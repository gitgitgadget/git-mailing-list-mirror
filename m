Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42B2B207BD
	for <e@80x24.org>; Tue, 25 Apr 2017 06:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S980631AbdDYG3c (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 02:29:32 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33319 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S979600AbdDYG3a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 02:29:30 -0400
Received: by mail-pg0-f67.google.com with SMTP id 63so8807259pgh.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 23:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XnMD78BBy5WLTBqcMZfYK8kcXAzgr8XSBuD4GfWaCaE=;
        b=eQc9Gv4gbrwcL/UaZM+HNmeJUQwBLnp+FJc//cnP1of2FMehekFev2Li1I8jQVMsQ8
         1cBVkTZrCtQ9P04iId0QbKSInC+WAptw1HDpCn8gl+KT6ZvdaMlMVxYaCMzedqtQVpUT
         KTmJbVbUQvN6PpiQnunf5GhebNiCxJIwZH6Fs1FqZobOKavZo0Z8fGab58nYqx7eiUAu
         uXw624FI8QI629V3WsawwwccVJ2kb541ny0pJBeL/wr9s9CyQJRj8NmN0Bsoy4IDhbtS
         R93r8iB/bhyp69pOmBDsnbe/WEs38UyfhQMMthGbvHJW4x8MZqOKea4th3GOCMi5sDU5
         jgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XnMD78BBy5WLTBqcMZfYK8kcXAzgr8XSBuD4GfWaCaE=;
        b=O4uqX3vTGStK2iMzec8YfSiC4ktV5TAe77WK2meRJRwroStOSkwRQo48h5RVLgiIr1
         HG9uEeeapnPrtQNNHGbxtGaPaTOiG+gRjItitkl8+FC3a033jlh5DBqXABTwo4liUWoj
         SGfmueMbPQQqxMWkb12agSsLcD+ET6/cAI81hrygZAnyQpcWAyDZ6YjkDvwYyNX4VXkJ
         HeeO+oUTBiLdzauLgvxls5FAWJbm4cHNu2iwj324q35+KuzOUyJKSrvCfYiUyLggtDoA
         S5ja1dWFvvMQL+DEQ1FExzw3a7z+GeOX2yUouU8FcIL8jFtdpatviOXOW4k1CtwCE91z
         4zhw==
X-Gm-Message-State: AN3rC/5QiJfKjcMVNvOB0oZ8kBGFkVyA95j38RRC0LzfKtvlGKYcys6Z
        W32URWdgukm2pw==
X-Received: by 10.99.177.1 with SMTP id r1mr16047137pgf.4.1493101770020;
        Mon, 24 Apr 2017 23:29:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:894:a17f:b6e3:25e8])
        by smtp.gmail.com with ESMTPSA id p62sm34132747pfi.7.2017.04.24.23.29.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 23:29:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     git@vger.kernel.org, Jhannes.Schindelin@gmx.de, peff@peff.net
Subject: Re: [PATCH v2] rebase -i: add config to abbreviate command-names
References: <20170424032347.10878-1-liambeguin@gmail.com>
        <20170425043742.15529-1-liambeguin@gmail.com>
Date:   Mon, 24 Apr 2017 23:29:28 -0700
In-Reply-To: <20170425043742.15529-1-liambeguin@gmail.com> (Liam Beguin's
        message of "Tue, 25 Apr 2017 00:37:42 -0400")
Message-ID: <xmqqinltuhiv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Liam Beguin <liambeguin@gmail.com> writes:

> Add the 'rebase.abbrevCmd' boolean config option to allow `git rebase -i`
> to abbreviate the command-names in the instruction list.
>
> This means that `git rebase -i` would print:
>     p deadbee The oneline of this commit
>     ...
>
> instead of:
>     pick deadbee The oneline of this commit
>     ...

Whenever I see "This means that...", my automatic reaction is "The
author expects what s/he wrote previously is not understandable, and
is making another try to give something more readable.  As this is
not a real time communication, why not rewrite the incomprehensible
part before wasting the time of the readers by throwing at them what
is known to the author to be unreadble, only to clarify with 'This
means that...' later?"

But I think in this case, you do not even have to say "This means
that".  What you wrote, without "This means that", i.e.

    Add the 'rebase.abbrevCommand' configuration variable to tell
    `git rebase -i` to show commands abbreviated in the instruction
    list, i.e.

         p deadbee The oneline of this commit
         ...

    instead of:

         pick deadbee The oneline of this commit
         ...

is quite readable.

> Using a single character command-name allows the lines to remain
> aligned, making the whole set more readable.

Hmph.  I have trouble with "lines remain aligned".  Depending on the
object names of commits, don't you end up getting something like
this that is not aligned?

    p deadbee The oneline
    p e2cb6ab8 Another commit

Or are you happy with only the beginning of object names aligned,
without the actual titles aligned?

Personally I am happy with the beginning of each instruction line
aligned, so from that point of view, this patch is a mild Meh to me,
even though I do a fair amount of "rebase -i" myself.  But obviously
I am not the only user of Git you need to please, so...
