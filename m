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
	by dcvr.yhbt.net (Postfix) with ESMTP id B93641F4BB
	for <e@80x24.org>; Thu, 29 Aug 2019 00:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfH2AHJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 20:07:09 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40720 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfH2AHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 20:07:09 -0400
Received: by mail-pl1-f194.google.com with SMTP id h3so699404pls.7
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 17:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aPJwZ8+2Ue3cHbZKPKN/5P3oNiR4MlNP7JCn9YqmAQc=;
        b=uULqXZ2tWETJFz/jg2rHWyyI4v4Sd3FfxpotMg5jMXuiTS+YNthMyCOeONI/BtntJJ
         I06/AQYvXue21MC3qFYVKAM8uA6ESRa9Mwou9UZPqHlSXJcP3OH8WaFRAFzQlPK9x5HE
         RiL1FgGLMrLgO7vLwsJtiHbrteNd2xZ5pTUkiz+2uZ8jueIVmBAJ5JNP6xU4oIo7hFwQ
         HLIfhWFCs8sRpJPCTiS2IV/XlwTQ2EyCGHDBad8NdD+sYDHH6AUNL531HwTw+n+FE/X0
         vtKXEn51178CeR98/WX85D1zrFjG9miDKFqNefATGgVzVQw+OVi1XqFP3x4PWS0D8jUD
         ocLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aPJwZ8+2Ue3cHbZKPKN/5P3oNiR4MlNP7JCn9YqmAQc=;
        b=qX9eyUSPITQQ0TEVWeXeHcx21VuLQTOOJbLErYARXw9xkjRaaW/WB2hUNHt38vfVOv
         uzoTHZJrNO5pBQd5MNivE8FTplcjQH4hZfMsJCHu1bm+uegGB6RnuEFY+/VEVyhTXsNe
         F43LFe9HXXGSd4nYLAmjAHDazR02wMo95l+9WwCNAuOzZinfsTzj3w9s43ytkZLJN2WP
         yyi/OQiojtjuBO6jgZmYhRqCDugm/EI+72Xx5NmBBVrj8FOfJ3IgFYwepH+7HZqZEjc8
         jbVcbkWNlRfHkHptMTWWn+sXAGI0miAe/0YYo4amVmokZLBiLwwGOs9PPLjtc8WWm58G
         vIkQ==
X-Gm-Message-State: APjAAAUXp3urhakCT8Nlcs7XcqkGIXBQQqH2F75K5cNnto+kKN4UHqwY
        wxXX14VCFnAzKbuJdiX5XsL1d+ie
X-Google-Smtp-Source: APXvYqxXf2p54AaPHthX2ZNs6tuZ0JYop4QnpJW3onHC8Z9zsb7bmrQoWziyTMIT8PSTgk/OIqy3CQ==
X-Received: by 2002:a17:902:8d8d:: with SMTP id v13mr6948394plo.137.1567037227165;
        Wed, 28 Aug 2019 17:07:07 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id m4sm305531pgs.71.2019.08.28.17.07.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Aug 2019 17:07:06 -0700 (PDT)
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
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 3/4] Recommend git-filter-repo instead of git-filter-branch
Date:   Wed, 28 Aug 2019 17:06:56 -0700
Message-Id: <20190829000657.26415-4-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.3.g59c7446927.dirty
In-Reply-To: <20190829000657.26415-1-newren@gmail.com>
References: <20190828002210.8862-1-newren@gmail.com>
 <20190829000657.26415-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

filter-branch suffers from a deluge of disguised dangers that disfigure
history rewrites (i.e. deviate from the deliberate changes).  Many of
these problems are unobtrusive and can easily go undiscovered until the
new repository is in use.  This can result in problems ranging from an
even messier history than what led folks to filter-branch in the first
place, to data loss or corruption.  These issues cannot be backward
compatibly fixed, so add a warning to both filter-branch and its manpage
recommending that another tool (such as filter-repo) be used instead.

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
 Documentation/git-fast-export.txt   |   6 +-
 Documentation/git-filter-branch.txt | 302 +++++++++++++++++++++++++---
 Documentation/git-gc.txt            |  17 +-
 Documentation/git-rebase.txt        |   3 +-
 Documentation/git-replace.txt       |  10 +-
 Documentation/git-svn.txt           |  10 +-
 Documentation/githooks.txt          |  10 +-
 contrib/svn-fe/svn-fe.txt           |   4 +-
 git-filter-branch.sh                |  13 ++
 9 files changed, 316 insertions(+), 59 deletions(-)

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
index 6b53dd7e06..c3f874b692 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -16,6 +16,22 @@ SYNOPSIS
 	[--original <namespace>] [-d <directory>] [-f | --force]
 	[--state-branch <branch>] [--] [<rev-list options>...]
 
