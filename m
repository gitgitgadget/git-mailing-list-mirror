From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jan 2009, #07; Wed, 28)
Date: Fri, 30 Jan 2009 14:18:32 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901301415260.3586@pacific.mpi-cbg.de>
References: <7vwscej26i.fsf@gitster.siamese.dyndns.org> <20090129035138.GC11836@coredump.intra.peff.net> <bd6139dc0901290327u572cc30ci9dc719c912fbf875@mail.gmail.com> <20090129113735.GA6505@coredump.intra.peff.net> <351A6988-32EB-473F-B6E5-8FBB38D91F88@ai.rug.nl>
 <bd6139dc0901290345u4962f747gbe93c945ab35c9cb@mail.gmail.com> <20090129115026.GB10792@coredump.intra.peff.net> <bd6139dc0901290420x1216a399w656e4d1622178a06@mail.gmail.com> <20090130045131.GB18655@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 30 14:19:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LStHV-0007Re-3y
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 14:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbZA3NSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 08:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752505AbZA3NSM
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 08:18:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:51326 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752491AbZA3NSL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 08:18:11 -0500
Received: (qmail invoked by alias); 30 Jan 2009 13:18:09 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp032) with SMTP; 30 Jan 2009 14:18:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+DuVAF5EWDYcTkqhYHqeetyn4i09gqoG+aBbZ2zm
	G2iqON6jlprLjq
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090130045131.GB18655@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107812>

Hi,

On Thu, 29 Jan 2009, Jeff King wrote:

> On Thu, Jan 29, 2009 at 01:20:20PM +0100, Sverre Rabbelier wrote:
> 
> > > It wouldn't help the case of "somebody
> > > else pushed some content that you want to pull", but like you said, I
> > > think the primary workflow is that you immediately push after cloning
> > > the empty repo.
> > 
> > Also, the only way to support the "somebody else pushed already"
> > workflow would be to assume the user wants to name the branch
> > 'master', which might not be the case at all.
> 
> You could make a guess that they will use "master", and if you are
> wrong, it behaves as now. But if you are right, "git pull" pulls down
> master automatically.
> 
> But that is getting a little confusing. So let's push this "git push
> --track" idea to completion and see how people like it.

How about installing

	[branch "master"]
		remote = origin
		merge = refs/heads/master

by default?  It is a safe bet that this will be the case for 99% of all 
users that want to clone an empty repository (especially if they are 
putting their public repositories on something like repo.or.cz, where you 
cannot change the default branch from "master" to something else).

And if somebody wants to track another branch, tough, she has to call 
this:

	$ git checkout -t origin/blablabla

Ciao,
Dscho
