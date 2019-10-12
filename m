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
	by dcvr.yhbt.net (Postfix) with ESMTP id C75041F4C0
	for <e@80x24.org>; Sat, 12 Oct 2019 22:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfJLW71 (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Oct 2019 18:59:27 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41414 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfJLW71 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Oct 2019 18:59:27 -0400
Received: by mail-vs1-f66.google.com with SMTP id l2so8544650vsr.8
        for <git@vger.kernel.org>; Sat, 12 Oct 2019 15:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l1C0FAGjtz+oqWcd7zBNG3epHIjoF2CiCJgAa7agNOA=;
        b=OFtrUovU/UDsNQDbjBQSvoAR6nZhJeMgvbdCa1UiCPpFrwK1OXSGji9k4vZZn3WcV1
         A4XWRoAV1k6arXiIXaCDRBtZJCCYWeXRT4cnkh8rhGXYaKIoDkC58ryOg7wATbOXDCiE
         OL+fi5KQJ7ZnhYanBLmgPCyzgsqUJolcZzmuL9agZTzNkXt2JGl1DsYwZqofBZpR4syn
         3mF4hKhxZ/biTXlutpZMEgs3sYH86VGHkT7txL1CdJpC559Hu4PERAvrXuIs/KdLqGYs
         D+IcqHuD1gK7BE0/IWUaqvvFr9YpZdEvORCEPchPS5/ynMRYsW0GKNaYda0be5VhOHt/
         1eJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l1C0FAGjtz+oqWcd7zBNG3epHIjoF2CiCJgAa7agNOA=;
        b=auZ/HPcJojXhXWR9dpkxSl0CZukDufwnKD+Ks1LeVf2+krKoURBDxPtKPdpwHNCSJz
         oHdWLmHbXSbOMy1MVpodhyseWQZwK7GOx6fvl0m2w0GF7Jp+O1MOQ9e54NyGZvFzi7P1
         SicSZyjGijEhGgvDL+vm8VAMK9VcwVmcNglfhvv/cu2H5rJjMloMf59PH3yZpuEYPy+G
         Ciu87oTK/1V/O2SDg/JNizSY0GqJYXLSJnar8KdWaRkLltPYgtYT2oHaH3t78u27OBSs
         ILwvWpu7QC/kE3y3u65DakroFSfOFGeOOqdXWC9p/sRT08cDGGTGne+KWO7j/T+GSXC6
         p+1w==
X-Gm-Message-State: APjAAAVRxLEEyXYUSFG3NhV5wpCugyyv7hQt+7JSlbpw2PyRg2teFkWW
        krg+AZbvVFBFhLnWAqYcSrZVRlchJ+PHTWf7kaM=
X-Google-Smtp-Source: APXvYqxKpkI1GcQ70hgtvCUxGjLpRzh3tGjFR+y3r+IUuvK0aY6hjEEt/qxg0Iy8RpgUJvHrGGPZB898n+FjACnQlhs=
X-Received: by 2002:a67:f799:: with SMTP id j25mr13625177vso.116.1570921166350;
 Sat, 12 Oct 2019 15:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.v2.git.gitgitgadget@gmail.com> <pull.316.v3.git.gitgitgadget@gmail.com>
 <8927494b8c418e43f5bbd6e1eb108be5a0a263fc.1570478905.git.gitgitgadget@gmail.com>
In-Reply-To: <8927494b8c418e43f5bbd6e1eb108be5a0a263fc.1570478905.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 12 Oct 2019 15:59:15 -0700
Message-ID: <CABPp-BGCNpZWoWk4coNEpA0zS2g0HXi5Kzb+QVusyLRt0fy=zw@mail.gmail.com>
Subject: Re: [PATCH v3 16/17] sparse-checkout: write using lockfile
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 7, 2019 at 1:08 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> If two 'git sparse-checkout set' subcommands are launched at the
> same time, the behavior can be unexpected as they compete to write
> the sparse-checkout file and update the working directory.
>
> Take a lockfile around the writes to the sparse-checkout file. In
> addition, acquire this lock around the working directory update
> to avoid two commands updating the working directory in different
> ways.

Wow, there's something I never would have thought to check.  Did you
have folks run into this, or is this just some defensive programming?
Either way, I'm impressed.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/sparse-checkout.c          | 15 ++++++++++++---
>  t/t1091-sparse-checkout-builtin.sh |  7 +++++++
>  2 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 542d57fac6..9b313093cd 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -308,6 +308,8 @@ static int write_patterns_and_update(struct pattern_list *pl)
>  {
>         char *sparse_filename;
>         FILE *fp;
> +       int fd;
> +       struct lock_file lk = LOCK_INIT;
>         int result;
>
>         if (!core_apply_sparse_checkout) {
> @@ -317,21 +319,28 @@ static int write_patterns_and_update(struct pattern_list *pl)
>
>         result = update_working_directory(pl);
>
> +       sparse_filename = get_sparse_checkout_filename();
> +       fd = hold_lock_file_for_update(&lk, sparse_filename,
> +                                     LOCK_DIE_ON_ERROR);
> +
> +       result = update_working_directory(pl);
>         if (result) {
> +               rollback_lock_file(&lk);
> +               free(sparse_filename);
>                 clear_pattern_list(pl);
>                 update_working_directory(NULL);
>                 return result;
>         }
>
> -       sparse_filename = get_sparse_checkout_filename();
> -       fp = fopen(sparse_filename, "w");
> +       fp = fdopen(fd, "w");
>
>         if (core_sparse_checkout_cone)
>                 write_cone_to_file(fp, pl);
>         else
>                 write_patterns_to_file(fp, pl);
>
> -       fclose(fp);
> +       fflush(fp);
> +       commit_lock_file(&lk);
>
>         free(sparse_filename);
>         clear_pattern_list(pl);
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 82eb5fb2f8..f22a4afbea 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -262,4 +262,11 @@ test_expect_success 'revert to old sparse-checkout on bad update' '
>         test_cmp dir expect
>  '
>
> +test_expect_success 'fail when lock is taken' '
> +       test_when_finished rm -rf repo/.git/info/sparse-checkout.lock &&
> +       touch repo/.git/info/sparse-checkout.lock &&
> +       test_must_fail git -C repo sparse-checkout set deep 2>err &&
> +       test_i18ngrep "File exists" err
> +'
> +
>  test_done
> --
> gitgitgadget
>
