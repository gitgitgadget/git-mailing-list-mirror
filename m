From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git in a Nutshell guide
Date: Thu, 22 Nov 2007 15:24:23 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711221522540.4725@wbgn129.biozentrum.uni-wuerzburg.de>
References: <1195477504.8093.15.camel@localhost>  <fhsc7b$k4g$1@ger.gmane.org>
 <1195737303.19260.27.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jonas Juselius <jonas@iki.fi>
X-From: git-owner@vger.kernel.org Thu Nov 22 15:24:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvCz1-00058q-DN
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 15:24:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbXKVOYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 09:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbXKVOYa
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 09:24:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:52295 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751676AbXKVOY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 09:24:29 -0500
Received: (qmail invoked by alias); 22 Nov 2007 14:24:27 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp006) with SMTP; 22 Nov 2007 15:24:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/yE3cL9pPye8ezNVxXLXAvVPXaHUNVRYG9IX1Wqb
	ejS4l+vVqqL+Dm
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <1195737303.19260.27.camel@localhost>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65826>

Hi,

On Thu, 22 Nov 2007, Jonas Juselius wrote:

> Suppose I have been working on some topic branch for a while and been 
> overly trigger happy, i.e. I have produced a ridiculous number of 
> commits along the way. At some point when I'm done I want to publish my 
> changes, but doing so would create an insanely obese history full of 
> near nonsense commits. What I want to do is to slim down the commit log 
> into pieces that actually makes sense. What is the preferred (or best, 
> most convenient) way of doing this? The way I have done this previously 
> is essentially:
> 
> 1.  git branch -m mytopic tmp_mytopic  # rename
> 2.  git branch mytopci tmp_mytpoic~42  # go back in history
> Loop:
> 3.1 git log; git diff; git annotate...
> 3.2 git diff tmp_mytopic~42..tmp_mytopic~33 | git-apply
> 3.3 git commit -m "sane commit message" -a
> 4.  git branch -d tmp_mytopic
> 
> If I need to reorder commits I can first use git-rebase -i to get
> everything streamlined. There must be a better way of doing this, right?

Yes, you can squash commits into previous commits with rebase -i.  Just 
replace the second "pick" command (and if you want to squash more than 
two, the later commands, too) with "squash".

Hth,
Dscho
