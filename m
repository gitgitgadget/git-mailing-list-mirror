From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Submodules and rewind
Date: Wed, 20 Feb 2008 02:06:36 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0802200203440.8333@wbgn129.biozentrum.uni-wuerzburg.de>
References: <20080219140604.04afc91f@extreme> <20080219223201.GE4703MdfPADPa@greensroom.kotnet.org> <20080219152357.5ab397cf@extreme> <alpine.LSU.1.00.0802200033530.8333@wbgn129.biozentrum.uni-wuerzburg.de> <20080219161517.34fd5878@extreme>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: skimo@liacs.nl, skimo@kotnet.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Stephen Hemminger <shemminger@vyatta.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 02:07:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRdQY-00005g-Ji
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 02:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756616AbYBTBGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 20:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756552AbYBTBGj
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 20:06:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:47020 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755303AbYBTBGi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 20:06:38 -0500
Received: (qmail invoked by alias); 20 Feb 2008 01:06:37 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp021) with SMTP; 20 Feb 2008 02:06:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+dfR1GYOmdpRv6I7C/nfSsaOVAAs/aIGspEXUCm6
	bdGSf3Fn+fwg5c
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <20080219161517.34fd5878@extreme>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74492>

Hi,

On Tue, 19 Feb 2008, Stephen Hemminger wrote:

> On Wed, 20 Feb 2008 00:35:33 +0100 (CET)
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > On Tue, 19 Feb 2008, Stephen Hemminger wrote:
> > 
> > > On Tue, 19 Feb 2008 23:32:01 +0100
> > > Sven Verdoolaege <skimo@kotnet.org> wrote:
> > > 
> > > > On Tue, Feb 19, 2008 at 02:06:04PM -0800, Stephen Hemminger wrote:
> > > > > Because of a bone headed merge, I had to rewind one project back 
> > > > > to a known good state, but the sub module stuff is now wedged 
> > > > > and brain stuck on the old commit id.
> > > > > 
> > > > > Isn't there some simple way to do 'git sub-module remove' 
> > > > > followed by 'git sub-module add' to reset the internal index?
> > > > 
> > > > Why doesn't "git submodule update" work for you?
> > > > 
> > > 
> > > It didn't fix it, but recloning did.
> > 
> > That does not make sense.  But with your reluctance with regards to 
> > revealing details, it is really impossible to tell what is going on.
> > 
> > For example, you did not even once give us the output of "git 
> > submodule", let alone "git diff <submodule>".
> > 
> > Helpless,
> > Dscho
> 
> Don't be stupid,

Thanks, I'm trying, I'm trying.

BTW that "Helpless" was meant as "I cannot help you".

> $ git-submodule init
> Submodule 'pkgs/linux-image-2.6.23-1-486-vyatta' (http://git.vyatta.com/linux-vyatta.git) registered for path 'pkgs/linux-image-2.6.23-1-486-vyatta'

AFAICT this is your problem.  Your urls are http:// url, and do not end in 
a slash.

Yes, there was a fix recently, but apparently it was not enough.  With 
the slash, it should even work on older git.

Hth,
Dscho
