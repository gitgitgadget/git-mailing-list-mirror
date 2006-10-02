From: A Large Angry SCM <gitzilla@gmail.com>
Subject: [PATCH] Stop making git-merge-recur
Date: Sun, 01 Oct 2006 19:45:06 -0700
Message-ID: <45207D32.8040300@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 02 04:45:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUDo1-0001yM-Uo
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 04:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWJBCpT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 22:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWJBCpT
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 22:45:19 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:53271 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751287AbWJBCpR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Oct 2006 22:45:17 -0400
Received: by py-out-1112.google.com with SMTP id n25so2282210pyg
        for <git@vger.kernel.org>; Sun, 01 Oct 2006 19:45:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=HUSYmEqO+CWXUpLbyFSscU8gWjWlbAqS9IYGqYFBxWat58xP12G6kv41yJ6loo8MTQZB6m+KCZaQjm/XbKJwfY1ZXy2+FLZxaoWZBqIFWc6rekgBXZQppDe3ROX0hFPVXd29Iky+RtxCv8TGZ6Xla3iZW9tw82CPDosYs7zu2AU=
Received: by 10.65.212.3 with SMTP id o3mr320673qbq;
        Sun, 01 Oct 2006 19:45:16 -0700 (PDT)
Received: from ?10.0.0.6? ( [68.233.231.217])
        by mx.gmail.com with ESMTP id f15sm103851qba.2006.10.01.19.45.15;
        Sun, 01 Oct 2006 19:45:16 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28211>

Git-merge-recur is no longer installed and make clean no longer
removes it, so creating making it.


Signed-off-by: A Large Angry SCM <gitzilla@gmail.com>
---

 Makefile |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index dd33158..37bd59d 100644
--- a/Makefile
+++ b/Makefile
@@ -586,8 +586,7 @@ export prefix TAR INSTALL DESTDIR SHELL_
 
 ### Build rules
 
-all: $(ALL_PROGRAMS) $(BUILT_INS) git$X gitk gitweb/gitweb.cgi \
-	git-merge-recur$X
+all: $(ALL_PROGRAMS) $(BUILT_INS) git$X gitk gitweb/gitweb.cgi
 
 all: perl/Makefile
 	$(MAKE) -C perl
@@ -603,9 +602,6 @@ git$X: git.c common-cmds.h $(BUILTIN_OBJ
 
 help.o: common-cmds.h
 
-git-merge-recur$X: git-merge-recursive$X
-	rm -f $@ && ln git-merge-recursive$X $@
-
 $(BUILT_INS): git$X
 	rm -f $@ && ln git$X $@
 
@@ -918,7 +914,7 @@ check-docs::
 	do \
 		case "$$v" in \
 		git-merge-octopus | git-merge-ours | git-merge-recursive | \
-		git-merge-resolve | git-merge-stupid | git-merge-recur | \
+		git-merge-resolve | git-merge-stupid | \
 		git-merge-recursive-old | \
 		git-ssh-pull | git-ssh-push ) continue ;; \
 		esac ; \
