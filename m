Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6D861F597
	for <e@80x24.org>; Thu,  2 Aug 2018 18:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732223AbeHBUkE (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 16:40:04 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:46215 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729733AbeHBUkD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 16:40:03 -0400
Received: by mail-yb0-f193.google.com with SMTP id c3-v6so1632228ybi.13
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 11:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vUb3ggGjYMc9oBvVFZT22RujwWuibpsnpugDiACeH2I=;
        b=fCGV/pIkWxxPPkPC/vI0Kcfd7SNr+Q0lMwJQqb9WnqiBg7Wqztm49MS39uJTj6ooTX
         hC4wqUVwNZtBH/7tj42eebLkI/nXqMMx5+PTpUpJT2uW/fVltZJCcL1nfaLFAFMxQwDJ
         rTsDffPvZTcRlpuSMWkO9qBuwlA1m4EeduqSK1ItHsemiLVSnMYZeYfygZ72G1QqOihv
         PiG/skgwrPLEDVbLzJjdLXFcQc63/rJPKukexl1nsNMu3hfid0iqonNuIvzny2kORlLF
         aY2TZM2FMefPT704m6tqysjOHL2b6oOKGYawZdU2LpTNIitD0EQOREKnQyFXITaoUAXe
         rmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vUb3ggGjYMc9oBvVFZT22RujwWuibpsnpugDiACeH2I=;
        b=lKzHuyhoQB/yEOk69r/Ftcm4SzFaX6gW6oI4XSfmUptYeGNlGv6N+L++w36sTTgK8x
         gyXsiEuEAEA0JQjn8OB/QssYeD1/PilXUf/XdUOcQERSkvqvr3u1Mbf+IdRXFqCqnjXG
         aK62Bdq4dxMQGSmSf0+s/nOkxTOLYlROMMqrPqJyoMMaz4nrMjonNOtGRyVxXmO4i8dl
         Hh8Sbwd1qzYk/R+12nMubcQWjj0xs5f/7RHYP+sTdGRYWbHPw2wE9+yST/zuJAHfTny4
         kES8lxPFNzyjl5fcSTIxx1LC9PgDrnixR9D0rH8kcbYpyVRfWQAyUW84kgfmteWablKC
         vFqg==
X-Gm-Message-State: AOUpUlH335YqZIhVAuWQGKm4HhLJncDgy56OLSegWSP7POwYpZakdyZg
        58nH46W3+/+qAIv0EYbjDg6u98zgpv6qFfEWNt8JAA==
X-Google-Smtp-Source: AAOMgpdksLPpjHuMxezTTVcTBbtW6UbCDQiqneCnxEhFBmiBiJDCj+WY+l3dGFZsmiSLXS+3ZqyoG5V5VaN0NY+q52I=
X-Received: by 2002:a81:3758:: with SMTP id e85-v6mr451650ywa.340.1533235661443;
 Thu, 02 Aug 2018 11:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180802134634.10300-1-ao2@ao2.it> <20180802134634.10300-5-ao2@ao2.it>
In-Reply-To: <20180802134634.10300-5-ao2@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 2 Aug 2018 11:47:30 -0700
Message-ID: <CAGZ79kY78rgb8VpRn-A2moucy16z1TsDGdz2cjJzVOxsiKiiYw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/12] submodule--helper: add a new 'config' subcommand
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        =?UTF-8?Q?Daniel_Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 2, 2018 at 6:47 AM Antonio Ospite <ao2@ao2.it> wrote:
>
> Add a new 'config' subcommand to 'submodule--helper', this extra level
> of indirection makes it possible to add some flexibility to how the
> submodules configuration is handled.
>
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> ---
>
> Note that the tests follow the predominant style in the file: subshell and cd
> right at the start of the sub-shell opening.
>
>  builtin/submodule--helper.c | 17 +++++++++++++++++
>  t/t7411-submodule-config.sh | 26 ++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index a3c4564c6c..14f0845d30 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2029,6 +2029,22 @@ static int connect_gitdir_workingtree(int argc, const char **argv, const char *p
>         return 0;
>  }
>
> +static int module_config(int argc, const char **argv, const char *prefix)
> +{
> +       if (argc < 2 || argc > 3)
> +               die("submodule--helper config takes 1 or 2 arguments: name [value]");
> +
> +       /* Equivalent to ACTION_GET in builtin/config.c */
> +       if (argc == 2)
> +               return print_config_from_gitmodules(argv[1]);
> +
> +       /* Equivalent to ACTION_SET in builtin/config.c */
> +       if (argc == 3)
> +               return config_set_in_gitmodules_file_gently(argv[1], argv[2]);
> +
> +       return 0;

Technically we cannot reach this point here?
Maybe it would be more defensive to

    BUG("How did we get here?");

or at least return something !=0 ?

>
> +test_expect_success 'reading submodules config with "submodule--helper config"' '

I shortly wondered if it would make sense to put these tests at the
beginning of either
this or a new file, as the functionality is rather fundamental. (I
never thought about
it, but actually it is better to go from common basic to more exotic
tests as you scroll
down the file), but this place is ok, if you choose to do so.

Thanks,
Stefan
