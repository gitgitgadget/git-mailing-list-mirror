Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C802C4363D
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 22:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B801B208C3
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 22:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="YGIuR/1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgJFWHB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 18:07:01 -0400
Received: from mout01.posteo.de ([185.67.36.65]:42441 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbgJFWHB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 18:07:01 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id EC13716005F
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 00:06:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1602022020; bh=Nv+Loi+P+VsnJl8raISMfWBdB4HY2n4tVLAYyUVec8A=;
        h=From:To:Subject:Date:From;
        b=YGIuR/1X49iE2i+cOK0yt5stS3e3JbeHHGVUrKeEIjohPHmJlkpa6PFcTC8c5ajss
         zb96SLzyTwMgOwNdiam0alojgXaM3NHbNaI10vgXk5K05PGBePNgmxOoVI2togfSkI
         vGcuX1Mek8bsFl5tk4j0L89/zWghzo6bOVvzt/SnlPn9cAK6UmMU2UCVQKIjo0ya9e
         ZcNxeU8S6bTWNJSlIvARkwAweFo1xFtyI5ZTe4FB5SrPZqv6Q0aLgESq7L0y3HEP7B
         eK1Scbsf+UaVNNoDBJcV1IYhYO7BgwaKCzP1MqDhwUkpiYrfbGxHShu/HRkTVk6wD3
         ZjFxH6IwVvmgQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4C5Wll42sHz6tm8
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 00:06:59 +0200 (CEST)
From:   Robert Karszniewicz <avoidr@posteo.de>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] git-completion.bash: stash-show: complete $__git_diff_common_options
Date:   Wed,  7 Oct 2020 00:06:37 +0200
Message-Id: <20201006220637.28139-2-avoidr@posteo.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201006220637.28139-1-avoidr@posteo.de>
References: <20201006220637.28139-1-avoidr@posteo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Robert Karszniewicz <avoidr@posteo.de>
---
 contrib/completion/git-completion.bash | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f363554996..83bc64607b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3020,7 +3020,10 @@ _git_stash ()
 		list,--*)
 			__gitcomp "--name-status --oneline --patch-with-stat"
 			;;
-		show,--*|branch,--*)
+		show,--*)
+			__gitcomp "$__git_diff_common_options"
+			;;
+		branch,--*)
 			;;
 		branch,*)
 			if [ $cword -eq 3 ]; then
-- 
2.28.0

