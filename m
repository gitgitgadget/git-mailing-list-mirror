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
	by dcvr.yhbt.net (Postfix) with ESMTP id 69F3E1F463
	for <e@80x24.org>; Wed, 18 Sep 2019 21:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388063AbfIRVyo (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 17:54:44 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:40671 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731093AbfIRVyo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 17:54:44 -0400
Received: by mail-ua1-f67.google.com with SMTP id i17so395702ual.7
        for <git@vger.kernel.org>; Wed, 18 Sep 2019 14:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UBBL7cNYDaVW/jLEg87KsvS9bFMdwGWS/fSRWX9fm+A=;
        b=N8GX6OOdWO298JYYLXjOD8orFOCYxBAEMA33zPu1NBHrHF6qEy2Ebi4DnptewbxbvP
         7EVC6b16e8OjiPgIWsgkfGspKUz3sdFI94ZZ3/RVX9nKo9cmvtKHN9LGZ/ftDk2nJDw8
         hqbSCawVW/vLWKuYxjQZEpjwhq3Y7S1NeBQ8I1l4+kuYJweGvxjD+sORPJJTpGy5IrVc
         /iQGHRD/EXri4+IPqmMJI5Cs6kXsPuH0YsvirLspIm3K4tBjwsY0fAw1oNHByle9ev0u
         jlEYLRybSpFnOkCDIthW4OiQ7kWPXmdMPJL2IwUOPhd9uUlXCQPxa7MkxncGfPmbZki1
         IZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UBBL7cNYDaVW/jLEg87KsvS9bFMdwGWS/fSRWX9fm+A=;
        b=cZI1nb74z++tBjHzTmgSLGJVV7tGsgI7AeeGwuxEmxZZDOBE0NdcJ86NOKPMCSy8KC
         pBOzcHDZY5f1kRE6i9FHRzq7Gh8c2JyMBA9X493JQo7JGAcnrByrPvgMP2meP3p5a8+U
         RdsD0hlS0dfTB9tk0FWnqW0P0L9woF9+Fe+66OdHrpozDX2up9DhrMGh/Pph48ktIHt2
         CKVjRy2Xz7Fm5hf61uhKRjCBeqvLbI2dmpbE/UzJzthbnIZtLZw7hfobpiU4lxaXPEYR
         qWeXbJUJMAsLbaAJ08b5SDzE6Zlm4tTgMnHvdCqYAfdleUGG6BXFhWW5FJaJpLjMAeiE
         TYag==
X-Gm-Message-State: APjAAAWiIQ8DLx+b7ZAr7GoUx4JrwcawgaBwlXSr+l2CFttmAmqwUGkD
        PpZXxhzlQg4WHiKm8SbowUVBkpozMedKm2PrYa0=
X-Google-Smtp-Source: APXvYqxn+M3u0z4tXjmvOquaft/kR/66Y2X0MakGiCOyLtyQhRXpYqnKTXXg8cyR7yzdZbTVX4UeG72zRgxHt868m0E=
X-Received: by 2002:ab0:4a83:: with SMTP id s3mr3783390uae.95.1568843683312;
 Wed, 18 Sep 2019 14:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190918202738.57273-1-jonathantanmy@google.com>
In-Reply-To: <20190918202738.57273-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 18 Sep 2019 14:54:32 -0700
Message-ID: <CABPp-BGN9x5HAdfm1Pn14uswCBomczSYNHeqkNmuUhWnuQD++Q@mail.gmail.com>
Subject: Re: [PATCH v2] merge-recursive: symlink's descendants not in way
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 18, 2019 at 1:27 PM Jonathan Tan <jonathantanmy@google.com> wro=
te:
>
> When the working tree has:
>  - bar (directory)
>  - bar/file (file)
>  - foo (symlink to .)
>
> (note that lstat() for "foo/bar" would tell us that it is a directory)
>
> and the user merges a commit that deletes the foo symlink and instead
> contains:
>  - bar (directory, as above)
>  - bar/file (file, as above)
>  - foo (directory)
>  - foo/bar (file)
>
> the merge should happen without requiring user intervention. However,
> this does not happen.
>
> This is because dir_in_way(), when checking the working tree, thinks
> that "foo/bar" is a directory. But a symlink should be treated much the
> same as a file: since dir_in_way() is only checking to see if there is a
> directory in the way, we don't want symlinks in leading paths to
> sometimes cause dir_in_way() to return true.
>
> Teach dir_in_way() to also check for symlinks in leading paths before
> reporting whether a directory is in the way.
>
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> Changes from v1:
>
> - Used has_symlink_leading_path(). This drastically shortens the diff.
> - Updated commit message following suggestions from Junio, Szeder G=C3=A1=
bor,
>   and Elijah Newren.
> - Updated test to add prereq and verification that the working tree
>   contains what we want.
> ---
>  merge-recursive.c          |  3 ++-
>  t/t3030-merge-recursive.sh | 28 ++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 6b812d67e3..22a12cfeba 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -764,7 +764,8 @@ static int dir_in_way(struct index_state *istate, con=
st char *path,
>
>         strbuf_release(&dirpath);
>         return check_working_copy && !lstat(path, &st) && S_ISDIR(st.st_m=
ode) &&
> -               !(empty_ok && is_empty_dir(path));
> +               !(empty_ok && is_empty_dir(path)) &&
> +               !has_symlink_leading_path(path, strlen(path));
>  }
>
>  /*
> diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
> index ff641b348a..faa8892741 100755
> --- a/t/t3030-merge-recursive.sh
> +++ b/t/t3030-merge-recursive.sh
> @@ -452,6 +452,34 @@ test_expect_success 'merge-recursive d/f conflict re=
sult' '
>
>  '
>
> +test_expect_success SYMLINKS 'dir in working tree with symlink ancestor =
does not produce d/f conflict' '
> +       git init sym &&
> +       (
> +               cd sym &&
> +               ln -s . foo &&
> +               mkdir bar &&
> +               >bar/file &&
> +               git add foo bar/file &&
> +               git commit -m "foo symlink" &&
> +
> +               git checkout -b branch1 &&
> +               git commit --allow-empty -m "empty commit" &&
> +
> +               git checkout master &&
> +               git rm foo &&
> +               mkdir foo &&
> +               >foo/bar &&
> +               git add foo/bar &&
> +               git commit -m "replace foo symlink with real foo dir and =
foo/bar file" &&
> +
> +               git checkout branch1 &&
> +
> +               git cherry-pick master &&
> +               test_path_is_dir foo &&
> +               test_path_is_file foo/bar
> +       )
> +'
> +
>  test_expect_success 'reset and 3-way merge' '
>
>         git reset --hard "$c2" &&
> --

Looks good to me; nice how much it has simplified.  Thanks for working on t=
his.

> 2.23.0.237.gc6a4ce50a0-goog

A total tangent, but what do you use the "-goog" suffix for?
