Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E05C4332F
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 16:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbiBVQbN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 11:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiBVQbG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 11:31:06 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBD9167F81
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:30:32 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d3so18777767wrf.1
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0/2yMfKj7qemE2ShouwPW7mCRvdo21HftDXt3BvzgL4=;
        b=LABoyHSeaFLVGv/f+vunpmc3lq+oFuBmmJABiqyqFDceuXLtHnxSIr12XW7Fsui8wI
         osogsVOr0wj94L1lOoVWQ/yplqjnk4lqsncS0JY2S2uywQQ9bcMmBdHEWnElFcn02kDL
         CvCWNQ5V+5TQS9eOHRpG/FRSFZGklKHN3/ZyDfHQLmtNRXvbvs33Qve0nV8GZBemCN38
         zQceawuqbw1wT5n7a3M9DVc3C4EAns37yKKyHi+zYEa6lmyvXXwjE/lfeFKpgcugs5iP
         t+twOcEeDB0WPIA9qFAuoArnzyUJ0KAz/+lxGjSiPq/5M1P+OsCwiWvtc9LQTIXA6hyJ
         oQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0/2yMfKj7qemE2ShouwPW7mCRvdo21HftDXt3BvzgL4=;
        b=sAKI0R9k9vKy3tScN/ouGjncVq8W1y3NCx/Y7TQ5zRJwknZXXt09gDi0hqiMMeKt0K
         Dukfz7Ro0MmuNszR9URE61e9Yc+aWug9bzgAzYB/14pLDyiNfvxVM7X5o1kj2YdDwhcH
         wOkGZyhd9Wg29UmDGU6o+bQ8xGTWQNZkDQEya9j6/6383drAb0MG8hZvUQ/amPyU4/xk
         2iO8TnY2o1HCsGry10Fo1UDHV70v1qM46pJQe4FG3L1BZ6K+VyhtfbKTPynxBq1t173/
         9w2gALMWeJB1myMvoW0uD1W4QH71iW6iBQL1euZUdoQlp3PnKXiZMPvRJzDxLbxcW+G/
         eeyw==
X-Gm-Message-State: AOAM531QjQyx9Md3TvaaSPcNqXe6v8Dhbj98Vtkyl3ynI4eg0C8P1HWh
        VlrjhCBXxYe5rmrxaxkEEQRsU6cjzEw=
X-Google-Smtp-Source: ABdhPJz28dv/azzlDpBQXyMACH4dDxsh7yomc74WhfNERG4JyKttIDNPWCumwF79zsGOBjHWTuvfIw==
X-Received: by 2002:adf:f284:0:b0:1e3:2576:245 with SMTP id k4-20020adff284000000b001e325760245mr20241420wro.529.1645547431355;
        Tue, 22 Feb 2022 08:30:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v2sm4418336wro.58.2022.02.22.08.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 08:30:30 -0800 (PST)
Message-Id: <d8b2767c148e59eafd57b355605b90dd3d4e311e.1645547423.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
        <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 16:30:17 +0000
Subject: [PATCH v2 08/14] bisect--helper: make `--bisect-state` optional
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In preparation for making `git bisect` a real built-in, let's prepare
the `bisect--helper` built-in to handle `git bisect--helper good` and
`git bisect--helper bad`, i.e. do not require the `--bisect-state`
option to be passed explicitly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 14 ++++++++------
 git-bisect.sh            |  2 +-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 31243a88a02..39b3cd606f2 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -26,8 +26,8 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
 					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
 	N_("git bisect--helper --bisect-next"),
-	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
-	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
+	N_("git bisect--helper [--bisect-state] (bad|new) [<rev>]"),
+	N_("git bisect--helper [--bisect-state] (good|old) [<rev>...]"),
 	N_("git bisect--helper --bisect-replay <filename>"),
 	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
 	N_("git bisect--helper --bisect-visualize"),
@@ -1210,10 +1210,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			     git_bisect_helper_usage,
 			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN);
 
-	if (!cmdmode)
-		usage_with_options(git_bisect_helper_usage, options);
-
-	switch (cmdmode) {
+	switch (cmdmode ? cmdmode : BISECT_STATE) {
 	case BISECT_START:
 		set_terms(&terms, "bad", "good");
 		res = bisect_start(&terms, argv, argc);
@@ -1221,6 +1218,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	case BISECT_STATE:
 		set_terms(&terms, "bad", "good");
 		get_terms(&terms);
+		if (!cmdmode &&
+		    (!argc || check_and_set_terms(&terms, argv[0]))) {
+			char *msg = xstrfmt(_("unknown command: '%s'"), argv[0]);
+			usage_msg_opt(msg, git_bisect_helper_usage, options);
+		}
 		res = bisect_state(&terms, argv, argc);
 		break;
 	case BISECT_TERMS:
diff --git a/git-bisect.sh b/git-bisect.sh
index 405cf76f2a3..fbf56649d7d 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -60,7 +60,7 @@ case "$#" in
 	start)
 		git bisect--helper --bisect-start "$@" ;;
 	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
-		git bisect--helper --bisect-state "$cmd" "$@" ;;
+		git bisect--helper "$cmd" "$@" ;;
 	skip)
 		git bisect--helper --bisect-skip "$@" || exit;;
 	next)
-- 
gitgitgadget

