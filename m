From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when
 appropriate to do so
Date: Tue, 6 Oct 2009 11:12:51 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910061111410.4985@pacific.mpi-cbg.de>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com> <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de> <20091005225611.GB29335@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 06 11:12:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mv65r-00018C-Q3
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 11:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756634AbZJFJLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2009 05:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756272AbZJFJLP
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 05:11:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:39875 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754004AbZJFJLP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2009 05:11:15 -0400
Received: (qmail invoked by alias); 06 Oct 2009 09:10:26 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp056) with SMTP; 06 Oct 2009 11:10:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18HfEQeyVgHSGiV2blRyiiwTBo1hdzs7qpor6bjaQ
	ijkE7mHBrf81Or
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20091005225611.GB29335@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129612>

Hi,

On Mon, 5 Oct 2009, Jeff King wrote:

> On Mon, Oct 05, 2009 at 11:17:09PM +0200, Johannes Schindelin wrote:
> 
> > > $ git clone git://git.kernel.org/pub/scm/git/git.git
> > > $ cd git
> > > $ git checkout next
> > > error: pathspec 'next' did not match any file(s) known to git.
> > > To create a local branch from the same named remote branch, use
> > >   git checkout -b next origin/next
> > > 
> > > Motivated by http://article.gmane.org/gmane.comp.version-control.git/129528
> > 
> > Actually, we should really think long and hard why we should not 
> > automatically check out the local branch "next" in that case.  I mean, 
> > really long and hard, and making sure to take user-friendliness into 
> > account at least as much as simplicity of implementation.
> 
> Some devil's advocate questions:
> 
>   1. How do we find "origin/next" given "next"? What are the exact
>      lookup rules? Do they cover every case? Do they avoid surprising
>      the user?

I am sure your strategy would be the same as mine: enumerate all remote 
branches, strip the remote nickname, and compare.  If there are 
ambiguities, tell the user and stop.

>   2. What do we do if our lookup is ambiguous (e.g., "origin/next" and
>      "foobar/next" both exist)?

See above.

> 
>   3. If our lookup does have ambiguities or corner cases, is it better
>      to simply be suggesting to the user, rather than proceeding with an
>      action?

See above.

Ciao,
Dscho
