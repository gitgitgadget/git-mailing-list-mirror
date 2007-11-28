From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] cvsimport: use show-ref to support packed refs
Date: Wed, 28 Nov 2007 17:52:29 -0500
Message-ID: <20071128225229.GA13836@coredump.intra.peff.net>
References: <20071128185504.GA11236@coredump.intra.peff.net> <20071128185611.GB11320@coredump.intra.peff.net> <Pine.LNX.4.64.0711281916140.27959@racer.site> <20071128194423.GB11396@coredump.intra.peff.net> <7v4pf63t7y.fsf@gitster.siamese.dyndns.org> <20071128224313.GB13298@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Emanuele Giaquinta <e.giaquinta@glauco.it>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 23:52:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxVm1-0008Us-IY
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 23:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760123AbXK1Wwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 17:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758359AbXK1Wwc
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 17:52:32 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3753 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759935AbXK1Wwb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 17:52:31 -0500
Received: (qmail 14927 invoked by uid 111); 28 Nov 2007 22:52:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 28 Nov 2007 17:52:30 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Nov 2007 17:52:29 -0500
Content-Disposition: inline
In-Reply-To: <20071128224313.GB13298@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66451>

On Wed, Nov 28, 2007 at 05:43:13PM -0500, Jeff King wrote:

> > 	sub get_headref {
> >         	my ($it) = (@_);
> >                 my $r = `git-rev-parse --verify "refs/$it"`;
> > 		return undef unless $? == 0;
> > 		chomp $r;
> > 		return $r;
> > 	}
> 
> I have no comment on which is the best command to use (you would know
> much better than I), but adding "refs/" is wrong.

BTW, one bad thing about the new get_headref compared to the original is
that it does not distinguish very well between "ref does not exist" and
"an error occurred." Is there a lookup command that makes such a
distinction possible?

-Peff
