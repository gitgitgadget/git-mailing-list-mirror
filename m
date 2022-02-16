Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C80C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 04:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344278AbiBPEV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 23:21:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343942AbiBPEVn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 23:21:43 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F1FE0B3
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 20:21:29 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id k1so1315126wrd.8
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 20:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/J/W/zvxLbl9imEtanzbUq56Wh8kmorpGiN4WOm7kmA=;
        b=MDaPDaFWeU+fUeQzeKgJhNZNDwXPN8+7DL5IziiLtX3pE6d1Sbb8cRmQIYsCRR6cT1
         jat0+dCoq68WFcFGkojvqZKQIhngfI4kmQWbVWw/f0i83/C7S7VJsIyaN8J8j1VXAVGK
         ingaAMYMHhoOQmWNTystCSyCQ5MKM4FH8fypvhubATLHsaTfK9MYwrFPMn3cqip968UH
         byiXh7dLIzfuMUtR9/Atrgq/GCREhX3MddExlkEOWS1439OgQGL6mdaJ8XSl/BPjbIGB
         Kfk1WNfdMimW7doI8XmEJEjMIUiB1w0IPRXOWoV3TZ0p2qY1gx4iZUuccGqy88l3T39v
         vk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/J/W/zvxLbl9imEtanzbUq56Wh8kmorpGiN4WOm7kmA=;
        b=j6BnKtcLJ8kKwa0OBPFM3Xg9LKhzIimdpJdC96WXjE0r+R8hdmq3sIn2PQH/yAZ2BQ
         peI0H9ZAXpKy3NMBTmOUauYpR87Y/HihSE3NLEP1O3BUbYlP1GnRX7bHJi78dH4nA3zW
         Az0K7jZX5SXYgLuq5rTVjirg4PDBMhszOTtt+ZQ2xqcjxAuqURKmg8AUF/xP7FgR/YnA
         9l7bxmavGOiYKt/7ePu7Mug7aKyB6F+X97kjNMpmJzqT61GLIx1yebvBD6zrwegDhpFs
         LlRNrrvQShQlYYH0BeA6h42uXN9vDcIPbL8dSOA774VbZlNu+CgvvlqIBEaWWNHfI90x
         bsGg==
X-Gm-Message-State: AOAM533JC2vKKcllnZzEC4mZD3NlaK4XuJ+gnS8s+0qIhzpntzassug9
        mTef20qPOiRlvTT4t9V6vkPGT+MYCIo=
X-Google-Smtp-Source: ABdhPJw8vvLzBYhdc1o6GtIGuVQXi1VxPPcZoS+qE0ftHjjyvRkFktAF4Dk5+3jI780cR9xSw0wCcw==
X-Received: by 2002:adf:f5ca:0:b0:1e4:a672:586e with SMTP id k10-20020adff5ca000000b001e4a672586emr833927wrp.190.1644985288234;
        Tue, 15 Feb 2022 20:21:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ba14sm12041317wrb.56.2022.02.15.20.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 20:21:27 -0800 (PST)
Message-Id: <2008542d0c718bbe43388297307a791f94bc73e1.1644985283.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1118.v3.git.1644985283.gitgitgadget@gmail.com>
References: <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com>
        <pull.1118.v3.git.1644985283.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 04:21:23 +0000
Subject: [PATCH v3 5/5] sparse-checkout: reject arguments in cone-mode that
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
        Elijah Newren <newren@gmail.com>,
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
  * contains any of '*\?[]'

Inform users they can pass --skip-checks if they have a directory that
really does have such special characters in its name.

Reviewed-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c          | 14 ++++++++++++++
 t/t1091-sparse-checkout-builtin.sh |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 64583fa704f..1a74173f7a1 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -710,6 +710,20 @@ static void sanitize_paths(int argc, const char **argv,
 	if (skip_checks)
 		return;
 
+	if (core_sparse_checkout_cone) {
+		for (i = 0; i < argc; i++) {
+			if (argv[i][0] == '/')
+				die(_("specify directories rather than patterns (no leading slash)"));
+			if (argv[i][0] == '!')
+				die(_("specify directories rather than patterns.  If your directory starts with a '!', pass --skip-checks"));
+			if (strchr(argv[i], '*') ||
+			    strchr(argv[i], '?') ||
+			    strchr(argv[i], '[') ||
+			    strchr(argv[i], ']'))
+				die(_("specify directories rather than patterns.  If your directory really has any of '*?[]' in it, pass --skip-checks"));
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
