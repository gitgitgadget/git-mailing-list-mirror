Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E5361F597
	for <e@80x24.org>; Fri,  3 Aug 2018 06:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeHCIQb (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 04:16:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41767 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbeHCIQa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 04:16:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id y10-v6so2679455pfn.8
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 23:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+NEHlF4lizj2NpWirwV+wQQJNExwhHBfAPcpk6U/pYw=;
        b=hQcvUeoX5mrVW7hmVTzj/ZoMIEykF2LlOgj6DUzfii0Jno6T//OKmztO8U5rOa65ZZ
         oy/t/wUQJmdBYlr49MujSKoydJLpOy4cVjndnSYeGilwH81I4y1VHqghGgNTMSnjc9Xr
         V/j5G7rKIqKPavkcXQBgwtmpOHOjLij6LBTWZN6tVtrcv+NeOkpBAvljn05znuBsXv3G
         iAgYhyRFu4j4ntp8bYu5MTyLXIGMr98s+XphzLXJqJqM0cY/DUIP+47004sZo59r8Uow
         24rCxuzvIDVNhxOP9Ne2a+n6PUMHyh85BvaYy+MTrIFgDIY/YLseb4WuLMY5J/CnCjOS
         vgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+NEHlF4lizj2NpWirwV+wQQJNExwhHBfAPcpk6U/pYw=;
        b=eT5znY9OM41PLCsTSc3ev1lueZqQIEZUozNSHTO+7goi/SLJuadRO7denudj0EHmfm
         LgvWU79twmkOSx7pB/cDbJHjAMSZlknZ0Zb8nLmW2p42EHxnRbF+Cd5WtpJx6GEogKfn
         fMD3nun1LJk9zj1RAg7U7HoLtYm8tx6Qfmk2PpTr9ItoHHiogtRyQDSfJKy495dV1EUK
         +22TC4p6nxCYufmPeiktzsTrMsTJ2PSwrb0wLx4w8pTbW9fEpgZ8/qMq2g4VJZMcM7jz
         HILLA68SXKFocjYsrOA0oSLturUXNN91OCX8MJiMTk21S78gWp6HBWcymrPR6AFM6Gg9
         B3iw==
X-Gm-Message-State: AOUpUlF3552FBIj+SCKcJcMvaxW3w8xWtaRJCBIwbJqHW5zcrKt880O/
        2RBeKNG78bQQb57Vk1mcbn8=
X-Google-Smtp-Source: AAOMgpfEuHWOLOruWC7WT1oYUTPsPuogphxWKJ+NetwD/Z23+5iAORixXebH09XOu3yLGUvbskZFIA==
X-Received: by 2002:a63:214f:: with SMTP id s15-v6mr2338352pgm.267.1533277306239;
        Thu, 02 Aug 2018 23:21:46 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id k64-v6sm4700715pgd.47.2018.08.02.23.21.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 23:21:45 -0700 (PDT)
Date:   Thu, 2 Aug 2018 23:21:44 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PoC] coccinelle: make Coccinelle-related make targets more
 fine-grained
Message-ID: <20180803062144.GB237521@aiede.svl.corp.google.com>
References: <20180723135100.24288-1-szeder.dev@gmail.com>
 <20180802115522.16107-1-szeder.dev@gmail.com>
 <20180802180155.GD15984@sigill.intra.peff.net>
 <20180802183145.GA23690@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802183145.GA23690@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Thu, Aug 02, 2018 at 02:01:55PM -0400, Jeff King wrote:

>> I suspect if we go with the one-spatch-per-source route, though, that we
>> could do this just with regular make rules.
>
> Yeah, it's pretty straightforward:
> 
> diff --git a/Makefile b/Makefile
> index d616c0412..86fdcf567 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2674,15 +2674,17 @@ COCCI_SOURCES = $(filter-out sha1collisiondetection/%,$(C_SOURCES))
>  else
>  COCCI_SOURCES = $(filter-out sha1dc/%,$(C_SOURCES))
>  endif
> +COCCI_COMBINED = contrib/coccinelle/combined.cocci

I like this approach.

[...]
> I guess you could even replace "COCCI_COMBINED" with "COCCI_PATCH" in
> most of the targets, and that would let people do individual:
> 
>   make COCCI_PATCH=contrib/coccinelle/foo.cocci coccicheck

The issue here is that the dependencies for foo.cocci become
unreliable, so I'd rather have a separate target for that (e.g.
depending on FORCE) if we go that way.

Thanks,
Jonathan
