Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FBAC433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 22:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347804AbiEUWTn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 18:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347291AbiEUWT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 18:19:29 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24605001C
        for <git@vger.kernel.org>; Sat, 21 May 2022 15:19:11 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e28so15307994wra.10
        for <git@vger.kernel.org>; Sat, 21 May 2022 15:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TkggvBoOmDn/lOOqUQE8c0jXF+pwQTw3QpqZT9FSUok=;
        b=jSSrE2kOt9pRF5PdAeQ445lwc7hzIBx+O+Y8uPXwcfu+J/hKHV9o5WZ8ace6bE6LWQ
         AI08j03B4Hr6qqzdki94tfBCKgqgvAzzLpNy7ViAQos+XDKatzqdYNuWU5El96qHlF4E
         VAbpyHodbQIOHrcUa9shwPZ1U3N8V8lVSAYvcuBzS1jsRispLIHPDzlrNlEZVMIeNFgs
         boAhqlPQFJ/fg9TLTBdslV667lJt2BO0KObIlyI8OAUptOBJituAkKNLWF9HE8SlM0g6
         E45Ck4IQ3yDH0bQgj9Yak9wOCqrV9XgLdB3qxvRavFVmpijp9zrg787TFfhTJrTprsPU
         1a4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TkggvBoOmDn/lOOqUQE8c0jXF+pwQTw3QpqZT9FSUok=;
        b=pWmLQUHCgnvdpT06AEvoLiJU8Ht997PjPHg2DyaPOl0+qtpPrTIGfq7BxOeD529jwv
         6o7FFvUAVIwanCW8k0xBqy6n3xKy5RLfFTo8IVNn2+K26St39j+yxTlpBG1xvut2eU58
         oKh93C2D10irFmOT7oRBdWr8xdFrRfnQL9Pa/9Jq7InLOQCkghkzIfphigN9U/DEjPWI
         Qt0l8pMErCmXaLO6eLbLD+k3ywLR1XgOTedSfvKFLUEN5VUYGEzd79XjK4SuAei77XOl
         JGnfEOO/jsgKsH/0GaRrR2XJiYl19NDTYDKivZGGapxBaPNFndvZIZg5lVQ/R5OyF6FW
         icWw==
X-Gm-Message-State: AOAM533fJJBJSbPwx4KKYvE5rlJEfAUrZ+mo2vGjCkM/A6nhO14UA5ie
        1X0HFMnwjEq7zZRb+p0YXwaj9krS1ao=
X-Google-Smtp-Source: ABdhPJx0P5PU6XF1IP2uCq0ru1KdZUch3OZR1Aafr4quDgEpDKrZYn1U5+/A6XUvRM29gU8niicG6Q==
X-Received: by 2002:adf:f550:0:b0:20e:69df:5f05 with SMTP id j16-20020adff550000000b0020e69df5f05mr11735912wrp.194.1653171551134;
        Sat, 21 May 2022 15:19:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v10-20020adf8b4a000000b0020ce1c1cf31sm6368347wra.21.2022.05.21.15.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 15:19:10 -0700 (PDT)
Message-Id: <fe355a6f03b739013957b261751b8bc3950ab533.1653171536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
References: <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
        <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 22:18:56 +0000
Subject: [PATCH v3 12/12] ci: call `finalize_test_case_output` a little later
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
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
index 29640d107ca..9e410a5bb70 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -783,13 +783,13 @@ trap '{ code=$?; set +x; } 2>/dev/null; exit $code' INT TERM HUP
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
@@ -799,18 +799,19 @@ test_failure_ () {
 		say_color error "1..$test_count"
 		_error_exit
 	fi
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
@@ -1136,10 +1137,10 @@ test_skip () {
 
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
