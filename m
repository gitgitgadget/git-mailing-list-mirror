From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached HEAD
 was
Date: Thu, 15 Oct 2009 17:48:04 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910151743230.20122@xanadu.home>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
 <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
 <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
 <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
 <alpine.LNX.2.00.0910151523020.32515@iabervon.org>
 <7v3a5k4cri.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0910151653480.32515@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Oct 15 23:49:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyYCC-0003CR-EW
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 23:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935321AbZJOVsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 17:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934871AbZJOVsr
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 17:48:47 -0400
Received: from relais.videotron.ca ([24.201.245.36]:34142 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933213AbZJOVsq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 17:48:46 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KRK00J6CSK44400@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 15 Oct 2009 17:48:05 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LNX.2.00.0910151653480.32515@iabervon.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130426>

On Thu, 15 Oct 2009, Daniel Barkalow wrote:

> On Thu, 15 Oct 2009, Junio C Hamano wrote:
> 
> > Daniel Barkalow <barkalow@iabervon.org> writes:
> > 
> > >  $ git checkout origin/master
> > >  $ git fetch
> > >  $ git checkout origin/next
> > >  Uncommited file '...' would be overwritten.
> > >
> > > If HEAD is a symref to refs/remotes/origin/master, and you update 
> > > refs/remotes/origin/master, git will subsequently see that your index 
> > > doesn't match HEAD, and when you switch branches, it will try to apply a 
> > > revert to the branch you're switching to. It's the same issue as pushing 
> > > into a non-bare repository.
> > 
> > I think the idea here is to allow HEAD to point at outside refs/heads/,
> > e.g. refs/remotes/origin/master, but forbid commit and other commands from
> > updating HEAD and its underlying ref via update_ref() unless HEAD is
> > detached or points at a local branch.
> 
>  $ git checkout origin/master
>  $ git fetch
>  (Some error)

Right.

So we're back to your initial proposal I guess (storing some info/state 
in .git/HEAD when detached).


Nicolas
