From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] git.el: Run git-gc --auto after commits.
Date: Sun, 28 Oct 2007 11:07:14 +0100
Message-ID: <874pgbd031.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 11:07:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im53O-0005Hp-NM
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 11:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbXJ1KHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 06:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbXJ1KHY
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 06:07:24 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:52205 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbXJ1KHX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 06:07:23 -0400
Received: from adsl-62-167-50-148.adslplus.ch ([62.167.50.148] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1Im536-0005p2-Q2
	for git@vger.kernel.org; Sun, 28 Oct 2007 05:07:22 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 378B51E7146; Sun, 28 Oct 2007 11:07:14 +0100 (CET)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -2.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62548>

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index e5ee8ce..e147da0 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -796,6 +796,7 @@ Return the list of files that haven't been handled."
                             (with-current-buffer buffer (erase-buffer))
                             (dolist (info files) (git-set-fileinfo-state info 'uptodate))
                             (git-call-process-env nil nil "rerere")
+                            (git-call-process-env nil nil "gc" "--auto")
                             (git-refresh-files)
                             (git-refresh-ewoc-hf git-status)
                             (message "Committed %s." commit)
-- 
1.5.3.4.404.g5a866

-- 
Alexandre Julliard
julliard@winehq.org
