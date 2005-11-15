From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: pushing patches to an imap folder
Date: Tue, 15 Nov 2005 12:36:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511151227300.21902@wbgn013.biozentrum.uni-wuerzburg.de>
References: <43799A67.9030705@codeweavers.com> <7vd5l2qnq6.fsf@assigned-by-dhcp.cox.net>
 <4379B9F6.5020402@codeweavers.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 12:37:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ebz70-0005V5-BW
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 12:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbVKOLg1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 06:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbVKOLg1
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 06:36:27 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:61116 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750778AbVKOLg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 06:36:26 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7713613F78C; Tue, 15 Nov 2005 12:36:25 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5C5349F2E2; Tue, 15 Nov 2005 12:36:25 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 48EAF9C709; Tue, 15 Nov 2005 12:36:25 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E0A3B13F78C; Tue, 15 Nov 2005 12:36:24 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Mike McCormack <mike@codeweavers.com>
In-Reply-To: <4379B9F6.5020402@codeweavers.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11898>

Hi,

On Tue, 15 Nov 2005, Mike McCormack wrote:

> Junio C Hamano wrote:
> 
> > Hmph.  How well does the rest of git help your workflow, working with 
> > the Wine community?  Especially, how are you keeping track of and 
> > interoperating with their main CVS repository?
> 
> We have a (semi-experimental) wine.git tree, which is updated at the 
> same time as the Wine CVS, by the project maintainer:
> 
> http://source.winehq.org/git/wine.git

This is cool! I used to track wine with "git-cvsimport -i".

My work flow was like this (not with wine, since I did not have enough 
time to hack on it in the last months, but with other CVS managed 
projects):

"git-cvsimport -i" every once in a while, followed by "git pull . origin" 
(my working branch is always master).

When I have something interesting, I make a topic branch from origin ("git 
checkout -b eyes_apple origin"), and pick the interesting commits from 
master ("git cherry-pick SHA1").

Sometimes I pick multiple commits with the "-n" flag, so that I can hide 
my shortcomings, committing with the message of the first commit ("git 
commit -C SHA1").

Then, I use git-format-patch to generate the patches, which I hand-edit to 
make sure there is no typo, and no unwanted changes slipped in. Then, I 
send the message(s).

> It will probably be maintained in parallel with the Wine CVS for a while,
> unless somebody writes a GIT->CVS gateway.

It would be cool to have something like git-cvs-daemon, which simulates a 
CVS server.

Ciao,
Dscho
