Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26CC21F404
	for <e@80x24.org>; Sun, 25 Mar 2018 16:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753557AbeCYQqq (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 12:46:46 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37710 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753444AbeCYQqo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 12:46:44 -0400
Received: by mail-wm0-f49.google.com with SMTP id r131so4497452wmb.2
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 09:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qtms8EvVjAyNQAV3ne189BYQhDyd/zpYr2Uots6Z/V4=;
        b=WMh0vjeAr0uIXVo0p3NPFSsYVyt3JpSxQwzHIXNMt470Tu3sMf/X4yZ2NuYNH5lKHf
         WDWAcILNIxMBNXQrJ0sHUY66gg5dY+B4ArH30FqIvZ5cF6I7wmIfKF1J6GdSRQtQwyMc
         DvzEbygCkJ46aFPlSDkG14kYonbNr7mDQ+ZiBUhykPFYlMGcHr0jjUDHke1s+/W8E0V7
         LQ6PBRe+C/5P20G+ghus5jlxEsTkBvyEawctl09VyHyBtlC37PoQYgnLMDo2RhRuJknz
         QQLtloPCll3Bpq/liqc7V8rIlk3/7pDRQ+qt8EMiugvR+S6ud0vQotBtfipMKvH4bF8g
         dO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qtms8EvVjAyNQAV3ne189BYQhDyd/zpYr2Uots6Z/V4=;
        b=RRBUMDEvQc1P0cHkHzcFeT0DHv30ZIjr5M60CwbnnPOr+jNHb92k6VqbmaDcGTcQl1
         WEui9SgKcH5ZriC2pVZQsy4GT8vUlK53sLvmlvOucplWNoXxh5DPClCMGGFcg9pomz1M
         Cry9xnyRaE9C2dK7Uaw/zhSdEZ+zq9Fm8AUP62nX1/A6yq6f2BAaoMjNvFgAoVfOPmFV
         JpOPZDsig+gj1EibRoWNVp3ywDbK5gr4bFKQaVJSbNKFVbESLfPH/LJec15KmDxbHwhZ
         x/ouwPhmIVHArou01o76z7StcTYst/csxeNtotPBwBmbXujazD/IUWUWGldp7nu8/l6/
         6JTw==
X-Gm-Message-State: AElRT7Fn7LwV81Kz8ET4oRywZMeaeyHqzniHOSdJvXOtQEJRUsLgSVNz
        Km/hbMm9JhuhuvL8w9tVvEQ=
X-Google-Smtp-Source: AG47ELsdfMxLg1mhY85I4qk8TvvX0AClp+d1s/jRTA/O7LuqIJwJFCsFS+o8pOvWNMGypd0niUfLWA==
X-Received: by 10.28.15.83 with SMTP id 80mr13076365wmp.151.1521996403300;
        Sun, 25 Mar 2018 09:46:43 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c19sm8293573wmd.37.2018.03.25.09.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 09:46:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     prashant Nidgunde <pashnidgunde@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: query on git submodule (ignore)
References: <CAA7Y+T3OdaSBcqPmfJcVbPTjY=VFnvx9PH-rW9utQ4mXce+S8w@mail.gmail.com>
Date:   Sun, 25 Mar 2018 09:46:41 -0700
In-Reply-To: <CAA7Y+T3OdaSBcqPmfJcVbPTjY=VFnvx9PH-rW9utQ4mXce+S8w@mail.gmail.com>
        (prashant Nidgunde's message of "Sat, 24 Mar 2018 22:17:52 -0400")
Message-ID: <xmqqk1u0f6ha.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

prashant Nidgunde <pashnidgunde@gmail.com> writes:

[cc: stefan, for his interest in improving 'git submodules']

> Hello,
>
> I am new to this community ,so please ignore if I am asking anything silly.
>
> Case :
> Today when I built my submodule , and did a git status , it shows as modified.
>
> After reading certain suggestions on web i found out that i can ignore
> that adding a line in .gitmodules
>
> But, I had to add that line manually ( which could be errorprone
> because of typos )
>
>
> Question:
>     1. Is it feasible to build a feature like :
>                    git submodule "zlib" ignore dirty ( which will
> ignore submodule zlib when its built and dirty  as it has new files in
> its directory)

How does it prevent you from saying 

	git submodule "glib" ignore dirty

when you really meant "zlib"?  How is the command supposed to know
that you did *not* mean "glib", which may currently not exist in the
index nor in the working tree yet but you are about to create, and
doing the "ignore dirty" configuration as an earlier step of
multiple steps to add a submodule?

I personally doubt that the main issue you should be concerned about
is feasibility.  A larger issue is how it is supposed to help, iow,
is such a "feature" useful in the first place?

Whenever you hear yourself say "I have to do X manually, and I can
make mistakes. Can a command do it instead?", you have to ask
yourself: what pieces of information do you give to that command,
and how do you ensure you do not make typos on that command line?

Besides, the above syntax would not work.  What would a user do when
a submodule called "add" exists, for example?
