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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F2811F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 22:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfJKW2A (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 18:28:00 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35545 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfJKW2A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 18:28:00 -0400
Received: by mail-vs1-f65.google.com with SMTP id s7so7247192vsl.2
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 15:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EYyWQ1fnSxGfpj+pDvhi3S6mmAqthgdpB58a3aM0glo=;
        b=MhgVpaG0A5q90Uz4TfcOA9DFVuwGEfLFdVk4Wc9zMAXlkOcP3jSISQYOL5t/ksACku
         wJPOqROM3cD/zLsmDxutaK7lZwTq0+3gMULbyXIIxDAlPOfa4Rvc8po8lkwT9XIorC7E
         XupHG1l2A4EEeT8nwyQM+SY9Aszt9BOqOLiaCGGWtNi5X4fbpyg7QohRVqbhcemJ1jRA
         CWjSN5X61NY3vdZRSIgVuqET3DyMZdkHiTZwkMVlMZCwY3aW/Ry3n4krReY0fiHlKjT0
         pirCOPghsNFo1uufiOuLCDwLDuEtN3Mrqjp0iSB6bvQ3ZUQDwUyUPD7oS2NF8z2GzAFr
         AeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EYyWQ1fnSxGfpj+pDvhi3S6mmAqthgdpB58a3aM0glo=;
        b=atOxuhH8Yox4sLEA8wKlTJD98Tgig5V1ua/jqRikTnrIlTM8mAidj/n6Vb998V5tY1
         M57rYLSn/5EgsJCVkKdULt/oo8P6ccq9p9i3rXaumN53ZvLgQ34GBtP+wcxkxKM+nES4
         Pu1I8O+RpF/VCDGjFVVOsKlItX5JMNvpLAWZwxganJ+jUfHPpVuaCKm4sp9u0t4T0Icq
         V4VgyLWX6HA3dGUM5pvnwCjPAGSHnC1g12W2XQlbwyzmv2g+FUn1H8WUYbbD/PM8zeTH
         T7Fqj80OuI7izPT/wyB4oazTWfJkq/psP3ZUQGY+XXuxUF6NguvQYJP2JXDeYWGWPAj4
         DMaQ==
X-Gm-Message-State: APjAAAX4wMP1RVEE8b5RvheushxmD1aFAba31aUQEiGPDuLzt044yYRX
        SHgDKunwpMu/nH47VRMqzMjwsPOSkhydStiYcSI=
X-Google-Smtp-Source: APXvYqz53vByHNwdIjS/bBJpJM4hVD7gP3MGl5vnrYN9z3iy3skAYKNrXyhE6NPTImmBFZx4CvCoJ2TowYcPpvQJ2pY=
X-Received: by 2002:a05:6102:2130:: with SMTP id f16mr10330205vsg.117.1570832878494;
 Fri, 11 Oct 2019 15:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.v2.git.gitgitgadget@gmail.com> <pull.316.v3.git.gitgitgadget@gmail.com>
 <0b1ed06bc8c27650086b10b587df943d3053b773.1570478905.git.gitgitgadget@gmail.com>
In-Reply-To: <0b1ed06bc8c27650086b10b587df943d3053b773.1570478905.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 11 Oct 2019 15:27:46 -0700
Message-ID: <CABPp-BHc+iUq9NtTL4Mn1U-DhMmV2nX-_OTJr-Ltc7c3xDV-Ow@mail.gmail.com>
Subject: Re: [PATCH v3 05/17] sparse-checkout: add '--stdin' option to set subcommand
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
> The 'git sparse-checkout set' subcommand takes a list of patterns
> and places them in the sparse-checkout file. Then, it updates the
> working directory to match those patterns. For a large list of
> patterns, the command-line call can get very cumbersome.
>
> Add a '--stdin' option to instead read patterns over standard in.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/sparse-checkout.c          | 40 ++++++++++++++++++++++++++++--
>  t/t1091-sparse-checkout-builtin.sh | 27 ++++++++++++++++++++
>  2 files changed, 65 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 52d4f832f3..68f3d8433e 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -145,6 +145,11 @@ static int write_patterns_and_update(struct pattern_list *pl)
>         char *sparse_filename;
>         FILE *fp;
>
> +       if (!core_apply_sparse_checkout) {
> +               warning(_("core.sparseCheckout is disabled, so changes to the sparse-checkout file will have no effect"));
> +               warning(_("run 'git sparse-checkout init' to enable the sparse-checkout feature"));
> +       }
> +
>         sparse_filename = get_sparse_checkout_filename();
>         fp = fopen(sparse_filename, "w");
>         write_patterns_to_file(fp, pl);
> @@ -154,16 +159,47 @@ static int write_patterns_and_update(struct pattern_list *pl)
>         return update_working_directory();
>  }
>
> +static char const * const builtin_sparse_checkout_set_usage[] = {
> +       N_("git sparse-checkout set [--stdin|<patterns>]"),
> +       NULL
> +};
> +
> +static struct sparse_checkout_set_opts {
> +       int use_stdin;
> +} set_opts;
> +
>  static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
>  {
>         static const char *empty_base = "";
>         int i;
>         struct pattern_list pl;
>         int result;
> +
> +       static struct option builtin_sparse_checkout_set_options[] = {
> +               OPT_BOOL(0, "stdin", &set_opts.use_stdin,
> +                        N_("read patterns from standard in")),
> +               OPT_END(),
> +       };
> +
>         memset(&pl, 0, sizeof(pl));
>
> -       for (i = 1; i < argc; i++)
> -               add_pattern(argv[i], empty_base, 0, &pl, 0);
> +       argc = parse_options(argc, argv, prefix,
> +                            builtin_sparse_checkout_set_options,
> +                            builtin_sparse_checkout_set_usage,
> +                            PARSE_OPT_KEEP_UNKNOWN);

Does this mean users can also spell it 'git sparse-checkout --stdin
set', instead of the expected 'git sparse-checkout set --stdin'?

> +
> +       if (set_opts.use_stdin) {
> +               struct strbuf line = STRBUF_INIT;
> +
> +               while (!strbuf_getline(&line, stdin)) {
> +                       size_t len;
> +                       char *buf = strbuf_detach(&line, &len);
> +                       add_pattern(buf, empty_base, 0, &pl, 0);
> +               }
> +       } else {
> +               for (i = 0; i < argc; i++)
> +                       add_pattern(argv[i], empty_base, 0, &pl, 0);
> +       }
>
>         result = write_patterns_and_update(&pl);
>
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 19e8673c6b..2a0137fde3 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -101,6 +101,13 @@ test_expect_success 'clone --sparse' '
>         test_cmp expect dir
>  '
>
> +test_expect_success 'warn if core.sparseCheckout is disabled' '
> +       test_when_finished git -C repo config --worktree core.sparseCheckout true &&
> +       git -C repo config --worktree core.sparseCheckout false &&
> +       git -C repo sparse-checkout set folder1 2>err &&
> +       test_i18ngrep "core.sparseCheckout is disabled" err
> +'
> +
>  test_expect_success 'set sparse-checkout using builtin' '
>         git -C repo sparse-checkout set "/*" "!/*/" "*folder*" &&
>         cat >expect <<-EOF &&
> @@ -120,4 +127,24 @@ test_expect_success 'set sparse-checkout using builtin' '
>         test_cmp expect dir
>  '
>
> +test_expect_success 'set sparse-checkout using --stdin' '
> +       cat >expect <<-EOF &&
> +               /*
> +               !/*/
> +               /folder1/
> +               /folder2/
> +       EOF
> +       git -C repo sparse-checkout set --stdin <expect &&
> +       git -C repo sparse-checkout list >actual &&
> +       test_cmp expect actual &&
> +       test_cmp expect repo/.git/info/sparse-checkout &&
> +       ls repo >dir  &&
> +       cat >expect <<-EOF &&
> +               a
> +               folder1
> +               folder2
> +       EOF
> +       test_cmp expect dir
> +'
> +
>  test_done
> --
> gitgitgadget
>
