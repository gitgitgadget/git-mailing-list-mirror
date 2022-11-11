Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F104C433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 23:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbiKKXp0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 18:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbiKKXpV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 18:45:21 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947496DCCE
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 15:45:19 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id g12so8241883wrs.10
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 15:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gePnx+tdJ4FcL2JiqcdzEAYDdvSh/EQf3uHbUL1YGRY=;
        b=ir+UHOyThFWQjPJvdCC74vlJcDXgNmyPQH2oeL+v7cZCU70gROsJu+wrJQw+7Iost8
         kjbtQ4rCrbNzqDXSLYbUyAEYBAFMsozKDKLPpbjv6ycRqn5uHviBkboLHkqQwF7IInHX
         3O6OCaX2KTGDJgpksBW/mqNpRC0TER2a8imrNHYwwhEz2fPkDQV0W3HNxxeIYh0+goxB
         F+pRcWtrc0xx+scNxU6qyCFj8bxydPWTGvo4cDnF9m6gonxNOUMa5T1VTC7QssIaPRsq
         q73yN1P2SXE7cV4s+ovy6TmBstSEAvZ3ONF68FRqDoJHdaAYGfvYaK1YMmXbSK/Q4bGR
         h1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gePnx+tdJ4FcL2JiqcdzEAYDdvSh/EQf3uHbUL1YGRY=;
        b=dBPZpn2fQSSWeZ2qnQlBXJQdEYFY1jxYxuXTtdMaycuM8gVzEU0OZ+YjZV5nCtEmBp
         GO9CdxOjJN0pwTBorzi0NilaCdypt93y003Ld6RpQOEcrlC2DvOv/GweE0R52dzIGCUU
         zPg5Fg9ZCrABvgigVYNJ+egMSJrSGJcUtdnQkJQMERzKG+ehGWXNLH1hw00qaDBuTvlb
         i546GeFq//gbLqvBziwhyc3VHEfy/wh2sr6rgGma0vCcU2TRYG9fUvMreehAED+OAky9
         UrQM7dnWyEHKL8kojVzrQvcxfF4AN3Y2KqLPzYDd5YIv7CXrqJvw9LKUky7fquinSO0B
         IooQ==
X-Gm-Message-State: ANoB5ploAr8SeVt5vyS2X4wRoCoAuQ0DPzHhXwOwY/TciXfbQAwpEhk2
        BUbf4Z1LO1F43gRhnFx7/Oq3Pm+0O3o=
X-Google-Smtp-Source: AA0mqf6rzuNnXYhbxoFeQLcgXtFuZM1LM55fg9Vz2JnOodizQYXm5tUMlZwbY4IwzrERnJhKFHMn7g==
X-Received: by 2002:adf:e0c5:0:b0:236:6f90:3e55 with SMTP id m5-20020adfe0c5000000b002366f903e55mr2435117wri.374.1668210317871;
        Fri, 11 Nov 2022 15:45:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p2-20020a7bcc82000000b003b50428cf66sm4351802wma.33.2022.11.11.15.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 15:45:17 -0800 (PST)
Message-Id: <48e55d4e97cfddee25e1cd5dd662c4f93a59b460.1668210315.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1397.v7.git.1668210314.gitgitgadget@gmail.com>
References: <pull.1397.v6.git.1667472621.gitgitgadget@gmail.com>
        <pull.1397.v7.git.1668210314.gitgitgadget@gmail.com>
From:   "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Nov 2022 23:45:14 +0000
Subject: [PATCH v7 2/2] merge-tree.c: allow specifying the merge-base when
 --stdin is passed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, kylezhao <kylezhao@tencent.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Kyle Zhao <kylezhao@tencent.com>,
        Kyle Zhao <kylezhao@tencent.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kyle Zhao <kylezhao@tencent.com>

The previous commit added a `--merge-base` option in order to allow
using a specified merge-base for the merge.  Extend the input accepted
by `--stdin` to also allow a specified merge-base with each merge
requested.  For example:

    printf "<b3> -- <b1> <b2>" | git merge-tree --stdin

does a merge of b1 and b2, and uses b3 as the merge-base.

