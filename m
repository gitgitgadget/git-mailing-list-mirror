From: Jeff King <peff@peff.net>
Subject: Re: valgrind test script integration
Date: Sat, 12 Jan 2008 13:12:40 -0500
Message-ID: <20080112181240.GB32732@coredump.intra.peff.net>
References: <7vsl13wmas.fsf@gitster.siamese.dyndns.org> <200801120926.14307.ismail@pardus.org.tr> <7vejcnwl85.fsf@gitster.siamese.dyndns.org> <200801120947.48602.ismail@pardus.org.tr> <20080112090432.GA6134@coredump.intra.peff.net> <20080112111044.GA24257@coredump.intra.peff.net> <20080112113608.GB24589@coredump.intra.peff.net> <alpine.LSU.1.00.0801121808150.8333@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 12 19:13:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDkr0-0007O5-TL
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 19:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756478AbYALSMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 13:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756041AbYALSMn
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 13:12:43 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4964 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756405AbYALSMm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 13:12:42 -0500
Received: (qmail 8416 invoked by uid 111); 12 Jan 2008 18:12:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 12 Jan 2008 13:12:41 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Jan 2008 13:12:40 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0801121808150.8333@wbgn129.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70342>

On Sat, Jan 12, 2008 at 06:10:30PM +0100, Johannes Schindelin wrote:

> Nevertheless, I think that would be better.
> 
> BTW does your first patch cope with scripts properly? (I.e. also valgrind 
> the git programs called by the script)

No. To do that, you would need to set up an alternate directory at the
head of the PATH with 'git' in it (and git-*, for everything we want to
intercept, which I think would be all builtins, but probably not scripts
(unless you want to run valgrind on perl or bash, which is probably not
useful to us)).

I started down that route, but it was a little ugly. How do we make that
directory? Where is it stored? Is it generated each time the test script
is run, or part of the Makefile?

-Peff
