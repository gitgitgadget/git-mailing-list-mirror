From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] be more vim-ish, and also syntax hilight Signed-off-by lines.
Date: Wed, 18 Oct 2006 02:39:35 +0200
Message-ID: <11611319762395-git-send-email-madcoder@debian.org>
References: <7vodsbmlkr.fsf@assigned-by-dhcp.cox.net> <1161131976193-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Oct 18 02:44:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZzTB-0008Bj-SR
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 02:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWJRAji (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 20:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWJRAji
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 20:39:38 -0400
Received: from pan.madism.org ([88.191.16.128]:41428 "EHLO hermes.madism.org")
	by vger.kernel.org with ESMTP id S1751183AbWJRAjh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 20:39:37 -0400
Received: from hermes.madism.org (localhost.localdomain [127.0.0.1])
	by hermes.madism.org (Postfix) with ESMTP id 0B0FCB005C;
	Wed, 18 Oct 2006 02:39:34 +0200 (CEST)
Received: from hades.madism.org (olympe.madism.org [82.243.245.108])
	by hermes.madism.org (Postfix) with ESMTP id D8035B005D;
	Wed, 18 Oct 2006 02:39:33 +0200 (CEST)
Received: by hades.madism.org (Postfix, from userid 1000)
	id 822D262112; Wed, 18 Oct 2006 02:39:36 +0200 (CEST)
To: Jeff King <peff@peff.net>
X-Mailer: git-send-email 1.4.2.3
In-Reply-To: <1161131976193-git-send-email-madcoder@debian.org>
X-AV-Checked: ClamAV (using ClamSMTP) at pan.madism.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29155>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 contrib/vim/syntax/gitcommit.vim |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/contrib/vim/syntax/gitcommit.vim b/contrib/vim/syntax/gitcommit.vim
index a9de09f..d0c6e5d 100644
--- a/contrib/vim/syntax/gitcommit.vim
+++ b/contrib/vim/syntax/gitcommit.vim
@@ -1,3 +1,14 @@
+" Vim syntax file
+" Language:	git commit message
+
+" Quit when a (custom) syntax file was already loaded
+if exists("b:current_syntax")
+  finish
+endif
+
+syn region gitSignedOff start=/^Signed-off-by:/ end=/$/ contains=gitAuthor,gitEmail
+syn region gitAuthor contained start=/\s/ end=/$/
+
 syn region gitLine start=/^#/ end=/$/
 syn region gitCommit start=/^# Updated but not checked in:$/ end=/^#$/ contains=gitHead,gitCommitFile
 syn region gitHead contained start=/^#   (.*)/ end=/^#$/
@@ -8,6 +19,9 @@ syn match gitCommitFile contained /^#\t.
 syn match gitChangedFile contained /^#\t.*/hs=s+2
 syn match gitUntrackedFile contained /^#\t.*/hs=s+2
 
+hi def link gitSignedOff Keyword
+hi def link gitAuthor Normal
+
 hi def link gitLine Comment
 hi def link gitCommit Comment
 hi def link gitChanged Comment
@@ -16,3 +30,7 @@ hi def link gitUntracked Comment
 hi def link gitCommitFile Type
 hi def link gitChangedFile Constant
 hi def link gitUntrackedFile Constant
+
+let b:current_syntax = "git"
+
+" vim: ts=8 sw=2
-- 
1.4.2.3
