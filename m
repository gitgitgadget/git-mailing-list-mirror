Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 965BC2023D
	for <e@80x24.org>; Wed,  1 Mar 2017 21:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753300AbdCAVRx (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 16:17:53 -0500
Received: from mail-yw0-f170.google.com ([209.85.161.170]:34624 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753271AbdCAVRm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 16:17:42 -0500
Received: by mail-yw0-f170.google.com with SMTP id p77so43108533ywg.1
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 13:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kmmXMAx+L2B2eZXbkG4YoHr10xhCkBuTD/lfZLcxOrY=;
        b=QEuW8xMVGEqJ3NlJVdUyxNMdyJrKUmJZ5m++0gyQN0gtiWvmtA7vwDRC3xHqopvHCE
         yDdBRUViQEI9kiiP0upRiHYI6QVkvTAtVX2Sx4UPeeQIJKwLHjyPha7WEYgzYTzvON2K
         21kjI/8gMawynVtuNAWlAQ+UDLh8MLXdtDcY0WVTYNwx6KGJWfjxGD+eEHF+b5UQkeik
         9F4RtwqAOVIMNOLl8tB6dSza33898WjU8AExfNuTGqIZpYJpa/CDIPXiBnIOU2jdi7mu
         mYwOWHsOxuEQsDEn6JLz4QsAYDaCUkt+fHnIa+3MR5lItgQjbk1aoM2sCdtPr1Z9T2hJ
         rH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kmmXMAx+L2B2eZXbkG4YoHr10xhCkBuTD/lfZLcxOrY=;
        b=chmnd3Lv8AM/okpdB5E/D58gM3EZT4lp3zXCbwlsEdntQW/3BARfBm6iJep495fLQb
         w+0VXkseCEm47Kk6BK6/LXMMRXfJNgpOn2QTFtkCrGn9kl+xx+evpr+WbgHmTYntYTZ0
         72GftkAAuSGNxPlo95o20lAUZXVWAEnue6WBfTl5bNy1hc9tgw4ZjGq9Y2JNSNDbvl7N
         1t4ZI/GXZbpVQnQ5pbX8qPxZg3ih2cabDnIodoHKu0OR3H4V/AFEMJuGDp4CkJ3GUCQp
         5lkaet9wDiQylK7hq26GghHONbtBIZOwwrMJ7BaVGnkMw2sxX1i/PGtJ/yE2F+OmVnVF
         G1Aw==
X-Gm-Message-State: AMke39nIPF/OzXuLtAx1jFx6WQcW76DTopkJ8cD5BArQDdcIKwnssscxjCC8jMbpIhz372V2IaXws4S1jD2Wfg==
X-Received: by 10.129.182.20 with SMTP id u20mr4413424ywh.286.1488399590265;
 Wed, 01 Mar 2017 12:19:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.67.40 with HTTP; Wed, 1 Mar 2017 12:19:29 -0800 (PST)
In-Reply-To: <4d2a1852-8c84-2869-78ad-3c863f6dcaf7@gmail.com>
References: <4d2a1852-8c84-2869-78ad-3c863f6dcaf7@gmail.com>
From:   Martin Langhoff <martin.langhoff@gmail.com>
Date:   Wed, 1 Mar 2017 15:19:29 -0500
Message-ID: <CACPiFC+=ZpHT=xh7Y8f68BcXxNYx8EFJfzqqG2ub4NL=uREu7g@mail.gmail.com>
Subject: Re: Delta compression not so effective
To:     Marius Storm-Olsen <mstormo@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 1, 2017 at 8:51 AM, Marius Storm-Olsen <mstormo@gmail.com> wrote:
> BUT, even still, I would expect Git's delta compression to be quite effective, compared to the compression present in SVN.

jar files are zipfiles. They don't delta in any useful form, and in
fact they differ even if they contain identical binary files inside.

>     Commits: 32988
>     DB (server) size: 139GB

Are you certain of the on-disk storage at the SVN server? Ideally,
you've taken the size with a low-level tool like `du -sh
/path/to/SVNRoot`.

Even with no delta compression (as per Junio and Linus' discussion),
based on past experience importing jar/wars/binaries from SVN into
git... I'd expect git's worst case to be on-par with SVN, perhaps ~5%
larger due to compression headers on uncompressible data.

cheers,


m
-- 
 martin.langhoff@gmail.com
 - ask interesting questions  ~  http://linkedin.com/in/martinlanghoff
 - don't be distracted        ~  http://github.com/martin-langhoff
   by shiny stuff
