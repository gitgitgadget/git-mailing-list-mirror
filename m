Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E81C4363D
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 22:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A69D2208B6
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 22:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="GcKMmJtP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgJFWG4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 18:06:56 -0400
Received: from mout01.posteo.de ([185.67.36.65]:43588 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbgJFWG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 18:06:56 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 30BBB16005C
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 00:06:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1602022014; bh=0aXwF90O6LTDKd/nksGD6DluXj7JFY2UgyG9JpxlnBM=;
        h=From:To:Subject:Date:From;
        b=GcKMmJtPO0MRdP1H6BWY+fVv1JJwj2st9VhubH1HepE/PIt1ATaKIDT7gHSicIWEp
         /HRheRFODX1VAIyE4UTNWZlVmE5EnvP23Mh+vlgbD4SOlB0C66WjJ3eawQFMuR8XPU
         0sy567z2n04ZNEuKsjOtYHBhqe59KTGHfnPs2YHm28jUiGRARzVEyBORSj631YRgZY
         /nEG3/5/RzQZtbEzmPGnCaozI9pRasRwmeLh3NvzR5Gb7cOkexk+kPi5pxuD+YzR2a
         PVFE5UDA8LHxh58B2OlZC/S5uxa/WCesFxd9hCrJ6I+MHn1vSLNtbbaKjwXrF3sFG7
         MlyhYMn/lweBg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4C5Wld4jBbz6tm5
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 00:06:53 +0200 (CEST)
From:   Robert Karszniewicz <avoidr@posteo.de>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] git-completion.bash: __git_diff_common_options: add --[no-]patch
Date:   Wed,  7 Oct 2020 00:06:36 +0200
Message-Id: <20201006220637.28139-1-avoidr@posteo.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At the same time also deduplicate those options from command completions
which use $__git_diff_common_options.

Signed-off-by: Robert Karszniewicz <avoidr@posteo.de>
---
 contrib/completion/git-completion.bash | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0a96ad87e7..f363554996 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1688,6 +1688,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--submodule --submodule= --ignore-submodules
 			--indent-heuristic --no-indent-heuristic
 			--textconv --no-textconv
+			--patch --no-patch
 "
 
 _git_diff ()
@@ -2031,11 +2032,9 @@ _git_log ()
 			--no-walk --no-walk= --do-walk
 			--parents --children
 			--expand-tabs --expand-tabs= --no-expand-tabs
-			--patch
 			$merge
 			$__git_diff_common_options
 			--pickaxe-all --pickaxe-regex
-			--patch --no-patch
 			"
 		return
 		;;
@@ -2938,7 +2937,7 @@ _git_show ()
 		;;
 	--*)
 		__gitcomp "--pretty= --format= --abbrev-commit --no-abbrev-commit
-			--oneline --show-signature --patch
+			--oneline --show-signature
 			--expand-tabs --expand-tabs= --no-expand-tabs
 			$__git_diff_common_options
 			"
-- 
2.28.0

