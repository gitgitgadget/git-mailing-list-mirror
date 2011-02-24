From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 18/31] rebase: extract merge code to new source file
Date: Thu, 24 Feb 2011 03:09:04 -0500
Message-ID: <20110224080904.GC25595@sigill.intra.peff.net>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-19-git-send-email-martin.von.zweigbergk@gmail.com>
 <4D58E17C.9090001@viscovery.net>
 <alpine.DEB.2.00.1102232216180.11038@debian>
 <20110224080734.GB25595@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 09:09:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsWG5-0005PH-Bu
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 09:09:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755081Ab1BXIJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 03:09:04 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:55085 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754887Ab1BXIJD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 03:09:03 -0500
Received: (qmail 20690 invoked by uid 111); 24 Feb 2011 08:09:02 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 24 Feb 2011 08:09:02 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Feb 2011 03:09:04 -0500
Content-Disposition: inline
In-Reply-To: <20110224080734.GB25595@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167779>

On Thu, Feb 24, 2011 at 03:07:34AM -0500, Jeff King wrote:

> On Wed, Feb 23, 2011 at 10:27:23PM -0500, Martin von Zweigbergk wrote:
> 
> > > > +++ b/git-rebase--merge.sh
> > > 
> > > This should be mode 100755. (Ditto for git-rebase--am.sh in 19/31)
> > 
> > I was just about to fix now and I noticed that quite a few other
> > script files are mode 100644. Should all be changed to mode 100755 or
> > is there some kind of rule as to which mode they should be? Both
> > git-sh-setup.sh and git-parse-remote.sh are also mode 100644 and I
> > (think I) know that both are always sourced. If the rule is that
> > sourced scripts should be mode 100644 (but I'm just guessing here),
> > then I should actually have changed the mode of
> > git-rebase--interactive.sh to that mode instead. Please advice.
> 
> Yes, sourced scripts should not have an executable bit. See 46bac90 for
> rationale.

And I should have mentioned: they should go in SCRIPT_LIB in the
Makefile, not SCRIPT_SH.

-Peff
