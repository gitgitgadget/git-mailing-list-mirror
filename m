Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B869B1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 12:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754855AbeASMYx (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 07:24:53 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:34322 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754796AbeASMYw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 07:24:52 -0500
Received: by mail-qt0-f177.google.com with SMTP id 33so3330896qtv.1
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 04:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s70XN6ILkmhNwYwp2x+obBMbVZhrYngyHdOunHL8WyE=;
        b=p9yKkW6Y7rkzg2mDbnMjZxNUduGd86qHPzNtUWUsCW/EAJLaM4Bj2UpVMMjDOX4PdT
         KLlDrjuVSlNRCWjAPnibF8Ean+KlnVmDejA4PdvNbQvfYR2JavOtMKF74C1YUd7I8LiF
         M0IhifrkpVEWyvK54qEZZzO/A7R1ELhc7iCt+oXsbMtIWCGBIPxF46kDiOJOuzTWlHYp
         3klWvdBbIT7JmYrzt8Z+Di8xVXPq8qjkTIr1t+YvqIdtudWSibhnDDqthukKCvW0AfpI
         AYwC1zZlwkALoBJrL9gSYANvLTnm7cIeK5pIjjFFDmQFEadeClYn+buXGp8ySZ2fpkE8
         zk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s70XN6ILkmhNwYwp2x+obBMbVZhrYngyHdOunHL8WyE=;
        b=mfBqtji2X5ltMv/Pk1yd116yfXdDmg0+ptWBjH5bZvJ3ar3vKrOkkcyjpja2f1ZkZu
         mMZ7ioaIh2bxC+y+Q8X4RziC6H5MKbiPGDh/py4TZWaznX43yiJGFZc2SAQ6q8ZqN2rp
         cLJ2aFlBX1OBy47rzBld6Glk15sEN8d8QHhZzvwMGFPfPSR6uax8va/X9SLM21Rhm47a
         vI5lLhuQf8ej5h0jO09SxV1KfT5o6c3FdtbA8TPoexHAmim10V3++TSZF4sJ8yWU3V6M
         gUcLWNUEAP/HtFn56kGTjsx9qsOUXVpPMhuiB2RKO3jQOGpyNS/n9n7ERReLrF0VZSQP
         cKAg==
X-Gm-Message-State: AKwxyteTt3qXsO39CsvWPDa8ppYsvpnAURusytKYzOv5zSxaiMrEOOZT
        m6x6TJEcsAZTKUxI8VhauQVJbHF+NyLzmf7siYM=
X-Google-Smtp-Source: ACJfBos1mmd280TR4Ow6mSLusL7T1XHlq+rWUt/6CTzYqQ/Hkr1TJXlbzmo1SKiGMp8YX4BQCYQYDVUumaAdN/ooTLo=
X-Received: by 10.55.112.132 with SMTP id l126mr16856328qkc.296.1516364691401;
 Fri, 19 Jan 2018 04:24:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.28.54 with HTTP; Fri, 19 Jan 2018 04:24:50 -0800 (PST)
In-Reply-To: <CAP8UFD1qPTh_VX8ebazxoeEHRfNjmNwy-baat9Y+GVHrHWQqFA@mail.gmail.com>
References: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
 <01020160df6dc529-fae54bd6-e595-44fa-9f9a-c44cb3a5a1a8-000000@eu-west-1.amazonses.com>
 <20180115214208.GD4778@sigill.intra.peff.net> <CAL21Bm=+uPrKECcCq2_rfJRuCpsOjZ41NfiyY3d1UA0b8YKj1w@mail.gmail.com>
 <20180117214354.GA13128@sigill.intra.peff.net> <CAP8UFD0PtOqX5c4ovRbYDWejQ55iUwtnPv-zGXS2GFAajhXqtA@mail.gmail.com>
 <CAL21BmnKd0qamJWJbrAzg_ZX1GkhCTPO_5zOiFNMBeF-xjDTiQ@mail.gmail.com>
 <CAL21BmneJ4rgCtf8t8LOK=gVv0MR+xam9jFBp7kp33rqEG7f6Q@mail.gmail.com> <CAP8UFD1qPTh_VX8ebazxoeEHRfNjmNwy-baat9Y+GVHrHWQqFA@mail.gmail.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Fri, 19 Jan 2018 15:24:50 +0300
Message-ID: <CAL21Bmnv24tc7H5w4Nm=TfYjVEYB=ykZ3iv_0JtUMODCKCwQzw@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] ref-filter: make valid_atom as function parameter
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-01-18 17:23 GMT+03:00 Christian Couder <christian.couder@gmail.com>:
> On Thu, Jan 18, 2018 at 12:49 PM, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=
=D0=B5=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:
>> 2018-01-18 9:20 GMT+03:00 =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=B5=D0=
=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com>:
>>>
>>> I think it's important to finish migrating process at first. I mean,
>>> now we are preparing and collecting everything in ref-filter, but we
>>> make resulting string and print still in cat-file. And I am not sure,
>>> but maybe it will not be possible to start using new atoms in cat-file
>>> while some part of logic still differs.
>>
>> I tried to make that part here:
>> https://github.com/telezhnaya/git/commit/19a148614f1d4db1f8e628eb4e6d7c8=
19d2da875
>> I know that the code is disgusting and there is a memory leak :) I
>> just try to reuse ref-filter logic, I will cleanup everything later.
>> At first, I try to make it work.
>> The problem is that I have segfault, and if I use gdb, I get:
>>
>> Program received signal SIGSEGV, Segmentation fault.
>> 0x0000000000000000 in ?? ()
>
> Make sure that you compile with debug options like -g3. For example I use=
:
>
> $ make -j 4 DEVELOPER=3D1 CFLAGS=3D"-g3"

