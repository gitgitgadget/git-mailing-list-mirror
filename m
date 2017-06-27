Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED8BD1FCCA
	for <e@80x24.org>; Tue, 27 Jun 2017 06:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751504AbdF0Ghw (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 02:37:52 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:36124 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbdF0Ghv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 02:37:51 -0400
Received: by mail-io0-f178.google.com with SMTP id z62so12534780ioi.3
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 23:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=znqNi15xtkqgrot2+nRpkCsqn7YErjMtl1NKXgXyY0A=;
        b=sJNzfNrnwy5+ZUFAEq904BDJSJo5+uogSJzI3OXl1s+XM+n5iJaX8DVU4QymsPeq4I
         07azr1nGudwR4xfHPksGiZ77esF1POXgo1otbgnDTYvFhv5A/3/WzqC2zS7lY5lEd+QS
         zhDqQeqeQdKqodUUffgJ+KOoHyEW3uif5BdHKmwHFPmqLaxopRW3u9uG2/N2bruqdB3W
         /pepWJARsoUVuovcsU9WAZn31nt+NaZ0RSrHyu39zmRdTebLbfou0IY8DLFN99TyMAfV
         YBMj4NXNECHF507BcD3eYu1at3aF9MnM9YkkIr5DNQqDmVq4fPlXaoWtzcL3hNDSmaLS
         MQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=znqNi15xtkqgrot2+nRpkCsqn7YErjMtl1NKXgXyY0A=;
        b=kAaGofL2vugozyaJzpAKc/gOzRF3lBYLG/dKl2wUKsgn/Kr0l/0fUFao7ML+VPQI6s
         yJ3AKTgP/7KG9XUL0I98xPDddyDZ3ThKiXRxRZbTEnfck/R6reshA3qYp5V3n3kGLENJ
         YHCIa32ZTjbIP0dRwk8NDCN02Hw6RU9c6CXhoRneYBWtw2pFoErUhYp7juO49acrIiJ/
         wmDxUrjW3wlNs/OTw6JORM5/jxMYwuMcg8aT0tpW+qoFJVYqIb+XY7tPHR3FxIHRc2cO
         dq9/fLAATBkTa29+Imb1MMKrN+8jSUKJD9vBvtFQ7a8qq/FDZsRWJOsI2vmg4IQjq3y0
         nHSg==
X-Gm-Message-State: AKS2vOw1YU9WTUUd6J6t0Kcg2+ItTG3NsrvnuqIlz2InN7inK+leAHtC
        3kMWqvsITNvpqNBz7AucmJEaxtrS7w==
X-Received: by 10.107.41.4 with SMTP id p4mr5001972iop.126.1498545470211; Mon,
 26 Jun 2017 23:37:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.40.70 with HTTP; Mon, 26 Jun 2017 23:37:49 -0700 (PDT)
In-Reply-To: <20170626231108.23640-5-pc44800@gmail.com>
References: <CAME+mvUrr8EA-6jbCZdpB7dMZ5CN3RyY7yoRoUBoiZw=sH6Ysw@mail.gmail.com>
 <20170626231108.23640-1-pc44800@gmail.com> <20170626231108.23640-5-pc44800@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 27 Jun 2017 08:37:49 +0200
Message-ID: <CAP8UFD3iuSKEuuE2aGv9yW+PkD7_5F4sfLF7VSVAJXYhDUMX1A@mail.gmail.com>
Subject: Re: [GSoC][PATCH 5/6 v2] submodule: port submodule subcommand sync
 from shell to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 27, 2017 at 1:11 AM, Prathamesh Chavan <pc44800@gmail.com> wrote:

> +static char *get_up_path(const char *path)
> +{
> +       int i = count_slashes(path);
> +       int l = strlen(path);

Nit: "l" is quite similar to "i" in many fonts, so maybe use "len"
instead of "l", but see below.

> +       struct strbuf sb = STRBUF_INIT;
> +
> +       while (i--)
> +               strbuf_addstr(&sb, "../");

Nit: a regular "for" loop like the following might be easier to review:

for (i = count_slashes(path); i; i--)
        strbuf_addstr(&sb, "../");

> +       /*
> +        *Check if 'path' ends with slash or not
> +        *for having the same output for dir/sub_dir
> +        *and dir/sub_dir/
> +        */
> +       if (!is_dir_sep(path[l - 1]))

As "l" is used only here, maybe we could get rid of this variable
altogether with something like:

      if (!is_dir_sep(path[strlen(path) - 1]))

> +               strbuf_addstr(&sb, "../");
> +
> +       return strbuf_detach(&sb, NULL);
> +}

> +static void sync_submodule(const struct cache_entry *list_item, void *cb_data)
> +{
> +       struct sync_cb *info = cb_data;
> +       const struct submodule *sub;
> +       char *sub_key, *remote_key;
> +       char *sub_origin_url, *super_config_url, *displaypath;
> +       struct strbuf sb = STRBUF_INIT;
> +       struct child_process cp = CHILD_PROCESS_INIT;
> +
> +       if (!is_submodule_initialized(list_item->name))
> +               return;
> +
> +       sub = submodule_from_path(null_sha1, list_item->name);
> +
> +       if (!sub && !sub->url)

I think it should be "(!sub || !sub->url)".

> +               die(_("no url found for submodule path '%s' in .gitmodules"),
> +                     list_item->name);
