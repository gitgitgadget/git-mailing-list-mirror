Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 729FA2047F
	for <e@80x24.org>; Sun, 24 Sep 2017 16:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752515AbdIXQRT (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Sep 2017 12:17:19 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34162 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752416AbdIXQRS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2017 12:17:18 -0400
Received: by mail-yw0-f195.google.com with SMTP id v72so2586795ywa.1
        for <git@vger.kernel.org>; Sun, 24 Sep 2017 09:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6fVVQw7epSxQMcuGSIgOpGHXfVZAxfX4lrg8B0/UJnk=;
        b=cr2Kg0J0yuBecnwYzPQk99UECHl16lF9Hb8MaTRDdTGmEEt8tJ18+SWZuB3SAkw3Lf
         /Thbog65uh0Ts1qrugMOmGGxwVBN3xpaREEzL83ZCNA5Mg1C9jtCcUJZZlp78B10mtcj
         Cw//wsMNEQ6lMGBlG8zlZnW8xB+LyPyPiv1IttljwKNxIjGGHubzNB20Pw/G8iyk0NYC
         SVCCOX+OUlIIA1l0RVjQFB6SJiwciriNnCEV0FZWTWfGtzo61VqEW/iYsqOS0utsyGcd
         g8frIU7mmwh6dXcNeVvvAxuEUJGKsA5zEtEvB7tFkQPML7BQ+P52DR3dHt5mYkRQjAKw
         xcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6fVVQw7epSxQMcuGSIgOpGHXfVZAxfX4lrg8B0/UJnk=;
        b=s1a/iVoMh5/s8zEi9pqfim9HyD1cbx3hF/cPFi5hHjxj5tHWDIMwjpYiTy/OyJpC9T
         sP2JzZzwt6GVG7zEaex16oFa18c1q7xioTVri9DfY0deNL+8D72Wd86VY5dgBo0co9pe
         fULr8LfE9WQeMyZoCBjU2/GJp2WahbvBSufyF0CSyBPklxlcvJjvlxJpz8vhpJ6BSDLx
         5DdASTLbM3oqXIiIh8HEojiMF17Gc3uzcTF8GuztmwT26CR9FrL1SmgAf9BqvFhC5zw0
         GpvCBxIflxMN404R5RdpkaFCwAXjhhin9X6TAdDvn+uNyst+cAVXRc6pLJDXSyrQdbjj
         qscQ==
X-Gm-Message-State: AHPjjUgmSnDJDjWvUfSDTnsroqpmMdQHAEgijDxgKig2RykaEwwasZAO
        7bw5uoAM19urEGLX4+zF87Pd2KdJoIsSfHUEZtDqUCLB
X-Google-Smtp-Source: AOwi7QCoEwzKUzdaIbF+lLNM3sS8u3suibEiAjNGy5UjKmqO2ivD6ressxkJ8AYlbKax3qZTZu3RioOco2KkbRWJRwM=
X-Received: by 10.13.225.138 with SMTP id k132mr3074450ywe.327.1506269836894;
 Sun, 24 Sep 2017 09:17:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.173.37 with HTTP; Sun, 24 Sep 2017 09:17:16 -0700 (PDT)
From:   Manav Rathi <mnvrth@gmail.com>
Date:   Sun, 24 Sep 2017 21:47:16 +0530
Message-ID: <CAEuZsW8vR0LesL=+ZoiFa=BBwhhm=KON+U3H2H9sNdTT+jgBkQ@mail.gmail.com>
Subject: [PATCH] docs: improve discoverability of exclude pathspec
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, Manav Rathi <mnvrth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ability to exclude paths in pathspecs is not mentioned in the man
pages of git grep and other commands where it might be useful.

Add a pointer to the pathspec syntax and a quick example in the git
grep man page to help the user to discover this ability.

Add similar pointers from the git-add and git-status man pages.

Additionally,

- Add a test for the behaviour when multiple exclusions are present.
- Add a test for the ^ alias.
- Perform general touch ups of surrounding lines.

Signed-off-by: Manav Rathi <mnvrth@gmail.com>
---
 Documentation/git-add.txt          | 27 ++++++++++++++++-----------
 Documentation/git-grep.txt         |  6 ++++++
 Documentation/git-status.txt       |  2 ++
 Documentation/glossary-content.txt |  2 +-
 t/t6132-pathspec-exclude.sh        | 13 ++++++++++++-
 5 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index f4169fb..6f76f39 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -50,17 +50,22 @@ commit.
 OPTIONS
 -------
 <pathspec>...::
- Files to add content from.  Fileglobs (e.g. `*.c`) can
- be given to add all matching files.  Also a
- leading directory name (e.g. `dir` to add `dir/file1`
- and `dir/file2`) can be given to update the index to
- match the current state of the directory as a whole (e.g.
- specifying `dir` will record not just a file `dir/file1`
- modified in the working tree, a file `dir/file2` added to
- the working tree, but also a file `dir/file3` removed from
- the working tree.  Note that older versions of Git used
- to ignore removed files; use `--no-all` option if you want
- to add modified or new files but ignore removed ones.
+ Files to add content from.
++
+File globs (e.g. `*.c`) can be given to add all matching files.  A
+leading directory name (e.g. `dir` to add `dir/file1` and `dir/file2`)
+can be given to update the index to match the current state of the
+directory as a whole.
++
+Note that specifying `dir` will record not just a file `dir/file1`
+modified in the working tree, a file `dir/file2` added to the working
+tree, but also a file `dir/file3` removed from the working tree.
+Older versions of Git used to ignore removed files; use the `--no-all`
+option if you want to add new and modified files but ignore removed
+ones.
++
+For more details about the <pathspec> syntax, see the 'pathspec' entry
+in linkgit:gitglossary[7].

 -n::
 --dry-run::
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 720c785..18b4947 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -289,6 +289,9 @@ providing this option will cause it to die.
 <pathspec>...::
  If given, limit the search to paths matching at least one pattern.
  Both leading paths match and glob(7) patterns are supported.
++
+For more details about the <pathspec> syntax, see the 'pathspec' entry
+in linkgit:gitglossary[7].

 Examples
 --------
@@ -305,6 +308,9 @@ Examples
  Looks for a line that has `NODE` or `Unexpected` in
  files that have lines that match both.

+`git grep solution -- :^Documentation`::
+ Looks for `solution`, excluding files in `Documentation`.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index d47f198..9f3a78a 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -111,6 +111,8 @@ configuration variable documented in linkgit:git-config[1].
  without options are equivalent to 'always' and 'never'
  respectively.

+<pathspec>...::
+ See the 'pathspec' entry in linkgit:gitglossary[7].

 OUTPUT
 ------
diff --git a/Documentation/glossary-content.txt
b/Documentation/glossary-content.txt
index b71b943..6b8888d 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -407,7 +407,7 @@ these forms:

 exclude;;
  After a path matches any non-exclude pathspec, it will be run
- through all exclude pathspec (magic signature: `!` or its
+ through all exclude pathspecs (magic signature: `!` or its
  synonym `^`). If it matches, the path is ignored.  When there
  is no non-exclude pathspec, the exclusion is applied to the
  result set as if invoked without any pathspec.
diff --git a/t/t6132-pathspec-exclude.sh b/t/t6132-pathspec-exclude.sh
index 9dd5cde..7ce91ef 100755
--- a/t/t6132-pathspec-exclude.sh
+++ b/t/t6132-pathspec-exclude.sh
@@ -25,7 +25,7 @@ EOF
  test_cmp expect actual
 '

-test_expect_success 'exclude only no longer errors out' '
+test_expect_success 'exclude only pathspec uses default implicit pathspec' '
  git log --oneline --format=%s -- . ":(exclude)sub" >expect &&
  git log --oneline --format=%s -- ":(exclude)sub" >actual &&
  test_cmp expect actual
@@ -183,4 +183,15 @@ EOF
  test_cmp expect actual
 '

+test_expect_success 'multiple exclusions' '
+ git ls-files -- :^*/file2 :^sub2 >actual &&
+ cat <<EOF >expect &&
+file
+sub/file
+sub/sub/file
+sub/sub/sub/file
+EOF
+ test_cmp expect actual
+'
+
 test_done
-- 
2.10.1