+WARNING
+-------
+'git filter-branch' has a plethora of pitfalls that can produce non-obvious
+manglings of the intended history rewrite (and can leave you with little
+time to investigate such problems since it has such abysmal performance).
+These safety and performance issues cannot be backward compatibly fixed and
+as such, its use is not recommended.  Please use an alternative history
+filtering tool such as https://github.com/newren/git-filter-repo/[git
+filter-repo].  If you still need to use 'git filter-branch', please
+carefully read <<SAFETY>> (and <<PERFORMANCE>>) to learn about the land
+mines of filter-branch, and then vigilantly avoid as many of the hazards
+listed there as reasonably possible.
+
+https://public-inbox.org/git/CABPp-BEDOH-row-hxY4u_cP30ptqOpcCvPibwyZ2wBu142qUbA@mail.gmail.com/[detailing
+the land mines of filter-branch]
+
 DESCRIPTION
 -----------
 Lets you rewrite Git revision history by rewriting the branches mentioned
@@ -445,36 +461,262 @@ warned.
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
+[[PERFORMANCE]]
+PERFORMANCE
+-----------
+
+The performance of filter-branch is glacially slow; its design makes it
+impossible for a backward-compatible implementation to ever be fast:
+
+* In editing files, git-filter-branch by design checks out each and
+every commit as it existed in the original repo.  If your repo has 10\^5
+files and 10\^5 commits, but each commit only modifies 5 files, then
+git-filter-branch will make you do 10\^10 modifications, despite only
+having (at most) 5*10^5 unique blobs.
+
+* If you try and cheat and try to make filter-branch only work on
+files modified in a commit, then two things happen
+
+  . you run into problems with deletions whenever the user is simply
+    trying to rename files (because attempting to delete files that
+    don't exist looks like a no-op; it takes some chicanery to remap
+    deletes across file renames when the renames happen via arbitrary
+    user-provided shell)
+
+  . even if you succeed at the map-deletes-for-renames chicanery, you
+    still technically violate backward compatibility because users are
+    allowed to filter files in ways that depend upon topology of commits
+    instead of filtering solely based on file contents or names (though
+    I have never seen any user ever do this).
+
+* Even if you don't need to edit files but only want to e.g. rename or
+remove some and thus can avoid checking out each file (i.e. you can use
+--index-filter), you still are passing shell snippets for your filters.
+This means that for every commit, you have to have a prepared git repo
+where users can run git commands.  That's a lot of setup.  It also means
+you have to fork at least one process to run the user-provided shell
+snippet, and odds are that the user's shell snippet invokes lots of
+commands in some long pipeline, so you will have lots and lots of forks.
+For every. single. commit.  That's a massive amount of overhead to
+rename a few files.
+
+* filter-branch is written in shell, which is kind of slow.  Naturally,
+it makes sense to want to rewrite that in some other language.  However,
+filter-branch documentation states that several additional shell
+functions are provided for users to call, e.g. 'map', 'skip_commit',
+'git_commit_non_empty_tree'.  If filter-branch itself isn't a shell
+script, then in order to make those shell functions available to the
+users' shell snippets you have to prepend the shell definitions of these
+functions to every one of the users' shell snippets and thus make these
+special shell functions be parsed with each and every commit.
+
+* filter-branch provides a --setup option which is a shell snippet that
+can be sourced to make shell functions and variables available to all
+other filters.  If filter-branch is a shell script, it can simply eval
+this shell snippet once at the beginning.  If you try to fix performance
+by making filter-branch not be a shell script, then you have to prepend
+the setup shell snippet to all other filters and parse it with every
+single commit.
+
+* filter-branch writes lots of files to $workdir/../map/ to keep a
+mapping of commits, which it uses pruning commits and remapping to
+ancestors and the map() command more generally.  Other files like
+$tempdir/backup-refs, $tempdir/raw-refs, $tempdir/heads,
+$tempdir/tree-state are all created internally too.  It is possible
+(though strongly discouraged) that users could have accessed any of
+these directly.  Users even had a pointer to follow in the form of
+Documentation that the 'map' command existed, which naturally uses the
+$workdir/../map/* files.  So, even if you don't have to edit files, for
+strict backward compatibility you need to still write a bunch of files
+to disk somewhere and keep them updated for every commit.  You can claim
+it was an implementation detail that users should not have depended
+upon, but the truth is they've had a decade where they could so.  So, if
+you want full compatibility, it has to be there.  Besides, the
+regression tests depend on at least one of these details, specifying an
+--index-filter that reaches down and grabs backup-refs from $tempdir,
+and thus provides resourceful users who do google searches an example
+that there are files there for them to read and grab and use.  (And if
+you want to pass the existing regression tests, you have to at least put
+the backup-refs file there even if it's irrelevant to your
+implementation otherwise.)
+
+All of that said, performance of filter-branch could be improved by
+reimplementing it in a non-shell language and taking a couple small
+liberties with backward compatibility (such as having it only run
+filters on files changed within each commit).  filter-repo provides a
+demo script named
+https://github.com/newren/git-filter-repo/blob/master/contrib/filter-repo-demos/filter-lamely[filter-lamely]
+which does exactly that and which passes all the git-filter-branch
+regression tests.  It's much faster than git-filter-branch, though it
+suffers from all the same safety issues as git-filter-branch, and is
+still glacially slow compared to
+https://github.com/newren/git-filter-repo/[git filter-repo].
+
+[[SAFETY]]
+SAFETY
+------
+
+filter-branch is riddled with gotchas resulting in various ways to
+easily corrupt repos or end up with a mess worse than what you started
+with:
+
+* Someone can have a set of "working and tested filters" which they
+document or provide to a coworker, who then runs them on a different OS
+where the same commands are not working/tested (some examples in the
+git-filter-branch manpage are also affected by this).  BSD vs. GNU
+userland differences can really bite.  If you're lucky, you get ugly
+error messages spewed.  But just as likely, the commands either don't do
+the filtering requested, or silently corrupt making some unwanted
+change.  The unwanted change may only affect a few commits, so it's not
+necessarily obvious either.  (The fact that problems won't necessarily
+be obvious means they are likely to go unnoticed until the rewritten
+history is in use for quite a while, at which point it's really hard to
+justify another flag-day for another rewrite.)
+
+* Filenames with spaces (which are rare) are often mishandled by shell
+snippets since they cause problems for shell pipelines.  Not everyone is
+familiar with find -print0, xargs -0, ls-files -z, etc.  Even people who
+are familiar with these may assume such needs are not relevant because
+someone else renamed any such files in their repo back before the person
+doing the filtering joined the project.  And, often, even those familiar
+with handling arguments with spaces my not do so just because they
+aren't in the mindset of thinking about everything that could possibly
+go wrong.
+
+* Non-ascii filenames (which are rare) can be silently removed despite
+being in a desired directory.  The desire to select paths to keep often
+use pipelines like `git ls-files | grep -v ^WANTED_DIR/ | xargs git rm`.
+ls-files will only quote filenames if needed so folks may not notice
+that one of the files didn't match the regex, again until it's much too
+late.  Yes, someone who knows about core.quotePath can avoid this
+(unless they have other special characters like \t, \n, or "), and
+people who use ls-files -z with something other than grep can avoid
+this, but that doesn't mean they will.
+
+* Similarly, when moving files around, one can find that filenames with
+non-ascii or special characters end up in a different directory, one
+that includes a double quote character.  (This is technically the same
+issue as above with quoting, but perhaps an interesting different way
+that it can and has manifested as a problem.)
+
+* It's far too easy to accidentally mix up old and new history.  It's
+still possible with any tool, but filter-branch almost invites it.  If
+we're lucky, the only downside is users getting frustrated that they
+don't know how to shrink their repo and remove the old stuff.  If we're
+unlucky, they merge old and new history and end up with multiple
+"copies" of each commit, some of which have unwanted or sensitive files
+and others which don't.  This comes about in multiple different ways:
+
+  ** the default to only doing a partial history rewrite ('--all' is not
+     the default and over 80% of the examples in the manpage don't use
+     it)
+
+  ** the fact that there's no automatic post-run cleanup
+
+  ** the fact that --tag-name-filter (when used to rename tags) doesn't
+     remove the old tags but just adds new ones with the new name (this
+     manpage has documented this for a long time so it's presumably not
+     a "bug" even though it feels like it)
+
+  ** the fact that little educational information is provided to inform
+     users of the ramifications of a rewrite and how to avoid mixing old
+     and new history.  For example, this man page discusses how users
+     need to understand that they need to rebase their changes for all
+     their branches on top of new history (or delete and reclone), but
+     that's only one of multiple concerns to consider.  See the
+     "DISCUSSION" section of the git filter-repo manual page for more
+     details.
+
+* Annotated tags can be accidentally converted to lightweight tags, due
+to either of two issues:
+
+  . Someone can do a history rewrite, realize they messed up, restore
+    from the backups in refs/original/, and then redo their
+    filter-branch command.  (The backup in refs/original/ is not a real
+    backup; it dereferences tags first.)
+
+  . Running filter-branch with either --tags or --all in your <rev-list
+    options>.  In order to retain annotated tags as annotated, you must
+    use --tag-name-filter (and must not have restored from
+    refs/original/ in a previously botched rewrite).
+
+* Any commit messages that specify an encoding will become corrupted
+by the rewrite; filter-branch ignores the encoding, takes the original
+bytes, and feeds it to commit-tree without telling it the proper
+encoding.  (This happens whether or not --msg-filter is used, though I
+suspect --msg-filter provides additional ways to really mess things
+up).
+
+* Commit messages (even if they are all UTF-8) by default become
+corrupted due to not being updated -- any references to other commit
+hashes in commit messages will now refer to no-longer-extant commits.
+
+* There are no facilities for helping users find what unwanted crud they
+should delete, which means they are much more likely to have incomplete
+or partial cleanups that sometimes result in confusion and people
+wasting time trying to understand.  (For example, folks tend to just
+look for big files to delete instead of big directories or extensions,
+and once they do so, then sometime later folks using the new repository
+who are going through history will notice a build artifact directory
+that has some files but not others, or a cache of dependencies
+(node_modules or similar) which couldn't have ever been functional since
+it's missing some files.)
+
+* If --prune-empty isn't specified, then the filtering process can
+create hoards of confusing empty commits
+
+* If --prune-empty is specified, then intentionally placed empty
+commits from before the filtering operation are also pruned instead of
+just pruning commits that became empty due to filtering rules.
+
+* If --prune empty is specified, sometimes empty commits are missed
+and left around anyway (a somewhat rare bug, but it happens...)
+
+* A minor issue, but users who have a goal to update all names and
+emails in a repository may be led to --env-filter which will only update
+authors and committers, missing taggers.
+
+* If the user provides a --tag-name-filter that maps multiple tags to
+the same name, no warning or error is provided; filter-branch simply
+overwrites each tag in some undocumented pre-defined order resulting in
+only one tag at the end.  If you try to "fix" this bug in filter-branch
+and make it error out and warn the user instead, one of the
+filter-branch regression tests will fail.  (So, if you are trying to
+make a backward compatible reimplementation you have to add extra code
+to detect collisions and make sure that only the lexicographically last
+one is rewritten to avoid fast-import from seeing both since fast-import
+will naturally do the sane thing and error out if told to write the same
+tag more than once.)
+
+Also, the poor performance of filter-branch often leads to safety issues:
+
+* Coming up with the correct shell snippet to do the filtering you want
+is sometimes difficult unless you're just doing a trivial modification
+such as deleting a couple files.  People have often come to me for help,
+so I should be practiced and an expert, but even for fairly simple cases
+I still sometimes take over 10 minutes and several iterations to get
+the right commands -- and that's assuming they are working on a tiny
+repository.  Unfortunately, people often learn if the snippet is right
+or wrong by trying it out, but the rightness or wrongness can vary
+depending on special circumstances (spaces in filenames, non-ascii
+filenames, funny author names or emails, invalid timezones, presence of
+grafts or replace objects, etc.), meaning they may have to wait a long
+time, hit an error, then restart.  The performance of filter-branch is
+so bad that this cycle is painful, reducing the time available to
+carefully re-check (to say nothing about what it does to the patience of
+the person doing the rewrite even if they do technically have more time
+available).  This problem is extra compounded because errors from broken
+filters may not be shown for a long time and/or get lost in a sea of
+output.  Even worse, broken filters often just result in silent
+incorrect rewrites.
+
+* To top it all off, even when users finally find working commands, they
+naturally want to share them.  But they may be unaware that their repo
+didn't have some special cases that someone else's does.  So, when
+someone else with a different repository runs the same commands, they
+get hit by the problems above.  Or, the user just runs commands that
+really were vetted for special cases, but they run it on a different OS
+where it doesn't work, as noted above.
 
 GIT
 ---
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
index 6156609cf7..a8cfc0ad82 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -832,7 +832,8 @@ Hard case: The changes are not the same.::
 	This happens if the 'subsystem' rebase had conflicts, or used
 	`--interactive` to omit, edit, squash, or fixup commits; or
 	if the upstream used one of `commit --amend`, `reset`, or
-	`filter-branch`.
+	a full history rewriting command like
+	https://github.com/newren/git-filter-repo[`filter-repo`].
 
 
 The easy case
diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index 246dc9943c..f271d758c3 100644
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
+https://github.com/newren/git-filter-repo[git-filter-repo], among other git commands, can be used to
+create replacement objects from existing objects. The `--edit` option
+can also be used with 'git replace' to create a replacement object by
 editing an existing object.
 
 If you want to replace many blobs, trees or commits that are part of a
@@ -148,13 +148,13 @@ pending objects.
 SEE ALSO
 --------
 linkgit:git-hash-object[1]
-linkgit:git-filter-branch[1]
 linkgit:git-rebase[1]
 linkgit:git-tag[1]
 linkgit:git-branch[1]
 linkgit:git-commit[1]
 linkgit:git-var[1]
 linkgit:git[1]
+https://github.com/newren/git-filter-repo[git-filter-repo]
 
 GIT
 ---
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 30711625fd..53774f5b64 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -769,11 +769,11 @@ option for (hopefully) obvious reasons.
 +
 This option is NOT recommended as it makes it difficult to track down
 old references to SVN revision numbers in existing documentation, bug
-reports and archives.  If you plan to eventually migrate from SVN to Git
-and are certain about dropping SVN history, consider
-linkgit:git-filter-branch[1] instead.  filter-branch also allows
-reformatting of metadata for ease-of-reading and rewriting authorship
-info for non-"svn.authorsFile" users.
+reports, and archives.  If you plan to eventually migrate from SVN to
+Git and are certain about dropping SVN history, consider
+https://github.com/newren/git-filter-repo[git-filter-repo] instead.
+filter-repo also allows reformatting of metadata for ease-of-reading
+and rewriting authorship info for non-"svn.authorsFile" users.
 
 svn.useSvmProps::
 svn-remote.<name>.useSvmProps::
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 82cd573776..5a789c91df 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -425,10 +425,12 @@ post-rewrite
 
 This hook is invoked by commands that rewrite commits
 (linkgit:git-commit[1] when called with `--amend` and
-linkgit:git-rebase[1]; currently `git filter-branch` does 'not' call
-it!).  Its first argument denotes the command it was invoked by:
-currently one of `amend` or `rebase`.  Further command-dependent
-arguments may be passed in the future.
+linkgit:git-rebase[1]; however, full-history (re)writing tools like
+linkgit:git-fast-import[1] or
+https://github.com/newren/git-filter-repo[git-filter-repo] typically
+do not call it!).  Its first argument denotes the command it was
+invoked by: currently one of `amend` or `rebase`.  Further
+command-dependent arguments may be passed in the future.
 
 The hook receives a list of the rewritten commits on stdin, in the
 format
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
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 5c5afa2b98..f805965d87 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -83,6 +83,19 @@ set_ident () {
 	finish_ident COMMITTER
 }
 
+if [ -z "$FILTER_BRANCH_SQUELCH_WARNING" -a \
+     -z "$GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS" ]; then
+	cat <<EOF
+WARNING: git-filter-branch has a glut of gotchas generating mangled history
+         rewrites.  Please use an alternative filtering tool such as 'git
+         filter-repo' (https://github.com/newren/git-filter-repo/) instead.
+         See the filter-branch manual page for more details; to squelch
+         this warning, set FILTER_BRANCH_SQUELCH_WARNING=1.
+
+EOF
+	sleep 5
+fi
+
 USAGE="[--setup <command>] [--subdirectory-filter <directory>] [--env-filter <command>]
 	[--tree-filter <command>] [--index-filter <command>]
 	[--parent-filter <command>] [--msg-filter <command>]
-- 
2.23.0.3.g59c7446927.dirty

