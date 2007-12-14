From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 07/17] Emacs mode: Bind "G" to "stg goto"
Date: Fri, 14 Dec 2007 11:57:44 +0100
Message-ID: <20071214105736.18066.55979.stgit@krank>
References: <20071214105238.18066.23281.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 11:59:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J38Fm-0001Hm-LK
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 11:58:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763133AbXLNK52 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 05:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763217AbXLNK52
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 05:57:28 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:51830 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763195AbXLNK51 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 05:57:27 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id F2D21200A217;
	Fri, 14 Dec 2007 11:57:25 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 27584-01-61; Fri, 14 Dec 2007 11:57:25 +0100 (CET)
Received: from krank (vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id AEDE8200A1E8;
	Fri, 14 Dec 2007 11:57:25 +0100 (CET)
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by krank (Postfix) with ESMTP id 255327B406D;
	Fri, 14 Dec 2007 11:57:44 +0100 (CET)
In-Reply-To: <20071214105238.18066.23281.stgit@krank>
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68283>

=46rom: Karl Hasselstr=C3=B6m <kha@treskal.com>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

 contrib/stgit.el |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)


diff --git a/contrib/stgit.el b/contrib/stgit.el
index d371e71..78e9520 100644
--- a/contrib/stgit.el
+++ b/contrib/stgit.el
@@ -83,6 +83,7 @@ Argument DIR is the repository path."
   (define-key stgit-mode-map ">"   'stgit-push-next)
   (define-key stgit-mode-map "<"   'stgit-pop-next)
   (define-key stgit-mode-map "P"   'stgit-push-or-pop)
+  (define-key stgit-mode-map "G"   'stgit-goto)
   (define-key stgit-mode-map "=3D"   'stgit-show))
=20
 (defun stgit-mode ()
@@ -154,6 +155,14 @@ Commands:
        (stgit-run (if applied "pop" "push") patch))
     (stgit-refresh)))
=20
+(defun stgit-goto ()
+  "Go to the patch on the current line"
+  (interactive)
+  (let ((patch (stgit-patch-at-point)))
+    (stgit-capture-output nil
+       (stgit-run "goto" patch))
+    (stgit-refresh)))
+
 (defun stgit-show ()
   "Show the patch on the current line"
   (interactive)
