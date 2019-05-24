Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 274F81F609
	for <e@80x24.org>; Fri, 24 May 2019 12:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391026AbfEXMeY (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 08:34:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36730 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389057AbfEXMeY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 08:34:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id s17so9880657wru.3
        for <git@vger.kernel.org>; Fri, 24 May 2019 05:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nxWn4mRq68PICdTpcMhvVGky8vsS0F7xavnvZhcqPjA=;
        b=IRrMBQuvuT+QGzLkVvFsD7ee8CjMxAClBbZ/mxutRGFdZKh52INKVcGkudyOwY9PRN
         ovOc7xRKxRBE1IlIC2R1LKR4ADtUBtA05LL8AVLoGaRPi1jQZ2TtD7cVSrKGWgfEMJmI
         SBP/qYHP1BCMr6JlkfRnYYWzqdBQYG+0WmrrNtUAxp/mDc9IgB26/J8PpbgR9Nsxqy27
         x6hRYPJk8qJ4NDNe0yq6LFHicd3478awPMcvTZIQS0+JBYO7GPra3Zwk5uSTEop+MJQm
         s02tmEqjfGrCWSS7THI8BSOd2KXUxyVysuHe37DS3j7Z3Er2aj7Au7a6M6D6gksUf6Eh
         0+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nxWn4mRq68PICdTpcMhvVGky8vsS0F7xavnvZhcqPjA=;
        b=CaNl7F3a5ILx9Q/LFHbEcZ5hb4lsmnBnDd4XDTkAMWhrGmxiMlu8pHU5e4Z6chXEVI
         JwRaLO3xEv/XaGbi+ZGBCH07Hb8rcu8VF6N9thJarbxNAdH71Z/Et8nyILfboe73gsH9
         Pr+rGj77Qb7QJVHAXzAyoYB9/Vz/tneCwCywi3eHZ6akezLTckudhxFVQ5BjxbfYyili
         s3tAAUxzhdZyfECZSS5YVfw2fAllz/83P07fXk+43IEkE7jnp9sXDv3YOnFsThXWTNWj
         /vKF9+V1PCPf+f+bjjkLpNRz5mAaUJ1oD/0f+rK3b5IPV+OQe4zefpHQCb9BNtTRgKSt
         vh0w==
X-Gm-Message-State: APjAAAU8IOpT11/R0e7iiqNwHf1UvgZeQTndYemjP9Dpzz2z8mWYhPKE
        QmxyZHTlIES0/CqCgi+sda0=
X-Google-Smtp-Source: APXvYqz3GPLXiZr8AbrEYqY6O/bcT/es6bktW77BCVJn/XH3EjSlj2rUZrTPYrXnU3LgNdcPjU+FOw==
X-Received: by 2002:a5d:618b:: with SMTP id j11mr19795802wru.36.1558701262294;
        Fri, 24 May 2019 05:34:22 -0700 (PDT)
Received: from szeder.dev (x4db30b59.dyn.telefonica.de. [77.179.11.89])
        by smtp.gmail.com with ESMTPSA id l18sm5889835wrh.54.2019.05.24.05.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 05:34:21 -0700 (PDT)
Date:   Fri, 24 May 2019 14:34:19 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org
Subject: Re: [PATCH v3] repack: enable bitmaps by default on bare repos
Message-ID: <20190524123419.GI951@szeder.dev>
References: <20190523113031.GA17448@sigill.intra.peff.net>
 <87tvdlt1jp.fsf@evledraar.gmail.com>
 <20190524072724.GH25694@sigill.intra.peff.net>
 <87r28offs6.fsf@evledraar.gmail.com>
 <20190524082605.GB9082@sigill.intra.peff.net>
 <87pno8fcp8.fsf@evledraar.gmail.com>
 <20190524092920.GD951@szeder.dev>
 <87imu0f6fh.fsf@evledraar.gmail.com>
 <20190524114114.GH951@szeder.dev>
 <87ftp4f4j8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ftp4f4j8.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 24, 2019 at 01:58:03PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, May 24 2019, SZEDER Gábor wrote:
> 
> > On Fri, May 24, 2019 at 01:17:06PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >>
> >> On Fri, May 24 2019, SZEDER Gábor wrote:
> >>
> >> > On Fri, May 24, 2019 at 11:01:39AM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> >> I don't think it's a performance problem to have an old commit-graph
> >> >> lying around. But if you turn on the commit-graph, run gc a bunch, then
> >> >> turn it off in config we'll have it lying around forever, even if you do
> >> >> subsequent gc's.
> >> >>
> >> >> So I think we should delete such things on the general principle that
> >> >> the end-state of a gc's shouldn't be the accumulation of the values of
> >> >> past configuration options if we can help it.
> >> >>
> >> >> Maybe that screws over other users who did a "commit-graph write"
> >> >> without setting gc.writeCommitGraph, but I think the only sane thing to
> >> >> do is to make "gc" fully 'own' such things if its turned on at all.
> >> >
> >> > Note that there is 'core.commitGraph' as well; as long as it's
> >> > enabled, no commit-graph files should be deleted.
> >>
> >> Why? If we won't update it or write it if it's not there, why keep it
> >> around?
> >
> > To read it, if 'core.commitGraph' says that is should be read.
> >
> >> It means the commit-graph code and anything else (like bitmaps) needs to
> >> deal with stale data for the common and default gc --auto case.
> >>
> >> You also can't have e.g. a global core.commitGraph=true config along
> >> with a per-repo gc.writeCommitGraph=true config do what you expect.
> >>
> >> Now just because you wanted to write it for some you'll end up keeping
> >> it around forever because you'd also want to optimistically always use
> >> it if it's there.
> >
> > This is exactly what I expect it to do.
> 
> Do you also expect base packs with an associated bitmap to have an
> implicit *.keep flag under gc with pack.writeBitmaps=false and
> pack.useBitmaps=true?

I don't understand what an "implicit *.keep flag" is.  However, since
a reachability bitmap is always associated with a pack, but the
commit-graph is not, I don't think this is a valid comparison.

> >> Note that I'm talking about the *default* gc semantics, they don't have
> >> to cover all advanced use-cases, just be good enough for most, and it's
> >> also important that they're as simple as possible, and don't result in
> >> stuff like "my performance sucks because I turned this config option on
> >> once a year ago for 2 days".
