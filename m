From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-bundle - bundle objects and references for disconnected
 transfer.
Date: Thu, 15 Feb 2007 01:15:33 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702150114230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11714622292110-git-send-email-mdl123@verizon.net>
 <11714622292295-git-send-email-mdl123@verizon.net>
 <Pine.LNX.4.63.0702142238310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D398F9.6070205@verizon.net> <45D3A18E.40309@verizon.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Thu Feb 15 01:15:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHUHi-0004iI-MN
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 01:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbXBOAPg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 19:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbXBOAPg
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 19:15:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:44518 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750745AbXBOAPf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 19:15:35 -0500
Received: (qmail invoked by alias); 15 Feb 2007 00:15:34 -0000
X-Provags-ID: V01U2FsdGVkX186qBZyvYg6lFwgShmj4Jd8sf+7GWovkoxFO8Y0cj
	Bdgw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45D3A18E.40309@verizon.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39778>

Hi,

On Wed, 14 Feb 2007, Mark Levedahl wrote:

> Mark Levedahl wrote:
> > Johannes Schindelin wrote:
> > 
> > > 
> > > Would it not be better to say explicitely which refs are expected to be
> > > present already (they start with "^" in the output of `git-rev-parse`,
> > > but you would need to do a bit more work, since you cannot just take the
> > > symbolic names).
> > > 
> > > IMHO reliance on $(git fsck | grep ^missing) is not good. The file check
> > > might take very, very long, or use much memory. And you _can_ do better
> > > [*1*].
> > >   
> > Good idea, but I think it is simpler to just keep the ^... output from
> > git-rev-parse and check that those exist. What you suggest below seems to
> > presume all bases are themselves references, which is not the case when
> > doing, for example, master~10..master.
>
> Examining further, I just don't know how to do this in shell. Basically, 
> what I want is the list of parents of all bases,

I don't think you need the bases. If you say "master~10..master" on the 
sender side, you want to update master on the receiving side, _after_ you 
verified that receiver already has "master~10".

Ciao,
Dscho
