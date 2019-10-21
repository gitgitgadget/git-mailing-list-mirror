Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A88851F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 13:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfJUNUx (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 09:20:53 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39335 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbfJUNUw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 09:20:52 -0400
Received: by mail-vs1-f66.google.com with SMTP id y129so8824518vsc.6
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 06:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fE+a+DhJH1jr7uSyIVC7sBdEqr0Fl6OBp3EIC8jG6bA=;
        b=gXqL5w8w3G6AC7MXe+UVCQKgazGfh6i9XUkq5strx6/Bng8vY9naAK2OJmW/GDm29t
         qr0/ApsGBIYVz8GxKG2cfEBsV0Ymd1FAB0CMDJ/k4KZ/MJv9F7GoMT/VbOmWsGAsugmt
         HKH5wBcz1bSCwsO0TFOhnS6gtFluz4ZnCH2ZVhRJUYGXnBUxi9UjFoXHScKOOE9UCEJP
         GgRRYJqDMUh1VNNx4sCveKkL4bl65BktqZhW9z0hN0gsNvybD7Nj0TkxWpo2aedSxxaW
         ryk24QIb+Pc47gJ2vgabmsviup+zeisT2vPURjXozzFVD/A09rMWGG8TBy1yd6JEOfJW
         MeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fE+a+DhJH1jr7uSyIVC7sBdEqr0Fl6OBp3EIC8jG6bA=;
        b=QacPQqO0ObSXotr2HlzKxnU1WQOwaHiYvO628B8InjjStNK1zzO7WeM8iVf2gQA3eW
         YyCMeYHzBB91/IRjVAzDz5LkCnirx9nyS/Z9xMWxpS827fMAPptCLyfhWNxnA5HlVfY2
         imdx+pkC4ilkOHGPu6w1GJn0nGvABI3rCMt7RO8WwNv7hxV+IRd/aCAAA2lCOzxTaTYP
         wPbMKsU9ZvVasMLAIBGG+or4R9jN3F1+O9kXW10oI9k0/f2Y3LLc8Mq6cKRHgKYYhAo+
         iq6THvzpJ0GnTVv/4PsD8qYSATo8OB2af5uU1OaZ/93XpJQKSb8t8JC443EevszKXGaV
         5c+g==
X-Gm-Message-State: APjAAAUBIRewMWHxG6Yo4EzVzCC7Idl1ipCZBSo16gKpXPJrgIr26HM3
        39ndcc63ujiT9W970dpnASgSj54kv2DYcW/lmp0=
X-Google-Smtp-Source: APXvYqwt5okeeZowMggHrfXuHQJW8CNi9A/FQORxU/XKiO3pBpVwQyEeqXy3pEtrCZg4sBN/QZA+8wv2nRnhNOYXldE=
X-Received: by 2002:a67:2c4d:: with SMTP id s74mr13348061vss.75.1571664051524;
 Mon, 21 Oct 2019 06:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <ac3cc3df4452355dc41c58fe94961c37ca09ebec.1571653441.git.bert.wesarg@googlemail.com>
In-Reply-To: <ac3cc3df4452355dc41c58fe94961c37ca09ebec.1571653441.git.bert.wesarg@googlemail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Mon, 21 Oct 2019 15:20:39 +0200
Message-ID: <CAKPyHN3QQuX4Z8-sySU3DbQYj1mfTqGjzgX8RFw_H6UFA07ohw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] format-patch: create leading components of output directory
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please ignore this. Will rebase on 2.24-rc0 and will only include the
test changes.

Bert

