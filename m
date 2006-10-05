From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] git.el: Fixed inverted "renamed from/to" message.
Date: Thu, 05 Oct 2006 11:29:57 +0200
Message-ID: <87odsr9kkq.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Oct 05 11:30:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVPYP-0005Ji-TL
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 11:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWJEJaE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 05:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWJEJaE
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 05:30:04 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:57567 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751572AbWJEJaA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Oct 2006 05:30:00 -0400
Received: from adsl-89-217-6-110.adslplus.ch ([89.217.6.110] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GVPYF-0007DQ-Jr
	for git@vger.kernel.org; Thu, 05 Oct 2006 04:30:00 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 8E9874F8E1; Thu,  5 Oct 2006 11:29:57 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28350>

The deleted file should be labeled "renamed to" and the added file
"renamed from", not the other way around (duh!)

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 68de9be..5354cd6 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -422,8 +422,8 @@ (defun git-rename-as-string (info)
         (propertize
          (concat "   ("
                  (if (eq state 'copy) "copied from "
-                   (if (eq (git-fileinfo->state info) 'added) "renamed to "
-                     "renamed from "))
+                   (if (eq (git-fileinfo->state info) 'added) "renamed from "
+                     "renamed to "))
                  (git-escape-file-name (git-fileinfo->orig-name info))
                  ")") 'face 'git-status-face)
       "")))
-- 
1.4.2.3.g1723

-- 
Alexandre Julliard
julliard@winehq.org
