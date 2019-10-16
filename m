Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47A5C1F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 07:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389396AbfJPHHX (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 03:07:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42432 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388897AbfJPHHW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 03:07:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id n14so26600218wrw.9
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 00:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ORfHEErNkg4LTahHiX+TMH6O36NKJDkH1FP+B+MqazM=;
        b=AT04BpFwZ35j+WzTOfZeN0M9wfFA+vTXhiq7PumrCAswaUdil+FuwDHoRHpjdXu05X
         vj+2agsDQqdG23zTcfqFDMOt6lSRfqVHv0uW1CUHvPb1PNK4ETwBFGTQ1VfsQ188Rjdx
         17/bg3ZV6Tc1V4+g/VmGYsTDkLnFwH1q2rtVM4UFaAVFkou+NLL5ll69fNYG8OLlHfna
         ONFLofOzdwpomBa0wKIzsJig24h/QsnGlxma075dBqMVUK6s/C+R4ztx1n9WlKxxMuay
         JF7ehczGcvIpnH6oWK89YaglsOrqVGlDfnyP+sswQSnp7YGwisaD6+IPtpInkb0LWdrT
         ZEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ORfHEErNkg4LTahHiX+TMH6O36NKJDkH1FP+B+MqazM=;
        b=diLv+6whl/vKD8rZdV7KIAKLHH7zz3nkZtYFNGtuv5AGgVcQts9ImHey/TAIz+ybh/
         XdjQ/oXFt041H/KRNQIihNejDG7aACk4Vq4G0aSjl+ZfWZuo0KysH4hDJUvgjjvTM4ZE
         7S8qVNQn7me49Mh33aV6dB0K/K3pbZRTbYww/y6g/ADxsxrUG4sAb6jDhE09Zluhw4vw
         ZoU7AbW/rDvqmbZxTZgobR6QpA3/CgCLdUcufvgyfU/XyZSBz1wzEC0Inm7KP+5A5XT9
         WmZvmxHUZnjIKQ7mWSCBZIrVruMho/mmpxHPA3Mm9Ll7QH8i2Heb/B9iaEtDBbeh1Zq1
         w0Iw==
X-Gm-Message-State: APjAAAUOqDxixMC2Pj4LcKUyB2ziBnUvpNsbUFV6UgA3oN2FR50tesr7
        hWDm9IQLdJrvfpJIvdAh4sRjxeMZ
X-Google-Smtp-Source: APXvYqzSNZL8tJPjqwFuLmE3VPy6wDNNxWsddQuLp3k+Oy38CuIOb27gAenPDyW1Q62jB+yvVGAq1A==
X-Received: by 2002:a05:6000:11d2:: with SMTP id i18mr1304974wrx.109.1571209640786;
        Wed, 16 Oct 2019 00:07:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y3sm7565227wmg.2.2019.10.16.00.07.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 00:07:20 -0700 (PDT)
Message-Id: <f08c90ea02f6811b310a01301acf46da133f38a9.1571209637.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.401.git.1571209637.gitgitgadget@gmail.com>
References: <pull.401.git.1571209637.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Oct 2019 07:07:17 +0000
Subject: [PATCH 2/2] git_path(): handle `.lock` files correctly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Ever since worktrees were introduced, the `git_path()` function _really_
needed to be called e.g. to get at the `index`. However, the wrong path
is returned for `index.lock`.

This does not matter as long as the Git executable is doing the asking,
as the path for that `index.lock` file is constructed from
`git_path("index")` by appending the `.lock` suffix.

However, Git GUI just learned to use `--git-path` instead of appending
relative paths to what `git rev-parse --git-dir` returns (and as a
consequence not only using the correct hooks directory, but also using
the correct paths in worktrees other than the main one). And one of the
paths it is looking for is... you guessed it... `index.lock`.

So let's make that work as script writers would expect it to.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 path.c               |  4 ++--
 t/t1500-rev-parse.sh | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/path.c b/path.c
index e3da1f3c4e..ff85692b45 100644
--- a/path.c
+++ b/path.c
@@ -268,7 +268,7 @@ static int trie_find(struct trie *root, const char *key, match_fn fn,
 	int result;
 	struct trie *child;
 
-	if (!*key) {
+	if (!*key || !strcmp(key, ".lock")) {
 		/* we have reached the end of the key */
 		if (root->value && !root->len)
 			return fn(key, root->value, baton);
@@ -288,7 +288,7 @@ static int trie_find(struct trie *root, const char *key, match_fn fn,
 
 	/* Matched the entire compressed section */
 	key += i;
-	if (!*key)
+	if (!*key || !strcmp(key, ".lock"))
 		/* End of key */
 		return fn(key, root->value, baton);
 
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 01abee533d..d318a1eeef 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -116,6 +116,21 @@ test_expect_success 'git-path inside sub-dir' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git-path in worktree' '
+	test_tick &&
+	git commit --allow-empty -m empty &&
+	git worktree add --detach wt &&
+	test_write_lines >expect \
+		"$(pwd)/.git/worktrees/wt/logs/HEAD" \
+		"$(pwd)/.git/worktrees/wt/logs/HEAD.lock" \
+		"$(pwd)/.git/worktrees/wt/index" \
+		"$(pwd)/.git/worktrees/wt/index.lock" &&
+	git -C wt rev-parse >actual \
+		--git-path logs/HEAD --git-path logs/HEAD.lock \
+		--git-path index --git-path index.lock &&
+	test_cmp expect actual
+'
+
 test_expect_success 'rev-parse --is-shallow-repository in shallow repo' '
 	test_commit test_commit &&
 	echo true >expect &&
-- 
gitgitgadget
