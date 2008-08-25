From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] git wrapper: execute git-shell when argv[1] is
 '-c'
Date: Tue, 26 Aug 2008 00:05:21 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808260001390.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <7vbpzikt4b.fsf@gitster.siamese.dyndns.org> <20080824222534.GC14930@eagain.net> <alpine.DEB.1.00.0808251235430.24820@pacific.mpi-cbg.de.mpi-cbg.de> <48B29B2A.6000802@gnu.org> <alpine.DEB.1.00.0808251955490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <237967ef0808251125q3e50fa04wf0e97ff29298bef2@mail.gmail.com> <alpine.DEB.1.00.0808252206150.24820@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.DEB.1.00.0808252225520.24820@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.DEB.1.00.0808252248150.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.DEB.1.00.0808252251450.24820@pacific.mpi-cbg.de.mpi-cbg.de> <20080825210345.GE14930@eagain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mikael Magnusson <mikachu@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Paolo Bonzini <bonzini@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Tommi Virtanen <tv@eagain.net>
X-From: git-owner@vger.kernel.org Tue Aug 26 00:01:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXk7p-0001g1-E4
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 00:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbYHYWAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 18:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753203AbYHYWAU
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 18:00:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:44283 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752306AbYHYWAT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 18:00:19 -0400
Received: (qmail invoked by alias); 25 Aug 2008 22:00:17 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp036) with SMTP; 26 Aug 2008 00:00:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/F88NexNrFV05hjLom8+s47FUMnvxrkY/FMNkIIN
	ogKj2zvSmCX63M
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20080825210345.GE14930@eagain.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93688>

Hi,

On Tue, 26 Aug 2008, Tommi Virtanen wrote:

> On Mon, Aug 25, 2008 at 10:52:46PM +0200, Johannes Schindelin wrote:
> > When a program is called via ssh's '-c' option, the login shell is called 
> > on the remote computer, with the given arguments.  In the case that Git 
> > was specified as login shell in /etc/passwd, Git used to complain that it 
> > does not know the '-c' option and die.
> > 
> > This commit assumes that '-c' indicates that Git was specified as
> > a login shell, and hands off to git-shell.
> > 
> > Noticed by Tommi Virtanen.
> 
> My imagination is insufficient in coming up with an uglier kludge, and
> I sincerely hope my name isn't associated with this in any way.

I have no problems deleting your name from the commit message.  None at 
all.  Even if you actually did notice the issue.

I do disagree with you that it is a kludge though.  I think it makes 
complete sense to add this to Documentation/git.txt in addition to other 
documentation that is lacking from my patch, though:

-- snip --
-c <command>::
	execute <command> in git-shell.
-- snap --

Ciao,
Dscho
