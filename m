Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C5DC433FE
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 16:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242912AbiCNQL7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 12:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242900AbiCNQLr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 12:11:47 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138833CFED
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 09:10:36 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id p9so24765493wra.12
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 09:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+D8F6NuLashoR0A4E60KGw0SkrTIzukOlk7zDCUYXNc=;
        b=L4M/GcjKded3TIupuazrZk2qZAFFqkAafZIjc7dR97OnWnfm0+oDhwQeJyr+Wlvua7
         6TalSoB0d4l71gwA4dn1DesI0nuzwY86oU/pz8PaDVnumeok8zv0aduTT0P2khngiD5G
         pRmruSmB8AzX+3b1kdJdgmM9ut1rw0YVbZYPvP/X6LBGZqhNRrzev78ags0ArEN+yjEM
         ZbS8PbkYsBDWPPul1xyS0VCPP9jFzOOX7lZ3d+sK/frh9KirNxs78cHKSr1lzs4zOkQi
         3AEYyflq6Um6F1HKpW5ntzX+hSqJGYMwxw3qd2x01fgcJH09g3lmRVMw12W6ncp25785
         sBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+D8F6NuLashoR0A4E60KGw0SkrTIzukOlk7zDCUYXNc=;
        b=ENUteIHd+OusTOdGoUzLl7qynhR/WmLNrm84ibBCI/z5WsOFrBr1Y7MV4XATgwNDke
         jQFPggTTiHe/drHXBaslJlJhpXUKY0eU+J/NWVmbIfR94mZnn0yvuV58LepC2ivwTIw6
         Z+y0pHg0GsGLoHSqeSXC9T0MexOI0871G4OQsXnmQTNE3X165vqxtBg6oY0pFdKdB+uS
         AkpskSPfWbfhpZmyID9GoQNd+RL5VzNJdb2Sn3iBuUSTAVk5MfI2BnDk9oE/EChG+VDU
         eKnrNiKgngwsg9LZCCMhRSxzqgcbiGCe8E2W/nQxOx/E6HHdzRjPAbPhXpP25tPm/MZN
         nntw==
X-Gm-Message-State: AOAM533zwl2Y62yg+vOKPXdznM9LiT+EpI3zclAwite0vj7XqVPfuv55
        bAjRmBkuaQ50IsXdgZfzua+VhEu7Sg0=
X-Google-Smtp-Source: ABdhPJxtN1K+pH+/B2bBPsEEk+YlqfrKuoyliR0WIP07lfVecyCG0Z3w1yBQx3iQgHvWeM7w+YyZBg==
X-Received: by 2002:a5d:4dc5:0:b0:1f0:73e4:2cd9 with SMTP id f5-20020a5d4dc5000000b001f073e42cd9mr17425742wru.212.1647274234437;
        Mon, 14 Mar 2022 09:10:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m185-20020a1c26c2000000b003899ed333ffsm17934764wmm.47.2022.03.14.09.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 09:10:33 -0700 (PDT)
Message-Id: <f869723d64f929736fc604830de1eeaf822a6f37.1647274230.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
References: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
        <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Mar 2022 16:10:28 +0000
Subject: [PATCH v2 3/5] reset: replace '--quiet' with '--no-refresh' in
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

