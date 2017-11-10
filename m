Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C9561F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 23:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753913AbdKJXdA (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 18:33:00 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:50590 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbdKJXc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 18:32:59 -0500
Received: by mail-ua0-f196.google.com with SMTP id v27so7896157uav.7
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 15:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bKuzUYyloT9Wjf9+L7z2/RC43eAy5IzZs5NPFA+8HcA=;
        b=VudD9yabIG6aohhTZu0v5USZBryZ+pXa7xlMHcVXWtLNosniZljcVQUfVqauCvhXrC
         t4/clVZDPzuDDqxbXi3T0nJDMKU+puNmRebOSIw20X3A5EQtgNxGjJHb1EbJx19pk7le
         aA7KvYLrT4zAcsGxf4Y4tAxuMF7x6yfznO0NlzwqoLpO2rv2I7fwCWUXKrG4/k0bd9DT
         7qx/1/Etf8bcMjdgjuFL80Nzyh8bw8RxtkqaWZSZuqsb78RhEe6kxur3tPI3VK4RIPmz
         tvtw+elqRRhGpCPCmtedZQbLeTEVRyHlcLVGsuIvBJE7mE5nXDaQk0EmiGeDtbg/AYiF
         OJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bKuzUYyloT9Wjf9+L7z2/RC43eAy5IzZs5NPFA+8HcA=;
        b=e2XLH3JeY9U2uRfgCOE8Fgzby+e+HtxNHLxAVJbcVdZO3CVV6RWiO46XUY66OO78qH
         OCJ5mAgSwsL21msE059od4ItolhdtmrazGmwQQgOLU2Ht/ZAPrTR30Vo1wTy9eVwtoEx
         lLGGzVEiKCuMLQv1FktCV6XCavB9J5XTTyamrIf2qW0+mCGwVZS6+5jPmnEPQR9oMlZ5
         ylpTi1Sv3iurM5Y7fuP4W4mhXnZlAlkt8mtoNesDqURkOs62mq3LUPcLdaBMAX9r7PK1
         nxt7qjY7MTrARBNppfc0VROCc0jPRZBVIz/+pWisqG98yN+WDKRwuG97jwsSle4KWlVj
         Fb8A==
X-Gm-Message-State: AJaThX54zCnmTjz0u6SdYm8UFbWm3V+vZ6W6dBB8AoAHnEUfbbJyXUHJ
        k2/oU2TU4XiRTFLWelPy4eS3eF1+PnTx9hZStTg=
X-Google-Smtp-Source: AGs4zMYzyZ0VHyAgbNUNgBYP5/4v8iqkv1Oy2y24Z6NLJap9JBmW4vm3odpBx3nAEfett24BjYNVpTUKde8ehGou1TE=
X-Received: by 10.176.82.110 with SMTP id j43mr1762938uaa.9.1510356778239;
 Fri, 10 Nov 2017 15:32:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.67.33 with HTTP; Fri, 10 Nov 2017 15:32:57 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1711101436270.2391@ds9.cixit.se>
References: <alpine.DEB.2.00.1711100959300.2391@ds9.cixit.se>
 <20171110102011.yqtka6a3wmgcvkl6@sigill.intra.peff.net> <alpine.DEB.2.00.1711101333030.2391@ds9.cixit.se>
 <7e242038-50e5-2cfc-e810-401af78b8cdc@gmail.com> <alpine.DEB.2.00.1711101436270.2391@ds9.cixit.se>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 10 Nov 2017 15:32:57 -0800
Message-ID: <CABPp-BEu_DOg5t0qHnyLYSok+J+onGFPoFBbgp9P-S5JfhcRjw@mail.gmail.com>
Subject: Re: cherry-pick very slow on big repository
To:     Peter Krefting <peter@softwolves.pp.se>
Cc:     Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 10, 2017 at 6:05 AM, Peter Krefting <peter@softwolves.pp.se> wrote:
> Derrick Stolee:
>
>> Git is spending time detecting renames, which implies you probably renamed
>> a folder or added and deleted a large number of files. This rename detection
>> is quadratic (# adds times # deletes).
>
> Yes, a couple of directories with a lot of template files have been renamed
> (and some removed, some added) between the current development branch and
> this old maintenance branch. I get the "Performing inexact rename detection"
> a lot when merging changes in the other direction.
>
> However, none of them applies to these particular commits, which only
> touches files that are in the exact same location on both branches.

I would be very interested to hear how my rename detection performance
patches work for you; this kind of usecase was the exact one it was
designed to help the most.  See
https://public-inbox.org/git/20171110222156.23221-1-newren@gmail.com/
