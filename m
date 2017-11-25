Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D37C520A40
	for <e@80x24.org>; Sat, 25 Nov 2017 10:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750992AbdKYKPY (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 05:15:24 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36321 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbdKYKPX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 05:15:23 -0500
Received: by mail-wr0-f193.google.com with SMTP id y42so22251582wrd.3
        for <git@vger.kernel.org>; Sat, 25 Nov 2017 02:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mqqky35/PUQ+XlRe0zpdsewBtnu7bojurBGsPfeNt5E=;
        b=RCWWVcpa+Eezw2JWFBJCRMMSOoZiNOe92Aoo1syBJN5/WMmzn91OdOI328hhuw3Gk3
         /2gR3H5HkXlwH5Z3PrWTfNpLkKnzz97BesebKfNXKatZm1N5vLc5sM8SQyaRmD2Dr8Dr
         9VTRLfWPLICyBD7SKj5WIA9UyifbHqWO2ws12KCZpuSowhQ/yVt2x2U6+IMB3g+rB51q
         pouJCKf/91j20QsPykIVg0jslCtnRY8lCptiKzniyqA7oVnrWW1T6V7be0Vyaw5G1B8K
         f6JiACYTgCZ/pKrCeeR090sG5TjQ7lgd8YaDW8lGoDnI4jrGJVRInLVN6EuXkkjtjg8T
         oJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mqqky35/PUQ+XlRe0zpdsewBtnu7bojurBGsPfeNt5E=;
        b=IYDsISoEMCbdx7ie8ihM39Spc1Y91sX+TdVW32017MRxQ7Le8Dge6U2s2L32TYG0o7
         h5xuUAzPIFnLk2uL671qF1iG8QW9DmKCIJhJF4TM5SLyKlRcT87kcGOtwZnnv/3tvJly
         NoaL+/TCKQRV3FboXAH1fOhI0k6bxWRrbU7lg0GPJ4VoHoDkQEYGRFoP6pYbBQE4O4H/
         R9G4zsoVDYuBpDk60p6SWK73s0tUCBiuCpg9/QGwVNNwv6HhA1KYsisn8RSo85+Zz5bL
         f2wur7REan9b8gjZQXE/87JnRfNTeiaJVkOABTsQFNi+7f5PddLhnuejk4eIJoVFmA62
         PVPw==
X-Gm-Message-State: AJaThX57qPWeFP4yI13yB+zT+6VleMFwvMwrFGFDV1XC+bdjyXzgA2a0
        hI/QiW92l8SU5C9lf4dpHRk=
X-Google-Smtp-Source: AGs4zMYz9v9Mcf5Ll3i+8yTsqurbHDOKP/oBhRt/vnD0anPaFxAmOt/nT5vukJ1OHB53xWzPZe+QWQ==
X-Received: by 10.223.170.214 with SMTP id i22mr30298342wrc.110.1511604921826;
        Sat, 25 Nov 2017 02:15:21 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id x142sm9250661wme.34.2017.11.25.02.15.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Nov 2017 02:15:20 -0800 (PST)
Date:   Sat, 25 Nov 2017 10:16:53 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] checkout: include the checkout.h header file
Message-ID: <20171125101653.GA3203@hank>
References: <60a2f330-8113-6389-ba2d-574d6af94a83@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60a2f330-8113-6389-ba2d-574d6af94a83@ramsayjones.plus.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/24, Ramsay Jones wrote:
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi Thomas,
> 
> If you need to re-roll your 'tg/worktree-create-tracking' branch, could
> you please squash this into the relevant patch (commit 6736ae9593,
> "checkout: factor out functions to new lib file", 2017-11-22).
> 
> [noticed by sparse]

Thanks for noticing this, I'll squash it into my re-roll.

> Thanks!
> 
> ATB,
> Ramsay Jones
> 
>  checkout.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/checkout.c b/checkout.c
> index b0c744d37..ac42630f7 100644
> --- a/checkout.c
> +++ b/checkout.c
> @@ -1,5 +1,6 @@
>  #include "cache.h"
>  #include "remote.h"
> +#include "checkout.h"
>  
>  struct tracking_name_data {
>  	/* const */ char *src_ref;
> -- 
> 2.15.0
