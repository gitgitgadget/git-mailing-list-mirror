Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B8AF207EC
	for <e@80x24.org>; Tue, 11 Oct 2016 09:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752585AbcJKJq3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 05:46:29 -0400
Received: from mout.gmx.net ([212.227.15.15]:52449 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753063AbcJKJpI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 05:45:08 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MaIsi-1baAuK2ndY-00JrRq; Tue, 11 Oct 2016 11:44:52
 +0200
Date:   Tue, 11 Oct 2016 11:44:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
In-Reply-To: <20161009205854.byq2wqgemtmwudfb@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1610111142490.35196@virtualbox>
References: <20161006114124.4966-1-pclouds@gmail.com> <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1610071319520.35196@virtualbox> <CACsJy8ASc7Fxm5XDHFiX9E+bQ8s1MtmEHfc7bZY4C-_GEQr0og@mail.gmail.com> <0347de20-72a7-b384-389f-4b2ad5789973@kdbg.org>
 <20161007175052.sxyk7y2ytjh36phr@sigill.intra.peff.net> <alpine.DEB.2.20.1610081034430.35196@virtualbox> <20161009060149.voqjoiltqi6jub7g@sigill.intra.peff.net> <CACsJy8BpYYJmBm32YsQyuP58uhLE+sn8WdhiHyY6xzcqPVjMVQ@mail.gmail.com>
 <20161009205854.byq2wqgemtmwudfb@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:JKscRPjlokbB3fj6FEoQZrTw2UgISh/8kdND9kmEABGv9d/LFNO
 hPHjH5xb/HWECklzsrBvhNsaGmaxPAUGSLP0UH055L7j2sekEIGeiRwzuWwPUsdgn2mM56d
 wz0CY/jxF4KahoQV1njCgzlgIIR5HMc6LHfFvoevwdApJiPcs/IKeI/07cpnkoQ3Z6/xPVq
 mQrlCYWIWsQnqVdcCL2QA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EQVJA/2bIZk=:FPn8JFjQ3f4yvM5OfYRmed
 5fXJjRwRBE2w6xa7trxtwIg9S5tG+uWfcjIrlEbQ6iQsbcNMIwq/eQ5MT45o8feLSBEjF2dyX
 uTbZ1/CbrJ4tIF2kJl67eMoboM6PrJLgEMm4/ZzN5aqDxSgnPqbIU375RsLb9P/zztN9Gja3y
 sQmmYYKLxbWL0j9k56gBVfRaJDE/R4HudRugNFJfSOt6gEOIV6V/t7e4e+1aD/dzaNGMlWmwo
 1QL3eLmje0AYCmynyNkBcqO+7Vdua9rqPirGPfvg28/bCUP9HqiiL2skTA8OBk4Qs3TR97bF+
 EV8EnkerAYzwuFKl4euEKKiyJ5EPGp4HjDZ/Wf3OlLW6tdhvWjfUDXIBctWic/Wd6EFy3d21+
 pLjRe0IkplwqKuWqR6qEjCnG5nLNgHH9sSLW6fwtzrUM31RM1oeiV46AuJ+YnLsqjSPpAE25F
 NO1OxjMB3BOOfZJJSoXnU1zVvYld7UPoQb+85yOOWmJeHGrs9ZqmYgE4cRSs+haob8zUw2ddc
 d3T8jwQzyeN07c1f7dwG/WCXzGO5+F6YyDRloxcdv6WzTZ1/MMyw6fvPZxBjUb/OySOShDAE3
 wCim+f/61WzGbJlpNstQoD7G8aUMbWDKXTBJis97kup0ibTYPIwVT/KNocag3sjEw7E/bTPkK
 EyfsBdkInyF8pHeLi+Rkf6QmSZZX1F6wCzN1ftvG4SEh5UpeNJemSq38uWAVKtn5pJe4y1Ziu
 gUmEkO13W2/fVd7UQhAkkCXe1dN2r8yHAMC5p4BpHUrc8zGaToc2NOcXdGCI64OtSoeUJU5yB
 OUjCx5O
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, 9 Oct 2016, Jeff King wrote:

> On Sun, Oct 09, 2016 at 06:32:38PM +0700, Duy Nguyen wrote:
> 
> > > If you mean ambiguity between the old "alias.X" and the new "alias.X.*",
> > > then yes, I think that's an unavoidable part of the transition.  IMHO,
> > > the new should take precedence over the old, and people will gradually
> > > move from one to the other.
> > 
> > Do we really need to treat this differently than
> > 
> > [alias]
> >     d2u = !dos2unix
> >     d2u = C:/cygwin/bin/dos3unix.exe
> > 
> > ?
> > 
> > Another similar case is one d2u (could be either old syntax or new) is
> > defined in ~/.gitconfig and the other d2u in $GIT_DIR/config. In
> > either case, the "latest" d2u definition wins.
> 
> Yeah, that's reasonable, too. So:
> 
>   [alias]
>     d2u = "!dos2unix"
> 
> acts exactly as if:
> 
>   [alias "d2u"]
>     command = dos2unix
>     type = shell
> 
> was specified at that point, which is easy to understand.

It is easy to understand, and even easier to get wrong or out of sync. I
really liked the ease of *one* `git config` call to add new aliases. Not
sure that I like the need for more such calls just to add *one* alias (one
config call for "shell", one for "don't cd up", etc).

Ciao,
Dscho
