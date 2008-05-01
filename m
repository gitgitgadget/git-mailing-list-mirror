From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Thu, 1 May 2008 13:59:40 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805011355540.5247@eeepc-johanness>
References: <4816CA72.8070405@viscovery.net> <alpine.DEB.1.00.0804291147450.27457@eeepc-johanness> <7vk5ig745b.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804292220120.13650@eeepc-johanness> <7viqy05mhp.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804292355060.17469@eeepc-johanness> <7v63u05khw.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804300016130.17469@eeepc-johanness> <7v1w4o3zle.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804300938190.17469@eeepc-johanness>
 <20080430130653.GD6160@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 01 15:00:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrYOX-000682-Dp
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 15:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757442AbYEAM7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 08:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757358AbYEAM7a
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 08:59:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:49283 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753543AbYEAM73 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 08:59:29 -0400
Received: (qmail invoked by alias); 01 May 2008 12:59:27 -0000
Received: from R415b.r.pppool.de (EHLO eeepc-johanness.samsung.router) [89.54.65.91]
  by mail.gmx.net (mp049) with SMTP; 01 May 2008 14:59:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+zeJ9Wmn2zJPvYvVCkhsQ+L6V+yen+PFJDDp8ZpW
	8sXhmiOalO4YKf
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080430130653.GD6160@dpotapov.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80908>

Hi,

On Wed, 30 Apr 2008, Dmitry Potapov wrote:

> On Wed, Apr 30, 2008 at 09:47:02AM +0100, Johannes Schindelin wrote:
> > 
> > I cannot bring myself to feel that this is messy.  The more I think about 
> > it, the clearer it becomes for me that the pick call should use the 
> > original commit, whereas the merge call should use the rewritten commit 
> > (and should therefore only be called when all ancestors of that merge 
> > which need rebasing were rebased already).
> >
> 
> Maybe, it would be better if re-written commits were marked a bit 
> differently, so there will be no confusion about whether an original or 
> re-written commit is referred. For instance, re-written commits can be 
> marked by adding apostrophe at the end, so if the original commit was 
> "abcdef" then the re-written should be called as "abcdef'". At least, it 
> will make plain clear for anyone where in merge rewritten commits are 
> mentioned. Otherwise, it looks too magical to me.

Fair enough.  (For the "too magical" part.)

But it would break down if you picked one commit twice, in order to split 
it.  OTOH, this is a rare thing, and you really only need to refer to 
rewritten commits in the "reset" and "merge" commands.

But there is a bigger problem with what you suggest: When merging a commit 
that is _not_ in the rewritten part of the history, adding an apostrophe 
is actively wrong.

And I still believe strongly that a regular "rebase -i -p" user will not 
want to refer to original commits, except for the "pick" command.

Ciao,
Dscho
