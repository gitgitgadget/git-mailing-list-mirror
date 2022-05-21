Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B38FC433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 14:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355325AbiEUOth (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 10:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244384AbiEUOtV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 10:49:21 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9357B6CA89
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:19 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id i20-20020a05600c355400b0039456976dcaso5668507wmq.1
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=txCyLIG842kVG4Wt19E7V9JZ6FcDgBZI2iSPks97yjU=;
        b=VxTYPHD2eh8ioLN3YHkh8ugRP1c5KlSKY5JqauZZglYEVtg8iPJnmOzoGjHusg9Du7
         hUX8UR5ZaGVtW0QHfNV/ltDBCO/TsSH65jEavY7ataqInYWxLdFCowJ6arIo9puEB0XZ
         zW5XWKgnwCkWoMPiqpbPps9ba2bJqzsmDpN7EDuy3LF+jFG0xTw/CN1nkoGec1MgTKz8
         layHbjINHmBpFZiN2j5NpuLfRQJvcAqn63zWHIvaEm/pHO2Fh6IGMW0bBXYFYjdh6ELR
         Sck4kKFElYcDSHHWZyQNHMRbrFfYIX6d+kImkF824miJAdbbtarX49423MrdCptvkOSL
         JN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=txCyLIG842kVG4Wt19E7V9JZ6FcDgBZI2iSPks97yjU=;
        b=qxe6YnSeF6zgmnCx5JQX2FMdP/4boqOe/EIobAfgwbavgywYG7o3pUBQpqyyJQqRqq
         TsTBlVNsAboCHmB1mstwK/uVxpGNg/IND9PjWqRAHqsmEcZhWm0rsDFo4kayJc35LtmF
         jOweTmDiUHJcQhT9Hf+bEwFTlIawGZdXhg2KhkvhwNd9nov2I7qicHA+QeM1+YwyimWc
         swip2am4tbRd7pdxysIsFKxMNbSib9kALqR/iEjFCdXi46UvsOx8cuZO6qm7WwaVYeCz
         d5WXq3dlcFpmseOoMoXTc/YOMpHyFrAtrdCKDoxvO25mmzo1VG57txuMF5o8SHWzKLud
         bFbg==
X-Gm-Message-State: AOAM5318ZlChiv0FFNsnNGF15NVD9yjeMihpdW31RFkXq7PKaqRVCWnM
        /49UlwymQ4FtD4sgRkAjNEKGcpcgtKI=
X-Google-Smtp-Source: ABdhPJz19V2DSOca6pyuAoueQSXvkRGQhZAscSuh43+/TneLMc0h7o/fv5otg6pKJ15AFGyUa2ly0w==
X-Received: by 2002:a05:600c:89a:b0:397:3e2c:f416 with SMTP id l26-20020a05600c089a00b003973e2cf416mr4486234wmp.160.1653144557792;
        Sat, 21 May 2022 07:49:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q14-20020adfab0e000000b0020d0c9c95d3sm5306825wrc.77.2022.05.21.07.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 07:49:17 -0700 (PDT)
Message-Id: <b7bc53b9cb6f0785341562d6e1a1190fc66dc5d3.1653144546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
References: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
        <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 14:48:59 +0000
Subject: [PATCH v3 08/15] bisect--helper: make `--bisect-state` optional
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
index 37a16c6ac1a..94293318619 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -26,8 +26,8 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
 					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
 	"git bisect--helper --bisect-next",
-	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
-	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
+	N_("git bisect--helper [--bisect-state] (bad|new) [<rev>]"),
+	N_("git bisect--helper [--bisect-state] (good|old) [<rev>...]"),
 	N_("git bisect--helper --bisect-replay <filename>"),
 	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
 	"git bisect--helper --bisect-visualize",
@@ -1318,10 +1318,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
@@ -1329,6 +1326,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

