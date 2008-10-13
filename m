From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce core.keepHardLinks
Date: Mon, 13 Oct 2008 18:09:21 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810131611470.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0810111344241.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081012183855.GA5255@spearce.org> <alpine.DEB.1.00.0810131057150.22125@pacific.mpi-cbg.de.mpi-cbg.de> <7vskr0bnlk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 18:04:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpPtl-0001VU-LW
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 18:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756164AbYJMQCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 12:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756121AbYJMQCi
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 12:02:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:48090 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756131AbYJMQCh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 12:02:37 -0400
Received: (qmail invoked by alias); 13 Oct 2008 16:02:35 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp027) with SMTP; 13 Oct 2008 18:02:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19hVPsf9vNhvHyhIvpiHKcO2EaGO/qYeFxFgD3iNb
	Lcnpmy7XeTsdE8
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <7vskr0bnlk.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98119>

Hi,

On Mon, 13 Oct 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> I cannot fathom why a user wants this much rope to hang themselves 
> >> with...
> >
> > The question is not so much why anyone want to do this, but _if_.
> 
> Sorry, I think the question should be _why_.
> 
> You can gain a sympathetic "Ah, that is sensible, and 'this much rope to 
> hang themselves with' comment was unwarranted" only by answering that 
> question.

Okay, here are a couple of reasons:

- all the editors that this guy tested keep the hard links, so it was 
  kinda hard to understand why Git insists on behaving differently,

- if the user asked for hard links, it is not Git's place to question that 
  decision,

- and in that user's scenario a certain file has to be shared between 
  different projects that are all version-controlled with Git, but in 
  different teams and with different servers they connect to.  So no, you 
  cannot even make a submodule of it, because the guys involved do not 
  share any repository/server access.  Besides, submodules are not 
  user-friendly enough yet.

Oh, and come to think of it, this could solve the old issue of "I want to 
track only a few files in my $HOME/".

Anyway, I think that breaking hard links is not a nice habit of Git (after 
all, from the user's point of view the file is not created, but 
modified!), and I would have expected others to need a lot less arguments 
to see it that way, too.

Ciao,
Dscho
