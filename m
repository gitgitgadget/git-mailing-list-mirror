Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34E3B1F404
	for <e@80x24.org>; Tue, 27 Mar 2018 17:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752377AbeC0RKJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 13:10:09 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:42992 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbeC0RKH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 13:10:07 -0400
Received: by mail-oi0-f43.google.com with SMTP id l190-v6so11612614oig.9
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 10:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aP/k7Yai+/Bl+BIutaTqJ4ZhAlE9X+GU63p4CRfcnx8=;
        b=gZBf0ZbQyHDzJL6zgt3qtlvTOz4bnUbLj0oQfQ+QU32Ni9vKegXS1Ux1+NOpf/sBy7
         hUKRVRy9TY4v7LbTmGX77MBaL8FJOMu3V5b159sOh9OvbluI85TH4Y439d7vhghhIc7l
         5fqErIks1d1xitjFO+S+WX5lQ49GhejA/eM0t/aWaPjk0cTo3wlSViM4oL1hm1rldfUV
         N/wVL/luvnzb1y8UsRwBnUHhPKp3A4BINuTG59A3Yf420WBHNcbRsJ8rKsqDCJ+lICH2
         v3qGYV+gTHXJyagtgtQX8rOv46b5yBzo8JaDZLStHfE85ePFHgTm0mmOdhAIAzgqp1Is
         MLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aP/k7Yai+/Bl+BIutaTqJ4ZhAlE9X+GU63p4CRfcnx8=;
        b=tC7ayQJgtCDmE7T9j/4QOCvzqTRJpTzir1SPUPdskYZjg/OSRPKiwa/g1HpUS2Gv8/
         2B2XeOjHCJrlJkWDG5lfrFJkPPt7BRWexIg95ijFlLBRgVGq0D4XcSME+Ut6fJOsThjH
         87tQAKK/SdYGmZj9nUfoCm7/Yn3JOtdR5xk24tDOLPTMlBdIjhXHZeUDSO8n5zTgo/mY
         Rk04Y+INgvEpqrMb3XGAgwbKADoo4JqYfYOExoTr6Sr4n98iEyKApLgVAknLDEmBALtT
         PAb47iNuvJ/CAuLe13uFnk4ldcoPUByx/uxHzoAc1u6RIbBq4g39UQ64TyOA9mvfA0QP
         zfgQ==
X-Gm-Message-State: ALQs6tBo/m4em7FhCVDqGIoTe1VVd4ZCB8ja0joVTRr+gwDEg0JYUp8b
        0VM8xfyivXGzmh8CtQqmMX6gPZQb8b7rPBRiGvg=
X-Google-Smtp-Source: AIpwx49gSXPdHOxBDZK7xUXNU//FtN/xo6xd6TDymptonWjPww68DI104htBJJv58rEtVQaAt8OPJA/Xr2uDAGrwjdA=
X-Received: by 10.202.241.65 with SMTP id p62mr131548oih.56.1522170606904;
 Tue, 27 Mar 2018 10:10:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.211.131 with HTTP; Tue, 27 Mar 2018 10:09:36 -0700 (PDT)
In-Reply-To: <20180327164757.GB24747@sigill.intra.peff.net>
References: <CACUQV5_3Pw+vnyyNUL4oE4tMLG_wKVdqdVk01rg4V92ufUYHHA@mail.gmail.com>
 <20180327063137.GA24044@sigill.intra.peff.net> <CACsJy8DP53Og1crS1bLoJf6w8cJhjGKy=ggfbsqzJ6AU4eNhPA@mail.gmail.com>
 <20180327164757.GB24747@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 27 Mar 2018 19:09:36 +0200
Message-ID: <CACsJy8Bog6U7X-jvzDhq14heQWx0HA_21HsSYR0nykU9aDsCYQ@mail.gmail.com>
Subject: Re: git complains packed-refs is not a directory when used with
 GIT_DIR and GIT_WORK_TREE envvars.
To:     Jeff King <peff@peff.net>
Cc:     Rafael Ascensao <rafa.almas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 27, 2018 at 6:47 PM, Jeff King <peff@peff.net> wrote:
>> So I would not mind papering over it right now (with an understanding
>> that absolute path pays some more overhead in path walking, which was
>> th reason we tried to avoid it in setup code). A slightly better patch
>> is trigger this path absolutization from setup_work_tree(), near
>> set_git_dir(). But then you face some ugliness there: how to find out
>> all ref stores to update, or just update the main ref store alone.
>
> I don't quite get why f57f37e2 doesn't want to call git_path(). Is it to
> avoid the way the path is munged? Or is it to avoid some lazy-setup that
> is triggered by calling get_git_dir() at all (which doesn't make much
> sense to me, because we'd already have called get_git_dir() much
> earlier). Or is it just because we may sometimes fill in refs->git_dir
> with something besides get_git_dir() (for a submodule or worktree or
> something)?

None of those, I think. git_path() does some magic to translate paths
so that refs/... ends up with $GIT_COMMON_DIR/refs/... while "index"
ends up with $GIT_DIR/index. Michael wanted to avoid that magic and
keep the control within refs code (i.e. this code knows refs/ and
packed-refs are shared, and pseudo refs are not, what git_path()
decides does not matter).

> I.e., can we do one of (depending on which of those answers is "yes"):
>
>   1. Stop caching the value of get_git_dir(), and instead call it
>      on-demand instead of looking at refs->git_dir? (If we just want to
>      avoid git_path()).

This probably works, but I count it as papering over the problem too.

>
>   2. If we need to avoid even calling get_git_dir(), can we add a
>      "light" version of it that avoids whatever side effects we're
>      trying to skip?
>
>   3. If the problem is just that sometimes we need get_git_dir() and
>      sometimes not, could we perhaps store NULL as a sentinel to mean
>      "look up get_git_dir() when you need it"?
>
>      That would let submodules and worktrees fill in their paths as
>      necessary (assuming they never change after init), but handle the
>      case of get_git_dir() changing.
>
> Hmm. Typing that out, it seems like (3) is probably the right path.
> Something like the patch below seems to fix it and passes the tests.

Honestly I think this is just another way to work around the problem
(with even more changes than your abspath approach). The problem is
with setup_work_tree(). We create a ref store at a specific location
and it should stay working without lazily calling get_git_dir(), which
has nothing to do (anymore) with the path we have given a ref store.
If somebody changes a global setting like $CWD, it should be well
communicated to everybody involved.

I would rather have something like ref_store_reinit() in the same
spirit as the second call of set_git_dir() in setup_work_tree. It is
hacky, but it works and keeps changes to minimal (so that it could be
easily replaced later).
-- 
Duy
