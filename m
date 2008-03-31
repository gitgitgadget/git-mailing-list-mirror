From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] git-archive ignores remote .gitattributes (was:
	.git/info/attributes not cloned)
Date: Sun, 30 Mar 2008 22:47:55 -0400
Message-ID: <20080331024755.GA690@coredump.intra.peff.net>
References: <47EB0FAE.5000102@rea-group.com> <20080327033341.GB5417@coredump.intra.peff.net> <47EB213F.1020503@rea-group.com> <20080327042925.GA6426@coredump.intra.peff.net> <47EB271F.1050307@rea-group.com> <20080327045342.GC6426@coredump.intra.peff.net> <47EC7DD1.3060102@rea-group.com> <alpine.LSU.1.00.0803281321260.18259@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Toby Corkindale <toby.corkindale@rea-group.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 31 04:48:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgA4r-0008S1-1d
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 04:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbYCaCr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 22:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbYCaCr6
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 22:47:58 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2495 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446AbYCaCr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 22:47:58 -0400
Received: (qmail 13216 invoked by uid 111); 31 Mar 2008 02:47:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 30 Mar 2008 22:47:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Mar 2008 22:47:55 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803281321260.18259@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78545>

On Fri, Mar 28, 2008 at 01:22:53PM +0100, Johannes Schindelin wrote:

> > "git-archive --remote=/some/repo" will ignore /some/repo/.gitattributes, 
> > but check /some/repo/info/attributes.
> > 
> > I think the problem is in the loop that looks for .gitattributes, which 
> > seems to do so by taking the current path and iterating down through it?
> 
> The problem is that "git archive --remote" operates on the remote 
> repository as if it were bare.  Which in many cases is true.
> 
> So I'd submit that this is not the usage .gitattributes is meant for, and 
> that you should clone the thing if you want to generate archives heeding 
> the .gitattributes.

I don't think it makes sense to operate on or take input from the
working tree of a remote; no other other command does, I don't think. I
had assumed, though, that .gitattributes files _in the tree being
exported_ would be used.

I thought there was some discussion of that a while ago (or possibly of
looking up .gitignore in the same way).

-Peff
