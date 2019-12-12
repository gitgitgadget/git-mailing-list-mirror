Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD7FC43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 20:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C2F2173E
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 20:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbfLLUsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 15:48:04 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:59118 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730749AbfLLUsE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 15:48:04 -0500
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:d1:f360:33e:2802:50eb:d77d])
        by smtp2-g21.free.fr (Postfix) with ESMTP id EF272200408;
        Thu, 12 Dec 2019 21:47:31 +0100 (CET)
From:   =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH 3/3] doc: indent multi-line items in list
Date:   Thu, 12 Dec 2019 21:46:55 +0100
Message-Id: <20191212204655.10425-3-jn.avila@free.fr>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191212204655.10425-1-jn.avila@free.fr>
References: <20191212204655.10425-1-jn.avila@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Although Asciidoc allows to not indent following lines in a list item,
it is clearer and safer to follow the recommended rule.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/diff-format.txt       |   2 +-
 Documentation/git-filter-branch.txt | 257 ++++++++++++++--------------
 2 files changed, 134 insertions(+), 125 deletions(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index 4d846d7346..fbbd410a84 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -61,7 +61,7 @@ Possible status letters are:
 - R: renaming of a file
 - T: change in the type of the file
 - U: file is unmerged (you must complete the merge before it can
-be committed)
+  be committed)
 - X: "unknown" change type (most probably a bug, please report it)
 
 Status letters C and R are always followed by a score (denoting the
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 5876598852..ee889dd033 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -466,13 +466,13 @@ The performance of git-filter-branch is glacially slow; its design makes it
 impossible for a backward-compatible implementation to ever be fast:
 
 * In editing files, git-filter-branch by design checks out each and
-every commit as it existed in the original repo.  If your repo has 10\^5
-files and 10\^5 commits, but each commit only modifies 5 files, then
-git-filter-branch will make you do 10\^10 modifications, despite only
-having (at most) 5*10^5 unique blobs.
+  every commit as it existed in the original repo.  If your repo has
+  10\^5 files and 10\^5 commits, but each commit only modifies 5
+  files, then git-filter-branch will make you do 10\^10 modifications,
+  despite only having (at most) 5*10^5 unique blobs.
 
 * If you try and cheat and try to make git-filter-branch only work on
-files modified in a commit, then two things happen
+  files modified in a commit, then two things happen
 
   ** you run into problems with deletions whenever the user is simply
      trying to rename files (because attempting to delete files that
@@ -481,39 +481,41 @@ files modified in a commit, then two things happen
      user-provided shell)
 
   ** even if you succeed at the map-deletes-for-renames chicanery, you
-     still technically violate backward compatibility because users are
-     allowed to filter files in ways that depend upon topology of
-     commits instead of filtering solely based on file contents or names
-     (though this has not been observed in the wild).
+     still technically violate backward compatibility because users
+     are allowed to filter files in ways that depend upon topology of
+     commits instead of filtering solely based on file contents or
+     names (though this has not been observed in the wild).
 
 * Even if you don't need to edit files but only want to e.g. rename or
-remove some and thus can avoid checking out each file (i.e. you can use
---index-filter), you still are passing shell snippets for your filters.
-This means that for every commit, you have to have a prepared git repo
-where those filters can be run.  That's a significant setup.
-
-* Further, several additional files are created or updated per commit by
-git-filter-branch.  Some of these are for supporting the convenience
-functions provided by git-filter-branch (such as map()), while others
-are for keeping track of internal state (but could have also been
-accessed by user filters; one of git-filter-branch's regression tests
-does so).  This essentially amounts to using the filesystem as an IPC
-mechanism between git-filter-branch and the user-provided filters.
-Disks tend to be a slow IPC mechanism, and writing these files also
-effectively represents a forced synchronization point between separate
-processes that we hit with every commit.
+  remove some and thus can avoid checking out each file (i.e. you can
+  use --index-filter), you still are passing shell snippets for your
+  filters.  This means that for every commit, you have to have a
+  prepared git repo where those filters can be run.  That's a
+  significant setup.
+
+* Further, several additional files are created or updated per commit
+  by git-filter-branch.  Some of these are for supporting the
+  convenience functions provided by git-filter-branch (such as map()),
+  while others are for keeping track of internal state (but could have
+  also been accessed by user filters; one of git-filter-branch's
+  regression tests does so).  This essentially amounts to using the
+  filesystem as an IPC mechanism between git-filter-branch and the
+  user-provided filters.  Disks tend to be a slow IPC mechanism, and
+  writing these files also effectively represents a forced
+  synchronization point between separate processes that we hit with
+  every commit.
 
 * The user-provided shell commands will likely involve a pipeline of
-commands, resulting in the creation of many processes per commit.
-Creating and running another process takes a widely varying amount of
-time between operating systems, but on any platform it is very slow
-relative to invoking a function.
+  commands, resulting in the creation of many processes per commit.
+  Creating and running another process takes a widely varying amount
+  of time between operating systems, but on any platform it is very
+  slow relative to invoking a function.
 
 * git-filter-branch itself is written in shell, which is kind of slow.
-This is the one performance issue that could be backward-compatibly
-fixed, but compared to the above problems that are intrinsic to the
-design of git-filter-branch, the language of the tool itself is a
-relatively minor issue.
+  This is the one performance issue that could be backward-compatibly
+  fixed, but compared to the above problems that are intrinsic to the
+  design of git-filter-branch, the language of the tool itself is a
+  relatively minor issue.
 
   ** Side note: Unfortunately, people tend to fixate on the
      written-in-shell aspect and periodically ask if git-filter-branch
@@ -546,51 +548,55 @@ easily corrupt repos or end up with a mess worse than what you started
 with:
 
 * Someone can have a set of "working and tested filters" which they
-document or provide to a coworker, who then runs them on a different OS
-where the same commands are not working/tested (some examples in the
-git-filter-branch manpage are also affected by this).  BSD vs. GNU
-userland differences can really bite.  If lucky, error messages are
-spewed.  But just as likely, the commands either don't do the filtering
-requested, or silently corrupt by making some unwanted change.  The
-unwanted change may only affect a few commits, so it's not necessarily
-obvious either.  (The fact that problems won't necessarily be obvious
-means they are likely to go unnoticed until the rewritten history is in
-use for quite a while, at which point it's really hard to justify
-another flag-day for another rewrite.)
+  document or provide to a coworker, who then runs them on a different
+  OS where the same commands are not working/tested (some examples in
+  the git-filter-branch manpage are also affected by this).
+  BSD vs. GNU userland differences can really bite.  If lucky, error
+  messages are spewed.  But just as likely, the commands either don't
+  do the filtering requested, or silently corrupt by making some
+  unwanted change.  The unwanted change may only affect a few commits,
+  so it's not necessarily obvious either.  (The fact that problems
+  won't necessarily be obvious means they are likely to go unnoticed
+  until the rewritten history is in use for quite a while, at which
+  point it's really hard to justify another flag-day for another
+  rewrite.)
 
 * Filenames with spaces are often mishandled by shell snippets since
