From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH] Add a RPMBUILD make variable
Date: Thu, 14 Jul 2005 19:20:25 -0600
Message-ID: <m13bqgyiee.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 15 03:21:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtEsm-0004QH-Tz
	for gcvg-git@gmane.org; Fri, 15 Jul 2005 03:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVGOBUn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 21:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbVGOBUn
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 21:20:43 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33981 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261737AbVGOBUl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 21:20:41 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6F1KPMO021908;
	Thu, 14 Jul 2005 19:20:25 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6F1KPXO021907;
	Thu, 14 Jul 2005 19:20:25 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This allows RPMBUILD to be overridden for people with
old versions of rpm or people who want to pass rpmbuild extra options.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

50c6a0b3b5d461b81bd5ceb0808206bfa20a8bfa
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -21,6 +21,7 @@ bin=$(prefix)/bin
 CC=gcc
 AR=ar
 INSTALL=install
+RPMBUILD=rpmbuild
 
 #
 # sparse is architecture-neutral, which means that we need to tell it
@@ -185,7 +186,7 @@ dist: git-core.spec git-tar-tree
 	gzip -9 $(GIT_TARNAME).tar
 
 rpm: dist
-	rpmbuild -ta git-core-$(GIT_VERSION).tar.gz
+	$(RPMBUILD) -ta git-core-$(GIT_VERSION).tar.gz
 
 test: all
 	$(MAKE) -C t/ all
