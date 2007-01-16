From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Replace rebase with filtering
Date: Tue, 16 Jan 2007 22:20:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701162218070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45AC3B5D.6080700@midwinter.com>
 <Pine.LNX.4.63.0701161216440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45AD2568.4040408@midwinter.com> <45AD2AE7.2010908@midwinter.com>
 <Pine.LNX.4.63.0701162131130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45AD383E.50105@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 22:20:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6vjP-0005rd-KL
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 22:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbXAPVUd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 16:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbXAPVUd
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 16:20:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:51728 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751293AbXAPVUc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 16:20:32 -0500
Received: (qmail invoked by alias); 16 Jan 2007 21:20:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp009) with SMTP; 16 Jan 2007 22:20:31 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Steven Grimm <koreth@midwinter.com>
In-Reply-To: <45AD383E.50105@midwinter.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36966>

Hi,

On Tue, 16 Jan 2007, Steven Grimm wrote:

> Johannes Schindelin wrote:
> > That is correct, but --ignore-if-in-upstream actually tests the hash of the
> > _diff_, not of the commit. So, if c really introduces the same change as f
> > (i.e. the diffs are identical), git-rebase will ignore f:
> > 
> > a---b---c---d
> >              \
> >               e'---g'
> > 
> > Totally untested, of course. But this is what --ignore-if-in-upstream was
> > written for.
> >   
> 
> Okay, great, that is certainly an improvement over what I thought was
> happening. But it won't work if you had to manually resolve a conflict during
> the rebase, yes? In that case the diffs would presumably not match.

Correct. There is no automatic way any program could verify that such a 
patch is indeed what is already in upstream.

Usually, however, this results in a conflict which you have to resolve. 
And _you_ do not have a hard time verifying that the patch already went 
in, and you just say "git rebase --skip" and the rebasing will continue 
_without_ having committed the now obsolete patch.

Ciao,
Dscho
