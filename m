Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53505C43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 14:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2460A2223D
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 14:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbgIQOiC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 10:38:02 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:45157 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbgIQOew (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 10:34:52 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N1Oo7-1kT8DF0y8B-012laJ; Thu, 17 Sep 2020 16:33:42 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 7CB9A1E01E7;
        Thu, 17 Sep 2020 14:33:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mfDz7Y1eM7uc; Thu, 17 Sep 2020 16:33:40 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (unknown [10.10.5.94])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id 29F101E01E6;
        Thu, 17 Sep 2020 16:33:40 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id F2C0C8051A; Thu, 17 Sep 2020 16:33:39 +0200 (CEST)
Date:   Thu, 17 Sep 2020 16:33:39 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: sub-fetches discard --ipv4|6 option
Message-ID: <20200917143339.GF8079@pflmari>
References: <20200914121906.GD4705@pflmari>
 <20200914194951.GA2819729@coredump.intra.peff.net>
 <20200915115025.GA18984@pflmari>
 <20200915130506.GA2839276@coredump.intra.peff.net>
 <20200915140613.GB18984@pflmari>
 <20200915152730.GA2853972@coredump.intra.peff.net>
 <20200915160357.GC18984@pflmari>
 <20200916163218.GA17726@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916163218.GA17726@coredump.intra.peff.net>
X-Provags-ID: V03:K1:fKRynWd9Iauha2DUeDiVCPdKPdw6W0CEOJ/aYDLGIm6+QLtKGH5
 Uvy947sXKi5sV9zomLI9i8wTWTJqWVKNh7jn3hNOhWBQSwVjeEXv6Nq3LHRhd965uqjhase
 hwUiDTWImp20MFy5bX4U+Yxtkw/+/DWECXxMFQNXD/lSnqJ4u+479stlLRzlwDMhBITC5Xc
 Z30OrcsqlTopCB39vdvlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CaSn4u/Kabg=:p0n7t6Fyk6yImRtz9t4KzS
 DukDIfRvLFO06D2OjGpSoITlTLYLqgGSm6t+O+K0Yeqhi3i/s1LR+hooG/BDpiUECxPxlT6yT
 58G+lKGlf2cf6tct0cwIwa8NAfZmie3UqYxZ2UQZeWOZDshQX0qsQtAmpgCkg/mMc2mFeWKg8
 mtX2XVaNXBbU9ImXrM56nrJPcKkjTxYjrZEqxmccsnGJyFrDegdwizD6e4Dm13A0ew8lSz7zG
 AsbNa58/69TCdLzdgBD9xXSyRhqtQvzNiwFw9CyS+fN03pUSqPhfWS8+HkwnczYKPgK0u4/mU
 h584uci0fHm1JfYrYW94Gx/8B77PGuOQCUJ4rMDhxfEXV7s7Cz896lcofQ7t81qCm0yARPBGJ
 S+oBzDsukaOyrlPpEcadNs+wPKTLFDwrvrK+xmt5gSytNeQv6Eu0rY+GvHrv8hPeb3X8uyMDZ
 GgDo7noX/MUMFBKrTNFgf34Mo18OCQ2jGNGoWpep6tMEuE6sAIMwv2v5wb8Gd92ZqVzLi6tCt
 axH77pH+rjdDHptIiYIAwYLFGNpJtJH/63FQKbpEKUZ2SZg0V2F+c0IBgtZlEPtzKZWE1jGkU
 CIi3y7Zi3gr5WPYblp/aN+7991ljQH1/dUuIlVlXLKn1r7QYsl+JAa3LIswLYKj8FIuI3aaGc
 Mj3rbaEYli67deGH8wAoJ6PMUo+ivW6/fHenxhAwp0/sE/olY3J2zwmgfzVK/a5YKzbkiqPBx
 g0+9crWtMZLwe++XMiGivdpWfj6MkplA5CGxptQAAuUGETTmIefZdE3RfJNJ8I2/95+7/a++E
 8QdIMw1zXVBgW+KRFHN0LlhhHwnizWeCc+Ga8XnMlmlaCeoTkBhCe4GVDNtyFnUQsiz26/ZRv
 FZvZK4KDvm7r09rNY01A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King, Wed, Sep 16, 2020 18:32:18 +0200:
> On Tue, Sep 15, 2020 at 06:03:57PM +0200, Alex Riesen wrote:
> 
> > > If you go that route, we have some "_F" macros that take flags. Probably
> > > would make sense to add it more consistently, which lets you convert:
> > > 
> > >   OPT_BOOL('f', "foo", &foo, "the foo option");
> > > 
> > > into:
> > > 
> > >   OPT_BOOL_F('f', "foo", &foo, "the foo option", PARSE_OPT_RECURSIVE);
> > > 
> > > but could also be used for other flags.
> > 
> > This part (marking of the options) was easy. What's left is finding out if an
> > option was actually specified in the command-line. The ...options[] arrays are
> > not update by parse_options() with what was given, are they?
> 
> Oh right. Having the list of options is not that helpful because
> add_options_argv() is actually working off the parsed data in individual
> variables. Sorry for leading you in a (maybe) wrong direction.
...
> > Or is it possible to use something in parse-options.h API to note the
> > arguments somewhere while they are parsed? I mean, there are
> > parse_options_start/step/end, can cmd_fetch argument parsing use those
> > so that the options marked recursive can be saved for sub-fetches?
> 
> Possibly the step-wise parsing could help. But I think it might be
> easier to just let parse_options() save a copy of parsed options. And
> then our PARSE_OPT_RECURSIVE really becomes PARSE_OPT_SAVE or similar,
> which would cause parse-options to save the original option (and any
> value argument) in its original form.
> 
> There's one slight complication, which is how the array of saved options
> gets communicated back to the caller. Leaving them in the original argv
> probably isn't a good idea (because the caller relies on it having
> options removed in order to find the non-option arguments).
> 
> Adding a new strvec pointer to parse_options() works, but means updating
> all of the callers, most of which will pass NULL. Possibly the existing
> "flags" parameter to parse_options() could grow into a struct. That
> requires modifying each caller, but at least solves the problem once and
> for all.

With such complication a step-wise parsing sounds easier, given that at the
moment there is only one user for the feature. Are there *existing* callers
of parse_options with similar requirements?

I feel that doing this kind of selection work in parse_options is an overkill:
if it is specific for just this use case, the implementation might be more
complex than necessary, while profiting just one caller.

> Another option is to stick it into parse_opt_ctx_t. That's used only be
> step-wise callers, of which there are very few.

Does that mean that currently there is no way to find out which option
corresponds to the last parsed command-line argument after a call to
parse_options_step? Which in turn makes the marking of recursive options
inaccessible to step-wise command line parsing code, right?

