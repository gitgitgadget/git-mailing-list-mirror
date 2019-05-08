Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF43F1F45F
	for <e@80x24.org>; Wed,  8 May 2019 12:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfEHMgO (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 08:36:14 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35089 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbfEHMgO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 08:36:14 -0400
Received: by mail-it1-f195.google.com with SMTP id u186so3570786ith.0
        for <git@vger.kernel.org>; Wed, 08 May 2019 05:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wt9XjFDU2JBTCwmtwOT+RlrcMwAStHRcOWAVXCPnXi8=;
        b=Yr2xX0cJcOTlj6MqkzXoodX14/1+VETKHiS32Ea1wJPPFdXCL9oOSohi4SZSw/htoN
         2xFggbIiRh0/ZbIYrki/Z8GYJ17J5hnBhRwR4CGqhaxrtYXxkIu3th7d66cxWK6pkccS
         QBk6Rb48eZ/5eQQ/l5PClPzLE4i9aZK16oyTQTpi3bA+Yu5z01lqG0dheYlVREksziZg
         JLch5+MQDjZI4/P9K/hveUPbyIJNLy5BcdHuHc2nGJtlJbFWEXEUNneKYJgodEGRaUYN
         GxjmczNkF0woDLgZA/V/X7N8sTe2RMCvspLYHmU62g2YB4JytjQzdxHQ3uzYLg0KvjZ+
         r/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wt9XjFDU2JBTCwmtwOT+RlrcMwAStHRcOWAVXCPnXi8=;
        b=OVOlavDzdJEswSL44x+OETSTxmGtlrddy0bH+M6aoYs3mMLUcKy0N4S/GRTstupy86
         x679myRdp/+ZH4Foj5YP4dFPFQcjvfvk+YWMXLQWclp9zk30rtDKz/LbCHqbHtwN56MM
         /xkHUCeA0B3Goro5JOd75FpaCoXRHeYsTI0UZfhkHIeBOJL+J+Ea5YqvbgxtuFmrSY7o
         8cStp0ofc1HyjZZS97b1K6mCHwVvevoJu4tPJ3Dtq6/zt3eYvIBmHGeuMZj/555ZbdQH
         CB1e2fFfylG9F7KU/J9AIMjnjN6vjmx81fKkeid4q415WFNQhkcFhfw9JSnc/3VrUCu/
         MqQA==
X-Gm-Message-State: APjAAAX2Fnm4fnvQzHqk1aoDvv9HXai4Mt9wvH9Pc/p+ttGiRSvR58Fm
        Cc4FkdFvQOcXsxWTTKutqsg=
X-Google-Smtp-Source: APXvYqzAN1AC39QQfUVgSKvPf+0PQKU5xQDsiIcNABvMjb5VfCCRLMFt2IFICrJRiUcHDnK/162Cpg==
X-Received: by 2002:a24:3a13:: with SMTP id m19mr2790089itm.88.1557318973689;
        Wed, 08 May 2019 05:36:13 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:740:70fe:227e:c32b:d104])
        by smtp.gmail.com with ESMTPSA id 70sm1155664itz.42.2019.05.08.05.36.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 05:36:12 -0700 (PDT)
Date:   Wed, 8 May 2019 08:36:10 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH] coccicheck: optionally batch spatch invocations
Message-ID: <20190508123610.GA19502@archbookpro.localdomain>
References: <20190503144211.GH14763@szeder.dev>
 <20190503174503.GA8242@sigill.intra.peff.net>
 <CA+P7+xoRGVAP4nHE=neUZGkn9RX_hxN9xVzfWexR79ZWT0ejSQ@mail.gmail.com>
 <20190506051148.GB30003@sigill.intra.peff.net>
 <CACsJy8CLjUdHCro8QJfTozMB0xVWppHuFRSLCvFSaeKO_PxAog@mail.gmail.com>
 <20190506234334.GA13296@sigill.intra.peff.net>
 <xmqq7eb3nfxn.fsf@gitster-ct.c.googlers.com>
 <20190507025501.GA3417@sigill.intra.peff.net>
 <xmqqh8a6n9wv.fsf@gitster-ct.c.googlers.com>
 <20190508070754.GA9195@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508070754.GA9195@sigill.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Wed, May 08, 2019 at 03:07:54AM -0400, Jeff King wrote:
> On Tue, May 07, 2019 at 01:52:32PM +0900, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > Yes, 2^31-1 is probably a better number, but it's harder to write out. :)
> > >
> > > Here's what a patch might look like to implement "0". By still using
> > > xargs in the unlimited code path, it's not too bad. I dunno.
> > 
> > As somebody who is too used to run "diff -U999" and be happy, I
> > cannot claim that I care enough, but the result does not look
> > too bad.
> 
> OK. With two "not too bad" comments (plus my own similar feeling), let's
> just do it. Here it is as a patch on top. It can also be squashed into
> the tip of jk/cocci-batch, but then we should probably s/999/0/ in the
> commit message. :)
> 
> -- >8 --
> Subject: [PATCH] coccicheck: make batch size of 0 mean "unlimited"
> 
> If you have the memory to handle it, the ideal case is to run a single
> spatch invocation with all of the source files. But the only way to do
> so now is to pick an arbitrarily large batch size. Let's make "0" do
> this, which is a little friendlier (and doesn't otherwise have a useful
> meaning).
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Makefile | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index daba958b8f..9cea614523 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1176,6 +1176,7 @@ SP_EXTRA_FLAGS =
>  
>  # For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
>  # usually result in less CPU usage at the cost of higher peak memory.
> +# Setting it to 0 will feed all files in a single spatch invocation.
>  SPATCH_FLAGS = --all-includes --patch .
>  SPATCH_BATCH_SIZE = 1
>  
> @@ -2792,7 +2793,12 @@ endif
>  
>  %.cocci.patch: %.cocci $(COCCI_SOURCES)
>  	@echo '    ' SPATCH $<; \
> -	if ! echo $(COCCI_SOURCES) | xargs -n $(SPATCH_BATCH_SIZE) \
> +	if test $(SPATCH_BATCH_SIZE) = 0; then \
> +		limit=; \
> +	else \
> +		limit='-n $(SPATCH_BATCH_SIZE)'; \
> +	fi; \

Could we pull `limit` out of the recipe and into a make variable? You
mentioned earlier that you wanted to do this but it was too complicated
but now that it's written like this, it seem like it'd be pretty easy to
do.

> +	if ! echo $(COCCI_SOURCES) | xargs $$limit \
>  		$(SPATCH) --sp-file $< $(SPATCH_FLAGS) \
>  		>$@+ 2>$@.log; \
>  	then \
> -- 
> 2.21.0.1314.g224b191707
> 
