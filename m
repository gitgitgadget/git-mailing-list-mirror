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
	by dcvr.yhbt.net (Postfix) with ESMTP id 81B5D1F4B7
	for <e@80x24.org>; Fri, 30 Aug 2019 00:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfH3AEV (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 20:04:21 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46334 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfH3AEV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 20:04:21 -0400
Received: by mail-vs1-f66.google.com with SMTP id x20so3593819vsx.13
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 17:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SSpcB8pBQHf9sEz/UTKbXpQXwehCWuFyjh8tIy0RKeM=;
        b=JOlkZ+jeb7VOSXPijYydq/vLJVfljVYeVlmaxseY1+C/k+cEARKo3vhL/jRaKc9AWu
         siMmyixQnwnZXH1WJ7pSL2iuqvhTODh3MHDsKCIxpW7tgcZRewEWunb6NFt1sG+9Gsqt
         158Ipoq69Q69xlkWaTZZQ52hZVzn076Wz3iMBpiyUZvLr6/yO0WvmScgM5aarnj2BKl/
         tkaE9mJ1fft1n1qUFFqOLovcYPLd4nL3ZLw6sz5Ij6cg9z/mN+1p3lyBj+BMkG3gifS1
         NbG9SVBZZb4gV/Nprxq5LVarx1py+d5kuxKX71dNRiHN0PgLfRPZ8ilie23Gapq8y3Bi
         o+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SSpcB8pBQHf9sEz/UTKbXpQXwehCWuFyjh8tIy0RKeM=;
        b=fYw4Jbk6WS85vG5Owg7gH5aopp9Pqrm7rEqhJ11LG3TZ7dScZpKaO0Ud0+NfCnuTg9
         dD3LhSdm/EcGLfZb70Yc0VK4DBIoG7AKG2ePm6BPKz1q26v+9UCcc7kxyV06CII47a+2
         J5lHT+FHHrf+vEPdfzJm4/YsuSbVybFN8J8Nx3zLah56SFycd70Nqx35N7m39rP99Ija
         BzK7e5qbFOg6oeIskZTHqTworsMK+R00KLJ7838KA3kx8QctLrhtYhe9mKEVK/OCuOQV
         ryRTAuAFO9R5dMDV8ZoHyJg8EbxywLm/81Ba7PAEwkOSXpvHnk381Q6Vo5dLuhT06a+0
         Wi5Q==
X-Gm-Message-State: APjAAAWt7u1rmgXnlhmaD1rVunlN5dJ6w/ElkTSLYDPMqu6uTWxfdjBr
        HeYIoI2SpSqFhS6dGkoCRcWgGnLk56UOmtoTODw=
X-Google-Smtp-Source: APXvYqyHWBJV0YKUByBAcj3HU7GlK8Ljn8gq5fLs4akiTCBo6Vc5fPZzitm8lKwCGRiWGfApsb2rbx6z8j7imaNt6uk=
X-Received: by 2002:a67:f887:: with SMTP id h7mr3265263vso.116.1567123459260;
 Thu, 29 Aug 2019 17:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190828002210.8862-1-newren@gmail.com> <20190829000657.26415-1-newren@gmail.com>
 <20190829000657.26415-4-newren@gmail.com> <CAPig+cQ-E8J9WfH96GKt5j0gb0s0XL5jC3AKyvJK36rpAvucmw@mail.gmail.com>
In-Reply-To: <CAPig+cQ-E8J9WfH96GKt5j0gb0s0XL5jC3AKyvJK36rpAvucmw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 29 Aug 2019 17:04:06 -0700
Message-ID: <CABPp-BEP94Z6e+SFyFnPPgnhQUn7dJqcmHCbpOiJ4-NDVm-ozA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] Recommend git-filter-repo instead of git-filter-branch
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

Thanks for the careful and thoughtful review.

