Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C31D61F45F
	for <e@80x24.org>; Fri, 10 May 2019 17:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfEJRAU (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 13:00:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37516 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfEJRAT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 13:00:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id a12so8708658wrn.4
        for <git@vger.kernel.org>; Fri, 10 May 2019 10:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eRUu6+L/LT8XmwMd/9rN5FMHP4ycVo+0N+46sk/eIG4=;
        b=efp4sQ4im9RtigblTdh8l/HIuXtLM2H2C2M3oTH8e9++8DnCkFXTmCGKyUv2FWKJuF
         Sc0T1ZdgjKqNnNK4FOemgYfEUE7PpdR10MPtO9TztMUGozTVwaPL+Td3z1SGJ1HOcC3z
         Y4+scZ311mMk/hbgr9Dhy4kQxd30Zxbrdwm/Q+xErEVZXENcITgX9YIkdFiwANk91mtl
         3EvBRzT3VBYOrIJ4wjTmZ8ThtuHJSNpLC9BpG9g3UJTOr44lZ8jd2pBMBxr6QQJrbwxB
         +X3Ky/NmJpG81Mb66esYukPX8a6UKNvgnrDqx/gojA+1aAt2y05qNi9rbx9UKLjmoyi9
         gEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eRUu6+L/LT8XmwMd/9rN5FMHP4ycVo+0N+46sk/eIG4=;
        b=Mvwv3y3Ioo9O15FQkefJpB1nDtou2naG9Q9wgArCh+gI/VhF8OOYJGUKkjpbxCj6yk
         mAxcQZt7HnVkXDCj/b8+z5Lr4QrVeHAM9aOZhDNWThhl8tgHh6PKTWkCroB0pDXqM3ve
         5lCYQPgL1Xqk41aDN1gmK1XxM3q1WJv9lHwtPndb0+ydMJMovDntIC9yLnkd2PPgD37p
         eCQqBKDWnPYo/k1qmTXMIqww1c+2RUDPHS/8UTVMRpIFVmNfhqZMY2Xz2D+kWU81SU/n
         YEk0MXD70kD+WZlaro2nbTIrvgInIyjp9I69gnp/oqi59/2y+q4pBdBa16bKA4tGK2Cm
         B4NA==
X-Gm-Message-State: APjAAAXwyIC2tXVVmFnRfugSM/gr56kX6UUVuzBDCS/j6c7DvzWTy8f/
        PSX9Ay6r64s9EwkVegDHbn8=
X-Google-Smtp-Source: APXvYqzmbbKErbd+iLcds3vz3pKkZYpn5E2Z6BGitd4GljxvxZbEgnCpSiwVG4ND6by4wEgzVjt3/w==
X-Received: by 2002:adf:da4a:: with SMTP id r10mr8408910wrl.216.1557507618080;
        Fri, 10 May 2019 10:00:18 -0700 (PDT)
Received: from szeder.dev (x4d0c00f2.dyn.telefonica.de. [77.12.0.242])
        by smtp.gmail.com with ESMTPSA id 91sm10154262wrs.43.2019.05.10.10.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 10:00:16 -0700 (PDT)
Date:   Fri, 10 May 2019 19:00:14 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: I made a flame graph renderer for git's trace2 output
Message-ID: <20190510170014.GQ14763@szeder.dev>
References: <87zhnuwdkp.fsf@evledraar.gmail.com>
 <8794fd2e-6256-3238-6d87-2e726d4a91fa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8794fd2e-6256-3238-6d87-2e726d4a91fa@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 10, 2019 at 12:38:52PM -0400, Derrick Stolee wrote:
> export GIT_TR2_EVENT=~/git-tr2-event.txt

Hrm,  better late than never, or at least better late than after it's
in a release...

Why does an environment variable that is supposed to be set by users
have this "TR2" abbreviation in its prefix?  What exactly, if
anything, did we gain by omitting "ACE" and not calling it
"GIT_TRACE2_..."?

Ken Thompson springs to mind, who (allegedly?) later regretted
spelling creat()/O_CREAT without the 'e'...

