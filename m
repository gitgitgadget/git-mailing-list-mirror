Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEEE81F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 19:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfDWTX0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 15:23:26 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:47426 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfDWTX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 15:23:26 -0400
Received: by mail-qt1-f202.google.com with SMTP id z34so15630793qtz.14
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 12:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=3sL2LchsHFTnjcpzNDn8mZO6QvgZbMCOcXbq91YO1p4=;
        b=O56KUadbmJzAWlTWGE9X+UeCM+FX5peVoXY1rTvoBTYr9BIK7VVC/qoZD98ASBs/Ej
         h5erNe05UqBmMxFsTQDDfRBzdOQjIMY0NGT6R8Y2F1tP2LzbZ/76IfkWXsXnj4Slw26L
         GWo/RD1sNeu9N2UH1Diq7tbX4OVGAov9jlyWondGKYsPVdjIaH8Sxajz40a3U8C8IGhz
         Ukip2bZGfBIr41u/TZVVUuDQ7Sw41hDGezKejMu3yYXmp9B519TClhHtPpAJu7nWQz4C
         cGuC4ykwDh9u+vWzFu+H8LZwJ2ZFpizkVl2u1VMuEM1ezCAq9HPXorHM8F5Z4gfP9Uca
         ajdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=3sL2LchsHFTnjcpzNDn8mZO6QvgZbMCOcXbq91YO1p4=;
        b=kO1miu8jn35rq6UQgPFzfkpg4DBcynfkAb0azn6rQ2gCWgH8Ev/MeM9A56ZSusvPju
         2ySNX4mRE+px7wylzc4MmMMsbUAx5hf6Os3RIzURDNiT3k4CW6mlIZwfLusZvf9jSJ9q
         EIVNt+bFbbWdzhIk5/4vTBJFfQnK4fn6ksEyj0orKwFtnOIzie1wH4LFlNaNJnQeJigU
         VWxhp7zksxbf2Ac1nhlduO9Zir9tLaRYzIAT9ghAoIrsoYy5umO6OXxDQWjqdxzhv6F6
         59x7fO1rlBf4rMi9xWSGNp96Y7/RomXiD5fPloBGcA+YKMYllGVaOZm4N+yDCWrkKw63
         bYMQ==
X-Gm-Message-State: APjAAAUgc8ZSsNOqrGgaMO91DEENBDjMVkyxcf2iXm/Cutq+5dZlpnsW
        YFLIjwfLiQp8YbvDaTzhxF+LoiVC51y8qpjXM0tW
X-Google-Smtp-Source: APXvYqwu0vHVhwTgTANYUI+THYf1yrNqxglNlVtCQ0Pr7s42WtkHoFB2RTPQhbMx+X81Ht8KMpFWIfJRXYszlMpGc/LL
X-Received: by 2002:ac8:810:: with SMTP id u16mr19773728qth.254.1556047405372;
 Tue, 23 Apr 2019 12:23:25 -0700 (PDT)
Date:   Tue, 23 Apr 2019 12:23:21 -0700
In-Reply-To: <20190423052159.GA12530@sigill.intra.peff.net>
Message-Id: <20190423192321.145285-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190423052159.GA12530@sigill.intra.peff.net>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: Re: [PATCH v2 0/8] CDN offloading of fetch response
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, avarab@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Fri, Mar 08, 2019 at 01:55:12PM -0800, Jonathan Tan wrote:
>=20
> > Here's my current progress - the only thing that is lacking is more
> > tests, maybe, so I think it's ready for review.
>=20
> A bit belated, but here are some overall thoughts. A lot of my thinking
> comes from comparing this to previous work I had done on teaching the
> client to fetch first from a bundle and then do a follow-up fetch from
> the server.

Thanks for your thoughts.

