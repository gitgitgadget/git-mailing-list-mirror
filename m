Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A50C433FE
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 01:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344302AbiCOBvE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 21:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344234AbiCOBu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 21:50:58 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1BE1EACF
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 18:49:47 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j26so26777218wrb.1
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 18:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+D8F6NuLashoR0A4E60KGw0SkrTIzukOlk7zDCUYXNc=;
        b=L2t/53oKck82URgsPzUSgGbUtqo3YOw+jv9vhxcNl/fA73aXf40/2wESSybxlYS9B4
         TLW4BF3yBq8tMnfK6IMN4CNS7k74DHHPsAmumYzsGOQ06lZ1SV1qm37H6WNZOqkVvufH
         JdqDBppeeB/f0pg+swiwXslmdY+86oEnB0tke+vVH7Yhs/TvaXaCL8xiviIQfXXb3ZPM
         S37UUaj+9z8ZozvVdD019YqC9WKKqNtDcEd86X+vPn/vH4P0FAuIChfLJ4SWCNWit6A3
         L4HIqPsySQihltsHgaFzNtccVF39o1gRFjeecP/ydMKRHLsDB16zcZkXeBhWVMCj0wRy
         9bTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+D8F6NuLashoR0A4E60KGw0SkrTIzukOlk7zDCUYXNc=;
        b=MaM1MVuYHm56fkLFVs47WMwhg3+WJtravEdR4ix7BH8cUoRybJrZhkECNryZW/CtM6
         zGzbA2MgX13tyAQ7ToDtzFhwhFHi8adia+iXYJd6WdltFXYd6UwAnaOT/uh+/s1FDL4N
         thJyUFbtWN76b5ezfKBy4mcQU3D4Iq6C4X8rI9tsYc0IYhjk96tyZh8w4f+Smfpuoe8F
         uIhDpaLpFzJ/DP7yGEg+4T4zSNdpFincCSep4TuFdaQtBMjdlVGfasBX8K432R+Xc0xf
         3OaQsECVFA9IFrQ6M6973THnEHwaFx9OHsV/Mjlu7JIaKo3aecEcCXUbvxpo1OM7lGP0
         +nZQ==
X-Gm-Message-State: AOAM532QQppCH6FgFtYV4NhQlcjLFKDZvPmIF7Viun5FJOfiXdwzAeT0
        tGs4tFkq4vR3fbg1hP+MFm/hqH4Yqdk=
X-Google-Smtp-Source: ABdhPJwMs61VvQehbWPFsh6EbIF2gMSsm6EA7QXnHhsm7nwgUgbr/Gxp8As9HAfE5gsCF8AAObOmRg==
X-Received: by 2002:a5d:6244:0:b0:1e7:686d:41e7 with SMTP id m4-20020a5d6244000000b001e7686d41e7mr18173595wrv.491.1647308985935;
        Mon, 14 Mar 2022 18:49:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i11-20020a05600c354b00b00389f440512esm899839wmq.32.2022.03.14.18.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 18:49:45 -0700 (PDT)
Message-Id: <eb5958194ee127db78e5028482c82dd8e5384f52.1647308982.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1170.v3.git.1647308982.gitgitgadget@gmail.com>
References: <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
        <pull.1170.v3.git.1647308982.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Mar 2022 01:49:40 +0000
Subject: [PATCH v3 3/5] reset: replace '--quiet' with '--no-refresh' in
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

