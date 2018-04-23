Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 110FC1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 01:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753848AbeDWBRa (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 21:17:30 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36998 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753755AbeDWBR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 21:17:29 -0400
Received: by mail-pf0-f172.google.com with SMTP id p6so7831426pfn.4
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 18:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mBZobjf786Ojt+EaxvcKOQHv8QVatEVY2X5Cz7hh9vg=;
        b=fTS3SKtg1E6K543YPQVzXeZgDGhA5lScJDAnm4nGmUKu8Ft3JU42X38dqYtAMtLmku
         ft3ZFQZTqIfw94Dl3QZtl/IPhoCZXVC0i/tfsYajBymojJhUTWSywwzmFxpSoFNeAps/
         O50Is2BCjf8FHy5yjF9Sc7VlmDFvG5AWwEPtfYiSM1docR/olyqZYbsk9k5FdCPaLnxp
         sRYInnRfayx84R82/DEuoGgOTu1Nre0o1KNzPBfYouVF3Oa3iMfyxOmoH97zoV1d/7zJ
         4LTDztsVSPWemMv7xo697pBvUvp7Xp6i9BLpzXisJvZ4vKd+ZvNDYioveIar0+LWWkfC
         EYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mBZobjf786Ojt+EaxvcKOQHv8QVatEVY2X5Cz7hh9vg=;
        b=sOeR84H8f5tK4Q2MfIpbqSpXiszbReXOOt7M8eXGCOK0KzoTB6xrYvD7s36hIPisk3
         SOnNpmcRtFZqVV5KeV7f6VI2WtVDEgQB8d5Us5sTmt2iQ7u4dqeYIuIhp/XcLT/da1iS
         kgV0N+zSZJ4kT+fbFDRodx6m7L9P9QQ+tCC+k4QM7hyqU9qrHqQKpV2unNwJ0ydOmija
         VPxm8pkNFgYR+bMuSqT6y/2gwc/Yn8/LT2ZVuffM0AWhLET8RgQyoOy6/oH891VAKxzz
         +Ey7Qc2JSAoC8Bu/gnbdenlc5E9yd0F6A/ESf8VzI6vbAXvuxleaMYDBOyiPMwEe1rWz
         CLvA==
X-Gm-Message-State: ALQs6tCnBHaX+zV+9oVL1UStQ1FE3kz/681MTBTS3d/zvMPdfojZo4Au
        Y5CL24ZHV3hMgSPzs73MUeYFAA==
X-Google-Smtp-Source: AIpwx482kb6sbQxa+AMjD2ryDsa1OaN/hUts5eqCocIM+BWqKPKIIJdbX1mBXkEQ56uNIjtMyFv5sQ==
X-Received: by 10.98.166.92 with SMTP id t89mr17853260pfe.27.1524446248245;
        Sun, 22 Apr 2018 18:17:28 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:e8b3:eaad:c134:baec])
        by smtp.gmail.com with ESMTPSA id p6sm21921427pfk.104.2018.04.22.18.17.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Apr 2018 18:17:27 -0700 (PDT)
Date:   Sun, 22 Apr 2018 18:17:26 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 2/6] grep.c: take column number as argument to
 show_line()
Message-ID: <20180423011726.GD78148@syl.local>
References: <20180421034530.GB24606@syl.local>
 <cover.1524429778.git.me@ttaylorr.com>
 <5aaf7bebb27d385ea090cb83e97c596983ebae47.1524429778.git.me@ttaylorr.com>
 <CAPig+cQ2+wTTXE0mhnGnp2pZug=Po0SCVwCO_2agxUDaOsFRLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQ2+wTTXE0mhnGnp2pZug=Po0SCVwCO_2agxUDaOsFRLw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 22, 2018 at 08:16:12PM -0400, Eric Sunshine wrote:
> On Sun, Apr 22, 2018 at 4:47 PM, Taylor Blau <me@ttaylorr.com> wrote:
> > show_line() currently receives the line number within the
> > 'grep_opt->buf' in order to determine which line number to display. In
> > order to display information about the matching column number--if
> > requested--we must additionally take in that information.
> >
> > To do so, we extend the signature of show_line() to take in an
> > additional unsigned "cno". "cno" is either:
> >
> >   * A 1-indexed column number of the first match on the given line, or
> >   * 0, if the column number is irrelevant (when displaying a function
> >     name, context lines, etc).
>
> This information about how 'cno' is interpreted seems important enough
> to have as an in-code comment somewhere. Unfortunately, this patch
> never actually uses 'cno', so it's hard to add such a comment to
> non-existent code. In fact, the granularity of this patch feels wrong;
> it seems to exist for some purpose but, at the same time, is a
> do-nothing patch.
>
> This issue illustrates a larger problem with how this patch series is
> structured overall. In his review, Ævar suggested collapsing several
> patches into one, but the problems go deeper than that when you have
> patches which implement some bit of functionality but don't document
> that functionality until some later step which exposes some other bit
> of functionality, and so forth. As a reviewer, I expect a patch series
> to hold my hand and lead me on a straightforward journey from building
> blocks to final product, but this series tends to jump around without
> apparent logic.
>
> One way to achieve a more coherent patch series would be to build the
> machinery first and then expose it to the user in various ways. Also,
> each patch which implements some user-facing functionality should also
> document that functionality. For instance, a more understandable
> series might be structured something like this:
>
>   1. grep: match_line: expose matched column
>   2. grep: extend grep_opt to allow showing matched column
>   3. grep: display column number of first match
>   4. builtin/grep: add --column-number option
>   5. grep: add configuration variables to show matched column
>   6. contrib/git-jump: jump to match column in addition to line
>
> There may be fewer or more patches than shown here (I believe Ævar
> suggested a cleanup patch), but this should give the general idea.
> Patches 4 and 5 might also be swapped if that seems more logical.
>
> (Sorry if any of the above sounds harsh; it's not meant to be, but is
> intended to be constructive.)

I appreciate the suggestion, and did not take it as harsh. I think that
the existing structure is OK, but I think that I am biased since I'm the
author of the series. I have given your proposed structure a shot and I
think that it should improve the readability of this series for others
on the list as well.

To avoid sending more email than is necessary, I have pushed a draft of
this series to my copy of Git, and would greatly appreciate your
feedback on whether the structure of these patches is sensible. If they
all seem OK to you, I'll happily push v3.

For your consideration: https://github.com/ttaylorr/git/compare/tb/grep-colno

> > We additionally modify all calls to show_line() in order to pass the new
> > required argument.
>
> Nit: No need to state the obvious; this final sentence could easily be dropped.

Fair; I have removed this from the patch.


Thanks,
Taylor
