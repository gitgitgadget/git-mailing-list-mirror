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
	by dcvr.yhbt.net (Postfix) with ESMTP id 728831F4B9
	for <e@80x24.org>; Fri, 30 Aug 2019 05:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfH3F5R (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 01:57:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35839 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfH3F5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 01:57:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id 205so1418899pfw.2
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 22:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8DQlXMBH7Na7ijY+8fclKHWjAq+dBVl+dcD3iNtVND4=;
        b=iREkgFBtyT327XPNCmaOXUt5k+TXJ1Rb2PIIw10qN69RykAxOr6YY2WgKcZ9gOjSn9
         bvS7mwA7rOXikFI8RKqZyoJNYD/77XXggf2q2d6piYTOyw1XPhivRbVXcv7o5bjRNXaw
         Wo8fmuNOtaFBMvFDGgMdZDKsTL8YOrXQTHb4TXvE88i+k5JdelnCB1xMNicOB9m8xiJx
         mIBh4GVSvDyEVdqCIZNPRDdR1UXPN9xa3oz648PqBIRR6yJLGqSAP7zi5vAa4j+Yh5Vh
         dBJnqkpU4y0n5NlDHIqxIg0ksli4cxoqbcUOLf3avg09U+hoB/PR2fyTkS2lQOQgGk8o
         Tmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8DQlXMBH7Na7ijY+8fclKHWjAq+dBVl+dcD3iNtVND4=;
        b=Co82TmQeT8zazczYKT8HSv63C/O2zZQcz4AS48rgdaix+K03sPuf2nszS4m8Cq+mmM
         F8/kqWfIR/DFk7PyXf5z1ZwP9jg09GnzKUedCKNL7XRJBWtAApUWu6ASnGEKBVbCOUkl
         1iR1w5L//sIlkd2yBTB4+YN+Nik4aTZtvj0t0IoykjO8wG3cQuwpJge+/6wLvdRoJ17T
         fPh8chaf+2bvok1zKCcGgUI7hgeXiXSUcOs4ie/OG4HreqG7r3JJ+flMnxA8Zvle3ITU
         dClS7yLeg4w5tJqqcG1suPB567zT9Tl9IO8MN2HlFkX82p6xm5S8KY8Hs4QoQbFZE+da
         rOIw==
X-Gm-Message-State: APjAAAXbt/+p/iyMTNxrsy4J314Gg+NLSmBj4AsEaeFM4BZm2vlhWZzj
        OiIYq7V2fsh0ZMTtVYot6Sacqw62N4k=
X-Google-Smtp-Source: APXvYqxjV7cEXcok+hxNc5D9xdIv7uIca3vjsZnIdV6BCFvrT5hu7DM1N55Xf6n0Cau++GkXEsTkww==
X-Received: by 2002:a17:90a:b288:: with SMTP id c8mr13875842pjr.135.1567144634201;
        Thu, 29 Aug 2019 22:57:14 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id b136sm5771139pfb.73.2019.08.29.22.57.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Aug 2019 22:57:13 -0700 (PDT)
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
Subject: [PATCH v4 0/4] Warn about git-filter-branch usage and avoid it
Date:   Thu, 29 Aug 2019 22:57:03 -0700
Message-Id: <20190830055707.7785-1-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.38.g892688c90e
In-Reply-To: <20190829000657.26415-1-newren@gmail.com>
References: <20190829000657.26415-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a series warns about git-filter-branch usage and avoids it
ourselves.

Changes since v3
  * Incorporated Eric's detailed feedback on the git-filter-branch
    manpage, some notes:
      * s/filter-branch/git-&/ (and similar for ls-files)
      * Multiple sections removed (and existing sections had a
        number of sentences removed)
      * I ended up not linking to the original html, but just added
        a small "Side Note" in a sub-bullet to address how fixing the
	written-in-shell attribute of git-filter-branch would do less
	than proponents expect.
      * ...and lots of other miscellaneous wording fixes and cleanups
  * The full range-diff is below, but it's kinda hard to read due to
    line wrapping and such.

Elijah Newren (4):
  t6006: simplify and optimize empty message test
  t3427: accelerate this test by using fast-export and fast-import
  Recommend git-filter-repo instead of git-filter-branch
  t9902: use a non-deprecated command for testing

 Documentation/git-fast-export.txt   |   6 +-
 Documentation/git-filter-branch.txt | 272 +++++++++++++++++++++++++---
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
 12 files changed, 309 insertions(+), 77 deletions(-)

Range-diff:
1:  7ddbeea2ca = 1:  7ddbeea2ca t6006: simplify and optimize empty message test
2:  e1e63189c1 = 2:  e1e63189c1 t3427: accelerate this test by using fast-export and fast-import
3:  59c7446927 ! 3:  ed6505584f Recommend git-filter-repo instead of git-filter-branch
    @@ Documentation/git-filter-branch.txt: SYNOPSIS
     +carefully read <<SAFETY>> (and <<PERFORMANCE>>) to learn about the land
     +mines of filter-branch, and then vigilantly avoid as many of the hazards
     +listed there as reasonably possible.
    -+
    -+https://public-inbox.org/git/CABPp-BEDOH-row-hxY4u_cP30ptqOpcCvPibwyZ2wBu142qUbA@mail.gmail.com/[detailing
    -+the land mines of filter-branch]
     +
      DESCRIPTION
      -----------
    @@ Documentation/git-filter-branch.txt: warned.
     +PERFORMANCE
     +-----------
     +
    -+The performance of filter-branch is glacially slow; its design makes it
    ++The performance of git-filter-branch is glacially slow; its design makes it
     +impossible for a backward-compatible implementation to ever be fast:
     +
     +* In editing files, git-filter-branch by design checks out each and
    @@ Documentation/git-filter-branch.txt: warned.
     +git-filter-branch will make you do 10\^10 modifications, despite only
     +having (at most) 5*10^5 unique blobs.
     +
    -+* If you try and cheat and try to make filter-branch only work on
    ++* If you try and cheat and try to make git-filter-branch only work on
     +files modified in a commit, then two things happen
     +
    -+  . you run into problems with deletions whenever the user is simply
    -+    trying to rename files (because attempting to delete files that
    -+    don't exist looks like a no-op; it takes some chicanery to remap
    -+    deletes across file renames when the renames happen via arbitrary
    -+    user-provided shell)
    ++  ** you run into problems with deletions whenever the user is simply
    ++     trying to rename files (because attempting to delete files that
    ++     don't exist looks like a no-op; it takes some chicanery to remap
    ++     deletes across file renames when the renames happen via arbitrary
    ++     user-provided shell)
     +
    -+  . even if you succeed at the map-deletes-for-renames chicanery, you
    -+    still technically violate backward compatibility because users are
    -+    allowed to filter files in ways that depend upon topology of commits
    -+    instead of filtering solely based on file contents or names (though
    -+    I have never seen any user ever do this).
    ++  ** even if you succeed at the map-deletes-for-renames chicanery, you
    ++     still technically violate backward compatibility because users are
    ++     allowed to filter files in ways that depend upon topology of
    ++     commits instead of filtering solely based on file contents or names
    ++     (though this has not been observed in the wild).
     +
     +* Even if you don't need to edit files but only want to e.g. rename or
     +remove some and thus can avoid checking out each file (i.e. you can use
     +--index-filter), you still are passing shell snippets for your filters.
     +This means that for every commit, you have to have a prepared git repo
    -+where users can run git commands.  That's a lot of setup.  It also means
    -+you have to fork at least one process to run the user-provided shell
    -+snippet, and odds are that the user's shell snippet invokes lots of
    -+commands in some long pipeline, so you will have lots and lots of forks.
    -+For every. single. commit.  That's a massive amount of overhead to
    -+rename a few files.
    -+
    -+* filter-branch is written in shell, which is kind of slow.  Naturally,
    -+it makes sense to want to rewrite that in some other language.  However,
    -+filter-branch documentation states that several additional shell
    -+functions are provided for users to call, e.g. 'map', 'skip_commit',
    -+'git_commit_non_empty_tree'.  If filter-branch itself isn't a shell
    -+script, then in order to make those shell functions available to the
    -+users' shell snippets you have to prepend the shell definitions of these
    -+functions to every one of the users' shell snippets and thus make these
    -+special shell functions be parsed with each and every commit.
    -+
    -+* filter-branch provides a --setup option which is a shell snippet that
    -+can be sourced to make shell functions and variables available to all
    -+other filters.  If filter-branch is a shell script, it can simply eval
    -+this shell snippet once at the beginning.  If you try to fix performance
    -+by making filter-branch not be a shell script, then you have to prepend
    -+the setup shell snippet to all other filters and parse it with every
    -+single commit.
    -+
    -+* filter-branch writes lots of files to $workdir/../map/ to keep a
    -+mapping of commits, which it uses pruning commits and remapping to
    -+ancestors and the map() command more generally.  Other files like
    -+$tempdir/backup-refs, $tempdir/raw-refs, $tempdir/heads,
    -+$tempdir/tree-state are all created internally too.  It is possible
    -+(though strongly discouraged) that users could have accessed any of
    -+these directly.  Users even had a pointer to follow in the form of
    -+Documentation that the 'map' command existed, which naturally uses the
    -+$workdir/../map/* files.  So, even if you don't have to edit files, for
    -+strict backward compatibility you need to still write a bunch of files
    -+to disk somewhere and keep them updated for every commit.  You can claim
    -+it was an implementation detail that users should not have depended
    -+upon, but the truth is they've had a decade where they could so.  So, if
    -+you want full compatibility, it has to be there.  Besides, the
    -+regression tests depend on at least one of these details, specifying an
    -+--index-filter that reaches down and grabs backup-refs from $tempdir,
    -+and thus provides resourceful users who do google searches an example
    -+that there are files there for them to read and grab and use.  (And if
    -+you want to pass the existing regression tests, you have to at least put
    -+the backup-refs file there even if it's irrelevant to your
    -+implementation otherwise.)
    -+
    -+All of that said, performance of filter-branch could be improved by
    -+reimplementing it in a non-shell language and taking a couple small
    -+liberties with backward compatibility (such as having it only run
    -+filters on files changed within each commit).  filter-repo provides a
    -+demo script named
    -+https://github.com/newren/git-filter-repo/blob/master/contrib/filter-repo-demos/filter-lamely[filter-lamely]
    -+which does exactly that and which passes all the git-filter-branch
    -+regression tests.  It's much faster than git-filter-branch, though it
    -+suffers from all the same safety issues as git-filter-branch, and is
    -+still glacially slow compared to
    -+https://github.com/newren/git-filter-repo/[git filter-repo].
    ++where those filters can be run.  That's a significant setup.
    ++
    ++* Further, several additional files are created or updated per commit by
    ++git-filter-branch.  Some of these are for supporting the convenience
    ++functions provided by git-filter-branch (such as map()), while others
    ++are for keeping track of internal state (but could have also been
    ++accessed by user filters; one of git-filter-branch's regression tests
    ++does so).  This essentially amounts to using the filesystem as an IPC
    ++mechanism between git-filter-branch and the user-provided filters.
    ++Disks tend to be a slow IPC mechanism, and writing these files also
    ++effectively represents a forced synchronization point between separate
    ++processes that we hit with every commit.
    ++
    ++* The user-provided shell commands will likely involve a pipeline of
    ++commands, resulting in the creation of many processes per commit.
    ++Creating and running another process takes a widely varying amount of
    ++time between operating systems, but on any platform it is very slow
    ++relative to invoking a function.
    ++
    ++* git-filter-branch itself is written in shell, which is kind of slow.
    ++This is the one performance issue that could be backward-compatibly
    ++fixed, but compared to the above problems that are intrinsic to the
    ++design of git-filter-branch, the language of the tool itself is a
    ++relatively minor issue.
    ++
    ++  ** Side note: Unfortunately, people tend to fixate on the
    ++     written-in-shell aspect and periodically ask if git-filter-branch
    ++     could be rewritten in another language to fix the performance
    ++     issues.  Not only does that ignore the bigger intrinsic problems
    ++     with the design, it'd help less than you'd expect: if
    ++     git-filter-branch itself were not shell, then the convenience
    ++     functions (map(), skip_commit(), etc) and the `--setup` argument
    ++     could no longer be executed once at the beginning of the program
    ++     but would instead need to be prepended to every user filter (and
    ++     thus re-executed with every commit).
    ++
    ++The https://github.com/newren/git-filter-repo/[git filter-repo] tool is
    ++an alternative to git-filter-branch which does not suffer from these
    ++performance problems or the safety problems (mentioned below). For those
    ++with existing tooling which relies upon git-filter-branch, 'git
    ++repo-filter' also provides
    ++https://github.com/newren/git-filter-repo/blob/master/contrib/filter-repo-demos/filter-lamely[filter-lamely],
    ++a drop-in git-filter-branch replacement (with a few caveats).  While
    ++filter-lamely suffers from all the same safety issues as
    ++git-filter-branch, it at least ameloriates the performance issues a
    ++little.
     +
     +[[SAFETY]]
     +SAFETY
     +------
     +
    -+filter-branch is riddled with gotchas resulting in various ways to
    ++git-filter-branch is riddled with gotchas resulting in various ways to
     +easily corrupt repos or end up with a mess worse than what you started
     +with:
     +
    @@ Documentation/git-filter-branch.txt: warned.
     +history is in use for quite a while, at which point it's really hard to
     +justify another flag-day for another rewrite.)
     +
    -+* Filenames with spaces (which are rare) are often mishandled by shell
    -+snippets since they cause problems for shell pipelines.  Not everyone is
    -+familiar with find -print0, xargs -0, ls-files -z, etc.  Even people who
    -+are familiar with these may assume such needs are not relevant because
    ++* Filenames with spaces are often mishandled by shell snippets since
    ++they cause problems for shell pipelines.  Not everyone is familiar with
    ++find -print0, xargs -0, git-ls-files -z, etc.  Even people who are
    ++familiar with these may assume such needs are not relevant because
     +someone else renamed any such files in their repo back before the person
     +doing the filtering joined the project.  And, often, even those familiar
     +with handling arguments with spaces my not do so just because they
     +aren't in the mindset of thinking about everything that could possibly
     +go wrong.
     +
    -+* Non-ascii filenames (which are rare) can be silently removed despite
    -+being in a desired directory.  The desire to select paths to keep often
    -+use pipelines like `git ls-files | grep -v ^WANTED_DIR/ | xargs git rm`.
    -+ls-files will only quote filenames if needed so folks may not notice
    -+that one of the files didn't match the regex, again until it's much too
    -+late.  Yes, someone who knows about core.quotePath can avoid this
    -+(unless they have other special characters like \t, \n, or "), and
    -+people who use ls-files -z with something other than grep can avoid
    -+this, but that doesn't mean they will.
    ++* Non-ascii filenames can be silently removed despite being in a desired
    ++directory.  The desire to select paths to keep often use pipelines like
    ++`git ls-files | grep -v ^WANTED_DIR/ | xargs git rm`.  ls-files will
    ++only quote filenames if needed so folks may not notice that one of the
    ++files didn't match the regex, again until it's much too late.  Yes,
    ++someone who knows about core.quotePath can avoid this (unless they have
    ++other special characters like \t, \n, or "), and people who use ls-files
    ++-z with something other than grep can avoid this, but that doesn't mean
    ++they will.
     +
     +* Similarly, when moving files around, one can find that filenames with
     +non-ascii or special characters end up in a different directory, one
    @@ Documentation/git-filter-branch.txt: warned.
     +that it can and has manifested as a problem.)
     +
     +* It's far too easy to accidentally mix up old and new history.  It's
    -+still possible with any tool, but filter-branch almost invites it.  If
    -+we're lucky, the only downside is users getting frustrated that they
    -+don't know how to shrink their repo and remove the old stuff.  If we're
    -+unlucky, they merge old and new history and end up with multiple
    -+"copies" of each commit, some of which have unwanted or sensitive files
    -+and others which don't.  This comes about in multiple different ways:
    ++still possible with any tool, but git-filter-branch almost invites it.
    ++If lucky, the only downside is users getting frustrated that they don't
    ++know how to shrink their repo and remove the old stuff.  If unlucky,
    ++they merge old and new history and end up with multiple "copies" of each
    ++commit, some of which have unwanted or sensitive files and others which
    ++don't.  This comes about in multiple different ways:
     +
     +  ** the default to only doing a partial history rewrite ('--all' is not
    -+     the default and over 80% of the examples in the manpage don't use
    -+     it)
    ++     the default and few examples show it)
     +
     +  ** the fact that there's no automatic post-run cleanup
     +
     +  ** the fact that --tag-name-filter (when used to rename tags) doesn't
    -+     remove the old tags but just adds new ones with the new name (this
    -+     manpage has documented this for a long time so it's presumably not
    -+     a "bug" even though it feels like it)
    ++     remove the old tags but just adds new ones with the new name
     +
     +  ** the fact that little educational information is provided to inform
     +     users of the ramifications of a rewrite and how to avoid mixing old
    @@ Documentation/git-filter-branch.txt: warned.
     +* Annotated tags can be accidentally converted to lightweight tags, due
     +to either of two issues:
     +
    -+  . Someone can do a history rewrite, realize they messed up, restore
    -+    from the backups in refs/original/, and then redo their
    -+    filter-branch command.  (The backup in refs/original/ is not a real
    -+    backup; it dereferences tags first.)
    ++  ** Someone can do a history rewrite, realize they messed up, restore
    ++     from the backups in refs/original/, and then redo their
    ++     git-filter-branch command.  (The backup in refs/original/ is not a
    ++     real backup; it dereferences tags first.)
     +
    -+  . Running filter-branch with either --tags or --all in your <rev-list
    -+    options>.  In order to retain annotated tags as annotated, you must
    -+    use --tag-name-filter (and must not have restored from
    -+    refs/original/ in a previously botched rewrite).
    ++  ** Running git-filter-branch with either --tags or --all in your
    ++     <rev-list options>.  In order to retain annotated tags as
    ++     annotated, you must use --tag-name-filter (and must not have
    ++     restored from refs/original/ in a previously botched rewrite).
     +
     +* Any commit messages that specify an encoding will become corrupted
    -+by the rewrite; filter-branch ignores the encoding, takes the original
    ++by the rewrite; git-filter-branch ignores the encoding, takes the original
     +bytes, and feeds it to commit-tree without telling it the proper
    -+encoding.  (This happens whether or not --msg-filter is used, though I
    -+suspect --msg-filter provides additional ways to really mess things
    -+up).
    ++encoding.  (This happens whether or not --msg-filter is used.)
     +
     +* Commit messages (even if they are all UTF-8) by default become
     +corrupted due to not being updated -- any references to other commit
    @@ Documentation/git-filter-branch.txt: warned.
     +authors and committers, missing taggers.
     +
     +* If the user provides a --tag-name-filter that maps multiple tags to
    -+the same name, no warning or error is provided; filter-branch simply
    ++the same name, no warning or error is provided; git-filter-branch simply
     +overwrites each tag in some undocumented pre-defined order resulting in
    -+only one tag at the end.  If you try to "fix" this bug in filter-branch
    -+and make it error out and warn the user instead, one of the
    -+filter-branch regression tests will fail.  (So, if you are trying to
    -+make a backward compatible reimplementation you have to add extra code
    -+to detect collisions and make sure that only the lexicographically last
    -+one is rewritten to avoid fast-import from seeing both since fast-import
    -+will naturally do the sane thing and error out if told to write the same
    -+tag more than once.)
    ++only one tag at the end.  (A git-filter-branch regression test requires
    ++this.)
     +
    -+Also, the poor performance of filter-branch often leads to safety issues:
    ++Also, the poor performance of git-filter-branch often leads to safety issues:
     +
     +* Coming up with the correct shell snippet to do the filtering you want
     +is sometimes difficult unless you're just doing a trivial modification
    -+such as deleting a couple files.  People have often come to me for help,
    -+so I should be practiced and an expert, but even for fairly simple cases
    -+I still sometimes take over 10 minutes and several iterations to get
    -+the right commands -- and that's assuming they are working on a tiny
    -+repository.  Unfortunately, people often learn if the snippet is right
    -+or wrong by trying it out, but the rightness or wrongness can vary
    -+depending on special circumstances (spaces in filenames, non-ascii
    -+filenames, funny author names or emails, invalid timezones, presence of
    -+grafts or replace objects, etc.), meaning they may have to wait a long
    -+time, hit an error, then restart.  The performance of filter-branch is
    -+so bad that this cycle is painful, reducing the time available to
    -+carefully re-check (to say nothing about what it does to the patience of
    -+the person doing the rewrite even if they do technically have more time
    -+available).  This problem is extra compounded because errors from broken
    -+filters may not be shown for a long time and/or get lost in a sea of
    -+output.  Even worse, broken filters often just result in silent
    -+incorrect rewrites.
    ++such as deleting a couple files.  Unfortunately, people often learn if
    ++the snippet is right or wrong by trying it out, but the rightness or
    ++wrongness can vary depending on special circumstances (spaces in
    ++filenames, non-ascii filenames, funny author names or emails, invalid
    ++timezones, presence of grafts or replace objects, etc.), meaning they
    ++may have to wait a long time, hit an error, then restart.  The
    ++performance of git-filter-branch is so bad that this cycle is painful,
    ++reducing the time available to carefully re-check (to say nothing about
    ++what it does to the patience of the person doing the rewrite even if
    ++they do technically have more time available).  This problem is extra
    ++compounded because errors from broken filters may not be shown for a
    ++long time and/or get lost in a sea of output.  Even worse, broken
    ++filters often just result in silent incorrect rewrites.
     +
     +* To top it all off, even when users finally find working commands, they
     +naturally want to share them.  But they may be unaware that their repo
4:  1dbca82408 = 4:  ca8e124cb3 t9902: use a non-deprecated command for testing
5:  762d63d6a5 < -:  ---------- Remove git-filter-branch, it is now external to git.git
-- 
2.23.0.38.g892688c90e

