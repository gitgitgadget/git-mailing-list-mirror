Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11A5A1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 16:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbeGRRfT (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 13:35:19 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:33180 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731443AbeGRRfT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 13:35:19 -0400
Received: by mail-yb0-f193.google.com with SMTP id e84-v6so2112667ybb.0
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 09:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V8eZ0nvc0r1XufavT8qhCw8lEZ8OPMprTQSCuj5EawI=;
        b=s3FWyw12KT/7u5r0N9kacCBG7loFlLDegXGUT5z0+XC5vDY6Fwi4J86RMRH8RiXbqS
         mm08El1shaPYszOoZiJ6yalPIg87MjOJJfUiWB4Q5HtHGBqXp60p9HobSghf21l5GKjX
         bsvsNMeaFfhV+fj4/MrdZMwmW8lWxzetI/tB2sU9pBsT4OU0B16+G669c1/5dL94SdWg
         LUukBv9BWE3VTsJyPuCcwan4ohzsEmbH/nNo0YPQ3FT5SNKUUzQyO7/KOqgfUF8FeLr9
         a0IUbsADvHjvuTVI/g1hdybMa9seZK7GYZ3XZJ21UgJ8fRVj/dee1lNpXsQRF2JCUL6j
         RcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V8eZ0nvc0r1XufavT8qhCw8lEZ8OPMprTQSCuj5EawI=;
        b=FFTPerE6ZCCycJRWahaNpfIu6hFr4PJpKmR/UR4TNlhJjyC/+cYmppS9g9c9Dxgywd
         VX+D87S1yX5MqLxMzGpXI36XHmzK2LyHe8goZtgu+5KqC0jVNAWXmkKKqEXBivExobBv
         +ZvNJCjXH+ApylE2yBLRLakIday2U1jpZrOTAhVjIUlDI3zTsbJLA9QO3AP4Tq9Mo78a
         oqbcciJDXlw2Sh0yXj5MZ8JAU2x2dTibs+J7ASgqaS2chq2mS/5l+MoNZZ9BjrAmXYRi
         UuYzQQ68vzQ0R+yfDcLCM227BQw0ktvxTpJRA2IiMZCUIF2Dgbav6wR+PhW3PuTh4L2v
         Nqxg==
X-Gm-Message-State: AOUpUlHitgSjcKJqEn/szPn0G8IGYCrB+uTOSlzVG9+8bSeh08rs/j0V
        rJzjq6rE92iXhkrZwa/pTByg/sb97Qsk1V9ttz9swwm9
X-Google-Smtp-Source: AAOMgpca9AGlzLFFkiuE3qlDFE7+Cugq1V60NUW+KMvMQdE2Puo9V57bUmcVV0tw5cg37xF5c1kvnRnWAKSbgnnUzek=
X-Received: by 2002:a25:84d0:: with SMTP id x16-v6mr3742134ybm.307.1531932991009;
 Wed, 18 Jul 2018 09:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180717210915.139521-1-bmwill@google.com> <CAGZ79kZEpNLkXuEQEiMB_nc-MOOp-KOziHyONmr4SiajA5+F2g@mail.gmail.com>
 <a7c43308-a388-e307-6bea-47e6df74b65c@gmail.com>
In-Reply-To: <a7c43308-a388-e307-6bea-47e6df74b65c@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 18 Jul 2018 09:56:20 -0700
Message-ID: <CAGZ79kbLn-uwQOXfqhtO46v0EWevY43Tf4W5Rz9gDD9_qbmX=A@mail.gmail.com>
Subject: Re: [RFC] push: add documentation on push v2
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 6:31 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 7/17/2018 7:25 PM, Stefan Beller wrote:
> > On Tue, Jul 17, 2018 at 2:09 PM Brandon Williams <bmwill@google.com> wrote:
> >> Signed-off-by: Brandon Williams <bmwill@google.com>
> >> ---
> >>
> >> Since introducing protocol v2 and enabling fetch I've been thinking
> >> about what its inverse 'push' would look like.  After talking with a
> >> number of people I have a longish list of things that could be done to
> >> improve push and I think I've been able to distill the core features we
> >> want in push v2.
> > It would be nice to know which things you want to improve.
>
> Hopefully we can also get others to chime in with things they don't like
> about the existing protocol. What pain points exist, and what can we do
> to improve at the transport layer before considering new functionality?

Another thing that I realized last night was the possibility to chunk requests.
The web of today is driven by lots of small http(s) requests. I know our server
team fights with the internal tools all the time because the communication
involved in git-fetch is usually a large http request (large packfile).
So it would be nice to have the possibility of chunking the request.
But I think that can be added as a capability? (Not sure how)

> >>   Thankfully (due to the capability system) most of the
> >> other features/improvements can be added later with ease.
> >>
> >> What I've got now is a rough design for a more flexible push, more
> >> flexible because it allows for the server to do what it wants with the
> >> refs that are pushed and has the ability to communicate back what was
> >> done to the client.  The main motivation for this is to work around
> >> issues when working with Gerrit and other code-review systems where you
> >> need to have Change-Ids in the commit messages (now the server can just
> >> insert them for you and send back new commits) and you need to push to
> >> magic refs to get around various limitations (now a Gerrit server should
> >> be able to communicate that pushing to 'master' doesn't update master
> >> but instead creates a refs/changes/<id> ref).
> > Well Gerrit is our main motivation, but this allows for other workflows as well.
> > For example Facebook uses hg internally and they have a
> > "rebase-on-the-server-after-push" workflow IIRC as pushing to a single repo
> > brings up quite some contention. The protocol outlined below would allow
> > for such a workflow as well? (This might be an easier sell to the Git
> > community as most are not quite familiar with Gerrit)
>
> I'm also curious how this "change commits on push" would be helpful to
> other scenarios.
>
> Since I'm not familiar with Gerrit: what is preventing you from having a
> commit hook that inserts (or requests) a Change-Id when not present?

That is how you do it normally. But what if you just get started or want to
send a one-off to the server (I wanted to upload a git patch to our internal
Gerrit once, and as my repository is configured to work with upstream Git
which doesn't carry change ids, I ran into this problem. I had to manually
add it to have the server accept it)

> How
> can the server identify the Change-Id automatically when it isn't present?

The change id is just a randomly assigned id, which can be made up,
but should stay consistent in further revisions. (Put another way:
change ids solve the 'linear assignment problem' of range-diff at scale)

So once the protocol support is in, the client would need to get some UX
update to replace its commits just pushed with the answer from the server
to work well with server side generated change ids.

But as said I am not sure how much we want to discuss in that direction,
but rather see if we could have other use cases:
Instead of just rebasing to solve the contention problem server side,
we could also offer a "coding helper as a service" - server. That would
work similar as the change id workflow lines out above:
You push to the server, the server performs some action (style formatting
your code for example, linting) and you download it back and have it locallly
again.

I think that would be pretty cool actually.

Thanks,
Stefan
