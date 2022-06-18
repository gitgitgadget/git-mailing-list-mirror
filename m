Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F26C43334
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 10:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbiFRKut (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 06:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbiFRKut (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 06:50:49 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4975B1D0DE
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 03:50:48 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id h7so4499833ila.10
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 03:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bM0qbzU0fwDjozG1arJLHGF4EUIN03U254OURd09yuc=;
        b=GEjX3V1t2EueJcrSzfu86Q6ZhD8j9/P1Pxox7f7yZaoamBBPJCOW+CSNXxoxxTNuBZ
         3ZnJsL81eXRc4ZJLKO1TLMokkNxweexxZDKEaGVrai+FfkK1SxrBRyTFv14ubNm89QOq
         aWyfhb35UtYevO9mCHysg9BUiuUAEfZYSC1P23KN7srH8AY4JaoS8bQLwxhMAJHEQarR
         F03S2sGQVFHD+igy9yqTuMkP6IMIPkFTXHI2dEuGdD70rKUiCH5o23l+4WJIWx6XZmJ2
         bOuFB8Jn9A4d5nThHWOJ0R3jc9w1Zq8YAZFPOsmy8UwAbcs0zKafLdRbUeEN3sGz7lBG
         YfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bM0qbzU0fwDjozG1arJLHGF4EUIN03U254OURd09yuc=;
        b=yc6A5N1aH1gLJw2CzHCc37ZF7NqtCiZ7oKMFWrH6PGN0QEYLVSXawVlk8el6M21qwz
         K8It/5vO49RqsI23HAMwKA0x7K0euN8Kaxgik00gwB3c7HzGJsm0x9AafB60Jp3YPvBQ
         ivkZft2QWiWupB1Z7ebNXs4EWPDv5jt2KpVqfl6v1/JodnKextxhYR8pJQaQ/W36Mt2z
         pVX66MDs8DmsAAEsPG54tCvau89OqMeftFKb/P1BY8H9FouxAD/S0cvOV+LkOmZfsiRh
         yjlzygSkCbx1lBwFl6J54M/1qx69CMpUMPmf53ezEyxTiZkvvVDrYbM+Sne5i5Rf59DG
         YfYQ==
X-Gm-Message-State: AJIora/g5qOr7MAgtEkuTA0Ccm9KVMAfXdO5ASA3J0zJkAaqGehPoU9Z
        f6R6VUsprFUDotA5LqYKnQBWbikverwvM6Zu/hY=
X-Google-Smtp-Source: AGRyM1tYfGUQa/Bs4EYFnGLCGxepsvBC3e2Z7AW6Rz4ExfwyyoBp8IsKYvSFXidTfsijGkPFxWiI3/NORuSTXlUuTYE=
X-Received: by 2002:a05:6e02:1242:b0:2d7:9672:bd36 with SMTP id
 j2-20020a056e02124200b002d79672bd36mr8037142ilq.163.1655549447671; Sat, 18
 Jun 2022 03:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1262.git.1655300752.gitgitgadget@gmail.com>
 <432d80b8c78355e5f70081c05e9a042a9ffcd033.1655300752.git.gitgitgadget@gmail.com>
 <220615.86a6ady983.gmgdl@evledraar.gmail.com>
In-Reply-To: <220615.86a6ady983.gmgdl@evledraar.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 18 Jun 2022 18:50:36 +0800
Message-ID: <CAOLTT8SfRz62jVrdtjsGN=-iBAQzA3w_oJgT++xtx_kbdCmdqQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ls-files: introduce "--format" option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2022=E5=
=B9=B46=E6=9C=8816=E6=97=A5=E5=91=A8=E5=9B=9B 04:15=E5=86=99=E9=81=93=EF=BC=
=9A
>
>
> > +static void write_name_to_buf(struct strbuf *sb, const char *name)
> > +{
> > +     name =3D relative_path(name, prefix_len ? prefix : NULL, sb);
> FWIW I'd find this a bit less "huh?" if we declared another variable
> here, so just:
>
>         const char *rel =3D relative_path(name, ...).
>

Yeah, It's just a wrong code copy.

> > +     o1
> > +     EOF
> > +     git ls-files --format=3D"%(path)" -m >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'git ls-files --format with -d' '
> > +     rm o1 &&
>
> Don't "rm o1" here, rather have the test that creates it do:
>
>     test_when_finished "rm o1" &&
>     [the command that creates o1]
>

I thought about how to test 'git ls-files -d', so maybe I need
something like:

test_expect_success 'git ls-files --format with -d' '
     echo o3 >o3 &&
     git add o3 &&
     rm o3 &&
     cat >expect <<-\EOF &&
     o3
     EOF
     git ls-files --format=3D"%(path)" -d >actual &&
     test_cmp expect actual
'

> > +     test_when_finished "git restore o1" &&
> > +     cat >expect <<-EOF &&
> > +     o1
> > +     EOF
> > +     git ls-files --format=3D"%(path)" -d >actual &&
> > +     test_cmp expect actual
> > +'
> > +
>
> These tests...:
>
> > +test_expect_success 'git ls-files --format with -s must fail' '
> > +     test_must_fail git ls-files --format=3D"%(objectname)" -s
> > +'
> > +
> > +test_expect_success 'git ls-files --format with -o must fail' '
> > +     test_must_fail git ls-files --format=3D"%(objectname)" -o
> > +'
> > +
> > +test_expect_success 'git ls-files --format with -k must fail' '
> > +     test_must_fail git ls-files --format=3D"%(objectname)" -k
> > +'
> > +
> > +test_expect_success 'git ls-files --format with --resolve-undo must fa=
il' '
> > +     test_must_fail git ls-files --format=3D"%(objectname)" --resolve-=
undo
> > +'
> > +
> > +test_expect_success 'git ls-files --format with --deduplicate must fai=
l' '
> > +     test_must_fail git ls-files --format=3D"%(objectname)" --deduplic=
ate
> > +'
> > +
> > +test_expect_success 'git ls-files --format with --debug must fail' '
> > +     test_must_fail git ls-files --format=3D"%(objectname)" --debug
> > +'
>
> ...would be better done with a for-loop, so:
>
>         for flag in -s -o -k --resolve-undo [...]
>         do
>                 test_expect_success "git ls-files --format is incompatibl=
e with $flag" '
>                         test_must_fail git ls-files --format=3D"%(objectn=
ame)" $flag
>                 '
>         done
>

Yeah, using this loop will be clear.

> Note the '' on the second argument, that's intentional, as we eval it
> you don't need "".
>
> > +test_done
>

Thanks for all these code style suggestions!

ZheNing Hu
