From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-bundle - bundle objects and references for disconnected
   transfer.
Date: Thu, 15 Feb 2007 16:35:42 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702151632270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11714622292110-git-send-email-mdl123@verizon.net>
 <11714622292295-git-send-email-mdl123@verizon.net>
 <Pine.LNX.4.63.0702142238310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D398F9.6070205@verizon.net> <45D3A18E.40309@verizon.net>
 <Pine.LNX.4.63.0702150114230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D3C1DB.9020009@verizon.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Thu Feb 15 16:58:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHieJ-0007eh-OS
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 16:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbXBOPfo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 10:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbXBOPfo
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 10:35:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:51412 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751657AbXBOPfo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 10:35:44 -0500
Received: (qmail invoked by alias); 15 Feb 2007 15:35:42 -0000
X-Provags-ID: V01U2FsdGVkX186NCBShWI6gE3NJ+RtgGyVoJvEQ1FxZY932MQ/sf
	8djw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45D3C1DB.9020009@verizon.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39832>

Hi,

On Wed, 14 Feb 2007, Mark Levedahl wrote:

> Johannes Schindelin wrote:
> > 
> > On Wed, 14 Feb 2007, Mark Levedahl wrote:
> > 
> > > Mark Levedahl wrote:
> > > > Johannes Schindelin wrote:
> > > > 
> > 
> > I don't think you need the bases. If you say "master~10..master" on 
> > the sender side, you want to update master on the receiving side, 
> > _after_ you verified that receiver already has "master~10".
> > 
> git>git-rev-parse master~10..master
> dc0f74905bd94b88d3b1d477e79faef7e0308fbf
> ^602598fd5d8f64028f84d2772725c5e3414a112f
> 
> Which shows the new head and the commit that the destination needs. That 
> is fine. But:
> 
> git>git-rev-parse master --since=10.days.ago
> dc0f74905bd94b88d3b1d477e79faef7e0308fbf
> --max-age=1170641182
> 
> is not helpful: it does not tell what is expected to be on the other 
> end. And I find both forms absolutely useful in the ways I use 
> git-bundle.

You're right.

But instead of doing this with Python or by hand, why not make the 
"--boundary" option useful in that case?

> I have found in practice my current solution of git-fsck to be much 
> faster.

It is only faster since you unpack the objects. Which makes almost every 
other operation slow.

Ciao,
Dscho
