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
	by dcvr.yhbt.net (Postfix) with ESMTP id 213CD1F609
	for <e@80x24.org>; Fri, 24 May 2019 11:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391286AbfEXL6H (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 07:58:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39878 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390961AbfEXL6H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 07:58:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id e2so964889wrv.6
        for <git@vger.kernel.org>; Fri, 24 May 2019 04:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=K1+f8YysbSUhgWAQ5SsVQZDChgALJt3boKgsN/gQ85k=;
        b=aaytQ7nSDGZGYGLY7xOZMKXtdd8lrwl5zOJlAHwQU2KinMNrSDvUtl5e/BoRhZiLON
         Tfbslpeuxx56+XtLD8F222oeg4hZZUh5hzjHkeH05yKK4QVAsbajC8VwgvNqgh88Iedl
         jcEEPxvQowcwt1LfdRjYgKwTgZSphq2gTPHTzUhJEQHFegfWf38fxVRYXCiXCS5eV2BD
         QRYujzF0sG7hIxMDBkDELsJPB6ZqbgdYrcq8l2irkmdRA8vNdBt2YGmXhV8dX65hBBZW
         gJquegWikyENmpCTGqVgzwF724YLxs5xS2EmCsLOhfmSe467NBR8HNMzoU+/+WtvvvO6
         do0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=K1+f8YysbSUhgWAQ5SsVQZDChgALJt3boKgsN/gQ85k=;
        b=aDgkfx3/5DnVsPx+RkFOKYBYuh0Y9G2m8B/WisZI2Tw+Gnnj9GcZL46rswOVJybvTe
         MaNz9rMmk6aAvEnkfl1mipe/8u3HODxbsgILjYTIsSgFkidbEriw/fqa2BsNuaKI76LV
         d8t70xmqpehnrFvjoR6gCTiR1TXr7qqcv3gjaY60tmn1GBjOeBrS8FsHDd/Dgv94hsLJ
         X861ctOlkIl91hQ03sA4fbHcJsA084UmqDMz2SaUASou8vAwVpahvLXaoeBKYRd15oFp
         +2ebRVoUKyGDjyjl/w4kiOX/v+y0cIHqdKjDaa2dRG+GVpWtJ0l6WCjwtk5eXwHOMZ/d
         FzWQ==
X-Gm-Message-State: APjAAAVO33db+5AWlxKWpVM+4zlv4kOovi5y97CVulOMN8kMDnSLxiYi
        8hcxBnOnnHN7QFPxZG0j4LCQK72iuwQ=
X-Google-Smtp-Source: APXvYqyz0EiRNvO3wU2xke42IuDmfuZFy8M0TXEchAwp35wLUBRL3GyBakX6E1/guDJ6lbL2LNUnXA==
X-Received: by 2002:adf:df87:: with SMTP id z7mr1976189wrl.8.1558699085553;
        Fri, 24 May 2019 04:58:05 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id d9sm2550325wro.26.2019.05.24.04.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 04:58:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org
Subject: Re: [PATCH v3] repack: enable bitmaps by default on bare repos
References: <87zhoz8b9o.fsf@evledraar.gmail.com> <20190410225721.GA32262@sigill.intra.peff.net> <20190523113031.GA17448@sigill.intra.peff.net> <87tvdlt1jp.fsf@evledraar.gmail.com> <20190524072724.GH25694@sigill.intra.peff.net> <87r28offs6.fsf@evledraar.gmail.com> <20190524082605.GB9082@sigill.intra.peff.net> <87pno8fcp8.fsf@evledraar.gmail.com> <20190524092920.GD951@szeder.dev> <87imu0f6fh.fsf@evledraar.gmail.com> <20190524114114.GH951@szeder.dev>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190524114114.GH951@szeder.dev>
Date:   Fri, 24 May 2019 13:58:03 +0200
Message-ID: <87ftp4f4j8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 24 2019, SZEDER G=C3=A1bor wrote:

> On Fri, May 24, 2019 at 01:17:06PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Fri, May 24 2019, SZEDER G=C3=A1bor wrote:
>>
>> > On Fri, May 24, 2019 at 11:01:39AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> >> I don't think it's a performance problem to have an old commit-graph
>> >> lying around. But if you turn on the commit-graph, run gc a bunch, th=
en
>> >> turn it off in config we'll have it lying around forever, even if you=
 do
>> >> subsequent gc's.
>> >>
>> >> So I think we should delete such things on the general principle that
>> >> the end-state of a gc's shouldn't be the accumulation of the values of
>> >> past configuration options if we can help it.
>> >>
>> >> Maybe that screws over other users who did a "commit-graph write"
>> >> without setting gc.writeCommitGraph, but I think the only sane thing =
to
>> >> do is to make "gc" fully 'own' such things if its turned on at all.
>> >
>> > Note that there is 'core.commitGraph' as well; as long as it's
>> > enabled, no commit-graph files should be deleted.
>>
>> Why? If we won't update it or write it if it's not there, why keep it
>> around?
>
> To read it, if 'core.commitGraph' says that is should be read.
>
>> It means the commit-graph code and anything else (like bitmaps) needs to
>> deal with stale data for the common and default gc --auto case.
>>
>> You also can't have e.g. a global core.commitGraph=3Dtrue config along
>> with a per-repo gc.writeCommitGraph=3Dtrue config do what you expect.
>>
>> Now just because you wanted to write it for some you'll end up keeping
>> it around forever because you'd also want to optimistically always use
>> it if it's there.
>
> This is exactly what I expect it to do.

Do you also expect base packs with an associated bitmap to have an
implicit *.keep flag under gc with pack.writeBitmaps=3Dfalse and
pack.useBitmaps=3Dtrue?

>> Note that I'm talking about the *default* gc semantics, they don't have
>> to cover all advanced use-cases, just be good enough for most, and it's
>> also important that they're as simple as possible, and don't result in
>> stuff like "my performance sucks because I turned this config option on
>> once a year ago for 2 days".
