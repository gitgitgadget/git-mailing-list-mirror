Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D30EE1FBB0
	for <e@80x24.org>; Fri, 25 Nov 2016 12:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753463AbcKYMUo (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Nov 2016 07:20:44 -0500
Received: from mail-yw0-f176.google.com ([209.85.161.176]:36424 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753324AbcKYMUm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2016 07:20:42 -0500
Received: by mail-yw0-f176.google.com with SMTP id a10so61529781ywa.3
        for <git@vger.kernel.org>; Fri, 25 Nov 2016 04:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=idVxif6nMMUrJAZMqP9W33B59ywuJrChYUzGo2LAoM0=;
        b=KjTXe0kRIQUhIcxmbbdHCYo5//V0aNKeb66Zx9I57qP4GTJRok6PkPH1ElB9VPxR+H
         KKdxAw+/Vr6H4LvDemzrgoQwiy65pvlYnOOJJNZTiEma1NcHybwN6LpckRvEQVTTtcmx
         7wxYHbAz/oODoadIo/HzeeL00uuiTTBmgPhDZj0tRjr4EG9cB7yEc4pjGGZxG47l/9eL
         gmxc1EayLrac7w2FSr8pRIAwyh8xMVQM1N8Xe3xJyzAujDyh+MOmubdT3EG6yEvpp/yx
         NLjOXAueyDMLVQp2G37lDLPnLfVAMQz+GmTHy65n91ryq4xjup1icMwH8aONxe0F9agF
         6yGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=idVxif6nMMUrJAZMqP9W33B59ywuJrChYUzGo2LAoM0=;
        b=cIa3RK+bZRw4I97gyznL/TiPG94sOyS2kniIR+xVos7eaQY4EQFBY3JLTDvN+FNoC3
         OKTPztvEiH5/tdjW209cWxiCYcx+Q9G2P1eQhbEXVK9Bk5zYS7hat+nq0KnheXFrSvQJ
         JTuhvSJ8LSIMfAR3ZySrAyeQHHCmbLzAkIos+qNKba40f5fMrv8mTKlmdfeVJCbvmIG8
         hJxFb62lub3D7qjlz4lnjWyBq0gnPnhKEwmZK0LvxgdznpG0+jA4ZE7nuv7T1Qb28jsM
         fu6ektLO3GlmKaiI0PPYvTtSFuejg3UwbVxVAQIl+utprv9wKly8/6lmIbdVlpFQxWHd
         0+7g==
X-Gm-Message-State: AKaTC01Ib4IvxDmY5XWwqQz1lfrZ74fX6JrwxxnNnJYe8BjE4GldwCX/XraB0/rYY0EDD0Ga+j8nT/L841vhKg==
X-Received: by 10.13.224.3 with SMTP id j3mr10405615ywe.46.1480076401815; Fri,
 25 Nov 2016 04:20:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.211.7 with HTTP; Fri, 25 Nov 2016 04:19:31 -0800 (PST)
In-Reply-To: <xmqqwpfum801.fsf@gitster.mtv.corp.google.com>
References: <20161122100046.8341-1-pclouds@gmail.com> <20161122100046.8341-4-pclouds@gmail.com>
 <xmqqwpfum801.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 25 Nov 2016 19:19:31 +0700
Message-ID: <CACsJy8C-5f-PErg6zx5OuURaA717o_g_RddjvwMUnO+vKCHrNA@mail.gmail.com>
Subject: Re: [PATCH 3/3] worktree list: keep the list sorted
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Mike Rappazzo <rappazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 24, 2016 at 12:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
> More importantly, perhaps get_worktrees() should learn to take an
> optional pointer to int that returns how many items are in the list?

My first thought was "yeah I remember there are many counting loop
like this" then grepped and realized this is the only place. For now I
think it's ok to leave it as is. When the second place does the same,
we'll change get_worktrees()

> Alternatively, other existing callers of the function do not care
> about the order, so it may not be such a good idea to always sort
> the result, but it may be a good idea to teach it to take a boolean
> that signals that the list should be sorted in a "natural order",
> which is how "worktree list" would show them to the user?

OK. I'll make it a bit flag, not a boolean though, to avoid changing
all call sites next time.
-- 
Duy
