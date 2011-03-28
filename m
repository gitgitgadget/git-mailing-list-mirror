From: Jeff King <peff@peff.net>
Subject: Re: Why can't I use git-bisect to find the first *good* commit?
Date: Mon, 28 Mar 2011 17:25:53 -0400
Message-ID: <20110328212553.GA3334@sigill.intra.peff.net>
References: <vpq62r3i1z4.fsf@bauges.imag.fr>
 <AANLkTimT+WN2F-BmQzQrAs3uizHig9cCXDUdc7nQ-vC5@mail.gmail.com>
 <vpqr59r6sg5.fsf@bauges.imag.fr>
 <AANLkTinuH4Ut+jtdqRfFrNeXA6JmBK2i0ddCcz4vV6JC@mail.gmail.com>
 <vpqvcz35cjk.fsf@bauges.imag.fr>
 <AANLkTikADLZvN0N==_H47O1vcrap1_Mcf7vW69d5sh0d@mail.gmail.com>
 <AANLkTimR5XfOV-0RZjdyu72E9JdBfr1B+wc=q55V4qH5@mail.gmail.com>
 <vpqbp0v2fve.fsf@bauges.imag.fr>
 <AANLkTim+iQ89b49nC8NRtoUobV4tMVL+bCoW-vg3+rLD@mail.gmail.com>
 <20110328202521.GB27755@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	demerphq <demerphq@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andrew Garber <andrew@andrewgarber.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 23:26:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Jwo-0006AU-PH
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 23:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923Ab1C1VZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 17:25:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42984
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160Ab1C1VZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 17:25:57 -0400
Received: (qmail 18534 invoked by uid 107); 28 Mar 2011 21:26:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Mar 2011 17:26:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Mar 2011 17:25:53 -0400
Content-Disposition: inline
In-Reply-To: <20110328202521.GB27755@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170193>

On Mon, Mar 28, 2011 at 04:25:21PM -0400, Jeff King wrote:

> On Mon, Mar 28, 2011 at 04:12:49PM -0400, Andrew Garber wrote:
> 
> > But what about demerphq's example? (see below)
> > 
> > >      Bx--B--B--B*
> > >     /
> > >  --Gz--By--B--Gx--G*
> > >
> > > How does knowing that G* is good help you to find that Bx broke the
> > > code in the B* branch again?
> > >
> > > Presumably 'By' broke the G* branch which was then fixed by Gx and
> > > none of this information helps you at all identify that Bx broke the
> > > B* branch.
> > >
> > > Whereas a plain binary search on the B* branch would eventually find
> > > that Bx was responsible.
> 
> If you feed bisect a history where the bug flips off and on between good
> and bad commits, you aren't necessarily going to get the answer you
> want. But that has nothing to do with the history shape; it is a problem
> in a linear history like this, too:
> 
>   --G--Bx--B--G--G--By--B

Actually, scratch what I said. I misread his graph. The fix has not yet
been cherry-picked, it just exists on the other branch. So there is no
flipping. But as Matthieu explained in another response, there is still
value in bisecting that graph.

-Peff
