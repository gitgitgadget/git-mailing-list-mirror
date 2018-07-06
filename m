Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_BL_SPAMCOP_NET,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABAE81F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 19:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934727AbeGFTkl (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 15:40:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43085 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934714AbeGFTkk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 15:40:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id b15-v6so5171184wrv.10
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 12:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9/t7XbKhdEYLco6F7HNE7cZcW0YJ0Yhd9dwPYbHksRA=;
        b=TAog3SyqdZxbTVOl9V1cMFeNUTqJ4lS0bU6tsdsHVLFVzqtUyt8rBCljtejRwNvlev
         uyzVJWXyYolDvNKCdGP7YA9cHPHvu8Lb7i1MQeYyF8zLg9PdAsGv1W0NdyKoW4I26p/o
         fLAJoMjeC+cNG4KyJhaV1nrPCTSv8Gh8Co2MZcdRg1clcNsnkE2G0tQaKc8yUXfQOCuA
         ePj6nFgRcvXOqJQ6zxLip3MiSIr0u/SHeBu1S41TED2jGWOnRJY8mEt088J7T29OzLYy
         7XJ4CBwANiUp3Pt92rOuDbEAseBU4Bz2Jf5V7EevcutOuH0y0BD4RIAlMV0eiLSDyIsn
         Jdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9/t7XbKhdEYLco6F7HNE7cZcW0YJ0Yhd9dwPYbHksRA=;
        b=WV5TTC4WNWPCNNEflE7X/jzxn+31OKGPLldwK5OpB2KtbHWzY8vNsRofrlTftlgSCS
         Xw1k7Yh7texeAe3B+axu8r3VIh73h0U/jSnxApZcVu+TIE8A688qeK0XuzA7fxqZE84O
         eSi3YA5SXUBqB1FL/xKq4atEnaUEIxyJQWPhoJ5j5W2/ssxQMySUq+9+n7RC2ZXRuqFb
         Qm0CAwx7yIGZ4Gv3AkXS57qpPIBDc00JnkAjAdgYDvHbJLmJXrbSicEae9q+ExZxhEqU
         HehXU8IePMa08DrMu1/kbttVOEjaruOF5OV9ayEQNLYLacSFDycqVNMA3YCP6L8UrYLR
         FNSQ==
X-Gm-Message-State: APt69E1LmcWG1xz3hzH0ZP8+nQFqYm5MCS7Hssm34QIm/TTg4/BwDU1r
        a9WYVcr6Q16s92ElD1PO1O8=
X-Google-Smtp-Source: AAOMgpeFwO8JgpuaEmdG0+Gfn3VoFJEvjAWYXz8nJqEQwhyiJaokLe3ua+miZ8rNCwKZlqKiOj5YHw==
X-Received: by 2002:adf:ce88:: with SMTP id r8-v6mr7954075wrn.112.1530906039301;
        Fri, 06 Jul 2018 12:40:39 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z7-v6sm7809422wrl.77.2018.07.06.12.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 12:40:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Subject: Re: ag/rebase-i-rewrite-todo, was Re: What's cooking in git.git (Jun 2018, #07; Thu, 28)
References: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807031438240.75@tvgsbejvaqbjf.bet>
        <xmqq601smexy.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807062117170.75@tvgsbejvaqbjf.bet>
Date:   Fri, 06 Jul 2018 12:40:38 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807062117170.75@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 6 Jul 2018 21:21:35 +0200 (DST)")
Message-ID: <xmqqwou8jgp5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Of course, at that point I will have to look through those 7 patches
> again, if only to verify that yes, they are still the same.

That is something the patch author must help the reviewer with, no?

Have uncontroversial stuff early in the series, concentrate on
stabilizing them before moving on to shiny new toys, then mark them
"unchanged since the last round" after three dashes when sending a
reroll to update later parts of the series that are in flux.  After
a few rounds, it may become apparent to reviewers that these early
parts can stand on their own merit as a separate series, on top of
which the remaining patches can build as a separate (sub)topic, at
which time we may have two or more topics, among which the early one
that has become stable may already be 'next'.

> And Alban is not sitting on his hands, either.

If you are saying that all of these 13 are constantly in flux,
whether these 13 patches are spread across 3 series or a single one
(assuming that all 13 are about the same topic that are
interdependant), the need to look at their updated incarnation does
not change, so I do not know what you are complaining about.

> So after reviewing those 13 patches, which undoubtedly will not be
> integrated into `next` under the premise that they are still in flux, they
> will most likely be joined by another dozen patches until the interactive
> rebase is rewritten completely in C. After which time, I will have
> reviewed the first 3 patches over 15 times.
>
> I wish there was a better way.

