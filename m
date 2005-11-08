From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Make the templates building a bit more silent
Date: Tue, 08 Nov 2005 10:49:31 +0100
Message-ID: <20051108094931.23012.6654.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 08 10:51:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZQ7Y-0007dL-JF
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 10:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbVKHJtf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 04:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbVKHJtf
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 04:49:35 -0500
Received: from w241.dkm.cz ([62.24.88.241]:54930 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965080AbVKHJte (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 04:49:34 -0500
Received: (qmail 23024 invoked from network); 8 Nov 2005 10:49:31 +0100
Received: from localhost (HELO machine.or.cz) (127.0.0.1)
  by localhost with SMTP; 8 Nov 2005 10:49:31 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11321>

The 'all' target in templates/Makefile contained 'find blt', which is
extremely annoying since it dumps all the files to stdout everytime,
cluttering the output and making the build of whole GIT a lot more noisy.
My guess is that it is some debugging leftover, actually.

This patch kills it.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 templates/Makefile |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/templates/Makefile b/templates/Makefile
index 07e928e..8f7f4fe 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -13,7 +13,6 @@ shq = $(subst ','\'',$(1))
 shellquote = '$(call shq,$(1))'
 
 all: boilerplates.made custom
-	find blt
 
 # Put templates that can be copied straight from the source
 # in a file direc--tory--file in the source.  They will be
