Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A06B20951
	for <e@80x24.org>; Fri, 17 Mar 2017 18:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbdCQSRL (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 14:17:11 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35446 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdCQSRK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 14:17:10 -0400
Received: by mail-pg0-f50.google.com with SMTP id b129so47030640pgc.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 11:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oX/XWo2KKERYVgRu+dxNT4kxFWYrEpLRruv490i7yWQ=;
        b=EBu115IpsD4KeM4KLGjcGhPRaI1d7/EggrqFUnbfhEEl7jUmPOb6UkHLK1+Qch9rAa
         20yDgjzYFqCS1ArEtam0hEXuBSJe1TGCHnNuDAWGZ/gTvyQsh5ce/tmVNNLPnm3jx/Pq
         k5oSM9HkIKeptd2Q79JvgaukvjupcifFRxYDbvt13VjjusWEQIai/89qrhNLsgz29Huy
         2CL56EzbbSCgmYHsv7mDSIKnM+uLGZTsCGNxM3En1H4HtSUJcBCjvzq0kRgXmlJEIeO6
         PvckTP6BgzlwhBITK8OEQMeR+SSBdGKB8xRv2pH5Gw2TjZvqT9j9bX9JDKnX0F3dykhm
         fliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oX/XWo2KKERYVgRu+dxNT4kxFWYrEpLRruv490i7yWQ=;
        b=aQEsVqAmrMAuFJ+8SvCciI4z7+/9Cgbungos1awtezAVLYMLxbGF851acUAimEZ3gv
         rY+TOFwgZYW2yo2Ooo2u7wsNDNUgR8J3BdOkjoGTjDm6HcA/rITot1jtIGHtVVAIebtz
         BPM+/PaQt2khmW7v0jqyoo8M7uQ+LGcyhdInMBAo24Jt0yh0X5GIpBU5brj7fnCd6thH
         HI9a7I8ptDdF6xFI+J+VY1/UVyUra4nqa7GhZp5ak2AOah1I+m/k7EM/gtU2j2rwGdVS
         ID3puNYMV3IztqdFkkOMIgmW/SZuSddGVZG7fPfLxGurNedSVq+qlMK4qU9WngrWK4ta
         2lZg==
X-Gm-Message-State: AFeK/H10C06xGC/ak+VPF+Kaz9shOiIwPnu2NRfW7D0LEIKvryBwfcOo81aS6owbdlbsLiv4zwgsjf6bar602j5H
X-Received: by 10.98.69.86 with SMTP id s83mr18684667pfa.232.1489774628845;
 Fri, 17 Mar 2017 11:17:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Fri, 17 Mar 2017 11:17:08 -0700 (PDT)
In-Reply-To: <20170316222952.53801-8-bmwill@google.com>
References: <20170313214341.172676-1-bmwill@google.com> <20170316222952.53801-1-bmwill@google.com>
 <20170316222952.53801-8-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 17 Mar 2017 11:17:08 -0700
Message-ID: <CAGZ79ka-rQ3YtdduAMYf-XYitKMfX2iEVh4wfR1vD6RzqhHDzw@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] submodule init: initialize active submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2017 at 3:29 PM, Brandon Williams <bmwill@google.com> wrote:
> Teach `submodule init` to initialize submodules which have been
> configured to be active by setting 'submodule.active' with a pathspec.
>
> Now if no path arguments are given and 'submodule.active' is configured,
> `init` will initialize all submodules which have been configured to be
> active.  If no path arguments are given and 'submodule.active' is not
> configured, then `init` will retain the old behavior of initializing all
> submodules.
>
> This allows users to record more complex patterns as it saves retyping
> them whenever you invoke update.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---


> @@ -417,7 +445,13 @@ static int module_init(int argc, const char **argv, const char *prefix)
>         argc = parse_options(argc, argv, prefix, module_init_options,
>                              git_submodule_helper_usage, 0);
>
> -       if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
> +       /*
> +        * If there are no path args and submodule.active is set then,
> +        * by default, only initialize 'active' modules.
> +        */
> +       if (!argc && git_config_get_value_multi("submodule.active"))
> +               module_list_active(&list);
> +       else if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
>                 return 1;

I would rather reuse module_list_compute and then post-process the list
to filter out inactive submodules iff "submodule.active" is set as that seems
cleaner and performance is not a pressing issue here?

>
> +static void module_list_active(struct module_list *list)
> +{
> +       int i;
> +
> +       if (read_cache() < 0)
> +               die(_("index file corrupt"));
> +
> +       gitmodules_config();

Here we also need to have

  git_config(submodule_config, NULL);

such that is_submodule_initialized works correctly,
I would assume?

> +
> +       for (i = 0; i < active_nr; i++) {
> +               const struct cache_entry *ce = active_cache[i];
> +
> +               if (!S_ISGITLINK(ce->ce_mode) ||
> +                   !is_submodule_initialized(ce->name))
> +                       continue;
> +
> +               ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
> +               list->entries[list->nr++] = ce;
> +               while (i + 1 < active_nr &&
> +                      !strcmp(ce->name, active_cache[i + 1]->name))
> +                       /*
> +                        * Skip entries with the same name in different stages
> +                        * to make sure an entry is returned only once.
> +                        */
> +                       i++;
> +       }
> +}
