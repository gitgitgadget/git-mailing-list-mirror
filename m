Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6570C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 19:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238952AbiG2TaV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 15:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238876AbiG2TaK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 15:30:10 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA8D8736A
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 12:29:52 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bn9so7144477wrb.9
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 12:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=flNOUpFpQNk5mfo8GE8lZF5pNYZBrO+OeLGye5bTl1g=;
        b=gx+nBeJMGeA9joe77Uh/rDo4OX7gqj6pOEsPktStZ9uFb/cP3jY05VH+UWdaHxDo34
         DbNIS2/m1N7NpfPMdP84soe9YgkxgIJJCTpDzmqfu32im2wWyy4x3VZPCFAas8A0TNH0
         65xS7qmYzyTpNQ1kI5q2D2pLEcWnn57B2QQKIBz9KrrO9eiCOAKHNXCCTxebsHz9qve2
         k4EGMlmCSL9KBNB0sM4UI4L9KC7/3qOlfsH9pvnvzzJmJ/Rhr1mxxNfWtq+06jgY1Zvq
         pnACWZQHOxDre86KTbQAwdaGRKmEbeXqVFsy1IxN3kwlZ2gIT5jLceDjnjHX1VxilnHw
         LHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=flNOUpFpQNk5mfo8GE8lZF5pNYZBrO+OeLGye5bTl1g=;
        b=ETjp4jxIFAkuGc24Ui25O/RLNBqJXjvhOX/uQXOfuD09AzPfCLQehhK78so83N1eEp
         kQv568hA7OOkA1ewWmwWxvyRgcdXEq7aHIYjGBb+VxuvcgkDADP9J/V0ADXkUSkWWncu
         v9WF66gP56SQRU4le50r1q6iwqw+RN5ArMee3TnZLzxT8kmguKcjX7inrLDhS+6x8HOB
         RvgcuQDBvN1EttiQKRPyqEq36PKuCSyAEY5qWVggxTFSCHUdwXPpL/OWCFop43xRPdn9
         o4l0kpbYDTEvpjwu2tIZFL7QaAvd81dp+EH3w/MFKBQjLGuSDMZldaR0GRI56C29AYmp
         cXHQ==
X-Gm-Message-State: ACgBeo1dfW3Eau09u0AwmoAUiJLszDzJIN/++oEfWQoMuoVlJ7iV9IjU
        haWtWcOzbEeVV91b87A11wyaiioTJ50=
X-Google-Smtp-Source: AA6agR4jX1MkTxte+lNC8535FY1Z5jJxgktrEhuHx3iVV125FeRqRLXZhKMpkvPoEPTDZR1cb0mjsQ==
X-Received: by 2002:a05:6000:168e:b0:21d:b9bf:5e39 with SMTP id y14-20020a056000168e00b0021db9bf5e39mr3461212wrd.71.1659122991172;
        Fri, 29 Jul 2022 12:29:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x12-20020a05600c21cc00b0039747cf8354sm4998025wmj.39.2022.07.29.12.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 12:29:50 -0700 (PDT)
Message-Id: <318269dfe27a56d4c85b8723fbd9853159e9d096.1659122979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
        <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jul 2022 19:29:38 +0000
Subject: [PATCH v2 09/10] maintenance: stop writing log.excludeDecoration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

This reverts commit 96eaffebbf3d0 (maintenance: set
log.excludeDecoration durin prefetch, 2021-01-19).

The previous change created a default decoration filter that does not
include refs/prefetch/, so this modification of the config is no longer
needed.

One issue that can happen from this point on is that users who ran the
prefetch task on previous versions of Git will still have a
log.excludeDecoration value and that will prevent the new default
decoration filter from being active. Thus, when we add the refs/bundle/
namespace as part of the bundle URI feature, those users will see
refs/bundle/ decorations.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/gc.c           |  6 ------
 t/t7900-maintenance.sh | 21 ---------------------
 2 files changed, 27 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index eeff2b760e0..6c222052177 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -910,12 +910,6 @@ static int fetch_remote(struct remote *remote, void *cbdata)
 
 static int maintenance_task_prefetch(struct maintenance_run_opts *opts)
 {
-	git_config_set_multivar_gently("log.excludedecoration",
-					"refs/prefetch/",
-					"refs/prefetch/",
-					CONFIG_FLAGS_FIXED_VALUE |
-					CONFIG_FLAGS_MULTI_REPLACE);
-
 	if (for_each_remote(fetch_remote, opts)) {
 		error(_("failed to prefetch remotes"));
 		return 1;
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 74aa6384755..62ed694a404 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -162,7 +162,6 @@ test_expect_success 'prefetch multiple remotes' '
 	test_cmp_rev refs/remotes/remote1/one refs/prefetch/remotes/remote1/one &&
 	test_cmp_rev refs/remotes/remote2/two refs/prefetch/remotes/remote2/two &&
 
-	test_cmp_config refs/prefetch/ log.excludedecoration &&
 	git log --oneline --decorate --all >log &&
 	! grep "prefetch" log &&
 
@@ -173,26 +172,6 @@ test_expect_success 'prefetch multiple remotes' '
 	test_subcommand git fetch remote2 $fetchargs <skip-remote1.txt
 '
 
-test_expect_success 'prefetch and existing log.excludeDecoration values' '
-	git config --unset-all log.excludeDecoration &&
-	git config log.excludeDecoration refs/remotes/remote1/ &&
-	git maintenance run --task=prefetch &&
-
-	git config --get-all log.excludeDecoration >out &&
-	grep refs/remotes/remote1/ out &&
-	grep refs/prefetch/ out &&
-
-	git log --oneline --decorate --all >log &&
-	! grep "prefetch" log &&
-	! grep "remote1" log &&
-	grep "remote2" log &&
-
-	# a second run does not change the config
-	git maintenance run --task=prefetch &&
-	git log --oneline --decorate --all >log2 &&
-	test_cmp log log2
-'
-
 test_expect_success 'loose-objects task' '
 	# Repack everything so we know the state of the object dir
 	git repack -adk &&
-- 
gitgitgadget

