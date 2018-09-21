Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D3421F453
	for <e@80x24.org>; Fri, 21 Sep 2018 16:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390208AbeIUWJY (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 18:09:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47073 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIUWJY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 18:09:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id z3-v6so1585489wrr.13
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 09:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fRZ5bENg4FCUtkLI+pvCDC8ck9zsWnKof6DnL+32mIw=;
        b=VVnunrC97tpF2NyjiOgsmnMXYKKGUYxFRUr7+Yn6iyHC2bi3mnUXKZ/cXlXgiOWkbM
         w2PHfjsIW1Z9IUvp/c9IFD3htFUMiQGFyyGvs8gUN2JsHgy1ACPuYC+K6xqW0gl9zQp9
         Hf4UOY72MuSTcz+qLU0BxV/pTHaMPC2c8ArRPs3vTi+Li98gLsjy0jhQ/78667MH8N3B
         X7+EGHJ/efOvyhK/aQJiJNlEv7hqSExPCkL6571CuSZeNTBuutUDYjL6L/stQetR79Nu
         LU6gV8WlSHI8TcLLbChk766FQYIQZEjQF68UOd/nqWeSeq7RyhGs5zVZUREClyypih9j
         YXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fRZ5bENg4FCUtkLI+pvCDC8ck9zsWnKof6DnL+32mIw=;
        b=Ns3NKf+qnqjvFJE7mpOOZkJuM8KB5+zICBFh2ws0CG8M0lH+r+JvYm5Ikkz9O3jFOo
         qh9aJ7ADnkiZ9IzgaqRBYO6HkMnyoeALY2EcL9+UHsm5zXhquM45ujZRSspN9NM4kgz1
         XNCglNTJ8At3B8gOvHN/BOoATEDzVweXurCY+YCIz9bnw9cA1WpFiSIfPrb2dU9mi/JF
         Fro8rSyZ7a6t2f41vDYnHrM2eu3pNleonOcU1iOapZCvwAs5D4ZSe5KQO0aJni7N3HWA
         WXa3Jn7NFbMR45tb1LdMSIVO7XSmS3tN358nz4tJkZnPb5YVIqN4nLD+C2R83gGRtViQ
         jISg==
X-Gm-Message-State: APzg51CzQ7pzmG+kJkUFUWQXnMaAeTxy+ff4doXpbNSiPwn2aZdZGirs
        9NiiDAnkaxBcTi5L8GhDYiE=
X-Google-Smtp-Source: ANB0VdZXLKTI5UwUlrtMmHNu+ktj35Hx5exuHw0vgiKpAZSSwXUEdHJQyX1ecdYD5SSaWk0ATI1e4w==
X-Received: by 2002:a5d:4512:: with SMTP id s18-v6mr40014895wrq.82.1537546786690;
        Fri, 21 Sep 2018 09:19:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j20-v6sm3947630wmh.9.2018.09.21.09.19.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 09:19:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Daniel =?utf-8?Q?Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5 9/9] submodule: support reading .gitmodules when it's not in the working tree
References: <20180917140940.3839-1-ao2@ao2.it>
        <20180917140940.3839-10-ao2@ao2.it> <20180918171257.GC27036@localhost>
        <20180920173552.6109014827a062dcf3821632@ao2.it>
Date:   Fri, 21 Sep 2018 09:19:45 -0700
In-Reply-To: <20180920173552.6109014827a062dcf3821632@ao2.it> (Antonio
        Ospite's message of "Thu, 20 Sep 2018 17:35:52 +0200")
Message-ID: <xmqq5zyyyg9q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antonio Ospite <ao2@ao2.it> writes:

> Protecting the problematic submodules function could work for now, but
> I'd like to have more comments, my proposal is:
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 601f801158..52b45de749 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -427,6 +427,11 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
>         if (repo_submodule_init(&submodule, superproject, path))
>                 return 0;
>
> +       grep_read_lock();
> +       /*
> +        * NEEDSWORK: repo_read_gitmodules accesses the object store which is
> +        * global, thus it needs to be protected.
> +        */
>         repo_read_gitmodules(&submodule);
>
>         /*
> @@ -439,7 +444,6 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
>          * store is no longer global and instead is a member of the repository
>          * object.
>          */
> -       grep_read_lock();
>         add_to_alternates_memory(submodule.objects->objectdir);
>         grep_read_unlock();

I think this is in line with how the grep codepath protects itself
when doing anything that accesses the object store.

Thanks.
