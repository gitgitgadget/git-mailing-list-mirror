Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2265D1FAE2
	for <e@80x24.org>; Tue, 20 Mar 2018 18:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751408AbeCTSRq (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 14:17:46 -0400
Received: from mail-ot0-f170.google.com ([74.125.82.170]:34290 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeCTSRp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 14:17:45 -0400
Received: by mail-ot0-f170.google.com with SMTP id m7-v6so2797628otd.1
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 11:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8il7kCb/XEhn9/RE967Q4BsFRWJFQsCkQ1bm2vgqXtc=;
        b=mMWO9f4AFU6gFPOGpAhrr6pl7BnNLXmYQ1DqCO9uUlQqbhMdPOZLDMHi7Bk+BfIk4A
         yg3WNRw1S8BrxjxGbFB0DMbEM8tJn9XHYTYdv3O73jdpbpjh9QCoAusmH10bktu14PNK
         wbxWoV60Z02VB9PI8BeBPuKi3rbmQuvqBQELLNYdW08ip2wNssI5feUtwa5UzOTElsRe
         JITtcIsJkNfzu8HBTldRxQPOhCTcym1JtDE7ma+IWJc4qEixDEmCdZaP0qnTxGN5X6WD
         sWx/GGdcUJkGivIanbBtRGLbIys7U9czo2/DIc+NK4amFwTYthR3uyc9qNnmeAdfFDwd
         rhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8il7kCb/XEhn9/RE967Q4BsFRWJFQsCkQ1bm2vgqXtc=;
        b=EkUjoXVWTKHJkhJByDQvUU4T4bmcmy28SK4/SKLHgrSpR0LSOgAwEchfpJPHkmEakQ
         uIyb57vE10Jz3D8nULknZ7aRqhw2P/SkvRtXzBbG9uexJGs83c+wqbep92FO+l42kG4q
         msH31MLH7kS97YNc1CkswrqjFqVvmInzf1VAPaVOoYEXEO6hQfz1jxQ41O3fhG/XXctt
         ZAUlcBHZLPSIBbE+P9vcVO9PPQ2OkimkRbGM/bB++51wZO23HrQsUHOrh2kA4cBuLGB5
         ReBgCnNB/VAsGhhVDrvmpHwYXjiWyivqneW0cTpC2Si7r1USUdT8F587l/LkzMZRjRnY
         62jg==
X-Gm-Message-State: AElRT7GFl2mrCNEozhVgnZOnd+rTj/yawTS8qb+wqRy+JY8hCaQ9RhHA
        wu+ISdDVJhd8pL6C97QZ5EwdQpsnyMQntdoMNRg=
X-Google-Smtp-Source: AG47ELuyXUPfmsnxF4bCoAD7kRPQPEjs/oTnMXYz11G+967k4fyOPWY6dY66nkuNWg+nKAEI5sJmdajyAa6+5q4NF/k=
X-Received: by 2002:a9d:3698:: with SMTP id h24-v6mr11729447otc.173.1521569864385;
 Tue, 20 Mar 2018 11:17:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Tue, 20 Mar 2018 11:17:13 -0700 (PDT)
In-Reply-To: <xmqqsh8wvwwn.fsf@gitster-ct.c.googlers.com>
References: <20180317141033.21545-1-pclouds@gmail.com> <20180318142526.9378-1-pclouds@gmail.com>
 <20180318142526.9378-10-pclouds@gmail.com> <xmqqsh8wvwwn.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 20 Mar 2018 19:17:13 +0100
Message-ID: <CACsJy8AM=TYDBedn2VTDZKmNEZUUhz0XCbZ928NWCsP7rPtxPw@mail.gmail.com>
Subject: Re: [PATCH v6 09/11] pack-objects: shrink size field in struct object_entry
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 19, 2018 at 5:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> +static inline void oe_set_size(struct object_entry *e,
>> +                            unsigned long size)
>> +{
>> +     e->size_ =3D size;
>> +     e->size_valid =3D e->size_ =3D=3D size;
>
> A quite similar comment as my earlier one applies here.  I wonder if
> this is easier to read?
>
>         e->size_valid =3D fits_in_32bits(size);
>         if (e->size_valid)
>                 e->size_ =3D size;

I wonder if wrapping this "=3D=3D" with something like this would help read=
ability?

#define truncated(a,b) (a) !=3D (b)

Then we could write

e->size_valid =3D !truncated(e->size_, size);
--=20
Duy
