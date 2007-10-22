From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Mon, 22 Oct 2007 14:48:20 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710221445170.25221@racer.site>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com> 
 <Pine.LNX.4.64.0710130130380.25221@racer.site>  <1192827476.4522.93.camel@cacharro.xalalinux.org>
  <4719B655.90204@op5.se> <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de>
 <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com>
 <Pine.LNX.4.64.0710210031130.25221@racer.site> <471AFD07.4040606@op5.se>
 <Pine.LNX.4.64.0710212308540.25221@racer.site> <471C586A.9030900@op5.se>
 <Pine.LNX.4.64.0710221156540.25221@racer.site> <471C9B13.9080603@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Oct 22 15:48:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjxeI-0004yY-FO
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 15:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbXJVNsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 09:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752593AbXJVNsn
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 09:48:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:45636 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752497AbXJVNsm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 09:48:42 -0400
Received: (qmail invoked by alias); 22 Oct 2007 13:48:40 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 22 Oct 2007 15:48:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+hzBEmd6GhGIalVCNWgGm1DMwYfXvnaQzqH98AIk
	z5FBn+ZZLZmyeA
X-X-Sender: gene099@racer.site
In-Reply-To: <471C9B13.9080603@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62007>

Hi,

On Mon, 22 Oct 2007, Andreas Ericsson wrote:

> If I were to suggest any improvements, it'd be to change the semantics of
> git-pull to always update the local branches set up to be merged with the
> remote tracking branches when they, prior to fetching, pointed to the same
> commit, such that when
> 
> $ git show-ref master
> d4027a816dd0b416dc8c7b37e2c260e6905f11b6 refs/heads/master
> d4027a816dd0b416dc8c7b37e2c260e6905f11b6 refs/remotes/origin/master
> 
> refs/heads/master gets set to refs/remotes/origin/master post-fetch.

In general, this should fail.  Because you are expected to have local 
changes in the local branches.  What you describe suggests that you should 
not use the branch name "master" at all, but "origin/master".

That said, there is a pretty simple way to achieve what you want (even if 
it does not help the confusion you create between local and remote 
branches):

	git config --add remote.origin.fetch master:master

Of course, when you checkout "master" and pull then, you'll get even more 
problems, _exactly_ because you muddled up the clear distinction between 
local and remote branches.

Ciao,
Dscho