On Mon, Oct 21, 2019 at 12:25 PM Bert Wesarg <bert.wesarg@googlemail.com> w=
rote:
>
> 'git format-patch -o <outdir>' did an equivalent of 'mkdir <outdir>'
> not 'mkdir -p <outdir>', which is being corrected.
>
> Avoid the usage of 'adjust_shared_perm' on the leading directories which
> may have security implications. Achieved by temporarily disabling of
> 'config.sharedRepository' like 'git init' does.
>
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>
> ---
> Changes in v2:
>  * squashed and base new tests on 'dl/format-patch-doc-test-cleanup'
>
> Changes in v3:
>  * avoid applying adjust_shared_perm
>
> Changes in v4:
>  * based on dl/format-patch-doc-test-cleanup and adopt it
>
> Changes in v5:
>  * make tests self-contained
>
> Cc: Denton Liu <liu.denton@gmail.com>
> Cc: Junio C Hamano <gitster@pobox.com>
> Cc: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  Documentation/config/format.txt    |  2 +-
>  Documentation/git-format-patch.txt |  3 ++-
>  builtin/log.c                      | 16 ++++++++++++++++
>  t/t4014-format-patch.sh            | 26 ++++++++++++++++++++++++++
>  4 files changed, 45 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config/format.txt b/Documentation/config/forma=
t.txt
> index cb629fa769..40cad9278f 100644
> --- a/Documentation/config/format.txt
> +++ b/Documentation/config/format.txt
> @@ -81,7 +81,7 @@ format.coverLetter::
>
>  format.outputDirectory::
>         Set a custom directory to store the resulting files instead of th=
e
> -       current working directory.
> +       current working directory. All directory components will be creat=
ed.
>
>  format.useAutoBase::
>         A boolean value which lets you enable the `--base=3Dauto` option =
of
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-forma=
t-patch.txt
> index 0ac56f4b70..2035d4d5d5 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -66,7 +66,8 @@ they are created in the current working directory. The =
default path
>  can be set with the `format.outputDirectory` configuration option.
>  The `-o` option takes precedence over `format.outputDirectory`.
>  To store patches in the current working directory even when
> -`format.outputDirectory` points elsewhere, use `-o .`.
> +`format.outputDirectory` points elsewhere, use `-o .`. All directory
> +components will be created.
>
>  By default, the subject of a single patch is "[PATCH] " followed by
>  the concatenation of lines from the commit message up to the first blank
> diff --git a/builtin/log.c b/builtin/log.c
> index 44b10b3415..8d08632858 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1765,10 +1765,26 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
>                 setup_pager();
>
>         if (output_directory) {
> +               int saved;
>                 if (rev.diffopt.use_color !=3D GIT_COLOR_ALWAYS)
>                         rev.diffopt.use_color =3D GIT_COLOR_NEVER;
>                 if (use_stdout)
>                         die(_("standard output, or directory, which one?"=
));
> +               /*
> +                * We consider <outdir> as 'outside of gitdir', therefore=
 avoid
> +                * applying adjust_shared_perm in s-c-l-d.
> +                */
> +               saved =3D get_shared_repository();
> +               set_shared_repository(0);
> +               switch (safe_create_leading_directories_const(output_dire=
ctory)) {
> +               case SCLD_OK:
> +               case SCLD_EXISTS:
> +                       break;
> +               default:
> +                       die(_("could not create leading directories "
> +                             "of '%s'"), output_directory);
> +               }
> +               set_shared_repository(saved);
>                 if (mkdir(output_directory, 0777) < 0 && errno !=3D EEXIS=
T)
>                         die_errno(_("could not create directory '%s'"),
>                                   output_directory);
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 72b09896cf..3aab25da76 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -1606,6 +1606,32 @@ test_expect_success 'From line has expected format=
' '
>         test_cmp from filtered
>  '
>
> +test_expect_success 'format-patch -o with no leading directories' '
> +       rm -fr patches &&
> +       git format-patch -o patches master..side &&
> +       count=3D$(git rev-list --count master..side) &&
> +       ls patches >list &&
> +       test_line_count =3D $count list
> +'
> +
> +test_expect_success 'format-patch -o with leading existing directories' =
'
> +       rm -rf existing-dir &&
> +       mkdir existing-dir &&
> +       git format-patch -o existing-dir/patches master..side &&
> +       count=3D$(git rev-list --count master..side) &&
> +       ls existing-dir/patches >list &&
> +       test_line_count =3D $count list
> +'
> +
> +test_expect_success 'format-patch -o with leading non-existing directori=
es' '
> +       rm -rf non-existing-dir &&
> +       git format-patch -o non-existing-dir/patches master..side &&
> +       count=3D$(git rev-list --count master..side) &&
> +       test_path_is_dir non-existing-dir
> +       ls non-existing-dir/patches >list &&
> +       test_line_count =3D $count list
> +'
> +
>  test_expect_success 'format-patch format.outputDirectory option' '
>         test_config format.outputDirectory patches &&
>         rm -fr patches &&
> --
> 2.23.0.13.g28bc381d7c
>
