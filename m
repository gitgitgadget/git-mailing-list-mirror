From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] "color.diff = true" is not "always" anymore.
Date: Fri, 30 Nov 2007 23:15:49 -0500
Message-ID: <20071201041549.GB30725@coredump.intra.peff.net>
References: <474B42EC.1000408@wanadoo.fr> <7vr6icej23.fsf@gitster.siamese.dyndns.org> <7vd4tuakzj.fsf_-_@gitster.siamese.dyndns.org> <20071128190439.GA11396@coredump.intra.peff.net> <7v4pf39m4j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 01 05:16:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyJm1-0006HH-RN
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 05:16:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373AbXLAEPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 23:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754428AbXLAEPw
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 23:15:52 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4652 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752969AbXLAEPv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 23:15:51 -0500
Received: (qmail 13839 invoked by uid 111); 1 Dec 2007 04:15:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 30 Nov 2007 23:15:50 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Nov 2007 23:15:49 -0500
Content-Disposition: inline
In-Reply-To: <7v4pf39m4j.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66695>

On Fri, Nov 30, 2007 at 06:36:44PM -0800, Junio C Hamano wrote:

> > It would be nice to have a "git config --colorbool" option, but it has
> > the unfortunate problem that the stdout of "git config" is piped back to
> > the caller, so the isatty check is meaningless (and the "pager in use"
> > is similarly tricky). Perhaps it should go in Git.pm, so it at least
> > only needs to be written once.
> 
> About the isatty(3) check, you do not have to use the stdout to report
> the result, though.  IOW, you could use the exit code from the command.

I thought about that, but it feels a little wrong since it is so unlike
all of the other interfaces to git-config. Still, I would consider doing
it if there weren't other issues (like knowing when a pager is in use).
At some point it becomes more complex than simply having the 5-10 lines
necessary to do the check in perl.

-Peff
