Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96BB41F404
	for <e@80x24.org>; Tue, 27 Feb 2018 18:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbeB0SCV (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 13:02:21 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:40821 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbeB0SCU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 13:02:20 -0500
Received: by mail-pg0-f42.google.com with SMTP id g2so7807333pgn.7
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 10:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mF1Pn4hgwMmaEKRiN/AexSCnoeNfCDTqqahzu0VjT34=;
        b=M8f6VaKjQRknyY7hBJ8kUZWA8qo2bgdaVzJ2/LrbAiA+JYbdgbTTA1isa5qJMfYDqu
         730pRGNdKvg6FT1YjojSYUTBb2KykVIWepCK7ToPtIhbw2qlz2A+Lrk2EjJnfjKCTOht
         uvuugS5F6LG3uvNgdHJYBWBteOVj4Ev5yubToS/mUsUHr//701VNjgVzr6IEkupwxHxQ
         bdwalsgKnf2Fds3ff+2nhG/IXix8iSeBeRyVAzRXypHuEMGE+mpkzNjVTMG6tN2aeIzm
         JKALvALGknKg6ZGvodUVrSi49u+As1hpq9juF7xL3Rob5b1I2ng7d6Tu/W8g3H17ViBc
         ewmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mF1Pn4hgwMmaEKRiN/AexSCnoeNfCDTqqahzu0VjT34=;
        b=j4cFueSr7OkgSV0C+Sunki4nup4iQl9kOeho4E2E4gIV4cwG+SjwKTfN4HfuxpJsZl
         gNZzUD9JwhubBMLsvXs6y0eebwZcMDO+TaP3mNZ8YuN6oLeLFNi6PApDkr54cW60vEES
         9peC8I9o4T7WzV6QlFyQR7S7IW5pNDE/BOCn5zgvb/AmIgoZ++bdhLn8T5qCvn2ivOZ2
         N86zfiWZ9tAyiYS6EQdcnLq56ojswJMDHPdUht4esgwBjkdm/DeNEwKzIVhEcxAzH/gP
         mPo6cDZH7Sf1+E+wT2m1qldbwxNnkBuYjuNihjGIqALureLHlTX/Scev8RaRPF+ss/YA
         zV5A==
X-Gm-Message-State: APf1xPDCWynDHEXUwZ/5k5eA1RPyQv+tz6alKLnz0ocVgddnGqzlmG+R
        w+u4xOAtigFby1NounbIasht7g==
X-Google-Smtp-Source: AH8x227wEzXXlky/Poz7rguGCzX6iwtxMbpfiK9SpfdGJqzrLprqblVr4w0DWse3HKM8s7+7O8shsQ==
X-Received: by 10.101.68.82 with SMTP id e18mr11858246pgq.329.1519754539085;
        Tue, 27 Feb 2018 10:02:19 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id 75sm9139100pfl.169.2018.02.27.10.02.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 10:02:17 -0800 (PST)
Date:   Tue, 27 Feb 2018 10:02:16 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 13/35] ls-refs: introduce ls-refs server command
Message-ID: <20180227180216.GA209668@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-14-bmwill@google.com>
 <20180222094831.GB12442@sigill.intra.peff.net>
 <20180223004514.GP185096@google.com>
 <20180224040149.GA16743@sigill.intra.peff.net>
 <87inaje1uv.fsf@evledraar.gmail.com>
 <20180227051555.GA65699@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180227051555.GA65699@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/26, Jonathan Nieder wrote:
> Ævar Arnfjörð Bjarmason wrote:
> > On Sat, Feb 24 2018, Jeff King jotted:
> 
> >> I actually wonder if we should just specify that the patterns must
> >> _always_ be fully-qualified, but may end with a single "/*" to iterate
> >> over wildcards. Or even simpler, that "refs/heads/foo" would find that
> >> ref itself, and anything under it.
> >
> > I agree that this is a very good trade-off for now, but I think having
> > an escape hatch makes sense. It looks like the protocol is implicitly
> > extendible since another parameter could be added, but maybe having such
> > a parameter from the get-go would make sense:
> 
> I prefer to rely on the implicit extensibility (following the general
> YAGNI principle).
> 
> In other words, we can introduce a pattern-type later and make the
> current pattern-type the default.

Yeah this is what I'm going to do for the next re-roll of the series,
make the pattern matching simple and later we can extend it if we want
since we already have the ability to add new features to commands (you
can see how I added shallow to fetch for an example).

> 
> Thanks for looking to the future.
> 
> [...]
> > E.g. if the refs were stored indexed using the method described at
> > https://swtch.com/~rsc/regexp/regexp4.html tail matching becomes no less
> > efficient than prefix matching, but a function of how many trigrams in
> > your index match the pattern given.
> 
> I think the nearest planned change to ref storage is [1], which is
> still optimized for prefix matching.  Longer term, maybe some day
> we'll want a secondary index that supports infix matching, or maybe
> we'll never need it. :)
> 
> Sincerely,
> Jonathan
> 
> [1] https://public-inbox.org/git/CAJo=hJsZcAM9sipdVr7TMD-FD2V2W6_pvMQ791EGCDsDkQ033w@mail.gmail.com/#t

-- 
Brandon Williams
