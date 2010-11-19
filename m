From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] push to mirrior interferes with parallel operations
Date: Fri, 19 Nov 2010 14:46:28 -0500
Message-ID: <20101119194628.GA15466@sigill.intra.peff.net>
References: <e355bb33c6192a6a29de56c7be93278e.squirrel@artax.karlin.mff.cuni.cz>
 <20101118175007.GA26505@sigill.intra.peff.net>
 <20101118184241.GN3693@efreet.light.src>
 <20101118190414.GA30438@sigill.intra.peff.net>
 <m2ipzt14rh.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Nov 19 20:46:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJWv6-0001Yz-8g
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 20:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756632Ab0KSTqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 14:46:36 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:54144 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756624Ab0KSTqf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 14:46:35 -0500
Received: (qmail 27765 invoked by uid 111); 19 Nov 2010 19:46:34 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 19 Nov 2010 19:46:34 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Nov 2010 14:46:28 -0500
Content-Disposition: inline
In-Reply-To: <m2ipzt14rh.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161778>

On Fri, Nov 19, 2010 at 08:40:18PM +0100, Andreas Schwab wrote:

> Jeff King <peff@peff.net> writes:
> 
> > it really only makes sense to push from a non-bare repo,
> 
> Why?  The repo could itself be a mirror.

Why do you have a working directory if you are going to have a refspec
that overwrites HEAD behind your back (which, IIRC, git will simply barf
on, so all of your fetches will fail)?

Yes, you could do something complex like have a mirror that lives on a
detached HEAD and automagically updates the working tree based on some
particular ref. But at that point I think you are going to be setting up
.git/config manually, anyway. This is really about what default git "git
remote add --mirror" should set up.

-Peff
