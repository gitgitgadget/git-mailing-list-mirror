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
	by dcvr.yhbt.net (Postfix) with ESMTP id 37A711F453
	for <e@80x24.org>; Wed, 24 Apr 2019 09:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfDXJJz (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 05:09:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52284 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfDXJJz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 05:09:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id j13so3625034wmh.2
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 02:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=MmzcwfvchOwfsy58FhrizaqCwIZQ6h2ifbceXPJAm9k=;
        b=kJ/TKuKyrlVdvc7sxE5b5EKjm5ZEDDdKRNORbpumYm4AR5m4kCnflYtTgnkz3GbZmY
         SidG3b88gDD09wCk1QV+U9ETGy6N38Qb4ow59Y4xG7lhrARKh/kQQvz5DMaB6ZVU5mPe
         zDZ9buppNCJ23X9PC67BEuhrq3wP0lNmLFlBoFgeco7e5MIGvEe8ynyk6Dk/wGqyq87v
         aDcxqT6jLA/n6sX7rSSRx4tamzdwPmsmTx6gAAmIwzCsCrAy4jEqNf2uR48Ethy0xfkY
         u9R+ENXzYLqQV6onHcbECm/HM5miQvAkZwV4DJ5mjFcq37NprkH+Nf6E3NcDTpJ9rwFB
         /ilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=MmzcwfvchOwfsy58FhrizaqCwIZQ6h2ifbceXPJAm9k=;
        b=PKQhcYdlrao2D0i7xR0Bg1+FFyHM4t/elsPCj0KhdEgDZohaFQpOGpC0ub73t+eOgu
         QC810OKxmBnhsQZi5mrQLagr3ADGzk5vtMWLGWPljeZZDvBXFJg8iPDce9ZkRxfN2xRh
         O0dBbTftI9Pf4VtFZzSosHjrZ0zl9/EA0zZgT6rLBZnt12uMLZ0H/4zRPUQ80uSOjyWL
         Vd49aE88BxxBJ9kJZ2eVnmeRBkzPFhVnxzpyZuyXlNgpiC1GkuYcfxzurbdhOUdB+UPU
         amgcXnf82BioyY6GrKVCAGuze/ZFoa4c9WVwUTKKQAOtCYtgmCjXfazk3Uko7TAlJ9+7
         9f9Q==
X-Gm-Message-State: APjAAAVA91VXSkPzEkUFcqC1KHx/Uu8jLF3QtHPlEMUKXWGPfu1x/oSt
        gcWUuqnKa6JdbuKQK4Tnl0UARkdN
X-Google-Smtp-Source: APXvYqyR/r684tzQUhRgjpSe9KGPT3j2WnzrCeyBmR3EEdLinJQMZfYz5B9SkcyKoPWtp4FbAgLIxw==
X-Received: by 2002:a1c:99d5:: with SMTP id b204mr1701709wme.141.1556096993161;
        Wed, 24 Apr 2019 02:09:53 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id e3sm1585958wro.35.2019.04.24.02.09.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 02:09:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/8] CDN offloading of fetch response
References: <cover.1550963965.git.jonathantanmy@google.com> <cover.1552073690.git.jonathantanmy@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <cover.1552073690.git.jonathantanmy@google.com>
Date:   Wed, 24 Apr 2019 11:09:51 +0200
Message-ID: <87pnpbsra8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 08 2019, Jonathan Tan wrote:

> One relatively significant change: someone pointed out that the issue fix=
ed by
> 50d3413740 ("http: make redirects more obvious", 2016-12-06) could also
> occur here, so I have changed it so that the server is required to send
> the packfile's hash along with the URI.
>
> This does mean that =C3=86var's workflow described in
> https://public-inbox.org/git/87k1hv6eel.fsf@evledraar.gmail.com/ would
> not work.  Quoting =C3=86var:
>
>> More concretely, I'd like to have a setup where a server can just dumbly
>> point to some URL that probably has most of the data, without having any
>> idea what OIDs are in it. So that e.g. some machine entirely
>> disconnected from the server (and with just a regular clone) can
>> continually generating an up-to-date-enough packfile.
>
> With 50d3413740, it seems to me that it's important for the server to
> know details about the URIs that it points to, so such a disconnection
> would not work.

For what it's worth I'm fine with that, and as is obvious in some of the
previous threads I hadn't thought about that threat model. This "I know
XYZ has a pack that should have most of it, check what's in it and get
back to me with HAVEs" was a nice-to-have, but not a must.

And you can still get most of the way there with this proposal and the
techniques described in the follow-up to
https://public-inbox.org/git/87bmhiykvw.fsf@evledraar.gmail.com/ if I'm
reading this series correctly.

I.e. the server would know the CDNs are going to be generating a pack
from the "master" history with the tip being the Nth commit, and since
both agree on the pack algorithm they can generate the same OID/pack
hash pair without further coordination, the server would then
optimistically advertise that. This would give you the sort of "lazy"
CDN setup I was describing with slightly more work than just "here's
some random latest pack".

But isn't in the case that if a malicious server ever got a hold of a
pack SHA-1 it knows to be on a private CDN *and* a commit that's in it
we'd have the same problem? Shouldn't this security model be prominently
documented in Documentation/technical/packfile-uri.txt? I.e. "THOU MUST
NEVER LEAK A COMBINATION OF THE PACK SHA-1 OF A PRIVATE CDN AND A
PRIVATE COMMIT SHA-1!".

It seems likely that once we have git CDN support the first thing CDNs
are going to do is to serve up such packs via a URL that includes the
pack SHA-1. Once the combination of that & a commit in it leaks we're
back to square one, no? *My* default approach in setting up such
infrastructure without knowing about 50d3413740 would be not to care
about the privacy of the SHA-1s, even in the case of private data.

Isn't there also overlap here with non-CDN shallow/narrow fetching?
Where a server can detect such a client, rely on it to get the objects
from elsewhere (e.g. via adding an unrelated remote), and then get a
push that gives it secret data?

I don't see any fool-proof way out of it, but maybe a mode where we:

 1. Get the CDN data URLs (which for the purposes of this example I'm
    assuming are "base packs" containing at least some commits...)

 2. Do a follow-up request to the server where we e.g. pretend not to
    have the last N commits for tips it advertises and ask it to serve
    that up from a non-CDN. If it can't we know it's lying and trying an
    attack similar to the one described in 50d3413740.

    Conversely, can't know if it can that it isn't, but at that point it
    seems unlikely, since surely the useful thing is a delta against the
    recent-but-server-lied-about-having-it commit, at least in most
    cases....

This would also have the advantage of addressing some of the reliability
concerns brought up elsewhere. I.e. once we're doing a sanity-check
post-fetch anyway a failure to download 1/3 packs from a CDN becomes
recoverable, although the design outlined here (understandably) would
prefer that to be done in another "fetch" dialog so the server can keep
the "CDN + my data should be 100% of the data" state.
