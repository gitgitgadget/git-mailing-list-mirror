Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F7B31FADF
	for <e@80x24.org>; Fri, 19 Jan 2018 03:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755055AbeASDGN (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 22:06:13 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:38872 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754890AbeASDGM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 22:06:12 -0500
Received: by mail-qt0-f196.google.com with SMTP id z10so749445qti.5
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 19:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=RpRpMUymgfdvmA+AXKhfCOq4Ks74pxcFLajIRvt319g=;
        b=KWokfuv1YWKWmiBUf52KsiavcCI0XhOYVQdtCsUJXVhJi8CBWxggY3DMYNa5NSdQNf
         TYLtIJZF8ZXhQriWD9mUGdXCGEUJs7DucmPBfpTPsqbUj/P6YdMXaZSZ5iZNC6OrQuzZ
         kuIN7o3Q8EHGZIArWl+d9DwtMy2Jf7DIUXsY1ROawGec00cNWHf/T1r1TrRRL0AxFg1P
         Yc6h83e+ZaK2zANwjPYoNbKx0C7MxT8jhKS4UNYopuYZcdfvqxvMpFZkpRfFQ+HxUm/k
         T9UJdFPMwgEpmAEBXWtrQwqI5SaIlV+VjP4uinObim+aPQEYH7pexU2fBWPuhBzw8GPm
         H4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:content-transfer-encoding;
        bh=RpRpMUymgfdvmA+AXKhfCOq4Ks74pxcFLajIRvt319g=;
        b=Nik2sVLVmf3agHCTOkWvP7ud/oBstT54lmvsmHsnz6GCimoQhflP4XgOD4m/UooHy6
         DewOL3N3RSAv19iYGorEiJIQAUbqooQtVSCwCdE9FjbBZbmnQz8HO2G3bcVvjUFKq9G7
         /FE0oeRuesn2/vaCUXHTYswzlQI7WszGOLXBlPR0Ce6Z5aJd01yPQZBHu9GH9DcVd3c+
         8oViajIKrMG0MzrG98OzB5ZFoiUTMYYxkoSK0UcfDBbmU08iMEpLmOehRLQlwckbNaBC
         aUj1a9bLbOQPUEzqOHjKi/eF9PN6/qjfq15AFEIDtdkNIl3IxhiWUFxPvYpqqOVT57j7
         Szxg==
X-Gm-Message-State: AKwxytflGUxOM0K45zzukhgI6d1VSBZDOgBbZsPSOwRFTmLL/GapZGFS
        giVyz5SmTYqKrLHBNnnn9w3gf4mH8HATjFfSZ+c=
X-Google-Smtp-Source: AH8x2275B6UqjPAi+ATxMeEt7LaZVBMlhsgYHMngs3MSVfElOTtaJ1zMp7vxJXLssOooaWDQZ4lsMizftUu/eP9hSS0=
X-Received: by 10.200.25.9 with SMTP id t9mr1280944qtj.75.1516331171670; Thu,
 18 Jan 2018 19:06:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Thu, 18 Jan 2018 19:06:10 -0800 (PST)
In-Reply-To: <20180119024738.GA222163@genre.crustytoothpaste.net>
References: <CALwADsGfB10f5+nOFN-pHCt4z1SkWMcvSHn8KokcyCM0V6K-BA@mail.gmail.com>
 <CAPig+cTkBEGyoS93GYCtoDgccTF_UixqBkVTExg7Zf0M1J7KRQ@mail.gmail.com> <20180119024738.GA222163@genre.crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 18 Jan 2018 22:06:10 -0500
X-Google-Sender-Auth: 9YrNEX6NN-mm5-JTDG-HbwfbIgA
Message-ID: <CAPig+cSbbzKV0GttLjHCyY3CNcJO0bdP3Mp4pT+3waUTMAQ8kg@mail.gmail.com>
Subject: Re: git 2.16.0 segfaults on clone of specific repo
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= 
        <aleks.bulaev@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 9:47 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Thu, Jan 18, 2018 at 07:15:56PM -0500, Eric Sunshine wrote:
>> On Thu, Jan 18, 2018 at 3:55 PM, =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B0=D0=
=BD=D0=B4=D1=80 =D0=91=D1=83=D0=BB=D0=B0=D0=B5=D0=B2
>> <aleks.bulaev@gmail.com> wrote:
>> > I found that git 2.16.0 segfaults on clone of vim-colorschemes repo.
>>
>> I can confirm that this crashes on MacOS; it does not crash on Linux or =
BSD.
>>
>> git-bisect places blame on eb0ccfd7f5 (Switch empty tree and blob
>> lookups to use hash abstraction, 2017-11-12).
>
> I unfortunately don't have a macOS system to test with, and I've
> compiled with both gcc and clang on my Debian system and, as you
> mentioned, it doesn't fail there.
>
> I have a guess about what the problem might be.  Can you try this patch
> and see if it fixes things?

That does fix the crash. Thanks for the quick diagnosis.

Can the commit message go into more detail as to why this was crashing
(or your speculation about why)? Perhaps give more detail about what
'clone' is doing that led to the crash.

> -- >8 --
> From 10b690241619a452634b31fbc5ccd054a4f6e5ec Mon Sep 17 00:00:00 2001
> From: "brian m. carlson" <sandals@crustytoothpaste.net>
> Date: Sun, 14 Jan 2018 18:26:29 +0000
> Subject: [PATCH] repository: pre-initialize hash algo pointer
>
> There are various git subcommands (among them, clone) which don't set up
> the repository but end up needing to have information about the hash
> algorithm in use.  In the future, we can add a command line option for
> this or read it from the configuration, but until we're ready to expose
> that functionality to the user, simply initialize the repository
> structure to use the current hash algorithm, SHA-1.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  repository.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/repository.c b/repository.c
> index 998413b8bb..f66fcb1342 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -5,7 +5,7 @@
>
>  /* The main repository */
>  static struct repository the_repo =3D {
> -       NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index,=
 NULL, 0, 0
> +       NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index,=
 &hash_algos[GIT_HASH_SHA1], 0, 0
>  };
>  struct repository *the_repository =3D &the_repo;
>
> --
