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
	by dcvr.yhbt.net (Postfix) with ESMTP id 20EA11F609
	for <e@80x24.org>; Fri, 24 May 2019 13:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403815AbfEXNlp (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 09:41:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45535 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391361AbfEXNlo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 09:41:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id b18so10055388wrq.12
        for <git@vger.kernel.org>; Fri, 24 May 2019 06:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=GAFXbR7Jk0XOVJGcPAhV3HqDpUXfmMGwO9iU5J5CnGg=;
        b=BxhFdzpmJeK8wQzSiALSZuTbdPiSRVpQkOliTX5jh4MzxUsvy8xv7EVK1DDU6Hqwpq
         INkSBDRMitLyxsjfpj1zW6nW5ndxBaARq2odmwMSH1t9UDeHsb3qIrKjUd4TMRaV9clR
         IULh5o/nc5lcaXZduqCJQLPYteMzgXI9TVzoCVU9+hmG+YZNVaoyERQjJAqkqSZwOYdw
         AXaXq5qf+xiKPFKO14ThSgPmMQTsCssAOEf+4R583h+O97k/cwY/VrA97C6awMNy73C8
         sbtQj1tDzNLl87GzmtD6nzKNFKNFgH8u45I456TTDpQrm3qodFHeCr9HD9Sj1j5X+3G2
         2UHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=GAFXbR7Jk0XOVJGcPAhV3HqDpUXfmMGwO9iU5J5CnGg=;
        b=Z/vRRguh0r7xi9HmNBmIrwQ80KIFYlmk+YrhtZSLuLtC7UTlKo4TaFfcY9lXK15K4D
         N5xua+909txZde08jYZSzizQsxP872ca43UG2CCs2pDMJEP4UUN44oP0pFGbDbg1ztyZ
         9xwxNwGoCQMBsrkQ7FVL4taHNB2ieS9YO0bw1eb4cavbPyEXDoZS9WCqM0he0XAV5DEc
         Yfl+9ijuGs6qt7zFLi3fc3kt2WGha49LTJkEdv+3lL0lirBKRTqkM9xVQnW4D0jyLIL5
         Bls7gR4cB0AuQFJYYqTQ8yWKjZmYfngPzDcId54sR5zG5ZBQOugygZN+sAdOGwOoKPhL
         rwAQ==
X-Gm-Message-State: APjAAAU4YGaHuQuRfgn2rMiMmkn4g4QgJMgv7rpIvssQSB6+IqEl4rgd
        mOmys6cf/xhWbo8sXSTw3Cw=
X-Google-Smtp-Source: APXvYqz9I0oP0voaT/J6CQ6JkxivtjRrbOsVww1SssAVY2ZHArjf7lueWvcXM1Y0jV6VOvJPCbIqOg==
X-Received: by 2002:adf:f48a:: with SMTP id l10mr454404wro.60.1558705302493;
        Fri, 24 May 2019 06:41:42 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id q68sm3055045wme.11.2019.05.24.06.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 06:41:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org
Subject: Re: [PATCH v3] repack: enable bitmaps by default on bare repos
References: <20190523113031.GA17448@sigill.intra.peff.net> <87tvdlt1jp.fsf@evledraar.gmail.com> <20190524072724.GH25694@sigill.intra.peff.net> <87r28offs6.fsf@evledraar.gmail.com> <20190524082605.GB9082@sigill.intra.peff.net> <87pno8fcp8.fsf@evledraar.gmail.com> <20190524092920.GD951@szeder.dev> <87imu0f6fh.fsf@evledraar.gmail.com> <20190524114114.GH951@szeder.dev> <87ftp4f4j8.fsf@evledraar.gmail.com> <20190524123419.GI951@szeder.dev>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190524123419.GI951@szeder.dev>
Date:   Fri, 24 May 2019 15:41:40 +0200
Message-ID: <87d0k8ezqj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 24 2019, SZEDER G=C3=A1bor wrote:

> On Fri, May 24, 2019 at 01:58:03PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Fri, May 24 2019, SZEDER G=C3=A1bor wrote:
>>
>> > On Fri, May 24, 2019 at 01:17:06PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> >>
>> >> On Fri, May 24 2019, SZEDER G=C3=A1bor wrote:
>> >>
>> >> > On Fri, May 24, 2019 at 11:01:39AM +0200, =C3=86var Arnfj=C3=B6r=C3=
=B0 Bjarmason wrote:
>> >> >> I don't think it's a performance problem to have an old commit-gra=
ph
>> >> >> lying around. But if you turn on the commit-graph, run gc a bunch,=
 then
>> >> >> turn it off in config we'll have it lying around forever, even if =
you do
>> >> >> subsequent gc's.
>> >> >>
>> >> >> So I think we should delete such things on the general principle t=
hat
>> >> >> the end-state of a gc's shouldn't be the accumulation of the value=
s of
>> >> >> past configuration options if we can help it.
>> >> >>
>> >> >> Maybe that screws over other users who did a "commit-graph write"
>> >> >> without setting gc.writeCommitGraph, but I think the only sane thi=
ng to
>> >> >> do is to make "gc" fully 'own' such things if its turned on at all.
>> >> >
>> >> > Note that there is 'core.commitGraph' as well; as long as it's
>> >> > enabled, no commit-graph files should be deleted.
>> >>
>> >> Why? If we won't update it or write it if it's not there, why keep it
>> >> around?
>> >
>> > To read it, if 'core.commitGraph' says that is should be read.
>> >
>> >> It means the commit-graph code and anything else (like bitmaps) needs=
 to
>> >> deal with stale data for the common and default gc --auto case.
>> >>
>> >> You also can't have e.g. a global core.commitGraph=3Dtrue config along
>> >> with a per-repo gc.writeCommitGraph=3Dtrue config do what you expect.
>> >>
>> >> Now just because you wanted to write it for some you'll end up keeping
>> >> it around forever because you'd also want to optimistically always use
>> >> it if it's there.
>> >
>> > This is exactly what I expect it to do.
>>
>> Do you also expect base packs with an associated bitmap to have an
>> implicit *.keep flag under gc with pack.writeBitmaps=3Dfalse and
>> pack.useBitmaps=3Dtrue?
>
> I don't understand what an "implicit *.keep flag" is[...]

A .keep means we keep the pack, and e.g. gc.bigPackThreshold is
effectively an implicit *.keep flag on a pack matching some critera,
which in this case caused this issue of a stale *.bitmap file (since the
pack wasn't touched, neither was the bitmap).

> [...]However, since a reachability bitmap is always associated with a
> pack, but the commit-graph is not, I don't think this is a valid
> comparison.

I don't either, I'm just trying to understand where you're coming from,
and I still don't.

That bitmaps are associated with specific packs and the commit graph
isn't is an internal implementation detail. Users who care about that
distinction either don't use "git gc" or would be willing to tweak its
settings.

For the rest I think removing existing side-indexes is a good default
for the practical reasons mentioned upthread.

>> >> Note that I'm talking about the *default* gc semantics, they don't ha=
ve
>> >> to cover all advanced use-cases, just be good enough for most, and it=
's
>> >> also important that they're as simple as possible, and don't result in
>> >> stuff like "my performance sucks because I turned this config option =
on
>> >> once a year ago for 2 days".
