Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E652B1F954
	for <e@80x24.org>; Sat, 18 Aug 2018 16:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbeHRTTX (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 15:19:23 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51248 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbeHRTTX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 15:19:23 -0400
Received: by mail-it0-f67.google.com with SMTP id e14-v6so15347084itf.1
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 09:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/TZ+2ST6aLpe8unSj1bssoO8777/QsoNLmefHmye7Tc=;
        b=rZv2fzoVopWxrreoYr6WdQ5KZROarCMvXvJGazFrCe6G28owIfBNGURDzNdc7CgkLh
         Ogq2t6kJ1furrv+Fapglt6qUM1b13sh4dSpA2Ko4wNNwnx7X6vLIvmikq6uKjCU4pWGs
         tGFL53JrRxVzDxrB7elfOvd8qBQjsoa4oaDTLQN+/ulDr0i4hEHrvVSqhxpriQs6LQnF
         BJPcKgFp8LQn0s5QLy3icEpvdpn3b8llyZLfe3DrGZPPWHE8DtemkhOz024BksAIcYTo
         IfVYUTadz5zoxtRfX6ecubBtOUYvjNx8uoEVziMfdLDnViG+94F0xtlWR2q3aB8LnSd/
         wFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/TZ+2ST6aLpe8unSj1bssoO8777/QsoNLmefHmye7Tc=;
        b=iCBd57jhSfyJgICaz5sBJGbbNREfGM+Zx+pyW/EkOMO1TtkiTMsNESn8JxrERqyNd/
         IKhW1610zWo0YqGtjoJAAMhksr9awj6B9aML7giLqz2K2eI6O7NjHTQYH/C/OEEROXXX
         Jqza4rpGu7KOCE6L/hxoqKN3SSeQaS4X8+clfJH2iPb+ZzIALA2RnAMYGZhqjc31AHnd
         HkREwQQIkrJc8q38FreHQDc22/9uj7LWCm8i5l79p82rm1XLKIv+KepgTq9rdjCK4O/a
         5+K1pnPTzPoXz94Z3A3n4CEcW6NL9rttCXdSltM5lXkPub5gn+Dmp9+vKLJ+2vfFFifH
         dpPw==
X-Gm-Message-State: AOUpUlFUM6eQlZQUZwxrl6U6lCbRtwKpyDC7UOr2b/lXNKa0Z5tXohGn
        E6TNp0EqBJ6i0hN9mxfNpYd8ihWF81ouaYU2nnDS/A==
X-Google-Smtp-Source: AA+uWPy+IX3YNeVeMdnK48GlOSGlfLtoO9YT9cSOQCbX+gAAFdZnWrBAHXvqx5zXC1xKySQySi7kQBBxunAnxxAeWzU=
X-Received: by 2002:a24:144:: with SMTP id 65-v6mr7464988itk.62.1534608669857;
 Sat, 18 Aug 2018 09:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180803222322.261813-1-sbeller@google.com> <20180813224235.154580-1-sbeller@google.com>
 <20180813224235.154580-8-sbeller@google.com>
In-Reply-To: <20180813224235.154580-8-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 18 Aug 2018 18:10:44 +0200
Message-ID: <CACsJy8BWTd5LEtZ00z7a1sOwx3n=RfPDqguNb+zTW0CZUUyJaA@mail.gmail.com>
Subject: Re: [PATCH 7/7] submodule--helper: introduce new update-module-mode helper
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 12:45 AM Stefan Beller <sbeller@google.com> wrote:
> +static int module_update_module_mode(int argc, const char **argv, const char *prefix)
> +{
> +       const char *path, *update = NULL;
> +       int just_cloned;
> +       struct submodule_update_strategy update_strategy = { .type = SM_UPDATE_CHECKOUT };
> +
> +       if (argc < 3 || argc > 4)
> +               die("submodule--helper update-module-clone expects <just-cloned> <path> [<update>]");

Maybe _() ?
-- 
Duy
