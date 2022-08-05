Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CD4C25B07
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 17:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241559AbiHER7C (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 13:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240806AbiHER66 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 13:58:58 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D6E74DE3
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 10:58:53 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j7so4068429wrh.3
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 10:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=9VJysiZs7rOwAsn34w2WMuGY6gBsjmTpKeQONCtqN08=;
        b=Pgt3+lhY4yYwkvOTn3ME46kv9Ihf5AdMHJ2cvijvY0wUcsRVnMrtP4p+6f2D0A6zmA
         R+LAoOaPgGg5ZDs5LHuYMdMDf/P5gJKi6FuH0pl5MgAUg/I3dj9oxbcxhcQIMbLdBis7
         OBISd7Y84xwiAgnLNVSM8XgiwUXchjUkUQikt5UV/29zbyjf2i2+YEwSLzxNIX49A/uh
         8ACeyaMwed+yEAUQvnn92+WdqZ4Fvv+PHsUm2r2Qsmph+vaxJHrjf9H3h0EkJb9hKzey
         k+/4sZKKuMnEqnflvKfpNFZ+VJr5S6qNTxgoqa6xFcy2mdcmLebApD2AbX/y5Wb+4gA+
         TqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=9VJysiZs7rOwAsn34w2WMuGY6gBsjmTpKeQONCtqN08=;
        b=NOXJFex6GXkg0kzx4KuxAY4W66eutx9F9gK4A8cIlEatSf/MYuR22CPRHNW7XHNhX9
         LIvVrffl0u2BpDkHe26227n+mvg+9+PPnEaHcwOJq+QnMX+kgX11ikXxaQ6qXBnuFMDN
         u+CFzsK++N8/xSeEOYzRBIcwYs4zYQqPw7R37ftTa2GYkkR+9e7rQrD2M71A8Vt4BLaM
         CnUX/sLdnVGuXgjFG9O2jn66cXYmQAn2JUhNKm0tddMm/CP9R2soJ6BqqoDML30WuYm+
         YQcPf34JfJCe8rxEoeOyros5b1Fc3BDua+nWEZ8w9UqdimgJZ/eWGro9L3jPzWFnf8nA
         vqlA==
X-Gm-Message-State: ACgBeo0wi6WxDgJpR5H0Pq/ozlORP/5gxJEi+32kPHiz36n2R04iT5Vk
        fy3n+xuaeCZLOpM19wfN5ZPoUfuEm6Q=
X-Google-Smtp-Source: AA6agR458DYp66j88dq7iyoaGI6BBGxL3GUhOzhEFhyb0fCRRm6gRwUX0mCEHrppMz8pbK2Hy6Y5Rw==
X-Received: by 2002:a5d:5989:0:b0:221:7c34:3943 with SMTP id n9-20020a5d5989000000b002217c343943mr1273334wri.441.1659722331842;
        Fri, 05 Aug 2022 10:58:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e12-20020adfa44c000000b0021e5cc26dd0sm4425402wra.62.2022.08.05.10.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:58:50 -0700 (PDT)
Message-Id: <0633f8403dbb425bd942458cf7ee5423c29a403f.1659722324.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>
References: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
        <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Aug 2022 17:58:34 +0000
Subject: [PATCH v3 02/11] t4207: modernize test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Before adding new tests to t4207-log-decoration-colors.sh, update the
existing test to use modern test conventions. This includes:

1. Use lowercase in test names.

2. Keep all test setup inside the test_expect_success blocks. We need
   to be careful about left whitespace in the broken lines of the input
   file.

3. Do not use 'git' commands on the left side of a pipe.

4. Create a cmp_filtered_decorations helper to perform the 'log', 'sed',
   and test_decode_color manipulations. Move the '--all' option to be an
   argument so we can change that value in future tests.

5. Modify the 'sed' command to use a simpler form that is more
   portable.

The next change will introduce new tests usinge these new conventions.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t4207-log-decoration-colors.sh | 37 +++++++++++++++++---------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index 36ac6aff1e4..324412d0839 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2010 Nazri Ramliy
 #
 
-test_description='Test for "git log --decorate" colors'
+test_description='test "git log --decorate" colors'
 
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
@@ -42,25 +42,28 @@ test_expect_success setup '
 	git stash save Changes to A.t
 '
 
-cat >expected <<EOF
-${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD ->\
- ${c_reset}${c_branch}main${c_reset}${c_commit},\
- ${c_reset}${c_tag}tag: v1.0${c_reset}${c_commit},\
- ${c_reset}${c_tag}tag: B${c_reset}${c_commit})${c_reset} B
-${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A1${c_reset}${c_commit},\
- ${c_reset}${c_remoteBranch}other/main${c_reset}${c_commit})${c_reset} A1
-${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_stash}refs/stash${c_reset}${c_commit})${c_reset}\
- On main: Changes to A.t
-${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
-EOF
+cmp_filtered_decorations () {
+	sed "s/$OID_REGEX/COMMIT_ID/" actual | test_decode_color >filtered &&
+	test_cmp expect filtered
+}
 
 # We want log to show all, but the second parent to refs/stash is irrelevant
 # to this test since it does not contain any decoration, hence --first-parent
-test_expect_success 'Commit Decorations Colored Correctly' '
-	git log --first-parent --abbrev=10 --all --decorate --oneline --color=always |
-	sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" |
-	test_decode_color >out &&
-	test_cmp expected out
+test_expect_success 'commit decorations colored correctly' '
+	cat >expect <<-EOF &&
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD -> \
+${c_reset}${c_branch}main${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: v1.0${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: B${c_reset}${c_commit})${c_reset} B
+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A1${c_reset}${c_commit}, \
+${c_reset}${c_remoteBranch}other/main${c_reset}${c_commit})${c_reset} A1
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_stash}refs/stash${c_reset}${c_commit})${c_reset} \
+On main: Changes to A.t
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
+	EOF
+
+	git log --first-parent --no-abbrev --decorate --oneline --color=always --all >actual &&
+	cmp_filtered_decorations
 '
 
 test_done
-- 
gitgitgadget

