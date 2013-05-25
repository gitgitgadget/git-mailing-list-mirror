From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 13/25] find_first_merges(): initialize merges variable using initializer
Date: Sat, 25 May 2013 11:08:12 +0200
Message-ID: <1369472904-12875-14-git-send-email-mhagger@alum.mit.edu>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johan Herland <johan@herland.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 25 11:10:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgAV6-00066M-B6
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 11:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205Ab3EYJJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 05:09:16 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:64453 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754094Ab3EYJJO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 05:09:14 -0400
X-AuditID: 1207440c-b7ff06d0000008f7-28-51a07fba5ab9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 68.4F.02295.ABF70A15; Sat, 25 May 2013 05:09:14 -0400 (EDT)
Received: from michael.fritz.box (p4FDD49F3.dip0.t-ipconnect.de [79.221.73.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4P98gun000489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 May 2013 05:09:13 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqLurfkGgwcf/0hZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLe5eXsXuwObx9/0HJo9LL7+zedx+PZ/Z41nvHkaPi5eUPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgztg6fTNjwUW2incT/jM1MO5g7WLk5JAQMJH4vK2XCcIWk7hwbz1b
	FyMXh5DAZUaJpdfus0M4F5gkth6ewwZSxSagK7GopxmsQ0TAUeLEg+usIEXMAr2MEg8ffQdL
	CAtES2xaeg7MZhFQlXj9/ic7iM0r4Cqx4tZFqNUKEpdnrWHuYuTg4ASKvz3BCRIWEnCReP7p
	HOsERt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3QN9XIzS/RSU0o3MUICjWcH47d1MocY
	BTgYlXh4BcvnBwqxJpYVV+YeYpTkYFIS5eWvXRAoxJeUn1KZkVicEV9UmpNafIhRgoNZSYSX
	IQUox5uSWFmVWpQPk5LmYFES51Vdou4nJJCeWJKanZpakFoEk5Xh4FCS4GUCRpSQYFFqempF
	WmZOCUKaiYMTRHCBbOAB2sAFUshbXJCYW5yZDlF0ilFRSpz3Zh1QQgAkkVGaBzcAlhJeMYoD
	/SPMexekigeYTuC6XwENZgIafDN3PsjgkkSElFQDY1mhv9p6/hXxCkm7JJmW7HjLPE103coG
	36DzYYEtL/Z7192vuuJ7dqfCg7Od71hWc3Vrvrgl+LvnvVXIE52MFO23N69UnH8t17ng9G/+
	C1uLVxRqOAT2Gnp4hOytNKj/NF0i7AijrIVDwKPts5acMc/NCv2R7m71e9esay++ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225512>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 submodule.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index e728025..b837c04 100644
--- a/submodule.c
+++ b/submodule.c
@@ -846,7 +846,7 @@ static int find_first_merges(struct object_array *result, const char *path,
 		struct commit *a, struct commit *b)
 {
 	int i, j;
-	struct object_array merges;
+	struct object_array merges = OBJECT_ARRAY_INIT;
 	struct commit *commit;
 	int contains_another;
 
@@ -856,7 +856,6 @@ static int find_first_merges(struct object_array *result, const char *path,
 	struct rev_info revs;
 	struct setup_revision_opt rev_opts;
 
-	memset(&merges, 0, sizeof(merges));
 	memset(result, 0, sizeof(struct object_array));
 	memset(&rev_opts, 0, sizeof(rev_opts));
 
-- 
1.8.2.3
