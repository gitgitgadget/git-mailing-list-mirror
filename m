From: Xavier Maillard <zedek@gnu.org>
Subject: [PATCH] Automatically add GIT as a VC backend
Date: Fri, 02 Mar 2007 00:52:58 +0100
Message-ID: <28587.1172793178@localhost>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 00:55:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMv7o-0002Ny-5w
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 00:55:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161151AbXCAXzt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 18:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161261AbXCAXzt
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 18:55:49 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:55115 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161151AbXCAXzs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 18:55:48 -0500
Received: from localhost.localdomain (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 5BFEB71D3
	for <git@vger.kernel.org>; Fri,  2 Mar 2007 00:55:47 +0100 (CET)
Received: from localhost (IDENT:1001@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l21Nqwoi028588
	for <git@vger.kernel.org>; Fri, 2 Mar 2007 00:52:58 +0100
X-Mailer: MH-E 8.0.3; nmh 1.2; GNU Emacs 23.0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41152>

Hi,

A small patch with following changes:

Automatically add GIT as a VC backend

Remove byte-compiler warning with an eval of vc
---
 contrib/emacs/vc-git.el |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/contrib/emacs/vc-git.el b/contrib/emacs/vc-git.el
index e456ab9..a2d3932 100644
--- a/contrib/emacs/vc-git.el
+++ b/contrib/emacs/vc-git.el
@@ -22,18 +22,19 @@
 ;; This file contains a VC backend for the git version control
 ;; system.
 ;;
-;; To install: put this file on the load-path and add GIT to the list
-;; of supported backends in `vc-handled-backends'; the following line,
-;; placed in your ~/.emacs, will accomplish this:
-;;
-;;     (add-to-list 'vc-handled-backends 'GIT)
+;; To install: put this file on the load-path.
 ;;
 ;; TODO
 ;;  - changelog generation
 ;;  - working with revisions other than HEAD
 ;;
 
-(eval-when-compile (require 'cl))
+(eval-when-compile 
+  (require 'cl)
+  (require 'vc))
+
+;; Add it automatically
+(add-to-list 'vc-handled-backends 'GIT)
 
 (defvar git-commits-coding-system 'utf-8
   "Default coding system for git commits.")
-- 
Xavier
