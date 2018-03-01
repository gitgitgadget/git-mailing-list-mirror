Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01CAD1F404
	for <e@80x24.org>; Thu,  1 Mar 2018 13:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030697AbeCANdk (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 08:33:40 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42014 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030616AbeCANdj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 08:33:39 -0500
Received: by mail-wr0-f194.google.com with SMTP id k9so6117182wre.9
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 05:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Cok9mzQhkuebCjkWVrrM1VVXLBQ/Bja0dz867giRjXs=;
        b=Pjv7hiF/XRKblCL2sVxmc/YaO1+M1DV8VFSDyjmAk34m6N1pl2r+p7UfDeEYGqbYY0
         fCYGzcrebU8LptmrAMBccWCj2Y5rtCJ69TQPHMRehEr1eMF1IOy6WKk2kQ/xIOKUjE0I
         KrPt1yV4VVb2lBx9ztJtNRfjtdyie/6UpCIB0lZQFR0CGiW+ly026i+4y/b/HTl1ertZ
         gbNq9F5COueER6bLqNzTgjcL+5aO/8reHEfmOPLo7wn3p0gLVKV9wvlnrV4GUVS10uhl
         ZlYNYD7WvKy+ylulU0ID6kL21h14lgNyXGZTu4GMK1b0sb8UWNpdxJNf4GFido1nR/3W
         2iJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Cok9mzQhkuebCjkWVrrM1VVXLBQ/Bja0dz867giRjXs=;
        b=ZXjK0W2U174PNTGjZ9DI59VDXoCeQ5umztgyz4O1ccHlm6YgVsFLOcvRS+diVVDCM1
         iF32v6v8PStP8C6ZvHfCs3/9dKHI5q6txwP8Pd7Q6Bf0zHsG5AoqV95mnpAUdaTZzbW4
         70oM4PLXwIUTiZkA0+Zo+1mu82XgCQXHSixXsL1Qw77FjIp7pBv+ds6bq2X/kFAEUITO
         fP/dPl5P6zwgWUeDb/B8+ccPFPVXPDW14vdaorBCAAhM4ZUipnIfVEu0bm9XHe3NAue+
         wjEWqoZ8OK5zBsDMQEcmUguwIm2N+08b+BtorlsSbwCm9cTbMdHk9nomrgSDUUUld5jS
         gZ6A==
X-Gm-Message-State: APf1xPDtp6xEVkpO9aVIwypEVVT5oDXmapd+Z8mNoLmyo7tryQA1DDKa
        EEYqY3FZU0M25lbV6vn8l6A=
X-Google-Smtp-Source: AG47ELtC9dimhojqJGRzquBuNo4CSW+qKoNFf+c37B32xygAnFzidOgHhsBe/aExhNeSDIhznXl2pg==
X-Received: by 10.223.185.24 with SMTP id k24mr1965557wrf.83.1519911218673;
        Thu, 01 Mar 2018 05:33:38 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id z72sm3882470wmc.2.2018.03.01.05.33.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 05:33:37 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH 00/11] Reduce pack-objects memory footprint
References: <20180228092722.GA25627@ash> <20180301091052.32267-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180301091052.32267-1-pclouds@gmail.com>
Date:   Thu, 01 Mar 2018 14:33:36 +0100
Message-ID: <87y3jbdiof.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 01 2018, Nguyễn Thái Ngọc Duy jotted:

> The array of object_entry in pack-objects can take a lot of memory
> when pack-objects is run in "pack everything" mode. On linux-2.6.git,
> this array alone takes roughly 800MB.
>
> This series reorders some fields and reduces field size... to keep
> this struct smaller. Its size goes from 136 bytes to 96 bytes (29%) on
> 64-bit linux and saves 260MB on linux-2.6.git.

I'm very interested in this patch series. I don't have time to test this
one right now (have to run), but with your previous RFC patch memory use
(in the ~4GB range) on a big in-house repo went down by a bit over 3%,
and it's ~5% faster.

Before/after RSS 4440812 / 4290000 & runtime 172.73 / 162.45. This is
after having already done a full git gc before, data via /usr/bin/time
-v.

So not huge, but respectable.

We have a big repo, and this gets repacked on 6-8GB of memory on dev
KVMs, so we're under a fair bit of memory pressure. git-gc slows things
down a lot.

It would be really nice to have something that made it use drastically
less memory at the cost of less efficient packs. Is the property that
you need to spend give or take the size of .git/objects in memory
something inherent, or just a limitation of the current implementation?
I.e. could we do a first pass to pick some objects based on some
heuristic, then repack them N at a time, and finally delete the
now-obsolete packs?

Another thing I've dealt with is that on these machines their
NFS-mounted storage gets exhausted (I'm told) due to some pathological
operations git does during repack, I/O tends to get 5-6x slower. Of
course ionice doesn't help because the local kernel doesn't know
anything about how harmful it is.
