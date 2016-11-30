Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 345281FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 12:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755408AbcK3MaY (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 07:30:24 -0500
Received: from mout.gmx.net ([212.227.17.20]:58235 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755146AbcK3MaR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 07:30:17 -0500
Received: from virtualbox ([37.24.142.44]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LeSOH-1cUxRg3obN-00q9go; Wed, 30
 Nov 2016 13:30:06 +0100
Date:   Wed, 30 Nov 2016 13:30:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming
 builtin
In-Reply-To: <xmqqshqadn0f.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1611301325210.117539@virtualbox>
References: <20161124210841.c4yi2nv57tjfejgj@sigill.intra.peff.net> <alpine.DEB.2.20.1611242211450.117539@virtualbox> <20161125031809.mueurvjijlnzy2s5@sigill.intra.peff.net> <alpine.DEB.2.20.1611251201580.117539@virtualbox> <20161125171940.rizbqyhsygdsoujr@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611251841030.117539@virtualbox> <20161125174721.f35mzc276kdwakzm@sigill.intra.peff.net> <alpine.DEB.2.20.1611261320050.117539@virtualbox> <20161126161907.xol62zytn2jb45gh@sigill.intra.peff.net> <alpine.DEB.2.20.1611261400300.117539@virtualbox>
 <20161127165058.uxujjehyjq7httro@sigill.intra.peff.net> <xmqqa8cjlekl.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1611281830040.117539@virtualbox> <xmqqa8cjjtfn.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1611292128340.117539@virtualbox>
 <xmqqshqadn0f.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:DaxQKn49ExxUU/ItGxGHk5knnStIlA8UXAhFk4aMZ1BbI5K79pt
 4wAUjy4rEc6kU7lCQlHyPu4VB/LcaGrnxbzekiGIiDqMtYTm9junIQP+kNf3/1ZNMMJ1nN/
 TXF9qQHt8gqsKjlNUcmJfITP9u8W3d4q/TB5rX3UzKVmB05hL3C3Qa3AAVxlzCM3kONabIp
 lqpD/mT2MZLF97G2QeEMA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CwfytGGyeMU=:PDToUOBZ6wXBd67enCLrkl
 VTb3JfFtRJsHbhdh96azqPUGbm9MwLTYfFjpPPa6S0s4KTIPg9ngf2X0b0Gn3bsB20tEDhdXy
 Ih74iz8nJd2thuAu4j5yVuLieMiqq0/OroEMmOKF6lWJobK/9+cH6DxBuvMdVq76wQj1nR6TP
 IGmMV2LbRVm8+4UVlacWtZnziGOL18sN7xr+xA5oPWhcw9UNHlOXOh50BTNme3MlnomTeNEGA
 SVN5ndiV5yGrNcKrGlE2X+IBQiGkfx88u22vj0L2kuSw604dshoEDS4tHDemAINu4UoidsrBK
 zm77ry4CETZeu6uK9GaJAvZTD74cMYBnZ6JMYanNF5MyguJrZ+pzX12pnXgBV0+U4FjN4KFGY
 /6+CuPqN3QW0coLctAK6SfRMTP15ZUoKbrR3m1vVZxJxAefP/bnPE3fcwL7Ab3PVVVI+b4+dQ
 +RJaRP3KMvOHWdN0W8dHXZLYEn2KHGC9fFKEmHW8CHWzwzUV2zqcIyUYVcJVIM+/cZbasOShu
 Lpk/1x9H8ly/ZfgS8KMLlxVvmmwNGNb0MRKs6cyaHbkoGogoswml37g4gBq7qYKRyzfCYYibQ
 LseLC4h7Ft+VPyhNM8bXGXDPnj8ddcu5OYJL/Eu7KKzzcJcPnrDafFkepTOMAR1MHOI3E00Di
 nsLdcjTH4PIlz664p3puYMDazJ/0LfxUL61InTSM7aOALWdIjm7GkQMc4JQP0b+yTUSnvR7uk
 jisc8wx5QVdmMEw/6kfpfSecYVXmnHRHnmIrzc17FRLgTZUkUhPmYkUubGOB7b9qEdZFYoGff
 hdjf1sA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 29 Nov 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > So the suggestion by both you and Peff, to use an environment variable,
> > which is either global, or requires the user to set it manually per
> > session, is simply not a good idea at all.
> 
> As I already said, I do not have a strong preference between config
> and env.  I raised the env as a possible alternative that you can
> think about its pros and cons, and as I already said, if you thought
> and your concluded that config would work better for your needs,
> that is fine by me.

The env flat out fails, on the grounds of not integrating nicely into a
Git for Windows installer.

The config kinda works now. But for what price. It stole 4 hours I did not
have. When the libexec/git-core/use-builtin-difftool solution took me a
grand total of half an hour to devise, implement and test.

And you know what? I still do not really see what is so bad about it.

And I still see what is bad about the config "solution": it *creates* a
chicken-and-egg problem with the order of config reading vs running
scripts. It *creates* problems for requiring to spawn a `git config` call
because reading the config in-process would mess up the global variables
and environment *beyond repair*, making it *impossible* to even spawn the
git-legacy-difftool Perl script.

In short: the config setting now works. But it is ugly as hell. I wish I
never had listened to you.

Ciao,
Dscho
