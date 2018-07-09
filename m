Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E2251F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 14:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932742AbeGIOfp (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 10:35:45 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39098 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932633AbeGIOfo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 10:35:44 -0400
Received: by mail-oi0-f65.google.com with SMTP id d189-v6so36266138oib.6
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 07:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jQN2TkEHndEgJbsANbdFl2KQPxMGv3Yhvb+PzSUd3wo=;
        b=Hr196SFmMhzKlGDgtwRDO4o3ZLORDUxhZMR2LHepq66wa/b/ror5demGY5Yj8+35EW
         n088GeRn3DYjsjAM2YMDpJ22ollbWH5BBjZxwjDeT4IcdgZJhA0ZgRQcOZMTfwi2LVWC
         yjRW48lkovJ0U2q9anHMTjXLivM+rWCe+ZnL4sCExqRvpeFHdwW/tt8fF4mgHBzrDHNI
         y+Lipj1TqXynVp1T/tHTZL7eJKT6cThIn3061UX51hau2+3PCjeRknmbszarc9jlA8zQ
         HO0kWf7jnEVGYxfz1TbFBXKANHqE8w7xtUCDQ2/h6YEILffCWaTDpfN66gVDYeJrnZSg
         MTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jQN2TkEHndEgJbsANbdFl2KQPxMGv3Yhvb+PzSUd3wo=;
        b=dARRW2kl3Oz8f32p9KTX38YVEx3EsL6Bk3Zsy9UjyHD3wrwt7yI/c1CH0SQ6BKu1Z+
         4laKOpZrDAYXVSA4Q87IAuMTvRl96gU2pCRUZRV7jjBx//qL/4Uw0ZtS27sh4Wx3Mz51
         16l3NXhurCmwRh8D6UNVkBLHewezGgGql1N7oWKn2sllXpW5EH/oLvHFQIX3cwfkfHyx
         rxrPRK/UnXHlRZa84ZJx/wHEYJ5mEyuOfQbCSD3zHG+/eIpyCX/em0V8vJQy56IHryd2
         K0mNyCKdrjmackR+pFvDHV7OL3r3PIsxr6msE2LATwDlSlXYsDzVTsaxBVWG1jSBxRWt
         I13A==
X-Gm-Message-State: APt69E3oXiNCk1sEOi3z41mKtb4TsxNqBaaUNBnMnTncKi81HCcrmSwv
        DnGBes3mhoUxnAQZV91K7Dg1N/zz63bzUeJjeoo=
X-Google-Smtp-Source: AAOMgpcYnYm0weu+nuwZP4til+EUlU3KZ7EN/oouS5/OUi8TvpRXURVG1uQw9tMxGbQCjgSsnt98L2ta7oM9FK6G8k0=
X-Received: by 2002:aca:d452:: with SMTP id l79-v6mr22085507oig.222.1531146944279;
 Mon, 09 Jul 2018 07:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180616054157.32433-1-pclouds@gmail.com> <20180616054157.32433-3-pclouds@gmail.com>
 <xmqqbmbypyis.fsf@gitster-ct.c.googlers.com> <20180630083825.GA2436@duynguyen.home>
 <xmqqsh50qiiw.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsh50qiiw.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 9 Jul 2018 16:35:17 +0200
Message-ID: <CACsJy8DrGnK3eM1mL7eLUL1hBNct=8qNC2f=PmO+g+7rjV8idg@mail.gmail.com>
Subject: Re: [PATCH 02/15] apply.c: stop using index compat macros
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 3, 2018 at 8:30 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> > A singe patch conversion would look like below. But for that to
> > happen, convert.c, rerere, ws.c and read-cache.c have to be converted
> > first to not use the_index.
>
> Yes, that was pretty much what I was driving at.  I do not have any
> trouble seeing a patch that converts callees that are deep in the
> callchain and are meant to serve helpers to make them capable of
> working on arbitrary in-core index instance.  That's a welcome
> change that allows us to reuse them in more context (namely, by
> callers that want to work on istate that is not the_index
> themselves).  Skipping the "intermediate" step like this patch would
> force us to focus on converting these lower-layer dependencies.

OK I'll drop part one and incorporate the changes in later patches.
-- 
Duy
