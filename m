Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A08F1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 21:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732034AbeHCXmx (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 19:42:53 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36473 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731952AbeHCXmx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 19:42:53 -0400
Received: by mail-yb0-f196.google.com with SMTP id s1-v6so3201588ybk.3
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 14:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oiqbCT3s/pQfHve8P349s/1Kh3QG+HYKn0l6Em9eDQA=;
        b=Cvjf1XOP3KX4W3v5FLB4xCtntwpdrN767Ou21ZpDHa4spV+FyCMEalOEFxnpGLnjXo
         fZB/uA7SWF+rrZGe7lnmDdrad7DRXRGxeXEgqVfsWrkV5kIKufzhLuFgs5FVZoGApiqD
         YsNcECV0IYSe57a2H7TMOd7elqzGSyBqBtUaY65dYblgl9I0Suox+tPAikx58z4KVtvO
         Nee/9PVcy+6nAi7YtisJtWlBnMMGYYqYCnTJVO9y7iYEwkKgEf8E0CwZ3dCOFvEpEPfE
         9GA30utAOzlJsmnMJ3MDEEAceoTIQEiT/phoO6HIrXJ8SR5W8wK5F9IEq0o60f3WpjBT
         /lBg==
X-Gm-Message-State: AOUpUlEOhchXZ44sumdlWNafsboc7VXhS80yx9JePekjQopslZwi5XSe
        w/HtCz+qEWNxPxm9HK4biW/uUybIRwmZw00wkPY=
X-Google-Smtp-Source: AAOMgpfKAC6sHgEOHTRo9SaICTUKiFWTutT/V5HeYmd+JGILl1bjii8FxxcQEBUZrrEGMiHbVP6Cyq28EKlebk9gxEI=
X-Received: by 2002:a25:488a:: with SMTP id v132-v6mr3026673yba.263.1533332688846;
 Fri, 03 Aug 2018 14:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180803205204.GA3790@sigill.intra.peff.net> <CAPig+cSDM4vjuhwfuapuPpjjOmXbrhz-i0eVhtShp+nOYReLnA@mail.gmail.com>
 <20180803213819.GA4650@sigill.intra.peff.net>
In-Reply-To: <20180803213819.GA4650@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 3 Aug 2018 17:44:37 -0400
Message-ID: <CAPig+cRKPdYa7-8YB=rV3jJDe47mgB4xwbeWu4a4JQhx9r2h3Q@mail.gmail.com>
Subject: Re: [PATCH] add a script to diff rendered documentation
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 3, 2018 at 5:38 PM Jeff King <peff@peff.net> wrote:
> On Fri, Aug 03, 2018 at 05:33:17PM -0400, Eric Sunshine wrote:
> I suppose so. Frankly I only added that line to appease git-sh-options
> anyway.
> > Should "j" and "f" be "-j" and "-f", respectively?
> No, they're input to "rev-parse --parseopt".
> > There doesn't seem to a usage() function defined anywhere (and
> > OPTIONS_SPEC doesn't seem to be used).
> It's git-sh-setup automagic. Try "./doc-diff --foo"

Ah yes, I saw but then forgot that 'git-sh-setup' was sourced.

> > > +# We'll do both builds in a single worktree, which lets make reuse
> > > +# results that don't differ between the two trees.
> >
> > "which lets make reuse"?
>
> As in, lets the tool "make" reuse results...

Okay, I was confused by "make" being a verb, and thought you had made
a last-minute edit, rewriting "which makes it possible to reuse...",
and intending to say instead "which lets us reuse...". Had it been
formatted "which lets 'make' reuse...", I'd probably have read it
correctly. Not worth a re-roll.
