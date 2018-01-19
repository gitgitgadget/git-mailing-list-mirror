Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D9E01F404
	for <e@80x24.org>; Fri, 19 Jan 2018 15:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755847AbeASPtN (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 10:49:13 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:34008 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755581AbeASPtA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 10:49:00 -0500
Received: by mail-io0-f179.google.com with SMTP id c17so2611245iod.1
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 07:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LRZr8kaRnloiqVatFUdT1RgpXt/k6e5I3/3BzAIJz3M=;
        b=uehBd2LgT4mwY+D8a8vd8N8nva1PGmJV2FAdoRrUARgWav7AjBKHr2MdK/DPxFqhpY
         qPgpUoBCpim8jLNZgz7xP0uLIkc750FCZqK+ALjgTy2v66IVb3oF13yQAWoMustZiuPN
         /7SDFI/SBThIgBRtuho2/EfQyMnR5giDnT7dkwHLpzI2JyLNrt0y0lYZFqdDmZ35ZSTM
         /zx0Ftq2LMXu+cIfPzl/mWIYvnIXcoiGotMnTwiDSpVgAjh/C5Tg1yS2fcnCmFEzhLlo
         wPmE+18Rs+9bCju4z+sgcyQdJ0enk+i4oDWGLcVKj/LcWdMf2B0r1E3vQrUE3H5IXw9H
         mAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LRZr8kaRnloiqVatFUdT1RgpXt/k6e5I3/3BzAIJz3M=;
        b=uRaTyka2buVgD1VIIXdxnJkUBzsIdox2eL8wmrgPOTHrO6xjZmQ2/xakXOz/Uql7Ma
         3F3AZriTREIegXaWOpO7shPFWf0nKsOWdPKbui2r0bshKLdTYff7tVHDZlUtPa3mPZRj
         eT968LXObNKWGgfwLVQRLneuzmdGm0AZSY/h3AuHYBFZQxf1u5PLkHy1ohLN5m4B3bdU
         JWMTWAVowPVlhiUkAYBJnS5oiXqTa+upLa3w8MNmcfI7331fYlS+55Q6fvbLpNzN3d4e
         3HWF9OQNmlUdco6ENBp1IwXRZbhcintwQqxZ6QIqA3ZvL3mJMOi76Uer6b067nK0WvsP
         ZiwQ==
X-Gm-Message-State: AKwxytcssqEf6+wUEINSHFyL3nHioqqa2V1YzIBvroIyiOTQRQ5Gbj43
        Dg1a/ETk9AsmhKwuAUPkRJYacG+3t16pfDIvWD0=
X-Google-Smtp-Source: ACJfBovF2oLskMdAzo4+NdEGxA5q5Z6lqhgs1FatHhSBqg5ib0OPXKDwLlXY/yZeryx031Fs1TrMUtLqdl/H5ntZ8os=
X-Received: by 10.107.17.37 with SMTP id z37mr16541761ioi.282.1516376939292;
 Fri, 19 Jan 2018 07:48:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.201.204 with HTTP; Fri, 19 Jan 2018 07:48:58 -0800 (PST)
In-Reply-To: <CAL21Bmnv24tc7H5w4Nm=TfYjVEYB=ykZ3iv_0JtUMODCKCwQzw@mail.gmail.com>
References: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
 <01020160df6dc529-fae54bd6-e595-44fa-9f9a-c44cb3a5a1a8-000000@eu-west-1.amazonses.com>
 <20180115214208.GD4778@sigill.intra.peff.net> <CAL21Bm=+uPrKECcCq2_rfJRuCpsOjZ41NfiyY3d1UA0b8YKj1w@mail.gmail.com>
 <20180117214354.GA13128@sigill.intra.peff.net> <CAP8UFD0PtOqX5c4ovRbYDWejQ55iUwtnPv-zGXS2GFAajhXqtA@mail.gmail.com>
 <CAL21BmnKd0qamJWJbrAzg_ZX1GkhCTPO_5zOiFNMBeF-xjDTiQ@mail.gmail.com>
 <CAL21BmneJ4rgCtf8t8LOK=gVv0MR+xam9jFBp7kp33rqEG7f6Q@mail.gmail.com>
 <CAP8UFD1qPTh_VX8ebazxoeEHRfNjmNwy-baat9Y+GVHrHWQqFA@mail.gmail.com> <CAL21Bmnv24tc7H5w4Nm=TfYjVEYB=ykZ3iv_0JtUMODCKCwQzw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 19 Jan 2018 16:48:58 +0100
Message-ID: <CAP8UFD21JcERHDZz_TVX9nuw+vfE=ra19hC50fRKdMxL_5bxOg@mail.gmail.com>
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

On Fri, Jan 19, 2018 at 1:24 PM, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=
=B5=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:
> 2018-01-18 17:23 GMT+03:00 Christian Couder <christian.couder@gmail.com>:
>> On Thu, Jan 18, 2018 at 12:49 PM, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=
=D0=B5=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:
>>> 2018-01-18 9:20 GMT+03:00 =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=B5=
=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com>:
>>>>
>>>> I think it's important to finish migrating process at first. I mean,
>>>> now we are preparing and collecting everything in ref-filter, but we
>>>> make resulting string and print still in cat-file. And I am not sure,
>>>> but maybe it will not be possible to start using new atoms in cat-file
>>>> while some part of logic still differs.
>>>
>>> I tried to make that part here:
>>> https://github.com/telezhnaya/git/commit/19a148614f1d4db1f8e628eb4e6d7c=
819d2da875
>>> I know that the code is disgusting and there is a memory leak :) I
>>> just try to reuse ref-filter logic, I will cleanup everything later.
>>> At first, I try to make it work.
>>> The problem is that I have segfault, and if I use gdb, I get:
>>>
>>> Program received signal SIGSEGV, Segmentation fault.
>>> 0x0000000000000000 in ?? ()
>>
>> Make sure that you compile with debug options like -g3. For example I us=
e:
>>
>> $ make -j 4 DEVELOPER=3D1 CFLAGS=3D"-g3"
>
> Is it OK that I get different test results with simple make and with
> make with all that flags?
> Have a code: https://github.com/telezhnaya/git/commits/catfile
> I do:
>
> olya@ubuntu17-vm:~/git$ make install
> olya@ubuntu17-vm:~/git$ cd t
> olya@ubuntu17-vm:~/git/t$ ./t1006-cat-file.sh
>
> And I have 17 tests broken.
> Then, without any changes in code, I do:
>
> olya@ubuntu17-vm:~/git$ make -j 4 DEVELOPER=3D1 CFLAGS=3D"-g3" install
> olya@ubuntu17-vm:~/git$ cd t
> olya@ubuntu17-vm:~/git/t$ ./t1006-cat-file.sh
>
> And there is 42 tests broken.
> And it's really hard to search for errors in such situation.

Some segfaults and other memory issues might happen or not happen
depending on how the code has been compiled. I think that if you fix
all the memory related issues, the behavior should be the same.
