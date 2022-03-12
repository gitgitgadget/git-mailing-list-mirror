Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB81BC433EF
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 00:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiCLAKE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 19:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiCLAKA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 19:10:00 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4A4226369
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 16:08:55 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 7-20020a05600c228700b00385fd860f49so6281614wmf.0
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 16:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+D8F6NuLashoR0A4E60KGw0SkrTIzukOlk7zDCUYXNc=;
        b=I24vuiQJNGXyMyIstkcuhJXZT6Bih+lJmqobcklSEldyw6GbXMeyyB+EZNMqfHxlLa
         5jzSh7Lz3cdGz8TI0B0gmqp3WXm3QCpD6nFbqs7u88pMDPWZ+K6miEnSAdBHKj36gv/v
         75Is1mh8WChPjFlMjeNpepr6d57IPpn86E6xvVk+ok0tTw1Ja1xIZtGLm3lCJGbuVsid
         dsCi4xenHnmVmdJBUUMHCrwMlQn8Gk/LuwR+kEtzlguzsjOVrM1EfpVLQFQRpIukkeKk
         SKt5/YBvQ/Xw3RWFEu48lEf+ZIg8Dj6xgffU0eBHuFi1DWFzs2Z8NE5TVlI5/WAqGQ1r
         6mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+D8F6NuLashoR0A4E60KGw0SkrTIzukOlk7zDCUYXNc=;
        b=IU4z6QbrH68Di9wTpQb2gDyBsGYvgq5ldkGy49D6HLStFsynhKQDTTDUmtT2+bl7S0
         te87VlOosYU31U1yvw+PfMV1ChcfSErybwoES79NsX4z619254NLT3Zezrl+KKZDCKSH
         Ujf4Q0WCf/hBRMqJazN4qStnda8dcHmahuZ7nBhtdG9DcGSCN1LgB+ZskaC4wbyFHXFj
         xVQtUlf7sZt4C9h8+81SQdaYXlaiR0nZGsJAFJ5MSg30192h4Hmwo3WycSAqZXyi4lWn
         iU8BZe87qNNI/Zs8wft/m5OE4M/j4+WxFIdRMjSsHIXX4UKdexYiQPR6566wVNhZhjS0
         kYfQ==
X-Gm-Message-State: AOAM5337sdlP9d//q6VCtLG0/HoZ9Q1K8rpvXFJxkkvku457HV2xKIWZ
        myOXE8fHm/RK4pYBOtYl26EkT4lXgLg=
X-Google-Smtp-Source: ABdhPJyDxNfs+tnZz7u4eGtCVQFrA5YtwMfMrt0ToQLpsiAzPwk9b0XiPsufmUpjfQkAdecix9kDQA==
X-Received: by 2002:a7b:c08b:0:b0:385:8748:5665 with SMTP id r11-20020a7bc08b000000b0038587485665mr8959217wmh.173.1647043733810;
        Fri, 11 Mar 2022 16:08:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i186-20020a1c3bc3000000b00382b25f6c9fsm8839759wma.42.2022.03.11.16.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 16:08:53 -0800 (PST)
Message-Id: <63c5ee36feb38ed192f4c60bb1c1c46a9a7a6b89.1647043729.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
References: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Mar 2022 00:08:47 +0000
Subject: [PATCH 3/5] reset: replace '--quiet' with '--no-refresh' in
 performance advice
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Replace references to '--quiet' with '--no-refresh' in the advice on how to
skip refreshing the index. When the advice was introduced, '--quiet' was the
only way to avoid the expensive 'refresh_index(...)' at the end of a mixed
reset. After introducing '--no-refresh', however, '--quiet' became only a
fallback option for determining refresh behavior, overridden by
'--[no-]refresh' or 'reset.refresh' if either is set. To ensure users are
advised to use the most reliable option for avoiding 'refresh_index(...)',
replace recommendation of '--quiet' with '--[no-]refresh'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/config/advice.txt | 8 ++++----
 advice.c                        | 2 +-
 advice.h                        | 2 +-
 builtin/reset.c                 | 8 ++++----
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index 971aad2f237..83c2a956611 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -67,10 +67,10 @@ advice.*::
 	commitBeforeMerge::
 		Advice shown when linkgit:git-merge[1] refuses to
 		merge to avoid overwriting local changes.
