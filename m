Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEE331F463
	for <e@80x24.org>; Tue, 17 Sep 2019 16:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbfIQQfU (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 12:35:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37443 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730445AbfIQQfU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 12:35:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id y5so2483175pfo.4
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 09:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zw6tvNAYBvBTdtULLa0m/g8muGde7ZEIzP3/41GZH1A=;
        b=JkKw5eXqSJ1m18hmoPkLjp6xkPkP6mrxXQUwP0hBR0WYOn1HzB66ui5PKDEY/66Dpk
         RBh2Se03onaFySsVKoRtr3MOPIR6mSQYzNWUOqqQhXn+65E4HVJxZ3KbdWqbg9yNEIKZ
         i24yGOdEzYWgKemimVe3GlTYCHogNWQS4PqYLoNvX/yyBzmHuBImu7aFWLfBcb9L6MLX
         esYc+sHBBn8pMj8q9ooXxzA/FRX8MWXcJgBa7wRX4vG2+p8Ue3mmk1sB5Z5GByr/Q0no
         odD6ZuOEftRSt6yifxDgFxds+7wZPzbfYOIT0vCB3b6UJnyJ71IZI6z/O6BVT2+BLUEB
         gP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zw6tvNAYBvBTdtULLa0m/g8muGde7ZEIzP3/41GZH1A=;
        b=aH7Z8hY1s2NIDZc6IORfLY4GwwbgUXJDAkYqlcRYXyZqoT8DubA56ZGJmgOzY8mak2
         P63xBvX1KUpPDnGAgBysia8GCbDPQ+xN9Jqj+/qrpTzMFUa8qnHSYQp5QczBKFg3DDVi
         +pIIgzUOsXmitHWF9oVtnFsHyVXS2c5Ucp3/mimHjEVcndtxw+wuCRRezeOQlcRwneXe
         eMIuTk0XtaqvR1YNwzrVcQzzZr41rhFUG0tHdWI0/frMV2NZ5C8ev40S+FmL8giReiZ6
         0wjCdGODISgQriO6TjQwke/Ul/5PQMq5pQloPWjFTmyKAm1A+tALIfdVL7pb2V5CPoXz
         oPUQ==
X-Gm-Message-State: APjAAAXKG34j9oaQEgheAx3N37x5oh+KVRqZkck5nyIWQOOG5FdiEPLs
        pP/RlxzkcXOzMM8DQ/lSRLh5L1pkRJ8=
X-Google-Smtp-Source: APXvYqwmxPQeXZtESXxNsa/+4P2h4ztnjKQaYQ4z5Nps8P8PohuJRwN3x8zLPAwx0LD8E4TsiZctpA==
X-Received: by 2002:a17:90a:17ad:: with SMTP id q42mr5648764pja.26.1568738119398;
        Tue, 17 Sep 2019 09:35:19 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id s5sm3202452pfe.52.2019.09.17.09.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Sep 2019 09:35:18 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 06/12] dir: if our pathspec might match files under a dir, recurse into it
Date:   Tue, 17 Sep 2019 09:34:58 -0700
Message-Id: <20190917163504.14566-7-newren@gmail.com>
X-Mailer: git-send-email 2.22.1.17.g6e632477f7
In-Reply-To: <20190917163504.14566-1-newren@gmail.com>
References: <20190912221240.18057-1-newren@gmail.com>
 <20190917163504.14566-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For git clean, if a directory is entirely untracked and the user did not
specify -d (corresponding to DIR_SHOW_IGNORED_TOO), then we usually do
not want to remove that directory and thus do not recurse into it.
However, if the user manually specified specific (or even globbed) paths
somewhere under that directory to remove, then we need to recurse into
the directory to make sure we remove the relevant paths under that
directory as the user requested.

Note that this does not mean that the recursed-into directory will be
added to dir->entries for later removal; as of a few commits earlier in
this series, there is another more strict match check that is run after
returning from a recursed-into directory before deciding to add it to the
list of entries.  Therefore, this will only result in files underneath
the given directory which match one of the pathspecs being added to the
entries list.

