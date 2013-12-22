From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/5] safe_create_leading_directories(): reduce scope of local variable
Date: Sun, 22 Dec 2013 08:14:08 +0100
Message-ID: <1387696451-32224-3-git-send-email-mhagger@alum.mit.edu>
References: <1387696451-32224-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 22 08:15:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VudFg-0006Rg-1v
	for gcvg-git-2@plane.gmane.org; Sun, 22 Dec 2013 08:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499Ab3LVHOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Dec 2013 02:14:40 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:64389 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752229Ab3LVHOj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Dec 2013 02:14:39 -0500
X-AuditID: 12074412-b7fc96d0000023d5-41-52b6915e8756
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id AB.60.09173.E5196B25; Sun, 22 Dec 2013 02:14:38 -0500 (EST)
Received: from michael.fritz.box (p57A25B75.dip0.t-ipconnect.de [87.162.91.117])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rBM7ERFM023935
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 22 Dec 2013 02:14:37 -0500
X-Mailer: git-send-email 1.8.5.1
In-Reply-To: <1387696451-32224-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqBs3cVuQwa3rJhZdV7qZLBp6rzBb
	3F4xn9mB2ePv+w9MHhcvKXt83iQXwBzFbZOUWFIWnJmep2+XwJ3x/8sK1oLZLBWLtpY0MK5k
	7mLk5JAQMJG48PEfE4QtJnHh3nq2LkYuDiGBy4wS1/ZtZYFwTjBJTD91EKyDTUBXYlFPM1iH
	iICaxMS2QywgNrOAg8Tmz42MILawQJjEtDnL2UFsFgFViRlbd4P18gq4SHz9ug1qs4LEvksn
	weZwCrhKTP2ykRXEFgKq2fHqEdMERt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3TN9HIz
	S/RSU0o3MUJCRWgH4/qTcocYBTgYlXh4M8S2BQmxJpYVV+YeYpTkYFIS5eWeABTiS8pPqcxI
	LM6ILyrNSS0+xCjBwawkwrvGFSjHm5JYWZValA+TkuZgURLn/blY3U9IID2xJDU7NbUgtQgm
	K8PBoSTB6w0yVLAoNT21Ii0zpwQhzcTBCSK4QDbwAG1IBSnkLS5IzC3OTIcoOsWoKCXOGwWS
	EABJZJTmwQ2ARfUrRnGgf4R5M0CqeIAJAa77FdBgJqDBxms3gQwuSURISTUwFj+Zus1E6NH+
	KTeUtny23HTwu/DdNm+hZZ57U5zvMqws/c/OM9X+XK1U71N9q/26uZKLu66/NqwK3RPzTvLm
	ucuf+WV+V/N0OebMLfq6IJ1z0UqWgwqPzidd162tX6Oa+eLpi023JU0m/4+xOqBaemytQ87e
	/W9X7na27//++U7RRFt2U/69H5RYijMSDbWYi4oTAcHWwQPFAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239635>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 sha1_file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index c9245a6..cc9957e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -108,9 +108,10 @@ int mkdir_in_gitdir(const char *path)
 int safe_create_leading_directories(char *path)
 {
 	char *pos = path + offset_1st_component(path);
-	struct stat st;
 
 	while (pos) {
+		struct stat st;
+
 		pos = strchr(pos, '/');
 		if (!pos)
 			break;
-- 
1.8.5.1
