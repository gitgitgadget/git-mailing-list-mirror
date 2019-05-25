Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81E2F1F462
	for <e@80x24.org>; Sat, 25 May 2019 14:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfEYOnK (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 May 2019 10:43:10 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:36167 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfEYOnK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 May 2019 10:43:10 -0400
Received: by mail-it1-f195.google.com with SMTP id e184so18070575ite.1
        for <git@vger.kernel.org>; Sat, 25 May 2019 07:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pbA9wueWe/zDMEuvoZTPfJUQdUf+oGE9IeZx4T8vXw4=;
        b=hYGMnlmL2h4XSbMmJg+VsSgVEgHrnqABfH1QV12o0tSYf522MoG/7Bw9QRI9X6MXwo
         FqYhuO2vjJM2F2Jp65KVC15AdljsqfHlRxunfbirKgW4Idp8ntE7B6JUtDtPszO+l+hw
         gxsfmFUOTUqAfz3kWmBJ4rGKXT20HjTd4xkzLR47cjzFZgGdo3v102AZfp5HvOiJypDv
         mpBinN5Q40VbVjx92wv4yIGA5a/D4LJJqFVL+Okwn6Q53B0xmy/JcpsuNsPVG0cCwbfo
         bo2BRfmDosXGL/4wNoRarK4ih635UdGchnKEkSZz2RcpyRGQADsnPOeNMF9vGeG8O0ol
         IpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pbA9wueWe/zDMEuvoZTPfJUQdUf+oGE9IeZx4T8vXw4=;
        b=IHd8PeELbjiO+roM+1D3cEFMaCULMSW297biOExNwOdrqirhlz0nEcWHK2+LuWzm20
         KG8x8aGuiU0WoGxy9SnLePI9YsFyOvT/O1QU62mm+6EetpoGqQamxEOKhbkRwnRBhk5n
         nxLd/77OYonE5AGBD7H3LTZzn9QtDnDcQ/JOKhFGDArez2SiqyAvPa09YNledfG5aFNT
         1bxwR68p2+FKh0ikUm8VaXSG/PgZF8T/0/sd9EvZqFVZSKlAsCOYZf7sjOhqnQV0e+/B
         deHeK6/04umwFPBQ1EyDPzcv3fcrbUgpwhh/b52qg47rxNDsm3k2n/eniozcsjTUPkCW
         Fl1g==
X-Gm-Message-State: APjAAAUMG5ubKFJd2A3dkSz9Qx2AW5NeY5y6rsyopZSSFzPTg3GRiHqW
        zGnUCd28OpVXC6+Rf3/2pGQw4NeI6Q1H258lfBUBYA==
X-Google-Smtp-Source: APXvYqyK0elu4v6pSATl7vr4srmIq/RCPsnidP9NRtJd3NuWu4JyeOq28Z19shoZBZA4cBmHPLrNxyOKKLCPNl3mLKU=
X-Received: by 2002:a24:1455:: with SMTP id 82mr23197438itg.59.1558795389134;
 Sat, 25 May 2019 07:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW40x3-4rye3QeVGix5pfTCoCHmiwg8ddCeq1E6YYongag@mail.gmail.com>
 <20190524061352.GB25694@sigill.intra.peff.net>
In-Reply-To: <20190524061352.GB25694@sigill.intra.peff.net>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 25 May 2019 11:42:58 -0300
Message-ID: <CAHd-oW4Y6bN+6SCJNEg+w0GMWQcUdiHmTbQfCpJ5J283xU8X+w@mail.gmail.com>
Subject: Re: [GSoC] How to protect cached_objects
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 24, 2019 at 3:13 AM Jeff King <peff@peff.net> wrote:
>
> On Thu, May 23, 2019 at 01:51:47PM -0300, Matheus Tavares Bernardino wrote:
>
> > As one of my first tasks in GSoC, I'm looking to protect the global
> > states at sha1-file.c for future parallelizations. Currently, I'm
> > analyzing how to deal with the cached_objects array, which is a small
> > set of in-memory objects that read_object_file() is able to return
> > although they don't really exist on disk. The only current user of
> > this set is git-blame, which adds a fake commit containing
> > non-committed changes.
> >
> > As it is now, if we start parallelizing blame, cached_objects won't be
> > a problem since it is written to only once, at the beginning, and read
> > from a couple times latter, with no possible race conditions.
> >
> > But should we make these operations thread safe for future uses that
> > could involve potential parallel writes and reads too?
> >
> > If so, we have two options:
> > - Make the array thread local, which would oblige us to replicate data, or
> > - Protect it with locks, which could impact the sequential
> > performance. We could have a macro here, to skip looking on
> > single-threaded use cases. But we don't know, a priori, the number of
> > threads that would want to use the pack access code.
>
> It seems like a lot of the sha1-reading code is 99% read-only, but very
> occasionally will require a write (e.g., refreshing the packed_git list
> when we fail a lookup, or manipulating the set of cached mmap windows).
>
> I think pthreads has read/write locks, where many readers can hold the
> lock simultaneously but a writer blocks readers (and other writers).
> Then in the common case we'd only pay the price to take the lock, and
> not deal with contention. I don't know how expensive it is to take such
> a read lock; it's presumably just a few instructions but implies a
> memory barrier. Maybe it's worth timing?

The pthread_rwlock_t, right? Nice! I didn't know about this type of
lock. It will be very handy in other situations as well, thanks for
the suggestion.

> -Peff
