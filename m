From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] send-email: validate patches before sending
	anything
Date: Fri, 18 Jan 2008 14:09:10 -0500
Message-ID: <20080118190910.GA21044@coredump.intra.peff.net>
References: <20080118141638.GA14928@coredump.intra.peff.net> <20080118141948.GB19783@coredump.intra.peff.net> <4790C11F.8010809@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Piatyszek <ediap@users.sourceforge.net>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jan 18 20:09:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFwb4-0002yZ-Lx
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 20:09:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759432AbYARTJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 14:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757022AbYARTJO
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 14:09:14 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4048 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755277AbYARTJN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 14:09:13 -0500
Received: (qmail 20112 invoked by uid 111); 18 Jan 2008 19:09:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 18 Jan 2008 14:09:11 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Jan 2008 14:09:10 -0500
Content-Disposition: inline
In-Reply-To: <4790C11F.8010809@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71052>

On Fri, Jan 18, 2008 at 04:09:19PM +0100, Johannes Sixt wrote:

> Jeff King schrieb:
> > +sub validate_patch {
> > +	my $fn = shift;
> > +	open(my $fh, '<', $fn)
> > +		or die "unable to open $fn: $!\n";
> > +	while (my $line = <$fh>) {
> > +		if (length($line) > 998) {
> > +			return "patch contains line longer than 998 characters";
> 
> "... contains line_s_ longer than..."

I actually had that and changed it, since we know of only one such line
(since we bail at that point). I think Jay's suggestion of outputting
the line number is even better.

-Peff
