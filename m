Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 648CD1F453
	for <e@80x24.org>; Fri, 22 Feb 2019 11:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfBVLfO (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 06:35:14 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:41129 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfBVLfO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 06:35:14 -0500
Received: by mail-ed1-f49.google.com with SMTP id x7so1478571eds.8
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 03:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2r4WIXr3ulJsb5/lKYr9J3LV3uHSu/s3x/DOSkmnl8I=;
        b=WJnhvChClikPo0wdj5dN5jdNFeZL0+rH5YxKSp/zsI8+UYqcPov0T2qWSziK+/8vF/
         iUbsf+HYIMLqhgVNgwcZ0pP5XUnXiEmanZwVvcXqELRIOB5i0RsveF5vqQXWt0UZpuSH
         V37cS9ujVayX6mXhPqo38VIOI+f51PznU1/W2SqHMeWUzNMUjAS6o2VjRqCQwtvQn7E+
         GoY/20gBYEWUea8TGVWQcdDhBpJOhVcDWB3DuNaJF36//hiPFsc5vTN7nQSNwN44Foh/
         VM+TWJV9RZbBTEXMH/z7N3k2cSVrn2EDk28YrMNcerp3VolrU1DE/s+0IBGhun7Udw3n
         vOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2r4WIXr3ulJsb5/lKYr9J3LV3uHSu/s3x/DOSkmnl8I=;
        b=C7sTwOUyk/7YBO4LgKKdKTrtRg8la6NJfg/z04sgmPHESgOYNN46L2nACXANEqBJIf
         2/2F9kEjvFWD3egsbezq9/RxoUPvPKLhyLA4vn146fHNWKsurf21NYl5DQ8P9Xpa2/zd
         qX4pT3UTF6F2a8JXu/BWVDf9uizhZBosMrZk0K2aY09hSOdnOggRoRuuZnhZpRQ1SVMw
         bLyhwjnUHw5mDckUBkumyuxB830EEtK6o4T75LAeQoWxftbmI0Y9+FCa9OUxt4WwzdRR
         FvZNv+Cl7s9BAXEvgkIeVr9Oi7lNeYeNGKE7N4bs/QUxtYDkF5r1x/jJJRxjI01dGME0
         UDHw==
X-Gm-Message-State: AHQUAuYpWOElmke/fvSYLtbeuvDYrO5qpHREHR1pJf4svtB0Rt0nRJwc
        UMu9mTLVH7dYt2AaP4P8oxVszifUGp9VCK8MgZ1VBVDNaR4=
X-Google-Smtp-Source: AHgI3IaKT6Rin8/fiDF3R0Kq8clsIamat0A5uQwGl1xZ071WvOJWcLgEMOM4e7psejvLFzj1A1w+WlsB/e/V9eMK3iI=
X-Received: by 2002:a50:8f86:: with SMTP id y6mr2914588edy.131.1550835311809;
 Fri, 22 Feb 2019 03:35:11 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UFD0VPZEhBTUb--n5RHECUkO81aPcGkTYGi0fqd35rnKr3Q@mail.gmail.com>
 <20190219201022.237430-1-jonathantanmy@google.com>
In-Reply-To: <20190219201022.237430-1-jonathantanmy@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 22 Feb 2019 12:35:00 +0100
Message-ID: <CAP8UFD16fvtu_dg3S_J9BjGpxAYvgp8SXscdh=TJB5jvAbzi4A@mail.gmail.com>
Subject: Re: [WIP RFC 2/5] Documentation: add Packfile URIs design doc
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 19, 2019 at 9:10 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > > Good points about SSH support and the client needing to control which
> > > protocols the server will send URIs for. I'll include a line in the
> > > client request in which the client can specify which protocols it is OK
> > > with.
> >
> > What if a client is ok to fetch from some servers but not others (for
> > example github.com and gitlab.com but nothing else)?
> >
> > Or what if a client is ok to fetch using SSH from some servers and
> > HTTPS from other servers but nothing else?
>
> The objects received from the various CDNs are still rehashed by the
> client (so they are identified with the correct name), and if the client
> is fetching from a server, presumably it can trust the URLs it receives
> (just like it trusts ref names, and so on). Do you know of a specific
> case in which a client wants to fetch from some servers but not others?

For example I think the Great Firewall of China lets people in China
use GitHub.com but not Google.com. So if people start configuring
their repos on GitHub so that they send packs that contain Google.com
CDN URLs (or actually anything that the Firewall blocks), it might
create many problems for users in China if they don't have a way to
opt out of receiving packs with those kind of URLs.

> (In any case, if this happens, the client can just disable the CDN
> support.)

Would this mean that people in China will not be able to use the
feature at all, because too many of their clones could be blocked? Or
that they will have to create forks to mirror any interesting repo and
 reconfigure those forks to work well from China?

> > I also wonder in general how this would interact with promisor/partial
> > clone remotes.
> >
> > When we discussed promisor/partial clone remotes in the thread
> > following this email:
> >
> > https://public-inbox.org/git/20181016174304.GA221682@aiede.svl.corp.google.com/
> >
> > it looked like you were ok with having many promisor remotes, which I
> > think could fill the same use cases especially related to large
> > objects.
> >
> > As clients would configure promisor remotes explicitly, there would be
> > no issues about which protocol and servers are allowed or not.
> >
> > If the issue is that you want the server to decide which promisor
> > remotes would be used without the client having to do anything, maybe
> > that could be something added on top of the possibility to have many
> > promisor remotes.
>
> It's true that there is a slight overlap with respect to large objects,
> but this protocol can also handle large sets of objects being offloaded
> to CDN, not only single ones.

Isn't partial clone also designed to handle large sets of objects?

> (The included implementation only handles
> single objects, as a minimum viable product, but it is conceivable that
> the server implementation is later expanded to allow offloading of sets
> of objects.)
>
> And this protocol is meant to be able to use CDNs to help serve objects,
> whether single objects or sets of objects. In the case of promisor
> remotes, the thing we fetch from has to be a Git server.

When we discussed the plan for many promisor remotes, Jonathan Nieder
(in the email linked above) suggested:

 2. Simplifying the protocol for fetching missing objects so that it
    can be satisfied by a lighter weight object storage system than
    a full Git server.  The ODB helpers introduced in this series are
    meant to speak such a simpler protocol since they are only used
    for one-off requests of a collection of missing objects instead of
    needing to understand refs, Git's negotiation, etc.

and I agreed with that point.

Is there something that you don't like in many promisor remotes?

> (We could use
> dumb HTTP from a CDN, but that defeats the purpose in at least one way -
> with dumb HTTP, we have to fetch objects individually, but with URL
> support, we can fetch objects as sets too.)
