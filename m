Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D06AE1F424
	for <e@80x24.org>; Fri, 20 Apr 2018 10:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754677AbeDTKyi (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 06:54:38 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42077 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754511AbeDTKyh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 06:54:37 -0400
Received: by mail-pl0-f68.google.com with SMTP id t20-v6so5059785ply.9
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 03:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yspUiynC4brGXyIIUONYOd258PHUikhwz9owInVLc28=;
        b=oqkV8VHGuExdd5RV3EyBQ3OvCZ5tqRtvXU08BKa3Ds+Rsy3pt8FVFpY1TkE9zAUV5z
         JuvrtPruKGPNvm1eP2j4PZCmSlyVT8RcaT8rIJaWJITKWNNLwuBD7yPJf6LeomYuoVT+
         kT5i235ZMz9mrews7nLp8FFcbevIfu8507kvMlU9n/D2pLumAt7bxoE2lGWIJEfom5hg
         qtvGTHgTFzhf6OsyYalDRaHeEqLMSfAadFSFU86O3iOuwxZWXAhsRtKqYDhjbYn+8lg3
         lWOqjlfMWbJsSyFrV6mPjuYyvL5ut3zheREhxQMMDGcIt0FhLjNCnMfmeRNa/50NRddd
         vXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yspUiynC4brGXyIIUONYOd258PHUikhwz9owInVLc28=;
        b=YWDNuo7ZxJrmhNgGWZfCjZU4HLB9LOASWDbVLHLu1tX9dSQLsay8lF10Ne4KkMebzY
         M5EKp3xu75gu3R1X7ZwxzwWXxaP2XQnaOIWxwQE0LBXSDonrItBb0IzYX09xZoWwawuM
         qly2ul08sVtlf1vtJKETaTzxonqwLOhG5n2q/yVIbZaekfhdg0soXHAlqUACB6wnEpxP
         XacpKqV3SVcOjxiq5niU2PZ69tIbjKEzKNin5oz3Y+/c55YCdBd6oczshn0bukjkbzjB
         asQPcLkxwrRkEXzdhnkziQAIuIYqXARlCZLZF9QIxKdD4pDlz/wMVoiPXeoQ3hP5A0Mh
         UhIQ==
X-Gm-Message-State: ALQs6tAVSxHp5dPD56fq5u+E/bn5xlcOCOGnhmZKp6/60S0dtWmIU8JG
        HczHzVm451NRVXo71sazPVfHhaZx+v4ensqChCE=
X-Google-Smtp-Source: AIpwx4/Qwz7qqX76JoOdNMTp5aSZdYfMW2kHodF480heaToKmo78pulsZL/SkEht82aRSy0JB0tI2gINJV7fvOqVmwY=
X-Received: by 2002:a17:902:b94c:: with SMTP id h12-v6mr9993452pls.321.1524221676916;
 Fri, 20 Apr 2018 03:54:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.150.4 with HTTP; Fri, 20 Apr 2018 03:54:35 -0700 (PDT)
In-Reply-To: <87o9iedwqn.fsf@evledraar.gmail.com>
References: <cover.1524211375.git.johannes.schindelin@gmx.de>
 <6be8678b7d6b4d9116ea4666a0b28ff4dd938690.1524211375.git.johannes.schindelin@gmx.de>
 <87o9iedwqn.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 20 Apr 2018 12:54:35 +0200
Message-ID: <CAN0heSpda1ZnFXgoCEgxGdBk-JYUSPAV0A=mQYMtOq7w8x+5=w@mail.gmail.com>
Subject: Re: [PATCH 1/3] gettext: avoid initialization if the locale dir is
 not present
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Dan Jacques <dnj@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20 April 2018 at 11:59, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com> wrote:
>
> On Fri, Apr 20 2018, Johannes Schindelin wrote:
>
>> The runtime of a simple `git.exe version` call on Windows is currently
>> dominated by the gettext setup, adding a whopping ~150ms to the ~210ms
>> total.
>>
>> Given that this cost is added to each and every git.exe invocation goes
>> through common-main's invocation of git_setup_gettext(), and given that
>> scripts have to call git.exe dozens, if not hundreds, of times, this is
>> a substantial performance penalty.
>>
>> This is particularly pointless when considering that Git for Windows
>> ships without localization (to keep the installer's size to a bearable
>> ~34MB): all that time setting up gettext is for naught.
>>
>> So let's be smart about it and skip setting up gettext if the locale
>> directory is not even present.

> If you don't ship git for windows with gettext or a podir, then compile
> with NO_GETTEXT, then we won't even compile this function you're
> patching here. See line 30 and beyond of gettext.h.
>
> Are you instead compiling git for windows with gettext support with an
> optional add-on package for i18n, so then this podir conditional would
> pass?
>
> In any case, if this is actually the desired behavior I think it's worth
> clearly explaining the interaction with NO_GETTEXT in the commit
> message, and if you *actually* don't want NO_GETTEXT I think it's useful
> to guard this with something like MAYBE_GETTEXT on top, so this code
> doesn't unintentionally hide installation errors on other
> platforms. I.e. something like:
>
>         int have_podir =3D is_directory(podir);
>         if (!have_podir)
> #ifdef MAYBE_GETTEXT
>                 return;
> #else
>                 BUG("Broken installation, can't find '%s'!", podir);
> #endif

Is it fair to say that such a broken installation would function more or
less well before and after Dscho's patch, and that your approach would
render such an installation quite useless? Do we have some other similar
cases where we go BUG("I could not find a resource. I could manage
fairly well without it, but you seemed to want it when you installed
me.")? I wonder what other well-respected software do if they can't find
their translations.

I suppose the logic could be the other way round, i.e., with a flag
REALLY_REQUIRE_GETTEXT_AT_RUNTIME. But I also wonder if a user who does
not notice that the installation is broken without us screaming BUG in
their face, really minds the "brokenness" that much.

Disclaimer: I do not use translated Git, nor other non-English-language
software.

Martin
