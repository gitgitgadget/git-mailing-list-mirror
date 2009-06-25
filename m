From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git pull merges current branch even when <dst> is specified
Date: Thu, 25 Jun 2009 11:44:17 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906251142550.5365@intel-tinevez-2-302>
References: <1245862052581-3149948.post@n2.nabble.com> <4A433AC8.4040702@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tom Lambda <tom.lambda@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jun 25 11:45:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJlVM-0002JW-4t
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 11:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbZFYJoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 05:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbZFYJoR
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 05:44:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:45038 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751312AbZFYJoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 05:44:16 -0400
Received: (qmail invoked by alias); 25 Jun 2009 09:44:17 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp006) with SMTP; 25 Jun 2009 11:44:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19bjIJaRExbtE6keaquA2A7EBeR6o8j07Pa408sEb
	Uxdg8nn0ornWGn
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4A433AC8.4040702@drmicha.warpmail.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122189>

Hi,

On Thu, 25 Jun 2009, Michael J Gruber wrote:

> Tom Lambda venit, vidit, dixit 24.06.2009 18:47:
> > 
> > If I am in 'master' and 'bugfix' is a remote branch in 'repo' which I do not
> > have locally yet, running:
> > 
> > git pull repo bugfix:bugfix
> > 
> > creates a new local branch 'bugfix' equals to 'repo/bugfix' as expected.
> > However, it also merges 'bugfix' into 'master', that surprises me since I
> > explicitly specify that <dst> is 'bugfix'.
> > 
> > I know that I can get what I want by running:
> > 
> > git fetch repo bugfix:bugfix
> > 
> > But the git-pull behavior looks odd to me. I thought that <dst> was the
> > current branch by default and it could be overridden by specifying it in the
> > command line.
> 
> Well, the first line of git-pull's man page says:
> 
> Runs git-fetch with the given parameters, and calls git-merge to merge
> the retrieved head(s) into the current branch.

To explain why this is so: Merging is an operation that requires a working 
directory, as merge conflicts can happen.  That is why merging is only 
possible locally, and only into the current branch.

Ciao,
Dscho
