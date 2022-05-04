Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC24C433EF
	for <git@archiver.kernel.org>; Wed,  4 May 2022 15:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352451AbiEDP3p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 11:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352594AbiEDP3I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 11:29:08 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7635165AF
        for <git@vger.kernel.org>; Wed,  4 May 2022 08:25:26 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i5so2488439wrc.13
        for <git@vger.kernel.org>; Wed, 04 May 2022 08:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Uo6VeR463A8bpTnDe4txbUadyp7c2hS7RwvOwDAMeOI=;
        b=aGPDfIL7ucaH2apD8/TG7UTxME18NXFoiFTgp6N8cwnRny8xT2yEfUl/weztLE0O3f
         Yhg2tyckQDJHoKAqi7ByV/yEY7fbpTX9TdH9ea631I1+FnY6CR+RZjJ9Qu97p6ZcLxrK
         yyHkZ2sOicUdAbVr+7ztTSCZnqPa4loHExqvkN7jJm7A46ZuFe5/GXsj1KI637xTfeMv
         u0MaqpZh2ocW0/5UZPu7r90fs1ajm2zQS+Qc9qGq2ABkFKzuS2p5LgLe3CKaNULnOj82
         xrY09bRL6qqKjYdEFLob8nDhVucOVB3ChrpLdSqs6Yt/uDMCkJ+lOXJ2g/1TwRULQaiK
         v/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Uo6VeR463A8bpTnDe4txbUadyp7c2hS7RwvOwDAMeOI=;
        b=UM0ODh5KbF3Y9W9svSOhxq5t3Q+0saxkHL4yenzydiNTyv/n7o1qskA+iHgvjlFqTv
         YTpyRLdGiPxFmaq+hzUwMhQwyvmir6Kg8ae0WZ3Ak3ucpzuoEqYEh/OtQVK9ik9nfOhL
         R/1RaESUdIEYzXrV3HN/vs5QUR6Dqy+wGP4rDLcD486kKc7oaBSXN3N++mlRvGcg5fc4
         VcdlLllU0QHpUw19/G+R7QsdQHO33vxexts9p4l0iZcDr1qs/uLvcp0kdGqA+EnTjePb
         r5ki3T72pGaA23QM8UbHZH6YAzd14tss6bK6J0F6jznUbXSx5z76du9Srgtje3atsFUO
         +t1g==
X-Gm-Message-State: AOAM530XgtEYce/iculpdTA4Z6j2rSyMlLeunsoEPziUD0/AYyinOpH3
        gRkQeOu3mFSVXUI324KpOOxVwwMk/e4=
X-Google-Smtp-Source: ABdhPJwFIsNWDtqSPBNC3NBaUGh+BkL89our2A4yv1VOZ5B/gCEIJaho9cS/JfBU0/9eKNyC63kBVA==
X-Received: by 2002:a05:6000:170a:b0:20c:5e04:af27 with SMTP id n10-20020a056000170a00b0020c5e04af27mr12638601wrc.547.1651677925041;
        Wed, 04 May 2022 08:25:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t8-20020a7bc3c8000000b0038eba413181sm4057993wmj.1.2022.05.04.08.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 08:25:24 -0700 (PDT)
Message-Id: <5a3eeb5540943279d1677c1338df86b58239abc1.1651677919.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
References: <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
        <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 May 2022 15:25:15 +0000
Subject: [PATCH v3 3/7] scalar: validate the optional enlistment argument
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `scalar` command needs a Scalar enlistment for many subcommands, and
looks in the current directory for such an enlistment (traversing the
parent directories until it finds one).

These is subcommands can also be called with an optional argument
specifying the enlistment. Here, too, we traverse parent directories as
needed, until we find an enlistment.

However, if the specified directory does not even exist, or is not a
directory, we should stop right there, with an error message.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          | 6 ++++--
 contrib/scalar/t/t9099-scalar.sh | 5 +++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 1ce9c2b00e8..00dcd4b50ef 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -43,9 +43,11 @@ static void setup_enlistment_directory(int argc, const char **argv,
 		usage_with_options(usagestr, options);
 
 	/* find the worktree, determine its corresponding root */
-	if (argc == 1)
+	if (argc == 1) {
 		strbuf_add_absolute_path(&path, argv[0]);
-	else if (strbuf_getcwd(&path) < 0)
+		if (!is_directory(path.buf))
+			die(_("'%s' does not exist"), path.buf);
+	} else if (strbuf_getcwd(&path) < 0)
 		die(_("need a working directory"));
 
 	strbuf_trim_trailing_dir_sep(&path);
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index 2e1502ad45e..9d83fdf25e8 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -85,4 +85,9 @@ test_expect_success 'scalar delete with enlistment' '
 	test_path_is_missing cloned
 '
 
+test_expect_success '`scalar [...] <dir>` errors out when dir is missing' '
+	! scalar run config cloned 2>err &&
+	grep "cloned. does not exist" err
+'
+
 test_done
-- 
gitgitgadget

