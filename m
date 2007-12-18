From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] provide advance warning of some future pack default
	changes
Date: Tue, 18 Dec 2007 14:30:35 -0500
Message-ID: <20071218193035.GA4583@sigill.intra.peff.net>
References: <7v3au16myj.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999999.0712171641460.8467@xanadu.home> <7vbq8o4yxc.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999999.0712172212110.8467@xanadu.home> <46a038f90712171952i4f53876fv55b0e6993d5f4b0a@mail.gmail.com> <7vlk7s38aq.fsf@gitster.siamese.dyndns.org> <20071218111136.GA6266@coredump.intra.peff.net> <Pine.LNX.4.64.0712181204500.23902@racer.site> <20071218124808.GA3728@sigill.intra.peff.net> <Pine.LNX.4.64.0712181329340.23902@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Nicolas Pitre <nico@cam.org>,
	Joel Becker <Joel.Becker@oracle.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 18 20:31:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4i9f-0001Xg-MQ
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 20:31:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbXLRTaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 14:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbXLRTaj
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 14:30:39 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4538 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750873AbXLRTai (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 14:30:38 -0500
Received: (qmail 21855 invoked by uid 111); 18 Dec 2007 19:30:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 18 Dec 2007 14:30:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Dec 2007 14:30:35 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0712181329340.23902@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68795>

On Tue, Dec 18, 2007 at 01:30:49PM +0000, Johannes Schindelin wrote:

> > Yes, it should be, but I think there will be a few user-visible fallouts
> > (like "--abbrev $foo" in scripts should now be "--abbrev-default $foo"
> > for safety).
> 
> But we are on our way to fix this, no?  IOW this warrants not a version 
> bump, but an extended feature freeze/bug fix period (like Junio suggested, 
> until January).

I think the resolution seems to be that we will now support "--abbrev
foo", though we didn't in the past. Because the "foo" here is optional,
the old "git log --abbrev HEAD" is ambiguous. In this case we'll see
that "HEAD" isn't a number and DWIM. But that means a script trying to
be unambiguous should use "git log --abbrev-default $foo" to make sure
that "$foo" doesn't accidentally match as a number.

So there will be user-visible changes (though I don't expect them to be
huge...there simply aren't that many variables with optional arguments).

-Peff
