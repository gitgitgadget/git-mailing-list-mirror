From: Jeff King <peff@peff.net>
Subject: Re: backwards compatibility, was Re: [PATCH v1 1/3] Introduce
	config variable "diff.primer"
Date: Mon, 26 Jan 2009 06:16:05 -0500
Message-ID: <20090126111605.GB19993@coredump.intra.peff.net>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu> <1232904657-31831-2-git-send-email-keith@cs.ucla.edu> <7v1vurf7lq.fsf@gitster.siamese.dyndns.org> <alpine.GSO.2.00.0901251345240.12651@kiwi.cs.ucla.edu> <20090126031206.GB14277@sigill.intra.peff.net> <alpine.DEB.1.00.0901261154330.14855@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Keith Cascio <keith@CS.UCLA.EDU>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 26 12:17:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRPTD-0005K9-SM
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 12:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbZAZLQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 06:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbZAZLQI
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 06:16:08 -0500
Received: from peff.net ([208.65.91.99]:54403 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706AbZAZLQH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 06:16:07 -0500
Received: (qmail 2390 invoked by uid 107); 26 Jan 2009 11:16:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 26 Jan 2009 06:16:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Jan 2009 06:16:05 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901261154330.14855@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107189>

On Mon, Jan 26, 2009 at 11:59:46AM +0100, Johannes Schindelin wrote:

> Just a reminder: we are very conservative when it comes to breaking 
> backwards compatibility.  For example, people running (but not upgrading) 
> gitweb who want to upgrade Git may rightfully expect their setups not to 
> be broken for a long time, if ever.
> 
> So your mentioning gitweb using "git diff" precludes all kind of cute 
> games, methinks.

Are you aware that gitweb no longer calls "git diff", exactly because
of problems caused by calling a porcelain from a script?

I don't want to break existing setups, either. But at some point you
have to say "this is porcelain, so don't rely on there not being any
user-triggered effects in its behavior". If porcelain is cast in stone,
then what is the point in differentiating plumbing from porcelain?

And when the line is blurred (as I think it is in several places), then
it has to be dealt with on a case-by-case basis. What is the benefit,
and what is the likelihood and extent of harm?

> And please no "anybody who would do this and that would be nuts" excuses: 
> if you want to change something fundamental like this, _you_ have to 
> defend it.
> 
> It is not acceptable to just shout out what you want and expect those 
> affected negatively to do the impact analysis for you.

This message is addressed to me, but I don't know exactly what you think
I'm proposing, failing to defend, or failing to do an impact analysis
for. Or are you speaking generally of the "you" who submit patches?

-Peff
