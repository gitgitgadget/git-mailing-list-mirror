Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3428FC433F5
	for <git@archiver.kernel.org>; Tue, 10 May 2022 23:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237697AbiEJXcr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 19:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbiEJXck (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 19:32:40 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7351D5007
        for <git@vger.kernel.org>; Tue, 10 May 2022 16:32:39 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id q20so242318wmq.1
        for <git@vger.kernel.org>; Tue, 10 May 2022 16:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=udkS8dA54x7bIimMz0F9qvNG6TEGzzvh+7UbZZKzdNw=;
        b=TrNl9J2qRUmmCqm+Q7bYWmtXjW7MvMobjUyHRyKzVXDQUs2KkwoqCPzhxp6zwRWU9f
         EsBwCUcE0fwtVmWgt/7ldElcHHVsZLm2NgnByDnAvKE+8MtBTm5znx8q67ZVPQ4mQvhp
         Yg3qHygku1+SwwRSHzUybNA+otI369Gcs9fUql1P5fXYunx5X2nHRaxusxdmkKrxTDkM
         j0we1htCthRlelfqXSTI67ROVbmGvSGBofL5c6HHVti2IugHw+FdkMqeo/DBbw57HU3S
         DOz6NF2qsHhwXMasA/2T2jgC+XqEx5ORjY/r6zp0DQX8ZV/rq/euLiXGkrdEQg26BEcP
         IHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=udkS8dA54x7bIimMz0F9qvNG6TEGzzvh+7UbZZKzdNw=;
        b=wLDTGmKN3j9A77XYAhiOA372vj0dMQcUSp+6Bsf3hrZpL2So3dKhTkG9I2Xw+Air0r
         ZFlKQb4hHs1aYVHHS5ZBaGQ8Z61g5wT991xxp3K8aFK+sjZ3DdsR78w809Z06U43B8Jo
         kyQzIwlaq1N23BHbiKYRQOI862joioVDeWCx1XUTBVUpkDtTEouOtPI+vyI5s6Gkvxae
         CdoUyCNSPQ4HmCRCKOGD1rUoMtzD/rQvE5MFXrwyp+69T/Q60nYrmNEo4BZLTmg7oIRg
         9e8ealZD6t0P5Wl0R7SIE1qJDlk9B/4k4rEI85JDchyritY3HizA8LYnE664Yywjc0MT
         5hwQ==
X-Gm-Message-State: AOAM532Rx2hnJ1SYXcoOLkB0w0+iXE4bZNu0Bkl7qg/v4qepAUyy0zsI
        rKMZ90vnISQtNRzjRj2b5O7Rx2CCb1c=
X-Google-Smtp-Source: ABdhPJx+/epJ0+Z/Vee/c/zd0g+q1xlAxce8NTI5ZTVN1EE93V/0n8b39+7+JOysvk1v0hmbMtGIfA==
X-Received: by 2002:a05:600c:214e:b0:394:31c6:b66b with SMTP id v14-20020a05600c214e00b0039431c6b66bmr2080192wml.31.1652225557764;
        Tue, 10 May 2022 16:32:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r7-20020adfe687000000b0020c5253d908sm161904wrm.84.2022.05.10.16.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 16:32:37 -0700 (PDT)
Message-Id: <7be484a8c0beb5787967e4c89fb3eab15006e3be.1652225552.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.v3.git.1652225552.gitgitgadget@gmail.com>
References: <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com>
        <pull.1171.v3.git.1652225552.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 May 2022 23:32:28 +0000
Subject: [PATCH v3 2/6] stash: integrate with sparse index
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

