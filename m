Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEA111F404
	for <e@80x24.org>; Fri,  9 Feb 2018 22:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753128AbeBIWpx (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 17:45:53 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40198 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753114AbeBIWpw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 17:45:52 -0500
Received: by mail-wm0-f67.google.com with SMTP id v123so146146wmd.5
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 14:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gPy2Jl6ciUeAsCRCFFhI4LyoOnFpfViMU+Dc03+H1ww=;
        b=vZdiUBWwJcCGc7O3G8HiFoIT5JVX/hC2AcXMkvP2REmSMcqRg18Kdz7r0+JQkG1fsd
         D8Y3LNj0Sx0RkqDVvoEdT2v9+pihUQyUPld19WmlHZhrAD10Z0Jq6ZZBOcKKyqQQQ5DF
         z1bWSdolsYNFvbjdmK8jmWQQ+qSMnbkezF6BZFVuol4C7WtuS8tGKO7qZVwd/UOKoYXc
         NhS74PJbsR1tjdTko40C5p3jpibPxz492dkYUeiqdjlqqP/srFd3UUA9GAzDjQGAqndo
         NqtatBjlxuOzj717YEg5L5ZFyoFby9sp2WbIvZwni5qMLe2Yb8w7U9Ok//fvr1caeRNO
         PU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gPy2Jl6ciUeAsCRCFFhI4LyoOnFpfViMU+Dc03+H1ww=;
        b=D8KDgkfwqARL30/jh7wWWONZiSZy2Ok2CHf3WmAuP7AlyjA//Q2ImTuqRAXtxP24Mm
         +aoA5FeFbrsjCPnfqeBwUArYGUO3FueTCfUMSps5NYXDSoDDDuYptVdXInT0oJEn5U+O
         PN69HM27Dp4Q8nYqYaDcqaANtCv9O6QJ0Hsl8nNHhVCREYx7oG+yOkAy4KP/2NXr0qXA
         YgIGHSxk1zFRjCE/JvyBtKCJXlu2WYCMNSAuxP7OObHNSgiJ1xOB/BvQUgorCjFHFQoQ
         0yvwqlzOhv/9WG3LE9DJtNLoYIVonXNfedEv+JABYMsY74f0RELY1YRY3/hz+nw+oBBH
         UGjQ==
X-Gm-Message-State: APf1xPDgwP/43BqTTKqRrQS6gXxIbiA3dIbk6IgVScZflHjPWybjEvaK
        z76t0w3qaRJ94xXTGwJGTPY=
X-Google-Smtp-Source: AH8x227ckozaz3d0vRo8iWXPT4L7pxXm/1nbCxKLPJHCp6LHCRcZOrr9au72HLyG6S/PZTTocd9WAQ==
X-Received: by 10.28.151.70 with SMTP id z67mr2979704wmd.13.1518216350813;
        Fri, 09 Feb 2018 14:45:50 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 188sm136940wmg.29.2018.02.09.14.45.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 14:45:50 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Leo Gaspard <leo@gaspard.io>, Joey Hess <id@joeyh.name>,
        git@vger.kernel.org, Brandon Williams <bmwill@google.com>
Subject: Re: Fetch-hooks
References: <5898be69-4211-d441-494d-93477179cf0e@gaspard.io>
        <87inb8mn0w.fsf@evledraar.gmail.com>
        <c8d1eb4d-c3d2-5834-a46b-931e825315aa@gaspard.io>
        <20180208153040.GA5180@kitenet.net>
        <871af155-a159-2a29-2e48-74e7a98b60d4@gaspard.io>
        <87bmgzmbsk.fsf@evledraar.gmail.com>
        <fa470be4-75fb-76ed-ed93-5c10fcfb8842@gaspard.io>
        <87po5dbz1a.fsf@evledraar.gmail.com>
        <20180209223011.GA24578@sigill.intra.peff.net>
Date:   Fri, 09 Feb 2018 14:45:49 -0800
In-Reply-To: <20180209223011.GA24578@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 9 Feb 2018 17:30:11 -0500")
Message-ID: <xmqqd11dvl2a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The negotiation for future fetches uses the existing refs as the
> starting point. And if we don't know that we have the objects because
> there are no refs pointing at them, they're going to get transferred
> again. That's extra load no the server, and extra time for the user
> waiting on the network.
>
> I tend to agree with the direction of thinking you outlined: you're
> generally better off completing the fetch to a local namespace that
> tracks the other side completely, and then manipulating the local refs
> as you see fit (e.g., fetching into refs/quarantine, and then migrating
> "good" refs over to refs/remotes/origin).

Thanks for a dose of sanity ;-)
