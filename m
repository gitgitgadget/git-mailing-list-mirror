From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] git.el: Fix typo in git-update-saved-file error handling.
Date: Sun, 28 Oct 2007 11:05:45 +0100
Message-ID: <87d4uzd05i.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 11:06:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im520-0004yU-47
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 11:06:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbXJ1KFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 06:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbXJ1KFz
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 06:05:55 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:52178 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbXJ1KFy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 06:05:54 -0400
Received: from adsl-62-167-50-148.adslplus.ch ([62.167.50.148] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1Im51f-0005jx-Tj
	for git@vger.kernel.org; Sun, 28 Oct 2007 05:05:53 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id A24251E7146; Sun, 28 Oct 2007 11:05:45 +0100 (CET)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -2.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62545>

Spotted by Matthieu Lemerre.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 8cfbdd7..0e5091c 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1353,7 +1353,7 @@ Commands:
   "Update the corresponding git-status buffer when a file is saved.
 Meant to be used in `after-save-hook'."
   (let* ((file (expand-file-name buffer-file-name))
-         (dir (condition-case nil (git-get-top-dir (file-name-directory file))))
+         (dir (condition-case nil (git-get-top-dir (file-name-directory file)) (error nil)))
          (buffer (and dir (git-find-status-buffer dir))))
     (when buffer
       (with-current-buffer buffer
-- 
1.5.3.4.404.g5a866

-- 
Alexandre Julliard
julliard@winehq.org
