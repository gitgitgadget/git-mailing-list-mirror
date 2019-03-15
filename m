Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FA3C20248
	for <e@80x24.org>; Fri, 15 Mar 2019 16:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbfCOQ2N (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 12:28:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42750 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbfCOQ2M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 12:28:12 -0400
Received: by mail-ed1-f65.google.com with SMTP id j89so8112047edb.9
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=gUfXgeJ8buwE15Jz3T2knqhxljnD3872W0blCY1K4VY=;
        b=oqzTv8Ed+NiAWmyaaYgBkUU5wJSjp03eznklAOjWxgUwjbExTwhfZSFl0ugbp/PwKi
         uG+LTpmQWJF1MPXGDA73ecpzj2y12Pdy6nEjTr/pG0AAmYmWWHpOIV71MVkGP6ZKHwHt
         USrENnRckmzW8W9HFWAo6LmuhcOG5tNfwtr0aP8JhBsbIVNwBv/60uuwrd778ahJcZTU
         IwCekTfnZoDuwOKTCSzZmHLPHMCiKVoBdM0nB/VsIe0eO4bnJ6EwwIq9xAdmbr9nUds6
         7Yn/Bhh64q2njIl192uoxNV3sH5BeGUZIjofYNR4Vuvw+iH8LVWza8IOcIrO4AhTTWmo
         592g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=gUfXgeJ8buwE15Jz3T2knqhxljnD3872W0blCY1K4VY=;
        b=mXKQB5xrF3meKp6f+gEOgOIWiCTFPe2Y5iwxDGKlBcc8Cp466ka3VpXaWvbi30byMK
         EtJBmmEy6Z1t3ZxWzM8Z5PEoObpkuqfPnbujcvhIGsPrPr/iwjpIFfSZMJ/z9pIkc/7l
         jy1Ke+S0AH2xEexmWNom46RUgGBQ3357+8p5lQ1CLLUzyr+UjlbCCqBO+9+WoZ13Y55w
         VdV11hrG6OkaFmL0/uCiGGmOJATByMIa2/cGhZ50EG2EPxGTEcwI6vunYAS9e//E6lpi
         yJRbfgzIh9BsRSPj8NMbgyMeziFranAfQvTnkePSBYtv12Q0w2jVqqOd1UlzVao+Ud5m
         Znsw==
X-Gm-Message-State: APjAAAVRGKnGnzsmsAdc05ZjyCqXelnCm9Fqtl9DbIl4arif+MUKQaXb
        uKVpCk+KqpaufN5HrOtIfvmp8wLK3cY=
X-Google-Smtp-Source: APXvYqxobEH74X5FLP3H3NH+BsaB399YaUbSEM7uehEF7fDgMwX6ILB/aUpAL3zksJhK7tUJXgdXYA==
X-Received: by 2002:a50:8562:: with SMTP id 89mr3332864edr.5.1552667290064;
        Fri, 15 Mar 2019 09:28:10 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id f9sm760446eds.56.2019.03.15.09.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 09:28:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: GitGitGadget on github.com/git/git?, was Re: [RFC/PATCH] point pull requesters to Git Git Gadget
References: <20190312213246.GA6252@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1903141235390.41@tvgsbejvaqbjf.bet> <20190315033020.GE28943@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1903151443420.41@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1903151443420.41@tvgsbejvaqbjf.bet>
Date:   Fri, 15 Mar 2019 17:28:08 +0100
Message-ID: <87va0k9k6f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 15 2019, Johannes Schindelin wrote:

> Hi Peff,
>
> On Thu, 14 Mar 2019, Jeff King wrote:
>
>> On Thu, Mar 14, 2019 at 01:04:51PM +0100, Johannes Schindelin wrote:
>>
>> > > One thing that I think submitGit can do that GGG cannot (yet), is just
>> > > take PRs straight on git/git. If we're going to start recommending it,
>> > > then I think we'd probably want to configure that, since it's one less
>> > > confusing step for first-timers, who right now might have to go re-make
>> > > their PR on gitgitgadget/git.
>> >
>> > I just realized that I had not responded to that yet. It is not *quite*
>> > that easy, unfortunately.
>> >
>> > I did design GitGitGadget to have a state. For example, to avoid spamming
>> > the Git mailing list with bogus patch series, GitGitGadget maintains a
>> > list of GitHub user names for users allowed to send patch series. (I saw
>> > my share of bogus PRs in the Git for Windows fork, and had no desire to
>> > facilitate similar patch series on the list.) This information, together
>> > with information about the Message IDs to monitor, and about the PRs that
>> > are still open, are maintained in a JSON-formatted object that is stored
>> > in `refs/notes/gitgitgadget`.
>>
>> Ah, I wondered if there might be a catch like this. I do think it would
>> be nice to keep that ref out of git.git. We definitely would not want to
>> lose the features that depend on it, but it sounds like we could use a
>> separate metadata repository.
>
> How about... brace yourself... https://github.com/gitgitgadget/git?

FWIW I'd love to see it on git/git for discoverability. From the rest of
your E-Mail it sounds like you're working on that. So just a +1.

If that doesn't work for whatever reason maybe we can amend git.git with
this to point people to it:
https://help.github.com/en/articles/creating-a-pull-request-template-for-your-repository

We have one in .github/PULL_REQUEST_TEMPLATE.md, maybe along with *.txt
docs we should amend that, unless of course real GGG on git/git is
imminent...

> Seriously, I still think that the `refs/notes/gitgitgadget` note was a
> rather smart idea, and it was designed to allow for serving multiple
> repositories. You will note that the PR references in
> https://github.com/gitgitgadget/git/blob/1380f7ee9aaf/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391
> are all full URLs, including the GitHub domain and the org. So if any
> contributor feels strongly enough to support, say, BitBucket or GitLab in
> GitGitGadget, the data structures support that (and I would gladly accept
> PRs for a change).
>
> Read: yes, we could totally extend GitGitGadget in a minimal fashion so
> that it supports PRs at https://github.com/git/git and stores the relevant
> metadata in http://github.com/gitgitgadget/git's `gitgitgadget` note,
> still.
>
>> > I could imagine that we keep pushing those refs to gitgitgadget/git,
>> > but now also allow for PRs on git/git to use GitGitGadget (we would
>> > have to install the GitHub App there, too, and I would have to change
>> > the code to allow that, and we would have to use a slightly different
>> > format for the tags generated from git/git PRs to avoid clashes with
>> > the gitgitgadget/git PRs, all of which is totally doable).
>>
>> I don't think connecting the GitHub App should be a big deal. Ideally it
>> would not even need write permission to the git/git repository, if it's
>> keeping metadata elsewhere (it would need to be able to write PR
>> comments, of course).
>
> Well, bummer. I cannot tell GitHub that it needs a certain permission on
> git/git vs another permission on gitgitgadget/git.
>
> I guess I'll have to be really diligent about the code base of
> GitGitGadget, then. Or maybe I'll use a second GitHub App that is only
> installed on gitgitgadget/git, as a hack.
>
>> It might not be a show-stopper if GitHub's permissions aren't
>> fine-grained enough to allow that, but not having repo write access
>> would be nice insurance against bugs in GitGitGadget writing where we
>> don't expect it to.
>
> Right. Hack it is.
>
>> > If this is truly something we ("we" as in "engaged Git developers")
>> > want, I can set aside some time to work on that. I had originally
>> > planned on exactly that, i.e. supporting PRs on git/git, but I got
>> > rather strong indications that GitGitGadget is hated by some (Duy, for
>> > example, was very vocal about refusing to even look at any of the
>> > GitGitGadget-sent patch series, let alone using the tool himself).
>> > While I think that this hate is undeserved, I cannot change other
>> > people's feelings, nor would I try, all I can do is to try not to make
>> > the situation worse.
>> >
>> > In short: before I spend serious time on extending GitGitGadget to
>> > handle git/git PRs, I want to be sure that I won't get backlash for
>> > that.
>>
>> IMHO, GitGitGadget is a useful tool to develop. It has some rough edges,
>> still, but I think the _idea_ is certainly a good one. Especially if the
>> dream of bi-directionality is ever fulfilled (though I am not exactly
>> holding my breath on that; I think it can get very tricky). But even
>> without that, I think it's useful to have something like it (or
>> submitGit) available for some contributors.
>
> Agreed.
>
>> In general, I have not minded the use of GGG on the list lately by you
>> or Stolee. I do complain about the rough edges (timestamps, sender-cc on
>> the cover letter, etc), but even as it stands now I am not hating it as
>> a reviewer. If you are happy with it on the sending side, and especially
>> if you want to smooth some of those rough edges, then I do not have a
>> problem myself with its continued use.
>
> Well, Peff, if I had to rank the Git mailing list regulars by "niceness",
> you would be on top. I never doubted that you'd be okay with it.
>
> Junio has been quite a bit more critical of it. And Duy really made a
> stink of it. But yeah, while I really did not feel any love for
> GitGitGadget, I also did not hear more than two voices speaking out
> against at least the current state of GitGitGadget.
>
> I'll give others time to chime in before I decide whether I should take
> GitGitGadget into the direction of git/git. (Because, remember, it is not
> quite "free", it takes a lot of time out of my schedule.)
>
> For the time being, I'll of course continue GitGitGadget myself, primarily
> because it addresses precisely all of my needs. Which makes sense, because
> those who develop the software always get the most out of it. It's the way
> it goes.

FWIW my temptations to use it stopped at
https://public-inbox.org/git/nycvar.QRO.7.76.6.1810022234350.2034@tvgsbejvaqbjf.bet/
i.e. In-Reply-To support.

I've also noticed that for 1/1 patches it sends a 0/1, I don't do that,
and personally wouldn't want to (just add any comments below "---").

But I'm really happy it's there & useful to people, just not tempted to
use it myself because I have a workflow I use already, and from
observing it in action I couldn't losslessly move 100% of my submissions
to it.
