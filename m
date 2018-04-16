Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 778491F404
	for <e@80x24.org>; Mon, 16 Apr 2018 15:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750979AbeDPPnL (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 11:43:11 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:46093 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbeDPPnK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 11:43:10 -0400
Received: by mail-ua0-f193.google.com with SMTP id a17so10383849uaf.13
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 08:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FmE10iy2c2hKgpzf2S1LonKcq/EqGr4oBurvLElCIvU=;
        b=L83oTbXdNph4n72iuhQdjomP2uV+0ABMYVk33B8xisbqe+kgwCkutvj4CBd9S8K5j3
         vjBw8avE7hFmdh4HEBFpEDLglfFm3jOVpvKWE1JWv66j/dkIiAzKdLFwlTWKcY1W0TN9
         4QXPtFUqUT3zzcihdcmRIgI1Ft9vDvYEmMLMe36ly74LHzulhjDhdYAhHXq9b/9gwAs7
         1HXTIsUnYtrK7/w+DDf3MZiVSrIIFxcQ1onul2Nomkxm03aO98iV1eLuIhJLd3td8dtn
         q0ux5sy8/6r1iO3uMZv3sZL9mHWGEXAlxDaEzvf+2gwvYeV/H4rsomzVEvi1+nJ7sk5r
         392g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FmE10iy2c2hKgpzf2S1LonKcq/EqGr4oBurvLElCIvU=;
        b=I/r4NGM0LPBoANMcWl8IqfM/03tXMB9IzB/cupPGGwwTGtwOTnodJRBD2YYOJqfLyP
         FQnnICZvmxcj3hhEzIuxaUqd8tfi32puDO8mA/fsHDxkzoT3df4ScOg2wm2cHgEYQAYF
         y6q+yb4iajvKpgeAHOpLJBHFoQCZi6llGkGLyMTcugFWZEICzkwcNGpQthRCx0BH21cc
         VEvzt4/oOMQzeYFxAvuxKPvhfFNB5dflaaVzNpaLjCZ7hU6ovL/MaSo5zAetkIAKZ59w
         8CW+xQ6dfjHYKmiBFpVWrOntxo/W8xS0l4D59+Dnj2EZyrKndbiQecWVZLIgSlIkzkUk
         rDJQ==
X-Gm-Message-State: ALQs6tA91o2OKus3Pt1aeTpaYXYiIkiwiAiSu5ZJ7BllS8p/NDjYFo/j
        txB4utx8+o77VvUXLPd0ir0QkmuHxqzK3HFLsyY=
X-Google-Smtp-Source: AIpwx48BLR0VDpoY5vrJvbTkI5agiePNJb5Clx1RK4yMvNuuDickUIaWUjskDHgXr3IZw3sMXcnrtw/rABSflKQDpEM=
X-Received: by 10.176.27.172 with SMTP id k44mr11801071uai.5.1523893389991;
 Mon, 16 Apr 2018 08:43:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.34.195 with HTTP; Mon, 16 Apr 2018 08:43:09 -0700 (PDT)
In-Reply-To: <20180415164238.9107-4-pclouds@gmail.com>
References: <20180326165520.802-1-pclouds@gmail.com> <20180415164238.9107-1-pclouds@gmail.com>
 <20180415164238.9107-4-pclouds@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 16 Apr 2018 17:43:09 +0200
Message-ID: <CAM0VKjkns+AsVyMSe2fxzT8a8oqYdNX3qO8mnw2juOgFC7LHYA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] generate-cmdlist.sh: keep all information in common-cmds.h
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 15, 2018 at 6:42 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> common-cmds.h is used to extract the list of common commands (by
> group) and a one-line summary of each command. Some information is
> dropped, for example command category or summary of other commands.
> Update generate-cmdlist.sh to keep all the information. The extra info
> will be used shortly.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  generate-cmdlist.sh | 61 +++++++++++++++++++++++++++++++++------------
>  help.c              | 42 ++++++++++++++++++++++++++-----
>  2 files changed, 81 insertions(+), 22 deletions(-)
>
> diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
> index eeea4b67ea..e0893e979a 100755
> --- a/generate-cmdlist.sh
> +++ b/generate-cmdlist.sh

> -printf 'static struct cmdname_help common_cmds[] =3D {\n'
> -grep -f "$match" "$1" |
> -sed 's/^git-//' |
> +printf 'static struct cmdname_help command_list[] =3D {\n'
> +command_list "$1" |
>  sort |
> -while read cmd tags
> +while read cmd category tags
>  do
> -       tag=3D$(echo "$tags" | sed "$substnum; s/[^0-9]//g")
> +       name=3D${cmd/git-}

There are two issues with this line:

- This is a "regular" shell script, therefore it must not use pattern
  substitution.

- The pattern substitution would remove the string "git-" in the middle of
  the variable as well; I suspect this is undesired.

I think that the remove matching prefix pattern substitution should be
used here.
