Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEE5C433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240287AbiF0ShC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239253AbiF0Sg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:36:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F8A18B19
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:31 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o16-20020a05600c379000b003a02eaea815so5268784wmr.0
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=D2Vna/oS9akoKBeXrPS7KPJyOGAnVW9RU62lI+f6aWU=;
        b=dp8UQApIEv8OKTu21EvZZE9Rm4AuPombwfj6HYBx/Sn5Y7JzB67oPrzhrjt3TSkOd2
         20CKf4iYxulRB2+e2LnlBQ+sHXQfYmscUMKArq70GipWtLz63sh/HvwkdKtNiMPqTdYg
         GpxTolCi0uFDbhnu1v0SxSOoQhoTh+8RIHqW5iuuOzJjHT0nOpJ9ebt6K4VroFDNXYTg
         iLW/VwZQ3A3NDTGztfFVL2Zxb7VEUJHZn/ZkDrK0czj3zKBtgiMHHm2EqlqJedepewzL
         0+8+FqBoGM61PHUFDxfz7YW2ju368eEHifG1VQMRIRfwaRT0bIqrA/t/MgfHR6+Ba+Gh
         IB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=D2Vna/oS9akoKBeXrPS7KPJyOGAnVW9RU62lI+f6aWU=;
        b=E6vSKtypoL/ZZDT+3AFWeW85bc9wE++SqGMmgGmbzsx/tF2Ny3sXXmrB4GQv2v2kiG
         shY6opt+ElFIvWdwh1E4Ra+qjEMIQVU1Y4zXuao3mtL+EGCaB3AhO8ETktLc2IRKzmcU
         rD7qZOMM9u43rTx8NrVe4vkMxqB3QwuS1akDxhmnCrPxGnwXzrvpfVhfUUO4FojL+E7J
         nn0I4vwqGh/io2g0n/XHP+4fG9tC3X1v0Yo4lVLrnxSkCNsiek3+8E89wMH/jV1ESIE9
         RcIMbfpj08RVNqxorP2r/uZ8wWo8+w5zJK4Gpo3E+JBeWSYQCfqjJ3ywH2KCGXMdT1DV
         xdOQ==
X-Gm-Message-State: AJIora/7qxraHmcaS/Z6hb+uO5lHehA5CpVOPzizYIVJWRW3weWbGlUJ
        YxSGn6E/ilwyk52K4WzUh1BAh9Zx2bD6jg==
X-Google-Smtp-Source: AGRyM1sVU50wcH2uOcao+LJnrLg+Jb++A7L/cJOlMAo9nhigjD9IyFzNyVKnjmNrdgXhTItMzCFYwQ==
X-Received: by 2002:a05:600c:3489:b0:39d:b58f:6797 with SMTP id a9-20020a05600c348900b0039db58f6797mr16642010wmq.205.1656354689562;
        Mon, 27 Jun 2022 11:31:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c230300b003973c54bd69sm18335364wmo.1.2022.06.27.11.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:31:29 -0700 (PDT)
Message-Id: <c57f63f6a6168b6da1e0cd786e0ec25013909d77.1656354677.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
References: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
        <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 18:31:10 +0000
Subject: [PATCH v4 09/16] bisect--helper: make `--bisect-state` optional
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
        Bagas Sanjaya <bagasdotme@gmail.com>,
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
index 2d6eafa2abd..1b1ce0941ff 100644
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
@@ -1320,10 +1320,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
@@ -1331,6 +1328,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

