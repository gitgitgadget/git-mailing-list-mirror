Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE95BC43461
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 11:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B12E1208E4
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 11:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgIOLwg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 07:52:36 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:50321 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgIOLvR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 07:51:17 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MALql-1kCKjJ2s9r-00BuAH; Tue, 15 Sep 2020 13:50:26 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id EAC1E1E01E7;
        Tue, 15 Sep 2020 11:50:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wxw1N4sEkUku; Tue, 15 Sep 2020 13:50:25 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (unknown [10.10.5.94])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id AB7EB1E01E6;
        Tue, 15 Sep 2020 13:50:25 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 7A0DE80518; Tue, 15 Sep 2020 13:50:25 +0200 (CEST)
Date:   Tue, 15 Sep 2020 13:50:25 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: sub-fetches discard --ipv4|6 option
Message-ID: <20200915115025.GA18984@pflmari>
References: <20200914121906.GD4705@pflmari>
 <20200914194951.GA2819729@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914194951.GA2819729@coredump.intra.peff.net>
X-Provags-ID: V03:K1:UwrRC+L3CRW1sMoc/OZ1lsyqK1xAU2GEBAwxPIBK5UJQ0hFUO5q
 7AVNk8GJtseyla37DbIW2ElEXqsmi2JVo3Z8HeUXRoG0vqruEHMg59DnfuXRC/S/X9Aw9F+
 +wU4XMvLf5yJe9GPIA6pPEiCPg/bohxvsbMdlvIktFar6BK2tZzPFLWxtlgemVBF2KkSZkZ
 1Mdzl59a3Nx1xlu8KTAPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VifA9/8zrCA=:ePhgK4QB+aSOUIcv/spvfT
 oJUnnuBwlDMHHCULJRz2ZWof7u0SXgu22bFwhldAprdl5uPCK6WKMu0Kt5g2+JBMLKGYZulV8
 cy1GRc1kZ1WaZKgRv279o0EMbcaeqT/ffsMAQYbVL/J2ydq+LZcRTbuRw6aRkMuSH6W0YQiuS
 WXeVRKbLFHXdAmnxQbzZvODW6MVzmBWl3kkBys5clmp+0s3bzVcgFKlRjpcr0BlD/BIw8RTa/
 65wY07EjfzipMa7IRUgYxoLaNhhvA8m6L8/eaag8ZnP8S/Pjm0IyEV3lFBzck0FqGffieYlos
 QwIx7w9hBqagqeTTfx5jj7VnM3bmbzbEnSSWW2CzgKKFSDl5XzZB2bzxPMhxAg2DEahddU0BP
 8ts5BnWK7n4CxCKD5YrQWRVpA8BLV2VnjL+evKmet9rlPl08/nJvdKTc4+B0VbT0UBB06SP0K
 K3M8IoqwCXDOVpR5iuQUkZiqjjisMr06A1hUxWKCnCmCETfNrwtmYFW1nWLV4mmtxbyGR4gzy
 goOXqya7Q0peNwAl8Hu1LlQG9XytzjlTXKx+yVWt17c2hNXbkqETJp9PUfffppbZTYl70BnWy
 zcbeY2OP1ghmcYmNvXbTqXe0RdwlWF30Tb/QJTQW88sKfNXLoy4w/u7KaQbJ4VdP9m+0LAJX0
 jyP6+/agTWDD8W9gE3BR/IXheRMjBqEA7L2KCmX0Gbcmz8zEHfw9uJozkMwlQj8T/GdLDlBzP
 lPWVe19xQ9bAfJxIUYvKQvCOy7aqCKhHPr9T7F13AghLfmE7BXq3afTsL0cle1mvvsJQXq9BM
 8XwVuM3CGDOM8WtTvjMzz8H2V5BJorVO3BWA6OQDjXbe1AghxsEIZ7lLk4Z1lQmz+DeWyqJ/z
 zQak7QhvhkkcxaEhydUA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King, Mon, Sep 14, 2020 21:49:51 +0200:
> On Mon, Sep 14, 2020 at 02:19:06PM +0200, Alex Riesen wrote:
> 
> > Unfortunately, it only worked for the fetches which didn't use --all or
> > --multiple. After a light searching, I failed to find an explanation as to
> > why --all|--multiple are handled so inconsistently with single remote fetches
> > and added the options (similar to --force or --keep) to the argument list for
> > sub-fetches: ...
> >  
> > Am I missing something obvious?
> 
> I don't think so. When we're starting fetch sub-processes, some options
> will make sense to pass along and some won't. The parent has to either
> pass all options and omit some, or explicitly pass ones it knows are
> useful. It looks like the code chooses the latter, but these particular
> options never got added (and it seems like they should be, as they are
> only useful to the child fetch processes that actually touch the
> network).
> 
> So your patch above looks quite sensible (modulo useful bits like a
> signoff and maybe a test, though I guess the impact of those options
> is probably hard to cover in our tests).

I tried to come up with one, but (aside from rather pointless checking of
option presence in the trace output) failed to.

Or may be precisely this could be the point of the test: just do a fetch with
all options we intend to pass down to sub-fetches and check that they are
indeed present in the invocation of fetch --all/--multiple/--recurse-submodules?

> It is rather unfortunate that anybody adding new fetch options needs to
> remember to (maybe) add them to add_options_to_argv() themselves.

Maybe make add_options_to_argv to go through builtin_fetch_options[] and copy
the options with a special marker if they were provided?
And use the word "recursive" in help text as the marker :)

> Also, regarding these two specific options, it sounds like you'd want
> them set for all fetches during the time your IPv6 setup is broken. In
> which case I think a config option might have served you better. So that
> might be something worth implementing (though either way I think the fix
> above is worth doing independently).

Sure! Thinking about it, I actually would have preferred to have both: a
config option and a command-line option. So that I can set --ipv4 in, say,
~/.config/git/config file, but still have the option to try --ipv6 from time
to time to check if the network setup magically fixed itself.

What would the preferred name for that config option be? fetch.ipv?

I'll be sending the first change reformatted as patch shortly. Just in case.

