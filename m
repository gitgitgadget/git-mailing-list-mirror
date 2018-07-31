Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 690161F597
	for <e@80x24.org>; Tue, 31 Jul 2018 21:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbeGaWs1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 18:48:27 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52914 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732079AbeGaWs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 18:48:27 -0400
Received: by mail-wm0-f68.google.com with SMTP id o11-v6so4545617wmh.2
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 14:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rPbqfh1rvNMFPY1m71mcWnoeAV4UUna1mMvoEgNTtzo=;
        b=oDGk9ldRSXlu1MG3q9mdaLsiSwlhfEIPZZOzzqIzFA5kQQkw8a3lcXSyZj0bOuLq4V
         AOgofk+mvenCCRe7gXrp4IBKt2FmJ8S471Qzc5b0SBaY3ibfvwba6Pyy7WrijXrbfY2c
         JhSab8zxWt4FTT6EQ9sWdpES1ROSseQvk+aX5K614QeqzN9dtefLQfKQV/TKYVDnyr+B
         YqvmkbqY06KUdURMXe/SNe+2/l1w53uaThEOSUKKNXjSx17kyCr0OfOzP/B2vGLhd/Bg
         WN9kHpCCsmw15MyvG6TqbieTmtcrdSKc68z4LUqYum+LNAehGCa9vLlluAjMIKerOVa/
         SYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rPbqfh1rvNMFPY1m71mcWnoeAV4UUna1mMvoEgNTtzo=;
        b=Isbi67UrFFziTyfDDYFJ02tJU0t2Pb99Qdnmb7DlDF4QZAM9YmZ1cV575ugdbFZrq9
         eUlv0u7pigD3ByCyVfNzfphleAJSlXS0xUfS2EGYdr2eLnVRdT+2aEHrOeVd56Y0b3sv
         6C06NKhEOL/PxPYnhSDp0s4VQTOZQCDXe508IgDKiZ5b4Z83VBM2SE1NqAhtoQSFTJ6y
         1Tza4bYOmyWmSlKqHVWuE3PROL84gG0iyJHhyetcjcX0IRrX5aWRt3EiOK9E+1wFiudU
         ah6VcyTW6uaVqCiP3GfL/L0WOH8uATuC9zRKOxkaiu6YungetDwiqieQ+moi1ICUf0kE
         Xwbw==
X-Gm-Message-State: AOUpUlGqJK7DzgO743xn0LYdMchlDcfrYU/PgHn3sKG6ZwqyumIS0z9N
        K/WzcKfXcYVEoJ56pQokuNHjY4qX
X-Google-Smtp-Source: AAOMgpfA7gpmmkE7U5jAq2awkwuiGPa9FYsKuhBL9H8joFqD97lK4hsVvGxJoiqmib/4Osua0quoyw==
X-Received: by 2002:a1c:c64f:: with SMTP id w76-v6mr854882wmf.3.1533071173860;
        Tue, 31 Jul 2018 14:06:13 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q1-v6sm21741020wrw.42.2018.07.31.14.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 14:06:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        George Shammas <georgyo@gmail.com>, git@vger.kernel.org
Subject: Re: git merge -s subtree seems to be broken.
References: <CAF1Ko+FBP5UmETmh071dvn9iv8-N-3YgaP61q-4jQvxFdN0GTA@mail.gmail.com>
        <CAF1Ko+FNfjWMteccfKDBjPEW76rGBLQkGb1icUHmzEZ0fKQJBA@mail.gmail.com>
        <xmqqtvofcsgc.fsf@gitster-ct.c.googlers.com>
        <20180731161559.GB16910@sigill.intra.peff.net>
        <xmqqh8kfcokk.fsf@gitster-ct.c.googlers.com>
        <20180731172304.GA16977@sigill.intra.peff.net>
        <20180731190459.GA3372@sigill.intra.peff.net>
Date:   Tue, 31 Jul 2018 14:06:12 -0700
In-Reply-To: <20180731190459.GA3372@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 31 Jul 2018 15:04:59 -0400")
Message-ID: <xmqqeffj9ku3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Jul 31, 2018 at 01:23:04PM -0400, Jeff King wrote:
> ...
> So here it is fixed, and with a commit message. I'm not happy to omit a
> regression test, but I actually couldn't come up with a minimal one that
> tickled the problem, because we're playing around with heuristics. So I
> compensated by probably over-explaining in the commit message. But

Have you tried to apply the message yourself?  I'll fix it up but
the hint to answer that question is in two extra pair of scissors.

> clearly this is not a well-tested code path given the length of time
> between introducing and detecting the bug.

Thanks for writing it up.  The patch itself still looks correct, too.

