From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Disconnect stash from its base commit
Date: Wed, 2 Jul 2008 14:51:34 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807021447200.9925@racer>
References: <20080702195947.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Olivier Marin <dkr+ml.git@free.fr>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 15:54:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE2mz-0007z2-Om
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 15:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755262AbYGBNxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 09:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755163AbYGBNxa
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 09:53:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:50684 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754803AbYGBNx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 09:53:29 -0400
Received: (qmail invoked by alias); 02 Jul 2008 13:53:27 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp015) with SMTP; 02 Jul 2008 15:53:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+mJdQ5YnGm5WjRq4ag96DjZ9CABtw7qT5nSLoNRA
	yNkJVVs+nKl20/
X-X-Sender: gene099@racer
In-Reply-To: <20080702195947.6117@nanako3.lavabit.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87138>

Hi,

On Wed, 2 Jul 2008, Nanako Shiraishi wrote:

> A stash records the state of the files in the working tree as a merge 
> between the HEAD and another commit that records the state of the index, 
> that in turn is a child commit of the HEAD commit.  In order to later 
> apply (or pop) the stash, however, only the tree objects of these three 
> commits are necessary.
> 
> This patch changes the structure of a stash to use a parentless new 
> commit that has the same tree as the HEAD commit, in place of the HEAD 
> commit. This way, a stash does not keep the history that leads to the 
> HEAD commit reachable, even if the stash is kept forever.

May I register my suspicion that this is the wrong direction to go?

I actually find it quite nice that I can easily see in gitk where I 
spawned off a certain stash, indeed, how the recent stash history 
(manually specified with "stash@{0} stash@{1} stash@{2}" [*1*]), relates 
to the current branch's history.

Ciao,
Dscho

P.S.: I vaguely remember that I once wrote a patch to turn "stash@{0..2}" 
into exactly the same, but I do not remember why I did not follow up on 
it.  Was it refuted, or unwanted?
