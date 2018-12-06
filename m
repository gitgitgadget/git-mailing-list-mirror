Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FC69211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 22:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbeLFWAL (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 17:00:11 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:35019 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeLFWAK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 17:00:10 -0500
Received: by mail-ed1-f41.google.com with SMTP id x30so2084954edx.2
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 14:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+vWHtlCDDQKv5bme4smePx6pwAef4nHZcDJi66a9LuQ=;
        b=TZeNaf+ElA3gZhUv0RqDSNgFaaiPhaLc0i04NyCdLMB6jENg3gcHwMfa5zA8dDTawV
         ASCd7cxoJWKH7XRJT1teSXosCTIs92XfJgJtf1LvaLUh9qX8SCcoct1sJAFpBco5iO3z
         7+tXYS+sqh8uSCYI9iM1rdflvvW85x6vUQ0J4i44+rAHnECDEDKOnFnx5LpQlUQyzz69
         PX8uv3G6qdx2TVEwUzcxmcZn2JBhKFAR8C37O1ehnCOPpTQhP9oiYcXKMURhkYWlEHiU
         gp5m+Y6VNAKBhJWfc8b4mxia3G0I99kRacTpy13sHMetT1KlLFwATWkL0vKxPbhO9OJR
         G5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+vWHtlCDDQKv5bme4smePx6pwAef4nHZcDJi66a9LuQ=;
        b=YrqDrI5pIA7NI8OaOV/yaqrZapP22f922hK7iJMo9XFjJn/HOMQpko/ajyAN0/QSMK
         ltamgASp19rPd40aSFAOyyn6R2xlwlqkdse82AVclDdfLT749eW7laoXhyxM+ckxEmKV
         VbusqxFsX5aP2RuzoGx6r3XBfssaNqXOYtkSfMVGhAJjj7CWcyFcxRNvbaJEJHri7jhm
         ku7KfJUxJrlxy7MtauosAVNz3K/ksG5isgdcHRdqEB1nf3116iE4ok4S269phxzqrRdl
         sUe9/PWh437U1nN/sZTby5wOIvXKIOkFZG7f+hBynMXBoREYanF0VHsA2Ohr0WYOFhIH
         pInQ==
X-Gm-Message-State: AA+aEWbnEObUQgKSSqnqdI3mjNe+HuITkaIUJyuKN8tg6Ylv4lAu+mIJ
        oPnrXZGwoBTQKihNz1w84HvE+Kx7Hoj/cRut5+QPeg==
X-Google-Smtp-Source: AFSGD/UgK7xocDSBzrZ9u2SEP83CL0Vp2XCapnm/3PKVX5IyowdHoSILqZ/58ElYjzbRIGBJZ9iAUMREHSpsUjmuYCY=
X-Received: by 2002:a50:acc3:: with SMTP id x61mr86892edc.76.1544133608748;
 Thu, 06 Dec 2018 14:00:08 -0800 (PST)
MIME-Version: 1.0
References: <20181129002756.167615-1-sbeller@google.com> <xmqqa7lkeki3.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa7lkeki3.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 6 Dec 2018 13:59:57 -0800
Message-ID: <CAGZ79kZaw_Pn8mneHYeUebB2vZ+N0FoJBr9NCWp8atfpjLat4g@mail.gmail.com>
Subject: Re: [PATCHv2 0/9] Resending sb/submodule-recursive-fetch-gets-the-tip
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 4, 2018 at 7:10 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > This is a resend of sb/submodule-recursive-fetch-gets-the-tip,
> > with all feedback addressed. As it took some time, I'll send it
> > without range-diff, but would ask for full review.
>
> Is that a "resend" or reroll/update (or whatever word that does not
> imply "just sending the same thing again")?

As you noticed, it is an actual update. I started to use resend
as DScho seems very unhappy about the word reroll claiming we'd
be the only Software community that uses the term reroll for
an iteration of a change.

I see how resend could sound like retransmission without change.


>                         child_process_init(cp);
>      -                  cp->dir = strbuf_detach(&submodule_path, NULL);
>     -                   prepare_submodule_repo_env(&cp->env_array);
>      +                  cp->dir = xstrdup(repo->worktree);
>     +                   prepare_submodule_repo_env(&cp->env_array);
>
> Hmph, I offhand do not see there would be any difference if you
> assigned to cp->dir before or after preparing the repo env, but is
> there a reason these two must be done in this updated order that I
> am missing?  Very similar changes appear multiple times in this
> range-diff.

Jonathan Tan asked for it to be "diff friendly". This -of course- is
range-diff unfriendly.

> [...]

you seem to be OK with a lot of the changes, I did not find an
actionable suggestion.

Thanks for still queuing topics during -rc time,
Stefan
