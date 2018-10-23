Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00E2D1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 00:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbeJWIrn (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 04:47:43 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41755 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeJWIrn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 04:47:43 -0400
Received: by mail-ed1-f68.google.com with SMTP id x31-v6so39666498edd.8
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 17:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qi5BF2JU8lp6k4QXQ8Sc+gpF1zS7dMOD+Dw67/SCcmI=;
        b=qsO/mAfbLtwrAs7xdN5/deGIKn5NP2/pO0vt32PDcCKpiZua4S2oiYAhuFbc5Az8yG
         EgiSGzK066G6jAJF14sAZX8lSlj2AgZY6m0WJOeZx2sTV3FyCiga/Ct3DBv1/XMe24DU
         sWwIpZ2dpxOiLmTndWfAFnLzTS/d2JuGwH9JR53nVepbal4ITcI9pDkU423VtrzmxbXD
         oVjDbowgHzE2lndfDO0AMTZnoKW86vVCOVJLairQ9U8Hagj0oE/ysCQj1IdB32WrhxzR
         XwEku+mbwSzsoDMZ3TJmccTzw3hli1wy3DbGNZjcAoVlL+5gZf9fw5/01UxiWDcRJDDE
         k3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qi5BF2JU8lp6k4QXQ8Sc+gpF1zS7dMOD+Dw67/SCcmI=;
        b=BuMNABpOVu8DygctnYkBzGIkChbg7r9pJaPIqXIawsj/teYe1r4WyT0qHK0sCxkOBq
         n3mSq908uIstRP8S5zS6Cojjd3AwVwyHHSxh5Bbx4K7/LDC6NCHRAYmUwpGU/sbwM3fI
         1ScrM85RadGK6z3WKV+IFjLqRu3a75AF7LpKurV1hkt4zGdeVVwadoB5vKsnfRh0M7gn
         zTFPx5Q30pT5z7P7mfJYcXUULEc4X5x9AJjZrpclmMXnXef3VBaEycv/LFHFLm3k3W5u
         wqto2vPUNyApbTQkaUMYh2Ra8C425QCPQlUnogE8Qv4oIMKeN4l1bLUQv8QgGuuMj5Mc
         sSag==
X-Gm-Message-State: ABuFfoi20ZCyxGuFwuyFLboDCNrLjgdFXQ0eyyqs5yzT/pUb/8iVSX1t
        PE6E0kSh5VLRqcQHSKsVey4KhoHtk2mfI4ct4gMEfQ==
X-Google-Smtp-Source: ACcGV622AeDsAPA7iVBUhRPJcvr4ZUmmsVM2SH/BnJOkrtqcyZlN1zdZK7RcwMYIJs6yLWASV37nbCcMC3YjF56kflc=
X-Received: by 2002:a17:906:1f13:: with SMTP id w19-v6mr36172480ejj.65.1540254411491;
 Mon, 22 Oct 2018 17:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181016233550.251311-1-sbeller@google.com> <20181022173935.GG30222@szeder.dev>
 <xmqqzhv5tx4m.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhv5tx4m.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 22 Oct 2018 17:26:40 -0700
Message-ID: <CAGZ79kaWaY+oxJfoMbsCcq6MZDPoq1OgOwK0a9mkKR7sUEOHpg@mail.gmail.com>
Subject: Re: New semantic patches vs. in-flight topics [was: Re: [PATCH 00/19]
 Bring more repository handles into our code base]
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Stepping back a bit, I'd imagine in an ideal world where "make
> coccicheck" can be done instantaneously _and_ the spatch machinery
> is just as reliable as C compilers.
> [...]
> Now we do not live in that ideal world and [...]
>  such a series will have zero
> chance of landing in 'pu', unless we freeze the world.

I wonder if we could approximate the ideal world with
rerere+spatch a bit more:

1) I resend the series that includes "apply cocci patches"
    as the last patch and you queue it as usual

2) The first time such a series is merged, you'd merge
    HEAD^ (i.e. excluding the "apply the semantic patch)
    to pu instead. I view this as a yet-to-be invented mode
    '--theirs-is-stale-use-tree-instead=THEIRS~1^{tree}',
    then run spatch to reproduce the last patch into the
    dirty merge (which has pu and the last patch as parent)

    This step is done to 'pre-heat' the rerere cache.

3) Any further integration (e.g. rebuilding pu) would
    benefit from the hot rerere cache and very little work
    is actually required as the conflicts are resolved by rerere.

Am I overestimating or misunderstanding rerere here?

> What I _could_ do (and what I did do only for one round of pushing
> out 'pu') is to queue a coccinelle transformation at the tip of
> integration branches.  If "make coccicheck" ran in subsecond, I
> could even automate it in the script that is used to rebuild 'pu'
> every day, so that after merging each and every topic, do the "make
> coccicheck" and apply resulting .cocci.patch files and squash that
> into the merge commit.
>
> But with the current "make coccicheck" performance, that is not
> realistic.

Would it be realistic for next and master branch instead of pu?

I'd be wary for the master branch, as we may not want to rely on
spatch without review. (It can produce funny white space issues,
but seems to produce working/correct code)

> I am wondering if it is feasible to do it at the tip of 'pu' (which
> is rebuilt two to three times a day), 'next' (which is updated once
> or twice a week) and 'master'.

We could even optimize that, by checking if contrib/cocci/ has
changes for the new tip of next/master respectively.

Another thing I wonder is if we care about the distinction between
the (a) pending changes as described by SZEDER, as we introduce
these deliberately, whereas (b) undesirable code patterns
(e.g. free and null instead of FREE_AND_NULL macro) might be
caught and reported in pu/next and then someone learns from it.
Automatic rewriting the (b) cases seems not just as desirable as
(a), where we do it purely to avoid resolving merge conflicts by
hand.

> I find that your "pending" idea may be nicer, as it distributes the
> load.  Whoever wants to change the world order by updating the .cocci
> rules is primarily responsible for making it happen without breaking
> the world during the transition.  That's more scalable.

... and I think SZEDER considers the current world broken as
'make coccicheck' returns non-empty, so it sounds to me as if
the current transition is thought less-than-optimal.
