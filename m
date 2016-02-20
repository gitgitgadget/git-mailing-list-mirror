From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] tests: rename work-tree tests to *work-tree*
Date: Sat, 20 Feb 2016 17:18:41 +0100
Message-ID: <2e74b7a8e3dd27ccd225b5278500f8a3e029d245.1455985042.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 20 17:19:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXAFk-0006TA-GO
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 17:19:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758773AbcBTQSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2016 11:18:46 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36995 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750987AbcBTQSp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Feb 2016 11:18:45 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 9BF132030B
	for <git@vger.kernel.org>; Sat, 20 Feb 2016 11:18:43 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Sat, 20 Feb 2016 11:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:message-id:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp;
	 bh=4f4JALisKOGBAtWRqmRL6b4DEeg=; b=P6H+G5reZ/RsmR53eYssBHKYG+xv
	4lPIO2VQ204VI8ezpzmvxPLEOi1cwsMh6WsRh+oAGdlNCquaB3WX5TfHrxgROOur
	84TT7JqzOA89r3QSXGH8MTpOwV3jm6alrW18xyD3aX6by8CfOkDlb9pRt+4CEWnd
	yWA1o28wrS4nZMo=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=4f4JALisKOGBAtWRqmRL6b4DEe
	g=; b=daaGohnmFergl0sfNGtmRVqqDcSdtryMEeU5zIxT1otDLWNn/3ZP/u8Vnl
	kWfCZvOUyjt/QWeOnUGWinRpfe7YTpov/n90RQQ/Qg3/w70q5dnvu2S3ySf6mwa3
	Yfb+vRzP2zl6LmPU3URt29pV4HYOJdEZJGD5ogcKTRcW26naQ=
X-Sasl-enc: n9o+L+sA3nEY6Xq5e0/syA1kyfmHAh5kp8Jb30HODgFU 1455985122
Received: from localhost (dslb-092-076-191-118.092.076.pools.vodafone-ip.de [92.76.191.118])
	by mail.messagingengine.com (Postfix) with ESMTPA id EEAC8680133;
	Sat, 20 Feb 2016 11:18:42 -0500 (EST)
X-Mailer: git-send-email 2.7.1.428.g2de392b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286785>

"Work tree" or "working tree" is the name of a checked out tree,
"worktree" the name of the command which manages several working trees.
The naming of tests mixes these two, currently:

$ls t/*worktree*
t/t1501-worktree.sh
t/t1509-root-worktree.sh
t/t2025-worktree-add.sh
t/t2026-worktree-prune.sh
t/t2027-worktree-list.sh
t/t2104-update-index-skip-worktree.sh
t/t3320-notes-merge-worktrees.sh
t/t7011-skip-worktree-reading.sh
t/t7012-skip-worktree-writing.sh
t/t7409-submodule-detached-worktree.sh

$grep -l "git worktree" t/*.sh
t/t0002-gitfile.sh
t/t1400-update-ref.sh
t/t2025-worktree-add.sh
t/t2026-worktree-prune.sh
t/t2027-worktree-list.sh
t/t3320-notes-merge-worktrees.sh
t/t7410-submodule-checkout-to.sh

Rename t1501, t1509 and t7409 to make it clear on first glance that they
test work tree related behavior, rather than the worktree command.

t2104, t7011 and t7012 are about the "skip-worktree" flag so that their
name should remain unchanged.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Just some housekeeping. Not super necessary, but should make it easier to find
the right test to amend, for example.

 t/{t1501-worktree.sh => t1501-work-tree.sh}                               | 0
 t/{t1509-root-worktree.sh => t1509-root-work-tree.sh}                     | 0
 ...bmodule-detached-worktree.sh => t7409-submodule-detached-work-tree.sh} | 0
 3 files changed, 0 insertions(+), 0 deletions(-)
 rename t/{t1501-worktree.sh => t1501-work-tree.sh} (100%)
 rename t/{t1509-root-worktree.sh => t1509-root-work-tree.sh} (100%)
 rename t/{t7409-submodule-detached-worktree.sh => t7409-submodule-detached-work-tree.sh} (100%)

diff --git a/t/t1501-worktree.sh b/t/t1501-work-tree.sh
similarity index 100%
rename from t/t1501-worktree.sh
rename to t/t1501-work-tree.sh
diff --git a/t/t1509-root-worktree.sh b/t/t1509-root-work-tree.sh
similarity index 100%
rename from t/t1509-root-worktree.sh
rename to t/t1509-root-work-tree.sh
diff --git a/t/t7409-submodule-detached-worktree.sh b/t/t7409-submodule-detached-work-tree.sh
similarity index 100%
rename from t/t7409-submodule-detached-worktree.sh
rename to t/t7409-submodule-detached-work-tree.sh
-- 
2.7.1.428.g2de392b
