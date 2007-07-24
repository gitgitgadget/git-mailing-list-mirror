From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] git.el: Pass an explicit argument to enable smerge-mode.
Date: Tue, 24 Jul 2007 12:02:28 +0200
Message-ID: <87wswqktl7.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 24 12:31:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDHfW-0005ly-5V
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 12:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758468AbXGXKa6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 06:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758363AbXGXKa6
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 06:30:58 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:42037 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756708AbXGXKa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 06:30:57 -0400
Received: from adsl-62-167-26-204.adslplus.ch ([62.167.26.204] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1IDHDr-0005Lb-D5
	for git@vger.kernel.org; Tue, 24 Jul 2007 05:02:31 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 054D51E7182; Tue, 24 Jul 2007 12:02:29 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53558>

Without argument the mode is toggled, which would do the wrong thing
if the file was already open.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 457f95f..d7f4316 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1038,7 +1038,7 @@ and returns the process output as a string."
   (let ((info (ewoc-data (ewoc-locate git-status))))
     (find-file (git-fileinfo->name info))
     (when (eq 'unmerged (git-fileinfo->state info))
-      (smerge-mode))))
+      (smerge-mode 1))))
 
 (defun git-find-file-other-window ()
   "Visit the current file in its own buffer in another window."
-- 
1.5.3.rc2.39.g82303f

-- 
Alexandre Julliard
julliard@winehq.org