On Thu, Aug 29, 2019 at 11:11 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Wed, Aug 28, 2019 at 8:07 PM Elijah Newren <newren@gmail.com> wrote:
> > filter-branch suffers from a deluge of disguised dangers that disfigure
> > history rewrites (i.e. deviate from the deliberate changes). [...]
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> > diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
> > @@ -16,6 +16,22 @@ SYNOPSIS
> > +WARNING
> > +-------
> > +'git filter-branch' has a plethora of pitfalls that can produce non-obvious
> > +manglings of the intended history rewrite (and can leave you with little
> > +time to investigate such problems since it has such abysmal performance).
> > +These safety and performance issues cannot be backward compatibly fixed and
> > +as such, its use is not recommended.  Please use an alternative history
> > +filtering tool such as https://github.com/newren/git-filter-repo/[git
> > +filter-repo].  If you still need to use 'git filter-branch', please
> > +carefully read <<SAFETY>> (and <<PERFORMANCE>>) to learn about the land
> > +mines of filter-branch, and then vigilantly avoid as many of the hazards
> > +listed there as reasonably possible.
> > +
> > +https://public-inbox.org/git/CABPp-BEDOH-row-hxY4u_cP30ptqOpcCvPibwyZ2wBu142qUbA@mail.gmail.com/[detailing
> > +the land mines of filter-branch]
>
> This stray link looks like leftover gunk from the previous revision.

Ugh, indeed.

>
> > +PERFORMANCE
> > +-----------
> > +
> > +The performance of filter-branch is glacially slow; its design makes it
>
> The rest of this document spells it git-filter-branch or 'git
> filter-branch', not plain filter-branch.
>
> > +* In editing files, git-filter-branch by design checks out each and
> > +every commit as it existed in the original repo.  If your repo has 10\^5
> > +files and 10\^5 commits, but each commit only modifies 5 files, then
> > +git-filter-branch will make you do 10\^10 modifications, despite only
> > +having (at most) 5*10^5 unique blobs.
> > +
> > +* If you try and cheat and try to make filter-branch only work on
> > +files modified in a commit, then two things happen
>
> s/filter-branch/git-&/

I can fix these up.

>
> > +
> > +  . you run into problems with deletions whenever the user is simply
> > +    trying to rename files (because attempting to delete files that
> > +    don't exist looks like a no-op; it takes some chicanery to remap
> > +    deletes across file renames when the renames happen via arbitrary
> > +    user-provided shell)
> > +
> > +  . even if you succeed at the map-deletes-for-renames chicanery, you
> > +    still technically violate backward compatibility because users are
> > +    allowed to filter files in ways that depend upon topology of commits
> > +    instead of filtering solely based on file contents or names (though
> > +    I have never seen any user ever do this).
>
> Maybe avoid first-person:
>
>     ... contents or names (though this has not been observed in
>     the wild).

Thanks for providing alternative wording.

> > +* filter-branch is written in shell, which is kind of slow.  Naturally,
> > +it makes sense to want to rewrite that in some other language.  However,
> > +filter-branch documentation states that several additional shell
> > +functions are provided for users to call, e.g. 'map', 'skip_commit',
> > +'git_commit_non_empty_tree'.  If filter-branch itself isn't a shell
> > +script, then in order to make those shell functions available to the
> > +users' shell snippets you have to prepend the shell definitions of these
> > +functions to every one of the users' shell snippets and thus make these
> > +special shell functions be parsed with each and every commit.
> > +
> > +* filter-branch provides a --setup option which is a shell snippet that
> > +can be sourced to make shell functions and variables available to all
> > +other filters.  If filter-branch is a shell script, it can simply eval
> > +this shell snippet once at the beginning.  If you try to fix performance
> > +by making filter-branch not be a shell script, then you have to prepend
> > +the setup shell snippet to all other filters and parse it with every
> > +single commit.
>
> Even though they made sense in the context of the original email
> message, these two bullet points may not belong in the man page since
> someone reading the man page is doing so to learn about
> git-filter-branch usage, not because he or she is thinking about
> re-implementing it. It might make sense, however, to collapse these
> points to some general statement about shell being slow and process
> startup being costly.

Hmm.  I see where you're coming from, but the performance section
isn't really user actionable stuff anyway; it's just a warning.  And I
have repeatedly seen over the years the question brought up on the
list of "Can we make filter-branch fast by making it a builtin?"  (Or
"Can't _you_ make filter-branch fast by rewriting it in C?")

