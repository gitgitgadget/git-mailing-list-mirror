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
	by dcvr.yhbt.net (Postfix) with ESMTP id B48DC1F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 16:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeK0Czc (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 21:55:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45729 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbeK0Czc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 21:55:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id v6so19478915wrr.12
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 08:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=eVueShaDHFZvDqfNXADieO11SLCtToCqRvMxiA76OGs=;
        b=jvCijjEPJ4iMwJzFOQFamsbEnAKmte9iURDZsQRO8vmQWIAhS6Q9lfJoe96lpM79ER
         NWyYQQftHKvAjMIb7sDO4V2oy8XiV0JTScvuZXq7E1p6SKGQEV0Q0VCMS57VLpcitHED
         y1q+j5HXpbPlQQw/N6GVnU+Wof4KaLpNf3KIA++Iw5b2LqT1XXWVwe9Eiq8CmwQMh2DD
         3QFSdClKQzi1o4zHY7yGnSdiPrU61jmIoJZpKugo7pPmwgkcFzKfjeizLgRHCdaJHaRy
         OoyQbo8I0ambx32wb/siRhHpuSan2k2cpgcNcB1CAqglcT5ZXc7Hqn8P+dg5BGtz1Ggy
         Tgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=eVueShaDHFZvDqfNXADieO11SLCtToCqRvMxiA76OGs=;
        b=lGYbteD8/UYXRuO8xJNh9T/4HOJlouKIm5WmZzHtBL4JpKJmBhDWNs7gvF5djOS9BY
         68NKwAoApmMNaJuAkCaN/6y+ukLyXh5Oo3XvY6o7wD02Q1GIwN/5pvvI5FAtGlaXDTWU
         0WOHVpV52tVcYFvM2N4WhmO2htiz1kNxbdTR0B0GXkhGbsP3dTQ9lIYxDiMkyXoEQcH+
         GpwGa4NRJujey0QP7FKts3qr7bgZ8Rhkg26XLggkbbF6tylFTp+ixqu/d2JZrYTrbURI
         RhAOQcTn7z/tbq000R8nU5E+gMw7TdSt2WEfPmFURC6mKd/R0pYnceqGNbgLBKKokm8K
         twuw==
X-Gm-Message-State: AA+aEWZWU+EvQijFbeNTIFIakSc7B1UOI709Wx4ICqj164L4qm+1uL4+
        jmedNlJT7EQWqUbtCPnPe3c=
X-Google-Smtp-Source: AFSGD/XJ0YW62mQjcgsCGPtpxbaKuZJjwGxejnjC+QVEIOpS7O7qlt1d17vGk1cfQWxdzZNiDi7+6g==
X-Received: by 2002:adf:aa94:: with SMTP id h20-v6mr23818169wrc.216.1543248059130;
        Mon, 26 Nov 2018 08:00:59 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id e8-v6sm1967474wmf.22.2018.11.26.08.00.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 08:00:58 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC] Introduce two new commands, switch-branch and restore-paths
References: <20181110133525.17538-1-pclouds@gmail.com>
        <xmqq8t1y3jex.fsf@gitster-ct.c.googlers.com>
        <CACsJy8BGgf0J=iKNc3qmz_rTMNdaPmR_1v+9i3nhGKcuOH4AFA@mail.gmail.com>
        <8736rx1ah9.fsf@evledraar.gmail.com>
        <CACsJy8B6wKGg2Jsopct-0dYNhKJGf9RdnrnTqBOt4kxy6LzxMw@mail.gmail.com>
        <20181120174554.GA29910@duynguyen.home>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181120174554.GA29910@duynguyen.home>
Date:   Mon, 26 Nov 2018 17:00:57 +0100
Message-ID: <87o9abzv46.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 20 2018, Duy Nguyen wrote:

> On Mon, Nov 19, 2018 at 04:19:53PM +0100, Duy Nguyen wrote:
>> I promise to come back with something better (at least it still
>> sounds better in my mind). If that idea does not work out, we can
>> come back and see if we can improve this.
>
> So this is it. The patch isn't pretty, mostly as a proof of
> concept. Just look at the three functions at the bottom of checkout.c,
> which is the main thing.
>
> This patch tries to split "git checkout" command in two new ones:
>
> - git switch-branch is all about switching branches

Isn't this going to also take the other ref arguments 'git checkout'
takes now? I.e. tags, detached HEADs etc? I'm reminded of the discussion
about what "range-diff" should be called :)

> - git restore-paths (maybe restore-file is better) for checking out
>   paths

If it takes globs/dirs then a plural is probably better.

> The main idea is these two commands will co-exist with the good old
> 'git checkout', which will NOT be deprecated. Old timers will still
> use "git checkout". But new people should be introduced to the new two
> instead. And the new ones are just as capable as "git checkout".
>
> Since the three commands will co-exist (with duplicate functionality),
> maintenance cost must be kept to minimum. The way I did this is simply
> split the command line options into three pieces: common,
> switch-branch and checkout-paths. "git checkout" has all three, the
> other two have common and another piece.
>
> With this, a new option added to git checkout will be automatically
> available in either switch-branch or checkout-paths. Bug fixes apply
> to all relevant commands.
>
> Later on, we could start to add a bit more stuff in, e.g. some form of
> disambiguation is no longer needed when running as switch-branch, or
> restore-paths.
>
> So, what do you think?

That "git checkout" does too many things is something that keeps coming
up in online discussions about Git's UI. Two things:

a) It would really help to have some comparison of cases where these
   split commands are much clearer or less ambiguous than
   git-checkout. I can think of some (e.g. branch with the same name as
   a file) but having some overall picture of what the new UI looks like
   with solved / not solved cases would be nice. Also a comparison with
   other SCMs people find less confusing (svn, hg, bzr, ...)

b) I think we really need to have some end-game where we'd actually
   switch away from "checkout" (which we could still auto-route to new
   commands in perpetuity, but print a warning or error). Otherwise
   we'll just end up with https://xkcd.com/927/ and more UI confusion
   for all.
