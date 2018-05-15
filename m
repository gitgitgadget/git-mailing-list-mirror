Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 646BE1F406
	for <e@80x24.org>; Tue, 15 May 2018 01:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeEOBdq (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 21:33:46 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:39138 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752024AbeEOBdp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 21:33:45 -0400
Received: by mail-yw0-f196.google.com with SMTP id v132-v6so4190976ywc.6
        for <git@vger.kernel.org>; Mon, 14 May 2018 18:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Yq9lZ5oaMbcGst5D4IF5s04HLzK44tP+cJYRTG2Q2OQ=;
        b=aiLHYCZup9f/XD5b9BMJyHMz5njsWYUElqCJ5nEyP+jvWFIw9ZQMWxDf0DJG9QzQoe
         LnWW96FweIw838182iLyPC2tU6A3IKUw3ajjgXUj1pQYo4zWmBvWFLPfZmoo3cdG5PwF
         /ONTYTVubK4PK3R1y4MInpAjGq+ZLrO4TXvr/j+tIoDqC8m3JUYY19kaltgki7JFUrvM
         T1JfOAuaTI0wacYe2A3HMZEl11sm4x0gzQ9SUihW0dd+PQawyKAUN40GvKvJxLfZcaPw
         ilFoe36Uf7rIfDoNRgi6Kovg4ZoZQdtlTFXOTj2J49zP1H84f6eKYz/pnwSQsztZx8GN
         mMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Yq9lZ5oaMbcGst5D4IF5s04HLzK44tP+cJYRTG2Q2OQ=;
        b=fPJGSKH5JP8sYuZ7+SG/Kk60o6ljIeo0P1790j8SYG5LNrbci45/8Fd7p4x4euZoOD
         dWI3rH9sf1cJCetvjNQxqrDyDGacT7Z/IV3t6uwGBGBP57UrAlPO2wPaxFwB++zFzLvC
         DKMitKSHSbP/k5s8VhAmMnJ8dnphAdk2YZDp0Nibaun93crYQVfnFE28fhrKbMqVwwce
         aIY60FVtS0nZycRT0xZTtR2svWLlr+OU0N+6mqvTLdO0PTimoBKkuwZsJN8UWUnFMYNH
         fCNNOCmCyWf8lyfu8+VeLd8AO0SBL38M5UZUoxuxZgk8ey7TqWHIB93SW5YOq5ZRCtZw
         IenQ==
X-Gm-Message-State: ALKqPwfczMxZavkGJZ3anH6pIuYWwLCU7KQrk3efZaE6t2G+7bccQ9QH
        GLThtHFt7LspAEj34/3f3pee5nED9mrBiiu8Kh7TeAdHC28=
X-Google-Smtp-Source: AB8JxZoY+5YIl3UPWhDWpao47FE3nPFCXEPjvKeXTH0tD5Wa7rJxhNcwkTi1qnl3K8dZW73MotuKzgvinKMEhRKtEvg=
X-Received: by 2002:a0d:fd84:: with SMTP id n126-v6mr5535176ywf.33.1526348024656;
 Mon, 14 May 2018 18:33:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Mon, 14 May 2018 18:33:44
 -0700 (PDT)
In-Reply-To: <20180514105823.8378-5-ao2@ao2.it>
References: <20180514105823.8378-1-ao2@ao2.it> <20180514105823.8378-5-ao2@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 14 May 2018 18:33:44 -0700
Message-ID: <CAGZ79kbkDO8KEm6ps75xTykU2JCVwHVVpOr+Eq_RQy_bn-jRCw@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] submodule--helper: add a new 'config' subcommand
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

On Mon, May 14, 2018 at 3:58 AM, Antonio Ospite <ao2@ao2.it> wrote:
> Add a new 'config' subcommand to 'submodule--helper', this extra level
> of indirection makes it possible to add some flexibility to how the
> submodules configuration is handled.
>
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> ---
>  builtin/submodule--helper.c | 39 +++++++++++++++++++++++++++++++++++++
>  t/t7411-submodule-config.sh | 26 +++++++++++++++++++++++++
>  2 files changed, 65 insertions(+)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 9e8f2acd5..b32110e3b 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1825,6 +1825,44 @@ static int is_active(int argc, const char **argv, const char *prefix)
>         return !is_submodule_active(the_repository, argv[1]);
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
> +static int module_config(int argc, const char **argv, const char *prefix)
> +{
> +       int ret;
> +
> +       if (argc < 2 || argc > 3)
> +               die("submodule--helper config takes 1 or 2 arguments: name [value]");
> +
> +       /* Equivalent to ACTION_GET in builtin/config.c */
> +       if (argc == 2) {
> +               char *key;
> +
> +               ret = git_config_parse_key(argv[1], &key, NULL);
> +               if (ret < 0)
> +                       return CONFIG_INVALID_KEY;
> +
> +               config_from_gitmodules(config_print_callback, the_repository, key);
> +
> +               free(key);
> +               return 0;
> +       }
> +
> +       /* Equivalent to ACTION_SET in builtin/config.c */
> +       if (argc == 3)
> +               return config_gitmodules_set(argv[1], argv[2]);

Ah, here we definitely want to set it in the .gitmodules file?
(Or does that change later in this series?)

> +
> +       return 0;
> +}
> +
>  #define SUPPORT_SUPER_PREFIX (1<<0)
>
>  struct cmd_struct {
> @@ -1850,6 +1888,7 @@ static struct cmd_struct commands[] = {
>         {"push-check", push_check, 0},
>         {"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
>         {"is-active", is_active, 0},
> +       {"config", module_config, 0},
>  };
>
>  int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
> diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
> index a648de6a9..dfe019f05 100755
> --- a/t/t7411-submodule-config.sh
> +++ b/t/t7411-submodule-config.sh
> @@ -139,4 +139,30 @@ test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
>         )
>  '
>
> +test_expect_success 'reading submodules config with "submodule--helper config"' '
> +       (cd super &&

I think the project prefers a style
of the cd at the same level of the echo and the following commands.

However we might not need the (cd super && ...) via

  echo "../submodule"  >expected
  git -C super ubmodule--helper config submodule.submodule.url >../actual
  test_cmp expected actual

Our friends developing git on Windows will thank us for saving
to spawn a shell as spawning processes is expensive on Windows. :)
Also we have fewer lines of code.

The patch looks good to me,
Thanks,
Stefan
