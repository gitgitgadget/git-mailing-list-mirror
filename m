Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C815B1F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 21:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756748AbdKNVRf (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 16:17:35 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:55238 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756719AbdKNVRd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 16:17:33 -0500
Received: by mail-io0-f176.google.com with SMTP id w127so8519833iow.11
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 13:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vdv6s/5BVTIy90gYYLbKDncIQr25iY3kournBx/CIsw=;
        b=Mj9peKORr0Jg5IG5i8sAwag1lePVOZIacf1e3ll+z9/4p99SyOjgwzjwxItjsvUtO2
         GoTlptTqAx7YkZQcR4A+QaPKYl9vMISNRRsLzQZLGxFZZbI2kro9EzOAT4XTrjLKDN9/
         sQ+pkByORVw8yeLvOCc8fF2RwsyDuFhveXFJfG/pY0L3dwhi/pBs4qM25lDr1z3eqPC7
         DS1NH7vRBC8TjTZYlMnwL28iIf20K0Hl2t+Nq2pNL5/YHTNgmW4Wew19aBEphusmw7F6
         GcEi8/X908EuSvbw/Cjn151hF0voRcJ5EhBLdKIUDimWPTG+q0JLH5bTM66x+JMNgs0+
         HWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vdv6s/5BVTIy90gYYLbKDncIQr25iY3kournBx/CIsw=;
        b=Qi9WMHkEWCwX76uC8V3wR6AuK5uKIaDuGEWzTzPOc8xjziCtj0UW8T1UE7A9KpvbeR
         LCWSGZjRjFGpKloz0z0XvZS655nRGs9Cew5R8KMzigJClTCxVrHB3WSMb4+S0HVxyGkw
         v1y3oYs5VK22xyXyw2CG1XNlDNoKYhlTDK0zpbNz8faXtjYToU38Eq8jMkuFKGsESeKy
         M1r/FMSRHlKETxxelWYgTZSgRTD8Slh5HI1tSbERp7Y4T7b2sTzTbYqsqTjq/wEpKdAw
         7qYdZ4P9yiBK9JVHvhHZH9zMvZw+3NrLBcPgZ9pxUd+gPCW56qEE35WZUDL8q6Ido0Z7
         YL9g==
X-Gm-Message-State: AJaThX4kZCe+ccR3nqsJUPXOqZepK1Ijy/yeBy3aVuo3GVQr8ZaDSnLo
        Hs/ayJRSzLmH+/nu05k9kcO5TQ==
X-Google-Smtp-Source: AGs4zMb8+SjtlgOyN1/HoQg/HkvvoEjgB99K5/CqTWOpeEcA63iFh3NE5RIu4x6/jQPOFATuXivjkA==
X-Received: by 10.107.63.8 with SMTP id m8mr3744457ioa.137.1510694251422;
        Tue, 14 Nov 2017 13:17:31 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:9ca7:c33c:854a:a353])
        by smtp.gmail.com with ESMTPSA id i76sm2209247itf.3.2017.11.14.13.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Nov 2017 13:17:30 -0800 (PST)
Date:   Tue, 14 Nov 2017 13:17:29 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>,
        Kevin Daudt <me@ikke.info>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCHv3 7/7] builtin/describe.c: describe a blob
Message-Id: <20171114131729.4f0084a249fb8277e1c4cdd3@google.com>
In-Reply-To: <CAGZ79kZXxrDKr5PfJ2xx_3hhzscUiQvqOnCGURXCbJSL118trw@mail.gmail.com>
References: <20171031211852.13001-1-sbeller@google.com>
        <20171102194148.2124-1-sbeller@google.com>
        <20171102194148.2124-8-sbeller@google.com>
        <20171114120208.d0570f20672f117bcf8e5396@google.com>
        <CAGZ79kZXxrDKr5PfJ2xx_3hhzscUiQvqOnCGURXCbJSL118trw@mail.gmail.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 14 Nov 2017 12:40:03 -0800
Stefan Beller <sbeller@google.com> wrote:

> Thanks for the review!
> 
> This series was written with the mindset, that a user would only ever
> want to describe bad blobs. (bad in terms of file size, unwanted content, etc)
> 
> With the --reverse you only see the *first* introduction of said blob,
> so finding out if it was re-introduced is still not as easy, whereas "when
> was this blob last used" which is what the current algorithm does, covers
> that case better.

How does "when was this blob last used" cover reintroduction better? If
you want to check all introductions, then you'll need something like
what I describe (quoted below).

> > Alternatively, to me, it seems that listing commits that *introduces*
> > the blob (that is, where it references the blob, but none of its parents
> > do) would be the best way. That would then be independent of traversal
> > order (and we would no longer need to find a tag etc. to tie the blob
> > to).
> 
> What if it is introduced multiple times? (either in multiple competing
> side branches; or introduced, reverted and re-introduced?)

Then all of them should be listed.

> > If we do that, it seems to me that there is a future optimization that
> > could get the first commit to the user more quickly - once a commit
> > without the blob and a descendant commit with the blob is found, that
> > interval can be bisected, so that the first commit is found in O(log
> > number of commits) instead of O(commits). But this can be done later.
> 
> bisection assumes that we only have one "event" going from good to
> bad, which doesn't hold true here, as the blob can be there at different
> occasions of the history.

Yes, bisection would only be useful to output one commit more quickly.
We will still need to exhaustively search for all commits if the user
needs more than one.
