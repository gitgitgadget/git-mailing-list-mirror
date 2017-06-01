Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC37120D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 19:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751264AbdFAT2d (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 15:28:33 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36713 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbdFAT2c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 15:28:32 -0400
Received: by mail-pf0-f181.google.com with SMTP id m17so35553647pfg.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 12:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=z4g12WGun0T8Z9XcBetbgQJ15LlqYo+6vEIK0VcC0qo=;
        b=ghZymuA+KCfs9rMY6BmLi774Bsc+ZdBKvhhwowh62j2ux1s1w2sT2e1uLuKWMzDI8R
         enR6po6UE4erCPFJo8XW6UrtUeB6zF0yGfwlKH11RaNAQPRw8jfxWZS6rD65kfRcWPlr
         p/RADPuADxC+sFuGQu2LFOQGaRYKU4RqdpBIrm4ZfT9JRpKAvyZKdpWAf45dYyM92yYz
         i6KsMfsMRjXuOFPlxVRMEEpqhkKf3IrWnhyhKQV/IPTYSTSehkYWP9RZqdzKHNWIweDk
         ZU0pC806E62eWA6IvLVvh3/78+o6dqc1HgzzS6myyn9MgCK75MMv3O8YBH6XuRATTpE3
         4n4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=z4g12WGun0T8Z9XcBetbgQJ15LlqYo+6vEIK0VcC0qo=;
        b=LrE3z/sbHDIYju0CAbYPQI2FEbyp8r/HaeIU/Z6KYiUV2jQ+8ELZu7Jn3LR7LWQI4A
         EtE8TIN9UGCBJpaECVYF5hPPF7dXV4NVA1CLQwMDNYjMVZ6j7plkA00SiS19GYX+1br/
         C6z7W7F3fk65RIknjhzewGcKnp6CMwLz3jxEHT1uhvFaAxnqTDagcto+ttGxmIOWaskI
         688JdbOe5MlkNkRm4MYIJzS+3UVd0ugr7j59pczlhCLO7fWl5nJ929EWhJRq6wWbsyvv
         CCNZwR9hGeU2AcGfd/bzCcYlXFQTcO6Uvr9bUlQght+9UTwSCcnApvDlHS5jLeuCwZn6
         D9Eg==
X-Gm-Message-State: AODbwcCFEkLT0drIA8yXB51msJcFzAhK1Gs4rGJuYYKs8iiQH4IFbVt1
        qfEXNyGjA5Hlo9+3AneLTUJPY3FC8dMn
X-Received: by 10.98.205.65 with SMTP id o62mr2579832pfg.105.1496345311520;
 Thu, 01 Jun 2017 12:28:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Thu, 1 Jun 2017 12:28:31 -0700 (PDT)
In-Reply-To: <20170531214417.38857-6-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com> <20170531214417.38857-6-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 1 Jun 2017 12:28:31 -0700
Message-ID: <CAGZ79kZF3mk40P1rRvV57X=JWveNoCmdvKmkUO=fo8Ts=BkZrA@mail.gmail.com>
Subject: Re: [PATCH 05/31] environment: remove namespace_len variable
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 2:43 PM, Brandon Williams <bmwill@google.com> wrote:
> Use 'skip_prefix' instead of 'starts_with' so that we can drop the need
> to keep around 'namespace_len'.

Looks correct.

Performance wise:
The strip_namespace function is only called from {receive/upload}-pack
and http-backend, so all network operations, whose actual operations
should far outweight the tiny CPU saving that this reverts.
We should be fine?

> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  environment.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/environment.c b/environment.c
> index a73b08f5d..e035f6372 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -98,7 +98,6 @@ char *git_work_tree_cfg;
>  static char *work_tree;
>
>  static const char *namespace;
> -static size_t namespace_len;
>
>  static const char *super_prefix;
>
> @@ -190,7 +189,6 @@ void setup_git_env(void)
>         git_replace_ref_base = xstrdup(replace_ref_base ? replace_ref_base
>                                                           : "refs/replace/");
>         namespace = expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
> -       namespace_len = strlen(namespace);
>         shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
>         if (shallow_file)
>                 set_alternate_shallow_file(shallow_file, 0);
> @@ -231,9 +229,10 @@ const char *get_git_namespace(void)
>
>  const char *strip_namespace(const char *namespaced_ref)
>  {
> -       if (!starts_with(namespaced_ref, get_git_namespace()))
> -               return NULL;
> -       return namespaced_ref + namespace_len;
> +       const char *out;
> +       if (skip_prefix(namespaced_ref, get_git_namespace(), &out))
> +               return out;
> +       return NULL;
>  }
>
>  const char *get_super_prefix(void)
> --
> 2.13.0.506.g27d5fe0cd-goog
>
