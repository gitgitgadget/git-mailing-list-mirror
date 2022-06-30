Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E947CCA473
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 21:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbiF3VUL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237464AbiF3VUB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 17:20:01 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E3D4D4F2
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:57 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q9so372473wrd.8
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8cJMTkrSAU6h8A1nOqWo8c80MQ+n6b/lbpr+v1A9LUM=;
        b=DV6rItXLa1x32PQ3wio4ngMEuMG123UWCuNbmJU2KwS9WeSkDwMcHw8vG6SZVyc2Nb
         0aoRHfDZmubO9OhbSpiGAkasoQSszV9ZuySDgZF0eilJzZ3X6zY7TQ6Gse9lwtd7KXja
         x7f1Gs8gKMt9+BEg5voDSncqUilGu11tlR2bpnrk4GlcquqOnparxQphQIbEiwcDZVrK
         0JR+TW5fvP30DRcknwFA+DHDqQckgx4PeJLMxL+9WUN2f7CaXKmB0ZkhpOmMBEaXGZ9z
         BZCxIu3SisuaQQxIqV3lxzVHTTlKCnI7+DvnihwmYcgDoYbms04zwui+o+yAcZzshcEJ
         AFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8cJMTkrSAU6h8A1nOqWo8c80MQ+n6b/lbpr+v1A9LUM=;
        b=21ANm5zcDoGHkoKl4MriuZZ/ZMtVPwWWUqXBId8TfZQpgzqTz8F3GY/nYVgtShetHN
         2StBWKdvRq+U20MfEmBoONftWFGXRW1R1nhnN6Segwplupg2OmCPaLjKxqOzQ7mb6p9t
         VOESfYsNWYK8XFMCOgAPt3fR3bRe3lZyCjPJ62UT1e2OSdu7kwBChn24Ttw96LvD+IVi
         QsEDp22UKVjsqJ7XQ6JeEv2wNQ9r75tcwPhA2D9MbaPgfyx0943uTrO+3twkNGgNcaTU
         t0dtrEChSKx9U9g9i8E8vwJOjnGIiEyrUwdDjc7VmHV1vFdXcbsRlotBHMq/MNU8zPgr
         GLUg==
X-Gm-Message-State: AJIora9xTtsE8EUM284JkiNT/MvSCN3SBzdVhCgfX92YrrkSbIAnyFNs
        D+OT5mZPwgapPJhmgk792sZnmSvVw4g=
X-Google-Smtp-Source: AGRyM1scWHuXDQZMMxgxKuLTW36xCGv97fYhMc8cMvsIsv2ZWRClNYpSIy82UbEiu8Byc0RZrgFk7w==
X-Received: by 2002:a5d:428d:0:b0:21b:a1c1:2b04 with SMTP id k13-20020a5d428d000000b0021ba1c12b04mr10498361wrq.106.1656623996495;
        Thu, 30 Jun 2022 14:19:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d43cf000000b0021badf3cb26sm24300803wrr.63.2022.06.30.14.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:19:55 -0700 (PDT)
Message-Id: <d3e803a4630a11bb68f673403eceb890bd573562.1656623978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
        <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 21:19:34 +0000
Subject: [PATCH v2 14/18] submodule--helper: don't recreate recursive prefix
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

update_submodule() uses duplicated code to compute
update_data->displaypath and next.recursive_prefix. The latter is just
the former with "/" appended to it, and since update_data->displaypath
not changed outside of this statement, we can just reuse the already
computed result.

We can go one step further and remove the reference to
next.recursive_prefix altogether. Since it is only used in
update_data_to_args() (to compute the "--recursive-prefix" flag for the
recursive update child process) we can just use the already computed
.displaypath value of there.

Delete the duplicated code, and remove the unnecessary reference to
next.recursive_prefix. As a bonus, this fixes a memory leak where
prefixed_path was never freed (this leak was first reported in [1]).

[1] https://lore.kernel.org/git/877a45867ae368bf9e053caedcb6cf421e02344d.1655336146.git.gitgitgadget@gmail.com

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index db2d5ab7998..c104b1a0236 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2418,9 +2418,9 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 
 	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
 	strvec_pushf(args, "--jobs=%d", update_data->max_jobs);
-	if (update_data->recursive_prefix)
-		strvec_pushl(args, "--recursive-prefix",
-			     update_data->recursive_prefix, NULL);
+	if (update_data->displaypath)
+		strvec_pushf(args, "--recursive-prefix=%s/",
+			     update_data->displaypath);
 	if (update_data->quiet)
 		strvec_push(args, "--quiet");
 	if (update_data->force)
@@ -2516,14 +2516,6 @@ static int update_submodule(struct update_data *update_data)
 		struct update_data next = *update_data;
 		int res;
 
-		if (update_data->recursive_prefix)
-			prefixed_path = xstrfmt("%s%s/", update_data->recursive_prefix,
-						update_data->sm_path);
-		else
-			prefixed_path = xstrfmt("%s/", update_data->sm_path);
-
-		next.recursive_prefix = get_submodule_displaypath(prefixed_path,
-								  update_data->prefix);
 		next.prefix = NULL;
 		oidcpy(&next.oid, null_oid());
 		oidcpy(&next.suboid, null_oid());
-- 
gitgitgadget

