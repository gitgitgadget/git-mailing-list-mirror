Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19D2E1F461
	for <e@80x24.org>; Fri, 23 Aug 2019 23:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfHWXbI (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 19:31:08 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46869 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfHWXbI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 19:31:08 -0400
Received: by mail-vs1-f68.google.com with SMTP id x20so7100586vsx.13
        for <git@vger.kernel.org>; Fri, 23 Aug 2019 16:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=75yZ5T+3xIsLMiWnwXCPv0eG66hz7Bj0jDRiOrTJ9qU=;
        b=a63d3aT9jY9DB995F1aEZLEaTBtXiTGfxatYuB0oCIM2w8I7fUQZal0wD3SBJzU6CQ
         cxoXAVm6ja59TpA5jlVprIfg85Xn/SiAQj7Rg0nCFsXb9CjVGjq9IuXxXHgadMkOFJXQ
         pi6R3ySD91CbHsMpvfhMK3/ftrnI4ONrTogvgeyfeNHpPvKNVcGaxbXhc8UtqYuFLZ2H
         YtUeNI/R3XOBHvJKWw1AuTuQfDt7b1Id2CB6GWoaBhaOGsmRiZ3nVsjl4PGzNY8LbOfS
         MY45ZJm2RReJpS7nuyqvkZHcxYvECc/1bjJ7xsILmRru0cCVlBgpAoPJUkvuIbsEjaY5
         D6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=75yZ5T+3xIsLMiWnwXCPv0eG66hz7Bj0jDRiOrTJ9qU=;
        b=a1I6HL2NjAistzOaRFcqLDMBHgn4Dfe11PghBzMIlD6Y/KYwkgJaYjoQzna98baMRd
         OO8TTCJpB+PxULQAXLjOP46qZxAxpaeQ4MJT4QxYakSLUgGjkafXhhDsitaxCrTxFr9b
         Mn22WFF9dtTcTOimGKh9NQFXS6aGU6vyRRXtaKcoApAuXaglLgGyYRZQb62EVjigFMfJ
         G+erroGoErkzfxA05B5IGa+GuSW/tMr3O4P/VNYh5O7/0GExN5opst58EITgCanQecSS
         r1iVeFT6CHg+aXhsmbZj6lIDmCowU6w8zg0b6ducX7BIabaNCACWF9Z4FumOM2mIpgs1
         SO0A==
X-Gm-Message-State: APjAAAU3J6B3I+T+vJjWWV1XJE7NgMY0DkHdllZDGVSwPvu9PhuOHij6
        QN1dk5II/qk1mPXsEZgGStiOMpVRb0rnTdcAv14=
X-Google-Smtp-Source: APXvYqyQWBZdPRA0Ku5rFHojs9JWVjpPnvnZ4b41AUUKU3AEYhq5Fz9ije1KhES1clh1LBD4/nEzRggn8pMWT/3Vg/0=
X-Received: by 2002:a67:d099:: with SMTP id s25mr2705924vsi.175.1566603067407;
 Fri, 23 Aug 2019 16:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.git.gitgitgadget@gmail.com> <0f095e85d5bf29346bdc5bf1707bb51eaf2202ae.1566313865.git.gitgitgadget@gmail.com>
In-Reply-To: <0f095e85d5bf29346bdc5bf1707bb51eaf2202ae.1566313865.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 23 Aug 2019 16:30:56 -0700
Message-ID: <CABPp-BEhc00g3CwKg13wDrtFHM-sw9tSy75UEbTvugKkdwTyeA@mail.gmail.com>
Subject: Re: [PATCH 4/9] sparse-checkout: 'add' subcommand
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 20, 2019 at 8:12 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The 'git sparse-checkout add' subcommand takes a list of patterns
> over stdin and writes them to the sparse-checkout file. Then, it
> updates the working directory using 'git read-tree -mu HEAD'.

As mentioned in response to the cover letter, I'd rather see it take
patterns as positional arguments (though requiring a '--' argument
before any patterns that start with a hyphen).  It could also take
--stdin to read from stdin.

> Note: if a user adds a negative pattern that would lead to the
> removal of a non-empty directory, then Git may not delete that
> directory (on Windows).

This sounds like you're re-iterating a bug mentioned earlier, but if
someone in the future comes and reads this comment it might sound like
you're saying git can avoid clearing a directory for optimization or
other reasons.  (And, of course, it'd be nice to figure out why this
bug exists.)

Another question this brings up, though, is that you worked around
this bug in 'init' so why would you not also do so for 'add'?  Seems
inconsistent to me.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-sparse-checkout.txt |  4 ++++
>  builtin/sparse-checkout.c             | 32 ++++++++++++++++++++++++++-
>  t/t1091-sparse-checkout-builtin.sh    | 20 +++++++++++++++++
>  3 files changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> index 50c53ee60a..6f540a3443 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -34,6 +34,10 @@ COMMANDS
>         by Git. Add patterns to the sparse-checkout file to
>         repopulate the working directory.
>
> +'add'::
> +       Add a set of patterns to the sparse-checkout file, as given over
> +       stdin. Updates the working directory to match the new patterns.
> +
>  SPARSE CHECKOUT
>  ----------------
>
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 86d24e6295..ec6134fecc 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -8,7 +8,7 @@
>  #include "strbuf.h"
>
>  static char const * const builtin_sparse_checkout_usage[] = {
> -       N_("git sparse-checkout [init|list]"),
> +       N_("git sparse-checkout [init|add|list]"),
>         NULL
>  };
>
> @@ -166,6 +166,34 @@ static int sparse_checkout_init(int argc, const char **argv)
>         return sc_read_tree();
>  }
>
> +static int sparse_checkout_add(int argc, const char **argv)
> +{
> +       struct exclude_list el;
> +       char *sparse_filename;
> +       FILE *fp;
> +       struct strbuf line = STRBUF_INIT;
> +
> +       memset(&el, 0, sizeof(el));
> +
> +       sparse_filename = get_sparse_checkout_filename();
> +       add_excludes_from_file_to_list(sparse_filename, "", 0, &el, NULL);

el is an exclude_list and we call add_excludes_..., but it's actually
an *include* list.  This is going to cause errors at some point, and
will cause lots of headaches.

> +
> +       fp = fopen(sparse_filename, "w");
> +       write_excludes_to_file(fp, &el);
> +
> +       while (!strbuf_getline(&line, stdin)) {
> +               strbuf_trim(&line);
> +               fprintf(fp, "%s\n", line.buf);
> +       }

Should we first check whether these excludes are already in the
sparse-checkout file?

> +       fclose(fp);
> +       free(sparse_filename);
> +
> +       clear_exclude_list(&el);
> +
> +       return sc_read_tree();

What if someone calls 'git sparse-checkout add' without first calling
'git sparse-checkout init'?  As far as I can tell, core.sparseCheckout
will be unset (i.e. treated as false), meaning that this operation
will do some work, but result in no changes and a report of success.
After users try to figure out why it won't work, they eventually run
'git sparse-checkout init', which will delete all the entries they
previously added with the 'add' subcommand.

What should happen instead?

> +}
> +
>  int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
>  {
>         static struct option builtin_sparse_checkout_options[] = {
> @@ -187,6 +215,8 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
>                         return sparse_checkout_list(argc, argv);
>                 if (!strcmp(argv[0], "init"))
>                         return sparse_checkout_init(argc, argv);
> +               if (!strcmp(argv[0], "add"))
> +                       return sparse_checkout_add(argc, argv);
>         }
>
>         usage_with_options(builtin_sparse_checkout_usage,
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index b7d5f15830..499bd8d6d0 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -100,4 +100,24 @@ test_expect_success 'clone --sparse' '
>         test_cmp expect dir
>  '
>
> +test_expect_success 'add to existing sparse-checkout' '
> +       echo "/folder2/*" | git -C repo sparse-checkout add &&

I've always been using '/folder2/' in sparse-checkout, without the
trailing asterisk.  That seems more friendly for cone mode too.  Are
there benefits to keeping the trailing asterisk?

> +       cat >expect <<-EOF &&
> +               /*
> +               !/*/*
> +               /folder1/*
> +               /folder2/*
> +       EOF
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
> \ No newline at end of file
> --
> gitgitgadget
>
