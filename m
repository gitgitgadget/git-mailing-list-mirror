Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75069ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 18:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiH3SvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 14:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiH3Suv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 14:50:51 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFD04C61D
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:37 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bu22so15070802wrb.3
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=NoYvMA/epqY3ghH1gKytvRGrE08JXJ83K6Pyb8wiZSw=;
        b=YaJTvEcI6+puKdvaY8a3wSwXTAaebPuPXfZDLIMLXT16uAEQy31BT7Kc7z6an0IKXz
         FM5mBRYQ8jW0mxPByTFga50tbdukKKYq+YVNQsnMhw0galSYj0WK9GZH3CYfKf6NbYcr
         Tpduwlrws3YvQQRG7/LtQoPx7+dsC90ogHdn/p7XmesTVoVy1EOvhQne39bE4iMk4VeH
         Jir9HYx0QyfQQ0OX6W1lJUUv/uqHlHGPK195OZZm44JgV25+MGkIfegHd+BpTeNeXghg
         VnpF1lZoNWOQInDOSjIj/XPnl6Nhaeol9A5u/74wkOZN+26NpLa8JEv1el7E82R+5sb7
         P7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=NoYvMA/epqY3ghH1gKytvRGrE08JXJ83K6Pyb8wiZSw=;
        b=4iBKAFQSePt6DmmY6Yg95fbE/c0voX/lKXO130YwMloLV05VxEIfVGkEM8fNxiUUGc
         RxSG/UewaG9pAHRN9yYppabtRCBdj5mpHqwGmJzT8JcsSHjNr26x8Ulv6P75JiwPDj+i
         gicE9D+sjVLetjs5B3krMfBJ67xYGjJuHmB2FqPOTn0p5xm91znGk15JBlFvdm6XMopR
         QgD92A3gw58aBNWfnnQADp+eHsHevLO50BSA/T4efdOpTADIK4+izl5bFOwKiiGq6/3k
         6rcohknvK4C3gyudAdNR1werOUgTD9aIb6wQLnTbbYzxtAyCUZu31TzfFR325iKUIJw3
         m4Aw==
X-Gm-Message-State: ACgBeo227FAvLJVdHRMUG6NV8xHNrgqWLp4XaIWgpt70zWmjVml5XIKf
        LIQIU6IIO2XEIyTXd+WgxZ7TH2oE/hQ=
X-Google-Smtp-Source: AA6agR5YDR1dDK2zpE6IXbCnyRslj9SgaXgTJEld+6kb1Yw+lmIDZ02tZ055NyUynZCM1yF4FdMxjw==
X-Received: by 2002:a05:6000:795:b0:226:e8d9:828c with SMTP id bu21-20020a056000079500b00226e8d9828cmr726389wrb.464.1661885435276;
        Tue, 30 Aug 2022 11:50:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v18-20020a1cf712000000b003a5c7a942edsm12547648wmh.28.2022.08.30.11.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:50:34 -0700 (PDT)
Message-Id: <e7623508f90916d494915637342cd2327c7eea5e.1661885419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
References: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
        <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Aug 2022 18:50:15 +0000
Subject: [PATCH v6 12/16] bisect--helper: make `state` optional
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
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In preparation for making `git bisect` a real built-in, let's prepare
the `bisect--helper` built-in to handle `git bisect--helper good` and
`git bisect--helper bad`, i.e. do not require the `state` subcommand to
be passed explicitly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 22 +++++++++++++++++++++-
 git-bisect.sh            |  2 +-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index ac3b2e5b61c..61e819e4efc 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1447,6 +1447,7 @@ static int cmd_bisect_run(int argc, const char **argv, const char *prefix)
 
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
+	struct strvec args = STRVEC_INIT;
 	parse_opt_subcommand_fn *fn = NULL;
 	int res = 0;
 	struct option options[] = {
@@ -1464,10 +1465,29 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     bisect_usage, 0);
+			     bisect_usage, PARSE_OPT_SUBCOMMAND_OPTIONAL);
+
+	if (!fn) {
+		if (!argc)
+			usage_msg_opt(_("need a command"), bisect_usage,
+				      options);
+
+		set_terms("bad", "good");
+		get_terms();
+		if (check_and_set_terms(argv[0]))
+			usage_msg_optf(_("unknown command: '%s'"), bisect_usage,
+				       options, argv[0]);
+
+		strvec_push(&args, "state");
+		strvec_pushv(&args, argv);
+		argc = args.nr;
+		argv = args.v;
+		fn = cmd_bisect_state;
+	}
 
 	res = fn(argc, argv, prefix);
 	free_terms();
+	strvec_clear(&args);
 
 	return is_bisect_success(res) ? 0 : -res;
 }
diff --git a/git-bisect.sh b/git-bisect.sh
index e19847eba0d..f4df8709d84 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -60,7 +60,7 @@ case "$#" in
 	start)
 		git bisect--helper start "$@" ;;
 	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
-		git bisect--helper state "$cmd" "$@" ;;
+		git bisect--helper "$cmd" "$@" ;;
 	skip)
 		git bisect--helper skip "$@" || exit;;
 	next)
-- 
gitgitgadget

