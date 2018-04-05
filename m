Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3841D1F404
	for <e@80x24.org>; Thu,  5 Apr 2018 22:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753233AbeDEWPi (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 18:15:38 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39527 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752595AbeDEWPh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 18:15:37 -0400
Received: by mail-pl0-f65.google.com with SMTP id s24-v6so21258534plq.6
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 15:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uksrXI9tOLD+RT/DhsChAQLHHOIXRC/KvgZ+q+y3ZzU=;
        b=Vc9bc+9L0Xmr1bazLoiT9Y7r8htqqvsW5tjj7YqBGBf5SaE5u190IFAQj4oao63q6u
         We6jHoFX7uRLCa3zORgcd5/9DKJr40z4tYS8kSoAEJ/Bd6Fyfeo+Osoq8ivOHwo15tRs
         LwLV5l5CPRdRDzjAQh3YXQHmxv27m4Viql5bcItZBYCvmpi8/KrybnAVTAeQmouDq4rI
         rDQTCVlHZrYGYQ7G3ce56wB6B4R9GLi0K6f52NMY8WRhX/20sfLn3U8SdOcM3HsOs755
         cRQUspZY1ew3MCcUTBiQwWk3QkQI06f84SLV+t9cMJ5OxcRFajPfQnaafnmZsMn0kcJs
         A2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uksrXI9tOLD+RT/DhsChAQLHHOIXRC/KvgZ+q+y3ZzU=;
        b=PrlG3zP+ITnDdFSa9sNmYV/LtE4OLdAwiNXbYAYyeLi7DhKf1m2aHudID+7c6FTv0s
         9WjQCcCLvgEkpfunmncJw3ilTwcXOUgLWafcGvUV0zaFUnuww+CA67gbQ6F353Z9TdzK
         UFt5Ln++tQnifl1eQkldkgcEIWLqTZSvOxakLuuujRyAucodi6k7Rc4rT+5yZ1jpn5pN
         fetzge7kQpWsOPQWXFdfBPoUpIWLmRbBst1rT4va0melWGLErKaAxcpWea1zoraVmP2C
         FGC8maO4z6I2LL4yzQDm41Sr4iFGy7ltor5xYurtMMDnurfJ3KUBSwX3p/ZUEOO/TIL8
         uYBA==
X-Gm-Message-State: AElRT7H7z2PutO04T4SPfYt72Uo8f+SYiiTjzK9lPCvaKqzICIyg9cwj
        bcGFwadBH50tKIGGhTBp+WQ8xA==
X-Google-Smtp-Source: AIpwx4/HNp5hdx7POzyOfPvNKpIy1UsKOlePi6dnqhAlmPS1UR/4GRkP8mkNKOU1K95zGR4lXYuekQ==
X-Received: by 10.99.120.3 with SMTP id t3mr15745880pgc.56.1522966537071;
        Thu, 05 Apr 2018 15:15:37 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:3d01:699f:f606:da49])
        by smtp.gmail.com with ESMTPSA id 27sm16874626pfo.137.2018.04.05.15.15.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Apr 2018 15:15:36 -0700 (PDT)
Date:   Thu, 5 Apr 2018 15:15:35 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com, gitster@pobox.com
Subject: Re: [PATCH v4 0/2] builtin/config.c: prefer `--type=bool` over
 `--bool`, etc.
Message-ID: <20180405221535.GB87758@syl.local>
References: <20180328234719.595-1-me@ttaylorr.com>
 <20180405020034.GA8879@syl.local>
 <20180405215759.GB29117@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405215759.GB29117@sigill.intra.peff.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 05, 2018 at 05:58:00PM -0400, Jeff King wrote:
> On Wed, Apr 04, 2018 at 07:00:34PM -0700, Taylor Blau wrote:
>
> > I have attached a fourth re-roll of my series to introduce
> > "--type=<type>" in "git config", and prefer it to "--<type>".
> >
> > In particular, since the last update, I have changed the following:
> >
> >   - Clearer wording in the second patch per Eric's suggestion.
> >
> >   - Stopped spelling the required argument to "--type=" as "[type]", and
> >     instead as "<type>" (cc: Eric).
> >
> >   - Changed "unexpected" to "unrecognized" in the fatal message when we
> >     don't know how to interpret the argument to "--type".
>
> This iteration looks good to me, assuming that last-one-wins is still
> the direction we want to go. I'm open to the notion that the cleanup is
> not worth the change in behavior. It is IMHO, but obviously it's
> somewhat subjective.

I am too, unless people on this thread have strong feelings otherwise.

Thanks,
Taylor
