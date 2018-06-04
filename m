Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9D191F403
	for <e@80x24.org>; Mon,  4 Jun 2018 15:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750950AbeFDPnS (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 11:43:18 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:55024 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbeFDPnR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 11:43:17 -0400
Received: by mail-wm0-f51.google.com with SMTP id o13-v6so15473920wmf.4
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 08:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BtEbSoOr4KDvbJpdXtxCugM+2kSbPFadjXybH5VfPEc=;
        b=HjYwN+B+CGs5K2qMrZ5R9ddhaK+WRRcknvRRLp3yVOUsz9c9wcarBJaQK5CV/ga4gC
         7y0g47wXh+GFEnxHDaFcL7pgzVT5XlkFQMM/voNAtXAt3sDxu+e5Lp4VPE1/F2PRcHLm
         EarMKdDbtTjIS6PM8Ez5LqCI184mWrTutldP/fAujY4MPfIBFZXw/vjJP+c7OEkVAh6Q
         ijtSNCn4apMcvrnis55etoLyT/PDMJwr8wJBEU/IAm/6YM0gPgHEWVfbHn6Dh7FnBjsi
         LT8apK+4J++Xj0Sdgu0GCKgv7V8jA0aRt6f/TGdPHCObjqtBULz4Tuxo9Z7KlrODtdrQ
         v7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BtEbSoOr4KDvbJpdXtxCugM+2kSbPFadjXybH5VfPEc=;
        b=pcpqRXPqGu3FfP65nOiPoirlgciEZFR6pNV3yR9VH1xx8ByFq+s5LZp1KS7X9w5VsF
         nQ4uKlzQ+y20NM3Ml4CKKERl6qIAb4ArFT0vPkk/jQ4YDwJjrjQGPk0t58CYtddethQr
         sQKRGOawn8BeTu17etKH5F32m50UyxZa6n28EK+kJ8wdlJ633KtKgvrWQOeb+HS7gFw6
         m7XAsoc5e7mKx4GBhzMndlKb61hVbcAIMKw7BF6hfz0pw6+0gkJKFh0s1yxJ0UkvUznZ
         RzBfvwxNRnkP/xViOTsuR++TTu6iE5oGtWdLYufsLDyHukbvIdv9f1KINV/Yz+7N4mOF
         DGtg==
X-Gm-Message-State: ALKqPweSBxS4pu3ycPQdH0VIpTvYD4H4rvv9UIv5os2FI23yekay+tMr
        R89LULH6DUWEU6JPbISA621EmXf/KIW0QKJRe5u0KA==
X-Google-Smtp-Source: ADUXVKI93Db3B5sPGpzPsmqYJ5/wOeP7lzgQyBUojODWSBIVmYBqzy208AgmC+lSwIqh48OYulbZQ0kQWJrok9dggBk=
X-Received: by 2002:a1c:3607:: with SMTP id d7-v6mr10281408wma.39.1528126996377;
 Mon, 04 Jun 2018 08:43:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:ef04:0:0:0:0:0 with HTTP; Mon, 4 Jun 2018 08:43:16 -0700 (PDT)
In-Reply-To: <20180604075549.GA21063@tor.lan>
References: <CA+dzEBm_doNMjEs_OWwia_mm7u3ztAFpCpaFJP3DRpFhEo93jg@mail.gmail.com>
 <20180604073855.GA20922@tor.lan> <20180604075549.GA21063@tor.lan>
From:   Anthony Sottile <asottile@umich.edu>
Date:   Mon, 4 Jun 2018 08:43:16 -0700
Message-ID: <CA+dzEBn7cCey-LDa1Y-PUeFQs7JiucS30FFiLfw4sfu6ZX34JQ@mail.gmail.com>
Subject: Re: Regression (?) in core.safecrlf=false messaging
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 4, 2018 at 12:55 AM, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>
> Does the following patch fix your problem ?
>
> diff --git a/config.c b/config.c
> index 6f8f1d8c11..c625aec96a 100644
> --- a/config.c
> +++ b/config.c
> @@ -1233,7 +1233,7 @@ static int git_default_core_config(const char *var,=
 const char *value)
>                 }
>                 eol_rndtrp_die =3D git_config_bool(var, value);
>                 global_conv_flags_eol =3D eol_rndtrp_die ?
> -                       CONV_EOL_RNDTRP_DIE : CONV_EOL_RNDTRP_WARN;
> +                       CONV_EOL_RNDTRP_DIE : 0;
>                 return 0;
>         }
>


Yes!  After applying that patch:

```

$ PATH=3D$PWD/prefix/bin:$PATH bash test.sh
+ git --version
git version 2.18.0.rc1.dirty
+ rm -rf repo
+ git init repo
Initialized empty Git repository in /tmp/git/repo/.git/
+ cd repo
+ git config core.autocrlf input
+ git config core.safecrlf false
+ echo -en 'foo\r\nbar\r\n'
+ git add f

```

Anthony
