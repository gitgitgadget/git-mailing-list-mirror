From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH] Use gzip -f when building the git-core tarball
Date: Thu, 14 Jul 2005 19:20:50 -0600
Message-ID: <m1y888x3t9.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 15 03:21:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtEtA-0004RT-Ei
	for gcvg-git@gmane.org; Fri, 15 Jul 2005 03:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVGOBVH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 21:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbVGOBVH
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 21:21:07 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35005 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261767AbVGOBVF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 21:21:05 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6F1KoD3021922;
	Thu, 14 Jul 2005 19:20:50 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6F1KoJN021921;
	Thu, 14 Jul 2005 19:20:50 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This allows rebuilding the tarball when it is already present
without having to answer annoying questions from gzip

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

d7c4e5ae707a6ad3028c48d800d568c554cc10af
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -183,7 +183,7 @@ dist: git-core.spec git-tar-tree
 	@cp git-core.spec $(GIT_TARNAME)
 	tar rf $(GIT_TARNAME).tar $(GIT_TARNAME)/git-core.spec
 	@rm -rf $(GIT_TARNAME)
-	gzip -9 $(GIT_TARNAME).tar
+	gzip -f -9 $(GIT_TARNAME).tar
 
 rpm: dist
 	$(RPMBUILD) -ta git-core-$(GIT_VERSION).tar.gz
