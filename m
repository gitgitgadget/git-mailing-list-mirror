Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC9A11F4B9
	for <e@80x24.org>; Wed, 28 Aug 2019 17:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfH1RQc (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 13:16:32 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38927 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfH1RQb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 13:16:31 -0400
Received: by mail-vs1-f65.google.com with SMTP id y62so490433vsb.6
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 10:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U1JlXCAxvxHY/ob6by6FoXol0/Ko4h4v7tQG5v3LjuQ=;
        b=F5Lna0cI1zKdjjYrRAnHN+45BsQjIWajsIN6VfkWdZ8pwR2QEprGJ3In0dKAwVARVx
         9zrIFNPWQ2r871T8bN/wzlJoalH7KD5i87o4Lh9mRAkpjOQiUrki8mMGkDoteqjKAXfK
         7WcVdqkRw8FlGPHdkWTeLFUuzELU8xi5IBKm2ZQh6VIgd8Ut4n/4M7yEMLDVWPI6vBBd
         4TlkBDAq88atlwr0lpTfyh6618s30ugTzszefGZZzQboBt7WQe/i0PEbPoM/tN7HzQ62
         0w7G02tv4t6ZSZird3nvjhPvU4pTt9KNkFmmeK6fJmXE/xqBqoT7LCy5P9cDzaNRy4Si
         9gDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U1JlXCAxvxHY/ob6by6FoXol0/Ko4h4v7tQG5v3LjuQ=;
        b=pBfsAyXhFEhu0REJV7ISB1pGiGTNmKtayyzwalUc9UCxAPgARuHiSp11drjw+gckwR
         rZJU7YjZBKY6I1SyZvuFzjvPljPkFHr3KI8TUuxv7JqRpQ+SZdesl+QhM6A/CF9Dhi33
         BIhUFEgHQo5YPqM6w6HsdYyDh+X88S2oliiV0Opw82LlDmxGI4V7qJLm3FjWdEnIFj6Z
         ++ZQBGXKfKlHR78Q/zf2CVzSKwmtehm9YALNNd+nmPKpsQLS1ahHjNFmNwyIkkY/n+d9
         0xTUF65086EVhwIrlx2Uq1pm8NmwZMH9fvYv7Tl4jKykF+5OBWn0GOFjbrmX1pJHBjG8
         U30g==
X-Gm-Message-State: APjAAAV63iMQEmaIFrK2ROEDpsS7bmyFmDmMmqjlEqqpE+Lc1L+3X8OZ
        33pmbELBEmMD7oK10ofcmZuatJHucqTmSpygXnE=
X-Google-Smtp-Source: APXvYqxNNoTXnGdszZu76wDkDUUL9uXp4s4SfuZy78d2jDndNNqU9ZeM2hakLpe+tX+I0uvKlbqZ7ZgOJUlVAVKJ4Ic=
X-Received: by 2002:a67:d099:: with SMTP id s25mr3182476vsi.175.1567012590090;
 Wed, 28 Aug 2019 10:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqd0gwopej.fsf@gitster-ct.c.googlers.com> <20190826235226.15386-1-newren@gmail.com>
 <20190827070324.7l2cpc3dlnithbm6@whir> <87v9ujc827.fsf@osv.gnss.ru>
 <CABPp-BGfoRX-ob986kd-vvBo3meg-MpJ8Jo85G_2GgARY=cxxg@mail.gmail.com> <87blw93c5n.fsf@osv.gnss.ru>
In-Reply-To: <87blw93c5n.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 28 Aug 2019 10:16:18 -0700
Message-ID: <CABPp-BEYRmhrb4Tx3bGzkx8y53T_0BYhLE5J0cEmxj18WtZs9A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Remove git-filter-branch from git.git; host it elsewhere
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Wed, Aug 28, 2019 at 1:52 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Tue, Aug 27, 2019 at 1:43 AM Sergey Organov <sorganov@gmail.com> wrote:
> >>
> >> Eric Wong <e@80x24.org> writes:
> >>
> >>
> >> [...]
> >>
> >> > AFAIK, filter-branch is not causing support headaches for any
> >> > git developers today.  With so many commands in git, it's
> >> > unlikely newbies will ever get around to discover it :)
> >> > So I think think we should be in any rush to remove it.
> >>
> >> Nah, discovering it is simple. Just Google for "git change author". That
> >> eventually leads to a script that uses "git filter-branch --env-filter"
> >> to get the job done, and I'm afraid it is spread all over the world.
> >>
> >> See, e.g.:
> >>
> >> https://help.github.com/en/articles/changing-author-info
> >
> > Side note: Is the goal to "fix names and email addresses in this
> > repository"?  If so, this guide fails: it doesn't update tagger names
> > or email addresses.  Indeed, filter-branch doesn't provide a way to do
> > that.  (Not to mention other problems like not updating references to
> > commit hashes in commit messages when it busy rewriting everything.)
>
> No. Maybe the original goal was like that, by I, personally, use
> modified version of this to change my "Author" credentials from
> "internal" to "public" in branches that I'm going to send upstream, so
> the actual aim is to change e-mail of particular Author from a@b to c@d
> in all the commits in a (feature) branch.

There's an interesting usecase I hadn't heard of or thought of before.
Quick question to see if I'm understanding correctly: "all commits in
a branch" or "all commits *unique* to a branch"?

