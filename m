Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6B1D1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 20:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeI1DBK (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 23:01:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36542 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeI1DBK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 23:01:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id l10-v6so4067801wrp.3
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 13:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=coUbo3Ad/i/jiTvvmYti4hGu7vprimfhJi7KfNHYzq0=;
        b=NSdFkT97hG0tItjLs8zI/SZhPEg4byA02usu5fpep08toGABvyGnBYGysc+tscRyFR
         AzUNQvFjNjrukc6SXTBOrm2tU0i5c9VURze//FyseJ9t3LjUDICAp6QPzGwIVHJUu+u3
         bKousyL7Pr27A4r3YrQuv+/YjsYBschMs5NHojdinfEm6Aa1r1NlsDcG0fPE8Vo9iRw0
         cNALY+ceLfiy904t341NI6s4rT3QqacKdNcHUULxUFOIDJQrIbQurT6Gr+6AHSwe6Ze7
         AglQg4WsOepGpmokBqwT8C3MD+jMujRnczTaY7I0qhw0Lgqbyem3smAZ/tg6wwJqODzs
         cKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=coUbo3Ad/i/jiTvvmYti4hGu7vprimfhJi7KfNHYzq0=;
        b=lWbqhF4RtdcLqetK6um8T/SeedV7GqQBr8UoehfFFHRjoec012Rykn5XPr9XXtqiZW
         MjEHGRD6Edn0lkGxH+GmIhXMKYe+nxIEmmzTxDOuA76pcPDROZHwH2BEme2nPILfUtvr
         sGmvhVaX3FalXP10QcYSiOGJ7Ij6JWUQ8GH7nf7dKL4jbGnLZ4dJmlFYr6jeX9JEyn/l
         1zbKo1F9QKIrriqO3+WZgBzRqbGJ3KBjTkZc26vUuJIvWu2rszHc6qQQwbpnImofVKd3
         ki5P4EfTm1MftaV13gtdlFqfaio6GgQZvQZp/yKpuaur2xQm9ssxWWBM7wosM30pqTiL
         gIUw==
X-Gm-Message-State: ABuFfog5GmeHQyhwn53OnLKX9C4HgOB8UtYvwxuZUTiJu4aYpON9A0ED
        UO7n4as2ZSLjsm2l0XhH5rREzLnQ
X-Google-Smtp-Source: ACcGV627Y2/B7vwCV6EYJ6xJOSpD15vrcI/5ETLl6Wpx9V8tRWo8q2ZO/mvZ95FSkqnp9+ftdMrLbA==
X-Received: by 2002:adf:94c2:: with SMTP id 60-v6mr2608588wrr.247.1538080862391;
        Thu, 27 Sep 2018 13:41:02 -0700 (PDT)
Received: from rigel (236.209.54.77.rev.vodafone.pt. [77.54.209.236])
        by smtp.gmail.com with ESMTPSA id d2-v6sm2897417wrm.71.2018.09.27.13.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 13:41:01 -0700 (PDT)
Date:   Thu, 27 Sep 2018 21:40:49 +0100
From:   Rafael =?iso-8859-1?Q?Ascens=E3o?= <rafa.almas@gmail.com>
To:     Nickolai Belakovski <nbelakovski@gmail.com>
Cc:     avarab@gmail.com, Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] branch: colorize branches checked out in a linked
 working tree the same way as the current branch is colorized
Message-ID: <20180927204049.GA2628@rigel>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20180927181708.GA2468@sigill.intra.peff.net>
 <20180927192804.GA27163@rigel>
 <87pnwyiu8k.fsf@evledraar.gmail.com>
 <CAC05385d=1s_qidC4uLdRAqUNaP7jwYTjfxHtGrmBDJ54F8pRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC05385d=1s_qidC4uLdRAqUNaP7jwYTjfxHtGrmBDJ54F8pRA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 01:16:19PM -0700, Nickolai Belakovski wrote:
>
> Not to hijack my own thread, but FWIW git branch -r shows remote
> branches in red, but old/new status of a remote branch is ambiguous
> (could have new stuff, could be out of date). Also, git branch -vv
> shows remote tracking branches in blue. One could argue it should be
> red since git branch -r is in red.
>

For me remote branches being red means: they're here but you cannot
write to them. They are like 'read-only/disabled' branches. Under this
interpretation red makes sense.


On Thu, Sep 27, 2018 at 9:02 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>
> E.g. I thought green here made sense because in "diff" we show the
> old/new as red/green, so the branch you're on is "new" in the same
> sense, i.e. it's what your current state is.
>

I still defend using green and dim green for this case. Because all
these worktrees are in a sense active. They're checked out in some
place. It's just the case that the particular one that we are in is
probably more relevant than the others.

--
Cheers
Rafael Ascensão
