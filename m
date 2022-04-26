Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E04C433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 20:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355124AbiDZUqj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 16:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355112AbiDZUqf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 16:46:35 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA71213BD5C
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 13:43:26 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i5so8015541wrc.13
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 13:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gYlLzFMHqODA8gTlaQ/jbLsyHtI/RYrbZiZNYlxIPPI=;
        b=HUrMyxSj0GlzMSdx7ZtMP9sUEXwDAk3FNTAOfiAzC6/KikPabfrgL1Y+gYftvUqTvz
         zguQvjCxTItpspS4F0rjoH8k9n4fukxyh/KfMlYdFFH71MjHFRo7taJIcbqpVczkLJUG
         i57Rju9OpicA7UPmASieCKwkyMUgxCuBqiDEcff7t8yGnCmIa/dWU2BqpE+UmgS/8b9n
         L3yOJHdvxtJA4SDY60URpSUKI6C+eEqI0E3GSS6PE2gim3alUILjQd0Lxs4USHhU075T
         bKAtrZgiif3+Qh7gNa8IIjIS16zW0L1aJdI9Czccbjx4p4Pj+Gv37ou+KQ+Rs3Vf9+J7
         oHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gYlLzFMHqODA8gTlaQ/jbLsyHtI/RYrbZiZNYlxIPPI=;
        b=wcneqYZYSizxboQ4cYfsgxfn69i5qWcyVAqD916pfcHmM7Ux7VYz7L/YOLdzByEduc
         YXh7/vj3KDAuOFuyh8dfyvyiQx04gLC6nLmTHcR9lHGmCLiO0BOwfzNGiU+6ecycEdzc
         DKdDMH6YM2UPly92BIjinjfQGi/uLTSBHxAw+m4CwPkjNJonclkL3ou+mkbDma4VJELu
         N2rJJ2KITJBBvm8lFhXiilCmz+Ut9i/2XAhl/ob9J88/1UF+jjinhByUVKBnN58BM1Fe
         H5SA52gRw7glSaCvh1utRHT2PM+vaciiWbsb3z3HQxemU/Agadn2jKFhv5hCWJVr165o
         lXLw==
X-Gm-Message-State: AOAM530ht83AxYGQH4j2yCiEH5A0Vqwt6V65O7CWR/cZ/4A1A+U7qmkF
        xQMjft7bViXw/R/irPP5pNwqh8YQgDE=
X-Google-Smtp-Source: ABdhPJys7Alq6fwBs842i066mPMODuBDPrAXZdUoKOJluYzy67fP7TBvP3ln9dnLQE7Cv1zWxG1vkg==
X-Received: by 2002:a5d:4311:0:b0:205:f439:cbf0 with SMTP id h17-20020a5d4311000000b00205f439cbf0mr20187817wrq.164.1651005805050;
        Tue, 26 Apr 2022 13:43:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r14-20020a0560001b8e00b00205918bd86esm12231608wru.78.2022.04.26.13.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:43:24 -0700 (PDT)
Message-Id: <5a7561637f0d845df23b47c9bed2ba74bbc5f07c.1651005800.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1207.v2.git.1651005800.gitgitgadget@gmail.com>
References: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
        <pull.1207.v2.git.1651005800.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Apr 2022 20:43:18 +0000
Subject: [PATCH v2 3/5] object-name: reject trees found in the index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Philip Oakley <philipoakley@iee.email>,
        Josh Steadmon <steadmon@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The get_oid_with_context_1() method is used when parsing revision
arguments. One particular case is to take a ":<path>" string and search
the index for the given path.

In the case of a sparse index, this might find a sparse directory entry,
in which case the contained object is a tree. In the case of a full
index, this search within the index would fail.

In order to maintain identical return state as in a full index, inspect
the discovered cache entry to see if it is a sparse directory and reject
it. This requires being careful around the only_to_die option to be sure
we die only at the correct time.

This changes the behavior of 'git show :<sparse-dir>', but does not
bring it entirely into alignment with a full index case. It specifically
hits the wrong error message within diagnose_invalid_index_path(). That
error message will be corrected in a future change.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 object-name.c                            | 19 ++++++++++++++++++-
 t/t1092-sparse-checkout-compatibility.sh | 11 ++---------
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/object-name.c b/object-name.c
index f0e327f91f5..2dc5d2549b8 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1881,6 +1881,20 @@ static char *resolve_relative_path(struct repository *r, const char *rel)
 			   rel);
 }
 
+static int reject_tree_in_index(struct repository *repo,
+				int only_to_die,
+				const struct cache_entry *ce,
+				int stage,
+				const char *prefix,
+				const char *cp)
+{
+	if (!S_ISSPARSEDIR(ce->ce_mode))
+		return 0;
+	if (only_to_die)
+		diagnose_invalid_index_path(repo, stage, prefix, cp);
+	return -1;
+}
+
 static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 				  const char *name,
 				  unsigned flags,
@@ -1955,9 +1969,12 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			    memcmp(ce->name, cp, namelen))
 				break;
 			if (ce_stage(ce) == stage) {
+				free(new_path);
+				if (reject_tree_in_index(repo, only_to_die, ce,
+							 stage, prefix, cp))
+					return -1;
 				oidcpy(oid, &ce->oid);
 				oc->mode = ce->ce_mode;
-				free(new_path);
 				return 0;
 			}
 			pos++;
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 3506c0216f0..08c9cfd359e 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1165,15 +1165,8 @@ test_expect_success 'show (cached blobs/trees)' '
 	test_must_fail git -C full-checkout show :folder1/ &&
 	test_must_fail git -C sparse-checkout show :folder1/ &&
 
-	git -C sparse-index show :folder1/ >actual &&
-	git -C full-checkout show HEAD:folder1 >expect &&
-
-	# The output of "git show" includes the way we referenced the
-	# objects, so strip that out.
-	test_line_count = 4 actual &&
-	tail -n 2 actual >actual-trunc &&
-	tail -n 2 expect >expect-trunc &&
-	test_cmp expect-trunc actual-trunc
+	test_must_fail git -C sparse-index show :folder1/ 2>err &&
+	grep "is in the index, but not at stage 0" err
 '
 
 test_expect_success 'submodule handling' '
-- 
gitgitgadget

