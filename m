Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31D041F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbeH2BnI (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:43:08 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41967 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbeH2BnI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:43:08 -0400
Received: by mail-ed1-f65.google.com with SMTP id f38-v6so2452099edd.8
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 14:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jFlVdcETeLiXM0OhIS0G6yRzCHirW6QExP06gsAQOnY=;
        b=M0Eqy2TLn/5ky0DEwU2b0hxsSe4t0ITOAjrgedb/NnUCsmODMIfKACLgqbDXN7rOWr
         aeIaUzsXNDs5bT6TeNoZldLyzDKR0bBdFklOf/7po87F+0Xp8H2+LoRxO/Cebg9oKtau
         YOvimfKrCqM1O51KnlrOS+OpX2NBv6UyKnrkBik89jiRjdjau82KlQNq0tSPdQWq1hb5
         McFXBquQEraKEVtWh7c0fWWuNUHsV1n9ZRwmKMGzsvKhbWFQGBqxhdkLkYOIGi+Gf1HJ
         UiSGvilLA6y0JRCmvjg1dXP2iS+x0gZhYKN/xZAJmv5e9jBm/BNMx+D8YgP6Tfdfr/dd
         qo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jFlVdcETeLiXM0OhIS0G6yRzCHirW6QExP06gsAQOnY=;
        b=KBaxC6waKMtfvO0pUoFvufpRdXCwfCwrYyhFDGLW1Pi/DHNY7jEvHpj17E8sw+bhzG
         sPkAtdI3iJxIQHToagHViJ7sgMAu0T35d8TtsMhzHqt0ea9xFpVGJLUjfGwWMh+IqOah
         pTcHUhfGO2TBP98BrW90ioaEqaErkkT/IWdsGt1CD4aSdtxMFHeNr5M2aydFBjAc4YTD
         kiojKsToN1dicWbZQUqkTf6aj/FptVA54LkBHfU7bX1+xG0QavHSbYqgM/lWiGVcjlRM
         u5Uc8vqTNWgttpJAMBYTo3hJnkbu4Fvb/iEvmG5sULnoTA165F0B6fPF8LevFp66LlxR
         CXAg==
X-Gm-Message-State: APzg51CqDOq0pSDHHZymFI9fc9Wf+t6O9sQZ6Gqji2WZP/Rg51B1ccW6
        IXbFekugkqn2HekdjQwmvc8NHw0Bq9GdjpI+mqZ3Ua6crX4=
X-Google-Smtp-Source: ANB0VdZp5ZdOSJ+VwIrSy5kXVxGbiUCKCvVTY+A9O+DPcJTbqo7bJDk7vFgMPovZEctpCoEBCdS5kLd/9ATTG/4yhyw=
X-Received: by 2002:a50:b0c1:: with SMTP id j59-v6mr4483551edd.267.1535492970682;
 Tue, 28 Aug 2018 14:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180827221257.149257-1-sbeller@google.com> <20180827221257.149257-2-sbeller@google.com>
 <xmqqtvnefhgx.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtvnefhgx.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 28 Aug 2018 14:49:19 -0700
Message-ID: <CAGZ79kYApAdFzC82LZNjYDzL5uWxtXHbvqUyjZ9OF+b=pGNbUA@mail.gmail.com>
Subject: Re: [PATCH 2/2] submodule.c: warn about missing submodule git directories
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 28, 2018 at 11:56 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > This is the continuation of f2d48994dc1 (submodule.c: submodule_move_head
> > works with broken submodules, 2017-04-18), which tones down the case of
> > "broken submodule" in case of a missing git directory of the submodule to
> > be only a warning.
>
> After seeing this warning, as we do not do any remedial action in
> this codepath, the user with a repository in this state will keep
> seeing the 'missing' message.  Wouldn't we want to give a hint in
> addition (e.g. 'you can run "git submodule update $name" to
> recover', or something like that)?

Not quite, as this is only triggered in the case of 'old_head = NULL', which
is when you have a superproject that is missing the submodule in the
working tree before and wants to have it afterwards.

Looking at the test in the previous patch, I would think a reasonable workflow
in the test is

    git clone --recurse-submodules super1 super1_clone && cd super1_clone
    git checkout --recurse-submodules historic_state
    # see warning, but checkout proceeds

    git fetch --recurse-submodules
    # clones the submodule as it was configured active via the clone

    git checkout --recurse-submodules historic_state
    # this checkout will put the submodule in place
    #  not sure if -f is needed here, though.


I am currently working on the cloning of submodules that are not currently
in the working tree while fetching in the superproject, which would address
the latter part.

> The MOVE_HEAD_FORCE codepath that follows this hunk is, eh, already
> forcing to correct the situation, so there is no need to touch that,
> which makes sense, if I understand correctly.

No, that is not executed for now as it depends on 'old_head'.

In case of FORCE we might want to die instead of just warn about that submodule.

Stefan
