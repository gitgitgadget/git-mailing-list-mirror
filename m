Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCCB7201A7
	for <e@80x24.org>; Fri, 12 May 2017 22:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756098AbdELWD1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 18:03:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36391 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754683AbdELWD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 18:03:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id u65so16132572wmu.3
        for <git@vger.kernel.org>; Fri, 12 May 2017 15:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=28ZmHq1GHJelsD/Bity9KEODNr5/ZblW1JJg08LRWm4=;
        b=PQk6W2w2He5zj7vq+TzqCRFC6zwk42L8RxpPYBBwRn1RsLIOx4XuDJK2Qa2VB0nWUO
         ApgfGK5f589zkIsEnAbQhz+kwQgbnN2y6Sq8i8aJNnXzLyl2KvwWZOe3U5xpvi8yC4i3
         zXpdk8kABhPSoeLPRfYoxvzoxGpz5Gw0S8fG6WDMravBrr/fykKWh45Xnm2aW/ZxELBd
         noYT3GMhF8/MkfcluzlxlCXlvk7v/8yh4AglZBaejpfmiI73u2TpEIGFArphQH11rxc7
         xADXDw9c1fyc5xmbmKphRhnYBSWNE+fiTm+bl0CBFnnlW0seI8LYYPkDJSA4wmw9Gbip
         +1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=28ZmHq1GHJelsD/Bity9KEODNr5/ZblW1JJg08LRWm4=;
        b=V4b0Ph6m7wt+wd+mVHk1I0B1Som19ouwsY/WDes4TB3uJhPHGxsPrLaz43omRXfUBn
         jFqS70TyPzd+44ihZZaizOVz1n0Aq6sePrdEClUJLh048pF07Tt2y/JxfKz1hiEQcuZH
         bbhCjxsm1ck3cpEafUIbWKR/X4uwNWj+7gGwUuTERT0WzFrRn3ZrzAXP+u6Iawd2PqXf
         fZY+yILR9FogpH9XPYBnvuHWbkICJLwJbZPGka4Y/+2fMCC9a8iqNSni/t+xL1CRMkvi
         6rQNwD6OGAhwSTiCO6u7Fjd6lkFlP++P085N6KWd6sMTEK/P6d4BbpBiYHv3htl5T5p4
         45nA==
X-Gm-Message-State: AODbwcCWXg2NZ+6sKfOVysoJqVm7JjWY5yNgaZ5r7DbilK5C2YDyvpCQ
        wXobKsRUcGWDo1UiRf/yuN3UAxCG1tkC
X-Received: by 10.28.146.2 with SMTP id u2mr3575401wmd.94.1494626605211; Fri,
 12 May 2017 15:03:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.100.213 with HTTP; Fri, 12 May 2017 15:03:04 -0700 (PDT)
In-Reply-To: <20170512213407.46251-1-sandals@crustytoothpaste.net>
References: <20170512213407.46251-1-sandals@crustytoothpaste.net>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Fri, 12 May 2017 16:03:04 -0600
Message-ID: <CAMMLpeTYvK+yow8R83Yf-kOFOZngFEfYsoQeXuTOL0tZOE3XTA@mail.gmail.com>
Subject: Re: [PATCH] builtin/log: honor log.decorate
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-05-12 15:34 GMT-06:00 brian m. carlson <sandals@crustytoothpaste.net>:
> The recent change that introduced autodecorating of refs accidentally
> broke the ability of users to set log.decorate = false to override it.
> When the git_log_config was traversed a second time with an option other
> than log.decorate, the decoration style would be set to the automatic
> style, even if the user had already overridden it.  Only set the option
> to its default value if we haven't set it already.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/log.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index b3b10cc1e..304923836 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -34,7 +34,7 @@ static int default_abbrev_commit;
>  static int default_show_root = 1;
>  static int default_follow;
>  static int default_show_signature;
> -static int decoration_style;
> +static int decoration_style = -1;
>  static int decoration_given;
>  static int use_mailmap_config;
>  static const char *fmt_patch_subject_prefix = "PATCH";
> @@ -410,7 +410,7 @@ static int git_log_config(const char *var, const char *value, void *cb)
>                 if (decoration_style < 0)
>                         decoration_style = 0; /* maybe warn? */
>                 return 0;
> -       } else {
> +       } else if (decoration_style == -1) {
>                 decoration_style = auto_decoration_style();
>         }
>         if (!strcmp(var, "log.showroot")) {

Sorry for the mistake. On second thought, I think we should set
decoration_style = auto_decoration_style() in init_log_defaults.

-Alex
