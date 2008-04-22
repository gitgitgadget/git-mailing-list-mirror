From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git remote update -> rejected
Date: Tue, 22 Apr 2008 12:58:07 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804221250010.4460@eeepc-johanness>
References: <1208857733.4695.37.camel@marge.simson.net> <20080422103458.GA14751@sigio.intra.peff.net> <1208861703.18689.2.camel@marge.simson.net> <20080422111113.GB11238@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Galbraith <efault@gmx.de>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 22 13:58:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoH8o-00088k-8u
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 13:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbYDVL5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 07:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbYDVL5n
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 07:57:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:51605 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752045AbYDVL5m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 07:57:42 -0400
Received: (qmail invoked by alias); 22 Apr 2008 11:57:40 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp038) with SMTP; 22 Apr 2008 13:57:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19qvdB0I1FqoYRHS7uK5sfCzZRdyJ4yGzRY2xWEv/
	sG63HlSOaEObA4
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080422111113.GB11238@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80104>

Hi Peff,

On Tue, 22 Apr 2008, Jeff King wrote:

> On Tue, Apr 22, 2008 at 12:55:03PM +0200, Mike Galbraith wrote:
> 
> > >   [remote "x86"]
> > >     url = ...
> > >     fetch = +refs/heads/*:refs/remotes/x86/*
> > > 
> > > See 'git help fetch' for details.
> > 
> > Thanks a bunch.  I'll try it.  I notice that origin and linux-next
> > already had + prefix.  Presumably that came from the home repo.
> 
> Cloning creates an origin with '+' in the fetch line, but "git remote
> add" doesn't seem to. Hrm, it looks like this is a regression from the
> recent rewrite in C.

Thanks for working on this: I missed this thread (had too many mails to 
catch up with).

> Dscho, is this a bug, or was there a conscious decision that I missed?

It was a concious decision, but maybe it was wrong.

My rationale was this: if I mirror another person's repository, I want all 
the history.  And I do want to keep it, even if the other person decides 
to clean the original repository out.

(In this case, the reflogs would not help, since I do not have a HEAD 
reflog for all the deleted branches, and deleting the refs deletes their 
reflogs, too.)

But as I said, my rationale may very well be wrong.

Ciao,
Dscho
