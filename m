From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Thu, 29 Nov 2007 10:08:49 -0500
Message-ID: <20071129150849.GA32296@coredump.intra.peff.net>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop> <Pine.LNX.4.64.0711271617350.27959@racer.site> <20071128000731.GD9174@efreet.light.src> <7v8x4jb295.fsf@gitster.siamese.dyndns.org> <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com> <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 16:09:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixl0u-0004Ar-6F
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 16:09:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756542AbXK2PIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 10:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755113AbXK2PIx
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 10:08:53 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4970 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754708AbXK2PIw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 10:08:52 -0500
Received: (qmail 19755 invoked by uid 111); 29 Nov 2007 15:08:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 29 Nov 2007 10:08:50 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Nov 2007 10:08:49 -0500
Content-Disposition: inline
In-Reply-To: <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66539>

On Wed, Nov 28, 2007 at 03:14:56PM -0800, Junio C Hamano wrote:

>  - Post v1.5.5, start cooking the change that does not install hardlinks
>    for built-in commands, aiming for inclusion in v1.6.0, by the end of
>    2008.

I am against this, unless it is configurable. I think the goal of
reducing user-visible commands is fine, and moving things to
$(libexecdir) is a good way of doing that.

However, I personally still think the 'git-foo' forms are valuable
(because fingers have already been trained, and because
non-bash-programmable completions understand them). And I don't mind
putting $(libexecdir)/git-core in my PATH to retain this behavior; it's
a one-time configuration tweak, and it helps new users with the
overwhelming command set.

But I don't see a point to removing the links entirely. The annoyance
factor for people who want git-* is much higher, and I don't see that it
actually buys us any help for new users (who will no longer care after
everything is hidden in $(libexecdir) anyway).

-Peff
