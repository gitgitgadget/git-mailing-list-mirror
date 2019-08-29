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
	by dcvr.yhbt.net (Postfix) with ESMTP id 30EBE1F4B9
	for <e@80x24.org>; Thu, 29 Aug 2019 00:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfH2AHF (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 20:07:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36161 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfH2AHE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 20:07:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id l21so579343pgm.3
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 17:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ugHp+FtS+/ntZZAo/D0LCrQsJKHt2pLXVNqt4vGr7Wo=;
        b=sWAPyFC+GdMee+tg7IU7df0RGGfapipZDpbvhaoGk0KEwsqwPQLV+mnco2JC2KbI+O
         w+YIP4UGeW2lW8toXxl/sTr5tjLtSAjFPfIjZFHs2Aof2cWKkwzxCGkHgk/Xs8wl7rDb
         ICQmClSfmDNg9OsLJF9hfzQ17dfHGLkZrSgnTfrlVw/uSQQ9wKLnCqxQ8Ajh9mmkRml2
         JZcF46s6PHGelQk7QndgmtmrgGKJ7j93DzKQ/q243qLo3MHesiuEqds0Z2YStGdI4zQX
         RvHMVbGWd6J8xpVgE1yDVPEJQytXWjedE7MjCDJD+THHGeI1JX8Bd6GPxNAoVrF7O/Cj
         T++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ugHp+FtS+/ntZZAo/D0LCrQsJKHt2pLXVNqt4vGr7Wo=;
        b=MtjcIJZmzTyvt/WZvnY2TnyCUj4UjsdlsYtMgwGnbhzufR+gV7SFPBVJoY+ckYGGRf
         /5i3CK+fCsMsjp8KtHO/1zyc+kx/NW2w9FJmBxvvdtkV7vTSPT1YOLldlSGxseTkrv6F
         NloKETC8CUzaHOCrZBMuoy5qR2LjWvRuiGIiY7O/f4JEFpsWKPLlEIBi1w/8BkKpwXOa
         avaLQfNR2lovDwtzIGTKbjYDMxcIR/EPdvMu5ZzwpE5yWhDDRweOsKuX6jn7k5XbQSVS
         wO6pU9nnXcibGajLzpd5iqHTSa2xzKj8/KT3L9dOv8hCXqBWtw4GiTeHxQBWHkTlGubT
         eF8g==
X-Gm-Message-State: APjAAAWv5Qz7rOpkeK6fRla55Gel3wP9QPVbLGzJkvZW1EiFeFayzv31
        XH1KcPsxeqhfslZYjhE+/sdcjMkY
X-Google-Smtp-Source: APXvYqyjZaYhZQyLHtk46pwlplEL2NjnSiYn0hg5/urRkO0K8+nyj0H+lO9VqZVXzwV44RgpxIxWfQ==
X-Received: by 2002:a65:41c6:: with SMTP id b6mr5711441pgq.269.1567037222850;
        Wed, 28 Aug 2019 17:07:02 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id m4sm305531pgs.71.2019.08.28.17.07.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Aug 2019 17:07:02 -0700 (PDT)
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
Subject: [PATCH v3 0/4] Warn about git-filter-branch usage and avoid it
Date:   Wed, 28 Aug 2019 17:06:53 -0700
Message-Id: <20190829000657.26415-1-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.3.g59c7446927.dirty
In-Reply-To: <20190828002210.8862-1-newren@gmail.com>
References: <20190828002210.8862-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a series warns about git-filter-branch usage and avoids it
ourselves.

Changes since v2 (full range-diff below):
  * [Patch 2] testcase syntax cleanups
  * [Patch 3] fixed "linkgit:" references to filter-repo to be url
    links (or footnotes)
  * [Patch 3] fixed the mode on filter-branch.sh (oops) and dropped
    the ambiguous "and pause".  Linkified "filter-repo" in a place
    where there was no link.
  * [Patch 3] As suggested by Eric (Sunshine), just make the manpage
    and directly include the safety and performance sections of the
    referenced email (the performance section was referenced by the
    safety section).  Being included directly in the manpage should
    help with folks reading the documentation offline.  Anyway, the
    text is really long, so it took a while to format it nicely,
    recheck for typos, reword based on the fact that it'll be in the
    manpage (because it's weird to have the manpage refer to itself),
    etc.
  * [Patch 4] Dropped almost all the original patch 4; only including
    the bits about t9902-completion.sh.  Removed the RFC label, since
    that one piece should be good for including now.

Elijah Newren (4):
  t6006: simplify and optimize empty message test
  t3427: accelerate this test by using fast-export and fast-import
  Recommend git-filter-repo instead of git-filter-branch
  t9902: use a non-deprecated command for testing

 Documentation/git-fast-export.txt   |   6 +-
 Documentation/git-filter-branch.txt | 302 +++++++++++++++++++++++++---
 Documentation/git-gc.txt            |  17 +-
 Documentation/git-rebase.txt        |   3 +-
 Documentation/git-replace.txt       |  10 +-
 Documentation/git-svn.txt           |  10 +-
 Documentation/githooks.txt          |  10 +-
 contrib/svn-fe/svn-fe.txt           |   4 +-
 git-filter-branch.sh                |  13 ++
 t/t3427-rebase-subtree.sh           |  24 ++-
 t/t6006-rev-list-format.sh          |   5 +-
 t/t9902-completion.sh               |  12 +-
 12 files changed, 339 insertions(+), 77 deletions(-)

Range-diff:
1:  7ddbeea2ca = 1:  7ddbeea2ca t6006: simplify and optimize empty message test
2:  f18bd7a609 ! 2:  e1e63189c1 t3427: accelerate this test by using fast-export and fast-import
    @@ Commit message
         Signed-off-by: Elijah Newren <newren@gmail.com>
     
      ## t/t3427-rebase-subtree.sh ##
    -@@ t/t3427-rebase-subtree.sh: commit_message() {
    +@@ t/t3427-rebase-subtree.sh: This test runs git rebase and tests the subtree strategy.
    + . ./test-lib.sh
    + . "$TEST_DIRECTORY"/lib-rebase.sh
    + 
    +-commit_message() {
    ++commit_message () {
      	git log --pretty=format:%s -1 "$1"
      }
      
    -+extract_files_subtree() {
    -+	git fast-export --no-data HEAD -- files_subtree/ \
    -+		| sed -e "s%\([0-9a-f]\{40\} \)files_subtree/%\1%" \
    -+		| git fast-import --force --quiet
    ++extract_files_subtree () {
    ++	git fast-export --no-data HEAD -- files_subtree/ |
    ++		sed -e "s%\([0-9a-f]\{40\} \)files_subtree/%\1%" |
    ++		git fast-import --force --quiet
     +}
     +
      test_expect_success 'setup' '
3:  7008c16984 ! 3:  59c7446927 Recommend git-filter-repo instead of git-filter-branch
    @@ Documentation/git-filter-branch.txt: SYNOPSIS
     +as such, its use is not recommended.  Please use an alternative history
     +filtering tool such as https://github.com/newren/git-filter-repo/[git
     +filter-repo].  If you still need to use 'git filter-branch', please
    -+carefully read the "Safety" section of the message on the Git mailing list
    ++carefully read <<SAFETY>> (and <<PERFORMANCE>>) to learn about the land
    ++mines of filter-branch, and then vigilantly avoid as many of the hazards
    ++listed there as reasonably possible.
    ++
     +https://public-inbox.org/git/CABPp-BEDOH-row-hxY4u_cP30ptqOpcCvPibwyZ2wBu142qUbA@mail.gmail.com/[detailing
    -+the land mines of filter-branch] and vigilantly avoid as many of the
    -+hazards listed there as reasonably possible.
    ++the land mines of filter-branch]
     +
      DESCRIPTION
      -----------
    @@ Documentation/git-filter-branch.txt: warned.
     -  are much more restrictive than git-filter branch, and dedicated just
     -  to the tasks of removing unwanted data- e.g:
     -  `--strip-blobs-bigger-than 1M`.
    --
    ++[[PERFORMANCE]]
    ++PERFORMANCE
    ++-----------
    ++
    ++The performance of filter-branch is glacially slow; its design makes it
    ++impossible for a backward-compatible implementation to ever be fast:
    ++
    ++* In editing files, git-filter-branch by design checks out each and
    ++every commit as it existed in the original repo.  If your repo has 10\^5
    ++files and 10\^5 commits, but each commit only modifies 5 files, then
    ++git-filter-branch will make you do 10\^10 modifications, despite only
    ++having (at most) 5*10^5 unique blobs.
    ++
    ++* If you try and cheat and try to make filter-branch only work on
    ++files modified in a commit, then two things happen
    ++
    ++  . you run into problems with deletions whenever the user is simply
    ++    trying to rename files (because attempting to delete files that
    ++    don't exist looks like a no-op; it takes some chicanery to remap
    ++    deletes across file renames when the renames happen via arbitrary
    ++    user-provided shell)
    ++
    ++  . even if you succeed at the map-deletes-for-renames chicanery, you
    ++    still technically violate backward compatibility because users are
    ++    allowed to filter files in ways that depend upon topology of commits
    ++    instead of filtering solely based on file contents or names (though
    ++    I have never seen any user ever do this).
    ++
    ++* Even if you don't need to edit files but only want to e.g. rename or
    ++remove some and thus can avoid checking out each file (i.e. you can use
    ++--index-filter), you still are passing shell snippets for your filters.
    ++This means that for every commit, you have to have a prepared git repo
    ++where users can run git commands.  That's a lot of setup.  It also means
    ++you have to fork at least one process to run the user-provided shell
    ++snippet, and odds are that the user's shell snippet invokes lots of
    ++commands in some long pipeline, so you will have lots and lots of forks.
    ++For every. single. commit.  That's a massive amount of overhead to
    ++rename a few files.
    ++
    ++* filter-branch is written in shell, which is kind of slow.  Naturally,
    ++it makes sense to want to rewrite that in some other language.  However,
    ++filter-branch documentation states that several additional shell
    ++functions are provided for users to call, e.g. 'map', 'skip_commit',
    ++'git_commit_non_empty_tree'.  If filter-branch itself isn't a shell
    ++script, then in order to make those shell functions available to the
    ++users' shell snippets you have to prepend the shell definitions of these
    ++functions to every one of the users' shell snippets and thus make these
    ++special shell functions be parsed with each and every commit.
    ++
    ++* filter-branch provides a --setup option which is a shell snippet that
    ++can be sourced to make shell functions and variables available to all
    ++other filters.  If filter-branch is a shell script, it can simply eval
    ++this shell snippet once at the beginning.  If you try to fix performance
    ++by making filter-branch not be a shell script, then you have to prepend
    ++the setup shell snippet to all other filters and parse it with every
    ++single commit.
    ++
    ++* filter-branch writes lots of files to $workdir/../map/ to keep a
    ++mapping of commits, which it uses pruning commits and remapping to
    ++ancestors and the map() command more generally.  Other files like
    ++$tempdir/backup-refs, $tempdir/raw-refs, $tempdir/heads,
    ++$tempdir/tree-state are all created internally too.  It is possible
    ++(though strongly discouraged) that users could have accessed any of
    ++these directly.  Users even had a pointer to follow in the form of
    ++Documentation that the 'map' command existed, which naturally uses the
    ++$workdir/../map/* files.  So, even if you don't have to edit files, for
    ++strict backward compatibility you need to still write a bunch of files
    ++to disk somewhere and keep them updated for every commit.  You can claim
    ++it was an implementation detail that users should not have depended
    ++upon, but the truth is they've had a decade where they could so.  So, if
    ++you want full compatibility, it has to be there.  Besides, the
    ++regression tests depend on at least one of these details, specifying an
    ++--index-filter that reaches down and grabs backup-refs from $tempdir,
    ++and thus provides resourceful users who do google searches an example
    ++that there are files there for them to read and grab and use.  (And if
    ++you want to pass the existing regression tests, you have to at least put
    ++the backup-refs file there even if it's irrelevant to your
    ++implementation otherwise.)
    ++
    ++All of that said, performance of filter-branch could be improved by
    ++reimplementing it in a non-shell language and taking a couple small
    ++liberties with backward compatibility (such as having it only run
    ++filters on files changed within each commit).  filter-repo provides a
    ++demo script named
    ++https://github.com/newren/git-filter-repo/blob/master/contrib/filter-repo-demos/filter-lamely[filter-lamely]
    ++which does exactly that and which passes all the git-filter-branch
    ++regression tests.  It's much faster than git-filter-branch, though it
    ++suffers from all the same safety issues as git-filter-branch, and is
    ++still glacially slow compared to
    ++https://github.com/newren/git-filter-repo/[git filter-repo].
    ++
    ++[[SAFETY]]
    ++SAFETY
    ++------
    ++
    ++filter-branch is riddled with gotchas resulting in various ways to
    ++easily corrupt repos or end up with a mess worse than what you started
    ++with:
    ++
    ++* Someone can have a set of "working and tested filters" which they
    ++document or provide to a coworker, who then runs them on a different OS
    ++where the same commands are not working/tested (some examples in the
    ++git-filter-branch manpage are also affected by this).  BSD vs. GNU
    ++userland differences can really bite.  If you're lucky, you get ugly
    ++error messages spewed.  But just as likely, the commands either don't do
    ++the filtering requested, or silently corrupt making some unwanted
    ++change.  The unwanted change may only affect a few commits, so it's not
    ++necessarily obvious either.  (The fact that problems won't necessarily
    ++be obvious means they are likely to go unnoticed until the rewritten
    ++history is in use for quite a while, at which point it's really hard to
    ++justify another flag-day for another rewrite.)
    ++
    ++* Filenames with spaces (which are rare) are often mishandled by shell
    ++snippets since they cause problems for shell pipelines.  Not everyone is
    ++familiar with find -print0, xargs -0, ls-files -z, etc.  Even people who
    ++are familiar with these may assume such needs are not relevant because
    ++someone else renamed any such files in their repo back before the person
    ++doing the filtering joined the project.  And, often, even those familiar
    ++with handling arguments with spaces my not do so just because they
    ++aren't in the mindset of thinking about everything that could possibly
    ++go wrong.
    ++
    ++* Non-ascii filenames (which are rare) can be silently removed despite
    ++being in a desired directory.  The desire to select paths to keep often
    ++use pipelines like `git ls-files | grep -v ^WANTED_DIR/ | xargs git rm`.
    ++ls-files will only quote filenames if needed so folks may not notice
    ++that one of the files didn't match the regex, again until it's much too
    ++late.  Yes, someone who knows about core.quotePath can avoid this
    ++(unless they have other special characters like \t, \n, or "), and
    ++people who use ls-files -z with something other than grep can avoid
    ++this, but that doesn't mean they will.
    ++
    ++* Similarly, when moving files around, one can find that filenames with
    ++non-ascii or special characters end up in a different directory, one
    ++that includes a double quote character.  (This is technically the same
    ++issue as above with quoting, but perhaps an interesting different way
    ++that it can and has manifested as a problem.)
    ++
    ++* It's far too easy to accidentally mix up old and new history.  It's
    ++still possible with any tool, but filter-branch almost invites it.  If
    ++we're lucky, the only downside is users getting frustrated that they
    ++don't know how to shrink their repo and remove the old stuff.  If we're
    ++unlucky, they merge old and new history and end up with multiple
    ++"copies" of each commit, some of which have unwanted or sensitive files
    ++and others which don't.  This comes about in multiple different ways:
    ++
    ++  ** the default to only doing a partial history rewrite ('--all' is not
    ++     the default and over 80% of the examples in the manpage don't use
    ++     it)
    ++
    ++  ** the fact that there's no automatic post-run cleanup
    ++
    ++  ** the fact that --tag-name-filter (when used to rename tags) doesn't
    ++     remove the old tags but just adds new ones with the new name (this
    ++     manpage has documented this for a long time so it's presumably not
    ++     a "bug" even though it feels like it)
    ++
    ++  ** the fact that little educational information is provided to inform
    ++     users of the ramifications of a rewrite and how to avoid mixing old
    ++     and new history.  For example, this man page discusses how users
    ++     need to understand that they need to rebase their changes for all
    ++     their branches on top of new history (or delete and reclone), but
    ++     that's only one of multiple concerns to consider.  See the
    ++     "DISCUSSION" section of the git filter-repo manual page for more
    ++     details.
    ++
    ++* Annotated tags can be accidentally converted to lightweight tags, due
    ++to either of two issues:
    ++
    ++  . Someone can do a history rewrite, realize they messed up, restore
    ++    from the backups in refs/original/, and then redo their
    ++    filter-branch command.  (The backup in refs/original/ is not a real
    ++    backup; it dereferences tags first.)
    ++
    ++  . Running filter-branch with either --tags or --all in your <rev-list
    ++    options>.  In order to retain annotated tags as annotated, you must
    ++    use --tag-name-filter (and must not have restored from
    ++    refs/original/ in a previously botched rewrite).
    ++
    ++* Any commit messages that specify an encoding will become corrupted
    ++by the rewrite; filter-branch ignores the encoding, takes the original
    ++bytes, and feeds it to commit-tree without telling it the proper
    ++encoding.  (This happens whether or not --msg-filter is used, though I
    ++suspect --msg-filter provides additional ways to really mess things
    ++up).
    ++
    ++* Commit messages (even if they are all UTF-8) by default become
    ++corrupted due to not being updated -- any references to other commit
    ++hashes in commit messages will now refer to no-longer-extant commits.
    ++
    ++* There are no facilities for helping users find what unwanted crud they
    ++should delete, which means they are much more likely to have incomplete
    ++or partial cleanups that sometimes result in confusion and people
    ++wasting time trying to understand.  (For example, folks tend to just
    ++look for big files to delete instead of big directories or extensions,
    ++and once they do so, then sometime later folks using the new repository
    ++who are going through history will notice a build artifact directory
    ++that has some files but not others, or a cache of dependencies
    ++(node_modules or similar) which couldn't have ever been functional since
    ++it's missing some files.)
    ++
    ++* If --prune-empty isn't specified, then the filtering process can
    ++create hoards of confusing empty commits
    ++
    ++* If --prune-empty is specified, then intentionally placed empty
    ++commits from before the filtering operation are also pruned instead of
    ++just pruning commits that became empty due to filtering rules.
    ++
    ++* If --prune empty is specified, sometimes empty commits are missed
    ++and left around anyway (a somewhat rare bug, but it happens...)
    ++
    ++* A minor issue, but users who have a goal to update all names and
    ++emails in a repository may be led to --env-filter which will only update
    ++authors and committers, missing taggers.
    ++
    ++* If the user provides a --tag-name-filter that maps multiple tags to
    ++the same name, no warning or error is provided; filter-branch simply
    ++overwrites each tag in some undocumented pre-defined order resulting in
    ++only one tag at the end.  If you try to "fix" this bug in filter-branch
    ++and make it error out and warn the user instead, one of the
    ++filter-branch regression tests will fail.  (So, if you are trying to
    ++make a backward compatible reimplementation you have to add extra code
    ++to detect collisions and make sure that only the lexicographically last
    ++one is rewritten to avoid fast-import from seeing both since fast-import
    ++will naturally do the sane thing and error out if told to write the same
    ++tag more than once.)
    ++
    ++Also, the poor performance of filter-branch often leads to safety issues:
    ++
    ++* Coming up with the correct shell snippet to do the filtering you want
    ++is sometimes difficult unless you're just doing a trivial modification
    ++such as deleting a couple files.  People have often come to me for help,
    ++so I should be practiced and an expert, but even for fairly simple cases
    ++I still sometimes take over 10 minutes and several iterations to get
    ++the right commands -- and that's assuming they are working on a tiny
    ++repository.  Unfortunately, people often learn if the snippet is right
    ++or wrong by trying it out, but the rightness or wrongness can vary
    ++depending on special circumstances (spaces in filenames, non-ascii
    ++filenames, funny author names or emails, invalid timezones, presence of
    ++grafts or replace objects, etc.), meaning they may have to wait a long
    ++time, hit an error, then restart.  The performance of filter-branch is
    ++so bad that this cycle is painful, reducing the time available to
    ++carefully re-check (to say nothing about what it does to the patience of
    ++the person doing the rewrite even if they do technically have more time
    ++available).  This problem is extra compounded because errors from broken
    ++filters may not be shown for a long time and/or get lost in a sea of
    ++output.  Even worse, broken filters often just result in silent
    ++incorrect rewrites.
    ++
    ++* To top it all off, even when users finally find working commands, they
    ++naturally want to share them.  But they may be unaware that their repo
    ++didn't have some special cases that someone else's does.  So, when
    ++someone else with a different repository runs the same commands, they
    ++get hit by the problems above.  Or, the user just runs commands that
    ++really were vetted for special cases, but they run it on a different OS
    ++where it doesn't work, as noted above.
    + 
      GIT
      ---
    - Part of the linkgit:git[1] suite
     
      ## Documentation/git-gc.txt ##
     @@ Documentation/git-gc.txt: NOTES
    @@ Documentation/git-rebase.txt: Hard case: The changes are not the same.::
      	`--interactive` to omit, edit, squash, or fixup commits; or
      	if the upstream used one of `commit --amend`, `reset`, or
     -	`filter-branch`.
    -+	a full history rewriting command like `filter-repo`.
    ++	a full history rewriting command like
    ++	https://github.com/newren/git-filter-repo[`filter-repo`].
      
      
      The easy case
    @@ Documentation/git-replace.txt: The following format are available:
     -replacement objects from existing objects. The `--edit` option can
     -also be used with 'git replace' to create a replacement object by
     +linkgit:git-hash-object[1], linkgit:git-rebase[1], and
    -+linkgit:git-filter-repo[1], among other git commands, can be used to
    ++https://github.com/newren/git-filter-repo[git-filter-repo], among other git commands, can be used to
     +create replacement objects from existing objects. The `--edit` option
     +can also be used with 'git replace' to create a replacement object by
      editing an existing object.
    @@ Documentation/git-replace.txt: pending objects.
      linkgit:git-hash-object[1]
     -linkgit:git-filter-branch[1]
      linkgit:git-rebase[1]
    -+linkgit:git-filter-repo[1]
      linkgit:git-tag[1]
      linkgit:git-branch[1]
      linkgit:git-commit[1]
    + linkgit:git-var[1]
    + linkgit:git[1]
    ++https://github.com/newren/git-filter-repo[git-filter-repo]
    + 
    + GIT
    + ---
     
      ## Documentation/git-svn.txt ##
     @@ Documentation/git-svn.txt: option for (hopefully) obvious reasons.
    @@ Documentation/git-svn.txt: option for (hopefully) obvious reasons.
      This option is NOT recommended as it makes it difficult to track down
      old references to SVN revision numbers in existing documentation, bug
     -reports and archives.  If you plan to eventually migrate from SVN to Git
    -+reports, and archives.  If you plan to eventually migrate from SVN to Git
    - and are certain about dropping SVN history, consider
    +-and are certain about dropping SVN history, consider
     -linkgit:git-filter-branch[1] instead.  filter-branch also allows
    -+linkgit:git-filter-repo[1] instead.  filter-repo also allows
    - reformatting of metadata for ease-of-reading and rewriting authorship
    - info for non-"svn.authorsFile" users.
    +-reformatting of metadata for ease-of-reading and rewriting authorship
    +-info for non-"svn.authorsFile" users.
    ++reports, and archives.  If you plan to eventually migrate from SVN to
    ++Git and are certain about dropping SVN history, consider
    ++https://github.com/newren/git-filter-repo[git-filter-repo] instead.
    ++filter-repo also allows reformatting of metadata for ease-of-reading
    ++and rewriting authorship info for non-"svn.authorsFile" users.
      
    + svn.useSvmProps::
    + svn-remote.<name>.useSvmProps::
     
      ## Documentation/githooks.txt ##
     @@ Documentation/githooks.txt: post-rewrite
    @@ Documentation/githooks.txt: post-rewrite
     -linkgit:git-rebase[1]; currently `git filter-branch` does 'not' call
     -it!).  Its first argument denotes the command it was invoked by:
     -currently one of `amend` or `rebase`.  Further command-dependent
    +-arguments may be passed in the future.
     +linkgit:git-rebase[1]; however, full-history (re)writing tools like
    -+linkgit:git-fast-import[1] or linkgit:git-filter-repo[1] typically do
    -+not call it!).  Its first argument denotes the command it was invoked
    -+by: currently one of `amend` or `rebase`.  Further command-dependent
    - arguments may be passed in the future.
    ++linkgit:git-fast-import[1] or
    ++https://github.com/newren/git-filter-repo[git-filter-repo] typically
    ++do not call it!).  Its first argument denotes the command it was
    ++invoked by: currently one of `amend` or `rebase`.  Further
    ++command-dependent arguments may be passed in the future.
      
      The hook receives a list of the rewritten commits on stdin, in the
    + format
     
      ## contrib/svn-fe/svn-fe.txt ##
     @@ contrib/svn-fe/svn-fe.txt: line.  This line has the form `git-svn-id: URL@REVNO UUID`.
    @@ contrib/svn-fe/svn-fe.txt: The exit status does not reflect whether an error was
     +git-svn(1), svn2git(1), svk(1), git-filter-repo(1), git-fast-import(1),
      https://svn.apache.org/repos/asf/subversion/trunk/notes/dump-load-format.txt
     
    - ## git-filter-branch.sh (mode change 100755 => 100644) ##
    + ## git-filter-branch.sh ##
     @@ git-filter-branch.sh: set_ident () {
      	finish_ident COMMITTER
      }
    @@ git-filter-branch.sh: set_ident () {
     +         rewrites.  Please use an alternative filtering tool such as 'git
     +         filter-repo' (https://github.com/newren/git-filter-repo/) instead.
     +         See the filter-branch manual page for more details; to squelch
    -+         this warning and pause, set FILTER_BRANCH_SQUELCH_WARNING=1.
    ++         this warning, set FILTER_BRANCH_SQUELCH_WARNING=1.
     +
     +EOF
     +	sleep 5
4:  ff3e04e558 < -:  ---------- Remove git-filter-branch, it is now external to git.git
-:  ---------- > 4:  1dbca82408 t9902: use a non-deprecated command for testing
-- 
2.23.0.3.g59c7446927.dirty