I could try to reword it so that there's some general statement about
shell being slow and process startup being costly, and then add these
two items as sub-bullets to try to stave off that obvious but
misguided question from coming up.  Or maybe I just add a reference to
the original email?

> Also, these bullet points and others below need a  s/filter-branch/git-&/.

Thanks, will fix.

> > +* filter-branch writes lots of files to $workdir/../map/ to keep a
>
> Should that path have three dots "..." instead of two ".."?

No, it's a literal parent directory reference.  Users have access to
$workdir; it's where their commands run.  There is no name for the
parent of that directory, other than by appending '/..' to wherever
they are.  Maybe if I had spelled it as $(pwd)/../map/ it would be
better?

Or maybe I don't need to name the files at all; does it really matter
to the user?

> > +mapping of commits, which it uses pruning commits and remapping to
> > +ancestors and the map() command more generally.  Other files like
> > +$tempdir/backup-refs, $tempdir/raw-refs, $tempdir/heads,
> > +$tempdir/tree-state are all created internally too.  It is possible
> > +(though strongly discouraged) that users could have accessed any of
> > +these directly.  Users even had a pointer to follow in the form of
> > +Documentation that the 'map' command existed, which naturally uses the
> > +$workdir/../map/* files.  So, even if you don't have to edit files, for
> > +strict backward compatibility you need to still write a bunch of files
> > +to disk somewhere and keep them updated for every commit.  You can claim
> > +it was an implementation detail that users should not have depended
> > +upon, but the truth is they've had a decade where they could so.  So, if
> > +you want full compatibility, it has to be there.  Besides, the
> > +regression tests depend on at least one of these details, specifying an
> > +--index-filter that reaches down and grabs backup-refs from $tempdir,
> > +and thus provides resourceful users who do google searches an example
> > +that there are files there for them to read and grab and use.  (And if
> > +you want to pass the existing regression tests, you have to at least put
> > +the backup-refs file there even if it's irrelevant to your
> > +implementation otherwise.)
>
> As with the earlier comment, this bullet point is aimed at someone
> thinking about re-implementing the command; it sounds out of place in
> the "Performance" section of the man page. However, it does make sense
> to mention all the files git-filter-branch creates since that can have
> an impact on performance. So, perhaps this section can be collapsed so
> it just talks about that.

I think there's both a how-performance-affects-user component and a
component addressing the common incorrect question/statement/thought
that filter-branch performance could just be fixed by making it a
builtin.  But splitting this may make sense.  And maybe the portions
addressing making-it-a-builtin-wouldn't-fix-it could be a short
sentence with a link to the original email for more details.

> > +All of that said, performance of filter-branch could be improved by
> > +reimplementing it in a non-shell language and taking a couple small
> > +liberties with backward compatibility (such as having it only run
> > +filters on files changed within each commit).  filter-repo provides a
> > +demo script named
> > +https://github.com/newren/git-filter-repo/blob/master/contrib/filter-repo-demos/filter-lamely[filter-lamely]
> > +which does exactly that and which passes all the git-filter-branch
> > +regression tests.  It's much faster than git-filter-branch, though it
> > +suffers from all the same safety issues as git-filter-branch, and is
> > +still glacially slow compared to
> > +https://github.com/newren/git-filter-repo/[git filter-repo].
>
> This paragraph could be collapsed to say merely that, for those with
> existing tooling relying upon git-filter-branch, filter-repo's
> "filter-lamely" provides a drop-in replacement with somewhat improved
> performance and a few caveats.

Sounds good.

> Taking the above comments into consideration, here is a possible
> rewrite of the final three bullet points and the closing paragraph:

Oh, sweet, thanks for providing this.  I really like the simplicity of
your suggested wording in general; it will be really helpful in
rewording.  I do have a nitpick with each one, though...

>     * filter-branch is written in shell, which is kind of slow, and it
>       potentially can run many other commands which can slow down its
>       operation significantly, especially on platforms for which
>       process startup is costly.

Even if it's not the emphasis you intended, I'm worried this makes it
sound as if filter-branch performance is only bad on Windows or Mac.
Compared to invoking a function (even in a bytecode interpreted
language), creating and running another process is slow on any
platform.

>     * filter-branch writes lots of files to $workdir/.../map/ to keep
>       a mapping of commits, which it uses for pruning commits and
>       remapping to ancestors and for the map() command more generally.
>       Other files like $tempdir/backup-refs, $tempdir/raw-refs,
>       $tempdir/heads, $tempdir/tree-state are created internally too.
>       Such file creation can be costly in general, but especially on
>       platforms with slow filesystems.

Again, it may not have been your intended emphasis, but I think this
may be read as singling out slow filesystems, and make people think
the performance problems from this bullet point only affects some
OSes.  Filesystems are part of the problem.  Disks being slow is part
of the problem.  But it's not all of it.  I guess part of what really
gets me with these is that they represent forced synchronization (e.g.
the kernel has to flush the data upon close() to make sure any other
processes can see the file contents and all further filtering is
blocked waiting for this to finish).  By way of comparison, in
filter-repo I have to both write data to fast-import and read back
information from fast-import (in order to find out the new commit
names, for example).  When I did the straightforward thing of writing
a commit, writing a 'get-mark' directive, and then reading the answer,
it ruined performance.  So I had to be a bit smarter and defer reading
back the resulting sha1.  There's no room for anything similarly
clever in filter-branch; writing these files out is a synchronization
point that is needed before the user's filter can be eval'ed.

>     The tool https://github.com/newren/git-filter-repo/[git
>     filter-repo] is an alternative to git-filter-branch which does not
>     suffer from these performance problems or the safety problems
>     (mentioned below). For those with existing tooling which relies
>     upon git-filter-branch, 'git repo-filter' also provides
>     https://github.com/newren/git-filter-repo/blob/master/contrib/filter-repo-demos/filter-lamely[filter-lamely],
>     a drop-in git-filter-branch replacement (with a few caveats).

This suggests filter-lamely doesn't suffer from performance or safety
problems, which is very misleading.  filter-lamely doesn't improve the
safety story at all and only ameliorates the performance problems
somewhat.

> > +SAFETY
> > +------
> > +
> > +* Non-ascii filenames (which are rare) can be silently removed despite
>
> Perhaps drop "(which are rare)" to make this sound more formal and
> less like an email message.

Makes sense; and I'm guessing I should also drop it from the bullet
point above this one.

I'll stop commenting on the individual comments since there's not much
to say with most of them other than they look like obviously good
suggestions...

> Comment below also are intended to make the prose sound a bit more formal.
>
> > +being in a desired directory.  The desire to select paths to keep often
> > +use pipelines like `git ls-files | grep -v ^WANTED_DIR/ | xargs git rm`.
> > +ls-files will only quote filenames if needed so folks may not notice
>
> s/ls-files/git-&/
>
> > +that one of the files didn't match the regex, again until it's much too
> > +late.  Yes, someone who knows about core.quotePath can avoid this
> > +(unless they have other special characters like \t, \n, or "), and
> > +people who use ls-files -z with something other than grep can avoid
> > +this, but that doesn't mean they will.
> > +
> > +* It's far too easy to accidentally mix up old and new history.  It's
> > +still possible with any tool, but filter-branch almost invites it.  If
> > +we're lucky, the only downside is users getting frustrated that they
>
> s/we're//
>
> > +don't know how to shrink their repo and remove the old stuff.  If we're
>
> s/we're//
>
> > +unlucky, they merge old and new history and end up with multiple
> > +"copies" of each commit, some of which have unwanted or sensitive files
> > +and others which don't.  This comes about in multiple different ways:
> > +
> > +  ** the default to only doing a partial history rewrite ('--all' is not
> > +     the default and over 80% of the examples in the manpage don't use
> > +     it)
>
> Maybe just shorten this to:
>
>    ('--all is not the default, and few examples show it)

I know I said I'd not comment unless I disagreed, but I just wanted to
say thanks so much for providing concrete suggestions in so many
places.  It's *very* helpful.

> > +  ** the fact that there's no automatic post-run cleanup
> > +
> > +  ** the fact that --tag-name-filter (when used to rename tags) doesn't
> > +     remove the old tags but just adds new ones with the new name (this
> > +     manpage has documented this for a long time so it's presumably not
> > +     a "bug" even though it feels like it)
>
> Perhaps drop the final parenthetical comment.
>
> > +  ** the fact that little educational information is provided to inform
> > +     users of the ramifications of a rewrite and how to avoid mixing old
> > +     and new history.  For example, this man page discusses how users
> > +     need to understand that they need to rebase their changes for all
> > +     their branches on top of new history (or delete and reclone), but
> > +     that's only one of multiple concerns to consider.  See the
> > +     "DISCUSSION" section of the git filter-repo manual page for more
> > +     details.
> > +
> > +* Annotated tags can be accidentally converted to lightweight tags, due
> > +to either of two issues:
> > +
> > +  . Someone can do a history rewrite, realize they messed up, restore
> > +    from the backups in refs/original/, and then redo their
> > +    filter-branch command.  (The backup in refs/original/ is not a real
> > +    backup; it dereferences tags first.)
> > +
> > +  . Running filter-branch with either --tags or --all in your <rev-list
> > +    options>.  In order to retain annotated tags as annotated, you must
> > +    use --tag-name-filter (and must not have restored from
> > +    refs/original/ in a previously botched rewrite).
>
> Should these bullet points use "**" rather than "."?

I guess it could but the "either of two issues" above it made me think
of numbering them.  I also had a couple sub-bullets in the performance
section that were numbered.  But I guess it is slightly weird coming
so close after another section that used un-numbered subbullets.  I
guess I'll just make them all un-numbered.

> > +* Any commit messages that specify an encoding will become corrupted
> > +by the rewrite; filter-branch ignores the encoding, takes the original
> > +bytes, and feeds it to commit-tree without telling it the proper
> > +encoding.  (This happens whether or not --msg-filter is used, though I
> > +suspect --msg-filter provides additional ways to really mess things
> > +up).
>
> Perhaps shorten simply to:
>
>     (This happens whether or not --msg-filter is used.)
>
> > +* If the user provides a --tag-name-filter that maps multiple tags to
> > +the same name, no warning or error is provided; filter-branch simply
> > +overwrites each tag in some undocumented pre-defined order resulting in
> > +only one tag at the end.  If you try to "fix" this bug in filter-branch
> > +and make it error out and warn the user instead, one of the
> > +filter-branch regression tests will fail.  (So, if you are trying to
> > +make a backward compatible reimplementation you have to add extra code
> > +to detect collisions and make sure that only the lexicographically last
> > +one is rewritten to avoid fast-import from seeing both since fast-import
> > +will naturally do the sane thing and error out if told to write the same
> > +tag more than once.)
>
> Maybe drop everything from "If you try to 'fix'..." to the end of paragraph.

Or just replace that long section you highlight with a parenthetical
comment, "(a git-filter-branch regression test requires this.)"

> > +Also, the poor performance of filter-branch often leads to safety issues:
> > +
> > +* Coming up with the correct shell snippet to do the filtering you want
> > +is sometimes difficult unless you're just doing a trivial modification
> > +such as deleting a couple files.  People have often come to me for help,
> > +so I should be practiced and an expert, but even for fairly simple cases
> > +I still sometimes take over 10 minutes and several iterations to get
> > +the right commands -- and that's assuming they are working on a tiny
> > +repository.  Unfortunately, people often learn if the snippet is right
> > +or wrong by trying it out, but the rightness or wrongness can vary
> > +depending on special circumstances (spaces in filenames, non-ascii
> > +filenames, funny author names or emails, invalid timezones, presence of
> > +grafts or replace objects, etc.), meaning they may have to wait a long
> > +time, hit an error, then restart.  The performance of filter-branch is
> > +so bad that this cycle is painful, reducing the time available to
> > +carefully re-check (to say nothing about what it does to the patience of
> > +the person doing the rewrite even if they do technically have more time
> > +available).  This problem is extra compounded because errors from broken
> > +filters may not be shown for a long time and/or get lost in a sea of
> > +output.  Even worse, broken filters often just result in silent
> > +incorrect rewrites.
>
> Drop the "People have often come to me..." sentence from this paragraph.


Thanks again for the careful reading and many suggestions!
