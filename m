Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E941BC433ED
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 14:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B48610D1
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 14:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbhDBOqC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 10:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbhDBOqB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 10:46:01 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BBFC0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 07:45:59 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id u10so5827935lju.7
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 07:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lU+uyBxGqrKVw79w+HWaf8Nt+ZcGY4t7aXCzzD7yl5s=;
        b=yWDSmXKc92a1afntKvP9b/es0Gl1byPyZPRv2jaRHGxSkOn38lqkobU/PDuImtCYcs
         Z08O+gFfrJvkndsj6DXeqbhQhDKI4iN4DTWaNhBOZ8Zqif+qu/V2rSBrzn6AcxFo6kGs
         DeA2tOMh2DTl0f5QAQ1cRHGeTGlx+TYfLonsZe6DVHP8QUwZ86ETPo3UQfc67h07t1YA
         Jx+VUF6fH+z11g92l49ZahsI8S37td89I59Bnu3SPXsiQgYl7kZParOmMJfv1NNSwP6K
         KxUZ3iKIIGcyvQRayz8pTT+nEGNGHN4iHDUbgFLR5DbThZSnn/80df9fcv9uEO8agUQC
         Ts7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lU+uyBxGqrKVw79w+HWaf8Nt+ZcGY4t7aXCzzD7yl5s=;
        b=lyKBKy+xSbwlavUb/riNRCObi3praDPHuRuveqc1+5ZmCfM0O3YqmlZdNw51TJyUxI
         hZfOrns4s2JIKVf0Tz59BtusY+32TY18OcIMhQXjUB4x4g9z92ZJJ6WVt5m+WYmIAQYO
         Sn8wfYi24dMRdszEq+FFkyxuqJ1TKnfRZRf1oT1SgspZR7IEU55VWegyzeqiZAJtr2gJ
         TyCwWYViWn4j8Dx31g9sjniI5Yz7BOmpL9KzvI9rjyeHgKt5XLL/TJpPnaZVZpt9/Rlu
         FQfzQ4DtGGI2NDrYwDeU+VgDxLk1oKOZv9Fg7ZHAH2b+Ehe2vNMvjlNVufQa5TJv3Ui5
         7k1g==
X-Gm-Message-State: AOAM5329F3T52/TZik3GpCHO2oLQbredr+ELjdqfK4f3JK53xl6rd1Hl
        ecDs8riBwksQOmH8XFGkeWZYHJaOtb5ouahdcy7buQ==
X-Google-Smtp-Source: ABdhPJxz1+Ayk2JE0NRMbo8ilM7IBJgREFkq/8lCLYNrJzbIU55C9pT/YqQsQoCR4xPzCGeL6eOoFnVJIh7lasYmnUA=
X-Received: by 2002:a2e:9055:: with SMTP id n21mr8420514ljg.248.1617374758393;
 Fri, 02 Apr 2021 07:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616015337.git.matheus.bernardino@usp.br>
 <8c83e92445b4131e9b8f8e2aa29b00717b257d13.1616015337.git.matheus.bernardino@usp.br>
 <CAP8UFD3s3NUpi2eyPWFa5bL4rez1wNtj5-dUpv8dJLo2CKYu9A@mail.gmail.com>
In-Reply-To: <CAP8UFD3s3NUpi2eyPWFa5bL4rez1wNtj5-dUpv8dJLo2CKYu9A@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 2 Apr 2021 11:45:47 -0300
Message-ID: <CAHd-oW4jhoUz=4XZYC0HZPFTziyC1fw3DKQuR5rzSmmBgxiCCw@mail.gmail.com>
Subject: Re: [PATCH 3/5] parallel-checkout: add configuration options
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 31, 2021 at 1:33 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Mar 17, 2021 at 10:12 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
>
> > The above benchmarks show that parallel checkout is most effective on
> > repositories located on an SSD or over a distributed file system. For
> > local file systems on spinning disks, and/or older machines, the
> > parallelism does not always bring a good performance. For this reason,
> > the default value for checkout.workers is one, a.k.a. sequential
> > checkout.
>
> I wonder how many people are still using HDD, and how many will still
> use them in a few years.
>
> I think having 1 as the default value for checkout.workers might be
> good for a while for backward compatibility and stability, while
> people who are interested can test parallel checkout on different
> environments. But we might want, in a few releases, after some bugs,
> if any, have been fixed, to use a default, maybe 10, that will provide
> significant speedup for most people, and will justify the added
> complexity, especially as your numbers still show a small speedup for
> HDD when using 10.

Yeah, I agree that it would be nice to have a better default in the
near future. Unfortunately, on some other HDD machines that I tested,
parallel checkout was slower than the sequential version. So I think
it may not be possible to enable parallelism by default now.

Nevertheless, I was also experimenting with some ideas to auto-detect
if parallelism is efficient in a given environment/repo and
auto-enable it if so. One interesting possibility suggested by =C3=86var
[1] was to implement this as a git maintenance task, which could
periodically probe the system and tune the checkout settings
appropriately.

[1]: https://lore.kernel.org/git/87y2ixpvos.fsf@evledraar.gmail.com/

> > @@ -23,6 +25,19 @@ enum pc_status parallel_checkout_status(void)
> >         return parallel_checkout.status;
> >  }
> >
> > +#define DEFAULT_THRESHOLD_FOR_PARALLELISM 100
>
> Using a "static const int" might be a bit better.

Ok, I will change that.

> > +void get_parallel_checkout_configs(int *num_workers, int *threshold)
> > +{
> > +       if (git_config_get_int("checkout.workers", num_workers))
> > +               *num_workers =3D 1;
>
> I think it's better when an important default value like this "1" is
> made more visible using a "static const int" or a "#define".

Will do.

> > @@ -568,7 +581,7 @@ int run_parallel_checkout(struct checkout *state)
> >         if (parallel_checkout.nr < num_workers)
> >                 num_workers =3D parallel_checkout.nr;
> >
> > -       if (num_workers <=3D 1) {
> > +       if (num_workers <=3D 1 || parallel_checkout.nr < threshold) {
>
> Here we check the number of workers...
>
> >                 write_items_sequentially(state);
> >         } else {
> >                 struct pc_worker *workers =3D setup_workers(state, num_=
workers);
>
> [...]
>
> > @@ -480,7 +483,8 @@ static int check_updates(struct unpack_trees_option=
s *o,
> >                 }
> >         }
> >         stop_progress(&progress);
> > -       errs |=3D run_parallel_checkout(&state);
> > +       if (pc_workers > 1)
> > +               errs |=3D run_parallel_checkout(&state, pc_workers, pc_=
threshold);

> ...but the number of workers was already checked here.

The re-checking at run_parallel_checkout() is important because
`num_workers` might actually become <=3D 1 after the above check at
check_updates(). This happens when there aren't enough enqueued
entries for 2+ workers, so we fall back to sequential checkout. It
also kind of works as a safe-mechanism for the case where the
run_parallel_checkout() caller forgot to check if the user actually
wants parallelism before calling the function.
