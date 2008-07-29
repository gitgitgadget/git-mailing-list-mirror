From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 4/4] Add a second testcase for handling invalid strategies in git-merge
Date: Wed, 30 Jul 2008 01:17:01 +0200
Message-ID: <f8e5afe347c194013ffd104b196a19a37d762f9b.1217372486.git.vmiklos@frugalware.org>
References: <cover.1217372486.git.vmiklos@frugalware.org>
 <a2d2bc675801bb03e3035ec0102eb27f08f27f1b.1217372486.git.vmiklos@frugalware.org>
 <18a8b4aaf4cc4bc720bd673166d4a7722ed79556.1217372486.git.vmiklos@frugalware.org>
 <ee13073cd83ff4a3cffb926b21cc54583e67f869.1217372486.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 01:17:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNyRq-0007ys-Kr
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 01:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890AbYG2XQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 19:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753218AbYG2XQi
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 19:16:38 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:55576 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446AbYG2XQf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 19:16:35 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id A030B1DDC5E;
	Wed, 30 Jul 2008 01:16:33 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 8DD141AB592; Wed, 30 Jul 2008 01:17:02 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <ee13073cd83ff4a3cffb926b21cc54583e67f869.1217372486.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1217372486.git.vmiklos@frugalware.org>
References: <cover.1217372486.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90704>

This one tests '-s index' which is interesting because git-merge-index
is an existing git command but it is not a valid strategy.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 t/t7600-merge.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 5eeb6c2..0329aee 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -230,6 +230,10 @@ test_expect_success 'test option parsing' '
 	test_must_fail git merge
 '
 
+test_expect_success 'reject non-strategy with a git-merge-foo name' '
+	test_must_fail git merge -s index c1
+'
+
 test_expect_success 'merge c0 with c1' '
 	git reset --hard c0 &&
 	git merge c1 &&
-- 
1.6.0.rc0.14.g95f8.dirty
