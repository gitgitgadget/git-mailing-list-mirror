From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 6/6] api-string-list.txt: initialize the string_list the easy way
Date: Wed, 12 Sep 2012 16:04:47 +0200
Message-ID: <1347458687-31092-7-git-send-email-mhagger@alum.mit.edu>
References: <1347458687-31092-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 16:05:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBnZc-0005AY-VX
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 16:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758921Ab2ILOFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 10:05:38 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:46843 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753169Ab2ILOF1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Sep 2012 10:05:27 -0400
X-AuditID: 12074413-b7f786d0000008bb-3f-505096a67333
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 0C.92.02235.6A690505; Wed, 12 Sep 2012 10:05:26 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8CE51QY021888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 12 Sep 2012 10:05:25 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1347458687-31092-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsUixO6iqLtsWkCAwdzpIhZdV7qZLBp6rzBb
	3F4xn9niR0sPswOLx9/3H5g8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujFMbj7EW
	/GGr6JizgLGB8RtrFyMnh4SAicTBE9+ZIGwxiQv31rN1MXJxCAlcZpRo+nuKEcI5wyTxfukl
	ZpAqNgFdiUU9zWAdIgJqEhPbDrGA2MwCKRIdz7sZQWxhgRCJay93gG1gEVCV+LfxAlgvr4CL
	xPT5k6A2K0r8+L4GLM4p4CqxZOYfNhBbCKhmbfNMpgmMvAsYGVYxyiXmlObq5iZm5hSnJusW
	Jyfm5aUW6Zrr5WaW6KWmlG5ihASQ8A7GXSflDjEKcDAq8fAyJPgHCLEmlhVX5h5ilORgUhLl
	/Tw5IECILyk/pTIjsTgjvqg0J7X4EKMEB7OSCO8GXaAcb0piZVVqUT5MSpqDRUmcV22Jup+Q
	QHpiSWp2ampBahFMVoaDQ0mC9+0UoEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4
	UGzEFwOjAyTFA7S3HKSdt7ggMRcoCtF6ilGXY/bNFfcZhVjy8vNSpcR5z0wCKhIAKcoozYNb
	AUsXrxjFgT4W5hWcClTFA0w1cJNeAS1hAloyYa0/yJKSRISUVANj24+GWZbNPzdU1bIlRBap
	yBwwc3Ux+Lh2690Uj+qve7eKTzz/6PxOLsm0OZd3njz/4C3fu4fTsutqTou37Di1/d39M35n
	wzhMBa9LuL1mWaCfZLN3htBnB9vfLLKR3/7LMgVaMiWzb+DZdpKf/+b17q+TvCwa 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205296>

In the demo code blurb, show how to initialize the string_list using
STRING_LIST_INIT_NODUP rather than memset().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-string-list.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index 32b35d9..155ac8c 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -44,10 +44,9 @@ member (you need this if you add things later) and you should set the
 Example:
 
 ----
-struct string_list list;
+struct string_list list = STRING_LIST_INIT_NODUP;
 int i;
 
-memset(&list, 0, sizeof(struct string_list));
 string_list_append(&list, "foo");
 string_list_append(&list, "bar");
 for (i = 0; i < list.nr; i++)
-- 
1.7.11.3
