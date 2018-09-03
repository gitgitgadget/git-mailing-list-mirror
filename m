Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 987931F404
	for <e@80x24.org>; Mon,  3 Sep 2018 18:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeICWZO (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 18:25:14 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51849 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeICWZO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 18:25:14 -0400
Received: by mail-it0-f65.google.com with SMTP id e14-v6so2010702itf.1
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 11:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WJD5qt/QHf05QAtIWNeIIhZ+oKWoa2F9Ue9m4xzfhG4=;
        b=i7V3cjLWFxfq33buw5slXTC9M7NcNVdJ9X5DVqj7XozRpusvuPeY7TBHVcq+u/STQK
         WQnwnYaBPDUKe13T7u4Wq4HAvkyANGRkawNhnaAiOt8s1pdtv3aGvi1o6fFFyWqbItQH
         58NDNTObopj1uZyBjKfAsMRWi5ALb+Jes16Rgp7h5SX2OFuAGmpKNa7mvjQlhi/BDUhz
         VdsHQBXogtOn3T+4CHbOeQ+kvn1cICWXLpquJCOKTlWUTXPLYwhJtG/S2iS5CDPg66xP
         QKyvQYqbDI3gat3rg0E8OZGhSE8KlfEzU1vTrgcxDT11b6kv14engF113H75/ul4aayy
         VbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WJD5qt/QHf05QAtIWNeIIhZ+oKWoa2F9Ue9m4xzfhG4=;
        b=isDUyms/7nCp7MHOETXYpvfhqJNRSTc2tdftbwCO92kUdYgJS/syn2f6sOiNljP/Nu
         xBxXVl4p2pRu0Ux+b5gyX8qZmpHxlDFCCqPFcYPIlVj+loNEXqEIPVhNcq4VSgxgS24/
         v5HAT3dw6IYfJErkuCkRtQ9tOhDUU0UJ5lyOZ1aZVUTqaFg/2ilNNcdFIQsV3W2PglPa
         aQWm93bPycPhKKm1amtu6CpFYtnY8hZN9/WGdv/3x7SFbpw0gkOxCpDFCtKMaxU6PH+t
         XaVcKfgguyEChmkGtIfCUanSPleMR/STW0YJ9rP7dDO1M+z3Ofvb5ZJhtllhld+njxcI
         g4rA==
X-Gm-Message-State: APzg51Dgwue33D9sl0M85/sxaRF2ads/NDiDD7yFeoMSz6Xz8NBSytd9
        5yesTxYB91bSeWT052CPNZhXEA3Ui/x559sMaydrZg==
X-Google-Smtp-Source: ANB0VdYo0SC6UInCOyI7SqtuaqCUXbSlTU9+qO8WEVnkDHXD4x7dsDextVrHTDHuvJ9uXuwXaFS00XHqLDUut247DMU=
X-Received: by 2002:a24:d583:: with SMTP id a125-v6mr5724860itg.91.1535997836454;
 Mon, 03 Sep 2018 11:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180826100314.5137-1-pclouds@gmail.com> <20180826100314.5137-13-pclouds@gmail.com>
 <CAGZ79kb=gcmEDGmTS-j-veFj8BgKup0g96i0Gm1P+j8eyX8_mQ@mail.gmail.com>
In-Reply-To: <CAGZ79kb=gcmEDGmTS-j-veFj8BgKup0g96i0Gm1P+j8eyX8_mQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 3 Sep 2018 20:03:30 +0200
Message-ID: <CACsJy8D9ZMGA8FDmgcNMbWH7VP5O8bfn7tLnXda2TcQKmLM5NA@mail.gmail.com>
Subject: Re: [PATCH 12/21] patch-ids.c: remove implicit dependency on the_index
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 27, 2018 at 9:13 PM Stefan Beller <sbeller@google.com> wrote:
>
> > -int init_patch_ids(struct patch_ids *ids)
> > +int init_patch_ids(struct patch_ids *ids, struct repository *repo)
> >  {
> >         memset(ids, 0, sizeof(*ids));
> > -       diff_setup(&ids->diffopts, the_repository);
> > +       diff_setup(&ids->diffopts, repo);
>
> Just realized when looking at this diff, though it applies to
> other patches as well. (and reading Documentation/technical/api-diff.txt
> confirms my thinking IMHO)
>
> What makes the repository argument any special compared
> to the rest of the diff options?
>
> So I would expect the setup to look like
>
>     memset(ids, 0, sizeof(*ids));
>     ids->diffopts->repo = the_repository;
>     diff_setup(&ids->diffopts);
>
> here and in diff_setup, we'd have
>
>   if (!options->repo)
>     options->repo = the_repository;
>
> or even put the_repository into default_diff_options,
> but then I wonder how this deals with no-repo invocations
> (git diff --no-index examples for bug reports)

That makes "repo" field optional and I'm very much against falling
back to the_repository. revisions.c in the end does not have any
the_repository reference, and it's actually undefined for most files.
This makes accidentally adding the_repository back much more
difficult.

Yes the --no-index stuff will have to be taken care of at some point,
but I think for now we could just put "struct repository *" in place
first to see what it looks like, then go from there.
-- 
Duy
