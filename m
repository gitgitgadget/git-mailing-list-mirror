Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76ADD1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 22:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbfILWM7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 18:12:59 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45686 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729488AbfILWM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 18:12:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id x3so12345589plr.12
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 15:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vZOJxxVSwvO10bRW7+TiR44RbS6V3La7ZMXKsSKX1qU=;
        b=UHGOqQSjWcPZfx5sELgRzjfV8QP9ksuZD6C/Mc8hn9NNtEAgwgzGP4BzfooEpR9vxf
         TtuIBFCBRQDOQEtBjx/qU/ORZrLqdAGSwhcY0NC8CQj4rYo2/BQwKPT1jAdEHonjRa+U
         ggvohHVJfJ8nx6AdXaGChsRQUQNpjJWSIFwxK1ZW7pnSPK8rBE/538MUOyzODd+W+xoL
         Ro5oTQ5mwg+G0X3f3HVuVT799EaOh7v1Ix9H3dO0pbCN8zxM25VhVkTUL6CJTdx0u+E8
         0gsIW0B1TZHosB0iK6o769bNz5ZDtdjG0fU8k6v1E72w46oEeFEx5X9CLQLrRjPrUCdR
         xwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vZOJxxVSwvO10bRW7+TiR44RbS6V3La7ZMXKsSKX1qU=;
        b=rTXk/6RRkChuJu6Ou71kh90luoeGJsBJTt39IWui9fR52hkl+ECcFoAkm5Qbxacmrj
         RyffmZdFcFzQqQFMraZQmhUYV4ajyJ/ghbM5d75HPRVweLOD1mpLgM8BB8VfkxnmMuLz
         gn8n5VPYtgntWXiixzgP1p18YtP4z8MMUsMrlbEjCwZR+jLjUiLj9WZEsUli2Xjmkgcf
         ta0AeDnPnCRkVMxjNd7Yvj3qWe74VOE6mQjkqG7vPG4lpFrZqJy2wGhahVU0f5EqqUq+
         rtdeeQVs2SnNvyarnpF6Vh8ml2LlO9Vg1+BBi2RWFkydHh/x2NHEUyawEsIhr17MmWb5
         i6kw==
X-Gm-Message-State: APjAAAU7asJUQT9pRQYe383nej/TythVzRtijcBj6pzXZLrrf2xrl6he
        LVTNDD7oEvYghL7kl+nRELdO9Gs8Zbw=
X-Google-Smtp-Source: APXvYqwAiZin0z6I0CkFj0LMHBzkl+GAx8nVPy8gApM69JlIB2CUdJKM1ffU75vXd3tIciwMKUQFbw==
X-Received: by 2002:a17:902:4a:: with SMTP id 68mr40339824pla.196.1568326377002;
        Thu, 12 Sep 2019 15:12:57 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id y13sm24358188pfn.73.2019.09.12.15.12.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Sep 2019 15:12:56 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 10/12] clean: avoid removing untracked files in a nested git repository
Date:   Thu, 12 Sep 2019 15:12:38 -0700
Message-Id: <20190912221240.18057-11-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.173.gad11b3a635.dirty
In-Reply-To: <20190912221240.18057-1-newren@gmail.com>
References: <20190905154735.29784-1-newren@gmail.com>
 <20190912221240.18057-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Users expect files in a nested git repository to be left alone unless
