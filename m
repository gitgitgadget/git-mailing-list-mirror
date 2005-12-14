From: Amos Waterland <apw@us.ibm.com>
Subject: [PATCH] Do not ignore errors during make check
Date: Wed, 14 Dec 2005 16:09:32 -0500
Message-ID: <20051214210932.GA2642@kvasir.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 22:13:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emdsd-0004ms-3H
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 22:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbVLNVJk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 16:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbVLNVJk
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 16:09:40 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:5807 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932231AbVLNVJj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2005 16:09:39 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id jBEL9ZUB030169
	for <git@vger.kernel.org>; Wed, 14 Dec 2005 16:09:35 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jBEL9YMh119376
	for <git@vger.kernel.org>; Wed, 14 Dec 2005 16:09:34 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id jBEL9YFp018440
	for <git@vger.kernel.org>; Wed, 14 Dec 2005 16:09:34 -0500
Received: from kvasir.watson.ibm.com (kvasir.watson.ibm.com [9.2.218.19])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id jBEL9YO1018416;
	Wed, 14 Dec 2005 16:09:34 -0500
Received: from apw by kvasir.watson.ibm.com with local (Exim 4.52)
	id 1EmdsS-0000ii-V2; Wed, 14 Dec 2005 16:09:32 -0500
To: junkio@cox.net
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13641>

Do not let errors pass by unnoticed when running `make check'.

Signed-off-by: Amos Waterland <apw@us.ibm.com>

---

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

20898ba8a3c6f78bb136626fddc34221df427116
diff --git a/Makefile b/Makefile
index 01b6643..3f62bcb 100644
--- a/Makefile
+++ b/Makefile
@@ -449,7 +449,7 @@ test-delta$X: test-delta.c diff-delta.o 
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $^
 
 check:
-	for i in *.c; do sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i; done
+	for i in *.c; do sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i || break; done
 
 
 
-- 
0.99.9.GIT
