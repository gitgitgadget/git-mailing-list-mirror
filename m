From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce core.keepHardLinks
Date: Mon, 13 Oct 2008 19:55:47 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810131954180.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0810111344241.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081012183855.GA5255@spearce.org> <alpine.DEB.1.00.0810131057150.22125@pacific.mpi-cbg.de.mpi-cbg.de> <7vskr0bnlk.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0810131611470.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081013162132.GB20371@leksak.fem-net> <20081013162351.GQ4856@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 13 19:50:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpRZ4-0003pa-JK
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 19:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755580AbYJMRtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 13:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755549AbYJMRtP
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 13:49:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:60571 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753859AbYJMRtO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 13:49:14 -0400
Received: (qmail invoked by alias); 13 Oct 2008 17:49:10 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp024) with SMTP; 13 Oct 2008 19:49:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19a8YpsbfFagdMaEwIt5b6hSAjijc9MvaeElaG3MM
	z9SrKQykwVGjST
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20081013162351.GQ4856@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98132>

Hi,

On Mon, 13 Oct 2008, Shawn O. Pearce wrote:

> Stephan Beyer <s-beyer@gmx.net> wrote:
> > Johannes Schindelin wrote:
> > > and I would have expected others to need a lot less arguments 
> > > to see it that way, too.
> > 
> > Despite the fact that I've never used hardlinks in a git repository, I 
> > would have expected git to keep them.  So I'm one of the "others" who 
> > thinks this config option is just sane (and should perhaps even be 
> > enabled by default, if it does not break stuff on file systems that do 
> > not have a hardlink feature... but ok)
> 
> My problem is many users do "cp -rl a b" to clone a->b and hardlink the 
> working directory.  They expect "cd b && git checkout foo" to then only 
> unlink the paths that differ.  Updating the original inode would break 
> repository a.
> 
> Its a change in behavior, to some of our oldest users.  So it can't 
> really be on by default.

Which is the reason why my commit is not titled "Make Git respect hard 
links by default", but "Introduce core.keepHardLinks".  I also hate people 
who try to break my setup.

Which scenario (breaking someone's setup) was exactly what triggered this 
patch.

Ciao,
Dscho
