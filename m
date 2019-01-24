Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AED29211B5
	for <e@80x24.org>; Thu, 24 Jan 2019 22:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfAXWIG (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 17:08:06 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39304 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfAXWIF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 17:08:05 -0500
Received: by mail-wm1-f66.google.com with SMTP id y8so4699961wmi.4
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 14:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nwp16yuXtiedBLyzEXlUL3CjFP0eAat/pw+aFHEnOxs=;
        b=Sm1JIfeHk6zSOX0qu+Ls0RyMwVZUoDh4FJ7g/yf7queSKSid4cOrx7KAWIjsXKdF55
         XEQ2RN9mwv1fh6ToZvt6cBm1x8IE0kssx0ljw4dl8cwlbLJn6E83pugswrxzHWCqkdXE
         mDJJOJuyfihnIlNSCFDEKNCQ8hCS0l3FsEkhFMXEIMvwToMNEXkKyfRy/4smSOrLsO7k
         mzqL/NfsW0KDSVtdcq/y9j75o3G801o0zA8TH5uBpgbAE9vKPXfBKbacn+gE9rJblgEV
         gMGeNVafNiOwSlAT5CsgyjSm4QeDjN9zUY06b/OIdHkPpODR2Vmk6IyjO/AJITBrkUbv
         nWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nwp16yuXtiedBLyzEXlUL3CjFP0eAat/pw+aFHEnOxs=;
        b=IlAdL51bQKW+6Z1o1ZDHBD+GLopAn39kusv4+ewCB88fv87UfAFpsgiExEQ3z24Zgp
         2Ge8wnwr05dTQF2mnNlMa7/EXV2X6dw1VXT+BZucBDomaDqnm13Q567qof6qPR/t8Q14
         oTHYCCTjGzhlXssFCEwDT8jJ/aHHQMckLLszbK6FW1Oo/JLOnLldJMnEEows4fGehRm7
         xaIMplX/lNdnOApNHHYAOijQfVLF3KLLZ2CpQ4pUsliVt7YJ0vZcL8UTOF85M5JS6J/7
         KQEQLJtRc4bWTt5InceduNC6l7ww9JXMW7iz+/aIgqh9e5FPSKAnpT844FzbHXaNi/Lm
         gp9g==
X-Gm-Message-State: AJcUukfURDIsIMkTfG0FLZJYa4Zql038IaahOPKx0ylAsV6HKOheOycJ
        r8PgrTctv4Fu82/UwdI4J8k=
X-Google-Smtp-Source: ALg8bN6l2yIGlhN12+Mo1ehJ5l7MFbYkdNYmddijrzeDBdIw7pycnAeyech1FfEl7xP5nxCl7rcxoQ==
X-Received: by 2002:a1c:1801:: with SMTP id 1mr4670528wmy.153.1548367684178;
        Thu, 24 Jan 2019 14:08:04 -0800 (PST)
Received: from localhost ([2.24.105.63])
        by smtp.gmail.com with ESMTPSA id q9sm169095472wrp.0.2019.01.24.14.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 14:08:02 -0800 (PST)
Date:   Thu, 24 Jan 2019 22:08:01 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 7/8] checkout: introduce --{,no-}overlay option
Message-ID: <20190124220801.GC11293@hank.intra.tgummerer.com>
References: <20181220134820.21810-1-t.gummerer@gmail.com>
 <20190108215225.3077-1-t.gummerer@gmail.com>
 <20190108215225.3077-8-t.gummerer@gmail.com>
 <20190122235313.GA199923@google.com>
 <20190123202156.GA11293@hank.intra.tgummerer.com>
 <20190123204721.GB34357@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123204721.GB34357@google.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/23, Jonathan Nieder wrote:
> Thomas Gummerer wrote:
> > On 01/22, Jonathan Nieder wrote:
> 
> > As checkout is a porcelain command, I had hoped it would be okay to
> > also have this as a configuration option, for the time before
> > 'checkout-paths' exists and while I'm getting used to actually typing
> > 'checkout-paths' instead of 'checkout'.  However I get that there may
> > be scripts that are using git checkout, and expect the previous
> > behaviour, so I'm also okay with dropping the config option for now.
> 
> Yes, if we have no plan for flipping the default later, then I would
> prefer to eliminate the config option.  Scripts very frequently use
> human-facing commands like "git checkout" when they want the command
> to produce (unparsable) friendly output to show to humans, and I don't
> think we've provided a good alternative for that use case.

Ok, I'm happy to drop that for now, and possibly re-introduce that
with another series to start flipping the default.  I'll probably wait
for Duy's checkout-paths command first though, and possibly send a
series later.

Junio, do you just want to revert the patch (1495ff7da5 ("checkout:
introduce checkout.overlayMode config", 2019-01-08)), or would you
prefer me sending a patch for that?

> > If we still want to make this the default even after 'checkout-paths'
> > exists, the plan you outline below sounds good to me, though maybe we
> > can make the "flip the default" step once we decide to release git
> > 3.0.
> 
> I would really like this, so I might write a series for it.  Please
> don't wait for me, though --- feel free to send any patches you're
> thinking about and we can work together or I can just appreciate your
> work. ;-)
> 
> Sincerely,
> Jonathan
