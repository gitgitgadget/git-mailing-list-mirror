Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43F0E1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 21:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933324AbeGIVFV (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 17:05:21 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35095 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933315AbeGIVFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 17:05:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id v3-v6so18531409wmh.0
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 14:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6lvvxpa5UEEm7tCBCC5hVeM1w1fG3HJOXh8w3uILdLs=;
        b=q7A335vpJJnQlqQm3u6klSNQZLiEe7mZqwK59Tzy+uQZ01ITcpSUNfxZrHmGof5jRe
         wSICW70UJUB1nms8EKXwZbnBFZ5NzC6jZihLmGAPooxbeKChFMq/KcTwcXuLX2jAGNrA
         kO5XW1u3cC68kLoU/rHGlScqu5L/sIPrODs8sauSjHMIVlr1SWO++El5QzPYMoM4FVxH
         kriVBlAoKvjnwpN5i/J2pEKNHuuQZS/QTUmiX9S9ztHw2savRNGwxL9djriF8kdRt5sZ
         Yf3JIvUkGlxlu2VcgObBmq4KhB5L2GTA6X3LK1AXou3kLgGBiU1mHB9IXstS9xLXWvVd
         55EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6lvvxpa5UEEm7tCBCC5hVeM1w1fG3HJOXh8w3uILdLs=;
        b=h5OskbZSDjhTsrsivwaUT+CSWlArPDxGglavqfBSBfdEa8n9JWuRP9yWJqNZatRAwy
         Jcf/nDnW23drx1zrkQB7+7Sf6WqJNb+2Kob0zCURdgKEN1Wx1hhWX6UZR2DSEZMbNzzx
         TDf5AohkQXhQpxr5c3YwrqOvHXc4l3mIzY0KYCMWnMbmnTc6CxtCNnKJCw5m1lH4gNeI
         RTkmtbrd+3VsMJ832dlZkGsisN/v1ZWJf3UvnrcQXEjbhRJYuDZDkUmRhszmSA5Mqa0L
         U1nnq7k+aSa3NjtCHd4JYdBdAZlqo8z+0t1MjJBJxJpB+yqcwz7KGp5f3OcODTDR9bGe
         4upA==
X-Gm-Message-State: APt69E0T253R1p6Z7SNM8OWGpyjjrNkzUHQGDoRiCk4Zd/gQ6kZ0v2cV
        yan2DiXPv9f/ZY/J9EbLu8M=
X-Google-Smtp-Source: AAOMgpeVkvvodWacu22cGzBu/xr7NfKdPGPGZ4pE5SxwdM8iHbV9OThHsvfg6wgATRikV8E38IIVIw==
X-Received: by 2002:a1c:6c14:: with SMTP id h20-v6mr9323223wmc.138.1531170314537;
        Mon, 09 Jul 2018 14:05:14 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g17-v6sm1326887wmd.25.2018.07.09.14.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 14:05:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul Smith <paul@mad-scientist.net>,
        Daniel Jacques <dnj@google.com>, git@vger.kernel.org
Subject: Re: Git 2.18: RUNTIME_PREFIX... is it working?
References: <97803ec8dae0a73bae301a37377b7b4a78f77e99.camel@mad-scientist.net>
        <nycvar.QRO.7.76.6.1807041312150.75@tvgsbejvaqbjf.bet>
        <986185d30a0f09b4e2a9832d324a265cd3da7354.camel@mad-scientist.net>
        <nycvar.QRO.7.76.6.1807061059260.75@tvgsbejvaqbjf.bet>
        <CAD1RUU-4a_jV_JjozjXOR4bi+_7rFW_AjmHbbrw6NHJ77=oGkw@mail.gmail.com>
        <bf0d4f33701ec694917f2e710c3fb097085c8d69.camel@mad-scientist.net>
        <nycvar.QRO.7.76.6.1807082346140.75@tvgsbejvaqbjf.bet>
        <20180709195822.GA9000@sigill.intra.peff.net>
Date:   Mon, 09 Jul 2018 14:05:13 -0700
In-Reply-To: <20180709195822.GA9000@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 9 Jul 2018 15:58:22 -0400")
Message-ID: <xmqq1sccce7q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Jul 08, 2018 at 11:52:22PM +0200, Johannes Schindelin wrote:
>
>> Now, if you care to have a look at Dan's (and my) patches to implement
>> RUNTIME_PREFIX so that it looks for a directory *relative to the Git
>> binary*, you will see that it is far from portable. In fact, it is very
>> definitely not portable, and needs specific support for *every single
>> supported Operating System*. And while we covered a lot, we did not cover
>> all of them.
>> 
>> So unfortunately, it is impossible to make it the default, I am afraid.
>
> Would it be reasonable to make RUNTIME_PREFIX the default on systems
> where we _do_ have that support? AFAIK there is no downside to having it
> enabled (minus a few syscalls to find the prefix, I suppose, but I
> assume that's negligible).
>
> I.e., a patch to config.mak.uname (and possibly better support for
> _disabling_ it, though I think "make RUNTIME_PREFIX=" would probably
> work).

I think that is a sensible approach.



