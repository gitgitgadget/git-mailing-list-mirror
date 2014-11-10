From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Add a few more values for
 receive.denyCurrentBranch
Date: Mon, 10 Nov 2014 14:03:29 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1411101401510.13845@s15462909.onlinehome-server.info>
References: <cover.1415368490.git.johannes.schindelin@gmx.de> <f82aedcb632571d0b756d62c58479c0aab35b026.1415368490.git.johannes.schindelin@gmx.de> <20141108111855.GA21620@peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 10 14:03:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xnod8-0007AR-Uw
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 14:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbaKJNDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 08:03:35 -0500
Received: from mout.gmx.net ([212.227.15.19]:52801 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814AbaKJNDe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 08:03:34 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MOfcU-1XtqFA2ehS-0065aB;
 Mon, 10 Nov 2014 14:03:30 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20141108111855.GA21620@peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:smSOAxK+B9+gSo54Ppn6blK67wC/6KlSA4frZYAmdzvMpDkVyM5
 zZBP36Ny5AgCLJadrxFSQ8iftFTZsw2mzW3IRUaFjfFmm7M/G/TJzsgYUL+IarsYWvPKb2T
 kL5SLLMhqv4+JL6V6lKU//q9d6UYngAjLy77l258K+Hxgnd/WJu/e66z8fxf4vNuSY8rSj6
 S81C+bzc7bKdZ+kYqScZQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sat, 8 Nov 2014, Jeff King wrote:

> On Fri, Nov 07, 2014 at 02:58:17PM +0100, Johannes Schindelin wrote:
> 
> > Under certain circumstances, it makes a *lot* of sense to allow pushing
> > into the current branch. For example, when two machines with different
> > Operating Systems are required for testing, it makes much more sense to
> > synchronize between working directories than having to go via a third
> > server.
> 
> FWIW, I do this without a third server (and without resorting to pull),
> with:
> 
>   host1$ git push host2 master:refs/remotes/host1/master
>   host2$ git merge host1/master
> 
> You can even set up a push refspec to make "git push host2" do the right
> thing.
> 
> That being said, I do like the premise of your patch, as it eliminates
> the extra step on the remote side (which is not that big a deal in
> itself, but when you realize that host2 _did_ have some changes on it,
> then you end up doing the merge there, when in general I'd prefer to do
> all the work on host1 via "git pull").

Plus: you have the luxury of working on an OS that makes ssh'ing from
another machine relatively easy. At least if you have the root password on
your machine. Which, I hate to point it out, is not too common a
commodity.

Ciao,
Dscho
