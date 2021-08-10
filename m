Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B538DC4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 19:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 988F3604D7
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 19:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbhHJTbF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 15:31:05 -0400
Received: from mout.web.de ([217.72.192.78]:47293 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231143AbhHJTbF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 15:31:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1628623835;
        bh=fJustJ7lGrDBang3tr3yCwB1479Uk9u2eYsxyoH32+U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=M4rXzJOZ+BxEWt8SHYaWoJIKbg5KeI/Ta622G+GoqxiMzUdGCCS4Wb1ET9ybtS4qH
         E4rSg5q8SYgXKrzEHflJVgNIX7aWrKc9j3+sjNsou6eTcym3IFVI+420mhI5p8nJaQ
         Htbs4T65AqCdDGGiZgaYargtSrqy1XfNII9evoq4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.27.185]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MThAi-1mdu0p0YBk-00QQv1; Tue, 10 Aug 2021 21:30:35 +0200
Subject: Re: [PATCH/RFC 0/3] pedantic errors in next
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, e@80x24.org
References: <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
 <20210809013833.58110-1-carenas@gmail.com> <xmqqtujyftzx.fsf@gitster.g>
 <YRIZsOaguDW0HaeI@carlos-mbp.lan>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <0b973579-748e-ce2f-20aa-a967765cce83@web.de>
Date:   Tue, 10 Aug 2021 21:30:34 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YRIZsOaguDW0HaeI@carlos-mbp.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NcdnTQVF0ze7nC8T7sY4mB4v2JsD1ZBSqLxgufujoFv9UlOldYO
 mlfhbrlIqU8CEnTAsDf7TObwWaF3slRBfxmnrOdTAc0+jm/USo6Wmdd5AjTpn9aBn0xd4HF
 P1Ul2Y7zn+LssFyp0OT6MF+ojW5dGOPEWkQwGlU2oIVCVnEsCIlnpkZOI8IzMwgMWFrgiUM
 +WEZtsmiHkkaKol/2HbLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XBLm0lswfws=:ONrsSnVqQRqwjQm7po40Lp
 jFHSDFO/3cFyHJt3n62hu+ciN4IK1ZbZ3+5UtGMAJwgQaXN+xGnu0Xwgz2SQRWjAU/909zfLc
 4z+F7STwt+4ptgwzgkWjbJ3C2ztFeRljbob/uCkF5o7pmznT1gF0JYOXLPTJVesykBmcL85G4
 emLHMiQ2mcO7grSD5OGBKTyOxR1AOTg52hA1omqwFwyE9tqOo7SIxf53uBtJVEwH9s7je9hHB
 R97kQvlQ8mIFlRXGtBMxqo3gE88oPFLL8Ui1T71TcgK5IciaR6Vm32e+4qceBlJSO+W3aFRep
 82SMnNgHpXyk+yHUFIsTyF7upbox7oLhg7SfiamA0pQzDNuozb3V83wV9nsJRXcryPCvhO54R
 894N8Z9aqQc5YQidzsfNOrEyYzd6o5y9qDiN14lufllW7L4y9Cp3dnwVIWzx7bt3VljMpn3Wo
 FBH6H6p2f8Z5pyPTSVOX0f6HFyJe08Qt2xfZeGZTcZDlGgEfr7v2tG09yrT3ank8j0HXY/9LX
 A8PaaAhF+kYopA46RIjselP5EnIu1Eegsd3qXN+0co26XuqOFFR30M4uYhg/5SIT4XjP8Kdzl
 ufWya/KxbUbZ1o/264dDXSvrWs9pnbCplh/KbApHPQ00qeoW5Ne34CcWvPm1zNaaLlzVf+QOR
 1iPRqCn55xoEPthZsG/9KFubXTxlEtYS+Hd0ejH8Cmlux7JGgHy1pUQC391UGKBwMO0SUASQa
 Lq8K5IEQgI2c7fqQ0B6TFYQLNHvjZnqszl6r/Fe7AN2Rnd9sx1gsDNklU3q3iW3tuG8UnjTkX
 3YnmoSV71J+fGtv9PYZzhRS2Y/sATEWPiENmwbKUD4C7q1xHyDpj6TVLJeyVIotQ2Gg+8ftP7
 7lBGQDozq3pwjyoJI5IDCBdekykw/Et9UWUxXU/FlzMOK7I7GUS1ExK4P1FuVrnPvrw0Vg7Um
 7Ec3smBNGu93H4+BmFAaY4gpDDfysOdoW3NDuZt2SAaWmIJcBYl4L7h6GjRHippTptToj8LoS
 dE4wFhDOheE9UVKa7XPfuwNUUMXihtZSX69xFk3hbfvCwIJcKYXoTdWqEHjTQZms9vCKjqtaX
 CC1+V4JPbELgqmGMQv1DXOTLetdTUFO0LlJ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.08.21 um 08:16 schrieb Carlo Marcelo Arenas Bel=C3=B3n:
> Thanks,
>
> in the discussion above Ren=C3=A9[1] proposed a fix for UBsan issues tha=
t were
> reported and that it is still missing.
>
> my version of it didn't require the extra 4 bytes or showed issues with
> notes so is probably incomplete and should be replaced from the original
> if possible, but follows below:

With your three patches plus the one below t3301-notes.sh and several more
fail on an Apple M1.  Adding an unused int member to struct leaf_node fixe=
s
that.  I didn't dig deeper into the notes code to understand the actual
issue, though.

>
> Carlo
>
> [1] https://lore.kernel.org/git/bab9f889-ee2e-d3c3-0319-e297b59261a0@web=
.de/
>
> +CC Ren=C3=A9 for advise
> --- >8 ---
> Date: Sun, 8 Aug 2021 20:45:56 -0700
> Subject: [PATCH] build: fixes for SANITIZE=3Dundefined (WIP)
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> mostly from instructions/code provided by Ren=C3=A9 in :
>
>   https://lore.kernel.org/git/20210807224957.GA5068@dcvr/
>
> tested with Xcode in macOS 11.5.1 (x86_64)
> ---
>  hash.h        | 2 +-
>  object-file.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hash.h b/hash.h
> index 27a180248f..3127ba1ef8 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -115,7 +115,7 @@ static inline void git_SHA256_Clone(git_SHA256_CTX *=
dst, const git_SHA256_CTX *s
>
>  struct object_id {
>  	unsigned char hash[GIT_MAX_RAWSZ];
> -	int algo;
> +	uint8_t algo;
>  };
>
>  /* A suitably aligned type for stack allocations of hash contexts. */
> diff --git a/object-file.c b/object-file.c
> index 374f3c26bf..2fa282a9b4 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -2406,7 +2406,7 @@ struct oidtree *odb_loose_cache(struct object_dire=
ctory *odb,
>  	struct strbuf buf =3D STRBUF_INIT;
>  	size_t word_bits =3D bitsizeof(odb->loose_objects_subdir_seen[0]);
>  	size_t word_index =3D subdir_nr / word_bits;
> -	size_t mask =3D 1 << (subdir_nr % word_bits);
> +	size_t mask =3D 1U << (subdir_nr % word_bits);
>  	uint32_t *bitmap;
>
>  	if (subdir_nr < 0 ||
>

The first hunk is about alignment (and missing the notes fix, as mentioned=
).
The second hunk is about shifting a signed 32-bit value 31 places to the
left, which is undefined (because technically there are only 31 value bits=
).
Those are different issues and they should be addressed by separate patche=
s,
I think.  That's why I submitted a patch for the the second one in
http://public-inbox.org/git/bab9f889-ee2e-d3c3-0319-e297b59261a0@web.de/.

Ren=C3=A9
