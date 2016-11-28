Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B07C1FF76
	for <e@80x24.org>; Mon, 28 Nov 2016 17:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753833AbcK1Res (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 12:34:48 -0500
Received: from mout.gmx.net ([212.227.15.15]:54780 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753647AbcK1Req (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 12:34:46 -0500
Received: from virtualbox ([37.24.142.44]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MGBB1-1bxvYq2gEx-00FA7E; Mon, 28
 Nov 2016 18:34:19 +0100
Date:   Mon, 28 Nov 2016 18:34:17 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming
 builtin
In-Reply-To: <xmqqa8cjlekl.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1611281830040.117539@virtualbox>
References: <20161124210841.c4yi2nv57tjfejgj@sigill.intra.peff.net> <alpine.DEB.2.20.1611242211450.117539@virtualbox> <20161125031809.mueurvjijlnzy2s5@sigill.intra.peff.net> <alpine.DEB.2.20.1611251201580.117539@virtualbox> <20161125171940.rizbqyhsygdsoujr@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611251841030.117539@virtualbox> <20161125174721.f35mzc276kdwakzm@sigill.intra.peff.net> <alpine.DEB.2.20.1611261320050.117539@virtualbox> <20161126161907.xol62zytn2jb45gh@sigill.intra.peff.net> <alpine.DEB.2.20.1611261400300.117539@virtualbox>
 <20161127165058.uxujjehyjq7httro@sigill.intra.peff.net> <xmqqa8cjlekl.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:smdwmXhc4AOr3UOOnLkbSlt46EHSewX/kcRG+XDibmKLAMmbejJ
 MCG7ackSDeR2vDK//Lg68EsLqVg3Ubd2ISF5kpmEfgTsW2L8R+N0NppSBNlQQ8ChIhXyjdl
 SONsE1QG2CZE2+LGSTQWbfPC9qV8UZVzlUOkethozcyirXLl9aY2Dvbu3fPxbp+BTWLo+39
 Fqs1e0Yx0VUApXuJdkfdQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GcBDETK75V0=:5vGBCSVZgmaPYguwaR3cOn
 nX35oOKRbrYLy/F/qFFXEQKIqAvDUjQvFY1uJyAzpqYOZIbdlNS3YpDLh5/i8PWG7nfC71ziG
 vTvjA2RRLGtcnyqGLxw140nvZhXBZGkh/6AwawSnwOipACcw7blb2W7Yq3XOdJ0HpqrOMph5G
 hk2H1gDn/ItaONkrFBrhczT5GhWUFUBQG4BlMP1eL7C2gJ2HwjhVkCihMGlZc9VtOj3Gk8h5Q
 qtONSdheAr2wlRAdcW8cOQxFfh2SNAmTHIJnXMFR5ikLvbTkl+VKMtA7GrgK2Y2jQvFyVYD5d
 86HDONJhlriyore1GtubSH7MvI2du2CIOnca3cs04iqRWZMAQn7Hnz/MGbYwf58kVj6MR7+X7
 ufdTl9UITXclO3idaB8HHhzDLQ+zSC+oWKkf+4eQ4ACnpcj3uLN9xuCpVC+soTm2ncJO/MLwh
 nqtkrDj6VT++jH4NanOChZ7wkxG3dBlsb11toMXhcFSACCdeWmeY0QzUdhumSLXo4oP1/9U3B
 HEK02PaYPRDIfA9VJZ2R+g636RuxQU80EZvQX9jOA0UsvRThk1shrXEGj0uBTDXD0JQuFs1rA
 ylvTVA6jJD15y+TbmBJ9cloo4tknu8YSQ8IzHnq6+RoLKAxa1KrxN7HitGL2PO0Y8YCPDs/ls
 pUnvlLC50zm6hkutAH/oF0ZherWo1zgWT5x1Ppv/RRMqEwHuQanMcLPzWAZK4V2TThG+bZplp
 AXVAB/Q4aem3Syasl1VpKCFg/VP6y9io6BqpCnh+Usaln85va2/ln82CPcZPqK8skBtTSAULU
 aPbO/Cn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 28 Nov 2016, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Sat, Nov 26, 2016 at 02:01:36PM +0100, Johannes Schindelin wrote:
> >
> >> > If you want to control it from outside the test script, you'd need
> >> > something like:
> >> > 
> >> >   if test "$GIT_TEST_DIFFTOOL" = "builtin"
> >> 
> >> That is a bit magic. I first used "GIT_USE_BUILTIN_DIFFTOOL" and it did
> >> not work. My name is arguably more correct (see also Jakub's note about
> >> "naming is hard"), but yours works because there is a "TEST" substring in
> >> it.
> >
> > Yes. You are free to add an exception to the env list in test-lib.sh,
> > but we usually use GIT_TEST_* to avoid having to do so.
> 
> Perhaps
> 
>  - The switch between "do I use builtin, or scripted?" mechanism in
>    1/2 can look at an environment (just like the old "am" rewrite
>    series did), instead of configuration.  This would make the code
>    a lot more simppler (you do not have to worry about the
>    interaction between "setup" and .git/config).
> 
>  - That environment variable can be named GIT_TEST_BUILTIN_DIFFTOOL;
>    after all, people are opting into helping to test the new shiny
>    to make/prove it ready sooner.
> 
>  - The bulk of the existing test for difftool can be moved to a
>    dot-included file (in a way similar to t/annotate-tests are
>    usable to test both annotate and blame-imitating-annotate).
>    Existing PERL prerequisites can all be lost.
> 
>  - Two tests can include that dot-included file; one would
>    explicitly unset that environment (and gives up without PERL
>    prerequisite), while the other explicitly sets it.

If my main worry was the test suite, I would agree with this plan.

However, I have been bitten time and again by problems that occurred only
in production, our test suite (despite taking already waaaaaay too long to
be truly useful in my daily development) was simply not good enough.

So my plan was different: to let end users opt-in to test this new beast
thoroughly, more thoroughly than any review would.

And for that, environment variables are just not an option. I need
something that can be configured in a portable application, so that the
main Git for Windows installation is unaffected.

My original "create a file in libexec/git-core/" was simple, did the job
reliably, and worked also for testing.

It is a pity that you two gentlemen shot it down for being inelegant. And
ever since, we try to find a solution that is as simple, works as
reliably, also for testing, *and* appeases your tastes.

Ciao,
Dscho
