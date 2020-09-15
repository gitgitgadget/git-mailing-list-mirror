Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B94C433E2
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 14:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DE4D206A1
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 14:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgIOOHL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 10:07:11 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:52645 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgIOOGs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 10:06:48 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MGygv-1kEf630vDf-00E7k7; Tue, 15 Sep 2020 16:06:16 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 4AEA31E01E7;
        Tue, 15 Sep 2020 14:06:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Os7pgqBRV8By; Tue, 15 Sep 2020 16:06:14 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (unknown [10.10.5.94])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id 06A851E01E6;
        Tue, 15 Sep 2020 16:06:13 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id D32AC80518; Tue, 15 Sep 2020 16:06:13 +0200 (CEST)
Date:   Tue, 15 Sep 2020 16:06:13 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: sub-fetches discard --ipv4|6 option
Message-ID: <20200915140613.GB18984@pflmari>
References: <20200914121906.GD4705@pflmari>
 <20200914194951.GA2819729@coredump.intra.peff.net>
 <20200915115025.GA18984@pflmari>
 <20200915130506.GA2839276@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915130506.GA2839276@coredump.intra.peff.net>
X-Provags-ID: V03:K1:eq547BLef0MHKlHF0itJbTgscEKRQfXl1vlpBvcMvbV8D6jaT7h
 lPUc0aFoslpIdEn6crvc/QbpDxUeJLPsTM9QA8bHgsrdFDbW9y5X4A9LoLzn3t27zAMbWvC
 imipkbzMfpZSOrvTg/7rquaHLgB+BfNaf3gaNdd604x69PCowkQshJUiTOq6VKr1k/K7v3d
 I+ecNYyDtq3FNAz0EzC1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kMxK7U/ZeiI=:RfW8yYzKaFPVZrhzwhoN8l
 1HRpC6UOhMmE+xSzTGNXIYn7jFngKWpXB6d1zEgs22eFMKI+Xo2vvi6NXHYYPOkQD7PWNUugZ
 K43KukJAMh5Al9gN2WUNqCtdg3w6zOG+n+4bR3hbvZ5cI6Qf8oaI1BDlzDj7ftpn4fnOWFkZK
 77K1DEZAuIyey+qQqbncaB4Fn9T6SlqZj3yW/WBNMVqRKvLP4qSNoFHWZ7Rdt8igivv9lHgh9
 KpdctcG8wttHwBgv4snxkYNN8FrvqmKQA9faoN+NiklaOqQybLj6rrS7o7/deY1G63SpKCB6R
 aXlRrCMRG16t99Wf9vu6zRE5OpA8CN0aLGKh16KAQnZglxTUeuWXxduDNCYYEAqEcI78RYPxD
 x+/TyD6ueZRgioebM8Qhu7QbPYR4ZqwWFE5TuLI7NV5eL0+Qo9LsHREQ7rAAgRGwPHCdxAwiu
 +kAjw1HwynfXLMtztw2M8SH8DC4gU2dEkTXRQNtaKQpgodx0CP84Ik/Ry4PnzezLJ2HIicFKX
 nY1Bpjx4GXyvHLccFHbTZr0e6PuhK1gyP6g0bJDhkZEWXoxyCVNvy9oqP0noqN0Yu0tp7csh1
 sBLD5Sc/g1wKGu5w/U3b5i4MaIies039qQT9bEh0sTkGl9vEq3zJHJKlaX5LGsjQEvmUhDJNj
 BPYqCfZ3LLIEBejU3XR2dzHZas/ttvT6yflBGHDzDDF0cDC4GsXF9sfKvqs9b24MtiYfKRY8/
 nQjN/ucRLF66Is1ww2voaaK46+pGLQ5+M7fcGpgN/QuD2IpEgVr7ajtY/gUlVGVbhf92whk+H
 kAs2r9vqfcUXXJoXMU9t8cYlK6td/vXINbJLzN1VsZ9VKg3UkrgG5ASC3vFOsoSFbxGvkgmnr
 bftWwJVNfUgQPhwhe+oQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King, Tue, Sep 15, 2020 15:05:06 +0200:
> On Tue, Sep 15, 2020 at 01:50:25PM +0200, Alex Riesen wrote:
> 
> > > So your patch above looks quite sensible (modulo useful bits like a
> > > signoff and maybe a test, though I guess the impact of those options
> > > is probably hard to cover in our tests).
> > 
> > I tried to come up with one, but (aside from rather pointless checking of
> > option presence in the trace output) failed to.
> > 
> > Or may be precisely this could be the point of the test: just do a fetch with
> > all options we intend to pass down to sub-fetches and check that they are
> > indeed present in the invocation of fetch --all/--multiple/--recurse-submodules?
> 
> Unfortunately I don't think that accomplishes much, since the main bug
> we're worried about is missing options. And it would require somebody
> adding the new options to the test, at which point you could just assume
> they would add it to add_options_to_argv().
> 
> Though I guess we can automatically get the list of options these days.
> So perhaps something like:
> 
>   subopts=
>   for opt in $(git fetch --git-completion-helper)
...
> Except that doesn't quite work, because the parent fetch will complain
> about nonsense values (e.g., --filter=1). So it would probably need a
> bit more manual intelligence to cover those options. It looks like some
> options are mutually exclusive, too (--deepen/--depth), so maybe we'd
> need to run an individual "fetch --all" for each option.
> 
> I dunno. It's getting pretty complicated. :)

It does :-( And the manual parts will require perpetual maintenance.
Not doing that yet than.

> > > It is rather unfortunate that anybody adding new fetch options needs to
> > > remember to (maybe) add them to add_options_to_argv() themselves.
> > 
> > Maybe make add_options_to_argv to go through builtin_fetch_options[] and copy
> > the options with a special marker if they were provided?
> > And use the word "recursive" in help text as the marker :)
> 
> Yeah, that would solve the duplication problem. We could probably add a
> "recursive" bit to the parse-options flag variable. Even if
> parse-options itself doesn't use it, it could be a convenience for
> callers like this one. It is a little inconvenient to set flags there,
> just because it usually means ditching our wrapper macros in favor of a
> raw struct declaration.

Or extend the list of wrappers with _REC(URSIVE) macros

Regards,
Alex
