Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2445E211B3
	for <e@80x24.org>; Sun,  2 Dec 2018 02:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725733AbeLBC3A (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Dec 2018 21:29:00 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33213 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbeLBC3A (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Dec 2018 21:29:00 -0500
Received: by mail-qk1-f194.google.com with SMTP id o89so5477702qko.0
        for <git@vger.kernel.org>; Sat, 01 Dec 2018 18:28:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=98f9axx0fWMEa+pJKCqnQUXG/FtT2rJ+A3Mv0pwkKlg=;
        b=eH1McJ4V9aTZgCFclRFNaHeVAa7FvyS2F40WveYNStLv7OXk9Q2ddqt1qUqyLNiFjM
         3DnWh3t1zq60hIP+TdW1BrAv+62NCPWHh/6CekIp2Gx9SHNjjtF5oUX2cyw/G7RI4UuP
         66U1nemx+4ffFrhgrWeX/EVpCVbcsbGjF5eRWyRxpc7hrAd9SmXq/3pAI/zCWlSzoG7Y
         YnZ961RMYUGQOIIhzO4z0mEGkDHWJyHfMjBBxx4/GHC5S/4AfZ1wOEpNbXnhUjk/4jNC
         5rgajjEDMd7BukEBdNzdFgjfFQlr4Sf9CqRoI2ttrkdlzrgDMxJBJN/6L65rtKngalm0
         z2Qw==
X-Gm-Message-State: AA+aEWaMeFHE2ndZJNgOs5+wyvAb4yUZHBveC58l5Tun9F2ZxxSsM0QC
        e6xxeKSM+JFb3WsigfJ3+f8vstL59r1TzaK0I4Y=
X-Google-Smtp-Source: AFSGD/XK1XBFby90+yDz/NYftNwYZ7zqkQCyX+XlV3a+7xD+ZkcK6ofgtA4al64wE/0UNuWS0FK6nVsCCujnRSNsVY4=
X-Received: by 2002:a37:66c1:: with SMTP id a184mr10410028qkc.314.1543717737500;
 Sat, 01 Dec 2018 18:28:57 -0800 (PST)
MIME-Version: 1.0
References: <3fb5a7ff-a63a-6fac-1456-4dbc9135d088@gmail.com>
 <nycvar.QRO.7.76.6.1811281600240.41@tvgsbejvaqbjf.bet> <25e07b91-3089-153c-2ecf-7d2d66bc3b65@gmail.com>
 <nycvar.QRO.7.76.6.1811281935310.41@tvgsbejvaqbjf.bet> <20181201200209.GC29120@sigill.intra.peff.net>
In-Reply-To: <20181201200209.GC29120@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 1 Dec 2018 21:28:47 -0500
Message-ID: <CAPig+cT6yo+wBHhkaAFK1REisOdtZsJNWEhoShcspzQsFeiWxQ@mail.gmail.com>
Subject: Re: [PATCH] rebase -i: introduce the 'test' command
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        paul.morelle@gmail.com, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 1, 2018 at 3:02 PM Jeff King <peff@peff.net> wrote:
> On Thu, Nov 29, 2018 at 09:32:48AM +0100, Johannes Schindelin wrote:
> > In reality, I think that it would even make sense to change the default to
> > reschedule failed `exec` commands. Which is why I suggested to also add a
> > config option.
>
> I sometimes add "x false" to the top of the todo list to stop and create
> new commits before the first one. That would be awkward if I could never
> get past that line. However, I think elsewhere a "pause" line has been
> discussed, which would serve the same purpose.

Are you thinking of the "break" command (not "pause") which Dscho
already added[1]?

[1]: 71f82465b1 (rebase -i: introduce the 'break' command, 2018-10-12)