Is it OK that I get different test results with simple make and with
make with all that flags?
Have a code: https://github.com/telezhnaya/git/commits/catfile
I do:

olya@ubuntu17-vm:~/git$ make install
olya@ubuntu17-vm:~/git$ cd t
olya@ubuntu17-vm:~/git/t$ ./t1006-cat-file.sh

And I have 17 tests broken.
Then, without any changes in code, I do:

olya@ubuntu17-vm:~/git$ make -j 4 DEVELOPER=3D1 CFLAGS=3D"-g3" install
olya@ubuntu17-vm:~/git$ cd t
olya@ubuntu17-vm:~/git/t$ ./t1006-cat-file.sh

And there is 42 tests broken.
And it's really hard to search for errors in such situation.

>
>> I tried to google it, it's my first time when I get that strange
>> message, and unfortunately find nothing. So please explain me the
>> reason, why I can't find a place of segfault that way.
>
> I get the following:
>
> (gdb) run cat-file --batch < myarg.txt
> Starting program: /home/ubuntu/bin/git cat-file --batch < myarg.txt
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1"=
.
>
> Program received signal SIGSEGV, Segmentation fault.
> 0x00005555556ea7cf in format_ref_array_item (info=3D0x7fffffffd460,
> format=3D0x7fffffffd6e0,
>     final_buf=3D0x7fffffffd410) at ref-filter.c:2234
> 2234                    atomv->handler(atomv, &state);
> (gdb) bt
> #0  0x00005555556ea7cf in format_ref_array_item (info=3D0x7fffffffd460,
>     format=3D0x7fffffffd6e0, final_buf=3D0x7fffffffd410) at ref-filter.c:=
2234
> #1  0x00005555556ea91c in show_ref_array_item (info=3D0x7fffffffd460,
> format=3D0x7fffffffd6e0)
>     at ref-filter.c:2256
> #2  0x0000555555577ef7 in batch_object_write (
>     obj_name=3D0x555555a66770 "5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689",
>     opt=3D0x7fffffffd6e0, data=3D0x7fffffffd5e0) at builtin/cat-file.c:29=
8
