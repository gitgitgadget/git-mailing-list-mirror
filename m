From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] git.el: Don't use --info-only when resolving a file.
Date: Sat, 06 Jan 2007 11:20:57 +0100
Message-ID: <87y7ogwj5i.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jan 06 11:21:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H38fh-0002Tk-Sx
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 11:21:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbXAFKVD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 05:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbXAFKVC
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 05:21:02 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:46800 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbXAFKVA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 05:21:00 -0500
Received: from adsl-84-227-145-235.adslplus.ch ([84.227.145.235] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1H38fb-0006YJ-1W
	for git@vger.kernel.org; Sat, 06 Jan 2007 04:20:59 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 390084F693; Sat,  6 Jan 2007 11:20:57 +0100 (CET)
To: git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36084>

It doesn't make a difference for git.el, but it helps when interacting
with git-rebase and friends.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index b808234..98d3eae 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -802,7 +802,7 @@ and returns the process output as a string."
   (interactive)
   (let ((files (git-marked-files-state 'unmerged)))
     (when files
-      (apply #'git-run-command nil nil "update-index" "--info-only" "--" (git-get-filenames files))
+      (apply #'git-run-command nil nil "update-index" "--" (git-get-filenames files))
       (git-set-files-state files 'modified)
       (git-refresh-files))))
 
-- 
1.5.0.rc0.g5a8e

-- 
Alexandre Julliard
julliard@winehq.org
