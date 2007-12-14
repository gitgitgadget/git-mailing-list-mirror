From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 02/17] Emacs mode: Show keybindings when user presses
	"h" or "?"
Date: Fri, 14 Dec 2007 11:56:28 +0100
Message-ID: <20071214105548.18066.10999.stgit@krank>
References: <20071214105238.18066.23281.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 11:56:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J38Da-0000E6-BY
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 11:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761490AbXLNK4M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 05:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759340AbXLNK4M
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 05:56:12 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:51819 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758073AbXLNK4L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 05:56:11 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 9AF15200A217;
	Fri, 14 Dec 2007 11:56:10 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 30527-01-21; Fri, 14 Dec 2007 11:56:10 +0100 (CET)
Received: from krank (oden.vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 59B2A200A1E8;
	Fri, 14 Dec 2007 11:56:10 +0100 (CET)
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by krank (Postfix) with ESMTP id BCD8B7B406D;
	Fri, 14 Dec 2007 11:56:28 +0100 (CET)
In-Reply-To: <20071214105238.18066.23281.stgit@krank>
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68278>

=46rom: Karl Hasselstr=C3=B6m <kha@treskal.com>

These are the same keys the git emacs mode uses.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

 contrib/stgit.el |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)


diff --git a/contrib/stgit.el b/contrib/stgit.el
index 1bdc0a5..09dec8b 100644
--- a/contrib/stgit.el
+++ b/contrib/stgit.el
@@ -65,6 +65,8 @@ Argument DIR is the repository path."
 (unless stgit-mode-map
   (setq stgit-mode-map (make-keymap))
   (suppress-keymap stgit-mode-map)
+  (define-key stgit-mode-map "?"   'stgit-help)
+  (define-key stgit-mode-map "h"   'stgit-help)
   (define-key stgit-mode-map "g"   'stgit-refresh)
   (define-key stgit-mode-map "r"   'stgit-rename)
   (define-key stgit-mode-map ">"   'stgit-push-next)
@@ -139,3 +141,8 @@ Commands:
     (with-current-buffer standard-output
       (goto-char (point-min))
       (diff-mode))))
+
+(defun stgit-help ()
+  "Display help for the StGit mode."
+  (interactive)
+  (describe-function 'stgit-mode))
