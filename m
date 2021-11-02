Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47D8C433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 11:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9496860EBB
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 11:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhKBLbc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 07:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhKBLbc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 07:31:32 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2E3C061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 04:28:57 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id b17so27184400uas.0
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 04:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1UkS18fRvQFSLcV0XMZZOUL7xNGooLP3MDFxy1aZ6BI=;
        b=ZwVD6nPWVOZx98RfzfLJ/2liAQo9uQlQBFOM0cEjuty6ADGzqcoujM8z56cvCa1YAR
         xgeJOaCeZ7WhRff+ROVCUDqJ0oWoyLvW4JeTkJCmk5FoTlhgbWGyEVhR/RtwDKRSsucg
         PwqpqO1v76gZh6KkfLuGAmLr77/1htGDIs1kQMmL5S+j/EDQ3uMYZgiuapDluHaVuOfY
         GPtAh6GlHzyqz2/ercwwBP3TRbW+Vz5A4fWSQkRjYfgTVffyL/mQE+gV6IjfI9kgRjmw
         OxuoDpIilNu1JSC7U4rBTdT6M75Oj0qhDr4a3x04CUAtiWGJ9IeBGdSfoEv0hJ5gtA0K
         ICVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1UkS18fRvQFSLcV0XMZZOUL7xNGooLP3MDFxy1aZ6BI=;
        b=Wo34sH+MTUp15/7uh26W/C48w9QRuicLbYMqrgQNKtkE9a045B/WV5tKeDfLpGCMdf
         UL0wwqugiZJ6yRCyVWtCzgGC++qseB/KleXAdT+5hH6t7c54GzD+CfdlrFRd2nISBpGi
         TJ+4U6Yqf+o1POmT6DpA8I3huxH5uLMu3rCutlLe/YJz4VtylE8F+LtA5AzNw70ivEdS
         onklpEAE60+AgCOONBvOLC0h0yx6QjS03ZimaRTKBlC0LQN7RnMgum0l7FXO6Y3nf6wC
         RW6cNIxA3fFE2Fod7R4cTYxOfBYliJW4jDeFCP/eSF5l/QF/UQCS0L3gU+jvH8d7HQ1r
         O8OQ==
X-Gm-Message-State: AOAM532PWtf1Fcm9wKtDi4ZKoD1QG7P+sOkGGvw9QbZ/1IYcQfP3GQPM
        QQmIexS/QYNilasAQc31hW5Nm0BjMbYHILXBEqTS/vtq/9sYoQ==
X-Google-Smtp-Source: ABdhPJxnnmNst8KeBwU0mOSQxRpfJ1QxxoYFb2VehS6+kPi+UxrVrwP95XxHRP9J3AMWKyBFalpuewwgkaU3+hCEpe0=
X-Received: by 2002:a05:6102:d8d:: with SMTP id d13mr15368602vst.43.1635852536775;
 Tue, 02 Nov 2021 04:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211030020917.32132-1-worldhello.net@gmail.com> <20211031052156.5237-1-worldhello.net@gmail.com>
In-Reply-To: <20211031052156.5237-1-worldhello.net@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 2 Nov 2021 19:28:45 +0800
Message-ID: <CAOLTT8Rv8jqWazJoKA0qTTRfQUxRny2b6XG+YsvXkT4D1xZ6_A@mail.gmail.com>
Subject: Re: [PATCH] i18n: fix typos found during l10n for git 2.34.0
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <daniel@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> =E4=BA=8E2021=E5=B9=B410=E6=9C=8831=E6=
=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=881:25=E5=86=99=E9=81=93=EF=BC=9A
>
> Emir reported typos in some i18n messages in the pull request[1] of
> Turkish language l10n for git 2.34.0.
>
> * Use stable spelling for config variable "gpg.ssh.defaultKeyCommand".
> * Add missing space between "with" and "--python".
>
> [1] https://github.com/git-l10n/git-po/pull/567
>
> Reported-by: Emir Sar=C4=B1 <bitigchi@me.com>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>  gpg-interface.c | 2 +-
>  ref-filter.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 800d8caa67..68d2f29be7 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -775,7 +775,7 @@ static const char *get_default_ssh_signing_key(void)
>                 if (keys[0] && starts_with(keys[0]->buf, "ssh-")) {
>                         default_key =3D strbuf_detach(keys[0], NULL);
>                 } else {
> -                       warning(_("gpg.ssh.defaultKeycommand succeeded bu=
t returned no keys: %s %s"),
> +                       warning(_("gpg.ssh.defaultKeyCommand succeeded bu=
t returned no keys: %s %s"),
>                                 key_stderr.buf, key_stdout.buf);
>                 }
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 282cdad103..08a3f839c9 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1037,7 +1037,7 @@ int verify_ref_format(struct ref_format *format)
>                      format->quote_style =3D=3D QUOTE_TCL) &&
>                      used_atom[at].atom_type =3D=3D ATOM_RAW &&
>                      used_atom[at].u.raw_data.option =3D=3D RAW_BARE)
> -                       die(_("--format=3D%.*s cannot be used with"
> +                       die(_("--format=3D%.*s cannot be used with "
>                               "--python, --shell, --tcl"), (int)(ep - sp =
- 2), sp + 2);
>                 cp =3D ep + 1;
>

It is my negligence. Thanks.

> --
> 2.34.0.rc0.8.g1f511a9b56
>

--
ZheNing Hu
