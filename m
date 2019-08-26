Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31B591F4B9
	for <e@80x24.org>; Mon, 26 Aug 2019 23:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfHZXwk (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 19:52:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39374 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfHZXwi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 19:52:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so11530597pgi.6
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 16:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H5x87QSvrq0ij+IKrzrzMSQhJvcL7g/G5e/9lB/LRCI=;
        b=Yelbabij4CfYnGDX5OstXSZ2fyV/huTiB01LgzXamfrPfij3gEjKKcEtVVlBVx/70M
         yyVWNmr9LxxqWl6/T1rzUTteTtd7F5aw12IGkGLYBPrI55JnySN7+uyz1tVX8G2lST/2
         Co+2yCKen/uUlvwMrgYYRF8T+F/DuoQXiBlog0vpfCQ0LLzD09JLxRhDqDRK1bbazUNg
         Ku6G3Pdn6qImJlNMKg1V6T5iFbH8+XsMf6qpzPbUBdsvO3xi8DdNW4zj1kmx/oBAXJHu
         GKdKAF0NjRvFJilSFIINsHDhBAnqAY3GbE413EgYCVV3LsRW7rw3OzSAAoTjRoLIGfyB
         gfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H5x87QSvrq0ij+IKrzrzMSQhJvcL7g/G5e/9lB/LRCI=;
        b=S2IMi6yLxxkL+ZRBTRtV/CPvR57CDfz3ujuknBVzY5YiwC/i7syWQj2TfF4s/iWXob
         KZ8xS0MGFyB+P+zn+fMLQyh6J10iv1oNiXJHckoC6OdOjMkPb8i7/5bs9ZqBeDpJIVMV
         b4djd4m7s3EWyi2JgdKoouQA6zGGukLU9gCNiYGzZZN041SEJB5FJyBp+xgQdX4JATcK
         MUKCoe8WvZqaMlJWtuWit4bfkyXgIhKFv35W6aVTcvkHnk10f6qSnhF2PMThCYV0jCXQ
         t5eUhyy8PEwWkIp6uT6CRLfn3b8QpOO/0B7wywDl6NmskgFUgWNAwvdcwE/Yp7UDYAzS
         pXiw==
X-Gm-Message-State: APjAAAWcSvy0F/xiuFoYY6svsvU4BpygQdMF8TQr1LjIR50jvZf4dUcf
        bsj8KjkVaMz4sEIqPFadw8dLdf2N
X-Google-Smtp-Source: APXvYqz7lOc/bGBAbjvApTphnIp/lYXoDm1oupDUF36mtEOozDvIkD52hOkQWMZ3B/7klC7tEk+mtg==
X-Received: by 2002:a17:90a:3646:: with SMTP id s64mr22705501pjb.44.1566863556727;
        Mon, 26 Aug 2019 16:52:36 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id 21sm5939047pfb.96.2019.08.26.16.52.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Aug 2019 16:52:36 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 4/5] Recommend git-filter-repo instead of git-filter-branch in documentation
Date:   Mon, 26 Aug 2019 16:52:25 -0700
Message-Id: <20190826235226.15386-5-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.5.g775ebaa2a0
In-Reply-To: <20190826235226.15386-1-newren@gmail.com>
References: <xmqqd0gwopej.fsf@gitster-ct.c.googlers.com>
 <20190826235226.15386-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

filter-branch suffers from a huge number of pitfalls that can result in
incorrectly rewritten history, and many of the problems can easily go
undetected until the new repository is in use.  This can result in
problems ranging from an even messier history than what led folks to
filter-branch in the first place, to data loss or corruption.  These
issues cannot be backward compatibly fixed, so add a warning to the
filter-branch manpage about this and recommand that another tool (such
as filter-repo) be used instead.

Also, update other manpages that referenced filter-branch.  Several of
these needed updates even if we could continue recommending
filter-branch, either due to implying that something was unique to
filter-branch when it applied more generally to all history rewriting
tools (e.g. BFG, reposurgeon, fast-import, filter-repo), or because
something about filter-branch was used as an example despite other more
commonly known examples now existing.  Reword these sections to fix
these issues and to avoid recommending filter-branch.

Finally, remove the section explaining BFG Repo Cleaner as an
alternative to filter-branch.  I feel somewhat bad about this,
especially since I feel like I learned so much from BFG that I put to
good use in filter-repo (which is much more than I can say for
filter-branch), but keeping that section presented a few problems:
  * In order to recommend that people quit using filter-branch, we need
    to provide them a recomendation for something else to use that
    can handle all the same types of rewrites.  To my knowledge,
    filter-repo is the only such tool.  So it needs to be mentioned.
  * I don't want to give conflicting recommendations to users
  * If we recommend two tools, we shouldn't expect users to learn both
    and pick which one to use; we should explain which problems one
    can solve that the other can't or when one is much faster than
    the other.
  * BFG and filter-repo have similar performance
  * All filtering types that BFG can do, filter-repo can also do.  In
    fact, filter-repo comes with a reimplementation of BFG named
    bfg-ish which provides the same user-interface as BFG but with
    several bugfixes and new features that are hard to implement in
    BFG due to its technical underpinnings.