sufficiently forced (with two -f's).  Unfortunately, in certain
circumstances, git would delete both tracked (and possibly dirty) files
and untracked files within a nested repository.  To explain how this
happens, let's contrast a couple cases.  First, take the following
example setup (which assumes we are already within a git repo):

   git init nested
   cd nested
   >tracked
   git add tracked
   git commit -m init
   >untracked
   cd ..

In this setup, everything works as expected; running 'git clean -fd'
will result in fill_directory() returning the following paths:
   nested/
   nested/tracked
   nested/untracked
and then correct_untracked_entries() would notice this can be compressed
to
   nested/
and then since "nested/" is a directory, we would call
remove_dirs("nested/", ...), which would
check is_nonbare_repository_dir() and then decide to skip it.

However, if someone also creates an ignored file:
   >nested/ignored
then running 'git clean -fd' would result in fill_directory() returning
the same paths:
   nested/
   nested/tracked
   nested/untracked
but correct_untracked_entries() will notice that we had ignored entries
under nested/ and thus simplify this list to
   nested/tracked
   nested/untracked
Since these are not directories, we do not call remove_dirs() which was
the only place that had the is_nonbare_repository_dir() safety check --
resulting in us deleting both the untracked file and the tracked (and
possibly dirty) file.

One possible fix for this issue would be walking the parent directories
of each path and checking if they represent nonbare repositories, but
that would be wasteful.  Even if we added caching of some sort, it's
still a waste because we should have been able to check that "nested/"
represented a nonbare repository before even descending into it in the
first place.  Add a DIR_SKIP_NESTED_GIT flag to dir_struct.flags and use
it to prevent fill_directory() and friends from descending into nested
git repos.

With this change, we also modify two regression tests added in commit
91479b9c72f1 ("t7300: add tests to document behavior of clean and nested
git", 2015-06-15).  That commit, nor its series, nor the six previous
iterations of that series on the mailing list discussed why those tests
coded the expectation they did.  In fact, it appears their purpose was
simply to test _existing_ behavior to make sure that the performance
changes didn't change the behavior.  However, these two tests directly
contradicted the manpage's claims that two -f's were required to delete
files/directories under a nested git repository.  While one could argue
that the user gave an explicit path which matched files/directories that
were within a nested repository, there's a slippery slope that becomes
very difficult for users to understand once you go down that route (e.g.
what if they specified "git clean -f -d '*.c'"?)  It would also be hard
to explain what the exact behavior was; avoid such problems by making it
really simple.

Also, clean up some grammar errors describing this functionality in the
git-clean manpage.

Finally, there are still a couple bugs with -ffd not cleaning out enough
(e.g.  missing the nested .git) and with -ffdX possibly cleaning out the
wrong files (paying attention to outer .gitignore instead of inner).
This patch does not address these cases at all (and does not change the
behavior relative to those flags), it only fixes the handling when given
a single -f.  See
https://public-inbox.org/git/20190905212043.GC32087@szeder.dev/ for more
discussion of the -ffd[X?] bugs.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-clean.txt |  6 +++---
 builtin/clean.c             |  2 ++
 dir.c                       | 10 ++++++++++
 dir.h                       |  3 ++-
 t/t7300-clean.sh            | 10 +++++-----
 5 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 3ab749b921..ba31d8d166 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -37,9 +37,9 @@ OPTIONS
 --force::
 	If the Git configuration variable clean.requireForce is not set
 	to false, 'git clean' will refuse to delete files or directories
-	unless given -f or -i. Git will refuse to delete directories
-	with .git sub directory or file unless a second -f
-	is given.
+	unless given -f or -i.  Git will refuse to modify untracked
+	nested git repositories (directories with a .git subdirectory)
+	unless a second -f is given.
 
 -i::
 --interactive::
diff --git a/builtin/clean.c b/builtin/clean.c
index 68d70e41c0..3a7a63ae71 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -946,6 +946,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	if (force > 1)
 		rm_flags = 0;
+	else
+		dir.flags |= DIR_SKIP_NESTED_GIT;
 
 	dir.flags |= DIR_SHOW_OTHER_DIRECTORIES;
 
diff --git a/dir.c b/dir.c
index 3b2fe1701c..7ff79170fc 100644
--- a/dir.c
+++ b/dir.c
@@ -1451,6 +1451,16 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 		return path_none;
 
 	case index_nonexistent:
+		if (dir->flags & DIR_SKIP_NESTED_GIT) {
+			int nested_repo;
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_addstr(&sb, dirname);
+			nested_repo = is_nonbare_repository_dir(&sb);
+			strbuf_release(&sb);
+			if (nested_repo)
+				return path_none;
+		}
+
 		if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
 			break;
 		if (exclude &&
diff --git a/dir.h b/dir.h
index 46c238ab49..739aea7c96 100644
--- a/dir.h
+++ b/dir.h
@@ -156,7 +156,8 @@ struct dir_struct {
 		DIR_SHOW_IGNORED_TOO = 1<<5,
 		DIR_COLLECT_KILLED_ONLY = 1<<6,
 		DIR_KEEP_UNTRACKED_CONTENTS = 1<<7,
-		DIR_SHOW_IGNORED_TOO_MODE_MATCHING = 1<<8
+		DIR_SHOW_IGNORED_TOO_MODE_MATCHING = 1<<8,
+		DIR_SKIP_NESTED_GIT = 1<<9
 	} flags;
 	struct dir_entry **entries;
 	struct dir_entry **ignored;
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 530dfdab34..6e6d24c1c3 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -549,7 +549,7 @@ test_expect_failure 'nested (non-empty) bare repositories should be cleaned even
 	test_path_is_missing strange_bare
 '
 
-test_expect_success 'giving path in nested git work tree will remove it' '
+test_expect_success 'giving path in nested git work tree will NOT remove it' '
 	rm -fr repo &&
 	mkdir repo &&
 	(
@@ -561,7 +561,7 @@ test_expect_success 'giving path in nested git work tree will remove it' '
 	git clean -f -d repo/bar/baz &&
 	test_path_is_file repo/.git/HEAD &&
 	test_path_is_dir repo/bar/ &&
-	test_path_is_missing repo/bar/baz
+	test_path_is_file repo/bar/baz/hello.world
 '
 
 test_expect_success 'giving path to nested .git will not remove it' '
@@ -579,7 +579,7 @@ test_expect_success 'giving path to nested .git will not remove it' '
 	test_path_is_dir untracked/
 '
 
-test_expect_success 'giving path to nested .git/ will remove contents' '
+test_expect_success 'giving path to nested .git/ will NOT remove contents' '
 	rm -fr repo untracked &&
 	mkdir repo untracked &&
 	(
@@ -589,7 +589,7 @@ test_expect_success 'giving path to nested .git/ will remove contents' '
 	) &&
 	git clean -f -d repo/.git/ &&
 	test_path_is_dir repo/.git &&
-	test_dir_is_empty repo/.git &&
+	test_path_is_file repo/.git/HEAD &&
 	test_path_is_dir untracked/
 '
 
@@ -671,7 +671,7 @@ test_expect_success 'git clean -d skips untracked dirs containing ignored files'
 	test_path_is_missing foo/b/bb
 '
 
-test_expect_failure 'git clean -d skips nested repo containing ignored files' '
+test_expect_success 'git clean -d skips nested repo containing ignored files' '
 	test_when_finished "rm -rf nested-repo-with-ignored-file" &&
 
 	git init nested-repo-with-ignored-file &&
-- 
2.23.0.173.gad11b3a635.dirty

