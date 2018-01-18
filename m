Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 660151FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 14:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756523AbeAROXo (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 09:23:44 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:33175 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756467AbeAROXl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 09:23:41 -0500
Received: by mail-io0-f173.google.com with SMTP id n7so8532492iob.0
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 06:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x4SACr7qo2mIWTquLV1KPaQhpbVgDLdR1MYsirFgvNU=;
        b=Lxm4aP/CD7fkp0f8Pf3osjKEC95F3ZwxYIc48JeZbPe2Rdp32wsY8eyxBnMppMcNr8
         QoLkcejOEgerhe807nCkP3HT/81qDQ0VxZRu+2mA2qKebaRe+G38D7r6tQOcWzLvUtGg
         +Cwf71S2RY1eqC4tYWauqzOSb1FA6NsbaHAsF/EGt97IjhRcpRT4g/Ic1cH1yvZJsuGC
         BgNRmZx7qm3wJ8ynAb0HEP+L+lHI8CwePNm+BQLyqz1xwgAkyzjN+ycCeD6Etk4hqPpZ
         vUbAv8VvM67eQ/D8KzusHXnHaCuEuYO3qHPDr49ItMkno2WTwMvyor/Mgp5vCUDBh68G
         1ZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x4SACr7qo2mIWTquLV1KPaQhpbVgDLdR1MYsirFgvNU=;
        b=gZgs5m+p07UnDDGtu9kPIPQMqHIoAy+Qlt8JYxAlceTd3b4Kz+Qp+7YH1dQJ1Kl8Pb
         UHieYU7pM8eyJCouLpxllKb+FfGyK6xpCxp6eVRrS+R282awluA54iG/hB9xdHUW/MpF
         coioLx5gvSHcBuQ2Xt7gy8aVfELMe32zgDYPcNC1WwsaLFm9wJpty9VwxZzqn33ILEkb
         n5Gf+KlezdxzHO7ueqInIomuIJkLd6zXJd13TOjKfxO9i0gf7TqKq3btL0CVzIXqifgn
         kA5b+LulYfOrzZ/CGuLMuizA/0PiDNY66a8e73k1tseKpAiudul/jYsdmdRTRIzD9O6k
         RSKg==
X-Gm-Message-State: AKwxytdjT4PhbnILHSHjwSB6TCovQjxpSUmCm4ZTMz/4QW/k4K0ORzO0
        e/uS1rMq4VqCz40WbesbzQPpIWHrNsCponLwrNU=
X-Google-Smtp-Source: ACJfBosPVMnWvh5IDPTyyIezADvZTJ1ocU0XkQPi/XpZuXUmYLy34JP/y1VQjJJE/qscHOX3WybJcf8ZvvMVgdppLQM=
X-Received: by 10.107.69.3 with SMTP id s3mr14875452ioa.67.1516285420437; Thu,
 18 Jan 2018 06:23:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.113.199 with HTTP; Thu, 18 Jan 2018 06:23:39 -0800 (PST)
In-Reply-To: <CAL21BmneJ4rgCtf8t8LOK=gVv0MR+xam9jFBp7kp33rqEG7f6Q@mail.gmail.com>
References: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
 <01020160df6dc529-fae54bd6-e595-44fa-9f9a-c44cb3a5a1a8-000000@eu-west-1.amazonses.com>
 <20180115214208.GD4778@sigill.intra.peff.net> <CAL21Bm=+uPrKECcCq2_rfJRuCpsOjZ41NfiyY3d1UA0b8YKj1w@mail.gmail.com>
 <20180117214354.GA13128@sigill.intra.peff.net> <CAP8UFD0PtOqX5c4ovRbYDWejQ55iUwtnPv-zGXS2GFAajhXqtA@mail.gmail.com>
 <CAL21BmnKd0qamJWJbrAzg_ZX1GkhCTPO_5zOiFNMBeF-xjDTiQ@mail.gmail.com> <CAL21BmneJ4rgCtf8t8LOK=gVv0MR+xam9jFBp7kp33rqEG7f6Q@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 18 Jan 2018 15:23:39 +0100
Message-ID: <CAP8UFD1qPTh_VX8ebazxoeEHRfNjmNwy-baat9Y+GVHrHWQqFA@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] ref-filter: make valid_atom as function parameter
To:     =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 12:49 PM, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=
=B5=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:
> 2018-01-18 9:20 GMT+03:00 =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=B5=D0=
=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com>:
>>
>> I think it's important to finish migrating process at first. I mean,
>> now we are preparing and collecting everything in ref-filter, but we
>> make resulting string and print still in cat-file. And I am not sure,
>> but maybe it will not be possible to start using new atoms in cat-file
>> while some part of logic still differs.
>
> I tried to make that part here:
> https://github.com/telezhnaya/git/commit/19a148614f1d4db1f8e628eb4e6d7c81=
9d2da875
> I know that the code is disgusting and there is a memory leak :) I
> just try to reuse ref-filter logic, I will cleanup everything later.
> At first, I try to make it work.
> The problem is that I have segfault, and if I use gdb, I get:
>
> Program received signal SIGSEGV, Segmentation fault.
> 0x0000000000000000 in ?? ()

Make sure that you compile with debug options like -g3. For example I use:

$ make -j 4 DEVELOPER=3D1 CFLAGS=3D"-g3"

> I tried to google it, it's my first time when I get that strange
> message, and unfortunately find nothing. So please explain me the
> reason, why I can't find a place of segfault that way.

I get the following:

(gdb) run cat-file --batch < myarg.txt
Starting program: /home/ubuntu/bin/git cat-file --batch < myarg.txt
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".

Program received signal SIGSEGV, Segmentation fault.
0x00005555556ea7cf in format_ref_array_item (info=3D0x7fffffffd460,
format=3D0x7fffffffd6e0,
    final_buf=3D0x7fffffffd410) at ref-filter.c:2234
2234                    atomv->handler(atomv, &state);
(gdb) bt
#0  0x00005555556ea7cf in format_ref_array_item (info=3D0x7fffffffd460,
    format=3D0x7fffffffd6e0, final_buf=3D0x7fffffffd410) at ref-filter.c:22=
34
#1  0x00005555556ea91c in show_ref_array_item (info=3D0x7fffffffd460,
format=3D0x7fffffffd6e0)
    at ref-filter.c:2256
#2  0x0000555555577ef7 in batch_object_write (
    obj_name=3D0x555555a66770 "5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689",
    opt=3D0x7fffffffd6e0, data=3D0x7fffffffd5e0) at builtin/cat-file.c:298