> > This code now starts CDN downloads after closing the first HTTP request=
,
> > and it holds on to the .keep files until after the refs are set. I'll
> > leave parallelization of the CDN downloads for later work.
>=20
> Good. One of the problems with the bundle+followup approach was either
> having to hold open or re-establish the connection to the original
> server, since that fetch had to be put on hold.
>=20
> I agree that parallelizing can come later. I do wonder if it's worth
> making a new tool rather than trying to reuse git-http-fetch. Yes, it
> basically does what we want already, but there's quite a lot of cruft in
> that dumb-http code base. Using http_get_file(), or even curl more
> directly might be a bit easier.
>=20
> One problem in particular I'd worry about is that the http code
> generally expects authentication to happen through the initial
> ref-discovery, and then be set for all subsequent requests. So I doubt
> an http_pack_request actually handles auth at all, and retro-fitting it
> may be tricky.

Thanks - I'll keep that in mind. If auth isn't handled, then we'll
definitely need something new.

> > One relatively significant change: someone pointed out that the issue f=
ixed by=20
> > 50d3413740 ("http: make redirects more obvious", 2016-12-06) could also
> > occur here, so I have changed it so that the server is required to send
> > the packfile's hash along with the URI.
>=20
> I have mixed feelings on that. I like how it clearly makes the server
> the source of authority. You don't have to care about CDN tampering,
> because you know you are getting the bytes the server wanted you to.

I was thinking not of CDN tampering but of a malicious server. Suppose a
server knew of (1) the hash of a target commit, and (2) the URL of a
packfile containing that target commit. The server can craft a commit
whose parent is that target commit and advertise it, and serves both
that commit as a packfile and the URL as packfile-uri. When the user
subsequently pushes, they will probably inadvertently push everything
including the target commit.

This is similar to the 50d3413740 case except that now the server needs
an additional datum (2). The packfile's hash is yet another additional
datum. I admit that it may not be that useful, though.

> I think even without that this is still _mostly_ true, though. You're
> going to compute the hash of every object the CDN sends you, and those
> objects must fit into the missing gaps in what the server sends you. So
> the worst case is that a malicious CDN could send you some extra
> objects. That's probably not the end of the world, but I do like the
> extra guarantee of knowing that you got byte-for-byte what the server
> wanted you to.

Yes, the guarantee is nice.

> > This does mean that =C3=86var's workflow described in [1] would not wor=
k.
> > Quoting =C3=86var:
> >=20
> > > More concretely, I'd like to have a setup where a server can just dum=
bly
> > > point to some URL that probably has most of the data, without having =
any
> > > idea what OIDs are in it. So that e.g. some machine entirely
> > > disconnected from the server (and with just a regular clone) can
> > > continually generating an up-to-date-enough packfile.
> >=20
> > With 50d3413740, it seems to me that it's important for the server to
> > know details about the URIs that it points to, so such a disconnection
> > would not work.
>=20
> I think even without 50d3413740, this is important for your scheme. One
> of the weaknesses (and strengths, I suppose) of the bundle+followup
> scheme was that the initial bundle generally had to meet the git
> repository guarantee. After you fetched the bundle, you'd tell the
> server "OK, now I have commit X" just like you were a regular client.
>=20
> But I really like that your proposal does away with that, and asks for
> tighter cooperation between the server and the CDN. It means the CDN can
> serve some random subset of the objects. But once we do that, now the
> server _has_ to know what was in those URLs it pointed to, because our
> protocol has no good way of communicating a random subset of objects (if
> they're just blobs, we could enumerate all of them to the server as
> haves; yuck.  But as soon as you get a tree or commit from the CDN, you
> have to have all of the reachable objects to be able to claim it).

Ah...you're right that the server still needs some inkling of what the
CDN's packfile has.

Without the packfile hash, the knowledge needed is slightly less: the
server just has to know a subset of the objects instead of the exact
list of objects, but I can't think of how this can benefit us other than
that we don't require so much consistency (it's OK if the server's
knowledge of the CDN is updated significantly later than the CDN is
updated, if the CDN reuses the same URL for each version of the
packfile).

> So I think this is pretty inherent to your proposal, and but it's the
> right tradeoff to be making here (I think there could still be room for
> the other thing, too, but it's just a different feature).

Thanks.
