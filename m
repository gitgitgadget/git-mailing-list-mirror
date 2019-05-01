Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A8A01F453
	for <e@80x24.org>; Wed,  1 May 2019 22:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfEAWCY (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 18:02:24 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46767 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfEAWCX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 18:02:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id n2so62792pgg.13
        for <git@vger.kernel.org>; Wed, 01 May 2019 15:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pyF7EmhBVcDmk85+yWNMA3xJx9nxIsWGVHzIYdUCLR0=;
        b=BXBnizTBCn+xI3Py81G4htco8PL+SFlt3hsnbUcc2sc/CCx1ZCqNa0YpBYq48TqufR
         CeYpUZpApU49aORLXndLT+hzR9iBfsBofG5XSzo6+ToRti1ytTG1PlaufUQImbFamDxu
         Fqj30cP0xfAQOaZ0icTuf2kUFogg8oO0DAI438g2N6O97MWMs+nwzWgjKee+UYc7wrc3
         wlSiE1NoBsClEVrPjNgtmefMJBluUJEfJmLCQXevgTcE6aDYqFLq6RdW86hRQCOEfri+
         yIcboKXTi5Xz5+41lI+1KIgXzfYUPnDbmxeVfHAea4Tt9R7RZliZEl9LAvl00IELA6Gj
         JYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pyF7EmhBVcDmk85+yWNMA3xJx9nxIsWGVHzIYdUCLR0=;
        b=py/TBiML2WzUKq7Q8GL1M5ZKVXTnmf6Q6jS3KJgQXJXlSJNRQUZIGwwIURHXoEGVsC
         CAPopIpyi9RfG1WDGPxR2xN/QpoqH1rTUhBzE2l/EO4eLkKjQrKI/bGcLkujtx9MGQfY
         Fn1jPt+1JH5fZZ+54G9CrqWv+yc0w9YQVXRHY2WWeRc79Ml2w/85OfhWu8ykBvahIAgj
         0r/N2/GZbSjlc4gw8RRzoqouJa5LSP5FEWtSm/+rt089ovavfKXZpOl4FtVRPiDxJy4B
         n6Sxrmc3EwqecAfjVvkel6arnMqa33BkryIQSL+8fMNgws0XPf0DBiMXUn6XM0bI4ThF
         L9cw==
X-Gm-Message-State: APjAAAX8HG9psiutJwHtBxAGPehfcYTMKceJnbGSs4QUGWdTqkLN1kay
        m4yBpWthrW1TOzQoG3D/oyI=
X-Google-Smtp-Source: APXvYqxBBKbolFpOCqJx3doFQ5GUijhJcvJjchoEVbx51K0zv381uC0k89eSLWGYE3nLkptwtiVsHg==
X-Received: by 2002:a63:5953:: with SMTP id j19mr366955pgm.260.1556748142280;
        Wed, 01 May 2019 15:02:22 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id z127sm21513671pfb.53.2019.05.01.15.02.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 15:02:20 -0700 (PDT)
Date:   Wed, 1 May 2019 15:02:19 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?xLBzbWFpbCBEw7ZubWV6?= <ismail@i10z.com>,
        =?utf-8?B?xLBzbWFpbCBEw7ZubWV6?= via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] mingw: enable DEP and ASLR
Message-ID: <20190501220219.GA42435@google.com>
References: <pull.134.git.gitgitgadget@gmail.com>
 <e142c1396ec3541486317819e885cf42be24af34.1556575015.git.gitgitgadget@gmail.com>
 <8e59dbf6-a339-74f3-4e60-e56b3817aea5@kdbg.org>
 <nycvar.QRO.7.76.6.1904301838400.45@tvgsbejvaqbjf.bet>
 <20190501204631.GB13372@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501204631.GB13372@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:

> I wonder if this points to this patch touching the wrong level. These
> compiler flags are a thing that _some_ builds want (i.e., production
> builds where people care most about security and not about debugging),
> but not necessarily all.
>
> I'd have expected this to be tweakable by a Makefile knob (either a
> specific knob, or just the caller setting the right CFLAGS etc), and
> then for the builds of Git for Windows to turn those knobs when making a
> package to distribute.
>
> Our internal package builds at GitHub all have this in their config.mak
> (for Linux, of course):
>
>   CFLAGS += -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1
>   CFLAGS += -fstack-protector-strong
>
>   CFLAGS += -fpie
>   LDFLAGS += -z relro -z now
>   LDFLAGS += -pie
>
> and I wouldn't be surprised if other binary distributors (like the
> Debian package) do something similar.

Yes, the Debian package uses

	CFLAGS := -Wall \
		$(shell dpkg-buildflags --get CFLAGS) \
		$(shell dpkg-buildflags --get CPPFLAGS)

and then passes CFLAGS='$(CFLAGS)' to "make".

That means we're using

	-g -O2 -fstack-protector-strong -Wformat -Werror=format-security
	-Wdate-time -D_FORTIFY_SOURCE=2

Dscho's suggestion for the Windows build sounds fine to me (if
checking for -Og, too).  Maybe it would make sense to factor out a
makefile variable for this, that could be used for builds on other
platforms, too.  That way, the autodetection can be in one place, and
there is a standard way to override it when the user wants something
else.

Thanks,
Jonathan
