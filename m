Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F07661F453
	for <e@80x24.org>; Sat, 27 Oct 2018 10:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbeJ0TW4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 15:22:56 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43286 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbeJ0TW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 15:22:56 -0400
Received: by mail-ed1-f66.google.com with SMTP id y20-v6so3386438eds.10
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 03:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=oQgP9OwxS/ICiXBCaSGJGAAd6V8kXdATeQWMpmzHi2g=;
        b=rp5hW0pNUDCimT+r+FB8KovaGDJNftQazb3JKs+07FqjT1XRNtYliV8wyMG3bY88P3
         26XHYSeKHjyptuzMmXVz2HwC7XHlYslDan2CcbZ4chF4vHc8RSKt0BdPM4C1UuAfE+ju
         vasoF9Zy3s2X2RUW2TpL80sk+8Ao6nJN8ncAblq37WrOR4akJj3OcWAzhKDJrzxYt0DQ
         4uVahsXcbmZW4hmzT1jgyhgtiLpP5+BLxWvrtNeax0fa/Wz0Dsz4yprTbDgiGtjnEEgH
         k6SRU9lUw2glxEkn2uJWhE5AkKdp15XhWu1aZ1iZDHAQ8uUrwDlFrbX3mcRxYgMdYvt+
         yfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=oQgP9OwxS/ICiXBCaSGJGAAd6V8kXdATeQWMpmzHi2g=;
        b=GuZ5bvjGceggbbnyF97GqlD/I4Nx9fGdJGpm2HDePFEFZwROAKbarf2wmIwqGLzddG
         QEF+jC1VAe+MLjfMzzNh7E9FL1bQH+LRn7UTjw1NDuYTnx2IMEHwahvMULj1Pn6bscl0
         9ibcBrQjvKvwg3sLvnZwRR1bzCdapPWKZNoVDpo88f4c1HkUYob7YCOP2501xzdk7vcb
         FbaM57S84lnKNjgWK8xsnLhaTlUNNwSMz6mv6Krs8+THVlzoGjF+eCaK39uJIcCEprAr
         SH3kiKbTvjwLEMEBnyi8zHDYEN1A2hzysoFsNsEj0lTQi+kT7J/ExwRTUkoNm1RsRb5C
         W66Q==
X-Gm-Message-State: AGRZ1gLkx3r8qj+xI46uvT5qtr0whK6AZwZAVumTrAN7shEmkWnl+vsy
        7kJ2UbJv1k8dx9Fxi3645W4=
X-Google-Smtp-Source: AJdET5fHr5VTnTp3O5bCyMfxTyAIRVxp/AHt0wbN5zG1fpWaC6K8JY7hmNgeIatlAtjFzsUgVVNU5g==
X-Received: by 2002:a50:8987:: with SMTP id g7-v6mr5979099edg.257.1540636943531;
        Sat, 27 Oct 2018 03:42:23 -0700 (PDT)
Received: from evledraar (223-81-146-85.ftth.glasoperator.nl. [85.146.81.223])
        by smtp.gmail.com with ESMTPSA id q5-v6sm3478878edg.81.2018.10.27.03.42.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Oct 2018 03:42:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] i18n: make GETTEXT_POISON a runtime option
References: <xmqqsh0xtwgb.fsf@gitster-ct.c.googlers.com> <20181023210154.32507-1-avarab@gmail.com> <xmqqefcfoq2a.fsf@gitster-ct.c.googlers.com> <20181024074400.GA31239@sigill.intra.peff.net> <xmqqefcen8ls.fsf@gitster-ct.c.googlers.com> <20181025010905.GA4458@sigill.intra.peff.net> <a5535030-65c1-613c-e4ea-d4379b243b87@ramsayjones.plus.com> <20181025212358.GA23257@sigill.intra.peff.net> <87pnvwldk7.fsf@evledraar.gmail.com> <20181027065952.GA17203@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181027065952.GA17203@sigill.intra.peff.net>
Date:   Sat, 27 Oct 2018 12:42:19 +0200
Message-ID: <87muqzllh0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Oct 27 2018, Jeff King wrote:

> On Fri, Oct 26, 2018 at 09:20:56PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> >> I was thinking:
>> >>
>> >>   $ git var -e GIT_WHATEVER_ENV
>> >>
>> >> [-e for environment].
>> >>
>> >> ... but that is really no different than git-config. ;-)
>> >
>> > Actually, "git var" already does pull bits from the environment. It
>> > doesn't know about all of the type-specific parsing that git-config
>> > does, but it might be a reasonable path forward to teach it that. (But I
>> > still think we should do nothing for now and see how often this comes
>> > up).
>>
>> For myself / Junio picking this up: Does that mean you've read v2 and
>> think it's OK to pick up in its current form? I think it is, just
>> looking for some Acks on that since it's not in the latest "What's
>> Cooking".
>
> I'm not sure if you're asking whether I looked at the rest of the patch.
> If so, then no, not really (so no objection, but I also did not review
> it).

Yeah I'm fishing for a more general review than just the problem of how
we turn an env variable into a boolean, so if you or anyone else is up
for it it would be most welcome :)
