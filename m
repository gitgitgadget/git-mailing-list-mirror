From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Organizing (large) test data in git
Date: Tue, 27 Feb 2007 21:51:35 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702272148350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17892.28995.328911.23188@lisa.zopyra.com>
 <Pine.LNX.4.63.0702272049560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17892.36336.249022.904854@lisa.zopyra.com>
 <Pine.LNX.4.63.0702272113430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17892.37416.358405.211524@lisa.zopyra.com>
 <Pine.LNX.4.63.0702272119430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17892.38760.241965.552855@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Feb 27 21:51:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM9IU-00042F-Ev
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 21:51:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585AbXB0Uvi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 15:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752586AbXB0Uvi
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 15:51:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:50658 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752585AbXB0Uvg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 15:51:36 -0500
Received: (qmail invoked by alias); 27 Feb 2007 20:51:35 -0000
X-Provags-ID: V01U2FsdGVkX1+Z4PxH4tCZkJXc8xO3RpFMrFPKNF5oLSAqqxtoDX
	FhPA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <17892.38760.241965.552855@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40803>

Hi,

On Tue, 27 Feb 2007, Bill Lear wrote:

> On Tuesday, February 27, 2007 at 21:22:31 (+0100) Johannes Schindelin writes:
>
> > Basically, shallow clones cut off branches at some point, even if 
> > those commits have references to their parents.
> 
> Ah, so a sort of temporal surgery.
> 
> I don't think this will help, and I don't think this is a unique git 
> issue, either.  It happens with any system, I would think.
> 
> Let's say I have 6 code repos on my system and one data repo.  If I make 
> changes in one of my code repos that requires a test data change, I have 
> to move to my test data repo, make the change there, and commit there.  
> Then, back in my code repo, I commit also.
> 
> Now, instead of one tidy package (a commit) that holds code and test 
> together in a coherent package, I have two separate commits in two repos 
> that now have to be coordinated.  Imagine I do more changes in similar 
> fashion, and others do as well.  Now our lead of the QA department is 
> pulling his hair out, trying to figure out which commits in the data 
> directory match those in the code directory so he can do regressions 
> properly.

So, it is _not_ a transport question.

Why not reference the commit name (the SHA1) of the commit changing 
behaviour in the commit of the test repo? Like: if abcdef0123 changes a 
certain output format, and this is expected, fix the test, and include a 
line "Reference-Commit: abcdef0123" in the test repo.

This could even be done automatically by a simple script to commit 
changes after fixing an issue both in the source _and_ test repo...

Ciao,
Dscho
