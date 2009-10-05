From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch
 when appropriate to do so
Date: Mon, 5 Oct 2009 18:56:12 -0400
Message-ID: <20091005225611.GB29335@coredump.intra.peff.net>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
 <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 06 01:08:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Muwep-0006PR-SG
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 01:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755577AbZJEW5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 18:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755560AbZJEW46
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 18:56:58 -0400
Received: from peff.net ([208.65.91.99]:43632 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755350AbZJEW45 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 18:56:57 -0400
Received: (qmail 21049 invoked by uid 107); 5 Oct 2009 22:59:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 05 Oct 2009 18:59:48 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Oct 2009 18:56:12 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129601>

On Mon, Oct 05, 2009 at 11:17:09PM +0200, Johannes Schindelin wrote:

> > $ git clone git://git.kernel.org/pub/scm/git/git.git
> > $ cd git
> > $ git checkout next
> > error: pathspec 'next' did not match any file(s) known to git.
> > To create a local branch from the same named remote branch, use
> >   git checkout -b next origin/next
> > 
> > Motivated by http://article.gmane.org/gmane.comp.version-control.git/129528
> 
> Actually, we should really think long and hard why we should not 
> automatically check out the local branch "next" in that case.  I mean, 
> really long and hard, and making sure to take user-friendliness into 
> account at least as much as simplicity of implementation.

Some devil's advocate questions:

  1. How do we find "origin/next" given "next"? What are the exact
     lookup rules? Do they cover every case? Do they avoid surprising
     the user?

  2. What do we do if our lookup is ambiguous (e.g., "origin/next" and
     "foobar/next" both exist)?

  3. If our lookup does have ambiguities or corner cases, is it better
     to simply be suggesting to the user, rather than proceeding with an
     action?

-Peff
