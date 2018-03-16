Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DBCD1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 19:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753195AbeCPTOu (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 15:14:50 -0400
Received: from mail-ot0-f169.google.com ([74.125.82.169]:45520 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752430AbeCPTOs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 15:14:48 -0400
Received: by mail-ot0-f169.google.com with SMTP id q5-v6so776716oth.12
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 12:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3/3112mCvwZCBcwURSfVwGAf8jl2Cn00THCkZ5PcKg4=;
        b=aTsI2CrkFBK5t4RNyZmtgSP04CBcJH9spujgsXkOA6TherQHWuFct3w1g/kdKV2o/T
         v8LYxb5tVdlFJMsM8v/s8czGpzQvcv9Jm8WSU6yc/4F9aup9VwRtRbYLo3bKOrO7ct4G
         XMBA4+33UONrh2aHAPs613/c5mUtD/GQ0gAXZ0kbefOs269HV9n0U+jfT7Dt7Usc7Dol
         h+/HHZ+E3/XrAVPa+8mq/5KWLKEKlXcgaN6hJLUCWbQYbs1UtL8ggaTm3GXBXEgkfEns
         MjrJkLSUkEeCKrTJHdyOSyPGvs2H3yf1oXECxGzsKSjL5AhVkig6UCfL8xWQCaPtjZy2
         K2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3/3112mCvwZCBcwURSfVwGAf8jl2Cn00THCkZ5PcKg4=;
        b=F9E0Z5p9t07y9tiXK4bfzKLZEsKnSCpHYxRn0YSvO1D+vF8zKmyg+PDiYSKQNID04Z
         jlPRzSEIF3EK2WOderL/D9wQScNoVy1HuH/c6IzZgN+W1Jbr83EWJGyHW/4FmSeHBG0G
         6Usrc7G+NtfdqonooQ9LuOwe6gFxcIVy9WAtloYJt9zytYgXV7To0SAEuE8uCdlzIRL3
         mvO77m0w2TtagIcXAmeOjlbrkFPuVktgzHm5XjkxxL5ofW0+0iqEcRfd0ygeq6GczZ1U
         tgaBjnVwB2KGjcqB7ggwyUqTCibzkizPsOaloWs9E9AhNDVVc3boFOS/4bELqHFWXhjo
         8T8A==
X-Gm-Message-State: AElRT7FhgYIMrV88yzxqqIyHR8yK3pKjOdCPkO3ZloIOo/PF5R4Y5ti+
        I3/6cmuSqW2YtFt+0ArDBB1VY0Nl98uqWSY3doo=
X-Google-Smtp-Source: AG47ELu9RZlnWegBwx+1p/2Ggwij/xrIDpBuo+TA1UlYmUfG0RrsMuR6DjIH6qMRLa/JkDuFZVk4PbHEJIdkRZubgzI=
X-Received: by 2002:a9d:266a:: with SMTP id a97-v6mr2074185otb.14.1521227688118;
 Fri, 16 Mar 2018 12:14:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Fri, 16 Mar 2018 12:14:17 -0700 (PDT)
In-Reply-To: <87d109qh51.fsf@evledraar.gmail.com>
References: <20180301092046.2769-1-pclouds@gmail.com> <20180306104158.6541-1-pclouds@gmail.com>
 <20180306104158.6541-5-pclouds@gmail.com> <87d109qh51.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 16 Mar 2018 20:14:17 +0100
Message-ID: <CACsJy8BOR_YkUYONw0aofejTKuCaujRbfoea25xWMsHAT=OXuA@mail.gmail.com>
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

On Mon, Mar 12, 2018 at 7:32 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Tue, Mar 06 2018, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy jotted:
>
>> We only show progress when there are new objects to be packed. But
>> when --keep-pack is specified on the base pack, we will exclude most
>> of objects. This makes 'pack-objects' stay silent for a long time
>> while the counting phase is going.
>>
>> Let's show some progress whenever we visit an object instead. The
>> number of packed objects will be shown after if it's not the same as
>> the number of visited objects.
>>
>> Since the meaning of this number has changed, use another word instead
>> of "Counting" to hint about the change.
>
> Can you elaborate on how the meaning has changed? With/without this on
> linux.git I get:
>
> With:
>
>     Enumerating objects: 5901144, done.
>     Getting object details: 100% (5901145/5901145), done.
>     Delta compression using up to 8 threads.
>
> Without:
>
>     Counting objects: 5901145, done.
>     Delta compression using up to 8 threads.
>
> So now we're seemingly off-by-one but otherwise doing the same thing?

Yep, it's an off-by-one bug.

> As for as user feedback goes we might as well have said "Reticulating
> splines", but I have some bias towards keeping the current "Counting
> objects..." phrasing. We ourselves have other docs referring to it that
> aren't changed by this patch, and there's
> e.g. https://githubengineering.com/counting-objects/ and lots of other
> 3rd party docs that refer to this.

This is why I changed the phrase. The counting is now a bit different.
Documents describing this exact phrase won't apply to the new version.

The old way counts objects that will be packed. The new way simply
counts objects that are visited. When you keep some packs, the number
of objects you visit but not pack could be very high, while in normal
case the two numbers should be the same (e.g. you pack everything you
visit). I would prefer to print both values (e.g. "counting objects:
<packed>/<visited>") but it's not possible with the current progress
code.
--=20
Duy
