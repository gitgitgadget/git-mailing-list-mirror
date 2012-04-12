From: Jeff King <peff@peff.net>
Subject: Re: push.default: current vs upstream
Date: Thu, 12 Apr 2012 18:11:10 -0400
Message-ID: <20120412221110.GA22426@sigill.intra.peff.net>
References: <vpqwr5uceis.fsf@bauges.imag.fr>
 <20120406071520.GD25301@sigill.intra.peff.net>
 <vpqr4w12tjj.fsf@bauges.imag.fr>
 <20120406080004.GA27940@sigill.intra.peff.net>
 <4F7FF19B.1060407@alum.mit.edu>
 <20120407075150.GA18168@sigill.intra.peff.net>
 <4F7FFD7A.80104@pileofstuff.org>
 <20120412071150.GB31122@sigill.intra.peff.net>
 <4F874639.5090207@pileofstuff.org>
 <7vlim04ou1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andrew Sayers <andrew-git@pileofstuff.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 00:11:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SISEZ-0003Sc-8X
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 00:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757361Ab2DLWLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 18:11:13 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60429
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049Ab2DLWLM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 18:11:12 -0400
Received: (qmail 32189 invoked by uid 107); 12 Apr 2012 22:11:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Apr 2012 18:11:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Apr 2012 18:11:10 -0400
Content-Disposition: inline
In-Reply-To: <7vlim04ou1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195378>

On Thu, Apr 12, 2012 at 02:33:58PM -0700, Junio C Hamano wrote:

> Andrew Sayers <andrew-git@pileofstuff.org> writes:
> 
> > So if the problem is that the documentation cues the reader to think
> > about upstreams but not to think about downstreams, the solution is to
> > find excuses to talk more about downstreams.  As far as I'm concerned
> > @{upstream} means "the place that commits come from when I `git pull`",
> > so it makes perfect sense to me that @{downstream} would mean "the place
> > commits go to when I `git push`".
> 
> In a separate message I completely misunderstood what you meant by
> "downstream".

Yeah, I also took it to mean that the "downstream" of your "upstream"
would be where you started (though as you mentioned, it is not 1-to-1,
so that would not work anyway).

But this:

> If you had something like this:
> 
> 	[remote "origin"]
>         	url = ...
>         [remote "destination"]
>                 pushURL = ...
> 
> 	[branch "topic"]
>         	remote = origin
>                 merge = refs/heads/master
> 		pushRemote = destination # new
>                 push = refs/heads/topic # new
> 
> you could express that asymmetric layout in a natural way.  When you say
> "git push" while on your "topic" branch, it will go to "destination"
> remote to update their "topic" branch.

is much more useful (and I already complained about the lack of
something like pushRemote recently). I just think it should not be
called "downstream", as it is not the reverse of upstream.

-Peff
