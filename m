Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA78C433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 06:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbiBQGzO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 01:55:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbiBQGzK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 01:55:10 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CB727F299
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 22:54:56 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id x5so2389649wrg.13
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 22:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vGo4Cu0wMK+GKV1DY6HP5Ycd5t3WJLkBzJplqc6dbYU=;
        b=YrAKu6RQT5iKnX1UEbgtniTHsmEG/VufG4y004H6zSNcVosCaK763irCUyIfOLci/V
         DvQJyvKWzT+XWCj08a0NYIKWeKdCzTeZJG1sn2v09bzXNGqGSqS0jJm81rhtyHn6vxqD
         mZsQuJNrEFAFhVvVxLPgoTTNjXXJ+h1GUQ5fo1j5IzphqZRlL5T5zrMImpXm3wFmjVI7
         AtD43y+6LGzfE0tI5cmz12k9CPbrmTySazvgq+wrQnboKyrGLNxw5H6bkbn/tmdpCT4x
         pZ8dsqQp0w0salH/qLQrd6bZvF3JYBg+iB7hKdFj+ibBIx+ssoQ6qZslrCQgXOK6mYxi
         KgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vGo4Cu0wMK+GKV1DY6HP5Ycd5t3WJLkBzJplqc6dbYU=;
        b=KSZJhK3ZfVYeNGsg3Cw7OkUgp+LHqaDRqM2sxn+gQiJDPSGvIIY79t8hRdzrS9ezve
         +fi91mHRctgohQYO67VKld+FksFBAixucZJhky8xgAMI54yICeyus2a6hTiFAcibVc3N
         Ut1gQQqKNTTOIW+Gm15AVJw1QotKBF1RhqfY+2Nj3k1kENG2PSc9iIDhBRoAynoI2LJ5
         YeWZCIp5Yx6tYNh5MZbyrd9oPVJkZp7rutHS/K5aBf0uFEE5fL/1b8L+3vvtR+tNiA3r
         QB8cs7A1OQXlLG0T1/R7BrYstovQWGMoAS6yL+0+YgRUHxquZ9+/K67x04SFvFe+44cm
         ZL/Q==
X-Gm-Message-State: AOAM533Z4Eu5CFvB/SKAnI7DhkRwSAcYsuDFvX20xKyppGWs3f6jwTxd
        sQ9Tx8yPM/ipwLH2oTFOVnBdjFUf8r8=
X-Google-Smtp-Source: ABdhPJxU7s+971wSvzGmOv7SgQWzyjM7EA80TrYN9zFwEenpiOJWvzgsy2G90f4vm5BBIcQkxq5Qpw==
X-Received: by 2002:a5d:4534:0:b0:1e4:9d38:2d4f with SMTP id j20-20020a5d4534000000b001e49d382d4fmr1176396wra.2.1645080895411;
        Wed, 16 Feb 2022 22:54:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5sm281602wmp.10.2022.02.16.22.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 22:54:54 -0800 (PST)
Message-Id: <d68682c25c439b35384472900acf0bc27f386f14.1645080889.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1118.v4.git.1645080889.gitgitgadget@gmail.com>
References: <pull.1118.v3.git.1644985283.gitgitgadget@gmail.com>
        <pull.1118.v4.git.1645080889.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Feb 2022 06:54:49 +0000
Subject: [PATCH v4 5/5] sparse-checkout: reject arguments in cone-mode that
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
index 64583fa704f..14601b8bd67 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -710,6 +710,17 @@ static void sanitize_paths(int argc, const char **argv,
 	if (skip_checks)
 		return;
 
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