-they cause problems for shell pipelines.  Not everyone is familiar with
-find -print0, xargs -0, git-ls-files -z, etc.  Even people who are
-familiar with these may assume such flags are not relevant because
-someone else renamed any such files in their repo back before the person
-doing the filtering joined the project.  And often, even those familiar
-with handling arguments with spaces may not do so just because they
-aren't in the mindset of thinking about everything that could possibly
-go wrong.
-
-* Non-ascii filenames can be silently removed despite being in a desired
-directory.  Keeping only wanted paths is often done using pipelines like
-`git ls-files | grep -v ^WANTED_DIR/ | xargs git rm`.  ls-files will
-only quote filenames if needed, so folks may not notice that one of the
-files didn't match the regex (at least not until it's much too late).
-Yes, someone who knows about core.quotePath can avoid this (unless they
-have other special characters like \t, \n, or "), and people who use
-ls-files -z with something other than grep can avoid this, but that
-doesn't mean they will.
-
-* Similarly, when moving files around, one can find that filenames with
-non-ascii or special characters end up in a different directory, one
-that includes a double quote character.  (This is technically the same
-issue as above with quoting, but perhaps an interesting different way
-that it can and has manifested as a problem.)
+  they cause problems for shell pipelines.  Not everyone is familiar
+  with find -print0, xargs -0, git-ls-files -z, etc.  Even people who
+  are familiar with these may assume such flags are not relevant
+  because someone else renamed any such files in their repo back
+  before the person doing the filtering joined the project.  And
+  often, even those familiar with handling arguments with spaces may
+  not do so just because they aren't in the mindset of thinking about
+  everything that could possibly go wrong.
+
+* Non-ascii filenames can be silently removed despite being in a
+  desired directory.  Keeping only wanted paths is often done using
+  pipelines like `git ls-files | grep -v ^WANTED_DIR/ | xargs git rm`.
+  ls-files will only quote filenames if needed, so folks may not
+  notice that one of the files didn't match the regex (at least not
+  until it's much too late).  Yes, someone who knows about
+  core.quotePath can avoid this (unless they have other special
+  characters like \t, \n, or "), and people who use ls-files -z with
+  something other than grep can avoid this, but that doesn't mean they
+  will.
+
+* Similarly, when moving files around, one can find that filenames
+  with non-ascii or special characters end up in a different
+  directory, one that includes a double quote character.  (This is
+  technically the same issue as above with quoting, but perhaps an
+  interesting different way that it can and has manifested as a
+  problem.)
 
 * It's far too easy to accidentally mix up old and new history.  It's
-still possible with any tool, but git-filter-branch almost invites it.
-If lucky, the only downside is users getting frustrated that they don't
-know how to shrink their repo and remove the old stuff.  If unlucky,
-they merge old and new history and end up with multiple "copies" of each
-commit, some of which have unwanted or sensitive files and others which
-don't.  This comes about in multiple different ways:
+  still possible with any tool, but git-filter-branch almost
+  invites it.  If lucky, the only downside is users getting frustrated
+  that they don't know how to shrink their repo and remove the old
+  stuff.  If unlucky, they merge old and new history and end up with
+  multiple "copies" of each commit, some of which have unwanted or
+  sensitive files and others which don't.  This comes about in
+  multiple different ways:
 
   ** the default to only doing a partial history rewrite ('--all' is not
      the default and few examples show it)
@@ -609,8 +615,8 @@ don't.  This comes about in multiple different ways:
      "DISCUSSION" section of the git filter-repo manual page for more
      details.
 
-* Annotated tags can be accidentally converted to lightweight tags, due
-to either of two issues:
+* Annotated tags can be accidentally converted to lightweight tags,
+  due to either of two issues:
 
   ** Someone can do a history rewrite, realize they messed up, restore
      from the backups in refs/original/, and then redo their
@@ -623,71 +629,74 @@ to either of two issues:
      restored from refs/original/ in a previously botched rewrite).
 
 * Any commit messages that specify an encoding will become corrupted
-by the rewrite; git-filter-branch ignores the encoding, takes the original
-bytes, and feeds it to commit-tree without telling it the proper
-encoding.  (This happens whether or not --msg-filter is used.)
+  by the rewrite; git-filter-branch ignores the encoding, takes the
+  original bytes, and feeds it to commit-tree without telling it the
+  proper encoding.  (This happens whether or not --msg-filter is
+  used.)
 
 * Commit messages (even if they are all UTF-8) by default become
-corrupted due to not being updated -- any references to other commit
-hashes in commit messages will now refer to no-longer-extant commits.
-
-* There are no facilities for helping users find what unwanted crud they
-should delete, which means they are much more likely to have incomplete
-or partial cleanups that sometimes result in confusion and people
-wasting time trying to understand.  (For example, folks tend to just
-look for big files to delete instead of big directories or extensions,
-and once they do so, then sometime later folks using the new repository
-who are going through history will notice a build artifact directory
-that has some files but not others, or a cache of dependencies
-(node_modules or similar) which couldn't have ever been functional since
-it's missing some files.)
+  corrupted due to not being updated -- any references to other commit
+  hashes in commit messages will now refer to no-longer-extant
+  commits.
+
+* There are no facilities for helping users find what unwanted crud
+  they should delete, which means they are much more likely to have
+  incomplete or partial cleanups that sometimes result in confusion
+  and people wasting time trying to understand.  (For example, folks
+  tend to just look for big files to delete instead of big directories
+  or extensions, and once they do so, then sometime later folks using
+  the new repository who are going through history will notice a build
+  artifact directory that has some files but not others, or a cache of
+  dependencies (node_modules or similar) which couldn't have ever been
+  functional since it's missing some files.)
 
 * If --prune-empty isn't specified, then the filtering process can
-create hoards of confusing empty commits
+  create hoards of confusing empty commits
 
 * If --prune-empty is specified, then intentionally placed empty
-commits from before the filtering operation are also pruned instead of
-just pruning commits that became empty due to filtering rules.
+  commits from before the filtering operation are also pruned instead
+  of just pruning commits that became empty due to filtering rules.
 
 * If --prune empty is specified, sometimes empty commits are missed
-and left around anyway (a somewhat rare bug, but it happens...)
+  and left around anyway (a somewhat rare bug, but it happens...)
 
 * A minor issue, but users who have a goal to update all names and
-emails in a repository may be led to --env-filter which will only update
-authors and committers, missing taggers.
+  emails in a repository may be led to --env-filter which will only
+  update authors and committers, missing taggers.
 
 * If the user provides a --tag-name-filter that maps multiple tags to
-the same name, no warning or error is provided; git-filter-branch simply
-overwrites each tag in some undocumented pre-defined order resulting in
-only one tag at the end.  (A git-filter-branch regression test requires
-this surprising behavior.)
+  the same name, no warning or error is provided; git-filter-branch
+  simply overwrites each tag in some undocumented pre-defined order
+  resulting in only one tag at the end.  (A git-filter-branch
+  regression test requires this surprising behavior.)
 
 Also, the poor performance of git-filter-branch often leads to safety
 issues:
 
-* Coming up with the correct shell snippet to do the filtering you want
-is sometimes difficult unless you're just doing a trivial modification
-such as deleting a couple files.  Unfortunately, people often learn if
-the snippet is right or wrong by trying it out, but the rightness or
-wrongness can vary depending on special circumstances (spaces in
-filenames, non-ascii filenames, funny author names or emails, invalid
-timezones, presence of grafts or replace objects, etc.), meaning they
-may have to wait a long time, hit an error, then restart.  The
-performance of git-filter-branch is so bad that this cycle is painful,
-reducing the time available to carefully re-check (to say nothing about
-what it does to the patience of the person doing the rewrite even if
-they do technically have more time available).  This problem is extra
-compounded because errors from broken filters may not be shown for a
-long time and/or get lost in a sea of output.  Even worse, broken
-filters often just result in silent incorrect rewrites.
-
-* To top it all off, even when users finally find working commands, they
-naturally want to share them.  But they may be unaware that their repo
-didn't have some special cases that someone else's does.  So, when
-someone else with a different repository runs the same commands, they
-get hit by the problems above.  Or, the user just runs commands that
-really were vetted for special cases, but they run it on a different OS
-where it doesn't work, as noted above.
+* Coming up with the correct shell snippet to do the filtering you
+  want is sometimes difficult unless you're just doing a trivial
+  modification such as deleting a couple files.  Unfortunately, people
+  often learn if the snippet is right or wrong by trying it out, but
+  the rightness or wrongness can vary depending on special
+  circumstances (spaces in filenames, non-ascii filenames, funny
+  author names or emails, invalid timezones, presence of grafts or
+  replace objects, etc.), meaning they may have to wait a long time,
+  hit an error, then restart.  The performance of git-filter-branch is
+  so bad that this cycle is painful, reducing the time available to
+  carefully re-check (to say nothing about what it does to the
+  patience of the person doing the rewrite even if they do technically
+  have more time available).  This problem is extra compounded because
+  errors from broken filters may not be shown for a long time and/or
+  get lost in a sea of output.  Even worse, broken filters often just
+  result in silent incorrect rewrites.
+
+* To top it all off, even when users finally find working commands,
+  they naturally want to share them.  But they may be unaware that
+  their repo didn't have some special cases that someone else's does.
+  So, when someone else with a different repository runs the same
+  commands, they get hit by the problems above.  Or, the user just
+  runs commands that really were vetted for special cases, but they
+  run it on a different OS where it doesn't work, as noted above.
 
 GIT
 ---
-- 
2.24.0

