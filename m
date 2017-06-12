Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28C5E1F8CF
	for <e@80x24.org>; Mon, 12 Jun 2017 16:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754254AbdFLQQx (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 12:16:53 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:36201 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754098AbdFLQQu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 12:16:50 -0400
Received: by mail-io0-f177.google.com with SMTP id y77so57465172ioe.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 09:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xWCP3iP477Q9rxqRCsG/KuD9GsSEaHcvOjMbKVeWLdQ=;
        b=q9gxsXozWawHZwU+lmiNrmgHThWMISBHC9/mkQO4OfDaGic04/sf2D52fCJci/gtqc
         FBq3f0gRCbUFtxN94SNaqPW1u8II9bFaa9CgEsrP2AE3sH5ICaZOGa9nVwOlrcaB9/aD
         HRTyjybSEMb9DNbQ58CCue8H71Nr/B/9QzLD5DkDJ/AVhasGoiVvHsgbN31zPbmD/SmV
         UljP6EyQrbndFwwBeWdYMskvPqM/1rRdaX1Bu3Nvo4LN99lZIxDZA990/+rfR+QXJMNZ
         MatkZ1SXYGavbI8lDKU7MlEifNkQuaS7IM7LC8cUkXppD5azQQeVHZY5VR2P2XlIkFIb
         8pjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xWCP3iP477Q9rxqRCsG/KuD9GsSEaHcvOjMbKVeWLdQ=;
        b=M+GNu90HFbBJuqdkrcXGm5TqMlcUY98z7SzIyMs/lDl6FbZCmh9hvABAPIpuusAiqR
         5bp/kGdUA1OpR/5q/5Tsxv9M6athBFKrYi93YRJZteZniKgjCbLh/r2hGdrNe4smDaMZ
         pQQHLHsLf26cXLqHkCzl7h0FQ9Ud0DOHj1H8r0vlzAfCU1w18hZ4DXrDHKHuKWsOmeqc
         VKoSBaOKn7uyUgIZRRv4k96eNZQzocxQPz6qFWVRt2cdEcbTDo0NfExIINFu6uULg16s
         QWWR28cpCxP84Y7VbIlji4lmwri3nJZh2+Yi3CauHovLQC3Mr6cgYz28vhe1Pgt7lJul
         dWBA==
X-Gm-Message-State: AODbwcARXW2AUspU+1CoKeLxBpzKAVBsIYIi2PYEfxMSn1OKJUzDV6qI
        RcAoHifiHNVVIeWgfOu2kK6kBDALaw==
X-Received: by 10.107.178.130 with SMTP id b124mr39973041iof.50.1497284209543;
 Mon, 12 Jun 2017 09:16:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Mon, 12 Jun 2017 09:16:28 -0700 (PDT)
In-Reply-To: <xmqq37b5qly8.fsf@gitster.mtv.corp.google.com>
References: <0a56f99e-aaa4-17ea-245a-12897ba08dbb@web.de> <xmqq1sr3161p.fsf@gitster.mtv.corp.google.com>
 <20170602030825.hdpbaisn54d4fi4n@sigill.intra.peff.net> <72b001fc-80e7-42b9-bd9d-87621da7978a@web.de>
 <20170602183504.ii7arq2ssxgwgyxr@sigill.intra.peff.net> <22833.57584.108133.30274@a1i15.kph.uni-mainz.de>
 <20170602223003.6etkdnnogb2jmoh3@sigill.intra.peff.net> <22833.60191.771422.3111@a1i15.kph.uni-mainz.de>
 <20170602225148.drkl7obwhzypgjtr@sigill.intra.peff.net> <a8b789e6-d0cd-6d96-1bfb-ccc5bc174013@web.de>
 <20170607081729.6pz5yo2hmp4fwuas@sigill.intra.peff.net> <662a84da-8a66-3a37-d9d2-4ff8b5f996c3@web.de>
 <xmqq37b5qly8.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 12 Jun 2017 18:16:28 +0200
Message-ID: <CACBZZX5ofJC70S09rfL_EMK2KWAoPCMun1eisi+CXeX=FSwy6Q@mail.gmail.com>
Subject: Re: [PATCH] strbuf: let strbuf_addftime handle %z and %Z itself
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>, Ulrich Mueller <ulm@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 12, 2017 at 5:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Am 07.06.2017 um 10:17 schrieb Jeff King:
>>> On Sat, Jun 03, 2017 at 12:40:34PM +0200, Ren=C3=A9 Scharfe wrote:
>>>> Duplicates strbuf_expand to a certain extent, but not too badly, I
>>>> think.  Leaves the door open for letting strftime handle the local
>>>> case.
>>>
>>> I guess you'd plan to do that like this in the caller:
>>>
>>>    if (date->local)
>>>      tz_name =3D NULL;
>>>    else
>>>      tz_name =3D "";
>>>
>>> and then your strftime() doesn't do any %z expansion when tz_name is
>>> NULL.
>>
>> Yes, or you could look up a time zone name somewhere else -- except we
>> don't have a way to do that, at least for now.
>
> Is that only "for now"?  I have a feeling that it is fundamentally
> impossible with the data we record.  When GMTOFF 9:00 is the only
> thing we have for a timestamp, can we tell if we should label it as
> JST (aka Asia/Tokyo) or KST (aka Asia/Seoul)?

It's obviously not perfect for all the reasons mentioned in this
thread, but we already have a timezone->offset mapping in the
timezone_names variable in date.c, a good enough solution might be to
simply reverse that lookup when formatting %Z

Of course we can never know if you were in Tokyo or Seul from the info
in the commit object, but we don't need to, it's enough that we just
emit JST for +0900 and anyone reading the output has at least some
idea what +0900 maps to.

We could also simply replace "%Z" with the empty string, as the the
POSIX strftime() documentation allows for:
http://pubs.opengroup.org/onlinepubs/009695399/functions/strftime.html
("Replaced by the timezone name or abbreviation, or by no bytes if no
timezone information exists.").
