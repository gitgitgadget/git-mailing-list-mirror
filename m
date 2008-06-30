From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] clone: respect the settings in $HOME/.gitconfig
	and /etc/gitconfig
Date: Mon, 30 Jun 2008 02:40:32 -0400
Message-ID: <20080630064031.GA30600@sigill.intra.peff.net>
References: <27C25D70-0BFC-4362-A771-C7CAD89BC198@ai.rug.nl> <alpine.DEB.1.00.0806271353350.9925@racer> <alpine.LNX.1.00.0806271149580.19665@iabervon.org> <7vvdzuo61b.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0806291359330.19665@iabervon.org> <alpine.DEB.1.00.0806292248160.9925@racer> <7vwsk730mm.fsf@gitster.siamese.dyndns.org> <7vskuv30e6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 08:41:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDD4v-0003Jy-DS
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 08:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbYF3Gkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 02:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbYF3Gkg
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 02:40:36 -0400
Received: from peff.net ([208.65.91.99]:2543 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751264AbYF3Gkf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 02:40:35 -0400
Received: (qmail 25611 invoked by uid 111); 30 Jun 2008 06:40:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 30 Jun 2008 02:40:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jun 2008 02:40:32 -0400
Content-Disposition: inline
In-Reply-To: <7vskuv30e6.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86883>

On Sun, Jun 29, 2008 at 11:25:05PM -0700, Junio C Hamano wrote:

> > Honestly, GIT_CONFIG is purely for scripts like git-svn that muck with
> > files that are in the config format to have a way to make sure that they
> > access the file they intend to, and being able to use GIT_CONFIG to keep
> > git programs from reading from $HOME/.gitconfig is primarily for giving
> > our test scripts repeatable environment, nothing more.
[...]
> Of course, that would have downsides as well.  Now git-clone tests cannot
> be sanely written without setting $HOME to somewhere stable; otherwise
> they can be randomly affected by buggy $HOME/.gitconfig files the end user
> may have.

I thought we went through all of this before, and it led to 8bfa6bd6.
The test scripts set GIT_CONFIG_NOSYSTEM and GIT_CONFIG_NOGLOBAL to
achieve the same suppression effect.

-Peff
