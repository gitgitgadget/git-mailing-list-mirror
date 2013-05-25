From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 21/25] string_list_add_one_ref(): rename first parameter to "refname"
Date: Sat, 25 May 2013 11:08:20 +0200
Message-ID: <1369472904-12875-22-git-send-email-mhagger@alum.mit.edu>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johan Herland <johan@herland.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 25 11:10:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgAUw-0005zn-Hm
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 11:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755213Ab3EYJKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 05:10:40 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:52896 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752512Ab3EYJJ2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 05:09:28 -0400
X-AuditID: 1207440d-b7fd06d000000905-b5-51a07fc86f55
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id E1.22.02309.8CF70A15; Sat, 25 May 2013 05:09:28 -0400 (EDT)
Received: from michael.fritz.box (p4FDD49F3.dip0.t-ipconnect.de [79.221.73.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4P98guv000489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 May 2013 05:09:26 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqHuifkGgwa+tIhZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLe5eXsXuwObx9/0HJo9LL7+zedx+PZ/Z41nvHkaPi5eUPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgzni8spm14A9rxafJGQ2Mr1i6GDk5JARMJDYvXQBli0lcuLeerYuR
	i0NI4DKjxPtlL6GcC0wSVw+eYQepYhPQlVjU08wEYosIOEqceHCdFaSIWaCXUeLho+9gCWGB
	CIlrt5eDNbAIqEr8PfOQGcTmFXCVWLngAtQ6BYnLs9YAxTk4OIHib09wgoSFBFwknn86xzqB
	kXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0jvdzMEr3UlNJNjJAw493B+H+dzCFGAQ5G
	JR7eHSXzA4VYE8uKK3MPMUpyMCmJ8vLXLggU4kvKT6nMSCzOiC8qzUktPsQowcGsJMLLkAKU
	401JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8HrUATUKFqWmp1akZeaU
	IKSZODhBBBfIBh6gDYEghbzFBYm5xZnpEEWnGBWlxHkngiQEQBIZpXlwA2AJ4RWjONA/wrwp
	IFU8wGQC1/0KaDAT0OCbufNBBpckIqSkGhgN3vlOkAwO3RT1nKPFJWuSWM6kFNXuedNj1kst
	ml97bbnBT9O/v5rPnlSI41vOWfip9Hh5+53VVv4f72QbWW5qO7J4SdpMLkV25cfeJyq/TF6R
	zHBvy+OZkQvvpy602rvxAuuSqcWSL85dYbGQOF8wRerBfbv4jNULBKSOxWhbdN6Z 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225510>

This is the usual convention.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 notes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/notes.c b/notes.c
index f63fd57..fa7cdf7 100644
--- a/notes.c
+++ b/notes.c
@@ -918,12 +918,12 @@ out:
 	return ret;
 }
 
-static int string_list_add_one_ref(const char *path, const unsigned char *sha1,
+static int string_list_add_one_ref(const char *refname, const unsigned char *sha1,
 				   int flag, void *cb)
 {
 	struct string_list *refs = cb;
-	if (!unsorted_string_list_has_string(refs, path))
-		string_list_append(refs, path);
+	if (!unsorted_string_list_has_string(refs, refname))
+		string_list_append(refs, refname);
 	return 0;
 }
 
-- 
1.8.2.3
