From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2] Display help for Git mode after pressing `h' or `?' in *git-status*
Date: Thu, 13 Jul 2006 22:22:14 +0200
Message-ID: <11528221341063-git-send-email-jnareb@gmail.com>
References: <11528217463561-git-send-email-jnareb@gmail.com>
Reply-To: Jakub Narebski <jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 13 22:22:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G17hj-0003Ah-Io
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 22:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbWGMUWb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 16:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbWGMUWa
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 16:22:30 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:42666 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1030358AbWGMUWU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jul 2006 16:22:20 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k6DKLgjC022931
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Jul 2006 22:21:42 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k6DKMEZj022334;
	Thu, 13 Jul 2006 22:22:14 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k6DKME78022333;
	Thu, 13 Jul 2006 22:22:14 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <11528217463561-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23850>

Add bindings for "h" and "?" in git-status-mode to display help about the mode,
including keymap via (describe-function 'git-status-mode), like in PCL-CVS.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 contrib/emacs/git.el |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 83a845d..34c9950 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -943,6 +943,8 @@ (unless git-status-mode-map
   (let ((map (make-keymap))
         (diff-map (make-sparse-keymap)))
     (suppress-keymap map)
+    (define-key map "?"   'git-help)
+    (define-key map "h"   'git-help)
     (define-key map " "   'git-next-file)
     (define-key map "a"   'git-add-file)
     (define-key map "c"   'git-commit-file)
@@ -1012,5 +1014,10 @@ (defun git-status (dir)
         (goto-char (point-min)))
     (message "%s is not a git working tree." dir)))
 
+(defun git-help ()
+  "Display help for Git mode."
+  (interactive)
+  (describe-function 'git-status-mode))
+
 (provide 'git)
 ;;; git.el ends here
-- 
1.4.0
