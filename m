Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA9C81F576
	for <e@80x24.org>; Fri, 23 Feb 2018 10:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbeBWKdv (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 05:33:51 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:34932 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbeBWKdu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 05:33:50 -0500
Received: by mail-ot0-f196.google.com with SMTP id p8so7075686otf.2
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 02:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XlR3dO0FljoiYLtlXrl9skv72sglTWbSwnV9wyRdzwQ=;
        b=dcPUg7LdvG/gWk2lc3DarWC/uFYsHN53bYX1lCeLeOsVW6ZGmCoRm+Hfreyu7O4U5g
         Ej1kKm47ubpsflC+bS03dqQpASaPX3awl2NzF13YVe2qXvpOPhxSC+eUm9lzGpoN9Rxq
         W1UNKmyudZLl85EiWVd7iyT+HMjvT5zHBRBrYGoSQp8uAW0AjEeE1/9hwyz24pCuOJZ4
         WEenLcNQ9WF1aGdpHGLHKBbE2O2taYw3bYh0UxgcfI6M+3kqODuRKSQsIGYKL1nr00VI
         VHL4FlUxH8qmLvSxrpeYTH+v3cfXkrwS7hzmqJgRR0l7owrqAXbAOr/t+vOtq0ELWq3D
         a5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XlR3dO0FljoiYLtlXrl9skv72sglTWbSwnV9wyRdzwQ=;
        b=WU6GZ/PmynV/jRd9ZyA6q0ZFXJ3CKcpsH2fTETubdTiT+neZIZN+1lmTJTHSlJS/J9
         EzC4LwTixO0Qlm+DI5htjMrQhVO0tEOnwWGzzmhXps7NYxDB8DUz9iC36ik56Cq0PUhn
         jrbWNOR2kW4HZ5yrb0ibXB5GDdkaKltAsAFn5aRgp0Kwfp8Jb0B5iw5zWzVVrplqoi5m
         5tCnjJEGcNsHAEBVxO+ROaJ4MYG+EzU/2/Ex3a2iRyz6yzQtezy0lSYD+LLdC4mvcyvj
         3gaVAjRbFsk3AQMvIwTkYKiOOYPX7R7S+azRJpjvj2CaM+OtZQ5gDI1fiHtnYdfibC50
         FsNw==
X-Gm-Message-State: APf1xPB/fdD3xQV03PJ5ZUI4th07bqoGhZqUIiTD/zskmzR/J4WMYBe7
        UueGpPVyG8TF0mb9nQBkbSuZFv6QZnjozAXq9hU=
X-Google-Smtp-Source: AG47ELsdUW+EV30iAvTlHiFQftD0KWWTZJzLYRGhqWonZZp1lWPbLsia5lKJU5tb2Q5ozWE5DS5Xq9zHzDdy7gWfChI=
X-Received: by 10.157.54.204 with SMTP id s12mr743137otd.304.1519382030213;
 Fri, 23 Feb 2018 02:33:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Fri, 23 Feb 2018 02:33:19 -0800 (PST)
In-Reply-To: <CAM0VKjmJwDUv4gTQ+22SgfX+=PahXRPeP=774hV7mxxm3nXiYg@mail.gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com> <20180209110221.27224-1-pclouds@gmail.com>
 <20180209110221.27224-30-pclouds@gmail.com> <CAM0VKjmJwDUv4gTQ+22SgfX+=PahXRPeP=774hV7mxxm3nXiYg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 23 Feb 2018 17:33:19 +0700
Message-ID: <CACsJy8CQJViiDVuEXH-zkY_yX5AUahJCCshX=jedHhVvfpMUiA@mail.gmail.com>
Subject: Re: [PATCH v3 29/42] completion: use __gitcomp_builtin in _git_notes
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 14, 2018 at 9:29 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> On Fri, Feb 9, 2018 at 12:02 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion=
/git-completion.bash
>> index c7b8b37f19..60127daebf 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>
>> @@ -1851,15 +1851,17 @@ _git_notes ()
>>         add,--reedit-message=3D*|append,--reedit-message=3D*)
>>                 __git_complete_refs --cur=3D"${cur#*=3D}"
>>                 ;;
>> -       add,--*|append,--*)
>> -               __gitcomp '--file=3D --message=3D --reedit-message=3D
>> -                               --reuse-message=3D'
>> +       add,--*)
>> +               __gitcomp_builtin notes_add
>> +               ;;
>> +       append,--*)
>> +               __gitcomp_builtin notes_append
>>                 ;;
>>         copy,--*)
>> -               __gitcomp '--stdin'
>> +               __gitcomp_builtin notes_copy
>>                 ;;
>>         prune,--*)
>> -               __gitcomp '--dry-run --verbose'
>> +               __gitcomp_builtin notes_prune
>>                 ;;
>>         prune,*)
>>                 ;;
>
> This could be simplified to:
>
>   add,--*|append,--*|copy,--*|prune,--*)
>         __gitcomp_builtin notes_$subcommand
>         ;;
>
> And we could even go one step further:
>
>   *,--*)
>         __gitcomp_builtin notes_$subcommand
>         ;;
>
> This would have the benefit that if any of the remaining subcommands
> learn --options, then they would be completed right away, without the
> need to add that subcommand to the case arms.

You read my mind ;-) We won't do this in this series though (but I
will simplify the code as suggested). parse-options.c does not have
any concept about these subcommands. So a bit more work and can (and
will) be done separately.
--=20
Duy
