Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 551E61F404
	for <e@80x24.org>; Mon,  9 Apr 2018 15:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752908AbeDIPP5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 11:15:57 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:38525 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbeDIPP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 11:15:57 -0400
Received: by mail-oi0-f42.google.com with SMTP id c3-v6so7964882oib.5
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 08:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cvm00EvE1b2gEDZL/yVdxCGaaW3Acyn6x+Qu5b2kuLg=;
        b=DpuVenD5/Ieg9gquqzDp69yFAqxoEr9drcd6YZsvfx6Q0e2v7x0zfgYhqU18vN0DCL
         AO6mOi5Kd5YDDn3wc+x5DMbsXtqLDyNlkIi99Ig9TnSW0HxVAbZVCqZIPMAuhlqAkPX6
         ZnCW+JYyXqk4HMvGnVuqWG+2wubMuzE5WOKKyEtbOzvbvFMuTQ/mrrbr2XQkPcR94NCD
         G/vxJ60s9NYvpFAEyPFrOXZkzKRKXhXa0eTj1l+IezjFBlNit9uGOcf1phuFe+Ar4nut
         dFb1dggnnUFgiO/7PeNHcxng4aVQMurHTyqpwIToevUxQkFRscHqMHUBPA0voS7cEiMN
         NVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cvm00EvE1b2gEDZL/yVdxCGaaW3Acyn6x+Qu5b2kuLg=;
        b=ryyjp1sDfFirQsmfrXbHNWAnOyqk8BnpHD6+s+B/+EXDHufUUAkADMyozBYc4pthQS
         Aj01TSAnEal0s83eTdx5l/XQl5vzz3T7HphKjhTGJrYNf4CgRgnYd5nGQ3fTRz4WLUCS
         egqgaDGYVYHGw3XMoYyrW0VIkOTPCiTjLspxxm+/ZVOh1No+ovEwrAaCME+PYKfec/EJ
         FytZjm2eNUIVBZsw2a+3QV1Uov92uMlMXm9ALBz4ntMOhOIAr+OmzDpT38DLKzMwi0M1
         OxFhXpL1FBR30VZh3jdE2gvvU1VhMxJdLNJXAwLZZlb25XPlQQyYmlu/QnxT5z5NBg+F
         Kb/Q==
X-Gm-Message-State: ALQs6tDrYkwYclheiTcaFO2h2ZPyzwczWCzawi7fYjA3g1eOeYDrVIo1
        6ZJQN8Xwj6Rxs6Lksdk8EqIix9tAcLsvO1bBb+Q=
X-Google-Smtp-Source: AIpwx4/CedvI09aJ1MDX2rbe5uCBmfeZodIawYw660vDNgOkJrmFcL++GnZwZc2kl5aJfw/8HiF1lRh0Gblzq2wbCyM=
X-Received: by 2002:aca:1002:: with SMTP id 2-v6mr1449480oiq.30.1523286956423;
 Mon, 09 Apr 2018 08:15:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Mon, 9 Apr 2018 08:15:02 -0700 (PDT)
In-Reply-To: <CAPig+cSwDpWOz2_PAZOCmdhoYXYhYR0fHsw8POgNDfd9nD2Q1A@mail.gmail.com>
References: <20180326165520.802-1-pclouds@gmail.com> <20180326165520.802-6-pclouds@gmail.com>
 <CAPig+cR-WP5z1u-9KG-mNOF0mEUcguMET93O21nfzYixEFWaYw@mail.gmail.com>
 <xmqqh8ok679l.fsf@gitster-ct.c.googlers.com> <CAPig+cSwDpWOz2_PAZOCmdhoYXYhYR0fHsw8POgNDfd9nD2Q1A@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 9 Apr 2018 17:15:02 +0200
Message-ID: <CACsJy8Dk5vBn+xY25PiTFvre_8HoveZ2eGSD8HOPmonGW99+8w@mail.gmail.com>
Subject: Re: [PATCH/RFC 5/5] help: add "-a --verbose" to list all commands
 with synopsis
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 9, 2018 at 11:55 AM, Eric Sunshine <sunshine@sunshineco.com> wr=
ote:
> On Mon, Apr 9, 2018 at 5:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>> On Mon, Mar 26, 2018 at 12:55 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy
>>> <pclouds@gmail.com> wrote:
>>>> +       switch (category) {
>>>> +       case CAT_ancillaryinterrogators: return _("Ancillary interroga=
tors");
>>>> +       case CAT_ancillarymanipulators: return _("Ancillary manipulato=
rs");
>>>> +       case CAT_foreignscminterface: return _("Foreign SCM interface"=
);
>>>> +       case CAT_mainporcelain: return _("Main porcelain");
>>>> +       case CAT_plumbinginterrogators: return _("Plumbing interrogato=
rs");
>>>> +       case CAT_plumbingmanipulators: return _("Plumbing interrogator=
s");
>>>
>>> s/interrogators"/manipulators"/
>>>
>>>> +       case CAT_purehelpers: return _("Pure helpers");
>>>> +       case CAT_synchelpers: return _("Sync helpers");
>>>> +       case CAT_synchingrepositories: return _("Synching repositories=
");
>>
>> Somehow this screams "an array of strings" at me.  Aren't this
>> CAT_things small and dense enum?
>
> Duy's modified generate-cmdlist.sh does actually output an array of
> strings for these, but the (generated) array is commented out in this
> RFC. I suppose the reason it's not presently used is because the array
> looks like this:
>
> static const char *cmd_categories[] =3D {
>     "ancillaryinterrogators",
>     "ancillarymanipulators",
>     "foreignscminterface",
>     "mainporcelain",
>     "plumbinginterrogators",
>     "plumbingmanipulators",
>     "purehelpers",
>     "synchelpers",
>     "synchingrepositories",
>      NULL
> };
>
> which doesn't give quite the human-friendly output he'd like. The
> series is RFC, after all.

Yep.

> A possible approach to fix it would be to add a new "### categories"
> section to command-list.txt which associates those category tags
> ("ancillaryinterrogators") with human-readable counterparts
> ("Ancillary interrogators").

Or extract the headlines from git.txt but that's not easy since it's
not consistent. We could manually recreate the same grouping as in
git.txt too, it's probably nicer than just printing groups sorted by
category id.
--=20
Duy
