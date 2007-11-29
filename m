From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Thu, 29 Nov 2007 16:14:10 -0500
Message-ID: <20071129211409.GA16625@sigill.intra.peff.net>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop> <Pine.LNX.4.64.0711271617350.27959@racer.site> <20071128000731.GD9174@efreet.light.src> <7v8x4jb295.fsf@gitster.siamese.dyndns.org> <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com> <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org> <20071129150849.GA32296@coredump.intra.peff.net> <fcaeb9bf0711291205h125dadbbp8e8ae392e9b5b751@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 22:14:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxqiP-0005Zr-EE
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 22:14:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbXK2VOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 16:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756775AbXK2VOO
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 16:14:14 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2283 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756222AbXK2VON (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 16:14:13 -0500
Received: (qmail 29354 invoked by uid 111); 29 Nov 2007 21:14:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 29 Nov 2007 16:14:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Nov 2007 16:14:10 -0500
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0711291205h125dadbbp8e8ae392e9b5b751@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66563>

On Fri, Nov 30, 2007 at 03:05:05AM +0700, Nguyen Thai Ngoc Duy wrote:

> > But I don't see a point to removing the links entirely. The annoyance
> > factor for people who want git-* is much higher, and I don't see that it
> > actually buys us any help for new users (who will no longer care after
> > everything is hidden in $(libexecdir) anyway).
> 
> Maybe only not install hardlinks on systems that do not support it
> like Windows? git.exe duplication takes a lot of space.

I think that is totally reasonable, as on those platforms there is
actually something to be gained from removing those hardlinks (you could
also of course make a very thin wrapper for "git-foo" that called "git
foo"; it would still be wasteful, but not as much as copying the whole
git.exe. But that is not worth doing unless people on Windows really
want the dash forms).

-Peff
