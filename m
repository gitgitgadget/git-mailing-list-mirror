Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C04720248
	for <e@80x24.org>; Tue, 26 Feb 2019 08:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfBZIan (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 03:30:43 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34752 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfBZIam (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 03:30:42 -0500
Received: by mail-ed1-f68.google.com with SMTP id a16so9999930edn.1
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 00:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4qGN5YJqSbK1EnE9uk7/Xw/nwUBRF4u2QyLfHRuHCFk=;
        b=LQ2Rkb7fFETv/24Z1RIISu1AoYfSkWaHzwdslzozw4QZ9TDxzYtfypJrWnwzRuWNOn
         6FlL3zRtW+pJL+465wu1dCE+j78XMy1riS1K/QDuTzYALNqVmcb4bArJNwAeP1sMiyfk
         VgrtqNwpxnGJaSmWOBD5eNRi6fGRexWN/Ew8tRuIKTUK+E2pRRmbWJFkP9nfH+r6BAyg
         5D26f1Zp330LpP7Q5oFi3DFjsrCuxjCeLUetYex9uxtmULnI3n5aXAM1WBW+gqPZC3wB
         9fU/EASNyAByUR6UBJoGrFmDqgOVd0JDU1HHz0KXLphEaAL8IwtyCzEM15sHyXn2sTwq
         Yneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4qGN5YJqSbK1EnE9uk7/Xw/nwUBRF4u2QyLfHRuHCFk=;
        b=OJ9+PPnszLZBqxzN9ErYDjzM+I5pY5vK4G0fX4+n776a2zW0sxBn7OSCagu4StRrzP
         7w915bccIDqhefuMWG2cUmUAcKyAssoX5u5YxNCGQ7/vgInYbF05x0se0/tUOoVF2o3k
         U/TITpXj4j2G2jRHwLOz8b/odSj4qE6Z28DFaKswkTgYNNdO5OGNOOXAR+sF0rEFD0pf
         6BY3mY9D48uMi8IJbLfdBPlZWMh8wxEX/W8BvQtRqmk1IG7JN5GTMoobZCjp5x9wIGFM
         EGbhA0kr7mxr/KCoXVqA3EeZqigV6ak1MwIcNQNezHk7YgNqEgToxvgLnN70i94jnPz9
         ZFqA==
X-Gm-Message-State: AHQUAua3OCsdO3rsjhaiEXFpddQWViX0zVbLg7CVrzF+IEqLYLYcs85c
        Cdz1NDRmzeIIAAKpNAMBJvNwjp0Yr1Y6juGLDPySae6spDk=
X-Google-Smtp-Source: AHgI3IYFTH1HZ3n8ba6GmqiTQN+a6pPQnr33gyWqH01JeHkyUbi8LSwfIJCsGu/fXLD/4xxsIWaTPpAMV7W+Bm2TcuQ=
X-Received: by 2002:a17:906:4893:: with SMTP id v19mr15660659ejq.196.1551169840041;
 Tue, 26 Feb 2019 00:30:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550963965.git.jonathantanmy@google.com>
 <CAP8UFD19521P=-R1XEdRK++HPatt3BJaxWPvpPRo8LHr3eisjA@mail.gmail.com> <20190225234528.GD16965@google.com>
In-Reply-To: <20190225234528.GD16965@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 26 Feb 2019 09:30:28 +0100
Message-ID: <CAP8UFD1tKNFO9wU8CbgNnSnQyvHYPsZMk1Bit2y1jxH4vk62qQ@mail.gmail.com>
Subject: Re: [WIP 0/7] CDN offloading of fetch response
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Feb 26, 2019 at 12:45 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Christian Couder wrote:
> > On Sun, Feb 24, 2019 at 12:39 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > Especially I'd like to know what should the client do if they find out
> > that for example a repo that contains a lot of large files is
> > configured so that the large files should be fetched from a CDN that
> > the client cannot use? Is the client forced to find or setup another
> > repo configured differently if the client still wants to use CDN
> > offloading?
>
> The example from that message:
>
>   For example I think the Great Firewall of China lets people in China
>   use GitHub.com but not Google.com. So if people start configuring
>   their repos on GitHub so that they send packs that contain Google.com
>   CDN URLs (or actually anything that the Firewall blocks), it might
>   create many problems for users in China if they don't have a way to
>   opt out of receiving packs with those kind of URLs.
>
> But the same thing can happen with redirects, with embedded assets in
> web pages, and so on.

I don't think it's the same situation, because the CDN offloading is
likely to be used for large objects that some hosting sites like
GitHub, GitLab and BitBucket might not be ok to have them store for
free on their machines. (I think the current limitations are around
10GB or 20GB, everything included, for each user.)

So it's likely that users will want a way to host on such sites
incomplete repos using CDN offloading to a CDN on another site. And
then if the CDN is not accessible for some reason, things will
completely break when users will clone.

You could say that it's the same issue as when a video is not
available on a web page, but the web browser can still render the page
when a video is not available. So I don't think it's the same kind of
issue.

And by the way that's a reason why I think it's important to think
about this in relation to promisor/partial clone remotes. Because with
them it's less of a big deal if the CDN is unavailable, temporarily or
not, for some reason.

> I think in this situation the user would likely
> (and rightly) blame the host (github.com) for requiring access to a
> separate inaccessible site, and the problem could be resolved with
> them.

The host will say that it's repo admins' responsibility to use a CDN
that works for the repo users (or to pay for more space on the host).
Then repo admins will say that they use this CDN because it's simpler
for them or the only thing they can afford or deal with. (For example
I don't think it would be easy for westerners to use a Chinese CDN.)
Then users will likely blame Git for not supporting a way to use a
different CDN than the one configured in each repo.

> The beauty of this is that it's transparent to the client: the fact
> that packfile transfer was offloaded to a CDN is an implementation
> detail, and the server takes full responsibility for it.

Who is "the server" in real life? Are you sure they would be ok to
take full responsibility?

And yes, I agree that transparency for the client is nice. And if it's
really nice, then why not have it for promisor/partial clone remotes
too? But then do we really need duplicated functionality between
promisor remotes and CDN offloading?

And also I just think that in real life there needs to be an easy way
to override this transparency, and we already have that with promisor
remotes.

> This doesn't stop a hosting provider from using e.g. server options to
> allow the client more control over how their response is served, just
> like can be done for other features of how the transfer works (how
> often to send progress updates, whether to prioritize latency or
> throughput, etc).

Could you give a more concrete example of what could be done?

> What the client *can* do is turn off support for packfile URLs in a
> request completely.  This is required for backward compatibility and
> allows working around a host that has configured the feature
> incorrectly.

If the full content of a repo is really large, the size of a full pack
file sent by an initial clone could be really big and many client
machines could not have enough memory to deal with that. And this
suppose that repo hosting providers would be ok to host very large
repos in the first place.

With promisor remotes, it's less of a problem if for example:

- a repo hosting provider is not ok with very large repos,
- a CDN is unavailable,
- a repo admin has not configured some repos very well.

Thanks for your answer,
Christian.
