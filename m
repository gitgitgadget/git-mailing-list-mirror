From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH] t7011: Mark fixed test as such
Date: Sat, 28 Nov 2009 19:24:59 +0100
Message-ID: <0327ed3d7c4621f205d2d111254d716bd1b06c28.1259432535.git.git@drmicha.warpmail.net>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 28 19:25:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NERys-0000J4-LV
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 19:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbZK1SZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 13:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752415AbZK1SZB
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 13:25:01 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:43689 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752347AbZK1SZA (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Nov 2009 13:25:00 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 608EDC35A1;
	Sat, 28 Nov 2009 13:25:07 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sat, 28 Nov 2009 13:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=DFpv1a9ExFR/nqZfOYcwCVGLOzw=; b=uvqAcENMjzfYx10C/wYCgyFah9lxbJr7lNniLgXe+KNeDGdvj/qCB17dJ6ZhvzssCjU35IqVFuIsAi0fwMRBh+hka/kQj2KrWY5S/jULKB3Rp7xtZaRuFP0tKg1dMV9e7vnfQ8+4JTKuUQtpjAQIdAdwC8FF0hPrn4f5m2RGXK4=
X-Sasl-enc: W3XSsLtz0zfoPd5+v0v1Hl8tH6Ax488WJ+Sxbum4mM13 1259432706
Received: from localhost (p5DCC12B9.dip0.t-ipconnect.de [93.204.18.185])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A84CFC5A;
	Sat, 28 Nov 2009 13:25:06 -0500 (EST)
X-Mailer: git-send-email 1.6.6.rc0.274.g71380
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133964>

Test 16/17 had been fixed since its introduction in b4d1690 (Teach Git
to respect skip-worktree bit (reading part), 2009-08-20). So, mark it as
expect_success rather than expect_failure.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
I'm actually wondering about 17/17 as well.
If commit is called with a file name then shouldn't it simply commit the
current state of the file in the worktree, no matter what the index or
skip-worktree say? I therefore think 17/17 should be expect_success
and have no test_must_fail.

 t/t7011-skip-worktree-reading.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-reading.sh
index e996928..8960dd9 100755
--- a/t/t7011-skip-worktree-reading.sh
+++ b/t/t7011-skip-worktree-reading.sh
@@ -148,7 +148,7 @@ test_expect_success 'git-rm succeeds on skip-worktree absent entries' '
 	git rm 1
 '
 
-test_expect_failure 'commit on skip-worktree absent entries' '
+test_expect_success 'commit on skip-worktree absent entries' '
 	git reset &&
 	setup_absent &&
 	test_must_fail git commit -m null 1
-- 
1.6.6.rc0.274.g71380