-	resetQuiet::
-		Advice to consider using the `--quiet` option to linkgit:git-reset[1]
-		when the command takes more than 2 seconds to refresh the index
-		after reset.
+	resetNoRefresh::
+		Advice to consider using the `--no-refresh` option to
+		linkgit:git-reset[1] when the command takes more than 2 seconds
+		to refresh the index after reset.
 	resolveConflict::
 		Advice shown by various commands when conflicts
 		prevent the operation from being performed.
diff --git a/advice.c b/advice.c
index 2e1fd483040..cb755c551a2 100644
--- a/advice.c
+++ b/advice.c
@@ -61,7 +61,7 @@ static struct {
 	[ADVICE_PUSH_NON_FF_MATCHING]			= { "pushNonFFMatching", 1 },
 	[ADVICE_PUSH_UNQUALIFIED_REF_NAME]		= { "pushUnqualifiedRefName", 1 },
 	[ADVICE_PUSH_UPDATE_REJECTED]			= { "pushUpdateRejected", 1 },
-	[ADVICE_RESET_QUIET_WARNING]			= { "resetQuiet", 1 },
+	[ADVICE_RESET_NO_REFRESH_WARNING]		= { "resetNoRefresh", 1 },
 	[ADVICE_RESOLVE_CONFLICT]			= { "resolveConflict", 1 },
 	[ADVICE_RM_HINTS]				= { "rmHints", 1 },
 	[ADVICE_SEQUENCER_IN_USE]			= { "sequencerInUse", 1 },
diff --git a/advice.h b/advice.h
index a3957123a16..f95af70ced4 100644
--- a/advice.h
+++ b/advice.h
@@ -36,7 +36,7 @@ struct string_list;
 	ADVICE_PUSH_UPDATE_REJECTED_ALIAS,
 	ADVICE_PUSH_UPDATE_REJECTED,
 	ADVICE_PUSH_REF_NEEDS_UPDATE,
-	ADVICE_RESET_QUIET_WARNING,
+	ADVICE_RESET_NO_REFRESH_WARNING,
 	ADVICE_RESOLVE_CONFLICT,
 	ADVICE_RM_HINTS,
 	ADVICE_SEQUENCER_IN_USE,
diff --git a/builtin/reset.c b/builtin/reset.c
index 7f667e13d71..feab85e03de 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -535,10 +535,10 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				refresh_index(&the_index, flags, NULL, NULL,
 					      _("Unstaged changes after reset:"));
 				t_delta_in_ms = (getnanotime() - t_begin) / 1000000;
-				if (advice_enabled(ADVICE_RESET_QUIET_WARNING) && t_delta_in_ms > REFRESH_INDEX_DELAY_WARNING_IN_MS) {
-					advise(_("It took %.2f seconds to refresh the index after reset.  You can\n"
-						"use '--quiet' to avoid this.  Set the config setting reset.quiet to true\n"
-						"to make this the default."), t_delta_in_ms / 1000.0);
+				if (advice_enabled(ADVICE_RESET_NO_REFRESH_WARNING) && t_delta_in_ms > REFRESH_INDEX_DELAY_WARNING_IN_MS) {
+					advise(_("It took %.2f seconds to refresh the index after reset.  You can use\n"
+						 "'--no-refresh' to avoid this.  Set the config setting reset.refresh to false\n"
+						 "to make this the default."), t_delta_in_ms / 1000.0);
 				}
 			}
 		} else {
-- 
gitgitgadget

