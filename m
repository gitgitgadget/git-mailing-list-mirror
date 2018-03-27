Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45DF81F404
	for <e@80x24.org>; Tue, 27 Mar 2018 14:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeC0O4d (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 10:56:33 -0400
Received: from mail-ot0-f179.google.com ([74.125.82.179]:43267 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbeC0O4c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 10:56:32 -0400
Received: by mail-ot0-f179.google.com with SMTP id m22-v6so24804672otf.10
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 07:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EfRH6Uj0Uyz3UqZCxkz5Be9XD+zSaojXsYOP6gHUEXs=;
        b=Hu5sF71eDjy37lH4Wjd1RTv6weKlVn7K++rzRaSiBj00uaFvfAj91qDQvb64Gmbs1g
         9SQZfGFu6dOwhxb3dnWVk6lzNIF/YZsQpSLjgIFJZfQMRp31n5yGRoSwherY2ul1posh
         k5LtlbFmc6SxByc4mIhynb3gsZ/xuAmtjyfe3KeI5OOywDQGBQmgAKs4Zy6Q6ltrjDic
         D6ePUvmspFvgMVt5CV8HUQ0JVFEZgwkS0peSeerildrg4b5Ct/3r1PRI26JOHwGw4BQp
         cl9V/b6Ju6cOs2oOaCvhDmxsJzEaBb/aUhc0FRyK82Txgch/bng/oWVAN8EQSdX8FHeZ
         qQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EfRH6Uj0Uyz3UqZCxkz5Be9XD+zSaojXsYOP6gHUEXs=;
        b=BxHZLCgiv7v4D5rIYZiABUU+BbTRzK8GCzqJHfJBlS4AKL3Gb2z0cPkxQ+/m3kTExw
         /9Byts/09YfF1GPQrEfYSfDFoQBSGcYfE4cwCsy+oKPoDdpagrdcfooF+P4O8Tf7EV1h
         VHZRjewELT1PSjLuDi+3p7cGfS3J4sSFHLf0twuFPqT/A4WQQhE/5UJKEkXSlQCXtkh+
         QeJM7h7L93FxZC952iupYw9qjnKKnPB4rE/qepLgu4dxT2/WwZaO30ndhseglD/Xbd6T
         LW6OwSSeM1kLOyluYSfDuZl72MRzndQi/erCUCOCouuPC36cNYiDWnYxyJvINe38lTXz
         UmUQ==
X-Gm-Message-State: AElRT7G81vNVPhQjf1mKIdHqgHhqOuEBrMXOHjviWeyEw1PzbiUBz44+
        5klLjdjqS2twtrQfBQ4KHuNLd+xjsNHuK2d36KI=
X-Google-Smtp-Source: AIpwx48cNKfHQNEcoA88B92LbSqHvad5JEtwKi3P6BZklnIKp+JTSHuICxsLZHklx0sFZZ/Hl/jIu69hugMi0MdAYuE=
X-Received: by 2002:a9d:16f3:: with SMTP id s48-v6mr7678924ots.304.1522162591169;
 Tue, 27 Mar 2018 07:56:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.211.131 with HTTP; Tue, 27 Mar 2018 07:56:00 -0700 (PDT)
In-Reply-To: <20180327063137.GA24044@sigill.intra.peff.net>
References: <CACUQV5_3Pw+vnyyNUL4oE4tMLG_wKVdqdVk01rg4V92ufUYHHA@mail.gmail.com>
 <20180327063137.GA24044@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 27 Mar 2018 16:56:00 +0200
Message-ID: <CACsJy8DP53Og1crS1bLoJf6w8cJhjGKy=ggfbsqzJ6AU4eNhPA@mail.gmail.com>
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

On Tue, Mar 27, 2018 at 8:31 AM, Jeff King <peff@peff.net> wrote:
>...
>
> But that really feels like we're papering over the problem.

It is papering over the problem in my opinion. setup_work_tree() is
involved here and when it moves cwd around, it re-init git-dir (and
all other paths). Before my patch we call git_path() only when we need
it and git-dir is likely already updated by setup_work_tree(). After
this patch, the path is set in stone before setup_work_tree() kicks
in. Once it moves cwd, relative paths all become invalid.

The way setup_work_tree() does it is just bad to me. When it calls
set_git_dir() again, the assumption is the new path is exactly the
same as the old one. The only difference is relative vs absolute. But
this is super hard to see from set_git_dir implementation. The new
struct repository design also inherits this (i.e. allowing to call
set_git_dir multiple times, which really does not make sense), but
this won't fly long term. When cwd moves, all cached relative paths
must be adjusted, we need a better mechanism to tell everybody that,
not just do it for $GIT_DIR and related paths.

I am planning to fix this. This is part of the "setup cleanup" effort
to keep repository.c design less messy and hopefully unify how the
main repo and submodule repo are created/set up. But frankly that may
take a long while before I could submit anything substantial (I also
have the "report multiple worktree's HEADs correctly and make fsck
count all HEADs" task, which is not small and to me have higher
priority).

So I would not mind papering over it right now (with an understanding
that absolute path pays some more overhead in path walking, which was
th reason we tried to avoid it in setup code). A slightly better patch
is trigger this path absolutization from setup_work_tree(), near
set_git_dir(). But then you face some ugliness there: how to find out
all ref stores to update, or just update the main ref store alone.

> It's not
> clear to me exactly what f57f37e2 is trying to accomplish, and whether
> it would work for it to look call get_git_dir() whenever it needed the
> path.
>
> -Peff
-- 
Duy
