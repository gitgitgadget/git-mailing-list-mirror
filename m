Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DA791F462
	for <e@80x24.org>; Mon, 17 Jun 2019 18:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfFQSge (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 14:36:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53217 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfFQSge (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 14:36:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so474813wms.2
        for <git@vger.kernel.org>; Mon, 17 Jun 2019 11:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oMBmdvI1r8YsOy8HRm08HegKV3f6QIk00dtbMKM7Ycg=;
        b=lq/JTx3bZpd6V6PRNP+v1mpVaPfcCbDwT9Hn1FoJDEYLkBXmzqjGE1jzfkvJHR3NdO
         ZVqJ63MdUItJP/ALU8cLCV6Q82RjxCFou6k9f95uE2pREW01tKpkPOnTnX7sJnMYdM07
         6vJkiIPaBRWUnDu/+r42z2Vdbj633l1RyNKl4gwGWTkMPIEhNUti/q/jtuzmw9Etpdvj
         dfZvDN0Yv+69JTxWjh6euHIyDLghxlSBaZkz2dW0Orjj9YJS1aJ8FbpNsCJXRYiY8shd
         RsJOJS4ar5tt6M6a/nrFK0Y+IvNXLLvTEkJ/HFoEyZXaFB7u6JcpOaTSevfMlfwjgLBZ
         aLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oMBmdvI1r8YsOy8HRm08HegKV3f6QIk00dtbMKM7Ycg=;
        b=piMzeph0LmoDoLm8tCCBwkBaOTZpMNPn0M8gVnYbpz5DGvWJWDgcW3/ebWFqKmYm3Z
         yV+lDuJ7S6RlXgPJ0DP57dNMPtlbY3NGm6tC9F5J9r7LrWYcrbbUHFq7FTO8Pzui4GjL
         P9XWlVd7e0ASkgLaB6IIMyoPZY9LsjxfGlIjs6tcaku+WrRGgE56Uz5vCwnHOf/1mFaH
         MfMWql/RaJuUKPK24dMIUdzPxV09PSlOe7YvrjLO6aMWY7jPydwhh38xAjP9fk85cyCd
         nmHbTke8pP71I+LKcLCeKdZR3AM12uK3XcRbeZZGOJ8zN2J5Puams2ybxzABrrXxC/9B
         b0OA==
X-Gm-Message-State: APjAAAVBYY8BqZRFTL1MT4OG1eI0OXvKJNhcvY1pTT4Vs70aHjvsm067
        jsglWtcGWll5/yzN+JjY3tfrAYM1
X-Google-Smtp-Source: APXvYqxB5JwoXm/bLCkPPc6qvDqQ5/+roqSLeNLOPWS3R/yEnm8an9qYIH4CaW2/BOYGfuLhB1vcYg==
X-Received: by 2002:a1c:e90f:: with SMTP id q15mr19012wmc.89.1560796591825;
        Mon, 17 Jun 2019 11:36:31 -0700 (PDT)
Received: from szeder.dev (x4db66496.dyn.telefonica.de. [77.182.100.150])
        by smtp.gmail.com with ESMTPSA id s7sm444568wmc.2.2019.06.17.11.36.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 11:36:30 -0700 (PDT)
Date:   Mon, 17 Jun 2019 20:36:28 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC/PATCH v1 0/4] compat/obstack: update from upstream
Message-ID: <20190617183628.GJ31952@szeder.dev>
References: <20190614095308.GG31952@szeder.dev>
 <20190614100059.13540-1-szeder.dev@gmail.com>
 <bd955bb3-626e-345d-550e-562027c2f7e6@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd955bb3-626e-345d-550e-562027c2f7e6@ramsayjones.plus.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 14, 2019 at 09:30:20PM +0100, Ramsay Jones wrote:
> 
> 
> On 14/06/2019 11:00, SZEDER Gábor wrote:
> > Update 'compat/obstack.{c,h}' from upstream, because they already use
> > 'size_t' instead of 'long' in places that might eventually end up as
> > an argument to malloc(), which might solve build errors with GCC 8 on
> > Windows.
> > 
> > The first patch just imports from upstream and doesn't modify anything
> > at all, and, consequently, it can't be compiled because of a screenful
> > or two of errors.  This is bad for future bisects, of course.
> > 
> > OTOH, adding all the necessary build fixes right away makes review
> > harder...
> > 
> > I'm not sure how to deal with this situation, so here is a series with
> > the fixes in separate patches for review, for now.  If there's an
> > agreement that this is the direction to take, then I'll squash in the
> > fixes in the first patch and touch up the resulting commit message.
> > 
> > 
> > Ramsay, could you please run sparse on top of these patch series to
> > make sure that I caught and converted all "0 instead of NULL" usages
> > in the last patch?  Thanks.
> 
> I applied your patches to current master (@0aae918dd9) and, since
> you dropped the final hunk of commit 3254310863 ("obstack.c: Fix
> some sparse warnings", 2011-09-11), sparse complains, thus:

Oh, indeed.  3254310863 removed that "__attribute__ ((noreturn))" from
the function's definition, but nowadays upstream writes that as
"static _Noreturn void print_and_abort (void)", and I didn't realize
that this _Noreturn is the same thing.

>   $ diff sp-out sp-out1
>   27a28,30
>   > compat/obstack.c:331:5: warning: incorrect type in initializer (different modifiers)
>   > compat/obstack.c:331:5:    expected void ( *[addressable] [toplevel] obstack_alloc_failed_handler )( ... )
>   > compat/obstack.c:331:5:    got void ( [noreturn] * )( ... )
>   $ 
> 
> So, yes you did catch all "using plain integer as NULL pointer"
> warnings! :-D

Heh :)

Anyway, I won't do anything for the time being, in the hope that we
can get on board with removing kwset/obstack...