(Perhaps the only commits with the author you want to change are among
the commits that are unique to that branch and so the distinction
doesn't matter, but it wasn't clear from the description.)

> >> > But I agree that filter-branch isn't useful and certainly
> >> > shouldn't be encouraged/promoted.
> >>
> >> Well, is there more suitable way to change author for a (large) set of
> >> commits then?
> >
> > I would say yes, use git filter-repo (note that this thread started
> > with me proposing filter-repo for inclusion in git.git -- and getting
> > suggestions that we should remove stuff instead of adding more stuff).
> > I'm biased, but I think it's much better at this particular job as
> > well:
>
> Well, I don't want to change the entire repo, and I don't immediately
> see how to do it with git filter-repo. Is it at all possible?

Yes, it is possible.  filter-repo has a hidden --refs argument
defaulting to --all; you could instead set it to e.g.
origin/master..master.

--refs is the only hidden option in filter-repo.  I know it may look
funny that I spent a bunch of effort to create the
--reference-excluded-parents option to fast-export explicitly so that
it would be possible to do partial history rewrites like this, and
then to hide and avoid documenting this option (though I did hint that
it existed in the documentation if you search for "Partial-repo
filtering"), but there was a few reasons for this:

  * mixing old and new history for most rewrites that
filter-branch/filter-repo/bfg/etc are used for can really mess things
up and make it hard to recover from.  I don't like trying to clean up
repos with accidental duplicate copies of most commits in the repo,
and I suspect others like it even less.  So, anything that makes it
easier to make such mistakes needs to have a really good rationale in
order for me to expose it.
  * The only usecases I knew of for partial repo filtering prior to
your email were (1) side-stepping insanely slow execution time of poor
filtering tools like filter-branch, and (2) performing operations
better suited to git-rebase anyway (e.g. the --signoff option to
rebase did not exist once upon a time and so folks could have used
filter-branch to fake it, but using rebase is the better way to make
this change).  And, even after your email, I'm not sure that has
changed though, as noted below.

> > You can create a mailmap file and pass it to the --mailmap option to
> > git-filter-repo.
> >
> > Or, if you prefer (perhaps you don't like git's mailmap format as used
> > by shortlog and now log, or perhaps you really want to be able to do
> > regex replacement or something), you can use the --name-callback or
> > --email-callback to work on those fields more directly.
> >
> > Or, if you prefer (e.g. you want to handle author vs. committer vs.
> > tagger differently), you can use the --commit-callback and
> > --tag-callback filters.
> >
> > As an added bonus, filter-repo will also perform the rewrite far
> > faster than filter-branch (and rewrite commit hashes in commit
> > messages as alluded to above).
>
> These things are nice to have indeed, but it always changes the entire
> repo, right? If so, it's not a suitable substitute for git-filter-branch
> for particular job at hand.

It *defaults* to changing the entire repo.  You may also be interested
to note that two of the demos in contrib/filter-repo-demos[1]
explicitly make use of partial history filtering -- one of the two
being the filter-branch reimplementation (I created a script that
reimplemented filter-branch on top of filter-repo and made it accept
the exact same flags as filter-branch.  That script passes all the
filter-branch regression tests from git.git and it's much faster than
filter-branch, though it's still glacially slow compared to
filter-repo, and has all the safety problems that filter-branch does).

[1] https://github.com/newren/git-filter-repo/tree/master/contrib/filter-repo-demos

> Actually, I'd rather expect some support for this in "git rebase", being
> git history editing/reshaping tool, but it looks like it only has it in
> the form that is very difficult to automate.

I agree that git rebase would be the better choice here; I typically
feel it's the better choice for rewrites of recent history.  I think
it provides just what you need:

  git rebase --exec="git commit --amend --reset-author -C HEAD" $UPSTREAM

(Assuming, of course, that you've either set the right environment
variables or set user.name and user.email to the new values you want
so that commit's --reset-author flag can reset to the *new* author.)

> >> > Yet there's probably still users which ARE happy with it, that
> >> > will never hit the edge cases and problems it poses; and will
> >> > never read release notes.  And said users are probably getting
> >> > git from a slow-moving distro, so it'd be a disservice to them
> >> > if they lost a tool they depend on without any warning.
> >>
> >> Personally, I'm far from happy with it, but I have no clue how to
> >> substitute it in the job above. Anybody?
> >
> > The start of this thread where I proposed git filter-repo for
> > inclusion in git[1] had links to documentation and comparisons to
> > other tools and such.  You may find those links helpful; if not, let
> > me know what needs to be fixed in the documentation.
>
> Thank you for the references, I find it a very nice tool to have!
>
> Pity it's not an entire substitute for git filter-branch.

Au contraire, I believe it is.  :-)

Thanks for the interesting usecase.  It sounds like we both think this
one happens to be better solved by rebase, and the command snippet I
provided above should show you to use rebase to solve it.  However, if
you come up with any others where partial repo filtering makes sense,
I'm always willing to reconsider my decision to make the --refs
argument hidden; it may just mean adding more warnings, but it might
also involve changing other defaults (e.g. the automatic
repacking/pruning).  I'd need concrete usecases to know for sure how
I'd want to handle it.

Hope that helps,
Elijah
