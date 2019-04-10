Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 312AA20248
	for <e@80x24.org>; Wed, 10 Apr 2019 01:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfDJB7i (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 21:59:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38243 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfDJB7i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 21:59:38 -0400
Received: by mail-pl1-f194.google.com with SMTP id f36so367763plb.5
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 18:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hmrULNL0y/0U6LJZK2IbaT9cm77tExTGW4h/ImHWwcw=;
        b=m0BMjKABUe+VU455RdbP1+7qDMRD113mc1ziQH6ohqWSO1fOmfSCh7XmiRlqoKawwu
         1xTaTTfXs+nduL4lyKyx44H4vWrMMNmnDd/zqIN4xoS8oCWwOb753QopdzNqAS5H2oLC
         28L9nwp1wNgM/Si+iSJNV+7dhKS1aM/WpR+U0/CBnIIiVXceG1ivJ/iH3hL2lEKSk1bK
         SFxbdZE506l0/aHtEFdS7LPFhCR8c1Lbs1HQ4R1m95YHNBvP8n+QRtfbW1IHwvjF/YQe
         p1sxSdgliuVzQJVV9SrNF7evhvrHUtHhSHT3nJ913lp2Q8xxhmIOj3tFt9P8TgStufzI
         1kwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hmrULNL0y/0U6LJZK2IbaT9cm77tExTGW4h/ImHWwcw=;
        b=b3oyPS1+CsCISr5cHqrIHz6b5z1VFYGLRI82u0FWazUaVU5aQCqcL490SoNBShxQyN
         LMAJOOjQZeSF9QLQe6xRl+Rxl95XTHC59D+spf2of0AEDrs3DEeyFP5odw3z6zWDrxKH
         5KHUIGPAeJMolpa0Yb5DkRreFvKHSYOIuoYZrBYOZJZ6IOzjhlPp7VBCggYRtjXgHX0w
         EoJnY5FDfMjYf225az1aKf9Og3r+yW6Ql8DiBOM9Pb4RGVJonAYUYEif8/Lf6wzKKhMg
         6996m+pgHtjWPtnZltmh0gPisCtCXVFdh1KWahzY6WnO33h0p51GhIvdsw/C48sPCqzg
         F21Q==
X-Gm-Message-State: APjAAAXCafIGOjCOYkIqJ7qRJ1HBmFH3mOheIe3G0HfcS7OGwc1RnNmZ
        3i1bcUMZseolrpMUFbaZi69LKg==
X-Google-Smtp-Source: APXvYqztQsjX5kXfpLIAHFb9d+vj/sQkG04PPLw9jxK7sdKhLHne/kMtQCoua75MhjVX/PTM7tdLnQ==
X-Received: by 2002:a17:902:6b08:: with SMTP id o8mr41576454plk.105.1554861576584;
        Tue, 09 Apr 2019 18:59:36 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:c47d:9491:9418:887])
        by smtp.gmail.com with ESMTPSA id g10sm16649066pgq.54.2019.04.09.18.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 18:59:35 -0700 (PDT)
Date:   Tue, 9 Apr 2019 18:59:34 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 2/7] t: introduce tests for unexpected object types
Message-ID: <20190410015934.GB56470@Taylors-MBP.hsd1.wa.comcast.net>
References: <cover.1554435033.git.me@ttaylorr.com>
 <ef6b4f380435d9743a56f47f68c18123bf0a0933.1554435033.git.me@ttaylorr.com>
 <20190405105033.GT32732@szeder.dev>
 <20190405182412.GC2284@sigill.intra.peff.net>
 <20190405184229.GB8796@szeder.dev>
 <20190405185241.GG2284@sigill.intra.peff.net>
 <87a7h1a5uk.fsf@evledraar.gmail.com>
 <20190409022936.GE81620@Taylors-MBP.hsd1.wa.comcast.net>
 <871s2ba6bb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871s2ba6bb.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

On Tue, Apr 09, 2019 at 11:14:48AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Tue, Apr 09 2019, Taylor Blau wrote:
>
> > Hi Ævar,
> >
> > On Sun, Apr 07, 2019 at 11:00:19PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >>
> >> On Fri, Apr 05 2019, Jeff King wrote:
> >>
> >> > On Fri, Apr 05, 2019 at 08:42:29PM +0200, SZEDER Gábor wrote:
> >> >
> >> >> > > Don't run git commands upstream of a pipe, because the pipe hides
> >> >> > > their exit code.  This applies to several other tests below as well.
> >> >> >
> >> >> > I disagree with that rule here. We're not testing "cat-file" in any
> >> >> > meaningful way, but just getting some stock output from a known-good
> >> >> > commit.
> >> >>
> >> >> It makes auditing harder and sets bad example.
> >> >
> >> > I disagree that it's a bad example. Just because a reader might not
> >> > realize that it is sometimes OK and sometimes not, does not make it bad
> >> > to do so in the OK case. It means the reader needs to understand the
> >> > rule in order to correctly apply it.
> >>
> >> FWIW I thought the rule was something to the effect of "we're hacking on
> >> git, any change might segfault in some unexpected test, let's make sure
> >> that fails right away", hence the blanket rule in t/README against "!
> >> git <cmd>" in favor of "test_must_fail git <cmd>", and "don't feed the
> >> output of a git command to a pipe" documented right after that.
> >
> > I have some loosely-held opinions on this. Certainly knowing if a change
> > to git caused a segfault in some test is something that we would want to
> > know about, though I'm not sure we're loosing anything by putting 'git'
> > on the left-hand side of a pipe here.
> >
> >   - If someone wrote a change to git that introduced a segfault in 'git
> >     cat-file', I'm sure that this would not be the only place that in
> >     the suite that would break because of it. Presumably, at least one
> >     of those places uses 'test_must_fail git ...' instead
> >
> >   - At the very least, 'broken-commit' doesn't contain what it needs to,
> >     the test breaks in another way (albeit further from the actual
> >     defect), and the developer finds out about their bug that way.
> >
> > In any case, these above two might be moot anyways, because I'm almost
> > certain that it will be a rarity for someone to _only_ run t6102, unless
> > it is included in a blanket 'make' from within 't'.
>
> First. I realize we're talking about the light fixtures in the bike shed
> at this point, but with that in mind...