Two notes of potential interest to future readers:

  * If we wanted to only recurse into a directory when it is specifically
    matched rather than matched-via-glob (e.g. '*.c'), then we could do
    so via making the final non-zero return in match_pathspec_item be
    MATCHED_RECURSIVELY instead of MATCHED_RECURSIVELY_LEADING_PATHSPEC.
    (Note that the relative order of MATCHED_RECURSIVELY_LEADING_PATHSPEC
    and MATCHED_RECURSIVELY are important for such a change.)  I was
    leaving open that possibility while writing an RFC asking for the
    behavior we want, but even though we don't want it, that knowledge
    might help you understand the code flow better.

  * There is a growing amount of logic in read_directory_recursive() for
    deciding whether to recurse into a subdirectory.  However, there is a
    comment immediately preceding this logic that says to recurse if
    instructed by treat_path().   It may be better for the logic in
    read_directory_recursive() to ultimately be moved to treat_path() (or
    another function it calls, such as treat_directory()), but I have
    left that for someone else to tackle in the future.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c            | 10 ++++++----
 dir.h            |  5 +++--
 t/t7300-clean.sh |  4 ++--
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/dir.c b/dir.c
index b4d656192e..47c0a99cb5 100644
--- a/dir.c
+++ b/dir.c
@@ -360,7 +360,7 @@ static int match_pathspec_item(const struct index_state *istate,
 		if ((namelen < matchlen) &&
 		    (match[namelen-offset] == '/') &&
 		    !ps_strncmp(item, match, name, namelen))
-			return MATCHED_RECURSIVELY;
+			return MATCHED_RECURSIVELY_LEADING_PATHSPEC;
 
 		/* name" doesn't match up to the first wild character */
 		if (item->nowildcard_len < item->len &&
@@ -377,7 +377,7 @@ static int match_pathspec_item(const struct index_state *istate,
 		 * The submodules themselves will be able to perform more
 		 * accurate matching to determine if the pathspec matches.
 		 */
-		return MATCHED_RECURSIVELY;
+		return MATCHED_RECURSIVELY_LEADING_PATHSPEC;
 	}
 
 	return 0;
@@ -1939,8 +1939,10 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 		/* recurse into subdir if instructed by treat_path */
 		if ((state == path_recurse) ||
 			((state == path_untracked) &&
-			 (dir->flags & DIR_SHOW_IGNORED_TOO) &&
-			 (get_dtype(cdir.de, istate, path.buf, path.len) == DT_DIR))) {
+			 (get_dtype(cdir.de, istate, path.buf, path.len) == DT_DIR) &&
+			 ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
+			  do_match_pathspec(istate, pathspec, path.buf, path.len,
+					    baselen, NULL, DO_MATCH_LEADING_PATHSPEC) == MATCHED_RECURSIVELY_LEADING_PATHSPEC))) {
 			struct untracked_cache_dir *ud;
 			ud = lookup_untracked(dir->untracked, untracked,
 					      path.buf + baselen,
diff --git a/dir.h b/dir.h
index 680079bbe3..46c238ab49 100644
--- a/dir.h
+++ b/dir.h
@@ -211,8 +211,9 @@ int count_slashes(const char *s);
  * when populating the seen[] array.
  */
 #define MATCHED_RECURSIVELY 1
-#define MATCHED_FNMATCH 2
-#define MATCHED_EXACTLY 3
+#define MATCHED_RECURSIVELY_LEADING_PATHSPEC 2
+#define MATCHED_FNMATCH 3
+#define MATCHED_EXACTLY 4
 int simple_length(const char *match);
 int no_wildcard(const char *string);
 char *common_prefix(const struct pathspec *pathspec);
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 12617158db..d83aeb7dc2 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -691,7 +691,7 @@ test_expect_failure 'git clean -d skips nested repo containing ignored files' '
 	test_path_is_file nested-repo-with-ignored-file/file
 '
 
-test_expect_failure 'git clean handles being told what to clean' '
+test_expect_success 'git clean handles being told what to clean' '
 	mkdir -p d1 d2 &&
 	touch d1/ut d2/ut &&
 	git clean -f */ut &&
@@ -707,7 +707,7 @@ test_expect_success 'git clean handles being told what to clean, with -d' '
 	test_path_is_missing d2/ut
 '
 
-test_expect_failure 'git clean works if a glob is passed without -d' '
+test_expect_success 'git clean works if a glob is passed without -d' '
 	mkdir -p d1 d2 &&
 	touch d1/ut d2/ut &&
 	git clean -f "*ut" &&
-- 
2.22.1.17.g6e632477f7.dirty

