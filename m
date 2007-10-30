From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: backup or mirror a repository
Date: Tue, 30 Oct 2007 00:33:05 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0710300030530.4362@racer.site>
References: <1190921742.2263.17.camel@Tenacity> <Pine.LNX.4.64.0709272255360.28395@racer.site>
 <1190940704.2263.32.camel@Tenacity> <Pine.LNX.4.64.0709280253150.28395@racer.site>
 <1190947063.2263.46.camel@Tenacity> <7vsl4zqp8l.fsf@gitster.siamese.dyndns.org>
 <20071018053226.GA20588@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dan Farina <drfarina@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 01:34:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imf3P-0004JD-Ku
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 01:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880AbXJ3Adq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 20:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752844AbXJ3Adq
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 20:33:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:46110 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752744AbXJ3Adp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 20:33:45 -0400
Received: (qmail invoked by alias); 30 Oct 2007 00:33:43 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp052) with SMTP; 30 Oct 2007 01:33:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18CbN0MMmYCOGWaPlvFxN/+co16cXbLadncHC8Nsp
	sTWY1L0114p4Oq
X-X-Sender: gene099@racer.site
In-Reply-To: <20071018053226.GA20588@dpotapov.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62636>

Hi,

On Thu, 18 Oct 2007, Dmitry Potapov wrote:

> On Thu, Sep 27, 2007 at 11:27:06PM -0700, Junio C Hamano wrote:
> > The "git remote add --mirror" setup is about setting up the
> > local repository _AS_ the backup of the remote.  In other words,
> > the contents come from the remote by fetching from it and safely
> > kept away from disaster on the local side.  And for that,
> > "remote prune" is a perfect thing to do.
> 
> I have tried to do that but I am getting a warning:
> $ git remote prune origin
> Warning: unrecognized mapping in remotes.origin.fetch: +refs/*:refs/*
> and no branch is removed.
> 
> I suspect that the change that introduced --mirror option for the 'add' 
> command did not adjust the prune procedure to handle the new situation 
> properly. Or is just me doing something wrong?

No, you're right.  I did not anticipate git-remote to be written the way 
it is.  After fiddling with it for several hours, I am giving up for now.  
IMHO the script is too married to the idea that the remote branches live 
in refs/remotes/<remote>/*.  Probably it would be very easy by now to 
implement it as a builtin, using remote.[ch].

Ciao,
Dscho