I don't mind some bike-shedding ;-).

> I just think it's useful as a general rule, particularly since with the
> "special setups" in the test mode we've found that all sorts of odd
> tests we didn't expect to stress test some features turned out to cover
> edge cases of them, e.g. when "GIT_TEST_COMMIT_GRAPH" was added we found
> that a bunch of random stuff segfaulted all over the place.
>
> So it's hard to say with any confidence in advance that something isn't
> going to stress git in some unusual way and isn't useful to guard for
> segfaults.

Yes, I think that's certainly true. There's something to be said for my
argument, too, (i.e., that it's ``probably'' just fine), but as I think
about it more, I'm less convinced that mine is a position worth holding.

Even if we catch only a bug or two on an off chance, there aren't too
many things I'd sacrifice to not make it so. In other words, I'm willing
to do quite a lot in order to get even a little indication of when
things are broken (including replacing 'git ... | sed' with 'git ... >foo &&
sed ... <foo').

> Of course if and when it segfaults it's likely to be seen by subsequent
> tests. In this case I'll note that if git fails we'll happily run not
> only perl/sed, but then hash-object the subsequent empty file, and then
> (presumably) fail in the next test.

Sure, we'll probably find out about it anyway, but still...

> >> > I am sympathetic to the auditing issue, though.
> >
> > Just to satisfy my curiosity, I put git on the left-hand side of a pipe
> > to see how many such examples exist today:
> >
> >   ~/g/git (master) $ git grep 'git cat-file .* |' -- t/t*.sh | wc -l
> >       179
> >
> > I'm not going to claim that changing 179 -> 180 is neutral or bad, but
> > it's interesting nonetheless.
>
> Separate from the question of if we generally agree that some value of
> "Y" makes for good coding style or not, we're always going to be in some
> flux state where a bunch of examples in our existing codebase contradict
> that, particularly in the test suite.
>
> I think that's a bit unfortunate in some ways. It's the result of the
> default "policy" that refactoring for refactoring's sakes is generally
> frowned upon, so we don't tend to go back and mass-fix "X" to "Y" once
> we agree "Y" is better than "X" for new code, just do it as we go when
> new code is written, or existing tests are updated for other reasons
> "while we're at it".

Is that refactoring for its own sake, though? I would personally be
happy to write a series that either (1) identifies spots in 't' where
`git` is found on the left-hand side of a pipe, (2) fixes the bad-style
invocation in those spots, or (3) both.

> >> > I dunno. In this case it is not too bad to do:
> >> >
> >> >   git cat-file commit $commit >good-commit &&
> >> >   perl ... <good-commit >broken-commit
> >> >
> >> > but I am not sure I am on board with a blanket rule of "git must never
> >> > be on the left-hand side of a pipe".
> >
> > I think that I mostly agree with Peff here for the reasons above.
> >
> > That all said, I don't really want to hold up the series for this alone.
> > Since there don't seem to be many other comments or issues, I would be
> > quite happy to do whatever people are most in favor of.
>
> FWIW this series LGTM as a whole. I think it says something about the
> general quality of it that we're all in some giant nitpick thread about
> perl v.s. sed and git on the LHS of a pipe or not :) I'm happy to have
> it queued as-is. These test issues are minor...

Thanks, I appreciate that you think the series is in good shape. Since
there haven't been too many comments other than this thread, I'm going
to send v2 now.

I decided to ban t6102 of all such 'git ... | sed' invocations, and
described the change earlier in this thread.

> > I basically don't really feel strongly about writing:
> >
> >   git cat-file commit $commit | sed -e ... >broken-commit
> >
> > as opposed to:
> >
> >   git cat-file commit $commit >good-commit &&
> >   sed -e '' <commit >bad-commit
> >
> >> >> > > Wouldn't a 'sed' one-liner suffice, so we won't have yet another perl
> >> >> > > dependency?
> >> >> >
> >> >> > Heh, this was actually the subject of much discussion before the patches
> >> >> > hit the list. If you can write such a one-liner that is both readable
> >> >> > and portable, please share it. I got disgusted with sed and suggested
> >> >> > this perl.
> >> >>
> >> >> Hm, so the trivial s/// with '\n' in the replacement part is not
> >> >> portable, then?  Oh, well.
> >> >
> >> > I don't think it is, but I could be wrong. POSIX does say that "\n"
> >> > matches a newline in the pattern space, but nothing about it on the RHS
> >> > of a substitution. I have a vague feeling of running into problems in
> >> > the past, but I could just be misremembering.
> >> >
> >> > We also tried matching /^tree/ and using "a\" to append a line, but it
> >> > was both hard to read and hit portability issues with bsd sed.
> >
> > I think that all of this discussion is addressed elsewhere in thread, but
> > the gist is that Eric provided a suitable sed invocation that I am going
> > to use instead of Peff's Perl.
> >
> >> > -Peff
> >
> > Thanks,
> > Taylor

Thanks,
Taylor
