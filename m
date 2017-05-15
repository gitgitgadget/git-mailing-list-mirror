Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B409C201A7
	for <e@80x24.org>; Mon, 15 May 2017 18:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935357AbdEOSay (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 14:30:54 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34745 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933211AbdEOSax (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 14:30:53 -0400
Received: by mail-it0-f65.google.com with SMTP id d68so2285411ita.1
        for <git@vger.kernel.org>; Mon, 15 May 2017 11:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Sz1AXI5g4VVZ1bUsWcgOv022zEJBjUwo/a4yjWD3TT4=;
        b=vCcoT2PqaKhGu9CQMOY4HZ3sAB3dS35UcjirVjWc1By0hH2w74B6x+6oaKzSf19BKc
         pqgeEekUDWY7yqqcX9886GEZh/J/leBkzeNNHpTA71lTIoqiKWJU2/w1krSFUXPP3IWp
         EZ2Dk/wROauofcW8x1GPj0jNVZMvMF3xhISVdxrdj8KbZSJURX0FTiWjVC/cX1KBd6lq
         /3IvFRz5brOg9vEVizjjnwkmjMhpt7YOIZVS7tZn6TyivnhbzO8zo5ozmi/P9yqDc07e
         8sApVKdlwVA2lOYl59yzd4hnApfjEBWSWgoZV10wSliX00J1BwTTdWisiGF+2qJgF4bS
         hq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Sz1AXI5g4VVZ1bUsWcgOv022zEJBjUwo/a4yjWD3TT4=;
        b=Jx4mxezj15tj32MQRyrW6e+ewXjJCBspw7A0YNj8kIw/Q6szSQBTD5hCBQr3fvXlRT
         BWPr0n7vV1xUnxaS7sX35AaZJOWu07nu1JiRyhrJLqEibxlrqlsmMm5Ix59kXy4nUll/
         A6sqAUNSljMojk3iYcHxNrfExtHREdaMp150/gIRQhi0RMsqHJWQwjgFjX42mqUzaUjc
         Sm++sWswBw6otLiFc1DmsSYIVIQfzgb0VA3ayxNABauIDN3pvezw5HEiVy4v28JLnYeu
         /JYCwnZZW7YAT70fKUqL04NZB63qgpjUnpHkTsVbmUfc6INJAapNjT4uSvlH6OTPQ4Ic
         30Pg==
X-Gm-Message-State: AODbwcBEp3p6QRBlaQK3N/Uex2Z7TN0hF1kJh8sFgQB9o8g/feZQ/Fg5
        uDTPTXaB1ceYCKJDfa2ejFmHd+LS5w==
X-Received: by 10.36.37.78 with SMTP id g75mr6634659itg.94.1494873052497; Mon,
 15 May 2017 11:30:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Mon, 15 May 2017 11:30:31 -0700 (PDT)
In-Reply-To: <CACBZZX5d25UyGbb6=kPmzk_5-X0GMptN0kX_--aBADsDy-9kWw@mail.gmail.com>
References: <CACBZZX5d25UyGbb6=kPmzk_5-X0GMptN0kX_--aBADsDy-9kWw@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 15 May 2017 20:30:31 +0200
Message-ID: <CACBZZX5nchNUb-V3U8FL9fuhk=3t42Qhz4=Wh9Qk_0C=x85UdQ@mail.gmail.com>
Subject: Re: [PATCH/RFC] The new IncludeIf facility doesn't DWIM when the repo
 is symlinked
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 5:20 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> I have a ~/git_tree in my homedir that's symlinked to an external
> drive, and doing "gitdir:~/git_tree/" doesn't work, because instead of
> matching against ~/git_tree it's matched against
> /mnt/some-other-storage/.
>
> Here's a WIP patch that makes this work for me, any reason I shouldn't
> finish this up & that we shouldn't be doing this? The doc don't say
> "we'll only match gitdir against the absolute resolved path" or
> anything like that, so until I checked out the implementation I didn't
> realize what was going on:

On closer inspection I can see that this was actually broken in
86f9515708 ("config: resolve symlinks in conditional include's
patterns", 2017-04-05), but works in the initial addition of
IncludeIf.

> diff --git a/config.c b/config.c
> index b4a3205da3..606acaa3f1 100644
> --- a/config.c
> +++ b/config.c
> @@ -214,6 +214,7 @@ static int include_by_gitdir(const struct
> config_options *opts,
>         struct strbuf pattern =3D STRBUF_INIT;
>         int ret =3D 0, prefix;
>         const char *git_dir;
> +       int tried_absolute =3D 0;
>
>         if (opts->git_dir)
>                 git_dir =3D opts->git_dir;
> @@ -226,6 +227,7 @@ static int include_by_gitdir(const struct
> config_options *opts,
>         strbuf_add(&pattern, cond, cond_len);
>         prefix =3D prepare_include_condition_pattern(&pattern);
>
> +again:
>         if (prefix < 0)
>                 goto done;
>
> @@ -245,6 +247,12 @@ static int include_by_gitdir(const struct
> config_options *opts,
>         ret =3D !wildmatch(pattern.buf + prefix, text.buf + prefix,
>                          icase ? WM_CASEFOLD : 0, NULL);
>
> +       if (!ret && !tried_absolute) {
> +               tried_absolute =3D 1;
> +               strbuf_reset(&text);
> +               strbuf_add_absolute_path(&text, git_dir);
> +               goto again;
> +       }
>  done:
>         strbuf_release(&pattern);
>         strbuf_release(&text);
