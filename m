Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1272ECAAD2
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 15:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiH2PM2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 11:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiH2PMS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 11:12:18 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED74A84EC8
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 08:12:06 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j26so4421347wms.0
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 08:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=AmBpF+luDAG/4AOSYnKvZhSPCdIyN9n6q5ReqcPRgYk=;
        b=Pgk2NgXHoUYwui4Jixda5J2Zvw8bV//uXkQg60Sd1QqWcg8IIRU4qjl3QfgT/87N2L
         Rm/T7dE+pIeKMnaF4PT9VtMmhTRGT4ebVFooo538QY71N27XZ8w5Rbb0xKc5DnlsYMru
         C9N+HhdaoF8HxCYtF+x2bwMIYVqs844+HtCjBx7KjUWLHW77Wa9oipg+wYYDbtj3EFz9
         5pT+AayificFVpjRKnwuqVoVNiPTWLbXuQnO9ODX8NcV2CdeCv0yRNXWMDc4+XpqHH4E
         DlQpjr0HNLbEDwUCwrWUaQilZaQbJvI0/t54ptLTIDbkTxT13NKRFFhrCNLffSvQFF0j
         WRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=AmBpF+luDAG/4AOSYnKvZhSPCdIyN9n6q5ReqcPRgYk=;
        b=cJmO4JO13hOsdIW0kuVy+gq5eSFHaloWQUuxV25vbupjSBDc2uhmlzcCby76yD5v7p
         r0pwe6rA3iQGyIsGr+Fv3FTNUjwDMWVCqajXfTEU6kPgbDY/kKHClo3jRefPr4sLJMCf
         sawVaV68NvAyy/zIWpS1SbaB5lnPSc7DQhrNNQJ0DXf7g4SPzVweA2NNUMUSUO/9FR12
         VrM+fPFZ3qK6q18ZuMogzheHc8BPxO+ly9awzRiMRjxkNH9yrkNo0ZeBl+FeXK0CKOdJ
         dcKfLmWVYRRYxLp7hwD61WFI8UMa/j++3YeX2C2Zo/jyn9Kt2EermINKhTRF/dWtNaVR
         +YwA==
X-Gm-Message-State: ACgBeo0UrbVQCiAQ0AchRQ2mMXuBss8FSGKoI185stnQBq/BJiCsdmNC
        iB4T1ADQJN6P1exhjGdCOVP3oouVzME=
X-Google-Smtp-Source: AA6agR5YWocVsc1bncLIRicaoQr2uowieGR3ck1uLyMV90Bf6fpd+N7PRuSrzoxb25++xeNQSNgSwQ==
X-Received: by 2002:a05:600c:4148:b0:3a5:4f94:577b with SMTP id h8-20020a05600c414800b003a54f94577bmr7284075wmm.167.1661785924976;
        Mon, 29 Aug 2022 08:12:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i15-20020a05600c400f00b003a54f1d007csm9444263wmm.10.2022.08.29.08.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 08:12:04 -0700 (PDT)
Message-Id: <cfa6914aee0d3ef84d726b97699f438fd4b254d9.1661785916.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
References: <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
        <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Aug 2022 15:11:56 +0000
Subject: [PATCH v3 5/5] add -p: ignore dirty submodules
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks to alwyas running `diff-index` and `diff-files` with the
`--numstat` option (the latter with `--ignore-submodules=dirty`) before
even generating any real diff to parse, the Perl version of `git add -p`
simply ignored dirty submodules and does not even offer them up for
staging.

However, the built-in variant did not use that flag because it tries to
run only one `diff` command, skipping the unneeded
`diff-index`/`diff-files` invocation of the Perl variant and therefore
only faithfully recapitulates what the Perl code does once it _does_
generate and parse the real diff.

This causes a problem when running the built-in `add -p` with
`diff-so-fancy` because that diff colorizer always inserts an empty line
before the diff header to ensure that it produces 4 lines as expected by
`git add -p` (the equivalent of the non-colorized `diff`, `index`, `---`
and `+++` lines). But `git diff-files` does not produce any `index` line
for dirty submodules.

The underlying problem is not even the discrepancy in lines, but that
`git add -p` presents diffs for dirty submodules: there is nothing that
_can_ be staged for those.

Let's fix that bug, and teach the built-in `add -p` to ignore dirty
submodules, too. This _incidentally_ also fixes the `diff-so-fancy`
problem ;-)

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c                |  3 ++-
 t/t3701-add-interactive.sh | 12 ++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/add-patch.c b/add-patch.c
index 0217cdd7c4a..ee6a3d3b712 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -426,7 +426,8 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	}
 	color_arg_index = args.nr;
 	/* Use `--no-color` explicitly, just in case `diff.color = always`. */
-	strvec_pushl(&args, "--no-color", "-p", "--", NULL);
+	strvec_pushl(&args, "--no-color", "--ignore-submodules=dirty", "-p",
+		     "--", NULL);
 	for (i = 0; i < ps->nr; i++)
 		strvec_push(&args, ps->items[i].original);
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 39e68b6d066..a4f45fc48a0 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -965,6 +965,18 @@ test_expect_success 'status ignores dirty submodules (except HEAD)' '
 	! grep dirty-otherwise output
 '
 
+test_expect_success 'handle submodules' '
+	echo 123 >>for-submodules/dirty-otherwise/initial.t &&
+
+	force_color git -C for-submodules add -p dirty-otherwise >output 2>&1 &&
+	grep "No changes" output &&
+
+	force_color git -C for-submodules add -p dirty-head >output 2>&1 <y &&
+	git -C for-submodules ls-files --stage dirty-head >actual &&
+	rev="$(git -C for-submodules/dirty-head rev-parse HEAD)" &&
+	grep "$rev" actual
+'
+
 test_expect_success 'set up pathological context' '
 	git reset --hard &&
 	test_write_lines a a a a a a a a a a a >a &&
-- 
gitgitgadget
