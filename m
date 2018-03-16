Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BC9E1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 20:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeCPUOB (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 16:14:01 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:38352 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752625AbeCPUN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 16:13:59 -0400
Received: by mail-oi0-f49.google.com with SMTP id 20so2548792oiq.5
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 13:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/LWYP0PprUnEgBvKTPdixXZo0CVJ8CGcEYjdT/fsJZM=;
        b=rVduyUJ7mE+3px/5nBOg3RJvaqmXYD8pN2xHmyrRyt6woDgAK/Jq3fc3Bb5Tl6GgKb
         OCz65gKZpymRPzcYAkoVu9gS9UVDTR6ZqR0sq+R/1Cf3XqEp+35EEeXmiEUP5fNN57IN
         hrvlAr16Lg6Bi/Bb0O8EngD6WkvL+ieo/fRQbjq8DUxbE1Zsi4nF/WdugUQiW7JDdVV2
         m9Qi8zrSL0939agcq/4nR6PRPCp3WofMd5S77NoK1VHtx9/CsGMSh2WitlGZwL0pUn4y
         znbJ7tkoSzUr6PgbP/NbVVxW4Wy8ljyKJqdaFttHVaeR+NXdoysUWpjQ0iSiu5YyHjoy
         eTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/LWYP0PprUnEgBvKTPdixXZo0CVJ8CGcEYjdT/fsJZM=;
        b=bF212p14PQpii4ImbJM20ZxeAAo3jaIimjyj39yhI+dO9HdvtAqBBXkJvL+CnMM8vZ
         qBIuCLWN8MP7GDew1hIf3zNs28bD/JbnMrkKjvArx43BZKxT/vqmhB9nmMM7stFZMLW7
         qXi+HUd3cFYvz2BOQv//mOKxU55gvXC1X+IUXHudZ5QLrXPCVSvImGGnT7PNoX0YnpZs
         kNftKsfzWHbsjiJOsaUxq0razmzH28BapYA+mqdUP58Rhe660ceevuMFxwDvRczEgimc
         SCK2BoV6inyPKqYtBdCYXtePdd8CdtOaJWSdU7TApFx51GfTtjXx5Y+3XyrpCx29HoHi
         Afjg==
X-Gm-Message-State: AElRT7EOVsCDJVRFXFTZtFoy8VtJ8KqMJn3Z37deoHa2Esd40yJUiGn2
        yP0PdYJ5RWKtb6IqmUpCMrSU8ZZsdLeDQf5ODAM=
X-Google-Smtp-Source: AG47ELvxv5AFuxCmtlgE7RWJVa379Fy22iE4x+95dx8VB6/Bb8L9b9AO8Yt/5oKO0sz9+1J9/5fy9P0PYc/MgvRmr30=
X-Received: by 10.202.187.4 with SMTP id l4mr2065463oif.56.1521231239284; Fri,
 16 Mar 2018 13:13:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Fri, 16 Mar 2018 13:13:28 -0700 (PDT)
In-Reply-To: <CACsJy8BOR_YkUYONw0aofejTKuCaujRbfoea25xWMsHAT=OXuA@mail.gmail.com>
References: <20180301092046.2769-1-pclouds@gmail.com> <20180306104158.6541-1-pclouds@gmail.com>
 <20180306104158.6541-5-pclouds@gmail.com> <87d109qh51.fsf@evledraar.gmail.com>
 <CACsJy8BOR_YkUYONw0aofejTKuCaujRbfoea25xWMsHAT=OXuA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 16 Mar 2018 21:13:28 +0100
Message-ID: <CACsJy8C+-=z89D8V7kwPid=VG=qS_DD6yG4nhOxv=mEPN+dBow@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] pack-objects: show some progress when counting
 kept objects
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 16, 2018 at 8:14 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Mar 12, 2018 at 7:32 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Tue, Mar 06 2018, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy jotted:
>>
>>> We only show progress when there are new objects to be packed. But
>>> when --keep-pack is specified on the base pack, we will exclude most
>>> of objects. This makes 'pack-objects' stay silent for a long time
>>> while the counting phase is going.
>>>
>>> Let's show some progress whenever we visit an object instead. The
>>> number of packed objects will be shown after if it's not the same as
>>> the number of visited objects.
>>>
>>> Since the meaning of this number has changed, use another word instead
>>> of "Counting" to hint about the change.
>>
>> Can you elaborate on how the meaning has changed? With/without this on
>> linux.git I get:
>>
>> With:
>>
>>     Enumerating objects: 5901144, done.
>>     Getting object details: 100% (5901145/5901145), done.
>>     Delta compression using up to 8 threads.
>>
>> Without:
>>
>>     Counting objects: 5901145, done.
>>     Delta compression using up to 8 threads.
>>
>> So now we're seemingly off-by-one but otherwise doing the same thing?
>
> Yep, it's an off-by-one bug.
>
>> As for as user feedback goes we might as well have said "Reticulating
>> splines", but I have some bias towards keeping the current "Counting
>> objects..." phrasing. We ourselves have other docs referring to it that
>> aren't changed by this patch, and there's
>> e.g. https://githubengineering.com/counting-objects/ and lots of other
>> 3rd party docs that refer to this.
>
> This is why I changed the phrase. The counting is now a bit different.
> Documents describing this exact phrase won't apply to the new version.
>
> The old way counts objects that will be packed. The new way simply
> counts objects that are visited. When you keep some packs, the number
> of objects you visit but not pack could be very high, while in normal
> case the two numbers should be the same (e.g. you pack everything you
> visit). I would prefer to print both values (e.g. "counting objects:
> <packed>/<visited>") but it's not possible with the current progress
> code.

On second thought, maybe instead of introducing a new line "getting
object details" i could just rename that line to "counting objects"?
They are exactly the same, except that in the new version, this
"counting objects" line could run a lot faster than the old line.


--=20
Duy
