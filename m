Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04996C433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 02:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D49D0610CA
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 02:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbhDSC6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Apr 2021 22:58:24 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53184 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229845AbhDSC6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Apr 2021 22:58:24 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 5B8971F4B4;
        Mon, 19 Apr 2021 02:57:54 +0000 (UTC)
Date:   Mon, 19 Apr 2021 02:57:54 +0000
From:   Eric Wong <e@80x24.org>
To:     Son Luong Ngoc <sluongng@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Raxel Gutierrez <raxelgutierrez09@gmail.com>,
        mricon@kernel.org, patchwork@lists.ozlabs.org,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: Pain points in Git's patch flow
Message-ID: <20210419025754.GA26065@dcvr>
References: <YHaIBvl6Mf7ztJB3@google.com>
 <YHhfsqfTJ9NzRwS1@C02YX140LVDN.corpad.adbkng.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YHhfsqfTJ9NzRwS1@C02YX140LVDN.corpad.adbkng.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Son Luong Ngoc <sluongng@gmail.com> wrote:
> Hi there,
> 
> I'm not a regular contributor but I have started to subscribe to the
> Git's Mailing List recently.  So I thought it might be worth sharing my
> personal view on this.
> 
> After writting all the below, I do realize that I have written quite a
> rant, some of which I think some might consider to be off topic.  For
> that, I do want to appologize before hand.

Thanks for the feedback, some points below.

>  Tue, Apr 13, 2021 at 11:13:26PM -0700, Jonathan Nieder wrote:
> > Hi,
> > 
> ...
> > 
> > Those four are important in my everyday life.  Questions:
> > 
> >  1. What pain points in the patch flow for git.git are important to
> >     you?
> 
> There are several points I want to highlight:
> 
> 1. Issue about reading the Mailing List:
> 
> - Subscribing to Git's Mailing List is not trivial:
>   It takes a lot of time to setup the email subscription.  I remember
>   having to google through a few documents to get my subscription
>   working.
> 
> - And even after having subscribed, I was bombarded with a set
>   of spam emails that was sent to the mailing list address.  These spams
>   range anywhere from absurd to disguising themselves as legitimate
>   users trying to contact you about a new shiny tech product.

Note that subscription is totally optional.

Gmail's mail filters probably aren't very good, perhaps
SpamAssassin or similar filters can be added locally to improve
things for you.

Spam filtering is a complex topic and Google's monopolistic
power probably doesn't inspire them to do better.

> 2. Issue about joining the conversation in the Maling List:
> 
> - Setting up email client to reply to the Mailing List was definitely
>   not trivial.  It's not trivial to send a reply without subscribing to
>   the ML(i.e. using a Header provided from one of the archive).
>   The list does not accept HTML emails, which many clients
>   use as default format.  Getting the formatting to work for line
>   wrapping is also a challenge depends on the client that you use.

The spam (and phishing) problem would be worse if HTML mail were
accepted.  Obfuscation/misdirection techniques used by spammers
and phishers aren't available in plain-text.

It's also more expensive to filter + archive HTML mail due to
decoding and size overheads, which makes it more expensive for
others to mirror/fork things.

> - It's a bit intimidating to ask 'trivial questions' about the patch and
>   create 'noise' in the ML.

I'm sorry you feel that way.  I understand the Internet and its
persistence (especially with mail archives :x) can have a
chilling effect on people.  I think the way to balance things is
to allow/encourage anonymity or pseudonyms, but some folks here
might disagree with me for copyright reasons.  OTOH, don't ask,
don't tell :)

(I am not speaking as a representative of the git project)

> 3. Isssue with archive:
> 
> - I don't find the ML archive trivial for new comers.  It took me a bit
>   of time to realize: 'Oh if I scroll to bottom and find the "Thread 
>   overview" then I can navigate a mailing thread a lot easier'.

(I'm the maintainer of public-inbox, the archival software you
seem to be referring to).

I'm not sure how to make "Thread overview" easier to find
without cluttering the display near the top.  Maybe I'll try
aria labels in the Subject: link...

> - The lack of labeling / categorization that I can filter while browsing
>   through the archive make the 'browse' experience to be quite
>   unpleasant.  Search is one way to do it, but a new comers would not be
>   knowledgable enough to craft search query to get the archive view just
>   right.  Perhaps a way to provide a curate set of categories would be
>   nice.

Perhaps TODO files/comments in the source tree are acceptable;
or a regularly-posted mail similar to "What's cooking".

Having a centralized website/tracker would give too much power
and influence to people/orgs who run the site.  It would like
either require network access or require learning more software
to synchronize.

> - Lost track of issues / discussion:
>   A quick example would be me searching for Git's zstd support
>   recently with 
> 
>   > https://lore.kernel.org/git/?q=zstandard 
> 
>   and got next to no relevant result.  However if I were to query
> 
>   > 'https://lore.kernel.org/git/?q=zstd'
> 
>   then a very relevant thread from Peff appeared.  I think this could be
>   avoided if the search in ML archive do more than just matching exact
>   text.

I'm planning to support Xapian synonyms for that, but haven't
gotten around to making it configurable+reproducible by admins.
Everything in public-inbox is designed to be reproducible+forkable.

> 4. Lack of way to run test suite / CI:
> 
>   It would be nice if we can discuss patches while having CI result as
>   part of the conversation.  Right now mostly I see that we have to
>   manually running benchmarks/tests and share the paste the results.
> 
>   But for folks who don't have a dev environment ready at hand (new
>   comers, during travel with only phone access), it would be nice to
>   have a way to run tests without a dev environment.

Fwiw, the GCC Farm project gives ssh accounts for all free
software contributors, not just gcc hackers: https://cfarm.tetaneutral.net
Perhaps there's other similar services, too.

Slow down and enjoy travel :)  There's very little in free
software urgent enough to require constant attention.  Email is
well-suited for asynchronous work, and nobody should expect
instant replies.  The always-on nature of the modern Internet
and smartphones increases stress and dangerous situations; so I
hope free software hackers aren't contributing to that.

>   This was mostly solved in the context of works spent on Github's
>   Action Workflow.  But if we are discussing about pure patch flow, this
>   is a miss.
> 
> >  2. What tricks do you use to get by with those existing pain points?
> 
> For (1):
> - I had to invested a lot of time into setting up a set of Gmail search
>   filter.  Move mails with topics that Im interested in into a special
>   tag while the rest into archive.  Regularly check if anything
>   interesting went to archive by accident.
> 
> For (2):
> - I had to setup Mutt + Tmux to have a compatible experience sending
>   replies like this one.

Fwiw, git-send-email works for non-patch mails, too.  I don't
want a monoculture around mutt or any particular clients, either.
(I've never used tmux and don't see why it's necessary, here).

Anyways, thanks again for the feedback.
