Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EFBC433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 10:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbiCAKZy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 05:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbiCAKZl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 05:25:41 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51D38EB77
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 02:24:58 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id i8so2622931wrr.8
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 02:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DXZZJDCDLve1Q2lw1hcqjmq9lJ9AxwHRnRwUJFeatvM=;
        b=BkrTuv6hGwwunkyDAYGhudDIlv1ez+YCDYigDX/XH6WNFhRwOGAf2DA6vnkzyey5Sz
         DJPxa0XPJdvhE3qAiLaickobjrYmclCf/vE0LOQDBA73zWKis3G2Hnyi5Crq+8fnYb2M
         cOjXgHHEO5oTzp5DFkrwnUIl8/ZAUl6o+Bwd51k3uVvAP7TgYsYVsFNPZnzFxMfuWx8E
         BGuITLyzQfPOq5DxWHE2EElidjWV8MIuViWfSqwG8E++0b9Nf2t8g2gaOU1vLpTI8t/T
         6rwc62T7/3+tNsSZKi2DY333iSVmb8h2ZlAQ8uK44RuudojiELi2eoYr1L2pjCJzo+IF
         h7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DXZZJDCDLve1Q2lw1hcqjmq9lJ9AxwHRnRwUJFeatvM=;
        b=ABX61Y+ttpe79y9sd6ladhJ8itewMVvtf+DsVKhTegH8/KUhLr/bg5Gpeumaw6pa3N
         BjdqSNwEPiCol4O9ob6a+VLMCWS24BgfvxzeQaUzI1LN4Wi9dk2D+oFcbFP4GR9eFlVO
         YNxzKybnC/BlUlyI0fjsqjZWwNtV5U5csZxoWEjq795HJNzzPz1LVHkyt4zBD0q6lXro
         Yrc0F4zj0QbiQl3ce/xeYlRR2/l0LaNK/IENX4fH6rs3Z0RtW5EvYTpMNqo4NCzUZigj
         cYHq9FnealjZXGNsQPBeKc8CmXo+3dKohy/epwA5nxydwlzktAXRHwzj2ViM3w9IPeqV
         Xydw==
X-Gm-Message-State: AOAM530vROD8MOLRYRWeWP/DQqXtWKYEzfQ+WfUDPZkEm5x5KwTvhClt
        T1AgKYn6zqLoWUGipsWeDl9sfAiI08Q=
X-Google-Smtp-Source: ABdhPJwac4AqZKaomh6TMb1g0heL6xCeXubK+mVTIgrncO7FHfvx4sGEJ+WaXLgGmtevrJn7nziiLw==
X-Received: by 2002:adf:d1e9:0:b0:1ea:7fc0:6625 with SMTP id g9-20020adfd1e9000000b001ea7fc06625mr18249637wrd.152.1646130297197;
        Tue, 01 Mar 2022 02:24:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z16-20020a7bc7d0000000b00381004c643asm1983794wmk.30.2022.03.01.02.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 02:24:56 -0800 (PST)
Message-Id: <be2a83f5da3cdd74ee8d5166dea8170344185600.1646130289.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
        <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 10:24:49 +0000
Subject: [PATCH v2 9/9] ci: call `finalize_test_case_output` a little later
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We used to call that function already before printing the final verdict.
However, now that we added grouping to the GitHub workflow output, we
will want to include even that part in the collapsible group for that
test case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 076bee58c19..1e683ad879b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -732,30 +732,31 @@ trap '{ code=$?; set +x; } 2>/dev/null; exit $code' INT TERM HUP
 # the test_expect_* functions instead.
 
 test_ok_ () {
-	finalize_test_case_output ok "$@"
 	test_success=$(($test_success + 1))
 	say_color "" "ok $test_count - $@"
+	finalize_test_case_output ok "$@"
 }
 
 test_failure_ () {
-	finalize_test_case_output failure "$@"
+	failure_label=$1
 	test_failure=$(($test_failure + 1))
 	say_color error "not ok $test_count - $1"
 	shift
 	printf '%s\n' "$*" | sed -e 's/^/#	/'
 	test "$immediate" = "" || _error_exit
+	finalize_test_case_output failure "$failure_label" "$@"
 }
 
 test_known_broken_ok_ () {
-	finalize_test_case_output fixed "$@"
 	test_fixed=$(($test_fixed+1))
 	say_color error "ok $test_count - $@ # TODO known breakage vanished"
+	finalize_test_case_output fixed "$@"
 }
 
 test_known_broken_failure_ () {
-	finalize_test_case_output broken "$@"
 	test_broken=$(($test_broken+1))
 	say_color warn "not ok $test_count - $@ # TODO known breakage"
+	finalize_test_case_output broken "$@"
 }
 
 test_debug () {
@@ -1081,10 +1082,10 @@ test_skip () {
 
 	case "$to_skip" in
 	t)
-		finalize_test_case_output skip "$@"
 
 		say_color skip "ok $test_count # skip $1 ($skipped_reason)"
 		: true
+		finalize_test_case_output skip "$@"
 		;;
 	*)
 		false
-- 
gitgitgadget
