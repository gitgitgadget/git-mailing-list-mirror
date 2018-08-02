Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15CB71F597
	for <e@80x24.org>; Thu,  2 Aug 2018 18:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbeHBT50 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 15:57:26 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:46476 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeHBT50 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 15:57:26 -0400
Received: by mail-yb0-f195.google.com with SMTP id c3-v6so1548071ybi.13
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 11:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxOA4+U5JcrdNZ97SU6zlkzI1iw1IDMuH0m3cNWWssg=;
        b=PFJa2Gy1NawXw9FEGaHdpbI41M7d9gVhIvsn36Uh8z/C7s1HZ99GNYgfhvycj22oya
         f8DSUG+la2VaxIqqQ3hJ01Eb5NtGP9mZ3aVttIH+SgWMJqxjEdEE+9I33/fuz0gMMZFA
         oxSKz4DGRn+gVmO9GouPOJTFGq3I4Y2xXq9oefHXiH5Cx+f0xRZrjzxTKYWHZMNh2hxc
         KTGq4mAhvWfoijDCKeJtpI6vaBSodmnouT76UmurjNgcI5KoVpeqII0+jYRz71Hx7fx4
         MflMgYgmhVjZYkOekFsGOovRWeRb1JPtc9jES4okHgDrlyMjKyUmEhv/LQLit8ztCfOi
         aYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxOA4+U5JcrdNZ97SU6zlkzI1iw1IDMuH0m3cNWWssg=;
        b=qhBpRwJ5wZujF3p23e2nMTkK597Q0Y2lOv9r+3DonVOj7cCiEKOyI6aUoh7lynmVNK
         zNuGAK+lmeCaGO7p898aYlzqhExQFd9pm7k+/qux/ylrybBhr2nsEFglEAKeyZ++f5g+
         oEcuvycGdwl1arKvXGUOwwlMWLpbHUFenOz4D7Tz3VRBIgFUG82Z0KyAebDy5mNR98fA
         JeDQYM/sTk55U2J80o/gH+NdI09cWYdmPrj7iVUgaH1gnih6eLbN+uYMcvSpcYTrlbZc
         bKw9c+R09L8P5I8ILvKAI9iimV7jQz72GKePtvgePISBu/9HQOamCkgLXGA9BzyvpfeP
         zWAA==
X-Gm-Message-State: AOUpUlHXIBIIehoG0XYPZl9voTSyANzoFqyoilYA7+3ShQXBHwGG8eq2
        N6ur5YxdyiBT+EJCpz8TFZ/YKLjJPeUjmPeWD0TYfg==
X-Google-Smtp-Source: AAOMgpefEh8lnfvfmfaujoAQucEBBYpmWJ/dAhVXIHSfMoxr6RGZg8kJHQu4HcfOaIwL6OT5/DYYzI82zR19nSE/9R0=
X-Received: by 2002:a0d:c944:: with SMTP id l65-v6mr365620ywd.414.1533233113394;
 Thu, 02 Aug 2018 11:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180802134634.10300-1-ao2@ao2.it> <20180802134634.10300-2-ao2@ao2.it>
In-Reply-To: <20180802134634.10300-2-ao2@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 2 Aug 2018 11:05:02 -0700
Message-ID: <CAGZ79ka-rbOiwWrwbW2vJW9ZOgSas23LkfmzBRLfK=g_cW=MhA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 01/12] submodule: add a print_config_from_gitmodules()
 helper
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
> This will be used to print values just like "git config -f .gitmodules"
> would.
>
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> ---
>  submodule-config.c | 25 +++++++++++++++++++++++++
>  submodule-config.h |  2 ++
>  2 files changed, 27 insertions(+)
>
> diff --git a/submodule-config.c b/submodule-config.c
> index 2a7259ba8b..6f6f5f9960 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -682,6 +682,31 @@ void submodule_free(struct repository *r)
>                 submodule_cache_clear(r->submodule_cache);
>  }
>
> +static int config_print_callback(const char *key_, const char *value_, void *cb_data)
> +{
> +       char *key = cb_data;
> +
> +       if (!strcmp(key, key_))
> +               printf("%s\n", value_);
> +
> +       return 0;
> +}
> +
> +int print_config_from_gitmodules(const char *key)
> +{
> +       int ret;
> +       char *store_key;
> +
> +       ret = git_config_parse_key(key, &store_key, NULL);
> +       if (ret < 0)
> +               return CONFIG_INVALID_KEY;
> +
> +       config_from_gitmodules(config_print_callback, the_repository, store_key);
> +
> +       free(store_key);
> +       return 0;
> +}
> +
>  struct fetch_config {
>         int *max_children;
>         int *recurse_submodules;
> diff --git a/submodule-config.h b/submodule-config.h
> index dc7278eea4..6fec3caadd 100644
> --- a/submodule-config.h
> +++ b/submodule-config.h
> @@ -56,6 +56,8 @@ void submodule_free(struct repository *r);
>   */
>  int check_submodule_name(const char *name);
>
> +extern int print_config_from_gitmodules(const char *key);

The only real pushback for this patch I'd have is lack of documentation
in public functions, though this is pretty self explanatory; so I'd be fine
for lacking the docs here.

In case a resend is needed, please drop the extern keyword here.

Thanks,
Stefan
