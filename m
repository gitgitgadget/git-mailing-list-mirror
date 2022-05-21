Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EF7C433F5
	for <git@archiver.kernel.org>; Sat, 21 May 2022 15:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355322AbiEUPI2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 11:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348064AbiEUPIY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 11:08:24 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B43092D25
        for <git@vger.kernel.org>; Sat, 21 May 2022 08:08:23 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u27so14170731wru.8
        for <git@vger.kernel.org>; Sat, 21 May 2022 08:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Uo6VeR463A8bpTnDe4txbUadyp7c2hS7RwvOwDAMeOI=;
        b=PZNEORk0NSxTKVh83V/JOh2DRfSnZb0BK2K8L1+37Iz8pfMkzJq79phGCxi73m+UnV
         6bulCvE0bOpzuKJ3pPCpMM/xRaavllAbnoM4Ux7vE6dLvmiwsNbAKPl/zJGo4ZHx9Ik4
         jOFc+/1pC82zZ7wnc/OSZ8hHJUxR6jm1iN3PrWmvbr7b/PVYion2/V/CwjoM++4EHQla
         XiCp/Jne4wiRWjEeDQp9UpyE2/0NByLwYwHsmkVe/0dRqTmVjs4k83toca6e88NommLu
         AbMuhOVr61VEgYinfmcqIJwTDtFMcvbcw/BWVIb32ZynSK83DCf+hjUuj4PFIX+pSVI5
         NqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Uo6VeR463A8bpTnDe4txbUadyp7c2hS7RwvOwDAMeOI=;
        b=PZLoU/2AzFLr3mSr1SKpnHw2WOszLZcgD0GOQNfbDkq9M9KiFIiHOn5lZaQ+s+dJi4
         6xIVqIQehjlYR7DpyA1bCvuYVaiZ2Be8YXbuHyN0T9ogcaVmTrb37LFkPpzgA8h07tDf
         gyt5CfcjsGJ6KyV/LziLX9fteIZdCldpM3BrKjcPy6R4rlkeVxYpGX81AIUjAhP29BjK
         FaYbxiUerYOPPR9oQfAKaNlQ2l4I6GTelGdFfMIgk9iixTb/zrLeaXZZzeJJKw+lCeVf
         zmKesE7wuQcnEYVpx8+w2V4TZKWSrq1tz+p30YZzXkm1XKGtaVQ/aUkWpVhake/FrwQX
         RQGg==
X-Gm-Message-State: AOAM531cvVHmTYn5mrGuP96USDnRg7kA25MtlPJzzgB7U0ELWdJnPdGK
        hbXr7uQEFJWXdZQrtlLiJSxmV/BwMEc=
X-Google-Smtp-Source: ABdhPJxPCQZHjDP1YkqihbJLlTes+gPObC6lCBzjmla+mIgfGeiJYjYw3CPYXrmCAdRZ/vuSjPCiKA==
X-Received: by 2002:adf:dd09:0:b0:20e:6231:51e7 with SMTP id a9-20020adfdd09000000b0020e623151e7mr12579574wrm.251.1653145701496;
        Sat, 21 May 2022 08:08:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay13-20020a05600c1e0d00b003944821105esm4521800wmb.2.2022.05.21.08.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 08:08:21 -0700 (PDT)
Message-Id: <ca83ddd5eed8ec9946d36ec0289ad41c2837bdc8.1653145696.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
References: <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
        <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 15:08:12 +0000
Subject: [PATCH v6 3/7] scalar: validate the optional enlistment argument
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>, rsbecker@nexbridge.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
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

