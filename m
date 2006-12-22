From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git (stable)
Date: Fri, 22 Dec 2006 20:21:02 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612221949490.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vodpw46zj.fsf@assigned-by-dhcp.cox.net> <86k60jsvh8.fsf@blue.stonehenge.com>
 <86fyb7sv9f.fsf@blue.stonehenge.com> <Pine.LNX.4.63.0612221902490.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <861wmrsstc.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 20:21:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxpxk-0000JN-1C
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 20:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbWLVTV0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 14:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbWLVTV0
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 14:21:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:49420 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752113AbWLVTVF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 14:21:05 -0500
Received: (qmail invoked by alias); 22 Dec 2006 19:21:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp053) with SMTP; 22 Dec 2006 20:21:03 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <861wmrsstc.fsf@blue.stonehenge.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35197>

Hi,

On Fri, 22 Dec 2006, Randal L. Schwartz wrote:

> >>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> 
> >>>>> writes:
> 
> >> Ahh, it's "git-pull . origin".
> 
> Johannes> This is just a merge, not a real pull (it leaves out the fetch 
> Johannes> part).
> 
> OK, so what does what a naked "git-pull" used to do before, which was 
> "fetch origin, then pull it into the current branch"?

$ git repo-config branch.xyz.remote origin
$ git repo-config branch.xyz.merge refs/heads/<whateveryourfirstfetchis>

> Johannes> So, for each branch (e.g. "xyz") for which you have a 
> Johannes> preferred upstream (e.g. remote "linus" with branch
> Johannes> "master"), say
> 
> Johannes> 	$ git repo-config branch.xyz.remote linus
> Johannes> 	$ git repo-config branch.xyz.merge refs/heads/master
> 
> But that's not upward compatible.  The default should be the old 
> behavior, or we need a better way to notify people that this breaks 
> things.

AFAIK it is not in maint. Not even in 1.4.4.3. So, you got it with master.

So, TFA should have been in a message "What's in git (stable)". 
Alas, the commit a71fb0a1: "git-pull: refuse default merge without 
branch.*.merge" was merged _after_ the latest announcement.

HOWEVER, it has been in "What's cooking in git (topics)".

Having said that, we could (at least for some time) print a big red 
warning for the specific case of "git pull" meaning "git pull origin 
<whateveristhefirstfetchedhead>" that this will GO AWAY SOON.

Of course, you would not see it. Only your script.

BTW I would _never_ allow a script to rely on such a DWIM feature.

Ciao,
Dscho
