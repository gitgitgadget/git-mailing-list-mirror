From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 06/13] delete_refs(): convert error message to lower case
Date: Mon,  8 Jun 2015 13:45:40 +0200
Message-ID: <49bd60449c003c8a7fd060095fe743bb9efaba99.1433763494.git.mhagger@alum.mit.edu>
References: <cover.1433763494.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 13:46:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1vVO-0005EK-Hl
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 13:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbbFHLqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 07:46:09 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:62189 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752319AbbFHLqE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 07:46:04 -0400
X-AuditID: 1207440f-f79236d000000c5e-02-55758078c99a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id E4.FD.03166.87085755; Mon,  8 Jun 2015 07:46:00 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t58Bjop3017042
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 07:45:59 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433763494.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsUixO6iqFvRUBpq8GiCuEXXlW4mi4beK8wW
	t1fMZ7b40dLDbLF5czuLA6vH3/cfmDwWbCr1eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M44s+8pU8IK14vnanAbGSyxdjJwcEgImEvNer2WDsMUkLtxbD2RzcQgJXGaUePezmxnC
	OcEk8fD6FrAONgFdiUU9zUwgtoiAmsTEtkMsIEXMAh2MEheWb2MHSQgLeEpsnT8bqJuDg0VA
	VWLtYz6QMK9AlMTpR82sENvkJM4f/8kMYnMKWEjc/X8B7AohAXOJj9vaGScw8i5gZFjFKJeY
	U5qrm5uYmVOcmqxbnJyYl5dapGuil5tZopeaUrqJERJQ/DsYu9bLHGIU4GBU4uE9sKgkVIg1
	say4MvcQoyQHk5Iob1dZaagQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEV4mC6Acb0piZVVqUT5M
	SpqDRUmcV32Jup+QQHpiSWp2ampBahFMVoaDQ0mC92MdUKNgUWp6akVaZk4JQpqJgxNkOJeU
	SHFqXkpqUWJpSUY8KDLii4GxAZLiAdr7DKSdt7ggMRcoCtF6ilGX486U/4uYhFjy8vNSpcR5
	H4MUCYAUZZTmwa2ApY9XjOJAHwvz6tYDVfEAUw/cpFdAS5iAlnz/WgyypCQRISXVwDiPvZ4p
	+296yUsmy6enA0Kl0qbWfJ6coP8s3j9S5MTk9BlP0nhO38q/Ov17ywdJftsHdtM+HnufdndC
	UW7bv9qbE76/F3679mnBpvAJltFJIT1fL3ZufR+97ujk/XGhB2Ja/laoKtd9uc/q 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271015>

This string is going to have to be re-internationalized anyway because
of the previous commit. So while we're at it, we might as well convert
it to lower case as per our usual practice.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 2a2a06d..a10aba8 100644
--- a/refs.c
+++ b/refs.c
@@ -2827,7 +2827,7 @@ int delete_refs(struct string_list *refnames)
 		const char *refname = refnames->items[i].string;
 
 		if (delete_ref(refname, NULL, 0))
-			result |= error(_("Could not remove reference %s"), refname);
+			result |= error(_("could not remove reference %s"), refname);
 	}
 
 	return result;
-- 
2.1.4