While I could still mention both tools, it seems like I would need to
provide some kind of comparison and I would ultimately just say that
filter-repo can do everything BFG can, so ultimately it seems that it
is just better to remove that section altogether.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-fast-export.txt   |  6 ++---
 Documentation/git-filter-branch.txt | 42 ++++++++---------------------
 Documentation/git-gc.txt            | 17 ++++++------
 Documentation/git-rebase.txt        |  2 +-
 Documentation/git-replace.txt       | 10 +++----
 Documentation/git-svn.txt           |  4 +--
 Documentation/githooks.txt          |  7 ++---
 contrib/svn-fe/svn-fe.txt           |  4 +--
 8 files changed, 36 insertions(+), 56 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index cc940eb9ad..784e934009 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -17,9 +17,9 @@ This program dumps the given revisions in a form suitable to be piped
 into 'git fast-import'.
 
 You can use it as a human-readable bundle replacement (see
-linkgit:git-bundle[1]), or as a kind of an interactive
-'git filter-branch'.
-
+linkgit:git-bundle[1]), or as a format that can be edited before being
+fed to 'git fast-import' in order to do history rewrites (an ability
+relied on by tools like 'git filter-repo').
 
 OPTIONS
 -------
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 6b53dd7e06..8c586eed55 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -16,6 +16,17 @@ SYNOPSIS
 	[--original <namespace>] [-d <directory>] [-f | --force]
 	[--state-branch <branch>] [--] [<rev-list options>...]
 
+WARNING
+-------
+'git filter-branch' has a litany of gotchas that can and will cause
+history to be rewritten incorrectly (in addition to abysmal
+performance).  These issues cannot be backward compatibly fixed and as
+such, its use is not recommended.  Please use an alternative history
+filtering tool such as 'git filter-repo'.  If you still need to use
+'git filter-branch', please carefully read the "Safety" section of
+https://public-inbox.org/git/CABPp-BEDOH-row-hxY4u_cP30ptqOpcCvPibwyZ2wBu142qUbA@mail.gmail.com/
+and avoid as many of the pitfalls listed there as reasonably possible.
+
 DESCRIPTION
 -----------
 Lets you rewrite Git revision history by rewriting the branches mentioned
@@ -445,37 +456,6 @@ warned.
   (or if your git-gc is not new enough to support arguments to
   `--prune`, use `git repack -ad; git prune` instead).
 
-NOTES
------
-
-git-filter-branch allows you to make complex shell-scripted rewrites
-of your Git history, but you probably don't need this flexibility if
-you're simply _removing unwanted data_ like large files or passwords.
-For those operations you may want to consider
-http://rtyley.github.io/bfg-repo-cleaner/[The BFG Repo-Cleaner],
-a JVM-based alternative to git-filter-branch, typically at least
-10-50x faster for those use-cases, and with quite different
-characteristics:
-
-* Any particular version of a file is cleaned exactly _once_. The BFG,
-  unlike git-filter-branch, does not give you the opportunity to
-  handle a file differently based on where or when it was committed
-  within your history. This constraint gives the core performance
-  benefit of The BFG, and is well-suited to the task of cleansing bad
-  data - you don't care _where_ the bad data is, you just want it
-  _gone_.
-
-* By default The BFG takes full advantage of multi-core machines,
-  cleansing commit file-trees in parallel. git-filter-branch cleans
-  commits sequentially (i.e. in a single-threaded manner), though it
-  _is_ possible to write filters that include their own parallelism,
-  in the scripts executed against each commit.
-
-* The http://rtyley.github.io/bfg-repo-cleaner/#examples[command options]
-  are much more restrictive than git-filter branch, and dedicated just
-  to the tasks of removing unwanted data- e.g:
-  `--strip-blobs-bigger-than 1M`.
-
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 247f765604..0c114ad1ca 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -115,15 +115,14 @@ NOTES
 -----
 
 'git gc' tries very hard not to delete objects that are referenced
