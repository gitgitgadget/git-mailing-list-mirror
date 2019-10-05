Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 483701F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 19:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbfJETk6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 15:40:58 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:40323 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfJETk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 15:40:58 -0400
Received: by mail-vk1-f195.google.com with SMTP id d126so2186240vkf.7
        for <git@vger.kernel.org>; Sat, 05 Oct 2019 12:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9x79l3bT4Pkr6S3wdzCEwW0xcKsBj5ETErxkmhjVNZM=;
        b=NHWK3Hes8Yw1lnWivaIW6yFiAqce5cJ1k4h6tC+fZWDoXniiKj3nuFzf/Ui0sWTzXG
         aw47FVqASXVCGkjNnTwcFeTSiq8GKCzSWj6FgM1jE7HQd9E3oCj9BxLjChIzf0RmY+v0
         i0vVfO1ytl+jXWSvClemE6RU9cLaARvXLPTobdsDF+C9GKCOHYX3iyz1RRZJ77Z75Kd6
         43uRmSKKO5bBDeAPDYQh5fnd6pv51NR9V1mn2eOsaYjrIh5Zms8IUb02ZXnlA8D4CbDG
         r2okABYWcu+/K3oaGKLjBlarv1soJL30XsiCdq7NYyRGTIg4r99yU20w2YmvjUaXc2w9
         TFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9x79l3bT4Pkr6S3wdzCEwW0xcKsBj5ETErxkmhjVNZM=;
        b=oBFJQ/qh4XufzCLDWmx72J8KfdvxBgEHS8EZbnZOCYnbO7wTM5y7Is2HqEkIq0c4U5
         VFkOQDdM0pFXEJr6qDcr/jKVS067uUe/mQ47g+ZNINHg2PbsV4vz7PQJmc55OHIIBEwm
         exskgTZJn2HYbBoK0DBSUhQ7te74WKUbxRA4+6unO8lmQZDi2lAVs0+0vDzzmKzW+7HF
         xCQKI8Erw3ZlSkXb7t6oyUX4QsTAbSeDQSfw/cS57/HTfJqC8Dt44mqP8/oQ05s8SlUu
         tLf2gdE9UJksWe36KBbQvdFEMdG+Jae92/Pf1rUaH3XEG6HB4jXva9Y0AuTgIY9y9s82
         725w==
X-Gm-Message-State: APjAAAU5NEMmUQnrhJ+1jJcwL+UQhEQBAHMAzslQAlbYO9nZxHT1yCRH
        /mtPos6BEH2Bta3UlGq3MY7ree37rrfl96NCdSQ=
X-Google-Smtp-Source: APXvYqzpKk7aF2BuPZExO+dqe1Uc4nVi4ZF7Y65DfbB3lbhDkNC5mHHFWaSlxKcj8mJoIAghTik4ady1OQnKZuAlGwc=
X-Received: by 2002:a1f:a3d8:: with SMTP id m207mr10866821vke.49.1570304457100;
 Sat, 05 Oct 2019 12:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.git.gitgitgadget@gmail.com> <pull.316.v2.git.gitgitgadget@gmail.com>
 <fef41b794a9886664616ce5e5c7902a82a474c2d.1568904188.git.gitgitgadget@gmail.com>
In-Reply-To: <fef41b794a9886664616ce5e5c7902a82a474c2d.1568904188.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 5 Oct 2019 12:40:46 -0700
Message-ID: <CABPp-BHaV+XX63Y46b8wHk0rHzdAbfDQDZAQe3pHcA63WerigA@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] clone: add --sparse mode
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 19, 2019 at 3:06 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> During the 'git sparse-checkout init' call, we must first look
> to see if HEAD is valid, or else we will fail while trying to
> update the working directory. The first checkout will actually
> update the working directory correctly.

This is new since the RFC series, but I'm not sure I understand.  Is
the issue you're fixing here that a 'git init somerepo' would hit this
codepath and print funny errors because HEAD doesn't exist yet and
thus the whole `git read-tree -mu HEAD` stuff can't work?  Or that
when the remote has HEAD pointing at a bad commit that you get error
messages different than expected?

> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 895479970d..656e6ebdd5 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -99,6 +99,7 @@ static int sparse_checkout_init(int argc, const char **argv)
>         char *sparse_filename;
>         FILE *fp;
>         int res;
> +       struct object_id oid;
>
>         if (sc_enable_config())
>                 return 1;
> @@ -120,6 +121,11 @@ static int sparse_checkout_init(int argc, const char **argv)
>         fprintf(fp, "/*\n!/*/\n");
>         fclose(fp);
>
> +       if (get_oid("HEAD", &oid)) {
> +               /* assume we are in a fresh repo */
> +               return 0;
> +       }
> +
>  reset_dir:
>         return update_working_directory();
>  }
