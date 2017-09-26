Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 899C120281
	for <e@80x24.org>; Tue, 26 Sep 2017 23:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030601AbdIZXhZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 19:37:25 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36406 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030538AbdIZXhY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 19:37:24 -0400
Received: by mail-wm0-f66.google.com with SMTP id r136so10143894wmf.3
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 16:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TkbITSnexIF2LvE5OqrgcaSF+IbTq07udMAhLQWnaqQ=;
        b=UuodilcwQ7gdcI2fP44CaWsydS2iGRzIokwNW1JgFg0jARAChwYNHRTmp8+xjAY+aP
         XXYrcB7aXsdjk2kc0uptyEIhQDYWStg3+twyLAC2u0Qm4e6iDPTun1FssNUVMB1wNgHN
         lF4jHUK7TPvoSIErNag5lVjvNw9ScCFoF7RfRwve6sU8u8CwXp759dd1RnLNmti3Sbt/
         hGHTmt0gikd88FK7vcSfCj1GdfYhaSoGDvqEy1ImTRKIPK31EkBNyQzjWXl+5caxjvu2
         aZbLdwlpYjEcmOBxRv3jM3Py9waDC9vp9kE6SfdHB4P6vZ0ou2PGcVX0pCnzelklVr51
         7gxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TkbITSnexIF2LvE5OqrgcaSF+IbTq07udMAhLQWnaqQ=;
        b=mImVRaqsH+aO5nSaRGIBxC/emb1pz58HTQ17KJNeOmtROF4LaPckPUaAAwVqwAOvt4
         NtkYLwm7Pote837cMp5lTKD/Ysz8kir+p7GddPBMN+PVZOXgFKV0Ub8FCJYVivlGTqGJ
         0MdH5TEsXrFEmh0PzQkFqNRzWoanTF7wB0VHUCBgMqyxonWxMTHkrqJHMwnHCKK+tDRL
         /7kMf/YfKme5pqLsQzQXRfBPTAgd8mMRfq5OC0tyAoRGzEl3LZ/Jn1/AhfvDkE08yvCY
         FLXFLfxTfD9LL3V3XubKxj1f6OTLzPSuR002sg77JzYw1s+P2ghUNOc29BMWgAXOOUas
         sEhg==
X-Gm-Message-State: AHPjjUia5MB8hacAE+UB7Erm2jPPHJTZ/zrZ2JmJrHtNYYicdf8AX39g
        5Z+PjRnhjXuWwj5isBqBjMSKwz9CqhKyYM4s4bg=
X-Google-Smtp-Source: AOwi7QCvWl2grmj9SikT9e4HnVVyxG/eXDdDKRQqlousbc/2jYFL01jdAq0D/r8VQJjKBwIyb3j4nKmUI2U8xjENsUk=
X-Received: by 10.80.204.151 with SMTP id q23mr19619462edi.104.1506469042690;
 Tue, 26 Sep 2017 16:37:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.213.80 with HTTP; Tue, 26 Sep 2017 16:37:02 -0700 (PDT)
In-Reply-To: <20170926182756.13319-1-sbeller@google.com>
References: <20170926182756.13319-1-sbeller@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 26 Sep 2017 16:37:02 -0700
Message-ID: <CA+P7+xr6_7BW0q7iZsMdeexFff=A-8rp8Lfds2NTXmvu1tOqCw@mail.gmail.com>
Subject: Re: [PATCH] submodule: correct error message for missing commits.
To:     Stefan Beller <sbeller@google.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 26, 2017 at 11:27 AM, Stefan Beller <sbeller@google.com> wrote:
> When a submodule diff should be displayed we currently just add the
> submodule objects to the main object store and then e.g. walk the
> revision graph and create a summary for that submodule.
>
> It is possible that we are missing the submodule either completely or
> partially, which we currently differentiate with different error messages
> depending on whether (1) the whole submodule object store is missing or
> (2) just the needed for this particular diff. (1) is reported as
> "not initialized", and (2) is reported as "commits not present".
>
> If a submodule is deinit'ed its repository data is still around inside
> the superproject, such that the diff can still be produced. In that way
> the error message (1) is misleading as we can have a diff despite the
> submodule being not initialized.
>
> Downgrade the error message (1) to be the same as (2) and just say
> the commits are not present, as that is the true reason why the diff
> cannot be shown.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>

This makes sense to me.

Thanks,
Jake

> ---
>  submodule.c                               | 2 +-
>  t/t4059-diff-submodule-not-initialized.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 6531c5d609..280c246477 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -567,7 +567,7 @@ static void show_submodule_header(FILE *f, const char *path,
>
>         if (add_submodule_odb(path)) {
>                 if (!message)
> -                       message = "(not initialized)";
> +                       message = "(commits not present)";
>                 goto output_header;
>         }
>
> diff --git a/t/t4059-diff-submodule-not-initialized.sh b/t/t4059-diff-submodule-not-initialized.sh
> index cd70fd5192..49bca7b48d 100755
> --- a/t/t4059-diff-submodule-not-initialized.sh
> +++ b/t/t4059-diff-submodule-not-initialized.sh
> @@ -95,7 +95,7 @@ test_expect_success 'submodule not initialized in new clone' '
>         git clone . sm3 &&
>         git -C sm3 diff-tree -p --no-commit-id --submodule=log HEAD >actual &&
>         cat >expected <<-EOF &&
> -       Submodule sm1 $smhead1...$smhead2 (not initialized)
> +       Submodule sm1 $smhead1...$smhead2 (commits not present)
>         EOF
>         test_cmp expected actual
>  '
> --
> 2.14.0.rc0.3.g6c2e499285
>
