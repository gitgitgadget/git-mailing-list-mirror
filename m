Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D128DC433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 04:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A57EC64FCD
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 04:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhCKECy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 23:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhCKECZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 23:02:25 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BE8C061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 20:02:25 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id o22so11986456oic.3
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 20:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hPBtgHW7cClG62lIvcyoJwN4PWf9paDi7+qNg4Xhrdk=;
        b=ecZ0fEUlWteLUIU3rFjq88b3zjPXkAPsqu9gZvrqFcuM784jEmRjm3l+IRNEqxtFnL
         YH5xfQVU4baNQY2GIkzbYmrMNflEVtDrRnq2CQMq2BpveK9/ws08XV1MQ8UHOjmH0eaF
         mnRpTniOf53PLJCRi2zmhj/GBrnLrIkwJoWYrKi5lQHvfPHrLyB5NNpaog11dbo5Azlw
         u042I8y4ih/kdF9imNmZOdzxqGd19gUhQ4RRicJGolqT9PhOAkzTx8CaRqfXNRE9DuQc
         oR5JnTMXJPa//wYRwOmaMe4fTIiWSlvcealMa2rcjSQ71RtNT/TtqkfekeqbvqZW4hX8
         1aCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hPBtgHW7cClG62lIvcyoJwN4PWf9paDi7+qNg4Xhrdk=;
        b=OfM+e9xMogChG6ipALWQ6uRUDE0pTXlAcKNAI280FQr4Yov206fs6r8bEENch0XzzA
         bZItV2qlAH1T/9dOd6oxvooah4EeUZ0h3VJ9SWWYTXYjbkTAH1828RDC80YD66LRo3au
         jmQosczvwKuc4vP7meo1aKF6Oq7yojQZO3i7CUCMghc4EDtc1zTq6/Wl170uEDT8tjnj
         QfTP4COjlj15ThSI39pzr9cJXoxQ9989kFTo8WQQz3CPJAZOAXS5ZpDnQD6oo5ivLSws
         UlRV8gRB1+qbAadFGmL9A5kye+rqAESKIRIRC27q2LIvC4qvSmGqVCOtVgs9RenBASrQ
         X3Ow==
X-Gm-Message-State: AOAM533cbfDyAIsWHbhtkwGaDTndwCHpW/1Qrd4KHAc49LHnpmEAXTc8
        IM7RaPZM6V0nFu8Xely7RHghQJGF834lSQFtxSbJCtEb5/w=
X-Google-Smtp-Source: ABdhPJx+XegCJPaR7i6XnyzklIOco8AfijLtDKNdzECspW3vt9B0Z2qRp4Xx6zpcP07qcHV8tHiYjZsUOGXLuK4V1AU=
X-Received: by 2002:a05:6808:1a:: with SMTP id u26mr4720164oic.163.1615435344889;
 Wed, 10 Mar 2021 20:02:24 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210310194306.32565-7-charvi077@gmail.com>
 <xmqqwnueh6ps.fsf@gitster.g>
In-Reply-To: <xmqqwnueh6ps.fsf@gitster.g>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Thu, 11 Mar 2021 09:32:13 +0530
Message-ID: <CAPSFM5c7ULGxThtFjPam33wMzK3kprds97zwJ63stc_Ct24nmQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] doc/git-commit: add documentation for
 fixup=[amend|reword] options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 11 Mar 2021 at 06:01, Junio C Hamano <gitster@pobox.com> wrote:

> > +--fixup=[(amend|reword):]<commit>::
> > +     Construct a new commit for use with `rebase --autosquash`,
> > +     which fixes the specified commit. The plain form
> > +     `--fixup=<commit>` creates a "fixup!" commit, that allows
> > +     to fixup only the content of the specified commit and leave
> > +     it's commit log message untouched. When used with `amend:`
> > +     or `reword:`, it creates "amend!" commit that is like "fixup!"
> > +     commit but it allows to fixup both the content and the commit
> > +     log message of the specified commit. The commit log message of
> > +     the specified commit is fixed implicitly by replacing it with
> > +     the "amend!" commit's message body upon `rebase --autosquash`.
>
> Rewriting
>
>     "is fixed implicitly by replacing it with" -> "is replaced by"
>
> may make it easier to follow.
>

Okay I will replace it.

Thanks and Regards,
Charvi
