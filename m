From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] be more vim-ish, and also syntax hilight Signed-off-by lines.
Date: Tue, 17 Oct 2006 02:31:09 +0200
Message-ID: <11610450702261-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Oct 17 02:31:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZcrU-000331-O5
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 02:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422987AbWJQAbN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 20:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422974AbWJQAbN
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 20:31:13 -0400
Received: from pan.madism.org ([88.191.16.128]:6809 "EHLO hermes.madism.org")
	by vger.kernel.org with ESMTP id S1422987AbWJQAbN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 20:31:13 -0400
Received: from hermes.madism.org (localhost.localdomain [127.0.0.1])
	by hermes.madism.org (Postfix) with ESMTP id B2DC1B005C;
	Tue, 17 Oct 2006 02:31:08 +0200 (CEST)
Received: from hades.madism.org (olympe.madism.org [82.243.245.108])
	by hermes.madism.org (Postfix) with ESMTP id 3A3C4B005D;
	Tue, 17 Oct 2006 02:31:08 +0200 (CEST)
Received: by hades.madism.org (Postfix, from userid 1000)
	id 979A062128; Tue, 17 Oct 2006 02:31:10 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.2.3
X-AV-Checked: ClamAV (using ClamSMTP) at pan.madism.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29006>

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
