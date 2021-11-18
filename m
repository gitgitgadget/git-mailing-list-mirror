Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA57C433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 10:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 544E06138F
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 10:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343533AbhKRKyM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 05:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343542AbhKRKxl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 05:53:41 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C086C061570
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 02:50:41 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id a9so10661207wrr.8
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 02:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eWjZ2Fb8wC7m67pIdo2K9o1etm/GNpvH1PwGZU+b8EY=;
        b=U6HJw9xU1sVyVHhCh0SS4PAQw/XcIunrz9hoKfEpp2e6UTVNYA38DdrdjHTkSPstXT
         lIN/uHlDl5CLek/mzzo9joZ2uIAqu51+RvQbjZXUVqPIS0ssMQIIcw2nyDNNL9wwGJo/
         Bim+xn+vgjFncZ+ASxC9CsAfwwo9SjqLqDRNXD/DfcHteQCKCTsDi9mKB4Bo3ddAmiTE
         oQsgmg3cljJWuZdCqoH1ec3V/EGou4c2rFf1pSWyP74VGQt1tT+agdvC+7sRMfaxxUDb
         +o18jV3zhrc0QeBuftqtxGmv8R0/r3BnF889b1tRfSNluVlKptPI5oWd4qGP2pLHGEsL
         Tyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eWjZ2Fb8wC7m67pIdo2K9o1etm/GNpvH1PwGZU+b8EY=;
        b=jMA05NphwhY9NjrT7AHeUN3YdbAqZtEBibVRuIfNeJIQX9vncAN7XU7h3t0d1cd9IQ
         1UMhvDCOIE5EfoloMRq16Ckcaimc8d+fBPqgOrag3jQQDZtxoCJjNfRekJoqparmJeNr
         z5f/IrKnKa1TumnaVMQglsDuhuHTB9wNh/xEKdzD627MxmAwfKmhRp7MHgFRYWcopS8Z
         +eyiPyMEaGaqRnXTrEosGFGY68LTLYTSP2EJ6IMBeUSPTwV0uMlmL2SrmhI+Csvx2Mb8
         x2ntuo+cdozhUTBbK/nPMicwMqkA2ovtotY/kifptBtBoPajmMMYf19OSHbZosZ/AyhJ
         82iA==
X-Gm-Message-State: AOAM530DqHe2YN/lXfM0Bz9ahl7rUgoCNVe8kxxpXHetji3CMloxrzbQ
        UyZFegNi97WIOxW+cspX9BJL+FAeWHw=
X-Google-Smtp-Source: ABdhPJwoPeCaSlv/jGQa9V4bF/FzyPxnXo2YnaKSGWvdMhgModqr37fn+uoAmiXf+B3/aDz9lVDpFw==
X-Received: by 2002:a5d:64ed:: with SMTP id g13mr30019229wri.222.1637232639751;
        Thu, 18 Nov 2021 02:50:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p62sm2650052wmp.10.2021.11.18.02.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 02:50:39 -0800 (PST)
Message-Id: <e907a2b2faa1e3c5854504c23cc6e118c2125817.1637232636.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com>
References: <pull.1076.v5.git.1637141636.gitgitgadget@gmail.com>
        <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Nov 2021 10:50:36 +0000
Subject: [PATCH v6 3/3] am: throw an error when passing --empty option without
 value
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>, Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Aleen <aleen42@vip.qq.com>

Signed-off-by: Aleen <aleen42@vip.qq.com>
---
 builtin/am.c  | 13 +++++++------
 t/t4150-am.sh |  8 +++++++-
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 1a3ed87b445..5d487b5256b 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -185,12 +185,14 @@ static int am_option_parse_quoted_cr(const struct option *opt,
 	return 0;
 }
 
-static int am_option_parse_empty_commit(const struct option *opt,
+static int am_option_parse_empty(const struct option *opt,
 				     const char *arg, int unset)
 {
 	int *opt_value = opt->value;
 
-	if (unset || !strcmp(arg, "die"))
+	BUG_ON_OPT_NEG(unset);
+
+	if (!strcmp(arg, "die"))
 		*opt_value = DIE_EMPTY_COMMIT;
 	else if (!strcmp(arg, "drop"))
 		*opt_value = DROP_EMPTY_COMMIT;
@@ -2391,10 +2393,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		{ OPTION_STRING, 'S', "gpg-sign", &state.sign_commit, N_("key-id"),
 		  N_("GPG-sign commits"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
-		{ OPTION_CALLBACK, 0, "empty", &state.empty_type,
-		  "(die|drop|keep)",
-		  N_("specify how to handle empty patches"),
-		  PARSE_OPT_OPTARG, am_option_parse_empty_commit },
+		OPT_CALLBACK_F(0, "empty", &state.empty_type, "{drop,keep,die}",
+		  N_("how to handle empty patches"),
+		  PARSE_OPT_NONEG, am_option_parse_empty),
 		OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
 			N_("(internal use for git-rebase)")),
 		OPT_END()
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 3119556884d..c32d21e80da 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -1165,8 +1165,14 @@ test_expect_success 'still output error with --empty when meeting empty files' '
 	test_cmp expected actual
 '
 
-test_expect_success 'error when meeting e-mail message that lacks a patch by default' '
+test_expect_success 'invalid when passing no value for the --empty option' '
 	git checkout empty-commit^ &&
+	test_must_fail git am --empty empty-commit.patch 2>err &&
+	echo "error: Invalid value for --empty: empty-commit.patch" >expected &&
+	test_cmp expected err
+'
+
+test_expect_success 'error when meeting e-mail message that lacks a patch by default' '
 	test_must_fail git am empty-commit.patch >err &&
 	test_path_is_dir .git/rebase-apply &&
 	test_i18ngrep "Patch is empty." err &&
-- 
gitgitgadget
