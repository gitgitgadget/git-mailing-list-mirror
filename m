Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BEA41F428
	for <e@80x24.org>; Fri,  5 Jan 2018 21:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753155AbeAEVoW (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 16:44:22 -0500
Received: from mail-yb0-f176.google.com ([209.85.213.176]:37462 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753074AbeAEVoV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 16:44:21 -0500
Received: by mail-yb0-f176.google.com with SMTP id 5so2385044ybp.4
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 13:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Ly8BUOBN69C7od7IoWUNyGR5/4PHVfLV8a+MWMw2KFI=;
        b=mkGaTc0MDG7eOvxKfpGpNHTqcwyq4W8eu+KUrXT9bJVsGyWvRm7RUz0E5PzHi5+b65
         sumPRu2euUI2sZZeqpgta+WEIcTB7HIve9PqN9WyDx299sYvREvxFW8nHK5KpQw54Tqz
         FSYrR6hD5JIvsOExrRK4tx23jL8kectcwHGxpB4gG19lneFDC5/WL+ntwkrqgytOfcGc
         iP4yKPUASpRQ022+NZTP0sLOB/5yaoXeptHakFgH8dvXCa2+jRC9VQ02HkSF/u+1j6lE
         rbKJiVaiyywQaDwisEj6jF2nhyBA2olU27TtEm+kHGIMabH6ZdPovbZ6ogtrbfnX+zV7
         73xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Ly8BUOBN69C7od7IoWUNyGR5/4PHVfLV8a+MWMw2KFI=;
        b=sdCWTm+tKlBCqon9TqmgA4kwtwfdM3VTy11qTjFqFS54lo4rj9whQgQyP7nHucU11F
         d4pTYzBPM+Um0QgYHR5MTW2u7cOnUDorO7QYhwTOD3cAYe1kzxhamev5tEg5etX2Wx4h
         jyHlo6Ozo7Kv3o0Q0MyejaCYMS5mq5bzTmKqY0pmon+n61H6rVZrJjDwJS3+XGGyugr9
         de1xW7XgV1TNKunDNBrZyNit++nEDKWrBthnxoBocdWOw68Tr+KpJRqRCYAD+MThuqea
         WkkfFo4O3Qje4To8QEF00f2tnPTUYAy1HP2BhteuQw9rRYLsTFhMhD/a4iEKni/voKW4
         D/7g==
X-Gm-Message-State: AKGB3mLlSIl60PnGc4I54qZkW9vtlRxlj8sOVPG4ZoPCH/JNEY20pnxT
        mXr0RCbhkVCfJtJ4Zl9PbDxJzB7ND/tfeqSKInUAOw==
X-Google-Smtp-Source: ACJfBov1tTmAFJcbX2uogD2mfalHupFO6vbxTiaVOZJ62w+rJDGYmet/fIt52sV4F59lzoTAk/SJfTkVcPH4GcBFtP8=
X-Received: by 10.37.183.132 with SMTP id n4mr4299150ybh.220.1515188660498;
 Fri, 05 Jan 2018 13:44:20 -0800 (PST)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.129.103.65 with HTTP; Fri, 5 Jan 2018 13:44:19 -0800 (PST)
In-Reply-To: <CAGyf7-E-7KUCAM8SeG-2powp2XN+H=16VG-6XBmj1wUT9tjVcw@mail.gmail.com>
References: <CAHd499C=3Y-ykgYZhSJzk=e-Pi6BUFeN8C89krd5T7T5fRB91g@mail.gmail.com>
 <CAGyf7-FHyO9pkEFFguea+B+VMTodF=mg8wJNedvjYdL7e7ORqQ@mail.gmail.com>
 <1515183976.21764.114.camel@mad-scientist.net> <CAHd499A_ANzFA8HSQLJWakzzWanbmVGnur=um=kquYHu0aCBcQ@mail.gmail.com>
 <CAGyf7-E-7KUCAM8SeG-2powp2XN+H=16VG-6XBmj1wUT9tjVcw@mail.gmail.com>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Fri, 5 Jan 2018 15:44:19 -0600
X-Google-Sender-Auth: BD_gMTUDeFAtbYGPtYSKAgaqGXU
Message-ID: <CAHd499BfQiDen6PZFhEeB7-B64PeeQcCWNVze6fONsDGO=YHog@mail.gmail.com>
Subject: Re: Can't squash merge with merge.ff set to false
To:     Bryan Turner <bturner@atlassian.com>
Cc:     paul@mad-scientist.net, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 5, 2018 at 2:54 PM, Bryan Turner <bturner@atlassian.com> wrote:
> The two _aren't_ distinctly separate, though. "git merge --squash
> --ff-only" has very different semantics to "git merge --squash --ff",
> in that it will only create a new squashed commit (or fast-forward a
> single commit) if the incoming commit(s) are fast-forward from the
> target. So there _is_ a setting for the fast-forward mode (given
> "--ff", "--ff-only", and "--no-ff" are a tri-state switch, and
> therefore comprise a single setting) that does impact squashing.

That feels really contrived to me though. For example, when I'm asking
to squash I don't really care about fast forward in that case.
Squashing means I'm expecting a possibly completely new commit with my
collective changes. If I only had one commit on my branch, likely I'd
be aware of that, and would do a fast forward merge or something. I
think the difference here is mind set. And maybe this is just me, but
the mentality when I choose --squash means I want nothing to do with
fast-foward. I don't care about it affecting the operation. If a
fast-foward happens to be the end result, I still don't care. Git made
that decision for me. And all I want is the end result: A single
commit.
