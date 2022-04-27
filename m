Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41F1C433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 18:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244680AbiD0STm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 14:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236073AbiD0STh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 14:19:37 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B238654F
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 11:16:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r11-20020a05600c35cb00b0039409c1111bso741879wmq.3
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 11:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=udkS8dA54x7bIimMz0F9qvNG6TEGzzvh+7UbZZKzdNw=;
        b=o2HL0tqzcfm+oUeUYckL2qOF20Kfds45JK0bfdGIZyG07xAhHn87s5ghfqt9iWNpfn
         G2ZEcELm3HOiQDGIxAqhICbW531Ikura7buxrpZ0JopoZN82HXNqxtg1ymoTvj+6nMBV
         PUHhkUCIf6XdPtiFol3ROF2LO6NcpJZuQeqTN6nvGItC0KuGEG1je8WvSnn7yiCfGUQ8
         aiJ+8A5tnI+dEh3XdtRyhjTzG9mOW1smSiQGu6c+9UUQL1+eUT0KpbnI0UZEXfHbawwl
         Du/It32uY/MZ+qNPB+pUOjajAPYg6IYdElUW95sSMNlO0xDY2bag6LQ/YV23LNPlqvZ+
         VGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=udkS8dA54x7bIimMz0F9qvNG6TEGzzvh+7UbZZKzdNw=;
        b=vesBwifkpA4DkvI5rW3R12Un6ZWrnzW84SOUNgtAv/+S6L4/swkt5kRyKT3a/6j9At
         lGVeM8FL1z9uANqvc1oSsr0Z4resHEL6vJAGBOJoHeMDM3L69BON1/m4F0ftXWYHvTOA
         +A+tCGUKDwbCRIZ1FKV3r2R6DqNMgul1kPzmDe9PoifXD99OJZPUaHOUrd6hZsrenaa8
         ExJgX3KlNUlN2r79d5CtxrOoHUR92/pL900QWpUo4lVHhwIIRgUOaFdUpNiZLMeFLFG0
         WARGbcWirRojGGglS85oRxoawBE+4w8NN4nGIczKnHJQV2XRSDJydp5zQWoM8NoHNOoM
         F8RQ==
X-Gm-Message-State: AOAM53227S3gaygINlnLy2DzWUpRP7JspoiAaOM14d3lmYOlULZjy2kY
        EM1WeGWU4Pnf585wO7833DhGwoKVElY=
X-Google-Smtp-Source: ABdhPJwG4qRPwewziGI0V54LyEAvtXHRBVT6Y7ieRawvgZxs0bSA8LGybKHKtKaK+At8uQqTnTgTDQ==
X-Received: by 2002:a05:600c:3ac5:b0:393:ed74:86a6 with SMTP id d5-20020a05600c3ac500b00393ed7486a6mr13319420wms.142.1651083383653;
        Wed, 27 Apr 2022 11:16:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c4ed200b00393e810038esm2266763wmq.34.2022.04.27.11.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:16:22 -0700 (PDT)
Message-Id: <b3e3f0298fb99b9aecc26271eee6fb6eab842dd9.1651083378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com>
References: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
        <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Apr 2022 18:16:13 +0000
Subject: [PATCH v2 2/7] stash: integrate with sparse index
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
 builtin/stash.c                          |  3 +++
 t/t1092-sparse-checkout-compatibility.sh | 29 +++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

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
index 86312b30444..75d844cd71d 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1271,7 +1271,10 @@ test_expect_success 'index.sparse disabled inline uses full index' '
 
 ensure_not_expanded () {
 	rm -f trace2.txt &&
-	echo >>sparse-index/untracked.txt &&
+	if test -z "$WITHOUT_UNTRACKED_TXT"
+	then
+		echo >>sparse-index/untracked.txt
+	fi &&
 
 	if test "$1" = "!"
 	then
@@ -1375,6 +1378,30 @@ test_expect_success 'sparse-index is not expanded: merge conflict in cone' '
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
+	! ensure_not_expanded stash pop
+'
+
 test_expect_success 'sparse index is not expanded: diff' '
 	init_repos &&
 
-- 
gitgitgadget

