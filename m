From: Jeff King <peff@peff.net>
Subject: Re: Why doesn't git-apply remove empty file
Date: Fri, 15 Aug 2008 00:08:34 -0400
Message-ID: <20080815040834.GA3732@sigill.intra.peff.net>
References: <7vod3xpxq2.fsf@gitster.siamese.dyndns.org> <38b2ab8a0808130048t506dbb7ah1d6fcd6bd4f3c90c@mail.gmail.com> <48A357BA.8060003@lsrfire.ath.cx> <alpine.LFD.1.10.0808131602200.3462@nehalem.linux-foundation.org> <38b2ab8a0808141242k4bd6867dt8ef54f160713061f@mail.gmail.com> <alpine.LFD.1.10.0808141246190.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808141258180.3324@nehalem.linux-foundation.org> <20080814202159.GD7138@leksak.fem-net> <20080814205447.GC25469@sigill.intra.peff.net> <20080814211034.GE7138@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Francis Moreau <francis.moro@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Aug 15 06:21:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTqo4-0007tK-Ay
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 06:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbYHOEIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 00:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbYHOEIh
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 00:08:37 -0400
Received: from peff.net ([208.65.91.99]:2333 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750736AbYHOEIg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 00:08:36 -0400
Received: (qmail 16396 invoked by uid 111); 15 Aug 2008 04:08:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 15 Aug 2008 00:08:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Aug 2008 00:08:34 -0400
Content-Disposition: inline
In-Reply-To: <20080814211034.GE7138@leksak.fem-net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92456>

On Thu, Aug 14, 2008 at 11:10:34PM +0200, Stephan Beyer wrote:

> git am -3 looks for the base blob in the "index" line of the patch.
> 
> Now imagine you do not have this blob in git, e.g. because you've not
> fetched some large side branch from another repo.

Ah, you're right. That is much trickier (though it can still be used in
some cases, depending on how broken the patch is).

> Then git am -3 won't help, too. (Yes, in this example fetching the
> branch may help, but there may be other examples.)

An easy example that breaks: the patch submitter didn't use git at all,
so there is no branch to fetch from. :)

-Peff
