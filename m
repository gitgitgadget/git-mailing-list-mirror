Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D87821F462
	for <e@80x24.org>; Mon, 29 Jul 2019 23:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfG2XjS (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 19:39:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45568 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfG2XjR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 19:39:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id o13so29011714pgp.12
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 16:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1gaJYNaqRHZOT1ym2YJzdcU9ynG7v984P2xAlTxH2NI=;
        b=La9J2MI9f+htvg3nlA33xpaQoCNziFxWllQWqBxhPNO7I6xFiFFjH9oxxViZps6KfK
         04zBu0Pdl8kAJnMGgzsuNFgPi0eTepmoiKV6eAGrDDmqoHHxyzR9K7aNaJMIxreud5uZ
         IRFbopqdVpNYYvDeITIMu0JyJGxIobfdZZZpZ2gIivRK1aoEzcCTxsaSR9IfJ2jF/gZy
         Tg34EA6BUn1p50MTxW57P3Ane0Ro24LvrOb9FhhiMEGEjXKSH9gRAyMOCzy/Nea3ISwO
         /o7hx7IDzKjM+K1CeqMG4bfcqnQVMtemB32pxDpQL90go+EPNJtu/6pmG+m8lLVyN5oP
         shMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1gaJYNaqRHZOT1ym2YJzdcU9ynG7v984P2xAlTxH2NI=;
        b=QUVFJqB31fTz9gWV2jylWn5ywrKZajY6oRXKfj3MiYiNPS4KOyu6N3QKCedzI8w24w
         h7TWhkF3HcvHXpeWwC+tWVrAPTxIJ7X+BzfHgQgBeYi+jFE/brVu9IPOj1NqIl/nH74O
         fgQWP3DwukZppEx08jda3nIoBzMT0UvWV36sBILbCcCerhGouwyQGSGVjmomSxSC73sr
         /LttcvC2CsLmKyrZT2Wy4illKDpdIpqhk9d1Dbx3x+tsOidPQeIp2QSrxU43U3w38pGw
         plhCd9IlgUQwqz6S2AS4OjLC4dYnuaqqwtKOkgId1GSgp4SU3SliicnbVVNlOB7j62Sj
         1Cpg==
X-Gm-Message-State: APjAAAULULo32fHKEpGQCjpW4qzsdmBjG3A1SElScSyJ08e/7DLnYCTX
        HvUWwp9G0xP0LFdF9FGhlSj0Xw==
X-Google-Smtp-Source: APXvYqwCO/11ffD+WJaT59lWixGWIYlOlxTuuDH9YI7X9vRDOxazwS28gELFcJswhgHOTyr9Joueug==
X-Received: by 2002:a17:90a:3544:: with SMTP id q62mr115436422pjb.53.1564443556625;
        Mon, 29 Jul 2019 16:39:16 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4264:e2f7:27a:8bb2])
        by smtp.gmail.com with ESMTPSA id q69sm82542522pjb.0.2019.07.29.16.39.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 16:39:15 -0700 (PDT)
Date:   Mon, 29 Jul 2019 16:39:11 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, stefanbeller@gmail.com
Subject: Re: [PATCH v2 0/4] pre-merge hook
Message-ID: <20190729233911.GI43313@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, stefanbeller@gmail.com
References: <xmqqbml6pgfm.fsf@gitster.mtv.corp.google.com>
 <cover.1563490164.git.steadmon@google.com>
 <CAN0heSr4N-+fjn3+58oUvvv57vDXtA2tR-NEEyoS4toj36V2-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSr4N-+fjn3+58oUvvv57vDXtA2tR-NEEyoS4toj36V2-Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.07.29 22:29, Martin Ågren wrote:
> On Fri, 19 Jul 2019 at 01:56, Josh Steadmon <steadmon@google.com> wrote:
> > This series revives an old suggestion [...] to make merge honor
> > pre-commit hook or a separate pre-merge hook. Since pre-commit does not
> > receive any arguments (which the hook could use tell between commit and
> > merge) and in order to keep existing behaviour (as opposed to the other
> > patch) this series introduces a pre-merge hook, with a sample hook that
> > simply calls the pre-commit hook.
> 
> Argh, I wanted to comment on this in the cover letter, but forgot and
> just left a bunch of nits.
> 
> I wonder if we might ever regret naming this "pre-merge" and not, e.g.,
> "pre-merge-commit". There's the pre-rebase hook which runs before
> git-rebase even starts actually rebasing, so I could well imagine a
> "pre-merge" hook which would get called before merging starts.

"pre-merge-commit" sounds reasonable to me. I'll wait for a bit before
sending out V3 in case anyone else wants to chime in here though.

> I'm also pondering whether there should be an "automatic" in there, but
> "pre-automatic-merge-commit" looks a bit awkward. Anyway, I'm not even
> sure an "automatic merge commit" is a well-defined thing. I can figure
> out what it pretty certainly means, but it's not crystal clear. There
> might be a need for some more discussion in the added docs for what this
> new hook is for and how it compares to pre-commit. Right now, the
> proposed docs suggests they're equivalent in a way, but I think that's a
> bit confusing -- they are certainly not synonyms, and they'd never both
> be called, for example. They can be used for the same purpose in
> different scenarios, sure.
> 
> I tried coming up with some proposed docs for githooks.txt, but didn't
> feel I achieved much of value. :-/
> 
> Martin
