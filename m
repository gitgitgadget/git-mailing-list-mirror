Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB340C433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 03:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiKCDaF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 23:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKCD3r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 23:29:47 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB83140EC
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 20:29:46 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o4so836759wrq.6
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 20:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wL971EsyNhMF0S4tHGcTxVLpvX7OV/46WnknqDT367g=;
        b=X7JvGF4M+N7OeVAFiEb1LSTVITrfcw4Dt6pfabcWaJ+CckbTYgYFmLWAJTIikCKUfR
         lkIqz4hV0bBfk+nWFKBGev8z95SY72Ght9VHWJK6xavIsP+Gz+YXNvxQ07W4RIDKC+JT
         nHfpRQ7qr4xfUwqSVLIn3zlTIRE1qEKXWdLqkAUkSOlC6qJyla53BMdlf930tHzgTROG
         M1ss19moOMPxiyyTgamoHr/whKxG/MFwzmP7ebyepQTcttb+d2ENzgzSRKepRZN/MWdM
         S04GAMg4q6Igsae/OZEKsn264nMAJp+ODje9R9KaijWkUQo/UINHhBNSGUuexUEucb9m
         LwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wL971EsyNhMF0S4tHGcTxVLpvX7OV/46WnknqDT367g=;
        b=SAUnlDRrtQVg7Zo5v16jFDxzJuPExKgz4bUxUx8zoF7/9D+E6A/yQMB0q1q02vS32+
         GhzX459CrC16EQd8EnvcJzx2zm8a4A2/QhzjZbGit3oX4nVjcj5lBhDj3P0++LIC04cs
         ZhBJPuDztTr/2sVqkcLBnrLYgLHwt+672srbNLFfOZNK6Bnjez3+DHrFVemoFLEOlxtp
         Ik6Dwhad7Ha3FO/joePNidF3BtJckEpH2axTaf2RGQZuoIQET1LccpuqCjGfnSVROyb+
         MeKNMNtIGkub9/xqNv358o6Pq5rT173Vlvxeka3d3gOCPTPbqmzf/u804gIAIK39MQH5
         oRHQ==
X-Gm-Message-State: ACrzQf21R1Y+mzQCBLRT0OhA5cQY0iX6Hs2xuJMw8zXjKJit4oEUg2U8
        CTIT4ONXkW//QVAWVms9DcCNHz3tQ8g=
X-Google-Smtp-Source: AMsMyM7Ux2l8sIDW6vYClnr5VkRh+O9Mr2UfQ6rWKvSuWGlhx+TSaAeJAKXIMHFYxg9FIA3AU+1qXA==
X-Received: by 2002:a05:6000:408b:b0:238:238:513d with SMTP id da11-20020a056000408b00b002380238513dmr1730856wrb.536.1667446185039;
        Wed, 02 Nov 2022 20:29:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x16-20020a5d4450000000b0022a3a887ceasm14433184wrr.49.2022.11.02.20.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 20:29:44 -0700 (PDT)
Message-Id: <3bdfad03ccade6527bbe74b62ef166df3fcdc13d.1667446182.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1397.v5.git.1667446182.gitgitgadget@gmail.com>
References: <pull.1397.v4.git.1667292904.gitgitgadget@gmail.com>
        <pull.1397.v5.git.1667446182.gitgitgadget@gmail.com>
From:   "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Nov 2022 03:29:42 +0000
Subject: [PATCH v5 2/2] merge-tree.c: allow specifying the merge-base when
 --stdin is passed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, kylezhao <kylezhao@tencent.com>,
        Taylor Blau <me@ttaylorr.com>,
        Kyle Zhao <kylezhao@tencent.com>,
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
 Documentation/git-merge-tree.txt | 14 +++++++++++++-
 builtin/merge-tree.c             | 21 +++++++++++++++++++--
 t/t4301-merge-tree-write-tree.sh | 25 +++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 3 deletions(-)

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
index 5b0073d3dcd..03bb1cb8685 100755
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
@@ -890,4 +897,22 @@ test_expect_success 'specify merge-base as parent of branch2' '
 	)
 '
 
+# Since the earlier tests have verified that individual merge-tree calls
+# are doing the right thing, this test case is only used to test whether
+# the input format is available.
+
+test_expect_success '--stdin with both a normal merge and a merge-base specified merge' '
+	cd base-b2-p &&
+	printf "c1 c3\nc2 -- c1 c3" | git merge-tree --stdin >actual &&
+
+	printf "1\0" >expect &&
+	git merge-tree --write-tree -z c1 c3 >>expect &&
+	printf "\0" >>expect &&
+
+	printf "1\0" >>expect &&
+	git merge-tree --write-tree -z --merge-base=c2 c1 c3 >>expect &&
+	printf "\0" >>expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget
