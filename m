Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC97F21847
	for <e@80x24.org>; Wed,  2 May 2018 03:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750962AbeEBD7Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 23:59:25 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36685 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbeEBD7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 23:59:24 -0400
Received: by mail-wm0-f44.google.com with SMTP id n10so21702486wmc.1
        for <git@vger.kernel.org>; Tue, 01 May 2018 20:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=w/TUJQyKx2NB1xX1ndHpy5BfsWO9Ofhu66PRvLfRZHw=;
        b=U64hWmq83eiBg7QXqp3W7cO7s0DWTvmEyZ1jKxCsaWzgY0rfp1nM1EjMhN9zDcGM4A
         RQtf1c8+i/EIvctec5zAYIcDTzi5l/vJUKCLghqFoqZ4Xx/uPxgL83h+FhWW3WNKtxbs
         FvmqLqm12dcT4yRyixK6rMSoYWCyyd7qQdLWaAAv2CN5ZzWORTAwPBM0oTrua7YhEH8c
         qTl+TgNEeiXwAw19pMNgdCkU3MNLa2pfpnNGQQuiS8UMe9DGpczESdQpULIA6kUi6qJQ
         f06DQV5KkQ0VEtaaj5cex8s2o+ZxGg4A3YKJT1UGmysyoZGIOUQA8X7bGpQu7agRx9pn
         WCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=w/TUJQyKx2NB1xX1ndHpy5BfsWO9Ofhu66PRvLfRZHw=;
        b=atPGPOmpmAvIbCGz5Pj40k0BPbw2Usc3JGhoD0tm6uQb2sm5USj5RJg/SuJs4hRW3Q
         /euQ9e6iI1W+Rv8t3bSXwrMSuUBu9zVrNmsSxqwE4kSQ7uHRRFhU1cNLtWyWexNIjo4M
         U6INzcWhKTXD3zKgOjIi1PXOuekX7rsXNkCKkwTSWnh7kjdO3NbgPaY3fh+S6KhCQ/qp
         UsEppwiIafAn+sbAven10s22zYiYSDaoB4QQ4E+AfQzVgncJ/j9531HZg26B3gFkQ1jk
         v/1/dEeA4nUIrtM1cvProoxDW8+nTV7EjIelu9HaDyZ3FUPdfQsTT+0iVJKgPWnrWiw1
         uMYg==
X-Gm-Message-State: ALQs6tD6n4CYzO2VVvFes/ijOBnJ7lbjWTz9l+SWZ1nyKJ1QdWRhcK8N
        EyuBMgUyS/5DqC0746bs6ww=
X-Google-Smtp-Source: AB8JxZoNcxY7M4oyBJvGSxbPzQaXAMLErsATMHdN60uMOpxtG17hEwhzS9dE3xzBbEyBp5WsLdwWmw==
X-Received: by 10.28.156.199 with SMTP id f190mr5827110wme.79.1525233563345;
        Tue, 01 May 2018 20:59:23 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b10-v6sm23574499wrn.42.2018.05.01.20.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 20:59:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2018, #04; Mon, 30)
References: <xmqq4ljtz87g.fsf@gitster-ct.c.googlers.com>
        <CAM0VKjmkn7eyooKheOEQnS=6HMZSTbhejoxQdKB7W+n=7D5KuQ@mail.gmail.com>
        <nycvar.QRO.7.76.6.1805011439580.79@tvgsbejvaqbjf.bet>
Date:   Wed, 02 May 2018 12:59:21 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1805011439580.79@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 1 May 2018 15:46:58 +0200 (DST)")
Message-ID: <xmqqr2muwvvq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So the problem you found is not a problem with *my* branch, of course, as
> I did not fork off of ...

Correct; there is no blame on you with the choice of the base.  It
was my mistake that I didn't check if the series could be queueable
on the maintenance track that is one release older than the current
'maint'.

As I wrote elsewhere, for a low-impact and ralatively old issue like
this, it is OK for a fix to use supporting code that only exists in
more recent codebase and become unmergeable to anything older than
the concurrent 'maint' track as of the time when the fix is written.
Even though it is sometimes nicer if the fix were written to be
mergeable to codebase near the point where the issue originates, it
is often not worth doing so if it requires bending backwards to
refrain from using a newer and more convenient facility.

