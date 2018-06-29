Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF7301F597
	for <e@80x24.org>; Fri, 29 Jun 2018 18:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935833AbeF2SfB (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 14:35:01 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:36541 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935211AbeF2SfB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 14:35:01 -0400
Received: by mail-yw0-f182.google.com with SMTP id t198-v6so3856023ywc.3
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 11:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xySdHQU6sAtqjGv1mHUnZ5QONCgLMXkPMuAh6I3QDxY=;
        b=BCAOwLOK9iDv/NND4ysVg93jMVKnU4gQNkQyRn2pe0TtbeQeSMD7rlKvyKG7CsJmsG
         veHUO9VN+3fm56oTKLN8/NbaalEK+tm0vEZeVItea5IA/5nYmTaebiTgcBCu+Ry5X+2b
         zUbIUzdTnz4rjlvJxl9L5+rz8RP/U+ukKODFwrHssCZrKKcjli1+GkyXg064tQv0m0rx
         8zN42MPIlmZ3TDN04EZD3NyDkusswGqQLTpaabjKNWSUGSFEJ2YvKmCFziI9KCRybogv
         RB9fgEKWH6OUy1jfY6teoCfrEuvYqYZVPVBof/L4cI3yiJ+Pn38L5YDlyT96l38oZuth
         xJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xySdHQU6sAtqjGv1mHUnZ5QONCgLMXkPMuAh6I3QDxY=;
        b=g0NDkqM+C3as+0e9NXeojZ3UXfMqZcLhh33C4Zxiivw39UJxAN8d4zl5VBhNPKhMKI
         iYXfUChzLX0CLkem+Z5XlsASi9GzudtdaXFJ2FI/1rTRT9PCJUUKZLJ397YNIX7TXLvG
         V8e1Q756f5oW/Lmsxiz2iKM7f9TenmEEn2+iH3SwWDSpgWacfKAP4zNEzhgadJyT/uJ3
         7FldnVqQoQurBsnVuve+/lGX/etBgi6wgvMI59n2CwBAmvfhYiAYkWqI0gY7io2OWQun
         13GixaVQ8H0KyxdjBG2Vk5/U8we5TD+RvcBlYnHKlPT9y4c5KQbsMlpa7YDALOyNLaAi
         l6GQ==
X-Gm-Message-State: APt69E05R657lfF0QTQClnffbcbpanZNFkwpn3HNjqf3JTTyfx3mVRPO
        kVCw3pAQxY7YHLyfiFXuXlGktF66+HaiQ+PeMLPzN1TPIQE=
X-Google-Smtp-Source: AAOMgpeeUblxRpLOm8b55HHeLlBusGHsIpUeOV7n73W85y+xoa2WZrrayELnNLBzkKoIaOxIYyllHcsckpvPZ4/iizw=
X-Received: by 2002:a81:e544:: with SMTP id c4-v6mr7723500ywm.345.1530297299750;
 Fri, 29 Jun 2018 11:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180629012222.167426-1-sbeller@google.com> <xmqq8t6xv5kb.fsf@gitster-ct.c.googlers.com>
 <xmqq4lhlv5a8.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4lhlv5a8.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 29 Jun 2018 11:34:48 -0700
Message-ID: <CAGZ79kb=W5_3FB6qSinPpcPzRgAe-qkuOCkXTjs6RLqUTjoboA@mail.gmail.com>
Subject: Re: [PATCH v3 00/32] object-store: lookup_commit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 29, 2018 at 11:03 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > One technique these (not just this) recent efforts seem to be
> > forgetting is to introduce "new" names that take a_repo and then
> > make the existing one a thin wrapper that calls the new one with
> > &the_repo as the argument.

So you'd rather want to see it less invasive done similar to
NO_THE_INDEX_COMPATIBILITY_MACROS ? Someone (jrnieder?)
called that a failed experiment, as now we need to carry that baggage
for quite some time and never cleaned up the started migration;
only recently Duy started to kill off the_index, which would finish
that migration?



> FWIW, here is how I am resolving semantic conflicts that I found so
> far while merging this topic to 'pu', which is stored in the
> merge-fix/ mechanism so that I can reuse it while rebuilding 'pu'.
>
> -- >8 --
> Subject: [PATCH] merge-fix/sb/object-store-lookup
>
> ---
>  builtin/bisect--helper.c | 2 +-
>  builtin/branch-diff.c    | 2 +-
>  negotiator/default.c     | 3 ++-

These look as if we can just use the_repository
(as you did below).

>  commit-graph.c           | 4 ++--

That is what I want to tackle next, and apparently you already did
by using the repository *r in there.

Thanks,
Stefan
