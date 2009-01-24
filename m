From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Heads up: major rebase -i -p rework coming up
Date: Sat, 24 Jan 2009 22:09:36 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901242206540.14855@racer>
References: <alpine.DEB.1.00.0901242056070.14855@racer> <7vpricmoda.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901242156320.14855@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Stephen Haberman <stephen@exigencecorp.com>,
	spearce@spearce.org, Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Junio C Hamano <gitster@pobox.com>, Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Jan 24 22:11:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQpmU-0006Km-NV
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 22:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755803AbZAXVJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 16:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755742AbZAXVJK
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 16:09:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:51010 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755614AbZAXVJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 16:09:09 -0500
Received: (qmail invoked by alias); 24 Jan 2009 21:09:06 -0000
Received: from pD9EB3F9A.dip0.t-ipconnect.de (EHLO noname) [217.235.63.154]
  by mail.gmx.net (mp004) with SMTP; 24 Jan 2009 22:09:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+J7vp8ec+JfnN5RJh0fYc0qRflIJbHRUrNFwzRb3
	NU+cD8ibI8D95g
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0901242156320.14855@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107009>

Hi,

On Sat, 24 Jan 2009, Johannes Schindelin wrote:

> > - Why do you need "merge D' was E"?  Shouldn't "pick E" be able to 
> >   notice that E is a merge and decompose it into "merge D' was E"  
> >   internally?
> > 
> >   This one I am somewhat complaining, unless your answer is "because 
> >   this way the user could drop some parents from the merge in the 
> >   editor".
> 
> Not only that; the user could use this to fix mismerges, i.e. by 
> replacing a SHA-1 with the SHA-1 (or indeed, a short name, unless it is 
> "was") of the branch that she _actually_ wanted to merge with.
> 
> >   And if your answer is that, then my next question will be "if that 
> >   is the case, can the user be expected to easily find out which 
> >   commit each parent SHA-1 refers to, without having more hint on the 
> >   'merge' insn line?"
> 
> Nope.
> 
> In most cases, however, that should be plenty enough:
> 
> 	merge 9383af1' was f39d50a Merge branch 'mh/unify-color' into next
> 
> The user does not have to guess much what 9383af1 might refer to.

Heh, I think it is much easier than I thought:  How about this?

 	merge 9383af1' was f39d50a Merge branch 'mh/unify-color' into next
	#   \ 9383af1 Revert previous two commits

Obviously, for octopodes, there would be multiple "#   \ <SHA-1> <oneline>" 
lines...

Ciao,
Dscho
