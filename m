Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8933E1F404
	for <e@80x24.org>; Sat, 24 Mar 2018 12:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752055AbeCXMON (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 08:14:13 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:45876 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751894AbeCXMOM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 08:14:12 -0400
Received: by mail-oi0-f51.google.com with SMTP id 71-v6so12475981oie.12
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 05:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fRASAAysNmWVz3OK5/mK2wcKMkjSnejQ5ssRsirIiLg=;
        b=Y9mfdSggDqeJM5klFrVB/IBh4duY0bCyWfU13oMPfDHX932/7r2OsAeTHrliYnF6LE
         fGy5UvIk8zRGU9XYMIu1JVf5jki0vLYFANIysLo8fwQOUN/LfDh1coUshH/o7HBGTb3b
         gCFUKmIxykPvyAwyAQCI8UpBgeHGUHKEInA1wwQvrhz4uldUJ/pqMGEeyWAxGfeL7VvX
         dskxk2sxVVCWBeiIVCHUUIAZUaeiI6NUJaQYHbmABZMB8sWpY7iLmY+bx2LZ3efZTOe7
         L3UZQ2VRlNq8gTbiyTFsEqcV044QaeMkcoip+aOiycRVTqmPwvXtlMtodFWj6hJgIwZu
         FBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fRASAAysNmWVz3OK5/mK2wcKMkjSnejQ5ssRsirIiLg=;
        b=PLXH354pU2w1oS1+upvKtyUJm6n74VzK9j3YG8Z+cVARQvwv49Q9RafcU9iSKe/q3c
         o+fadDpXpfROQb3DgUmasUu2wVoyVDtdS4Hndmay6aryVkOs9RSQRqmrszai1GrSBArK
         mNnChtNdO32nCWg3DBUfr8GxMrPNB/qkatHkXkaXCl1WKey79M45Z+LuCuXFNdxcEybP
         zW+/HAAmRu+jcJ+R8zC2/h2MQt1r0gxYgEqUWVood108k1xF2EtHiXjOqY0gcmaZmIN2
         bexD7tqLb7fPL0p0mN1wOnLBj5ELQ9VXzFza+SbMaIb9mcx3boFrROa2nfw7JAmJLei/
         k9kA==
X-Gm-Message-State: AElRT7Fh11IvUkYln5LyFJMnqUneqt/hToCCQitvFDAQVPRmUz3E0ogH
        pNGmhe5bo9abEyyXrrIO3xZUUY/SyPsrDM3Sd8I=
X-Google-Smtp-Source: AG47ELuBXnWkzaN/nWQLiJTWwhaWpM422++qLMiqJyNAlJ/kfbyYaisG6ZhWah1z7i8fjp3QyzDbfANhMV7/2VH19w4=
X-Received: by 10.202.206.13 with SMTP id e13mr19425188oig.34.1521893652153;
 Sat, 24 Mar 2018 05:14:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Sat, 24 Mar 2018 05:13:41 -0700 (PDT)
In-Reply-To: <87fu4pyfvr.fsf@evledraar.gmail.com>
References: <20180317075421.22032-1-pclouds@gmail.com> <20180324074308.18934-1-pclouds@gmail.com>
 <20180324074308.18934-6-pclouds@gmail.com> <87fu4pyfvr.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 24 Mar 2018 13:13:41 +0100
Message-ID: <CACsJy8CvgAHcB6uKgN=aULST0CkmPeCXLZcM_LZcXv9S9rEWPg@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] gc: add --keep-largest-pack option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 10:36 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Sat, Mar 24 2018, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>>       struct option builtin_gc_options[] =3D {
>>               OPT__QUIET(&quiet, N_("suppress progress reporting")),
>> @@ -362,6 +390,8 @@ int cmd_gc(int argc, const char **argv, const char *=
prefix)
>>               OPT_BOOL(0, "aggressive", &aggressive, N_("be more thoroug=
h (increased runtime)")),
>>               OPT_BOOL(0, "auto", &auto_gc, N_("enable auto-gc mode")),
>>               OPT_BOOL(0, "force", &force, N_("force running gc even if =
there may be another gc running")),
>> +             OPT_BOOL(0, "keep-largest-pack", &keep_base_pack,
>> +                      N_("repack all other packs except the largest pac=
k")),
>>               OPT_END()
>>       };
>
> This conflicts with master because of your own 7e1eeaa431 ("completion:
> use __gitcomp_builtin in _git_gc", 2018-02-09). I pushed out a
> avar-pclouds/gc-auto-keep-base-pack branch to github.com/avar/git which
> resolves it as:
>
>     @@ -365,6 +393,8 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
>                     OPT_BOOL_F(0, "force", &force,
>                                N_("force running gc even if there may be =
another gc running"),
>                                PARSE_OPT_NOCOMPLETE),
>     +               OPT_BOOL(0, "keep-largest-pack", &keep_base_pack,
>     +                        N_("repack all other packs except the larges=
t pack")),
>                     OPT_END()
>             };
>
> I assume that's the intention here.

Yeah, I want  to keep the same base for easy interdiff. There are
worse conflicts are with the other series I'm helping Stefan.
--=20
Duy