-anywhere in your repository. In
-particular, it will keep not only objects referenced by your current set
-of branches and tags, but also objects referenced by the index,
-remote-tracking branches, refs saved by 'git filter-branch' in
-refs/original/, reflogs (which may reference commits in branches
-that were later amended or rewound), and anything else in the refs/* namespace.
-If you are expecting some objects to be deleted and they aren't, check
-all of those locations and decide whether it makes sense in your case to
-remove those references.
+anywhere in your repository. In particular, it will keep not only
+objects referenced by your current set of branches and tags, but also
+objects referenced by the index, remote-tracking branches, notes saved
+by 'git notes' under refs/notes/, reflogs (which may reference commits
+in branches that were later amended or rewound), and anything else in
+the refs/* namespace.  If you are expecting some objects to be deleted
+and they aren't, check all of those locations and decide whether it
+makes sense in your case to remove those references.
 
 On the other hand, when 'git gc' runs concurrently with another process,
 there is a risk of it deleting an object that the other process is using
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 6156609cf7..2f201d85d4 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -832,7 +832,7 @@ Hard case: The changes are not the same.::
 	This happens if the 'subsystem' rebase had conflicts, or used
 	`--interactive` to omit, edit, squash, or fixup commits; or
 	if the upstream used one of `commit --amend`, `reset`, or
-	`filter-branch`.
+	a full history rewriting command like `filter-repo`.
 
 
 The easy case
diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index 246dc9943c..35595a2cd3 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -123,10 +123,10 @@ The following format are available:
 CREATING REPLACEMENT OBJECTS
 ----------------------------
 
-linkgit:git-filter-branch[1], linkgit:git-hash-object[1] and
-linkgit:git-rebase[1], among other git commands, can be used to create
-replacement objects from existing objects. The `--edit` option can
-also be used with 'git replace' to create a replacement object by
+linkgit:git-hash-object[1], linkgit:git-rebase[1], and
+linkgit:git-filter-repo[1], among other git commands, can be used to
+create replacement objects from existing objects. The `--edit` option
+can also be used with 'git replace' to create a replacement object by
 editing an existing object.
 
 If you want to replace many blobs, trees or commits that are part of a
@@ -148,8 +148,8 @@ pending objects.
 SEE ALSO
 --------
 linkgit:git-hash-object[1]
-linkgit:git-filter-branch[1]
 linkgit:git-rebase[1]
+linkgit:git-filter-repo[1]
 linkgit:git-tag[1]
 linkgit:git-branch[1]
 linkgit:git-commit[1]
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 30711625fd..f2762dd5d4 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -769,9 +769,9 @@ option for (hopefully) obvious reasons.
 +
 This option is NOT recommended as it makes it difficult to track down
 old references to SVN revision numbers in existing documentation, bug
-reports and archives.  If you plan to eventually migrate from SVN to Git
+reports, and archives.  If you plan to eventually migrate from SVN to Git
 and are certain about dropping SVN history, consider
-linkgit:git-filter-branch[1] instead.  filter-branch also allows
+linkgit:git-filter-repo[1] instead.  filter-repo also allows
 reformatting of metadata for ease-of-reading and rewriting authorship
 info for non-"svn.authorsFile" users.
 
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 82cd573776..997548f5ed 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -425,9 +425,10 @@ post-rewrite
 
 This hook is invoked by commands that rewrite commits
 (linkgit:git-commit[1] when called with `--amend` and
-linkgit:git-rebase[1]; currently `git filter-branch` does 'not' call
-it!).  Its first argument denotes the command it was invoked by:
-currently one of `amend` or `rebase`.  Further command-dependent
+linkgit:git-rebase[1]; however, full-history (re)writing tools like
+linkgit:git-fast-import[1] or linkgit:git-filter-repo[1] typically do
+not call it!).  Its first argument denotes the command it was invoked
+by: currently one of `amend` or `rebase`.  Further command-dependent
 arguments may be passed in the future.
 
 The hook receives a list of the rewritten commits on stdin, in the
diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
index a3425f4770..19333fc8df 100644
--- a/contrib/svn-fe/svn-fe.txt
+++ b/contrib/svn-fe/svn-fe.txt
@@ -56,7 +56,7 @@ line.  This line has the form `git-svn-id: URL@REVNO UUID`.
 
 The resulting repository will generally require further processing
 to put each project in its own repository and to separate the history
-of each branch.  The 'git filter-branch --subdirectory-filter' command
+of each branch.  The 'git filter-repo --subdirectory-filter' command
 may be useful for this purpose.
 
 BUGS
@@ -67,5 +67,5 @@ The exit status does not reflect whether an error was detected.
 
 SEE ALSO
 --------
-git-svn(1), svn2git(1), svk(1), git-filter-branch(1), git-fast-import(1),
+git-svn(1), svn2git(1), svk(1), git-filter-repo(1), git-fast-import(1),
 https://svn.apache.org/repos/asf/subversion/trunk/notes/dump-load-format.txt
-- 
2.23.0.5.g775ebaa2a0

