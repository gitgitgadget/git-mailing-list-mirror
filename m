Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by archive.lwn.net (Postfix) with ESMTP id BB3447DE57
	for <lwn-git@archive.lwn.net>; Wed, 11 Mar 2020 16:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbgCKQ1a (ORCPT <rfc822;lwn-git@archive.lwn.net>);
        Wed, 11 Mar 2020 12:27:30 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45616 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgCKQ13 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 12:27:29 -0400
Received: by mail-oi1-f193.google.com with SMTP id v19so2456774oic.12
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 09:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CrO+xIFkhuXY2Bjp2MJHYCsyGc8QjFap4z7EVPtge7I=;
        b=SIF8pyT3L7rCeaOH8TUwSH/sMOS2uQlRPVYNXSBbzpBg8cVgJJw5fhUXEuC0OrBtMZ
         SdKlqafkQg8e348BuQI0YeatpSYT7IyaWmx/0hSqEbIe4sHUG+CLtvfuiNM3FBhoWWPL
         j7iK5QFvONCiJQTJf2kTNlVqg3ws3sZXLC2l5lrpb7YzNmR+ldec8o+c+/tswW2mw3Cs
         6EcQdlUdGOu+h75Vm/6q9E87ULK2yv6n6Y5zcdzg1ZbuBZk+TwG+SloRJGU80XdpJ3vo
         vjDymkl+FywSunuyj2hAnmj+nzxK0a3sOg3HgcxeM+i5ny8TKmZWfAlUXu7Lww8anln/
         y60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CrO+xIFkhuXY2Bjp2MJHYCsyGc8QjFap4z7EVPtge7I=;
        b=pSeFxvznRxhfKkdvBo6edS3tHi1PyF6KFKoHBq9m9QXr6mVjemMMlE9KjFuCTCGTLQ
         LggC4/e35wEcLBPQZdb3Unq6rmlRfd0D4nQxeEx1XVt/PP9pjzBdhYZ4zTueIOqCtBZw
         DSXxT2ks6ncrsysDQjG8exNWkXqeqlTemeEUVOxw7MnrxzvyxBRfVWQW7fBuz2Pdiy5w
         K+IQDH32ZxMe4ijBoMLaZrDsHG85vvbVAvvBNrfGgUVpnZcBNfgxGvNEz5zGdksZFMNb
         UAJWHC+BriKkENZGumaYT3sY2u4GduhoGriBHir/uNgzVIW+nMvjXt3Zl7eUxjHFEOSX
         f6Bw==
X-Gm-Message-State: ANhLgQ27bCBjN9DBAkzRPVHQZoVobvIGP/lGptbzfMQBeUqLcdRBJpgc
        q73InlQ86raH0xJso2Q5JI3zqPCEkUBIorbLPQn/1Q==
X-Google-Smtp-Source: ADFU+vvXNoRu7zd8KT/hlbLvXuilxPUbJwDVvgbTJc796UT6+C4mY6p+pww/OhVkz6DWdX0s0zeuXGM/JmjMsh89jnw=
X-Received: by 2002:aca:3081:: with SMTP id w123mr2472601oiw.31.1583944048717;
 Wed, 11 Mar 2020 09:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200311065527.7669-1-worldhello.net@gmail.com>
In-Reply-To: <20200311065527.7669-1-worldhello.net@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 11 Mar 2020 09:27:17 -0700
Message-ID: <CABPp-BE2vd2UOKbOaEuW4=YLvofFkg=mWGmE=WFW2gXaR-E5Hw@mail.gmail.com>
Subject: Re: [PATCH] i18n: unmark a message in rebase.c
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://archive.lwn.net:8080/git/CABPp-BE2vd2UOKbOaEuW4=YLvofFkg=mWGmE=WFW2gXaR-E5Hw@mail.gmail.com/>
List-Archive: <http://archive.lwn.net:8080/git/>
List-Post: <mailto:git@vger.kernel.org>

On Tue, Mar 10, 2020 at 11:55 PM Jiang Xin <worldhello.net@gmail.com> wrote:
>
> Commit v2.25.0-4-ge98c4269c8 (rebase (interactive-backend): fix handling
> of commits that become empty, 2020-02-15) marked "{drop,keep,ask}" for
> translation, but this message should not be changed.
>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>  builtin/rebase.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index cb7aeae597..bff53d5d16 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1543,7 +1543,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>                                  "ignoring them"),
>                               REBASE_PRESERVE_MERGES, PARSE_OPT_HIDDEN),
>                 OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
> -               OPT_CALLBACK_F(0, "empty", &options, N_("{drop,keep,ask}"),
> +               OPT_CALLBACK_F(0, "empty", &options, "{drop,keep,ask}",
>                                N_("how to handle commits that become empty"),
>                                PARSE_OPT_NONEG, parse_opt_empty),
>                 { OPTION_CALLBACK, 'k', "keep-empty", &options, NULL,
> --
> 2.26.0.rc0.1.g67b07ef6f6

Thanks for the fix.
