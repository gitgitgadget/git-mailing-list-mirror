Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08510C433EF
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 16:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242678AbiBSQpU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 11:45:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242671AbiBSQpN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 11:45:13 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D25B5F4E9
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 08:44:54 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id k127-20020a1ca185000000b0037bc4be8713so10747306wme.3
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 08:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=e6xtNB5BwysTVf1JLa/AmaUE4ekue4CCCfL+8wZmFy4=;
        b=Q5Idkr+v2L/rJIVyrXTmZz8jrIr4P1yGFtAG4ZD+qalxT1biu2Z3Cl7V3vfQJezGNv
         ARFdpMovKC7TJ87+H3Lyk6MQ9euL7Nlpl3TCPtVNXgfxy1ML8nh3AfuBKCBGQk/m2bAf
         Ts9mTHeJVyRBk6TB5dqnIRZATPEGV+n+KCq7au9jebwHQXYiLn+A/jAZQwXvjsFQAuJD
         qIe/Hha0ZShiuo8rOW8tpF4kkLk9Yj5H0plONrNAuDF3tT2VzpCqWa2XfPXkHwOQCOOj
         dyZIEVFa2gXIUoqrYE4UJ+a8pf6E4BKw5/9isrtgUEdxAveX7TNnBagP+JCNfsvIEBia
         sxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=e6xtNB5BwysTVf1JLa/AmaUE4ekue4CCCfL+8wZmFy4=;
        b=mOWuTBXIfoMoa5ttfqOlT5DXSsksQPU+RD35izylopqgcsbuH4IQvHMjeY+eI7Z0nL
         pGE5IHzlzjmvmM1zouMA/lujlKsybEFi1pO/lFkg1JgwCkpdc+P9hoZFNDUUNhp172ni
         Gsz/NZquwaRKHDH6H6IXr+c+NtpbTxmmu13+DbvRkZoDTuzbyVMMZy0lau1rb/ZtWYaz
         sivOHdvt2vPiPycRvUnbBUZeAJfFvJtRoG+AhF6YHKPPVZwtW08WwAhxdmIxm368ySaC
         YjFglrkp6WXCF2S+/tq8Cc8vXYAvejnljWmLk8W0VC1bNueokvKqypYXnozX18t75yBc
         Gz9w==
X-Gm-Message-State: AOAM530a+1WAJiAYImnEVzP6gBijuXZo3ytFroz1tZRt5oNWb7duIiij
        rWUwqIobwkcgSyfQOKblVyIE7ja3NEc=
X-Google-Smtp-Source: ABdhPJw9Rrj0Di3owq4qtw4sPzomeCw9OtEnB5CCKEVBSg8vihYikvcF4fVmEpg4kCj1jOo5jHCHuw==
X-Received: by 2002:a1c:f003:0:b0:37b:d5fc:5c9e with SMTP id a3-20020a1cf003000000b0037bd5fc5c9emr11542203wmb.154.1645289092663;
        Sat, 19 Feb 2022 08:44:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l31sm2984215wms.0.2022.02.19.08.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 08:44:52 -0800 (PST)
Message-Id: <53183d07502fafde291a99afd96e4d7a1c0ee4d4.1645289086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1118.v5.git.1645289086.gitgitgadget@gmail.com>
References: <pull.1118.v4.git.1645080889.gitgitgadget@gmail.com>
        <pull.1118.v5.git.1645289086.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 19 Feb 2022 16:44:45 +0000
Subject: [PATCH v5 5/5] sparse-checkout: reject arguments in cone-mode that
 look like patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In sparse-checkout add/set under cone mode, the arguments passed are
supposed to be directories rather than gitignore-style patterns.
However, given the amount of effort spent in the manual discussing
patterns, it is easy for users to assume they need to pass patterns such
as
   /foo/*
or
   !/bar/*/
or perhaps they really do ignore the directory rule and specify a
random gitignore-style pattern like
   *.c

To help catch such mistakes, throw an error if any of the positional
arguments:
  * starts with any of '/!'
  * contains any of '*?[]'

Inform users they can pass --skip-checks if they have a directory that
really does have such special characters in its name.  (We exclude '\'
because of sparse-checkout's special handling of backslashes; see
the MINGW test in t1091.46.)

Reviewed-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c          | 11 +++++++++++
 t/t1091-sparse-checkout-builtin.sh |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 38ac37d9c61..a0c8a1499af 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -710,6 +710,17 @@ static void sanitize_paths(int argc, const char **argv,
 	if (prefix && *prefix && !core_sparse_checkout_cone)
 		die(_("please run from the toplevel directory in non-cone mode"));
 
+	if (core_sparse_checkout_cone) {
+		for (i = 0; i < argc; i++) {
+			if (argv[i][0] == '/')
+				die(_("specify directories rather than patterns (no leading slash)"));
+			if (argv[i][0] == '!')
+				die(_("specify directories rather than patterns.  If your directory starts with a '!', pass --skip-checks"));
+			if (strpbrk(argv[i], "*?[]"))
+				die(_("specify directories rather than patterns.  If your directory really has any of '*?[]\\' in it, pass --skip-checks"));
+		}
+	}
+
 	for (i = 0; i < argc; i++) {
 		struct cache_entry *ce;
 		struct index_state *index = the_repository->index;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 3b39329266b..421127d99c2 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -673,7 +673,7 @@ test_expect_success BSLASHPSPEC 'pattern-checks: escaped characters' '
 	git -C escaped reset --hard $COMMIT &&
 	check_files escaped "a deep folder1 folder2 zbad\\dir zdoes*exist" zglob[!a]? &&
 	git -C escaped sparse-checkout init --cone &&
-	git -C escaped sparse-checkout set zbad\\dir/bogus "zdoes*not*exist" "zdoes*exist" "zglob[!a]?" &&
+	git -C escaped sparse-checkout set --skip-checks zbad\\dir/bogus "zdoes*not*exist" "zdoes*exist" "zglob[!a]?" &&
 	cat >expect <<-\EOF &&
 	/*
 	!/*/
-- 
gitgitgadget
