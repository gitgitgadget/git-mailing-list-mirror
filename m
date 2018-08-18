Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52AD11F954
	for <e@80x24.org>; Sat, 18 Aug 2018 16:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeHRTIS (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 15:08:18 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:38902 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeHRTIR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 15:08:17 -0400
Received: by mail-it0-f67.google.com with SMTP id v71-v6so15483980itb.3
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 09:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s2tZdE55mGZD6Df0U/ev4u+UgGTNZtCOx+SIpKjGpjc=;
        b=b+8ohZ7jEWnX247dDvAghL2/pWlxTQkI15pEVUCEoLjwR3PN0bTRqGf77uYU1etyX0
         YFphVDSN8pTY1pPD4PebYEYEwkdkXAiezy9aEm8brL7JOEiEkUZ+Jn5adal14XqtHSCk
         YBCJ6CN0jHqXbkVmSjxBInfWz0tsXSekrjynoOivutKbvSel5YIXKmE6zxgYIhrq4CPO
         zjD1S7IUBbJefWfLopwjsmyOPFjpMN3vtah3mN/h2PI3Fa2+DXfQAc+FSQz+4ySN9HWl
         uxFH93Yx78QjdMOmT0CMpEqAzDvOmPGMuc4RLuGm1QRTjuI8TgtE5Yj+Z8j5BK3OfKnE
         1ugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s2tZdE55mGZD6Df0U/ev4u+UgGTNZtCOx+SIpKjGpjc=;
        b=lWnAtd8yYPxO51aNo3KWwGelly3QyIhULYY9BeSKHA5mHBkEDFTR3kzcSrwN5bYVdM
         lAQBg4EVpHR4gKtovMLo7hbdMOxrGINJBwzY1WZNfyR0j9NpVUnPLeNGP1MYGS6e3646
         ve5yL5rjB8dY9moxcx5XlzBdr0e3lh/t5lAEQ/WgH1DUtPKNJ5FfyG1qZ0WyVABP2E4D
         8ni/Iex2gCYL8zscCK4QgCCrPQbRrLLTEgGl+AHv1P41q2bjRyASeLNkuTnoJ1OVf6C7
         i9zEUc29Oeu5eDT15MAQOrPF+tUNJlz8C/+qxM0sMRO98CBFrrB+wrdVFvA1cdTy1DbL
         sdjQ==
X-Gm-Message-State: AOUpUlE01fJcnQGmNAs6NFg+BVQOZpUJOwVG/j/6M/ywQTbZTztLDd7l
        Rmv1we12vkoZrPU/p/do3BukVWXRGBYUZ595/yOVhQ==
X-Google-Smtp-Source: AA+uWPxEgNabHQ5SbzGUYbzGv7yie7sFBaSsoi/oXLcGPdlrhRSqes5BmE7FkWsDzcT8bD5baJUWyU1ZJ5B6XfR9TZo=
X-Received: by 2002:a24:144:: with SMTP id 65-v6mr7434387itk.62.1534608006936;
 Sat, 18 Aug 2018 09:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180808152140.14585-1-predatoramigo@gmail.com> <20180808152140.14585-12-predatoramigo@gmail.com>
In-Reply-To: <20180808152140.14585-12-predatoramigo@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 18 Aug 2018 17:59:41 +0200
Message-ID: <CACsJy8CS5aABuQrqWxdfLOTbFRhQDQ+tFO+wOCLTdeJG8mH0hw@mail.gmail.com>
Subject: Re: [PATCH 11/18] builtin rebase: support `--autostash` option
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>, alban.gruin@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 8, 2018 at 5:26 PM Pratik Karki <predatoramigo@gmail.com> wrote:
> @@ -224,13 +219,56 @@ static int read_basic_state(struct rebase_options *opts)
>         return 0;
>  }
>
> +static int apply_autostash(struct rebase_options *opts)
> +{
> +       const char *path = state_dir_path("autostash", opts);
> +       struct strbuf autostash = STRBUF_INIT;
> +       struct child_process stash_apply = CHILD_PROCESS_INIT;
> +
> +       if (!file_exists(path))
> +               return 0;
> +
> +       if (read_one(state_dir_path("autostash", opts), &autostash))
> +               return error(_("Could not read '%s'"), path);
> +       argv_array_pushl(&stash_apply.args,
> +                        "stash", "apply", autostash.buf, NULL);
> +       stash_apply.git_cmd = 1;
> +       stash_apply.no_stderr = stash_apply.no_stdout =
> +               stash_apply.no_stdin = 1;
> +       if (!run_command(&stash_apply))
> +               printf("Applied autostash.\n");

I think you need _() here.

> +       else {
> +               struct argv_array args = ARGV_ARRAY_INIT;
> +               int res = 0;
> +
> +               argv_array_pushl(&args,
> +                                "stash", "store", "-m", "autostash", "-q",
> +                                autostash.buf, NULL);
> +               if (run_command_v_opt(args.argv, RUN_GIT_CMD))
> +                       res = error(_("Cannot store %s"), autostash.buf);
> +               argv_array_clear(&args);
> +               strbuf_release(&autostash);
> +               if (res)
> +                       return res;
> +
> +               fprintf(stderr,
> +                       _("Applying autostash resulted in conflicts.\n"
> +                         "Your changes are safe in the stash.\n"
> +                         "You can run \"git stash pop\" or \"git stash drop\" "
> +                         "at any time.\n"));
> +       }
> +
> +       strbuf_release(&autostash);
> +       return 0;
> +}
> +
>  static int finish_rebase(struct rebase_options *opts)
>  {
>         struct strbuf dir = STRBUF_INIT;
>         const char *argv_gc_auto[] = { "gc", "--auto", NULL };
>
>         delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
> -       apply_autostash();
> +       apply_autostash(opts);
>         close_all_packs(the_repository->objects);
>         /*
>          * We ignore errors in 'gc --auto', since the
-- 
Duy
