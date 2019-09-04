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
	by dcvr.yhbt.net (Postfix) with ESMTP id 329F51F4B9
	for <e@80x24.org>; Wed,  4 Sep 2019 22:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbfIDWcv (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 18:32:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44893 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbfIDWcu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 18:32:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id q21so308315pfn.11
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 15:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F2xkUkDkedfFjKFe10DMHBo/SPZFod+cFGYOY2a7QH0=;
        b=IXyXIePtMsAVAG6zPxPTp8k8rFbSqy5F5sOCJ5yplgdH3bpOi1w3vmp3jAnPt2z2SU
         no/6bZa3A3HkMxM4Urr0Out/1oAZhUKsyfPE05krKew8QwzRZzBHsM8lqnF9VDeg35GO
         dvMRsqEMdkTW9qxSphkp+dELnuLLX38z2LXb3MaBngzB02+FTiiWJh/zpvckW1hsSRcG
         OW1DeAw7+06EKvM2CVsoP+YUuVeeeb2CrFHNnteiV6hAyDfHRdqf3XcK1yBbdlJZVWtF
         dfgQMhh5OVl1Z57NPtfpOkbcHDdhshO+BprtTEYsIh9T87Q0uM3wrN6GtGrYFCciFfp0
         1qtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F2xkUkDkedfFjKFe10DMHBo/SPZFod+cFGYOY2a7QH0=;
        b=E8ozDE2oKEN4YliOnXhf5iVnsppEcx9U8i7jeJtHF0fhiWV9FHJHLamLsms9XcXg0d
         EtjLk359QSB9kqXuDwda5CxK6/SLJCBHrCmed9rOuphQJOnoMNReSf/i026pm772XQvA
         Gfs9SDk2q6OaObBWgbBzONmqxnozdEEz6BI0esfsUWWsZN1nnmCUdmgaJB4hgGfdi4ut
         Q70zhYYuA9YhFly9ehXmfas8QEtuvHrU5TwVcP3wEFZRVY5fnBqKIxLGNti3Of3chDm/
         pMUVjGO7aJr1lYBzVHQnx3a0g4vkKamW/RLjRfvBhhJIKg2zn8vaY4H9u41QxEFS2t+l
         RQMg==
X-Gm-Message-State: APjAAAUwiX1fE22zq0n716bpG5RJt6PRUQTmqDSwFCBMXwD60VhHIwuX
        sfgEeZonj08SpC6BDUeEx3rVb/OF
X-Google-Smtp-Source: APXvYqzoM/blf7hxAZpnKuNCge/m8r7lLt1SUESBmDBeJlkl4MoowJPkiK+hMYDOkfV9HBZvfEgA/Q==
X-Received: by 2002:a63:481c:: with SMTP id v28mr401102pga.50.1567636369632;
        Wed, 04 Sep 2019 15:32:49 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id v12sm135898pgr.86.2019.09.04.15.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Sep 2019 15:32:48 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v6 2/3] Recommend git-filter-repo instead of git-filter-branch
Date:   Wed,  4 Sep 2019 15:32:38 -0700
Message-Id: <20190904223239.571-3-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.3.g19edb94ec2
In-Reply-To: <20190904223239.571-1-newren@gmail.com>
References: <20190903185524.13467-1-newren@gmail.com>
 <20190904223239.571-1-newren@gmail.com>
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
 Documentation/git-filter-branch.txt | 273 +++++++++++++++++++++++++---
 Documentation/git-gc.txt            |  17 +-
 Documentation/git-rebase.txt        |   3 +-
 Documentation/git-replace.txt       |  10 +-
 Documentation/git-svn.txt           |  10 +-
 Documentation/githooks.txt          |  10 +-
 contrib/svn-fe/svn-fe.txt           |   4 +-
 git-filter-branch.sh                |  14 ++
 9 files changed, 288 insertions(+), 59 deletions(-)

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
index 6b53dd7e06..5876598852 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -16,6 +16,19 @@ SYNOPSIS
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
 DESCRIPTION
 -----------
 Lets you rewrite Git revision history by rewriting the branches mentioned
