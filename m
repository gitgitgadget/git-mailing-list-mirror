Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40A781FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 20:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756530AbcK2UhX (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 15:37:23 -0500
Received: from mout.gmx.net ([212.227.17.20]:60060 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755690AbcK2UhW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 15:37:22 -0500
Received: from virtualbox ([37.24.142.44]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LiDHj-1cXwPT0NcZ-00nOqJ; Tue, 29
 Nov 2016 21:37:12 +0100
Date:   Tue, 29 Nov 2016 21:36:55 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming
 builtin
In-Reply-To: <xmqqa8cjjtfn.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1611292128340.117539@virtualbox>
References: <20161124210841.c4yi2nv57tjfejgj@sigill.intra.peff.net> <alpine.DEB.2.20.1611242211450.117539@virtualbox> <20161125031809.mueurvjijlnzy2s5@sigill.intra.peff.net> <alpine.DEB.2.20.1611251201580.117539@virtualbox> <20161125171940.rizbqyhsygdsoujr@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611251841030.117539@virtualbox> <20161125174721.f35mzc276kdwakzm@sigill.intra.peff.net> <alpine.DEB.2.20.1611261320050.117539@virtualbox> <20161126161907.xol62zytn2jb45gh@sigill.intra.peff.net> <alpine.DEB.2.20.1611261400300.117539@virtualbox>
 <20161127165058.uxujjehyjq7httro@sigill.intra.peff.net> <xmqqa8cjlekl.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1611281830040.117539@virtualbox> <xmqqa8cjjtfn.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9gyBqffq1PDgFgRbYl20tPmgK4QjdPmSJK8QIxwSX98gtxkSklf
 Zxrg8Nz8suJppSy5sDayVk0QMO03D2XmN++QGAbSRpqe0L0FUI5BtDGmio4/54YiyF+u3Tq
 r3gy/gORAcEiQqTtPiyvv6wacCv2whpi+e+CB35HtcPBCgbEWKKSZj2QmUPmsml6QlOvGle
 3JNnvhy5TYkJlN3s8yg3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:up1AHnI3iXY=:nxVBrcWYQMZmqmKfeH02iF
 KjySPTNQTNi6x+b5NV7nEG0Y9IFClfJsD2gXg3S8RJZFTikAKXAOJR/o1dTgBzzaXH3m/PjWP
 zNuTg+6oaCe+o45ZGfkCBe09NRm7aXA2y5TLg2oc7pI5w96r/75x3vJh8s248qMkS4PBqeHxX
 hTYxxHYvO/3fPDHlUkwS7xMWeHpPPEvi7TtyRAVV79GKvFdtwqZL+fTiE+b6tGBCXJDxkwGjA
 sBxroaf5kn0lf6SfApjFr3pvHxc47tX/NIWQ2yHQnh8voeMe6A4OL9jbWStSE797f9k+F3IAP
 /yboAq3B96LRVJQN2UQzpBsPUOemgJ/2na4qeFIjpPd4t8o+IT9kkIvZA7WNw2kga/rih+Wk/
 /gxVVZOcCKH7SnhHEsO+0kzd4IpQon8bH/SR5Wd50wewGagsyGC8Z/nPUx2I7/OaG8OYgKmWZ
 tLj//Y00vYq+gy3tK4QIMsuCjxw9jVOxguhIMEc6o7wwU9VNHD5AiUFpmS0mAwPBKstOMlTBT
 ZStCodcxSRmupVgWr6dolQPGIJSirKH8HcRyriDQDA31PFK4kK3y1dvH9+EXC13PLm3z3RE+I
 drcxgq5qNy9asZIlQIJO+SJUcHq4LqJO6hVMROBQtJapv94W55uNx+71YD3yk3J4d5rmPdpds
 9i3DCNWtQ11h3VqTvo+w+7E3uNeBGc1dhrc1Y5bZZLCLdVD9HMdFHVri8rgyIMUX4TOa6f4DP
 JjTGXxH+gyODeNqZRZG1uJapJbvgAipl4/fFP+CGc4VNjX/aPUay39apWikOgwXAZDajHPk/x
 2J4W6ko
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 28 Nov 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > However, I have been bitten time and again by problems that occurred only
> > in production, our test suite (despite taking already waaaaaay too long to
> > be truly useful in my daily development) was simply not good enough.
> >
> > So my plan was different: to let end users opt-in to test this new beast
> > thoroughly, more thoroughly than any review would.
> 
> I agree with that 100%.  
> 
> [...]
> 
> > And for that, environment variables are just not an option. I need
> > something that can be configured in a portable application, so that the
> > main Git for Windows installation is unaffected.
> 
> I am not sure I follow here.  
> 
> Are you saying that the users who are opting into the experiment
> will keep two installations, one for daily use that avoids getting
> hit by the experimental code and the other that is used for testing?

I have obviously done a real bad job at explaining the Windows situation
well enough.

Many, many users have multiple installations of Git for Windows. If you
have GitHub for Windows and installed the command-line tools: you got one.
If you installed Git for Windows, you got another one. If you installed
Visual Studio, chances are you have another one. If you got any number of
third-party tools requiring Git functionality, you have another one.

They all live in separate directories that are their own little pseudo
Unix root directory structures, complete with etc/, usr/, var/.

Users do not necessarily keep track, or for that matter, are aware of, the
multiple different installations.

Obviously, I do not want any installation other than the one the user just
installed to pick up on the configuration.

So the suggestion by both you and Peff, to use an environment variable,
which is either global, or requires the user to set it manually per
session, is simply not a good idea at all.

> > My original "create a file in libexec/git-core/" was simple, did the job
> > reliably, and worked also for testing.
> 
> It may have been OK for quick-and-dirty hack during development, but
> I do not think it was good in anything released.

Well, you say that it is quick and dirty.

I say it is the only viable solution I saw so far. All proposed
alternative solutions fall flat on their bellies, simply by not working in
all the cases I need them to work.

As I said elsewhere: I look for a correct solution first, and then I
thrive to make it pretty. You start the other way round, and I do not have
time for that right now.

Ciao,
Dscho
