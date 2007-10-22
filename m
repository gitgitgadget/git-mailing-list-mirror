From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Mon, 22 Oct 2007 14:06:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710221305230.32497@iabervon.org>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com> 
 <Pine.LNX.4.64.0710130130380.25221@racer.site>  <1192827476.4522.93.camel@cacharro.xalalinux.org>
  <4719B655.90204@op5.se> <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de>
 <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com>
 <Pine.LNX.4.64.0710210031130.25221@racer.site> <471AFD07.4040606@op5.se>
 <Pine.LNX.4.64.0710212308540.25221@racer.site> <471C586A.9030900@op5.se>
 <Pine.LNX.4.64.0710221156540.25221@racer.site> <471C9B13.9080603@op5.se>
 <Pine.LNX.4.64.0710221445170.25221@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Jakub Narebski <jnareb@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 20:06:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik1fL-0002El-QQ
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 20:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbXJVSGD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 14:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbXJVSGD
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 14:06:03 -0400
Received: from iabervon.org ([66.92.72.58]:45666 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460AbXJVSGB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 14:06:01 -0400
Received: (qmail 14134 invoked by uid 1000); 22 Oct 2007 18:06:00 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Oct 2007 18:06:00 -0000
In-Reply-To: <Pine.LNX.4.64.0710221445170.25221@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62034>

On Mon, 22 Oct 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 22 Oct 2007, Andreas Ericsson wrote:
> 
> > If I were to suggest any improvements, it'd be to change the semantics of
> > git-pull to always update the local branches set up to be merged with the
> > remote tracking branches when they, prior to fetching, pointed to the same
> > commit, such that when
> > 
> > $ git show-ref master
> > d4027a816dd0b416dc8c7b37e2c260e6905f11b6 refs/heads/master
> > d4027a816dd0b416dc8c7b37e2c260e6905f11b6 refs/remotes/origin/master
> > 
> > refs/heads/master gets set to refs/remotes/origin/master post-fetch.
> 
> In general, this should fail.  Because you are expected to have local 
> changes in the local branches.  What you describe suggests that you should 
> not use the branch name "master" at all, but "origin/master".

If you push your changes to the origin soon after making them, you'll only 
have local changes if somebody else changed something while you were 
working on a change. You're expected to create local changes in the local 
branches, but you shouldn't generally sit on them forever, and when you've 
pushed them, you no longer have any difference in content between local 
and remote.

If the project has multiple branches in the central repository, and you 
make changes for each of them at different times, but only one each day, 
the normal case will be to have local changes sitting in at most one of 
the branches, and, in particular, no local changes left in any branch 
other than HEAD.

	-Daniel
*This .sig left intentionally blank*
