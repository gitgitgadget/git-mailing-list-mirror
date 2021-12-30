Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DFEC4332F
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 00:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhL3Ach (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 19:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbhL3Acg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 19:32:36 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B2BC061574
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 16:32:35 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id b73so14632621wmd.0
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 16:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tl/2v4010Nv23zr4hoIwG8ZM+d+bjnLqiey99XsHXpQ=;
        b=UlBJvAXd2UutiqpTiNVJgXCa64IwtTLhUkjjwAjkQ1kgAkgBJCBwsbCgZQ1Gj5XXvg
         esWmOcdh/tn7AR0s5lzdqZEGCrFzon4Yc4a7JK/1Re8tbn15dbOu1LrvrZVai4xm0DHd
         /5VX5iuISEz12wSNPayAsXuEhVoM7qDrBm2gcYj0qahugaLmSI8kUldfY62igk3suQfY
         hnpr4jv4eCPkUKYiy0OYlAbjcK8Uldon7kir052Vu9Aa8tvsU2iu05VV2To259a6tIo0
         4RAzxJL1leICkRWtvDVSXrwBbDOf0eYp5ii7IvchZ+FPnNGb+sRIMEr3VJd7NOmxjYHV
         hzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tl/2v4010Nv23zr4hoIwG8ZM+d+bjnLqiey99XsHXpQ=;
        b=SFzOuaTFpR2hecEvCfLsWyVl0lVxFoqXISTAdtmq6R9Xt8ZRJmL5KOMntEOgO6OsgJ
         99humDfP3E4XSLqS5LrWaVa5ej96m7/pNjO7ICTGg+6tRY/Djv6/A95YZSgp/yu/AG0b
         GFDWaMfkTAnt+Xe46DpgfukN0KVo24CLEyMzUhJ+b4q2xKuYABOAmLbMdAlxuKBuhNNs
         XBdO7n0BAijBUuquYibWmjEWwsW3QrKGHP7YZWAY59wb6a8wGOZOAZmmdVy1z74TGwg9
         pHytgCpuJ3izDYQ/81TgsWhoPH++jRD17OTeMqBWs4w6Insoito3iJWb+aN0sDY6hIzt
         SgNg==
X-Gm-Message-State: AOAM530fwr85PIA6ZcER28sKbXxLWlcSTVxXRju1TVAdm6J+4jjjmqsL
        4Hx6rAJMb9wgOjJ6yl3t4l8wUc7HIYU=
X-Google-Smtp-Source: ABdhPJyGzJa2/8AVviOr+PwwOz/qyAKqZ4j8TrgcmalahfUjRyck8lpDixiNjcVi8sv8O/Uk12VVtg==
X-Received: by 2002:a1c:a98f:: with SMTP id s137mr23639422wme.5.1640824353602;
        Wed, 29 Dec 2021 16:32:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l14sm16905798wrr.53.2021.12.29.16.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 16:32:33 -0800 (PST)
Message-Id: <a7f3ae5cddaed61a618a5fa2f9d9c888e0dd7d99.1640824351.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1108.git.1640824351.gitgitgadget@gmail.com>
References: <pull.1108.git.1640824351.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Dec 2021 00:32:30 +0000
Subject: [PATCH 1/2] sparse-checkout: custom tab completion tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, johannes.schindelin@gmail.com,
        Lessley Dennington <lessleydennington@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lessley Dennington <lessleydennington@gmail.com>

Add tests for missing/incorrect components of custom tab completion for the
sparse-checkout command. These tests specifically highlight the following:

1. git sparse-checkout <TAB> results in an incomplete list of subcommands
(it is missing reapply and add).
2. git sparse-checkout --<TAB> does not complete the help option.
3. Options for subcommands are not tab-completable.
4. git sparse-checkout set <TAB> and git sparse-checkout add <TAB> show
both file names and directory names.

Although these tests currently fail, they will succeed with the
sparse-checkout modifications in git-completion.bash in the next commit in
this series.

Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
---
 t/t9902-completion.sh | 74 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 0f28c4ad940..22271ac2f3b 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1444,6 +1444,80 @@ test_expect_success 'git checkout - with --detach, complete only references' '
 	EOF
 '
 
+test_expect_failure 'sparse-checkout completes subcommands' '
+	test_completion "git sparse-checkout " <<-\EOF
+	list Z
+	init Z
+	set Z
+	add Z
+	reapply Z
+	disable Z
+	EOF
+'
+
+test_expect_failure 'sparse-checkout completes options' '
+	test_completion "git sparse-checkout --" <<-\EOF
+	--help Z
+	EOF
+'
+
+test_expect_failure 'sparse-checkout completes subcommand options' '
+	test_completion "git sparse-checkout init --" <<-\EOF &&
+	--cone Z
+	--sparse-index Z
+	--no-sparse-index Z
+	EOF
+
+	test_completion "git sparse-checkout set --" <<-\EOF &&
+	--stdin Z
+	EOF
+
+	test_completion "git sparse-checkout add --" <<-\EOF
+	--stdin Z
+	EOF
+'
+
+test_expect_failure 'sparse-checkout completes directory names' '
+	# set up sparse-checkout repo
+	git init sparse-checkout &&
+	(
+		cd sparse-checkout &&
+		mkdir -p folder1/0/1 folder2/0 folder3 &&
+		touch folder1/0/1/t.txt &&
+		touch folder2/0/t.txt &&
+		touch folder3/t.txt &&
+		git add . &&
+		git commit -am "Initial commit"
+	) &&
+
+	# initialize sparse-checkout definitions
+	git -C sparse-checkout config index.sparse false &&
+	git -C sparse-checkout sparse-checkout init --cone &&
+	git -C sparse-checkout sparse-checkout set folder1/0 folder3 &&
+
+	# test tab completion
+	(
+		cd sparse-checkout &&
+		test_completion "git sparse-checkout set f" <<-\EOF
+		folder1 Z
+		folder1/0 Z
+		folder1/0/1 Z
+		folder2 Z
+		folder2/0 Z
+		folder3 Z
+		EOF
+	) &&
+
+	(
+		cd sparse-checkout/folder1 &&
+		test_completion "git sparse-checkout add " <<-\EOF
+		./ Z
+		0 Z
+		0/1 Z
+		EOF
+	)
+'
+
 test_expect_success 'git switch - with -d, complete all references' '
 	test_completion "git switch -d " <<-\EOF
 	HEAD Z
-- 
gitgitgadget

