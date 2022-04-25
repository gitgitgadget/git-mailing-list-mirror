Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2349C433F5
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 17:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244069AbiDYRwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 13:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244081AbiDYRwd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 13:52:33 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F4227FE7
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 10:49:24 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m15-20020a7bca4f000000b0038fdc1394b1so2311wml.2
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 10:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LluslZKvEbFBFR4oqBEKbFKd/+jnft1f6FxdURLlUJM=;
        b=D4y7BtYtjB5NyGis4kq4jur3x/4RAbrQkyZVWT9jw6LsQdVnqoVlK1z9/v2Sj5wEAw
         kvHaxyz8yD3fyBbAGs2PTnBpqobNpMUY070JiJaiWoDc2Rh3IsV6h934HUQLEJMfiENw
         dPPmEjN3HS5CkkCCJenGf7lEbbPcnEcs4kTOaEi0C6A8ZIMrDXwhCJFDVcTRiWjcKmJ/
         l8fP926/tpPxmjCjxCRAfAneUSDldxXTaRqd/PhR0S7SZEis53fk+5TlEXVi9nhvO6AB
         V1dUdgkvVdDs8iX5jTYTzTGWTv4GE0n3avjTwu39qAkhDQP4CUDw0hzYjq0LGJ/sq0iQ
         yDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LluslZKvEbFBFR4oqBEKbFKd/+jnft1f6FxdURLlUJM=;
        b=VBVhRheKvbOdf+IPIXs2QDhQy9L5I9+y4S/8jOKP2NlBmVu3pfA9u2iRfA/8PWrtYJ
         iq8LU/HJihmHcmhLaZI1W+oVAln6aJwXRGSHdHzs+2zXDQqO+x0InQIGhtsKfBgETJzA
         ct4SV6VyNzt8kQXJfdbSaKe517lQBJfL1VZn1cpW/HAL7lT8OshXrISlcdth9uXhm1wM
         SUz6jSfC5HVTYiYG6cWRv1Nw2xq50MvMeRF1i5wPBsKU+MuRFLp/cBWDVi2kEn3weGcK
         bcVELf/aipFg3odDbfJ85paOlwBsU6oSRkJQlRiU2YWOIti/qOQkErJNB1yWN8OZg9m7
         ESJw==
X-Gm-Message-State: AOAM530mebAUa1Zg2Y5K4Q1TiR6Y+2TWDHqDFCV9ovrxys7aAY0Hk+GC
        WUephKMT5a3RiwP7asTMpj6SHuDq7mM=
X-Google-Smtp-Source: ABdhPJwpM+AH2FsaB+aBQKFnvxgpSVwLzoFHg67xj/S9JHwUW+2IBbgeGdm+C0MzdqpX1TdLNGNQ9w==
X-Received: by 2002:a05:600c:3ca3:b0:392:990b:af11 with SMTP id bg35-20020a05600c3ca300b00392990baf11mr17602620wmb.173.1650908962736;
        Mon, 25 Apr 2022 10:49:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u5-20020a5d6da5000000b0020a880e5e9fsm9405998wrs.29.2022.04.25.10.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 10:49:22 -0700 (PDT)
Message-Id: <f6cf05a5bee9e4ebc174bab0385a13cc1cdb4014.1650908958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
References: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Apr 2022 17:49:12 +0000
Subject: [PATCH 2/7] stash: integrate with sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Enable sparse index in 'git stash' by disabling
'command_requires_full_index'.

With sparse index enabled, some subcommands of 'stash' work without
expanding the index, e.g., 'git stash', 'git stash list', 'git stash drop',
etc. Others ensure the index is expanded either directly (as in the case of
'git stash [pop|apply]', where the call to 'merge_recursive_generic()' in
'do_apply_stash()' triggers the expansion), or in a command called
internally by stash (e.g., 'git update-index' in 'git stash -u'). So, in
addition to enabling sparse index, add tests to 't1092' demonstrating which
variants of 'git stash' expand the index, and which do not.

Finally, add the option to skip writing 'untracked.txt' in
'ensure_not_expanded', and use that option to successfully apply stashed
untracked files without a conflict in 'untracked.txt'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/stash.c                          |  3 ++
 t/t1092-sparse-checkout-compatibility.sh | 45 +++++++++++++++++++-----
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 0c7b6a95882..1bfba532044 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1770,6 +1770,9 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, git_stash_usage,
 			     PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	index_file = get_index_file();
 	strbuf_addf(&stash_index_path, "%s.stash.%" PRIuMAX, index_file,
 		    (uintmax_t)pid);
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index baf95906729..b00c65c7770 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1271,7 +1271,10 @@ test_expect_success 'index.sparse disabled inline uses full index' '
 
 ensure_not_expanded () {
 	rm -f trace2.txt &&
-	echo >>sparse-index/untracked.txt &&
+	if test -z $WITHOUT_UNTRACKED_TXT
+	then
+		echo >>sparse-index/untracked.txt
+	fi &&
 
 	if test "$1" = "!"
 	then
@@ -1314,14 +1317,6 @@ test_expect_success 'sparse-index is not expanded' '
 	echo >>sparse-index/untracked.txt &&
 	ensure_not_expanded add . &&
 
-	ensure_not_expanded checkout-index -f a &&
-	ensure_not_expanded checkout-index -f --all &&
-	for ref in update-deep update-folder1 update-folder2 update-deep
-	do
-		echo >>sparse-index/README.md &&
-		ensure_not_expanded reset --hard $ref || return 1
-	done &&
-
 	ensure_not_expanded reset --mixed base &&
 	ensure_not_expanded reset --hard update-deep &&
 	ensure_not_expanded reset --keep base &&
@@ -1375,6 +1370,38 @@ test_expect_success 'sparse-index is not expanded: merge conflict in cone' '
 	)
 '
 
+test_expect_success 'sparse-index is not expanded: stash' '
+	init_repos &&
+
+	echo >>sparse-index/a &&
+	ensure_not_expanded stash &&
+	ensure_not_expanded stash list &&
+	ensure_not_expanded stash show stash@{0} &&
+	! ensure_not_expanded stash apply stash@{0} &&
+	ensure_not_expanded stash drop stash@{0} &&
+
+	echo >>sparse-index/deep/new &&
+	! ensure_not_expanded stash -u &&
+	(
+		WITHOUT_UNTRACKED_TXT=1 &&
+		! ensure_not_expanded stash pop
+	) &&
+
+	ensure_not_expanded stash create &&
+	oid=$(git -C sparse-index stash create) &&
+	ensure_not_expanded stash store -m "test" $oid &&
+	ensure_not_expanded reset --hard &&
+	! ensure_not_expanded stash pop &&
+
+	ensure_not_expanded checkout-index -f a &&
+	ensure_not_expanded checkout-index -f --all &&
+	for ref in update-deep update-folder1 update-folder2 update-deep
+	do
+		echo >>sparse-index/README.md &&
+		ensure_not_expanded reset --hard $ref || return 1
+	done
+'
+
 test_expect_success 'sparse index is not expanded: diff' '
 	init_repos &&
 
-- 
gitgitgadget

