Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13C7F20446
	for <e@80x24.org>; Tue, 17 Oct 2017 17:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933375AbdJQR41 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 13:56:27 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:54603 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759639AbdJQR40 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 13:56:26 -0400
Received: by mail-qk0-f176.google.com with SMTP id n5so3112107qke.11
        for <git@vger.kernel.org>; Tue, 17 Oct 2017 10:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PREzcL9GCLDKiN7+XjDnxuFhvZQStyS10ZCrRd1CuCc=;
        b=YC/dsgIAXLCyDwebyo4eTQz7k+M1hSc/EsEg6926XsuOjWGkLzsOyK8cdMU4/BzCfH
         4l2HusQ50U1I0vQ2yLI8JSCzQTHKSCPk5Ur8+ans6K7HOfJds5JrTM3x7sFagVKjUAhX
         JCUud4OkJZRRROdDXZM8evmgNgZWwJWHy6W6G7HGhZVxuBPc2QozKVYpRvAqB19YPc1W
         Gl6eYHUsrZ6e+2bi9PZQsRKFjd+UBEHEV6J4aIFkiWgkYvufGTee6tLDeBl96vYTTGzC
         qTjRBOKPBqOx7cFP8ccvYW9SbaVMccxc+QGFtw580mvY9wsQNg6lRy87TEZNsB1ZyyNe
         sZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PREzcL9GCLDKiN7+XjDnxuFhvZQStyS10ZCrRd1CuCc=;
        b=iV3hBvwNwGHdCbNJn4Mveo8+GcmvQF8z27lHWEKuQ5VRIdW+C5ZgjXwKk6IlMhgOgv
         rfyp4TsxJwNz8qHlZgZRNJtMRBav1sUXaJzNC/XejKu1QRi1LJNQllBuvXEcTVFaywPL
         nFQPizMqqejHUNelIT2HW8xKT9z/c/W1zZyWsBYnN1lgVf2QAw1MktXlyEX4C2fI0ASC
         NZeIJXAyTuPYW5QrrNS9QIE611gSWjgeCKxkUSNll1nnUMKTOVlSMrpiNsnjYzWfOY+n
         uNByVV+0T5HP9lTU4xNL8ixGkAPmyHzM7c5LJJEaUuFJ71mhBthzvX3zV3l4E35bVcAF
         4+HQ==
X-Gm-Message-State: AMCzsaXMAFIDwdq+Fu5MFOmvs5ur/UlRJAUZzgxtyAnljOpK8FtNEnFH
        9UgLZs2qo3IoBS8Oo64H5FITZMwhzvOuMDaIK5YfJQ==
X-Google-Smtp-Source: AOwi7QBfAvcbFmcXkLXIzmUFYBMll9xI478W0jVDRlq8BTHKY1NjFfBjII86qV+OcdMBoyOadjWjqQ6fvxrSnQ90LWc=
X-Received: by 10.55.33.203 with SMTP id f72mr20357942qki.176.1508262985201;
 Tue, 17 Oct 2017 10:56:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Tue, 17 Oct 2017 10:56:24 -0700 (PDT)
In-Reply-To: <20171016135715.GB12756@book.hvoigt.net>
References: <20171016135623.GA12756@book.hvoigt.net> <20171016135715.GB12756@book.hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 17 Oct 2017 10:56:24 -0700
Message-ID: <CAGZ79kaA6myLpDcN2H4sdbMKvkuVRp4Zud==k=p1BNfWn95a4Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] fetch: add test to make sure we stay backwards compatible
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 16, 2017 at 6:57 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> The current implementation of submodules supports on-demand fetch if
> there is no .gitmodules entry for a submodule. Let's add a test to
> document this behavior.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
>  t/t5526-fetch-submodules.sh | 42 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index 42251f7f3a..43a22f680f 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -478,7 +478,47 @@ test_expect_success "don't fetch submodule when newly recorded commits are alrea
>                 git fetch >../actual.out 2>../actual.err
>         ) &&
>         ! test -s actual.out &&
> -       test_i18ncmp expect.err actual.err
> +       test_i18ncmp expect.err actual.err &&
> +       (
> +               cd submodule &&
> +               git checkout -q master
> +       )

For few instructions inside another repo, I tend to use the
-C option:

  git -C submodule checkout -q master

That saves a shell, which is noticeable cost on Windows I was told.
(also fewer lines to type).

Oh, I see, that is consistent with the rest of the file. Oh well.
(Otherwise I would have lobbied to even move it further up and
put it inside a test_when_finished "<cmd>"


> +'
> +
> +test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .gitmodule entry" '
> +       (
> +               cd downstream &&
> +               git fetch --recurse-submodules
> +       ) &&

This is consistent with the rest of the file as well, so I shall
refrain from complaining. ;)

> +       add_upstream_commit &&
> +       head1=$(git rev-parse --short HEAD) &&
> +       git add submodule &&
> +       git rm .gitmodules &&
> +       git commit -m "new submodule without .gitmodules" &&
> +       printf "" >expect.out &&

This could be just

    : >expect.out

no need to invoke a function to print nothing.

> +       head2=$(git rev-parse --short HEAD) &&
> +       echo "From $pwd/." >expect.err.2 &&
> +       echo "   $head1..$head2  master     -> origin/master" >>expect.err.2 &&
> +       head -3 expect.err >>expect.err.2 &&
> +       (
> +               cd downstream &&
> +               rm .gitmodules &&
> +               git config fetch.recurseSubmodules on-demand &&
> +               # fake submodule configuration to avoid skipping submodule handling
> +               git config -f .gitmodules submodule.fake.path fake &&
> +               git config -f .gitmodules submodule.fake.url fakeurl &&
> +               git add .gitmodules &&
> +               git config --unset submodule.submodule.url &&
> +               git fetch >../actual.out 2>../actual.err &&
> +               # cleanup
> +               git config --unset fetch.recurseSubmodules &&
> +               git reset --hard
> +       ) &&
> +       test_i18ncmp expect.out actual.out &&
> +       test_i18ncmp expect.err.2 actual.err &&
> +       git checkout HEAD^ -- .gitmodules &&
> +       git add .gitmodules &&
> +       git commit -m "new submodule restored .gitmodules"
>  '

Thanks for writing this test.
With or without the nits addressed, this is

Reviewed-by: Stefan Beller <sbeller@google.com>
