Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A144C433EF
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 22:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343556AbhKZWsc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 17:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245248AbhKZWqV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 17:46:21 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC3CC0613ED
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 14:41:12 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so7682042wms.3
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 14:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wSpJGrNm6d7EMcQpoWGw26gF9D+DatE4Bc+ckQHo5Gw=;
        b=dczUUjWmgucp1Ccs+D3Hw1jWPytZ77nKUJ+3wR6GvIBJMOSCFY5/i5vbP6HYAW47Ua
         kdlnHGADCWfjDn5u86SPNV0H/dvDBOmBpVmCbFgOdfQYMlobBHNo46zEzmZ+Gk9wXFyn
         MJ/loNrGmEh40DEnfDUn8CWZqMqBI7Ng2UiTKCe7cSHmAzW1EX40R3KtymD0KHJzIG/L
         cNaA3j4JsHCSD+QH5VCKGLBlKDJzEMIT9zOzyaPPtbU+qxNnwECFah4GdUNQV/zLKohi
         4/muUSd5Ck7Z6hpfqpVJKMvLSlzvZtFllxQQsfd2hvOiEDqMPmp8egwIOI0NGXDI4qYp
         NYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wSpJGrNm6d7EMcQpoWGw26gF9D+DatE4Bc+ckQHo5Gw=;
        b=IXOkl6STFYXvAMk70WIe7Sf0oWRibIid++BEUiDXhy5/+xRFIZhCc9UC3I8f+YYOBw
         9BbJxV1clUaktthPGAX0VNqo5bdJqfLQ3+ZltOYhcsy8v05SUQtjoTl3ke1mqjvGfKyo
         vpP8fbzhTcMeqKWo4I7503IngaaiBW1yhPYy4gxxNwjOVfOSQkiqfx+j8YPmXyvGrIlu
         F6CJrAjs39QmbBDfzJOZKUbIHy5aH01KUvoVkYfCl+/Zw5i3ugdb8sSOIdY0Nk1TIre8
         6IzSrcM3tEOTYgficGhTf0f2drE5FOu5tZW1RMZ5sgwpl6miACn4ofYGaJP02X7x7L3z
         QZBA==
X-Gm-Message-State: AOAM533ndt063qFbU1oqidpTeBvG6aWVm1rF0YwpTfyLGTeQF+4UBAhO
        mUbknYt9hNO40xgJYN/ZiobtHclO3dQ=
X-Google-Smtp-Source: ABdhPJwp9HWMkDlc0tEk2/bodiCJbX2J3M6fBmh/Y272ZxMBLCqUqRgQOaxTzuByvy1jGS+WOowtbw==
X-Received: by 2002:a1c:9d03:: with SMTP id g3mr18296796wme.143.1637966470918;
        Fri, 26 Nov 2021 14:41:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q8sm6538239wrx.71.2021.11.26.14.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 14:41:10 -0800 (PST)
Message-Id: <2c73a09a2e83f08bcb0a5449f48e7e2ca5ac914e.1637966463.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
References: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
        <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Nov 2021 22:41:00 +0000
Subject: [PATCH v3 09/11] dir: avoid incidentally removing the original_cwd in
 remove_path()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Modern git often tries to avoid leaving empty directories around when
removing files.  Originally, it did not bother.  This behavior started
with commit 80e21a9ed809 (merge-recursive::removeFile: remove empty
directories, 2005-11-19), stating the reason simply as:

    When the last file in a directory is removed as the result of a
    merge, try to rmdir the now-empty directory.

This was reimplemented in C and renamed to remove_path() in commit
e1b3a2cad7 ("Build-in merge-recursive", 2008-02-07), but was still
internal to merge-recursive.

This trend towards removing leading empty directories continued with
commit d9b814cc97f1 (Add builtin "git rm" command, 2006-05-19), which
stated the reasoning as:

    The other question is what to do with leading directories. The old
    "git rm" script didn't do anything, which is somewhat inconsistent.
    This one will actually clean up directories that have become empty
    as a result of removing the last file, but maybe we want to have a
    flag to decide the behaviour?

remove_path() in dir.c was added in 4a92d1bfb784 (Add remove_path: a
function to remove as much as possible of a path, 2008-09-27), because
it was noted that we had two separate implementations of the same idea
AND both were buggy.  It described the purpose of the function as

    a function to remove as much as possible of a path

Why remove as much as possible?  Well, at the time we probably would
have said something like:

  * removing leading directories makes things feel tidy
  * removing leading directories doesn't hurt anything so long as they
    had no files in them.

But I don't believe those reasons hold when the empty directory happens
to be the current working directory we inherited from our parent
process.  Leaving the parent process in a deleted directory can cause
user confusion when subsequent processes fail: any git command, for
example, will immediately fail with

    fatal: Unable to read current working directory: No such file or directory

Other commands may similarly get confused.  Modify remove_path() so that
the empty leading directories it also deletes does not include the
current working directory we inherited from our parent process.  I have
looked through every caller of remove_path() in the current codebase to
make sure that all should take this change.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c                |  3 +++
 dir.h                |  6 +++++-
 t/t2501-cwd-empty.sh | 12 ++++--------
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/dir.c b/dir.c
index 94489298f4c..97d6b71c872 100644
--- a/dir.c
+++ b/dir.c
@@ -3327,6 +3327,9 @@ int remove_path(const char *name)
 		slash = dirs + (slash - name);
 		do {
 			*slash = '\0';
+			if (startup_info->original_cwd &&
+			    !strcmp(startup_info->original_cwd, dirs))
+				break;
 		} while (rmdir(dirs) == 0 && (slash = strrchr(dirs, '/')));
 		free(dirs);
 	}
diff --git a/dir.h b/dir.h
index 83f46c0fb4c..d6a5d03bec2 100644
--- a/dir.h
+++ b/dir.h
@@ -504,7 +504,11 @@ int get_sparse_checkout_patterns(struct pattern_list *pl);
  */
 int remove_dir_recursively(struct strbuf *path, int flag);
 
-/* tries to remove the path with empty directories along it, ignores ENOENT */
+/*
+ * Tries to remove the path, along with leading empty directories so long as
+ * those empty directories are not startup_info->original_cwd.  Ignores
+ * ENOENT.
+ */
 int remove_path(const char *path);
 
 int fspathcmp(const char *a, const char *b);
diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index 6788a0d267f..cba817ff734 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -175,12 +175,12 @@ test_expect_success 'revert fails if cwd needs to be removed' '
 '
 
 test_expect_success 'rm does not clean cwd incidentally' '
-	test_incidental_dir_removal failure git rm bar/baz.t
+	test_incidental_dir_removal success git rm bar/baz.t
 '
 
 test_expect_success 'apply does not remove cwd incidentally' '
 	git diff HEAD HEAD~1 >patch &&
-	test_incidental_dir_removal failure git apply ../patch
+	test_incidental_dir_removal success git apply ../patch
 '
 
 test_incidental_untracked_dir_removal () {
@@ -262,12 +262,8 @@ test_expect_success '`rm -rf dir` even with only tracked files will remove somet
 	) &&
 
 	test_path_is_missing a/b/c/tracked &&
-	## We would prefer if a/b was still present, though empty, since it
-	## was the current working directory
-	#test_path_is_dir a/b
-	## But the current behavior is that it not only deletes the directory
-	## a/b as requested, but also goes and deletes a
-	test_path_is_missing a
+	test_path_is_missing a/b/c &&
+	test_path_is_dir a/b
 '
 
 test_expect_success 'git version continues working from a deleted dir' '
-- 
gitgitgadget

