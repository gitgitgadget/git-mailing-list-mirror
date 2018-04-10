Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B42D1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 18:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752137AbeDJSiF (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 14:38:05 -0400
Received: from mail-yb0-f170.google.com ([209.85.213.170]:43093 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751849AbeDJSiE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 14:38:04 -0400
Received: by mail-yb0-f170.google.com with SMTP id z5-v6so4659500ybo.10
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 11:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i2XpbBHpuNDd2RTI9n9U7CQxB1+dxvIHYn0BfpxVuaY=;
        b=sdoBjR3RlQ0NAjbJukfTw/GGFcx4uE1TDN6oH2WTnwxlEQHH4YIRPwKCxEnM4rlF84
         3JDcyD9y4C4M2+YcjtrhWcXKZEnnUlwZ1L4KrEqEUFT/CWTs4iSa1IIg8Dpop8qVGhKN
         /Gd9A9bftj8Df/wYhjUxAtODey3PWXeZbLJka2IusTQc7L7ObDRF5mOfVxouodaRYKYG
         WxVTvo/9zEkblnwXqpqxeZcZlZ8DfFlS1bYWNW1gq/hmJBZWi+8sSb1c/4yR377eFOZz
         sgehOP87InwZh6zyEr5K9Q+UH82mQex03GDTKK9gxMSoFkei6PHwujju0YPUWz3QVBpf
         FM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i2XpbBHpuNDd2RTI9n9U7CQxB1+dxvIHYn0BfpxVuaY=;
        b=e0oSzGji9ap5Uqe/k8fWEvTEXOKzA1KY9PUDJsjy6OX1WlEP59jpbl5/FV9gx+eI8K
         MXWReJys2FQt2+G0GV1Pig8Iczb11pL57TplIwyKg9GwHcdEn082GIX4Vz65AQDUYmtR
         n9mx0y3h8TtFTu4QlLQe2wkF9lfkiEDohgyZ6iILnQGxb1Zdc0AIoJck052dJ+sqN1jZ
         1G+N5dONAk9/MPuX2BnftGcbw7NhYr8uBdl6xXvGNbTri6SvMXEXbBH5d1csrPDgOlon
         ufhNlHtUyAGKQsizzL4BPeVkD6rf8HmCXUP56cXv8RDuguCuS6bijuDMnCdFNQkON7h3
         3HlA==
X-Gm-Message-State: ALQs6tC/NnuEP2RkZ5OZXMNXmrYCS6eU0T7XFxOz/xSWLXEM+RPC3MF+
        87bnjcLwNBMRn+ee4W1vEr4MWNcDFt4ui0GvhvHRKA==
X-Google-Smtp-Source: AIpwx4+xftMpYsL15lsHDDjb/GCWTBHg+TcNNwklQz373bIFMTzBQmEOi2tuZWCIyLRJIZv4Uzw48X87ZmVLHEN0AR0=
X-Received: by 2002:a25:ba51:: with SMTP id z17-v6mr985466ybj.334.1523385483412;
 Tue, 10 Apr 2018 11:38:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Tue, 10 Apr 2018 11:38:02
 -0700 (PDT)
In-Reply-To: <2c6214de-36b0-c67b-9a40-d43d28e780c4@alum.mit.edu>
References: <20180406232136.253950-1-sbeller@google.com> <20180409224533.17764-1-sbeller@google.com>
 <20180409224533.17764-13-sbeller@google.com> <2c6214de-36b0-c67b-9a40-d43d28e780c4@alum.mit.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 10 Apr 2018 11:38:02 -0700
Message-ID: <CAGZ79kZEOzAOqYePMxHMZChuoO3ryy8xY41KCPTp=HT-3TRVPw@mail.gmail.com>
Subject: Re: [PATCH 12/16] refs: store the main ref store inside the
 repository struct
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>,
        sunshine@sunshineco.us, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On Tue, Apr 10, 2018 at 7:02 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:

> This also makes sense to me, as far as it goes. I have a few comments
> and questions:
>
> Why do you call the new member `main_ref_store`? Is there expected to be
> some other `ref_store` associated with a repository?

I'll rename it in a reroll.

>
> I think the origin of the name `main_ref_store` was to distinguish it
> from submodule ref stores. But presumably those will soon become the
> "main" ref stores for their respective submodule repository objects,
> right?

I hope so.

> So maybe calling things `repository.ref_store` and
> `get_ref_store(repository)` would be appropriate.

ok.

>
> There are some places in the reference code that only work with the main
> repository. The ones that I can think of are:
>
> * `ref_resolves_to_object()` depends on an object store.
>
> * `peel_object()` and `ref_iterator_peel()` also have to look up objects
> (in this case, tag objects).
>
> * Anything that calls `files_assert_main_repository()` or depends on
> `REF_STORE_MAIN` isn't implemented for other reference stores (usually,
> I think, these are functions that depend on the object store).
>
> Some of these things might be easy to generalize to non-main
> repositories, but I didn't bother because AFAIK currently only the main
> repository store is ever mutated.
>
> You can move a now-obsolete comment above the definition of `struct
> files_ref_store` if you haven't in some other patch (search for
> "libification").

ok, I'll have a look at that.

My plan was to remove the submodule accessors from the refs API, and
mandate the access via

    repo_submodule_init(&submodule_repo, superproject_repo, path);
    sub_ref_store = get_ref_store(submodule_repo);

instead of also having

    sub_ref_store = get_submodule_ref_store(path);

as that would ease the refs API (and its internals potentially)
as well as avoiding errors with mixing up repositories. As the
construction of a submodule repository struct requires its
superproject repo, it helps avoiding pitfalls with nested
submodules IMO.

Thanks for the comments,
Stefan

>
> Hope that helps,
> Michael
