From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] emacs mode: handle "stg status" output with #
Date: Sun, 13 Apr 2008 18:48:31 +0200
Message-ID: <20080413164818.8926.15902.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 13 18:49:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jl5OW-0001on-C1
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 18:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758611AbYDMQsi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Apr 2008 12:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758409AbYDMQsi
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 12:48:38 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2397 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758504AbYDMQsh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 12:48:37 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1Jl5NX-00008G-00; Sun, 13 Apr 2008 17:48:31 +0100
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79411>

Recently, "stg status" started separating patch names and descriptions
with # rather than |. This broke some parts of the emacs mode, such as
coloring and patch selection.

This patch makes the emacs mode accept either delimiter.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 contrib/stgit.el |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/contrib/stgit.el b/contrib/stgit.el
index ba6df6a..339ef13 100644
--- a/contrib/stgit.el
+++ b/contrib/stgit.el
@@ -107,7 +107,7 @@ Argument DIR is the repository path."
         (cond ((looking-at "Branch: \\(.*\\)")
                (put-text-property (match-beginning 1) (match-end 1)
                                   'face 'bold))
-              ((looking-at "\\([>+-]\\)\\( \\)\\([^ ]+\\) *| \\(.*\\)"=
)
+              ((looking-at "\\([>+-]\\)\\( \\)\\([^ ]+\\) *[|#] \\(.*\=
\)")
                (let ((state (match-string 1))
                      (patchsym (intern (match-string 3))))
                  (put-text-property
