Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 304621F453
	for <e@80x24.org>; Sat,  2 Feb 2019 09:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfBBJO0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Feb 2019 04:14:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37209 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfBBJO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Feb 2019 04:14:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so9528810wrt.4
        for <git@vger.kernel.org>; Sat, 02 Feb 2019 01:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OidYRehJy7kSdLVfOE3YmERTy16TaYEzxJbl+ZK5qCI=;
        b=Iahvkm6bgaNOugHRsDrq4hMH4OgiK4DDAnI//uLvJTjBQxioUEByqWJ0iip2aYeX6D
         bv5fgYPtCRgxIaFNjvmK7iePBJ5DtdZaWjEy74Ux1Z0T8N1zPs7/uL5Pu0C9YLbQxD3U
         p8pLAo23oEOueD+K225K9iE80yZRSl0FBNiZF9ubZ0J32Za9BPOKNHB1ZLg5SyePuvpx
         aS5HtoCJ0jjv++wDyCPE5xzvSNlZJBpB1J8rTf+roAK3HIrPHksSXepeIsWjQPK4wQof
         WjbRfWqA4wO1WozaC3u1KaOtbxzCx4VSLVvWZyLmV8XcSdf4XknFc9G0tYvYpIWd6MXN
         Fa0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OidYRehJy7kSdLVfOE3YmERTy16TaYEzxJbl+ZK5qCI=;
        b=cSUQr0/GdCaRzJ+MPiBKb70PKspefKjn4Xx6GTg7Ikg83VQcFoYIrzIeRNg1nM+CMs
         ER29322FIrcKPWI/zcINwRqVmxulm/ovpW4HpUJlUqqI7XlINOE1pebGEy2xxflmpNz7
         eiERqql6af4Ib8Ncd24LKNgTbZWmxMVKFy5q/nsNOMnEO+8+A5cwrm8CrOCu/pQwk3gn
         lOA2c1nnNViJiE05yh04GRxovKG16hocNeQtIIOKGg0TFtABU359WNIAibV8sDnStiGF
         Y/W/A9/tQMBYS2SLySmgM/yFXXCDn2y6+wytNI5kJGLxqvaApUzCciZqMIqqv0nNChbh
         AudQ==
X-Gm-Message-State: AHQUAub9nZhkBJVBN8xobaIDFCJUR8mzqv6a88+PP/1xhOsTvnIEfq/v
        bGwpwj+Gk7ajDwaU+zMcseISVTvwCJhW0lO+2r0=
X-Google-Smtp-Source: AHgI3IYDeqJmW9mRpVFj3ELLCtgwoGihld78OMi0K9X9wEV2kcchUA3pkkDWT/FAVF5ewoh7xCU0mV9AKK8TzQy4SU0=
X-Received: by 2002:adf:9c8a:: with SMTP id d10mr2979908wre.244.1549098864444;
 Sat, 02 Feb 2019 01:14:24 -0800 (PST)
MIME-Version: 1.0
References: <20181028125025.30952-1-anders@0x63.nu> <20181208163647.19538-1-anders@0x63.nu>
 <20181208163647.19538-3-anders@0x63.nu> <xmqqa7ldkbwr.fsf@gitster-ct.c.googlers.com>
 <87o99iwmjn.fsf@0x63.nu> <20190129165523.GA7349@sigill.intra.peff.net>
 <87pnsfkvk1.fsf@0x63.nu> <CAL21Bmmx=EO+R2t+KviNekDhU3fc0wjCcmUmbzLa14bb0PAmHA@mail.gmail.com>
 <87o97wll60.fsf@0x63.nu>
In-Reply-To: <87o97wll60.fsf@0x63.nu>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Sat, 2 Feb 2019 12:14:13 +0300
Message-ID: <CAL21BmnU2aTT_8iqejurgKeHXk-kmmGK1tmXLcVh7G12rwRPOw@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] pretty: allow %(trailers) options with explicit value
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=D1=87=D1=82, 31 =D1=8F=D0=BD=D0=B2. 2019 =D0=B3. =D0=B2 21:47, Anders Wald=
enborg <anders@0x63.nu>:
>
>
> =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=B5=D0=B6=D0=BD=D0=B0=D1=8F write=
s:
> >> Oh my. I wasn't aware that there was a totally separate string
> >> interpolation implementation used for ref filters. That one has
> >> separated parsing, making it more amenable to good error handling.
> >> I wonder if that could be generalized and reused for pretty formats.
> >>
> >> However I doubt I will have time to dig deeper into that in near time.
> >>
> >
> > Sorry, I haven't read your patch in details. If you will be at Git Merg=
e
> > tomorrow, you could ask me any questions, I can explain how for-each-re=
f
> > formatting works amd maybe even give you some ideas how to use its logi=
c in
> > pretty, I was thinking about it a bit.
>
> No, unfortunately I'm not at Git Merge.
>
> I think I got how the formatting work. But if you have ideas on how to
> reuse the logic I'm all ears.

 Maybe my advices will be not suitable: I know how ref-filter works,
but I know only a few about pretty system. The main point is that we
need to save backward compatibility, and that means that we can't just
drop pretty logic and start using ref-filter one there. I guess it's
not so hard to make like translation table between pretty commands and
ref-filter one. For example, 'short' in pretty means 'commit
%(objectname)%0aAuthor: %(author)' in ref-filter. So if I wanted to
change pretty logic, I would add support of all ref-filter commands
and make translation table for backward compatibility. Hope it was
helpful.



>
