Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C98971F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 19:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbeJFCZe (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 22:25:34 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:39131 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbeJFCZd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 22:25:33 -0400
Received: by mail-ed1-f54.google.com with SMTP id d15-v6so383430edq.6
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 12:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i5fcFdZ+htsGDrldVEUPiSQQPphyGG0Ft1s8kfXpToM=;
        b=uWYqgfnU8TUuVeL5vW7SSbsjcwaLPBg6XXdjs8qc9Rj/TRNCWuTYHX4yPzm1UmddwY
         Qy1mg4DhEBCKweqNgl/IczQjZDQklAieQcLwMx+9ZQEkTzez/lqkC7aDcE/rHmaMyio2
         YLLUoVcL5rLTD3905kz/oUnIQLU4cI12ySNCSpNwau3lPYwoc+01wOszknK09H45xOjh
         2BTEZRQrsCS1HYK+eNY3sg28tKcKEBHOism09Q5DD1h/bYNtpdkdRK9ZV7bEv1Jqv6Y1
         Wy2UZh59F0Y90yok/ShhYD31u5o0J74mKYGVmahbMKSm94DWt8v5Mt9SvBOfk3Jh30pY
         RuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i5fcFdZ+htsGDrldVEUPiSQQPphyGG0Ft1s8kfXpToM=;
        b=KuQKX5WDJHk5ZEkQcHqCOKxIKxJvuk2yaT6aGqD9bqhQtozGuOMjSGYFKfWJJHkFnE
         d5DY/Gcvtd5OUiRK7Ah8fWjZeMw5DomUoXZxXfDNn2gZYe7NxQB2wB4h1xvEzLeCOZOU
         ZYIUf/EuZqoJgHHOlZa3opJ+yOLa/LxS6RGQ2MZcoRaYZQdWNCmJi6D09DwKX8e/zLLq
         XVa7LrzmPHKSDXUQEEkIHRYHu3NPANW7cd3EFHk0Y+OyCi8g35Cxrj2R6A1mIK7UnrTX
         2EIq6LXAyAJHP3kl5qllrNM5/kGXZbV4IpQgw63HTnkaClHKX8NuZglst/3kMW8ABoFe
         q+sw==
X-Gm-Message-State: ABuFfog8tlnHrS8e9LZ4dvvmU7tFw/nVUBxDg82AG4afR3+pP6u5gNSP
        BJnjEMa76bgnbyH+lH4NZzM4ulkiaog3YAEenCh+gQ==
X-Google-Smtp-Source: ACcGV62HNxayYmlKmVXuLmXd992ICU+wWXJ2e9TSXVf3VoForWR355jLl9uaTTWdyHAIl4TGhdU8sG3sM6f4wWozl4U=
X-Received: by 2002:a50:b2a6:: with SMTP id p35-v6mr15520742edd.215.1538767524144;
 Fri, 05 Oct 2018 12:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1538516853.git.steadmon@google.com> <59357266bd86e8e0ace9217a97717129a6f76188.1538516853.git.steadmon@google.com>
 <CAGZ79kbD=P__8GU9rV87wREF_MbQA9i2ij6C2qXyaJfqHD3Szg@mail.gmail.com>
 <20181003213349.GA32105@google.com> <CAGZ79kZP7y3v8hrhKKP_FT7+uyUSWO5s8w13-c67QWdzme1-Qw@mail.gmail.com>
 <20181005001817.GB32105@google.com>
In-Reply-To: <20181005001817.GB32105@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 5 Oct 2018 12:25:12 -0700
Message-ID: <CAGZ79kbSF5XM72SOQH7XNyjeCLqQ+AuxOqMPTspjOgk-jEgrzw@mail.gmail.com>
Subject: Re: [PATCH 1/1] protocol: limit max protocol version per service
To:     Josh Steadmon <steadmon@google.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > But given that we transport the version in env variables, we'd
> > need to be extra careful if we just did not see the version
> > in the --remote=. above?
>
> Sorry, I'm not sure I understand this. What about env variables requires
> caution?

By locally transporting the version via env variables means the absence of
"version X" lines in the GIT_TRACE output is not a clear indication
of version 0, I would think. It is a strong indicator, but now we'd have to dig
and see if the env variables were set outside?


> >
> > > I suppose if we are strict about serving from a single endpoint, the
> > > version registry makes more sense, and individual operations can declare
> > > acceptable version numbers before calling any network code?
> >
> > Ah yeah, that makes sense!
>
> Thinking out loud here. Please let me know if I say something stupid :)
>
> So we'll have (up to) three pieces of version information we'll care
> about for version negotiation:
>
> 1. (maybe) a client-side protocol.version config entry

(and in case we don't, we have it implicit ly hardcoded, as
we have to choose the default for users that don't care themselves about
this setting)

> 2. a list of acceptable proto versions for the currently running
>    operation on the client
> 3. a list of acceptable proto versions for the server endpoint that
>    handles the request

Yes that matches my understanding. The issue is between (1) and (2)
as (1) is in a generic config, whereas (2) is specific to the command,
such that it may differ. And as a user you may want to express things
like: "use the highest version", which is done by setting (1) to "version 2"
despite (2) not having support of all commands for v2.

> According to the doc on protocol.version: "If set, clients will attempt
> to communicate with a server using the specified protocol version. If
> unset, no attempt will be made by the client to communicate using a
> particular protocol version, this results in protocol version 0 being
> used."
>
> So, if protocol.version is not set, or set to 0, the client should not
> attempt any sort of version negotiation.

Yes, as version 0 is unaware of versions, i.e. there are old installations
out there where all the versioning code is not there, so in case of an
old client the new server *must* speak v0 to be able to communicate
(and vice versa).


> Otherwise, the client prefers a
> particular version, but we don't guarantee that they will actually use
> that version after the (unspecified) version negotiation procedure.
>
> If protocol.version is set to something other than 0, we construct a
> list of acceptable versions for the given operation. If the
> protocol.version entry is present in that list, we move it to the front
> of the list to note that it is the preferred version. We send all of
> these, in order, in the request.
>
> When the server endpoint begins to handle a request, it first constructs
> a list of acceptable versions. If the client specifies a list of
> versions, we check them one-by-one to see if they are acceptable. If we
> find a match, we use that version. If we don't find any matches or if
> the client did not send a version list, we default to v0.
>
> Seem reasonable?

This sounds super reasonable!

Thanks
Stefan
