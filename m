Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89E8C20193
	for <e@80x24.org>; Fri, 28 Oct 2016 06:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755871AbcJ1GL7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 02:11:59 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:34069 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbcJ1GL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 02:11:58 -0400
Received: by mail-yw0-f180.google.com with SMTP id w3so69150466ywg.1
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 23:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZdAvSXQ2qKpXuXMVe5MgbYGp1R3pHZBOx2RKrHpB3J8=;
        b=kcJERSeuai/BT8BGsI9x9ut9AwKD6g+XLNVVNtiCfyGVhMUzj9ZXhLxtcZxNWdS0I2
         9ZZtO3GrwI4+L9RLtK8LgrNur8YJ+6Z7Uqy5z9RyLrnwJMt4QrvLC24APAdY1t9X1Dg5
         sU+qKo9i6ej/6FAbNFsfMUwrUi6lDUF4eanGxq5OB+Zq7+todG6O5HWNeYFkdXu0OB4z
         G78BCEUHqQm6G2Y0U2rLv3sxS1tR941MSgnEaybVcxYXAj5NBWpqYXu1iehA7kYJJHgD
         2GifZHLX5fJy7O6ILxgNDwP8XlxcJYvnR9djIqQ/vMtzfI0MI9bh4U6JLGs6SpQcpGPf
         2A4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZdAvSXQ2qKpXuXMVe5MgbYGp1R3pHZBOx2RKrHpB3J8=;
        b=CLYXyztHknS2raWdbT6n/tw2EjWo0iPZfn/krE6C1/cj+ThmDmnPun2sGF7YMNwqXZ
         kwndXSmIS4Nu/wfZbs191hV2yL8HTBgRcshv4WrJkHiXaQkE6PCmskbUyWnT829mq3o1
         65Wzkbjx7jS5NYb3JFCvI9pRl9kQVPMuj3aMDzlM0QTgfO9Re/6zq6UB0npWgfDNpXy2
         HCQfKAGrm9gd+sA6j1jO51Vv2ykYfhaAl4PsZ5KH7yJAifEqDDXaVzX1o/2BvtPP0+Cc
         Jkhg2KSI2vV6EkKsAubFI3+pLjeCIerwfHeyopmxo5QrSg906n68GPDYf2S2PYllU5Yy
         ecgQ==
X-Gm-Message-State: ABUngvctB9UD5vqV//MmipGBgnyKoln0f4K310pdx4i0qoX85l3gPxsDxdCGXTk58S6wVbojH6j1WbA/0G0ANQ==
X-Received: by 10.129.74.67 with SMTP id x64mr10889912ywa.59.1477635117447;
 Thu, 27 Oct 2016 23:11:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Thu, 27 Oct 2016 23:11:37 -0700 (PDT)
In-Reply-To: <2ddca5e3-3c4d-b555-4309-a180ceed581e@kdbg.org>
References: <20161026215732.16411-1-sbeller@google.com> <93be5d21-6cb6-ee2b-9f4f-c2fe7c690d6c@kdbg.org>
 <xmqqlgxa8h3a.fsf@gitster.mtv.corp.google.com> <67e38b43-0264-12f2-cca8-4b718ed7dc9d@kdbg.org>
 <xmqqh97y8g74.fsf@gitster.mtv.corp.google.com> <xmqqd1im8foi.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbP3pgPHgv-x1Q-Q1QwmXc=gOyxWhXh2SngO8WSZc3PFA@mail.gmail.com>
 <34c88c40-2088-fd74-5d26-56c0599b7eb9@kdbg.org> <xmqqr3716301.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kY_fZ_pDtVnwJoDkR6PjTNoqDMN5OC70Z8SH_J0Wvkq-w@mail.gmail.com>
 <a2e5acd6-485d-0387-7a85-6042dee702f7@kdbg.org> <CA+P7+xpckfaeHmoEGQBdLD-=Kf7gQ-jOxGFKrKmiFH1SBN7GjA@mail.gmail.com>
 <2ddca5e3-3c4d-b555-4309-a180ceed581e@kdbg.org>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 27 Oct 2016 23:11:37 -0700
Message-ID: <CA+P7+xrvHfTd77uTM+g1_QyWFvQuak2x-wdej7hD99v-37AOLg@mail.gmail.com>
Subject: Re: [PATCH] compat: Allow static initializer for pthreads on Windows
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Simon Ruderich <simon@ruderich.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2016 at 10:55 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> One point is that the DCLP idiom must be implemented correctly. There are
> solutions, of course, and when the initialization is over, we have a
> miniscule overhead at each pthread_mutex_lock call.
>

Right, this I understood, but appeared to be solved.

> The main point is that the initialization has to solve a chicken-and-egg
> problem: After we have found an uninitialized critical section, we have to
> have mutual exclusion for the initialization. We need another critical
> section for this, but we cannot have one that is initialized. For this
> reason, the solution uses a different kind of mutual exclusion primitive,
> which is more akin to POSIX semaphores and works across processes. In the
> patch proposed by Stefan, a *session-wide* mutex is used. That means that
> all concurrent git invocations in a user's session synchronize their
> initialization of critical section objects.
>

Thank you for explaining this. Now I understand why this would be
considered a big issue, and potentially worth considering the
alternatives like attr_start. This was missing since I don't think any
of the rest of us knew (correct me if I am wrong) that the
synchronization would be global. For many cases it's probably not that
bad, but we do have a suitable explanation, and I think living with
"attr_start()" in the win32 initialization path which is something
Stefan suggested in a previous email would make the most sense then.

> That's just ridiculous. It's like waiting for a ... no, *the* ... battle
> ship just to get our bouncers in their position. We are talking milliseconds
> here, not nanoseconds.
>

Right. Thanks for filling in the missing details.

Regards,
Jake

> -- Hannes
>
