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
	by dcvr.yhbt.net (Postfix) with ESMTP id DE7BA1F4B7
	for <e@80x24.org>; Fri, 23 Aug 2019 18:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404551AbfHWSGz (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 14:06:55 -0400
Received: from mail-ua1-f41.google.com ([209.85.222.41]:38359 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404508AbfHWSGz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 14:06:55 -0400
Received: by mail-ua1-f41.google.com with SMTP id g13so3562805uap.5
        for <git@vger.kernel.org>; Fri, 23 Aug 2019 11:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8EFamHO5cnfdjNjUALrXgiF7akZe4f8J5mOh1Sra/K4=;
        b=gM2tXy4qmuVWojBtdvI46MfWSZNAP4Wp/CNj+VoddvNHdcHp5dRYu7mhuSq5Q2V6Kr
         nxBzgN0ukY7RG2aGlK7n3NpTnP9CdqDTvg0cD3aFkAyNz7X/UAkPxBAqAs7yB4vlw+gQ
         4Qb3l1wPNDBEvAL8LEK/cTIsxp/w5FwBDpOMJFbXex2jSS8QTldcbp0F3lkuc9NagK+F
         m+k1/Q0mgFtlhwO9B4qfceQuZg7+aq8TFvmVWumpCtWmHTwD1fBRWbGCmsQP19xIgGgj
         sNsCpf0OT4uHLG5CcZVwDOyZqMMx7igDs9fSJPKcZuCTst2rybm8IV3GRpklzwezExv0
         jppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8EFamHO5cnfdjNjUALrXgiF7akZe4f8J5mOh1Sra/K4=;
        b=dfJGtv3wq7ChGqAMGDuaIYYtWJid+jFxK7qW8obbbHT63a6veBwxW349Ha0EU9kCat
         ZFbeFUcReq0y5z5To4UjKwjyBP6yWgAlUHgMNC0MBzsG5Jybmok9sJX8PP1rxDv9hEM0
         ecOIM8cMme6tMWe+PeI7xxnErpCEdAaCmwxm+nnkmC8+6bW8cklstWnoii3UwSE9iURm
         9UTzPIcU0O78BSiSMUDmtRJRVCODLZtIOqKqkQ7pqZXxNTPBvfAGctvCfvkW9pTPxRCq
         QrDMXt61KLeiS/OAvBzDKWbr5rcfQl2vvtDbvs3jSA+au6nJhT1wgZwMCZarY6L0WA79
         GCOA==
X-Gm-Message-State: APjAAAWeXkdJI0mbnadIDNQsqVVcoz/MCNHxoWGW07IsLdeQ6jl8SuX4
        UX8YX6gCgYNum68nH2JNJ4IIU0A7bcwZdtcLTKY=
X-Google-Smtp-Source: APXvYqxrMgdMQ4h6XxypcuBrNJs7Te56wUZDhfrX/TfOc+LgaQ8cVSqRSpt1Ubm35JtBMepPq0haawXwYSNehu0Qxgw=
X-Received: by 2002:ab0:2b13:: with SMTP id e19mr3127258uar.81.1566583613241;
 Fri, 23 Aug 2019 11:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BEr8LVM+yWTbi76hAq7Moe1hyp2xqxXfgVV4_teh_9skA@mail.gmail.com>
 <xmqqlfvlne3k.fsf@gitster-ct.c.googlers.com> <CABPp-BFK65qL4GCs5bFuiPPYwMCDYrxMyYejacVS89d2GK4nDQ@mail.gmail.com>
 <20190823030059.47ftwfne6y436e5j@dcvr>
In-Reply-To: <20190823030059.47ftwfne6y436e5j@dcvr>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 23 Aug 2019 11:06:41 -0700
Message-ID: <CABPp-BEDOH-row-hxY4u_cP30ptqOpcCvPibwyZ2wBu142qUbA@mail.gmail.com>
Subject: Re: RFC: Proposing git-filter-repo for inclusion in git.git
To:     Eric Wong <e@80x24.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric!

On Thu, Aug 22, 2019 at 8:01 PM Eric Wong <e@80x24.org> wrote:
>
> Elijah Newren <newren@gmail.com> wrote:
> >   * Remove git-filter-branch from git.git.  Mention in the release
> > notes where people can go to get it.[1]
> >
> > filter-branch is not merely a slow or difficult-to-use tool, it's one
> > that *fosters* mistakes by making it hard to get things right in
> > several different ways.  Granted, people exercise extra caution using
> > filter-branch because they know they need to, but there are so many
> > gotchas that they're likely to accidentally mess something up.  Those
> > mess-ups are not always discovered immediately, and by then it's
> > nearly cast into stone (rewriting being something you want to do very
> > rarely).
>
> Is it possible to turn git-filter-branch into a fast, compatible,
> and (maybe) safe wrapper for git-filter-repo?  That would "fix"
> filter-branch and (if done carefully) not break existing uses.

Ooh, what an interesting question.  I can probably ramble on a LOT
longer than you expected about this...

== Short answer ==

It is certainly possible to reimplement git-filter-branch on top of
git-filter-repo, though slightly differently than how you appear to be
suggesting here.  In doing so, you can provide the same user interface
and have it be perfectly compatible.  In fact, I've already created
such a thing -- except that I took a few small liberties with
compatibility (and documented each), primarily to improve the speed --
and I can use it instead of git-filter-branch to pass the git.git
testsuite.  You can see it here:
https://github.com/newren/git-filter-repo/blob/master/contrib/filter-repo-demos/filter-lamely

HOWEVER, it is NOT possible at all to make such a thing be fast or
safe.  Not even close.  The performance and safety and are not
accidents of the implementation, but are baked into the design from
top to bottom and cannot be fixed without breaking backward
compatibility in lots and lots of different ways.  For the really
curious, I'll provide a possibly non-comprehensive list of why you
can't fix performance or safety if you require any compatibility at
all (and maybe throw in one or two things that could be
backward-compatibly fixed in filter-branch, such as the commit
encoding disaster):


== Long answer ==

Performance:

  * In editing files, git-filter-branch by design checks out each and
every commit as it existed in the original repo.  If your repo has
10^5 files and 10^5 commits, but each commit only modifies 5 files,
then git-filter-branch will make you do 10^10 modifications, despite
only having (at most) 5*10^5 unique blobs.
  * If you try and cheat and try to make filter-branch only work on
files modified in a commit, then two things happen (1) you run into
problems with deletions whenever the user is simply trying to rename
files (because attempting to delete files that don't exist looks like
a no-op; it takes some chicanery and work to remap deletes across file
renames when the renames happen via arbitrary user-provided shell),
and (2) even if you succeed at the map-deletes-for-renames chicanery
(as I believe I did in my reimplementation), you still technically
violate backward compatibility because users are allowed to filter
files in ways that depend upon topology of commits instead of
filtering solely based on file contents or names (though I have never
seen any user ever do this).
  * Even if you don't need to edit files but only want to e.g. rename
or remove some and thus can avoid checking out each file (i.e. you can
use --index-filter), you still are passing shell snippets for your
filters.  This means that for every commit, you have to have a
prepared git repo where users can run git commands.  That's a lot of
setup.  It also means you have to fork at least one process to run the
user-provided shell snippet, and odds are that the user's shell
snippet invokes lots of commands in some long pipeline, so you will
have lots and lots of forks.  For every. single. commit.  That's a
massive amount of overhead to rename a few files.
  * filter-branch is written in shell, which is kind of slow.
Naturally, it makes sense to want to rewrite that in some other
language.  However, filter-branch documentation states that several
additional shell functions are provided for users to call, e.g. 'map',
'skip_commit', 'git_commit_non_empty_tree', If filter-branch itself
isn't a shell script, then in order to make those shell functions
available to the users' shell snippets you have to prepend the shell
definitions of these functions to every one of the users' shell
snippets and thus make these special shell functions be parsed with
each and every commit.
  * filter-branch provides a --setup option which is a shell snippet
that can be sourced to make shell functions and variables available to
all other filters.  If filter-branch is a shell script, it can simply
eval this shell snippet once at the beginning.  If you try to fix
performance by making filter-branch not be a shell script, then you
have to prepend the setup shell snippet to all other filters and parse
it with every single commit.
  * git-filter-branch writes lots of files to $workdir/../map/ to keep
a mapping of commits, which it uses for the map() command it provides.
Other files like $tempdir/backup-refs, $tempdir/raw-refs,
$tempdir/heads, $tempdir/tree-state are all created internally too --
and users could have accessed any of these.  Users even had a pointer
to follow in the form of Documentation that the 'map' command existed,
which naturally uses the $workdir/../map/* files.  So, even if you
don't have to edit files, for strict backward compatibility you need
to still write a bunch of files to disk somewhere and keep them
updated for every commit.  You can claim it was an implementation
detail that users should not have depended upon, but the truth is
they've had a decade where they could so.  So, if you want full
compatibility, it has to be there.  Besides, the regression tests
depend on at least one of these details, specifying an --index-filter
that reaches down and grabs backup-refs from $tempdir, and thus
provides resourceful users who do google searches an example that
there are files there for them to read and grab and use.  (And if you
want to pass the existing regression tests, you have to at least put
the backup-refs file there even if it's irrelevant to your
implementation otherwise.)

Safety:

filter-branch is riddled with gotchas resulting in various ways to
easily corrupt repos or end up with a mess worse than what you started
with:

* Someone can have a set of "working and tested filters" which they
document or provide to a coworker, who then runs them on a different
OS where the same commands are not working/tested (even the
git-filter-branch manpage is guilty here).  BSD vs. GNU userland
differences can really bite.  If you're lucky, you get ugly error
messages spewed.  But just as likely, the commands either don't do the
filtering requested, or silently corrupt making some unwanted change.
The unwanted change may only affect a few commits, so it's not
necessarily obvious either.  (The fact that problems won't necessarily
be obvious means they are likely to go unnoticed until the rewritten
history is in use for quite a while, at which point it's really hard
to justify another flag-day for another rewrite.)
 * filenames with spaces (which are rare) are often mishandled by
shell snippets since they cause problems for shell pipelines.  Yes, I
know find -print0, xargs -0, ls-files -z, etc.  Not everyone does.
And even if they do, they may assume it's not relevant because someone
else renamed any such files in their repo back before the person doing
the filtering joined the project (or maybe they are just being lazy
and not thinking about everything that could go wrong).
 * non-ascii filenames (which are rare) can be silently removed
despite being in a desired directory (the desire to select paths to
keep often use pipelines like 'git ls-files | grep -v ^WANTED_DIR/ |
xargs git rm".  ls-files will only quote filenames if needed so folks
may not notice that one of the files didn't match the regex, again
until it's much too late.  Yes, someone who knows about core.quotePath
can avoid this (unless they have other special characters like \t, \n,
or "), and people who use ls-files -z can avoid this, but that doesn't
mean they will).
  * Similarly, when moving files around, one can find that filenames
with non-ascii or special characters end up in a different directory,
one that includes a double quote character.  (This is technically the
same issue as above with quoting, but perhaps an interesting different
way that it can and has manifested as a problem.)
  * It's far too easy to accidentally mix up old and new history.
It's still possible with any tool, but filter-branch almost invites
it.  If we're lucky, the only downside is users getting frustrated
that they don't know how to shrink their repo and remove the old
stuff.  If we're unlucky, they merge old and new history and end up
with multiple "copies" of each commit, some of which have unwanted or
sensitive files and others which don't.  This comes about in multiple
different ways: the default to only doing a partial history rewrite
('--all' is not the default and over 80% of the examples in the
manpage don't use it), the fact that there's no automatic post-run
cleanup, the fact that --tag-name-filter (when used to rename tags)
doesn't remove the old tags but just adds new ones with the new name
(the manpage documents this so it's presumably not a "bug" even though
it feels like it), and the fact that little educational information is
provided to inform users of the ramifications of a rewrite and how to
avoid mixing old and new history (e.g. not only do other users need to
understand that they need to rebase their changes for all their
branches on top of new history (or delete and reclone), but they also
need to manually delete all their tags before refetching, any
references that were on any shared servers (e.g. the central repo
folks push to) that weren't part of the rewrite need to be deleted,
and if the shared server has any locked-down refs such as
refs/changes/, refs/pull/, or refs/merge-requests/ then people need to
exercise extra caution; since none of these are fool-proof, someone
should probably also add some server-side hooks to prevent folks from
accidentally re-pushing old history, or make use of special facilities
(such as gerrit's ban-commit command) to prevent it.)
  * annotated tags can be accidentally converted to lightweight tags.
The first way this happens is folks do a rewrite, realize they messed
up, restore from the backups in refs/original/, and then redo their
filter-branch command.  (The backup in refs/original/ is not a real
backup; it dereferences tags first.)  Another way this happens is
despite passing --tags or --all on the command line, filter-branch
dereferences the tag for them.  The documentation does not make it all
that clear that in order to retain annotated tags as annotated, you
must use --tag-name-filter (and must not have restored from
refs/original/ in a previously botched rewrite).
  * Any commit messages that specify an encoding will become corrupted
by the rewrite; filter-branch ignores the encoding, takes the original
bytes, and feeds it to commit-tree without telling it the proper
encoding.  (This happens whether or not --msg-filter is used, though I
suspect --msg-filter provides additional ways to really mess things
up).
  * commit messages (even if they are all UTF-8) by default become
corrupted due to not being updated -- any references to other commit
hashes in commit messages will now refer to no-longer-extant commits.
  * no facilities for helping users find what unwanted crud they
should delete means they are much more likely to have incomplete or
partial cleanups that sometimes result in confusion and people wasting
time trying to understand  (e.g. folks tend to just look for big files
to delete instead of big directories or extensions, and once they do
so, then sometime later folks using the new repository who are going
through history will notice a build artifact directory that has some
files but not others, or a cache of dependencies (node_modules or
similar) which couldn't have ever been functional since it's missing
some files)
  * if --prune-empty isn't specified, then the filtering process can
create hoards of confusing empty commits
  * if --prune-empty is specified, then intentionally placed empty
commits from before the filtering operation are also pruned instead of
just pruning commits that became empty due to filtering rules.
  * if --prune empty is specified, sometimes empty commits are missed
and left around anyway (probably just a bug, but...).

Also, performance and safety combine:

  * Coming up with the correct shell snippet to do the filtering you
want is sometimes difficult unless you're just doing a trivial
modification such as deleting a couple files.  People have often come
to me for help, so I should be practiced and an expert, but even for
fairly simple cases I still sometimes taken over 10 minutes and
several iterations to get the right commands -- and that's assuming
they are working on a tiny repository.  Unfortunately, people often
learn if the snippet is right or wrong by trying it out, but the
rightness or wrongness can vary depending on special circumstances
(spaces in filenames, non-ascii filenames, funny author names or
emails, invalid timezones, presence of grafts or replace objects,
etc.), meaning they may have to wait a long time, hit an error, then
restart.  The performance of filter-branch is so bad that this cycle
is painful, reducing the time available to carefully re-check (to say
nothing about what it does to the patience of the person doing the
rewrite even if they do technically have more time available).  This
problem is extra compounded because errors from broken filters may not
be shown for a long time and/or get lost in a sea of output.  Even
worse, broken filters often just result in silent incorrect rewrites.
  * To top it all off, even when users finally find working commands,
they naturally want to share them.  But they may be unaware that their
repo didn't have some special cases that someone else's does.  So,
when someone else with a different repository runs the same commands,
they get hit by the problems above.  Or, the user just runs commands
that really were vetted for special cases, but they run it on a
different OS where it doesn't work, as noted above.

== End of long answer ==


Summary of above: Anything compatible with git-filter-branch will be
slower than molasses and extraordinarily unsafe.



> It could also spew warnings to recommend safer switches.

Ooh, I can take a crack at that right now: "For safety, don't use
--tree-filter, --index-filter, --commit-filter, --tag-name-filter,
--prune-empty, or (obviously) --force and _always_ use '--all' (and
nothing else) for <rev-list options>.  For performance, don't use
--tree-filter, --index-filter, --commit-filter, --tag-name-filter,
--setup, --env-filter, or --msg-filter.  Also, don't depend
refs/original/ stuff since that's unsafe (tag dereferencing), making
--original useless.  If you follow all these suggestions, -d is
useless too.  Oh, and I forgot to include --parent-filter among the
bad-for-performance cases because you should have been using
git-replace(1) instead of it for some time now,  So that leaves us
with our subset that could theoretically be made safe and performant:
--subdirectory-filter."

Turns out, filter-repo does support this exact flag, so if you're
willing to restrict yourself to this subset, then filter-repo IS a
drop-in replacement.  :-)

And if you want not just recommendations of flags to avoid, bug flags
you can use, then, again, see filter-repo for flags you can use.


> Stability is a major reason I use git, the Linux kernel,
> and why I distrust+avoid desktop/GUI software.  Removing
> "unsafe" features, even with good intentions, inevitably leads
> to frustrated users.

I did not and would not suggest deleting git-filter-branch.  I
suggested removing it from git.git and putting it elsewhere AND
telling people where that elsewhere is.  That elsewhere might be
git-filter-repo, it could be a different repo, or it could even be my
alternative faster (but still way too slow) re-implementation of
filter-branch.

Hope that helps,
Elijah
