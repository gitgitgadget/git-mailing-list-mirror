From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] git-add--interactive: manual hunk editing mode v2
Date: Mon, 9 Jun 2008 00:06:03 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806090003450.1783@racer>
References: <200805232221.45406.trast@student.ethz.ch> <20080606051026.GA18257@sigill.intra.peff.net> <20080606060318.GE18257@sigill.intra.peff.net> <200806090033.51167.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jun 09 01:08:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5Tzn-0005Fq-Fo
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 01:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755771AbYFHXH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 19:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755820AbYFHXH0
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 19:07:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:35896 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755771AbYFHXHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 19:07:25 -0400
Received: (qmail invoked by alias); 08 Jun 2008 23:07:23 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp046) with SMTP; 09 Jun 2008 01:07:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Od6d+RvgOQ/yfy0vww3UXaoAeM8xsnTgQV9XpAs
	3Z+sDONioth8EU
X-X-Sender: gene099@racer
In-Reply-To: <200806090033.51167.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84342>

Hi,

On Mon, 9 Jun 2008, Thomas Rast wrote:

> Jeff King wrote:
> >
> > I wrote this after reading just your first patch, and it looks like 
> > you've made much progress since. It seems like Thomas' patch could 
> > just get rid of all the recounting entirely, and just pass off the 
> > edited hunks to "git apply --recount". Which should make his patch 
> > much smaller and more straightforward.
> 
> I think there's no way to split hunks, in the way I currently "help" 
> with @@ line guessing, using just the --recount feature.  Unless the 
> editor helps you with adding complete correct @@ lines in the middle of 
> hunks (Emacs does that).  I don't think it is at all possible to remove 
> the middle part of a hunk in Johannes' scheme without somehow figuring 
> out the corresponding @@ line (or at least its old line number) or 
> editing away every +/- line.
> 
> Then again it's not always easy even with my patch: you may have to
> manually insert extra context because of the rule against zero lines
> of context.

That is actually where Junio convinced me that my approach is wrong: he 
said that you can _only_ reliably split a hunk at common lines.

The thing is: if you split _not_ at a common line, the context of the 
second part would _change_ depending if you want to apply the first part 
or not.

Ciao,
Dscho
