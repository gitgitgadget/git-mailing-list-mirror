Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E54FC1F731
	for <e@80x24.org>; Sun,  4 Aug 2019 11:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfHDLB4 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 4 Aug 2019 07:01:56 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:58622 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfHDLB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Aug 2019 07:01:56 -0400
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:33e:2802:50eb:d77d])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 4A3A42003BE;
        Sun,  4 Aug 2019 13:01:52 +0200 (CEST)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v2] l10n: reformat some localized strings for v2.23.0
Date:   Sun, 04 Aug 2019 13:01:51 +0200
Message-ID: <5200616.dDItsc6b64@cayenne>
In-Reply-To: <20190803234522.GA5417@sigill.intra.peff.net>
References: <20190730033512.7226-1-worldhello.net@gmail.com> <20190803195907.3124-1-jn.avila@free.fr> <20190803234522.GA5417@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sunday, 4 August 2019 01:45:22 CEST Jeff King wrote:
> On Sat, Aug 03, 2019 at 09:59:07PM +0200, Jean-Noël Avila wrote:
> 

> > -			   N_("where the checkout from")),
> > +			   N_("where the checkout is from")),
> 
> I think your original "where to checkout from" is better.
> 
> As a native speaker, "where the checkout is from" implies that checkout
> is a noun that is being described. But I think we want checkout to be a
> verb (because we are talking about the operation), and the option tells
> Git how to do that operation.
> 
> (I agree the original "where the checkout from" is nonsense).
> 


Oh. OK.

> > diff --git a/builtin/fetch.c b/builtin/fetch.c
> > index 53ce99d2bb..0e8760e5d4 100644
> > --- a/builtin/fetch.c
> > +++ b/builtin/fetch.c
> > @@ -850,6 +850,15 @@ static int iterate_ref_map(void *cb_data, struct object_id *oid)
> >  	return 0;
> >  }
> >  
> > +static char warn_show_forced_updates[] =
> > +N_("Fetch normally indicates which branches had a forced update, but that\n"
> > +   "check has been disabled. To re-enable, use '--show-forced-updates' flag\n"
> > +   "or run 'git config fetch.showForcedUpdates true'.");
> 
> This one isn't a typo fix, right? It's just putting the two warning()
> calls into a single message. I can see how this would be useful for
> translators, but note that the output will be different. The original
> would be something like:
> 
>   warning: Fetch normally indicates...
>   warning: To re-enable...
> 
> where now we'd get:
> 
>   warning: Fetch normally indicates...
>   check has been disabled...
>   or run 'git config...
> 
> which might be a bit harder to read because the wrapped lines lose the
> prefix. For advise() we nicely pick out the newlines and prefix each
> line individually, but warning(), error(), etc, don't do that. Maybe
> they should.
> 
> That's too big for this late in the -rc cycle, I think. In the meantime,
> I'm not sure which (the original or your patch) is the least-bad
> solution. :)
> 
> This change (if I am right that there's no actual typo fix) should
> perhaps be in a separate patch from the earlier hunk, though.
> 
> -Peff
> 

This one is not about typos.

My original fix was more concerning the second sequence, where the sentence is broken in the middle, simply for better rendering but this does not make sense either, because the lines are too long anyway.

I guess that in most languages, a sentence can be broken into two propositions by a coordinating conjunction, but it may not match the English structure.

Is it so important that the lines of warning all start with a "warning:" prefix?

JN