Signed-off-by: Kyle Zhao <kylezhao@tencent.com>
---
 Documentation/git-merge-tree.txt | 14 ++++++++++++-
 builtin/merge-tree.c             | 21 +++++++++++++++++--
 t/t4301-merge-tree-write-tree.sh | 35 ++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index d9dacb2ce54..298c133fdb6 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -66,7 +66,8 @@ OPTIONS
 
 --merge-base=<commit>::
 	Instead of finding the merge-bases for <branch1> and <branch2>,
-	specify a merge-base for the merge.
+	specify a merge-base for the merge. This option is incompatible
+	with `--stdin`.
 
 [[OUTPUT]]
 OUTPUT
@@ -220,6 +221,17 @@ with linkgit:git-merge[1]:
   * any messages that would have been printed to stdout (the
     <<IM,Informational messages>>)
 
+INPUT FORMAT
+------------
+'git merge-tree --stdin' input format is fully text based. Each line
+has this format:
+
+	[<base-commit> -- ]<branch1> <branch2>
+
+If one line is separated by `--`, the string before the separator is
+used for specifying a merge-base for the merge and the string after
+the separator describes the branches to be merged.
+
 MISTAKES TO AVOID
 -----------------
 
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 62c6d43cdb9..330f779e8bc 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -557,12 +557,29 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 		while (strbuf_getline_lf(&buf, stdin) != EOF) {
 			struct strbuf **split;
 			int result;
+			const char *input_merge_base = NULL;
 
 			split = strbuf_split(&buf, ' ');
-			if (!split[0] || !split[1] || split[2])
+			if (!split[0] || !split[1])
 				die(_("malformed input line: '%s'."), buf.buf);
 			strbuf_rtrim(split[0]);
-			result = real_merge(&o, merge_base, split[0]->buf, split[1]->buf, prefix);
+			strbuf_rtrim(split[1]);
+
+			/* parse the merge-base */
+			if (!strcmp(split[1]->buf, "--")) {
+				input_merge_base = split[0]->buf;
+			}
+
+			if (input_merge_base && split[2] && split[3] && !split[4]) {
+				strbuf_rtrim(split[2]);
+				strbuf_rtrim(split[3]);
+				result = real_merge(&o, input_merge_base, split[2]->buf, split[3]->buf, prefix);
+			} else if (!input_merge_base && !split[2]) {
+				result = real_merge(&o, NULL, split[0]->buf, split[1]->buf, prefix);
+			} else {
+				die(_("malformed input line: '%s'."), buf.buf);
+			}
+
 			if (result < 0)
 				die(_("merging cannot continue; got unclean result of %d"), result);
 			strbuf_list_free(split);
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 6db96ccbaae..a8983a0edcb 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -860,6 +860,13 @@ test_expect_success '--stdin with both a successful and a conflicted merge' '
 	test_cmp expect actual
 '
 
+
+test_expect_success '--merge-base is incompatible with --stdin' '
+	test_must_fail git merge-tree --merge-base=side1 --stdin 2>expect &&
+
+	grep "^fatal: --merge-base is incompatible with --stdin" expect
+'
+
 # specify merge-base as parent of branch2
 # git merge-tree --write-tree --merge-base=c2 c1 c3
 #   Commit c1: add file1
@@ -887,4 +894,32 @@ test_expect_success 'specify merge-base as parent of branch2' '
 	test_cmp expect actual
 '
 
+# Since the earlier tests have verified that individual merge-tree calls
+# are doing the right thing, this test case is only used to verify that
+# we can also trigger merges via --stdin, and that when we do we get
+# the same answer as running a bunch of separate merges.
+
+test_expect_success 'check the input format when --stdin is passed' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_commit -C repo c1 &&
+	test_commit -C repo c2 &&
+	test_commit -C repo c3 &&
+	printf "c1 c3\nc2 -- c1 c3\nc2 c3" | git -C repo merge-tree --stdin >actual &&
+
+	printf "1\0" >expect &&
+	git -C repo merge-tree --write-tree -z c1 c3 >>expect &&
+	printf "\0" >>expect &&
+
+	printf "1\0" >>expect &&
+	git -C repo merge-tree --write-tree -z --merge-base=c2 c1 c3 >>expect &&
+	printf "\0" >>expect &&
+
+	printf "1\0" >>expect &&
+	git -C repo merge-tree --write-tree -z c2 c3 >>expect &&
+	printf "\0" >>expect &&
+
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget
