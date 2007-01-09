From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: a few remaining issues...
Date: Wed, 10 Jan 2007 00:53:34 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701100051350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v7iw1hgvt.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701051453520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070105193306.GB8753@spearce.org> <Pine.LNX.4.63.0701091218080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vtzz0j6hf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 10 00:53:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Qmh-00084E-AU
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 00:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbXAIXxh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 18:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbXAIXxh
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 18:53:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:39154 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932552AbXAIXxg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 18:53:36 -0500
Received: (qmail invoked by alias); 09 Jan 2007 23:53:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 10 Jan 2007 00:53:34 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vtzz0j6hf.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36432>

Hi,

On Tue, 9 Jan 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Fri, 5 Jan 2007, Shawn O. Pearce wrote:
> >
> >> I myself am also severly lacking in time right now.
> >
> > Did you have any chance to look at the patch I posted? It adds 
> > "--walk-reflogs" option to the revision walker, and as long as there is 
> > reflog information, traverses the commits in that order. It also shows the 
> > reflog data just below the "commit" line.
> 
> What does it do when you say, for example:
> 
> 	git log --walk-reflogs master..next

It means that (ideally) all revisions are shown which are in the reflog 
chain of next, and _not_ in the reflog chain of master.

However, once the reflog traversal hits the oldest reflog entry, it 
reverts to commit parent traversal.

> I couldn't make heads or tails out of the patch and did not understand 
> what it was trying to do.  It looked as if you were making the log 
> traversal machinery to walk _both_ reflog (probably from the latest to 
> older) and the usual ancestry.

Yes, first reflog, then usual ancestry.

Would you want that changed to _only_ reflog traversal?

Ciao,
Dscho
