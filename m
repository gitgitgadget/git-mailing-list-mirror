From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] grep: fix error message mention --exclude
Date: Sat, 15 Oct 2011 20:36:22 +0200
Message-ID: <2533ba3dbe08fc0d76c9cbc9c76bff1c4ff80d4c.1318703760.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 15 20:36:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RF961-0001hF-P5
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 20:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754306Ab1JOSga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 14:36:30 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46453 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754282Ab1JOSg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2011 14:36:29 -0400
Received: by bkbzt19 with SMTP id zt19so1519717bkb.19
        for <git@vger.kernel.org>; Sat, 15 Oct 2011 11:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=mGQ9/cyJpZ0xZPntkk2+U129Ds+SJmUmXeO2jt80cec=;
        b=YOfwT4xoM53tUMFgAhRWUMMFMUs0j7/G1pAiHsuLfcc4Jc2WwfawMRMPg5QXZgViP+
         NpC8/u49CpiEmxJkDyltMFjHiuuoDH0R+9L+UED13yGHgZeHrMWZR/YF1ITPBBk04rsA
         7+RFGBo/LC6RX55mSqGMidHDQU9fHr0XNfy3g=
Received: by 10.204.130.155 with SMTP id t27mr9810354bks.49.1318703786358;
        Sat, 15 Oct 2011 11:36:26 -0700 (PDT)
Received: from localhost (p5B2ACC3F.dip.t-dialin.net. [91.42.204.63])
        by mx.google.com with ESMTPS id z9sm11993428bkn.7.2011.10.15.11.36.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 15 Oct 2011 11:36:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.789.gb4599
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183671>

Missing rename from --exclude to --standard-exclude.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 builtin/grep.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 024b878..7d0779f 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1064,7 +1064,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			die(_("--no-index or --untracked cannot be used with revs."));
 		hit = grep_directory(&opt, &pathspec, use_exclude);
 	} else if (0 <= opt_exclude) {
-		die(_("--exclude or --no-exclude cannot be used for tracked contents."));
+		die(_("--[no-]exclude-standard cannot be used for tracked contents."));
 	} else if (!list.nr) {
 		if (!cached)
 			setup_work_tree();
-- 
1.7.6.789.gb4599
