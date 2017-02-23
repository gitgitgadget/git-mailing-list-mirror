Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6F3B2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 23:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbdBWXXD (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:23:03 -0500
Received: from mail-ot0-f170.google.com ([74.125.82.170]:33065 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751584AbdBWXXC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:23:02 -0500
Received: by mail-ot0-f170.google.com with SMTP id k4so4481156otc.0
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 15:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fiiRRA37gzzxg4HRmcCO31areP3DE7vUnqpLbTM/BYg=;
        b=k9s3j5gX0y1VqZIHptUlb1zuwOgK+gYxdMuWzSZh4AyCuK4ni9q37ihgiV/Tnmf2LG
         WRJcKPiKr9mVR7Qi+HCZxLvfg56G7YSFhedOLkl41nbBo+utM+E+qsnyLfcmCrX8mkV4
         BjOVpUe8b9KctY6Nyh3jzdyfOMFvt3PGxiNFXLPFV2IzE41drqgs8v0jzDhLQECp7K3d
         Re6ZYgA5E5E563LcsI00Pyo9yDJoJxNE+vBUx6l8FMZ7Jwair2DWK6GxIuKfALJ7gwdY
         pt0fQg126SUU1LR86czSr5QtcPBFkYQXO8jCB8eXdCEEEYknBveMLjBoN1MT5IK7DoxF
         C7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=fiiRRA37gzzxg4HRmcCO31areP3DE7vUnqpLbTM/BYg=;
        b=YYZFB7E6y1amYUamVufir+tO0j3mQbQep7BOo/C6QDyO/m7hDcPJIvbI0y4kmDrHO6
         9E73LkhUPGR+2h2Vdhh15G9AQvRi0X5vxOAhUA9wPR3ANN/Jf6+IySFCHLKH6NOrxWCX
         erO0DJVwxFkS2+slbfFAsMHUfHiyjhc89n+mky32SBoCMIvQZJgwL+kUx8LxVB5nqvwJ
         Ulj6wzCfIiwkQoav8tw5WjMOAj8k+BotAuj7ecFKFYUwtE3X+ZRxUldjcK2D5vCt9vwT
         Y2wEfAq0CkmLMyeOy3xEbHTxLVT+ubruOqjNX9PPBY6kAWRvhzCTh5YYtnf8DVDcj8US
         J0/A==
X-Gm-Message-State: AMke39kU09EnXCMnbPCZNb8CFCHdThvicOYXSva2ENY1mfVgtUiGen4JH222OhJqkOXesl2YYDdP9yEreZfmog==
X-Received: by 10.157.41.135 with SMTP id n7mr19672866otb.165.1487891660470;
 Thu, 23 Feb 2017 15:14:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.164.66 with HTTP; Thu, 23 Feb 2017 15:14:19 -0800 (PST)
In-Reply-To: <20170223230507.kuxjqtg3ghcfskc6@sigill.intra.peff.net>
References: <CA+55aFzFEpi1crykZ33r9f7BsvLt_kiB-CHXOkuCAX=fd4BU-w@mail.gmail.com>
 <20170223182147.hbsyxsmyijgkqu75@kitenet.net> <CA+55aFxckeEW1ePcebrgG4iN4Lp62A2vU6tA=xnSDC_BnKQiCQ@mail.gmail.com>
 <20170223184637.xr74k42vc6y2pmse@sigill.intra.peff.net> <CA+55aFx=0EVfSG2iEKKa78g3hFN_yZ+L_FRm4R749nNAmTGO9w@mail.gmail.com>
 <20170223193210.munuqcjltwbrdy22@sigill.intra.peff.net> <CA+55aFxmr6ntWGbJDa8tOyxXDX3H-yd4TQthgV_Tn1u91yyT8w@mail.gmail.com>
 <20170223195753.ppsat2gwd3jq22by@sigill.intra.peff.net> <alpine.LFD.2.20.1702231428540.30435@i7.lan>
 <20170223224302.joti4zqucme3vqr2@sigill.intra.peff.net> <20170223230507.kuxjqtg3ghcfskc6@sigill.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Feb 2017 15:14:19 -0800
X-Google-Sender-Auth: wOU1N66RD8WDrJE6_V4EdWbjBIw
Message-ID: <CA+55aFyj2nEec4AL5pqY4Gz-mRuBuhp=+hRjTnhPVEnAU89i=g@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Jeff King <peff@peff.net>
Cc:     Joey Hess <id@joeyh.name>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 3:05 PM, Jeff King <peff@peff.net> wrote:
>
> (By the way, I don't see your version on the list, Linus, which probably
> means it was eaten by the 100K filter).

Ahh. I didn't even think about a size filter.

Doesn't matter, your version looks fine.

           Linus
