Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B981C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 11:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0D0221775
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 11:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="oQ2bUhiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgI1LNO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 07:13:14 -0400
Received: from mout01.posteo.de ([185.67.36.65]:33724 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgI1LNO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 07:13:14 -0400
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Sep 2020 07:13:13 EDT
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id A2597160060
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 13:05:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1601291132; bh=7rZNTXPgwb0d7w4a1Ig5MBDAOwCv0H4C2uP8goszG4M=;
        h=From:To:Subject:Date:From;
        b=oQ2bUhiD7IexgHiURwd4CSFXdRLcr1ES1P5LNbwJeVMh/BgmKvUVMCcB1Y5bvOHP5
         yeSXAD+60YSq+MIFwUEJ9m5JvrSsv9YM4BvoUKYu1OiPJ5XEtIhZTFOmZP8guRaoLd
         7s2do508kxjhCbLUgMWrLxxh19PFmZm5itPUm+O7OcmxHBjpKJ/SULUEeRb76rjFBn
         r8rv+Ac6N592FYzHw/b8e3X/kVftDgGuO4mS9W6RBvAsAAT8IbPwWrbTOlvG8c06eS
         0hiltF4mgSCaKfr0lo51vhVd3mcgjyFXFJtNTIEC2w54EFlxyAOiQp3QpRZ21ewsx3
         cplPJr6rbzHvw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4C0KSD2Qy3z9rxc
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 13:05:32 +0200 (CEST)
From:   Robert Karszniewicz <avoidr@posteo.de>
To:     git@vger.kernel.org
Subject: [PATCH] git-completion.bash: stash-show: add --patch-with-stat
Date:   Mon, 28 Sep 2020 13:05:17 +0200
Message-Id: <20200928110517.24915-1-avoidr@posteo.de>
X-Mailer: git-send-email 2.28.0
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
index 8be4a0316e..d98c731667 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3016,7 +3016,10 @@ _git_stash ()
 		list,--*)
 			__gitcomp "--name-status --oneline --patch-with-stat"
 			;;
-		show,--*|branch,--*)
+		show,--*)
+			__gitcomp "--patch-with-stat"
+			;;
+		branch,--*)
 			;;
 		branch,*)
 			if [ $cword -eq 3 ]; then
-- 
2.28.0

