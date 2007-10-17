From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: revised: [PATCH] Color support added to git-add--interactive.
Date: Tue, 16 Oct 2007 21:51:52 -0400
Message-ID: <20071017015152.GN13801@spearce.org>
References: <471045DA.5050902@gmail.com> <19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com> <20071013172745.GA2624@coredump.intra.peff.net> <20071013175127.GA3183@coredump.intra.peff.net> <47112491.8070309@gmail.com> <20071015034338.GA4844@coredump.intra.peff.net> <20071016194709.3c1cb3a8@danzwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeff King <peff@peff.net>, Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Dan Zwell <dzwell@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 03:52:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihy52-0002vG-6w
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 03:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761536AbXJQBwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 21:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760560AbXJQBwF
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 21:52:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50876 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761989AbXJQBwE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 21:52:04 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ihy4U-0005id-Un; Tue, 16 Oct 2007 21:51:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0D76C20FBAE; Tue, 16 Oct 2007 21:51:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071016194709.3c1cb3a8@danzwell.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61305>

Dan Zwell <dzwell@gmail.com> wrote:
> Adds color to the prompts and output of git-add--interactive.

I'm probbaly going to publish this in `pu` tonight but I have some
comments that I think need to be addressed before this graduates
any further.

First off, no Signed-off-by?  This is big enough that I refuse to
put it in the main tree without one.  Second it would really have
helped if the email was formatted with `git format-patch`.  Copying
the message headers and body over for the commit message was less
than fun.  I have better things to do with my time.
 
> +color.interactive.<slot>::
> +        Use customized color for add--interactive output. `<slot>`

You probably should talk about `git add --interactive` as that
is what the git-add documentation calls it.  Many end-users don't
even know that `git add -i` is exec()'ing into another program to
accomplish its task.  I fixed this up when I applied the patch.

> +Note: these are not the same colors/attributes that the
> +rest of git supports, but are specific to git-add--interactive.

This is a problem in my opinion.  Why can't it match the same
names that the C code recognizes?  What if we one day were to
see git-add--interactive.perl converted to C?  How would we then
reconcile the color handling at that point in time?

-- 
Shawn.
