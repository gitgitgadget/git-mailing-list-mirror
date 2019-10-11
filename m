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
	by dcvr.yhbt.net (Postfix) with ESMTP id 792811F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 22:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbfJKWOx (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 18:14:53 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44460 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbfJKWOx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 18:14:53 -0400
Received: by mail-vs1-f66.google.com with SMTP id w195so7194890vsw.11
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 15:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N4i/HhdXSeJKhyNWnNX8fFyhomf+pQowTAqcfLbAI6A=;
        b=VuiJ8dHM1RLymll7guX7BQg6YlUDtvQKD2E7/JgLY4uDEkzrHRXMvtpozIBKMFScGP
         uu0jpu1hr2X200NUV201yp5yOIdYcrnZlbsvVCF+rgu6G+zDE6XfIqjZZ3DtvVH2OZF+
         EBnINUptxe7K9FuU1VXnPTjw74Xv+EQcTzLcFW911oa4hYFgsrKmWnckI0Hpmds34awm
         BfbbLtw3lxjGe5uTzCw/dG9yaH26jJqQwHYY5ETEPzmVTrArGz2Vx925XkznLoyhJtxG
         VAjpuALgvrqjdpG9iA3m/+smY+OGmVwURdKHt28XWD5y32YnTFXD2iid29ioxnOHg8T+
         yt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N4i/HhdXSeJKhyNWnNX8fFyhomf+pQowTAqcfLbAI6A=;
        b=jbFv9AkZAA5dLRNBBHm5jUatCG+BbQUXWBdeR0PM8yifJ/Mgz8JKyQSlEcdUSV/KvY
         1GvAocFoQYZyNZ4pLWaW3/aG9G7FCAkeJvOh0TEr9XU/mkXOq6HcTJTxmh6e0t8nD3S0
         TxH9Usk+ZG4y9SwualR9Bx6mk6rJaDdw9FxTShlUsyITZP48m/SKms2Fe/lLCyq+kxNG
         9m4AQ2tv2CNisCdC21aMKyYkL+8Oaewy6Pg9JpTfnnkFG9mdPxJn5uuE0cIh7xoyw5P0
         r+8y0wMMWl4ZKiA0wqtaNXxdc/ThMjbHhD/ADLXCVxyRgSd98fneChE2cMOI3q0SH++Y
         P4WQ==
X-Gm-Message-State: APjAAAUUqSNGOR1ibRrL6Bz/aGGhU1a9yeThm1KgYOUrfya2z5SIfXxl
        wyxiY8mIzHpnN0gcthErQwrDPY4uUTpD+6c8Xko=
X-Google-Smtp-Source: APXvYqwJjqjIhS4q4qZdo8vAGpyPy+PTULVNzJrQ2WW7cx9xp2JjPmE0nmNPpx2J9Pmd+pt6Qz1RVj8RT3xqHr21O/U=
X-Received: by 2002:a67:f98b:: with SMTP id b11mr10269655vsq.53.1570832090766;
 Fri, 11 Oct 2019 15:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.v2.git.gitgitgadget@gmail.com> <pull.316.v3.git.gitgitgadget@gmail.com>
 <08bb6fb7f31b92395df4db10bf47e9a9c01257f4.1570478905.git.gitgitgadget@gmail.com>
In-Reply-To: <08bb6fb7f31b92395df4db10bf47e9a9c01257f4.1570478905.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 11 Oct 2019 15:14:39 -0700
Message-ID: <CABPp-BHd9sJ=HcM-VQaGpd5TV-A0JL5NWG6zdDReUJrMnE+FwA@mail.gmail.com>
Subject: Re: [PATCH v3 02/17] sparse-checkout: create 'init' subcommand
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
> ++
> +The init subcommand also enables the 'extensions.worktreeConfig' setting
> +and sets the `core.sparseCheckout` setting in the worktree-specific config
> +file. This prevents the sparse-checkout feature from interfering with other
> +worktrees.

I'm afraid that might be mis-parsed by future readers.  Perhaps something like:

The init subcommand also enables the `core.sparseCheckout` setting.
To avoid interfering with other worktrees, it first enables the
`extensions.worktreeConfig` setting and makes sure to set the
`core.sparseCheckout` setting in the worktree-specific config file.

> +enum sparse_checkout_mode {
> +       MODE_NONE = 0,
> +       MODE_FULL = 1,
> +};

So MODE_FULL is "true" and MODE_NONE is "false".  MODE_NONE seems
confusing to me, but let's keep reading...

> +
> +static int sc_set_config(enum sparse_checkout_mode mode)
> +{
> +       struct argv_array argv = ARGV_ARRAY_INIT;
> +
> +       if (git_config_set_gently("extensions.worktreeConfig", "true")) {
> +               error(_("failed to set extensions.worktreeConfig setting"));
> +               return 1;
> +       }
> +
> +       argv_array_pushl(&argv, "config", "--worktree", "core.sparseCheckout", NULL);
> +
> +       if (mode)
> +               argv_array_pushl(&argv, "true", NULL);
> +       else
> +               argv_array_pushl(&argv, "false", NULL);

Wait, what?  MODE_FULL is used to specify that you want a sparse
checkout, and MODE_NONE is used to denote that you want a full (i.e.
non-sparse) checkout?  These are *very* confusing names.


> +static int sparse_checkout_init(int argc, const char **argv)
> +{
> +       struct pattern_list pl;
> +       char *sparse_filename;
> +       FILE *fp;
> +       int res;
> +
> +       if (sc_set_config(MODE_FULL))
> +               return 1;

Seems confusing here too.


Everything else in the patch looks good, though.
