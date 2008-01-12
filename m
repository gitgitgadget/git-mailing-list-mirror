From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] GIT 1.5.4-rc3
Date: Sat, 12 Jan 2008 13:09:43 -0500
Message-ID: <20080112180943.GA32732@coredump.intra.peff.net>
References: <7vsl13wmas.fsf@gitster.siamese.dyndns.org> <200801120926.14307.ismail@pardus.org.tr> <7vejcnwl85.fsf@gitster.siamese.dyndns.org> <200801120947.48602.ismail@pardus.org.tr> <20080112090432.GA6134@coredump.intra.peff.net> <alpine.LSU.1.00.0801121756400.8333@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ismail =?iso-8859-1?Q?D=F6nmez?= <ismail@pardus.org.tr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 12 19:10:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDkoB-0006Iv-Dm
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 19:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757178AbYALSJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 13:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756805AbYALSJq
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 13:09:46 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3937 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756518AbYALSJp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 13:09:45 -0500
Received: (qmail 8393 invoked by uid 111); 12 Jan 2008 18:09:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 12 Jan 2008 13:09:44 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Jan 2008 13:09:43 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0801121756400.8333@wbgn129.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70341>

On Sat, Jan 12, 2008 at 05:57:49PM +0100, Johannes Schindelin wrote:

> >  		if (pathspec) {
> > -			memset(seen, 0, argc);
> > +			memset(seen, 0, argc > 0 ? argc : 1);
> >  			matches = match_pathspec(pathspec, ent->name, ent->len,
> >  						 baselen, seen);
> >  		} else {
> 
> Would it not be better to guard the memset by an "if (argc)", and set 
> "seen" to NULL by default?

I am not sure what you mean by "guard with if (argc)"; it needs to be
memset in either case (either with N slots, or with 1 if no argc). Seen
could not be NULL previously, but Rene's patch makes that possible.

-Peff
