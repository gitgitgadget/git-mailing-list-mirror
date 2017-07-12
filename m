Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 605C8202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 18:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbdGLSGH (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 14:06:07 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36202 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbdGLSGG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 14:06:06 -0400
Received: by mail-pf0-f180.google.com with SMTP id q86so16589194pfl.3
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 11:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ma7U3/NGJ7s8sPAxJyWCz8jAiQ6TDO4qDXAuhe+FzAk=;
        b=YmoQTNAs9WLRAs7STijBDPsnMOGlfOhpYkbwU15Q/KYDusC/CK4GuE7hSjl9hGSYvq
         XNpJy9/E26hydgZeEuttVaPTOBPrVMMGNUltEvi2EK1cSCUCqYuaBtIP47DtEB4zQFXu
         cBEsDeyH8EJ+JHsGPhfyJpF2Dv2GVKToOFx/tpvaKz30vt9YXhEI7McMote8F2YssJZM
         SE4tAcCkWXkYCHWB0BkjeH18lKDjP8U4lkpW7S6Rsa+yX00m3zGMOp4rfxE3xc5uuRC9
         AXtlrgv49t3SuPZyIrA2N3K/HSn2GYYcwemfbJvdkaPig7tRu6+i0HqQoJ10PiOS+G1D
         aR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ma7U3/NGJ7s8sPAxJyWCz8jAiQ6TDO4qDXAuhe+FzAk=;
        b=ZJnTIjShnvli0EZQznDDmrGDk3r8qAcRMUjiH8paBZh8aTD6Y0qFnqtZRdCDWrzeoZ
         r05FYHnZyAIAq1mnHe4EvXLp2+zA5f407FXMGm4dmfU+3fqgkAIrHs6c+wHdntJpaEHB
         DNEEm49Y2h0aJu52lenjoEUh/6FKhdfCxdQ4UxkJ8oi8nBStRds1RizUWEScT//Qoi+l
         d6kCWoQp4dBzBIgwVjUIC/S59X6nmBelY9Ac4dVnZpS4B2I89wQPJZhi0P3VsFnWTF5W
         dKR+00xzeKidz1lqCtGzwmJbTb+aNBhUPlsxbyIIbJMk3RLF9GxxTwSWiHLB3mRIJJjv
         438w==
X-Gm-Message-State: AIVw113o1qU6dhVUoPB4nPKLsOxqf2m6nak/dkeslkDWFBLo4y0+LLds
        hRubP/XqVgg3ryRF
X-Received: by 10.99.95.147 with SMTP id t141mr4991833pgb.263.1499882765646;
        Wed, 12 Jul 2017 11:06:05 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:3d1f:bb9:8897:56b4])
        by smtp.gmail.com with ESMTPSA id t83sm5846805pfg.91.2017.07.12.11.06.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 11:06:04 -0700 (PDT)
Date:   Wed, 12 Jul 2017 11:06:03 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 0/3] Convert grep to recurse in-process
Message-ID: <20170712180603.GE65927@google.com>
References: <20170711220408.173269-1-bmwill@google.com>
 <20170712074220.565z3gahruqb2e7q@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170712074220.565z3gahruqb2e7q@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/12, Jeff King wrote:
> On Tue, Jul 11, 2017 at 03:04:05PM -0700, Brandon Williams wrote:
> 
> > This series utilizes the new 'struct repository' in order to convert grep to be
> > able to recurse into submodules in-process much like how ls-files was converted
> > to recuse in-process.  The result is a much smaller code footprint due to not
> > needing to compile an argv array of options to be used when launched a process
> > for operating on a submodule.
> 
> I didn't follow the rest of the "struct repository" series closely, but
> I don't feel like we ever reached a resolution on how config would be
> handled. I notice that the in-process "ls-files" behaves differently
> than the old one when config differs between the submodule and the
> parent repository. As we convert more commands (that use more config)
> this will become more likely to be noticed by somebody.
> 
> Do we have a plan for dealing with this? Is our solution just "recursed
> operations always respect the parent config, deal with it"?

Each 'struct repository' does have its own config so we could
potentially want a config in a submodule to override some config in the
superproject.  Though for right now it may be simpler to not worry about
doing this overriding, mostly because you would only want to allow
overriding of some configuration and not all configuration.  One example
would be the number of threads allowed in grep, it doesn't make much
sense to let a submodule's configuration of this to trump the
superproject's since the command was invoked in the context of the
superproject.

-- 
Brandon Williams
