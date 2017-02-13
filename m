Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F8271FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 21:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753450AbdBMVB6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 16:01:58 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36093 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753164AbdBMVB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 16:01:56 -0500
Received: by mail-oi0-f66.google.com with SMTP id u143so743936oif.3
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 13:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pe3FdRO/xNJLtnO00LxhNZeGRP1rkt0Ah+rU7uZWJAc=;
        b=f0v+NR6o1SyG24gTIDMet6SP8HLIMSFrg4cclpl88zpg52r/u0jmnioF5uFqxoUF5B
         WFMlMDvTq0Bvr/hN6Am/Av2EE2YGxQZKLXjG3BSe+RCqkMQs7/v5ogQehVPbTm5oCxQm
         4yW3KKJdIF8FcWmV0D/ac+VKhrPpDrnqLwGdbPX65h0+E+GNGFDyWRWzjGJDF7YPOJCV
         saZv1ICYH+LSwB5JTdcKNP3kHOgL04eETIta25/Pti2YhHFXWCQGJbXIjMowDSW1oa9i
         sf894Wu9O8rcQtWhM/Ml18lYlyHpwyBH2DfKPfjDNb3U4OBK6+BWMRA/oi0uaWmxZTU7
         KpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pe3FdRO/xNJLtnO00LxhNZeGRP1rkt0Ah+rU7uZWJAc=;
        b=ITLFicceK2C6zyELm25ihocapXdAn6bWoyfvoqRwu+c/Mj/bqkme4hMFStwNs5sgWe
         OkqIcngcFzSNYUBTkQJigkR6rhk+KQlF0tT2xOFJFzb/pffYrLjuJRYWSeFi76HVBN5I
         0yqkokhzAiF0FIWxBCcX2XhxBpAF7c7ZiDbGH7mYlcw+LxBPAYNLgVRaJG5m8Y+6uRuA
         O1Yo67hO6JTNlvi090BegHTCqlRhur5sO7vGPRBphNCBbsiHBYthWrl71GnOxd6+c4HU
         730Vp/uiW8iqARbJjEbEltrQjnE3rm0Vap+ifY3OLgCGbA6fR6AktVguZTWsL5k6FfgM
         boKA==
X-Gm-Message-State: AMke39m6wotJa9Uvjbz/gwC949WbZFd0w6ggRCvJtG2WHOP1U/sy9Y7yKMhmRfaGB22fEQ==
X-Received: by 10.84.232.10 with SMTP id h10mr32201981plk.121.1487019711005;
        Mon, 13 Feb 2017 13:01:51 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d0e0:42a7:601f:5154])
        by smtp.gmail.com with ESMTPSA id s65sm16379279pgb.64.2017.02.13.13.01.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Feb 2017 13:01:50 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] show decorations at the end of the line
References: <alpine.LFD.2.20.1702110943460.31350@i7.lan>
        <CA+55aFw2S14a4_4YK0b6PNK4TH_AUo_+2JN+PTyBTufNeB5t6A@mail.gmail.com>
        <xmqq1sv2fq6m.fsf@gitster.mtv.corp.google.com>
        <CA+55aFy-vvOBu5Y4KDeteUyK-7U7yTa1HoqHo+hME1=8bq7Xhw@mail.gmail.com>
Date:   Mon, 13 Feb 2017 13:01:49 -0800
In-Reply-To: <CA+55aFy-vvOBu5Y4KDeteUyK-7U7yTa1HoqHo+hME1=8bq7Xhw@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 13 Feb 2017 11:33:18 -0800")
Message-ID: <xmqq7f4tdcua.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> And if you actually want decorations, and you're parsing them, you are
> *not* going to script it with "--oneline --decorations", because the
> end result is basically impossible to parse already (because it's
> ambiguous - think about parentheses in the commit message).

OK.  So let's wait to hear from others if they like the "obviously"
improved output.  Even though I find the decorations indispensable
in my "git log" output, I personally do not have much preference
either way, as my screen is often wide enough ;-)

Thanks.  We'd need to update the tests that expects the old style
output, though.