@@ -445,36 +458,236 @@ warned.
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
+The performance of git-filter-branch is glacially slow; its design makes it
+impossible for a backward-compatible implementation to ever be fast:
+
+* In editing files, git-filter-branch by design checks out each and
+every commit as it existed in the original repo.  If your repo has 10\^5
+files and 10\^5 commits, but each commit only modifies 5 files, then
+git-filter-branch will make you do 10\^10 modifications, despite only
+having (at most) 5*10^5 unique blobs.
+
+* If you try and cheat and try to make git-filter-branch only work on
+files modified in a commit, then two things happen
+
+  ** you run into problems with deletions whenever the user is simply
+     trying to rename files (because attempting to delete files that
+     don't exist looks like a no-op; it takes some chicanery to remap
+     deletes across file renames when the renames happen via arbitrary
+     user-provided shell)
+
+  ** even if you succeed at the map-deletes-for-renames chicanery, you
+     still technically violate backward compatibility because users are
+     allowed to filter files in ways that depend upon topology of
+     commits instead of filtering solely based on file contents or names
+     (though this has not been observed in the wild).
+
+* Even if you don't need to edit files but only want to e.g. rename or
+remove some and thus can avoid checking out each file (i.e. you can use
+--index-filter), you still are passing shell snippets for your filters.
+This means that for every commit, you have to have a prepared git repo
+where those filters can be run.  That's a significant setup.
+
+* Further, several additional files are created or updated per commit by
+git-filter-branch.  Some of these are for supporting the convenience
+functions provided by git-filter-branch (such as map()), while others
+are for keeping track of internal state (but could have also been
+accessed by user filters; one of git-filter-branch's regression tests
+does so).  This essentially amounts to using the filesystem as an IPC
+mechanism between git-filter-branch and the user-provided filters.
+Disks tend to be a slow IPC mechanism, and writing these files also
+effectively represents a forced synchronization point between separate
+processes that we hit with every commit.
+
+* The user-provided shell commands will likely involve a pipeline of
+commands, resulting in the creation of many processes per commit.
+Creating and running another process takes a widely varying amount of
+time between operating systems, but on any platform it is very slow
+relative to invoking a function.
+
+* git-filter-branch itself is written in shell, which is kind of slow.
+This is the one performance issue that could be backward-compatibly
+fixed, but compared to the above problems that are intrinsic to the
+design of git-filter-branch, the language of the tool itself is a
+relatively minor issue.
+
+  ** Side note: Unfortunately, people tend to fixate on the
+     written-in-shell aspect and periodically ask if git-filter-branch
+     could be rewritten in another language to fix the performance
+     issues.  Not only does that ignore the bigger intrinsic problems
+     with the design, it'd help less than you'd expect: if
+     git-filter-branch itself were not shell, then the convenience
+     functions (map(), skip_commit(), etc) and the `--setup` argument
+     could no longer be executed once at the beginning of the program
+     but would instead need to be prepended to every user filter (and
+     thus re-executed with every commit).
+
+The https://github.com/newren/git-filter-repo/[git filter-repo] tool is
+an alternative to git-filter-branch which does not suffer from these
+performance problems or the safety problems (mentioned below). For those
+with existing tooling which relies upon git-filter-branch, 'git
+repo-filter' also provides
+https://github.com/newren/git-filter-repo/blob/master/contrib/filter-repo-demos/filter-lamely[filter-lamely],
+a drop-in git-filter-branch replacement (with a few caveats).  While
+filter-lamely suffers from all the same safety issues as
+git-filter-branch, it at least ameloriates the performance issues a
+little.
+
+[[SAFETY]]
+SAFETY
+------
+
+git-filter-branch is riddled with gotchas resulting in various ways to
+easily corrupt repos or end up with a mess worse than what you started
+with:
+
+* Someone can have a set of "working and tested filters" which they
+document or provide to a coworker, who then runs them on a different OS
+where the same commands are not working/tested (some examples in the
+git-filter-branch manpage are also affected by this).  BSD vs. GNU
+userland differences can really bite.  If lucky, error messages are
+spewed.  But just as likely, the commands either don't do the filtering
+requested, or silently corrupt by making some unwanted change.  The
+unwanted change may only affect a few commits, so it's not necessarily
+obvious either.  (The fact that problems won't necessarily be obvious
+means they are likely to go unnoticed until the rewritten history is in
+use for quite a while, at which point it's really hard to justify
+another flag-day for another rewrite.)
+
+* Filenames with spaces are often mishandled by shell snippets since
+they cause problems for shell pipelines.  Not everyone is familiar with
+find -print0, xargs -0, git-ls-files -z, etc.  Even people who are
+familiar with these may assume such flags are not relevant because
+someone else renamed any such files in their repo back before the person
+doing the filtering joined the project.  And often, even those familiar
+with handling arguments with spaces may not do so just because they
+aren't in the mindset of thinking about everything that could possibly
+go wrong.
+
+* Non-ascii filenames can be silently removed despite being in a desired
+directory.  Keeping only wanted paths is often done using pipelines like
+`git ls-files | grep -v ^WANTED_DIR/ | xargs git rm`.  ls-files will
+only quote filenames if needed, so folks may not notice that one of the
+files didn't match the regex (at least not until it's much too late).
+Yes, someone who knows about core.quotePath can avoid this (unless they
+have other special characters like \t, \n, or "), and people who use
+ls-files -z with something other than grep can avoid this, but that
+doesn't mean they will.
+
+* Similarly, when moving files around, one can find that filenames with
+non-ascii or special characters end up in a different directory, one
+that includes a double quote character.  (This is technically the same
+issue as above with quoting, but perhaps an interesting different way
+that it can and has manifested as a problem.)
+
+* It's far too easy to accidentally mix up old and new history.  It's
+still possible with any tool, but git-filter-branch almost invites it.
+If lucky, the only downside is users getting frustrated that they don't
+know how to shrink their repo and remove the old stuff.  If unlucky,
+they merge old and new history and end up with multiple "copies" of each
+commit, some of which have unwanted or sensitive files and others which
+don't.  This comes about in multiple different ways:
+
+  ** the default to only doing a partial history rewrite ('--all' is not
+     the default and few examples show it)
+
+  ** the fact that there's no automatic post-run cleanup
+
+  ** the fact that --tag-name-filter (when used to rename tags) doesn't
+     remove the old tags but just adds new ones with the new name
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
+  ** Someone can do a history rewrite, realize they messed up, restore
+     from the backups in refs/original/, and then redo their
+     git-filter-branch command.  (The backup in refs/original/ is not a
+     real backup; it dereferences tags first.)
+
+  ** Running git-filter-branch with either --tags or --all in your
+     <rev-list options>.  In order to retain annotated tags as
+     annotated, you must use --tag-name-filter (and must not have
+     restored from refs/original/ in a previously botched rewrite).
+
+* Any commit messages that specify an encoding will become corrupted
+by the rewrite; git-filter-branch ignores the encoding, takes the original
+bytes, and feeds it to commit-tree without telling it the proper
+encoding.  (This happens whether or not --msg-filter is used.)
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
+the same name, no warning or error is provided; git-filter-branch simply
+overwrites each tag in some undocumented pre-defined order resulting in
+only one tag at the end.  (A git-filter-branch regression test requires
+this surprising behavior.)
+
+Also, the poor performance of git-filter-branch often leads to safety
+issues:
+
+* Coming up with the correct shell snippet to do the filtering you want
+is sometimes difficult unless you're just doing a trivial modification
+such as deleting a couple files.  Unfortunately, people often learn if
+the snippet is right or wrong by trying it out, but the rightness or
+wrongness can vary depending on special circumstances (spaces in
+filenames, non-ascii filenames, funny author names or emails, invalid
+timezones, presence of grafts or replace objects, etc.), meaning they
+may have to wait a long time, hit an error, then restart.  The
+performance of git-filter-branch is so bad that this cycle is painful,
+reducing the time available to carefully re-check (to say nothing about
+what it does to the patience of the person doing the rewrite even if
+they do technically have more time available).  This problem is extra
+compounded because errors from broken filters may not be shown for a
+long time and/or get lost in a sea of output.  Even worse, broken
+filters often just result in silent incorrect rewrites.
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
index 5c5afa2b98..fea7964617 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -83,6 +83,20 @@ set_ident () {
 	finish_ident COMMITTER
 }
 
+if test -z "$FILTER_BRANCH_SQUELCH_WARNING$GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS"
+then
+	cat <<EOF
+WARNING: git-filter-branch has a glut of gotchas generating mangled history
+	 rewrites.  Hit Ctrl-C before proceeding to abort, then use an
+	 alternative filtering tool such as 'git filter-repo'
+	 (https://github.com/newren/git-filter-repo/) instead.  See the
+	 filter-branch manual page for more details; to squelch this warning,
+	 set FILTER_BRANCH_SQUELCH_WARNING=1.
+EOF
+	sleep 10
+	printf "Proceeding with filter-branch...\n\n"
+fi
+
 USAGE="[--setup <command>] [--subdirectory-filter <directory>] [--env-filter <command>]
 	[--tree-filter <command>] [--index-filter <command>]
 	[--parent-filter <command>] [--msg-filter <command>]
-- 
2.23.0.3.g19edb94ec2

