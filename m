From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 11/17] Emacs mode: add stgit-repair
Date: Fri, 14 Dec 2007 11:58:39 +0100
Message-ID: <20071214105833.18066.46153.stgit@krank>
References: <20071214105238.18066.23281.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 11:59:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J38Fq-0001Hm-3x
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 11:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764117AbXLNK6Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 05:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764061AbXLNK6X
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 05:58:23 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:51840 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763217AbXLNK6W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 05:58:22 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 67275200A217;
	Fri, 14 Dec 2007 11:58:21 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 28143-01-58; Fri, 14 Dec 2007 11:58:21 +0100 (CET)
Received: from krank (oden.vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 25200200A1E8;
	Fri, 14 Dec 2007 11:58:21 +0100 (CET)
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by krank (Postfix) with ESMTP id 8C8A67B406D;
	Fri, 14 Dec 2007 11:58:39 +0100 (CET)
In-Reply-To: <20071214105238.18066.23281.stgit@krank>
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68284>


Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

 contrib/stgit.el |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)


diff --git a/contrib/stgit.el b/contrib/stgit.el
index 2d18061..20cb08f 100644
--- a/contrib/stgit.el
+++ b/contrib/stgit.el
@@ -89,6 +89,7 @@ Argument DIR is the repository path."
   (define-key stgit-mode-map "n"   'next-line)
   (define-key stgit-mode-map "g"   'stgit-refresh)
   (define-key stgit-mode-map "r"   'stgit-rename)
+  (define-key stgit-mode-map "\C-r"   'stgit-repair)
   (define-key stgit-mode-map ">"   'stgit-push-next)
   (define-key stgit-mode-map "<"   'stgit-pop-next)
   (define-key stgit-mode-map "P"   'stgit-push-or-pop)
@@ -138,6 +139,13 @@ Commands:
     (stgit-refresh)
     (stgit-goto-patch name)))
=20
+(defun stgit-repair ()
+  "Run stg repair"
+  (interactive)
+  (stgit-capture-output nil
+   (stgit-run "repair"))
+  (stgit-refresh))
+
 (defun stgit-push-next ()
   "Push the first unapplied patch"
   (interactive)
