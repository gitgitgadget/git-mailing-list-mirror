Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A1F91F775
	for <e@80x24.org>; Wed,  2 Jan 2019 18:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfABSAZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 13:00:25 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32958 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfABSAY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 13:00:24 -0500
Received: by mail-qt1-f194.google.com with SMTP id l11so34349499qtp.0
        for <git@vger.kernel.org>; Wed, 02 Jan 2019 10:00:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VyHXHX8agG4F6Js+mScvyat0VSd6qpwSRQulLu6f0Hg=;
        b=kgXCB+vTw7o1JfljJIqXf9Qm7Bp83bAl5oiMkBANQ7bwzELGXDFoTBNiRrq82xS95P
         mo2TFs8/wT3q8kv7hSvnE54zRF0QAxs4ejgHmn0uhm2oiBUoU3sux9O2ETZOwlygBrih
         vbWm12n0F7C2oYL4nMWG2hc5/0LlEL4fJo/jaFTGxYScbLn0uALj5rFJtgF6VQg6sRCA
         qb5E9RyqELUF+sC4AG6b7izO9I9uac6YPWJTD+E80LThfGEPg+tl2IC22fToGd/B6tSq
         nmhSYxXZllkDkBS8tI2GVViSH/aOVU87VkIpdGbg81RnDMe1sOArOVEJ3CMbIjlYxnOL
         P4tg==
X-Gm-Message-State: AJcUukfe4CVhse4zLPI7WCFqN9b1yFAZpowJs8bWTuKfm9M/jk6O885H
        Y7XWttt6dJ12HMMHFMzdJuHM73+ezv5jiHC8Wv04nnvC2og=
X-Google-Smtp-Source: ALg8bN6X/LvwkUNJet+665kyFVfLfbsd9rmo12gMcDaWI2jx3S9suSFlgCZnlylkMLZG9DM3GwmbXt7j5ARARiLYdAY=
X-Received: by 2002:a0c:9359:: with SMTP id e25mr43956382qve.203.1546452023975;
 Wed, 02 Jan 2019 10:00:23 -0800 (PST)
MIME-Version: 1.0
References: <20190102093846.6664-1-e@80x24.org>
In-Reply-To: <20190102093846.6664-1-e@80x24.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 2 Jan 2019 13:00:14 -0500
Message-ID: <CAPig+cR2w3S==3-zstjmuB9jw4H-aPK7xqMeMLK-P94=+18jJQ@mail.gmail.com>
Subject: Re: [PATCH] banned.h: mark strncat() as banned
To:     Eric Wong <e@80x24.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 2, 2019 at 4:38 AM Eric Wong <e@80x24.org> wrote:
>
> strncat() has the same quadratic behavior as strcat() and is
> difficult-to-read and bug-prone.  While it hasn't yet been a
> problem in git iself, strncat() found it's way into 'master'

s/iself/itself/

> of cgit and caused segfaults on my system.
>
> Signed-off-by: Eric Wong <e@80x24.org>
