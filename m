From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] cache_tree_find(): remove redundant check in while condition
Date: Mon,  3 Mar 2014 17:08:05 +0100
Message-ID: <1393862885-23271-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 17:08:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKVQ2-0006KS-RZ
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 17:08:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158AbaCCQIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 11:08:38 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:62806 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753980AbaCCQIh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2014 11:08:37 -0500
X-AuditID: 1207440d-f79d86d0000043db-f9-5314a9047a55
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id D8.C7.17371.409A4135; Mon,  3 Mar 2014 11:08:36 -0500 (EST)
Received: from michael.fritz.box (p57A2466F.dip0.t-ipconnect.de [87.162.70.111])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s23G88wB019126
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 3 Mar 2014 11:08:35 -0500
X-Mailer: git-send-email 1.9.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsUixO6iqMuyUiTY4NF3ZYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M44fugvU8EdloqFF0+yNjBe
	Z+5i5OSQEDCR+H10CxOELSZx4d56NhBbSOAyo0TPfPMuRi4g+ziTRM+1E4wgCTYBXYlFPc1g
	DSICahIT2w6xgNjMAg4Smz83gtUIC/hKrFj8C8xmEVCVOPr1JtgyXgEXidNP/rNCLJOTmPJ7
	AfsERu4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3SN9HIzS/RSU0o3MUJ8z7uD8f86mUOM
	AhyMSjy8M6aJBAuxJpYVV+YeYpTkYFIS5f24HCjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhDei
	BijHm5JYWZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLgrVwB1ChYlJqeWpGW
	mVOCkGbi4AQZziUlUpyal5JalFhakhEPCvT4YmCog6R4gPa2grTzFhck5gJFIVpPMSpKifNu
	ADlWACSRUZoHNxYW0a8YxYG+FOadBtLOA0wGcN2vgAYzAQ028wMbXJKIkJJqYGSIDTOb9olX
	br9k8/E6dv+pm1K89rQK/0hOveoSO7GscdUHjh19z+T/8lx6ISy/MbjunlDE8Zl7rjzru2J7
	7oC4T7/xhQXPMv5mszxWLA3l8ZwhUr9afGtAyPO1UldXd+6QL3Hb+/k8Jz+H2Squ3xON5Tf7
	/yqddd2To3O37bx/y1RWrXoqeE2JpTgj0VCLuag4EQAGwKsqwwIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243232>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
A trivial little cleanup.

 cache-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index 0bbec43..7f63c23 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -565,7 +565,7 @@ static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *pat
 			return NULL;
 		it = sub->cache_tree;
 		if (slash)
-			while (*slash && *slash == '/')
+			while (*slash == '/')
 				slash++;
 		if (!slash || !*slash)
 			return it; /* prefix ended with slashes */
-- 
1.9.0
