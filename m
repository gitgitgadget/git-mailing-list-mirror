From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Minor portability patch to git-submodule
Date: Tue, 18 Dec 2007 14:01:28 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712181357150.23902@racer.site>
References: <Pine.LNX.4.64.0712171639420.24957@fractal.phys.lafayette.edu>
 <Pine.LNX.4.64.0712172253150.9446@racer.site>
 <Pine.LNX.4.64.0712180734520.28219@fractal.phys.lafayette.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andy Dougherty <doughera@lafayette.edu>
X-From: git-owner@vger.kernel.org Tue Dec 18 15:02:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4d1R-0001vf-63
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 15:02:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756128AbXLROBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 09:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756073AbXLROBo
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 09:01:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:53025 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755938AbXLROBn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 09:01:43 -0500
Received: (qmail invoked by alias); 18 Dec 2007 14:01:41 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 18 Dec 2007 15:01:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19lmKMsKNllzPfLfymeuOdXx50hW1w6ygzw9rZEp5
	4wflBsc8Jypkr/
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0712180734520.28219@fractal.phys.lafayette.edu>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68748>

Hi,

On Tue, 18 Dec 2007, Andy Dougherty wrote:

> On Mon, 17 Dec 2007, Johannes Schindelin wrote:
> 
> > On Mon, 17 Dec 2007, Andy Dougherty wrote:
> > 
> > > -	git ls-files --stage -- "$@" | grep -e '^160000 ' |
> > > +	git ls-files --stage -- "$@" | egrep -e '^160000 ' |
> > 
> > Nack.  egrep is not available on all platforms.  But then I have to 
> > wonder why not saying "grep '^160000 '" instead?
> 
> Your last suggestion is easily and obviously better -- I'll assume you 
> don't need an explicit patch and can just hand-edit mine.  Still, I'd have 
> thought egrep was fine.  As far as I recall, it goes back to v7 Unix.

This is just another instance where we should look at existing systems 
and not so much at standards documents.

> Or are there non-unix systems at issue (perhaps cygwin variants or 
> something) that have grep but not egrep?

Well, I checked msysGit, and it has it.

That is, kind of: it is just a wrapper, calling "grep -E".  Which means 
yet another fork() on a fork() challenged platform, so I would appreciate 
it if we could avoid it.

Thanks,
Dscho
