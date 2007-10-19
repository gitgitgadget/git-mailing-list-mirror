From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git push bug?
Date: Fri, 19 Oct 2007 19:24:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0710191920210.16728@wbgn129.biozentrum.uni-wuerzburg.de>
References: <1192719040.9433.5.camel@gentoo-jocke.transmode.se> 
 <0DAC53EF-021D-441C-9520-9795AAB6DE54@zib.de>  <1192723269.9433.21.camel@gentoo-jocke.transmode.se>
  <Pine.LNX.4.64.0710181720010.25221@racer.site> 
 <1192725116.4954.7.camel@gentoo-jocke.transmode.se> 
 <Pine.LNX.4.64.0710182259190.25221@racer.site> <1192805255.1875.25.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>, git <git@vger.kernel.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Fri Oct 19 19:26:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iivbo-0007GB-2D
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 19:26:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935858AbXJSRYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 13:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935712AbXJSRYp
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 13:24:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:41439 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1765502AbXJSRYn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 13:24:43 -0400
Received: (qmail invoked by alias); 19 Oct 2007 17:24:41 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp051) with SMTP; 19 Oct 2007 19:24:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+2qcwjzMq2KVRob5JnasYPYovJsYD9HM1cY3N/Xs
	waTJf+NfweIGmd
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <1192805255.1875.25.camel@gentoo-jocke.transmode.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61735>

Hi,

On Fri, 19 Oct 2007, Joakim Tjernlund wrote:

> On Thu, 2007-10-18 at 23:00 +0100, Johannes Schindelin wrote:
> > 
> > On Thu, 18 Oct 2007, Joakim Tjernlund wrote:
> > 
> > > First, I didn't know that I could do that. Secondly, I was also 
> > > looking do v2.6.23:linus refspecs
> > 
> > 
> > First, then our documentation could be better.  How?
> 
> Well, it isn't clear to me how all this is supposed to work and what is 
> bugs. Clearifying that would help.
> 
> For instances I did a push with v2.6.23:refs/heads/linus and now I got a 
> branch with the SHA1 of v2.6.23 
> tag(0b8bc8b91cf6befea20fe78b90367ca7b61cfa0d) in it. Makes gitk display 
> that branch as "linus^{}".

It strikes me as really odd that you would _want_ to create a branch 
remotely, that has _never_ existed locally.

> > Second, why not "git checkout -b linus v2.6.23 && git push origin 
> > linus"?
> 
> An extra checkout that takes time but works.

Not only that: before trying to publish something, I would have expected 
you to have that branch locally, and that you actually worked on it.

> Doesn't make the above "weiredness" go away though.

Yes it does.

git checkout -b <branchname> resolves to the commit that the tag pointed 
to.  So it would not push a tag, which you did.

Of course you could do what you planned to do, if you knew git better.  
But you are not familiar enough with git's inner workings yet, so I 
suggest to stay with things for now that work _always_, and exactly as 
expected.

Such as creating a branch locally, with exactly the name that you plan it 
to have remotely, and then pushing it with "git push origin <branchname>".  
Easy as apple pie.

Ciao,
Dscho
