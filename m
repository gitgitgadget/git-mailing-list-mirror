Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2EF91F404
	for <e@80x24.org>; Mon, 12 Feb 2018 00:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932266AbeBLAez (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Feb 2018 19:34:55 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:45520 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932108AbeBLAey (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Feb 2018 19:34:54 -0500
Received: by mail-ot0-f193.google.com with SMTP id 73so12533420oti.12
        for <git@vger.kernel.org>; Sun, 11 Feb 2018 16:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dlHlVT3vOS29tDoWCoGFubj62pir6kjmbcO2UKjcnDo=;
        b=N3+NlSz/7Zq63rO7NLhNI/yhNIBi4psA5GHA/TuBK8bdgkq4T4+b/7cseNywxEbtGt
         4hxdTllf7BVWGgZcQZiu9XDHoyfaBOK36HTlXudHMSD1QxeFnmJX+UAECeSDLFrOsZjv
         M/IpBi5mO4rTh6eparHpoB5wKpzKWe6OsGDmoK78qX0VqLE8aQDxsehXATlN4v6yxjJO
         jBwXUwC+YvV5tCtfA5GFFDR4uu3vJBT9nat3HscaU86t6ZiECdpBnh06ex9LV+ONiPiY
         5/oc5w+vy94StV2t7HwrUM0RvccwfmS0TC23oVugMhCdBzKqJ075RlaBM8c3sqbq3je3
         Ih7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dlHlVT3vOS29tDoWCoGFubj62pir6kjmbcO2UKjcnDo=;
        b=JK74f5HZ2qqQEDNn6ZJ9Uk3vSJwQK34KTpw/dxgiWYjNyRTgxZMPKVnZ2nBmCUgG2z
         fg0T+5iig/eVOEgIo7yNLyyFDTn1HX+G4/vpuWddSeMkpoaLa8CuWq8D8fhOuqBobK5e
         YooWoQDWE0Q/8mjvemVxru7RyOW6Hv+UsxvoAYcs5R1noE6pqAYtTYN3990eDOqpfkyT
         nr3DWvB8wtJEufamErRrL8Qzlj4H2QT7fONTz3Jeqwv+6zY8238sWYk6Z1HkjNydMGjw
         yshPwLkDDaaVJ17jWjNsnOjcsUcvgHvcjX33XgpF0l0WyxcbR6EDxT0he0qSqaTDLdcy
         H+ig==
X-Gm-Message-State: APf1xPC1gpByG37ircORzg7Ejp+Yu7kCeYf3i++JaY6pI2k/TPIoYB14
        QkkeutrAjfiCZ48xPaHun7t8GSZCu4wZbxg8Eeo=
X-Google-Smtp-Source: AH8x224BnyFOAPs7IW0ZsEjiLWxQ0xUQ5//tNpJ/QygJRfDxS1blOhH+xN8ZbrpIrjOYIORtbl6RF27YUFqSEuxug2I=
X-Received: by 10.157.64.140 with SMTP id n12mr7761288ote.151.1518395693659;
 Sun, 11 Feb 2018 16:34:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Sun, 11 Feb 2018 16:34:22 -0800 (PST)
In-Reply-To: <CAPig+cT63UnZ1qLKc-Rk4k0ixL93ywd-i6AFH3mFJOWq2QpuBQ@mail.gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com> <20180209110221.27224-1-pclouds@gmail.com>
 <20180209110221.27224-43-pclouds@gmail.com> <CAPig+cT63UnZ1qLKc-Rk4k0ixL93ywd-i6AFH3mFJOWq2QpuBQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 12 Feb 2018 07:34:22 +0700
Message-ID: <CACsJy8BoPxbt=hqAd9fS7MLiF33FVtAk0=Fr_q7UgYy1YvEg0w@mail.gmail.com>
Subject: Re: [PATCH v3 42/42] git-completion.bash: add GIT_COMPLETION_OPTIONS=all
 config
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 11, 2018 at 8:59 AM, Eric Sunshine <sunshine@sunshineco.com> wr=
ote:
> On Fri, Feb 9, 2018 at 6:02 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 <pclouds@gmail.com> wrote:
>> By default, some option names (mostly --force, scripting related or for
>> internal use) are not completable for various reasons. When
>> GIT_COMPLETION_OPTIONS is set to all, all options (except hidden ones)
>> are completable.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion=
/git-completion.bash
>> @@ -36,6 +36,10 @@
>> +#
>> +#   GIT_COMPLETION_OPTIONS
>> +#
>> +#     When set to "all", complete all possible options
>> @@ -303,7 +307,7 @@ __gitcomp_builtin ()
>>         if [ -z "$options" ]; then
>>                 # leading and trailing spaces are significant to make
>>                 # option removal work correctly.
>> -               options=3D" $(__git ${cmd/_/ } --git-completion-helper) =
$incl "
>> +               options=3D" $(__git ${cmd/_/ } --git-completion-helper=
=3D$GIT_COMPLETION_OPTIONS) $incl "
>
> This approach is rather different from what I had envisioned. Rather
> than asking --git-completion-helper to do the filtering, my thought
> was that it should unconditionally dump _all_ options but annotate
> them, and then git-completion.bash can filter however it sees fit. For
> instance, --git-completion-helper might annotate "dangerous" options
> with a "!" ("!--force" or "--force!" or "--force:!" or whatever).
>
> The benefit of this approach is that it more easily supports future
> enhancements. For instance, options which only make sense in certain
> contexts could be annotated to indicate such. An example are the
> --continue, --abort, --skip options for git-rebase which only make
> sense when a rebase session is active. One could imagine these options
> being annotated something like this:
>
>     --abort:rebasing
>     --continue:rebasing
>     --skip:rebasing
>
> where git-completion.bash understands the "rebasing" annotation as
> meaning that these options only make sense when "rebase-apply" is
> present. (In fact, the annotation could be more expressive, such as
> "--abort:exists(rebase-apply)", but that might be overkill.)

I agree. I went a bit off track with this ...=3Dall. But yes some form
of annotation will be needed long term to describe these options in
details. We haven't gotten the annotation in struct option[] to this
level yet, it's a bit hard to see what will be needed here. Let's drop
42/42 for now. I will study git-completion.bash more to see what it
needs and revisit this at some point in future.
--=20
Duy
