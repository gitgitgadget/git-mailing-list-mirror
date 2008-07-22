From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t3200,t7201: replace '!' with test_must_fail
Date: Tue, 22 Jul 2008 16:16:54 -0500
Message-ID: <hQLzs7uznR2DlUhN5OKjUZqeIVMnE5x0w2zVo6ve1hi_9wvQvkrJrQ@cipher.nrlssc.navy.mil>
References: <0GfECozN3g0ZvAESKMi76RyOVHEb2OhhwET9GWmEm7pbzYQJub50UlWpZtBa7MGn1UGb-7mzbzE@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 22 23:19:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLPGD-00084W-Ca
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 23:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756983AbYGVVR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 17:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756864AbYGVVR6
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 17:17:58 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:42873 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757396AbYGVVRz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 17:17:55 -0400
Received: by mail.nrlssc.navy.mil id m6MLGtcr020547; Tue, 22 Jul 2008 16:16:55 -0500
In-Reply-To: <0GfECozN3g0ZvAESKMi76RyOVHEb2OhhwET9GWmEm7pbzYQJub50UlWpZtBa7MGn1UGb-7mzbzE@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 22 Jul 2008 21:16:55.0240 (UTC) FILETIME=[448FDC80:01C8EC40]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89537>

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t3200-branch.sh |    2 +-
 t/t7201-co.sh     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 7c583c8..7a83fbf 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -200,7 +200,7 @@ test_expect_success \
 
 test_expect_success \
     'branch from non-branch HEAD w/--track causes failure' \
-    '!(git branch --track my10 HEAD^)'
+    'test_must_fail git branch --track my10 HEAD^'
 
 # Keep this test last, as it changes the current branch
 cat >expect <<EOF
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 3111baa..9ad5d63 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -335,6 +335,6 @@ test_expect_success \
     git checkout -b delete-me master &&
     rm .git/refs/heads/delete-me &&
     test refs/heads/delete-me = "$(git symbolic-ref HEAD)" &&
-    !(git checkout --track -b track)'
+    test_must_fail git checkout --track -b track'
 
 test_done
-- 
1.6.0.rc0.38.g8b8fb7
