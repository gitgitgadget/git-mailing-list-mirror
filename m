From: David Greaves <david@dgreaves.com>
Subject: [PATCH] cg-init should only process files
Date: Thu, 12 May 2005 17:03:15 +0100
Message-ID: <E1DWG9b-0001VV-V0@ash.dgreaves.com>
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 12 17:58:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWG35-0003S4-6d
	for gcvg-git@gmane.org; Thu, 12 May 2005 17:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbVELQDl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 12:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVELQDl
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 12:03:41 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:28903 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262065AbVELQDS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2005 12:03:18 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 8C837E6E07; Thu, 12 May 2005 17:01:56 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 28174-02; Thu, 12 May 2005 17:01:56 +0100 (BST)
Received: from oak.dgreaves.com (modem-485.leopard.dialup.pol.co.uk [217.135.145.229])
	by mail.ukfsn.org (Postfix) with ESMTP
	id F1D97E6E04; Thu, 12 May 2005 17:01:55 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DWG9c-0004Y6-20; Thu, 12 May 2005 17:03:16 +0100
Received: from david by ash.dgreaves.com with local (Exim 4.50)
	id 1DWG9b-0001VV-V0; Thu, 12 May 2005 17:03:15 +0100
To: Petr Baudis <pasky@ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

cg-init tries to add directories

Signed-off-by: David Greaves <david@dgreaves.com>

---
commit c6ecba40932efa0b28cd15d00fdab3b2607ec069
tree 39f7bebbadf6ebae67367b629d8cec298f7dcc90
parent f7d4b2adfc6a29036e2a8abe5b742e57b64e50d7
author David Greaves <david@dgreaves.com> Thu, 12 May 2005 13:05:03 +0100
committer David Greaves <david@ash.(none)> Thu, 12 May 2005 13:05:03 +0100

 cg-init |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: cg-init
===================================================================
--- 85d8d081e2012da8dd1af35b62ae82f79f89ebd0/cg-init  (mode:100755)
+++ 39f7bebbadf6ebae67367b629d8cec298f7dcc90/cg-init  (mode:100755)
@@ -31,7 +31,7 @@
 	echo "Cloned (origin $uri available as branch \"origin\")"
 else
 	git-read-tree # Seed the dircache
-	find * | xargs cg-add
+	find * -type f | xargs cg-add
 	cg-commit -C -m"Initial commit" -e
 fi
 exit 0
