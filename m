From: Jeff King <peff@peff.net>
Subject: Re: Question regarding git fetch
Date: Thu, 27 Aug 2009 18:16:31 -0400
Message-ID: <20090827221631.GA7058@coredump.intra.peff.net>
References: <1251387045053-3527289.post@n2.nabble.com>
 <32541b130908270836m50553ccatddf4c870eec54ddb@mail.gmail.com>
 <20090827164657.GA17090@atjola.homenet>
 <32541b130908271022i6a825198i37e2ec82ed5f833c@mail.gmail.com>
 <20090827204835.GC4399@coredump.intra.peff.net>
 <20090827213426.GD4399@coredump.intra.peff.net>
 <7v7hwpors9.fsf@alter.siamese.dyndns.org>
 <20090827215007.GA6231@coredump.intra.peff.net>
 <32541b130908271512h255834adl5a606054f6ab20e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Tom Lambda <tom.lambda@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 00:16:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgnGq-0005QX-NH
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 00:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363AbZH0WQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 18:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753344AbZH0WQc
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 18:16:32 -0400
Received: from peff.net ([208.65.91.99]:60701 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753317AbZH0WQb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 18:16:31 -0400
Received: (qmail 1119 invoked by uid 107); 27 Aug 2009 22:16:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 27 Aug 2009 18:16:42 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Aug 2009 18:16:31 -0400
Content-Disposition: inline
In-Reply-To: <32541b130908271512h255834adl5a606054f6ab20e4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127225>

On Thu, Aug 27, 2009 at 10:12:50PM +0000, Avery Pennarun wrote:

> > I'm still screwed. The issue is that you consider your configured
> > refspec destinations to be precious, and not merely a cache for what's
> > happening on the remote side.
> 
> Is the "precious remote ref" concept perhaps an imaginary one?

Maybe. I certainly don't use it. But I am trying to consider corner
cases where somebody who _isn't_ me is going to get screwed by a
change we make.

> After all, if I *really* care about the prior state of the remote, I
> can just make it a remote branch.  And if (as often happens) I just

Do you mean "local branch" here?

> want to know what's new in that ref since last time I merged, it's
> simply
> 
>    git log master..origin/master
> 
> This works even if master has extra commits vs. origin/master, since
> the double-dot invokes git-merge-base.

Well, ".." doesn't use git-merge-base. But yes, I actually do this,
except I do:

  gitk master...origin/master

-Peff
