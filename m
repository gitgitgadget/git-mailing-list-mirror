From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Organizing (large) test data in git
Date: Tue, 27 Feb 2007 21:22:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702272119430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17892.28995.328911.23188@lisa.zopyra.com>
 <Pine.LNX.4.63.0702272049560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17892.36336.249022.904854@lisa.zopyra.com>
 <Pine.LNX.4.63.0702272113430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17892.37416.358405.211524@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Feb 27 21:22:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM8qK-0008Eo-6B
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 21:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1749667AbXB0UWd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 15:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbXB0UWd
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 15:22:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:43390 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1749667AbXB0UWd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 15:22:33 -0500
Received: (qmail invoked by alias); 27 Feb 2007 20:22:31 -0000
X-Provags-ID: V01U2FsdGVkX18E8I1Y0j8EOML/XVeKbCsplPyeuWQEyyn0YvcywU
	qGkw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <17892.37416.358405.211524@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40784>

Hi,

On Tue, 27 Feb 2007, Bill Lear wrote:

> On Tuesday, February 27, 2007 at 21:14:07 (+0100) Johannes Schindelin writes:
> >> 
> >> Welll... it's not really a matter of capacity, though I do agree that
> >> lifting that limit will help.  We are more concerned with time to
> >> clone the repos over the (often very slow) corporate network, for
> >> example.  With future ratios of about 1% code to 99% test data, we
> >> hither and yon with little care, and a monster data repo that is
> >> (somehow) sanely managed with git as well.  I was just curious if
> >> others had run into the management problems that I mentioned with
> >> separating test data from code and what they may have done to surmount
> >> them.
> >
> >Okay I misunderstood, then.
> >
> >Do shallow clones help you?
> 
> Hmm, can't answer now, since I don't know what these are.  I shall
> investigate and see if they do.

Basically, shallow clones cut off branches at some point, even if those 
commits have references to their parents.

For example, if you have a linear branch HEAD~1000..HEAD, and you want to 
get just the latest two commits, a shallow clone will give you just 
HEAD~1..HEAD, pretending that HEAD~1 is a root commit (a commit without 
parents), when it is not.

But if you do not care for history, instead just for being up-to-date, it 
should help you.

Ciao,
Dscho

P.S.: And no, I don't remember if you need to say "--depth 2" or "--depth 
1" for that... Sorry
