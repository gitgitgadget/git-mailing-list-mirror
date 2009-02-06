From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/8] Tests: let --valgrind imply --verbose and --tee
Date: Fri, 6 Feb 2009 14:08:15 -0500
Message-ID: <20090206190815.GB19494@coredump.intra.peff.net>
References: <cover.1233702893u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0902040026250.9822@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 06 20:09:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVW5A-0001tD-QK
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 20:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753034AbZBFTIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 14:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbZBFTIS
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 14:08:18 -0500
Received: from peff.net ([208.65.91.99]:55712 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782AbZBFTIR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 14:08:17 -0500
Received: (qmail 24142 invoked by uid 107); 6 Feb 2009 19:08:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 06 Feb 2009 14:08:31 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Feb 2009 14:08:15 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902040026250.9822@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108771>

On Wed, Feb 04, 2009 at 12:26:26AM +0100, Johannes Schindelin wrote:

> It does not make much sense to run the (expensive) valgrind tests and
> not look at the output.
> 
> To prevent output from scrolling out of reach, the parameter --tee is
> implied, too.

Might it not make sense to want to send the output to a file, but _not_
show it on the terminal (e.g., running from a cron job)? But if I
understand correctly, that is not actually possible with any combination
of "--verbose" and "--tee".

So perhaps it would make more sense to have, rather than "--tee", simply
"--verbose" to output to the terminal and "--save-output" (or similar)
to save the output. If both are requested, it is equivalent to what
"--tee" does now.

On the other hand, I think "--verbose --tee >/dev/null" would probably
accomplish the same thing, so it probably isn't worth too much effort.

Other than that, this series looks pretty reasonable. I am a bit late to
ack, but thank you for following through on it. It looks like it has
caught some bugs already, which is always a good sign. :)

I have access to a decent quad-core box, so I'll try to periodically run
the test suite with valgrind on it. Daily is probably too much, but
maybe whenever we go into rc-freeze is a good time.

-Peff
