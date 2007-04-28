From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] Introduces for_each_revision() helper
Date: Sat, 28 Apr 2007 14:52:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704281451510.12006@racer.site>
References: <11776932123749-git-send-email-lcapitulino@mandriva.com.br>
 <1177693212202-git-send-email-lcapitulino@mandriva.com.br>
 <Pine.LNX.4.64.0704280446180.12006@racer.site> <20070428115059.GA4888@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>,
	junkio@cox.net, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 28 14:52:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhmPh-0007ZX-UA
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 14:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754644AbXD1Mwa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 08:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756124AbXD1Mwa
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 08:52:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:40486 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754644AbXD1Mw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 08:52:28 -0400
Received: (qmail invoked by alias); 28 Apr 2007 12:52:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp021) with SMTP; 28 Apr 2007 14:52:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18+XTsScUA+6cMc/BrQXV4ay7M4529QTzhP4HGs/A
	OFrsZ1eaAGFCOu
X-X-Sender: gene099@racer.site
In-Reply-To: <20070428115059.GA4888@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45777>

Hi,

On Sat, 28 Apr 2007, Alex Riesen wrote:

> Johannes Schindelin, Sat, Apr 28, 2007 04:46:41 +0200:
> > > +#define for_each_revision(commit, rev) \
> > > +	for (prepare_revision_walk(rev); \
> > > +		  (commit = get_revision(rev)) != NULL; )
> > > +
> > >  #endif
> > 
> > I object to this, additionally to the magic argument that I agree to, on 
> > the grounds that it is actually wrong. The first iteration will work on an 
> > _uninitialized_ "commit" variable.
> 
> No, it wont. Check it. This code is correct.

Yes, sorry, as I admitted in my reply to Junio, there was some serious 
mental temporary disability involved.

> > Furthermore, it is not like it was a huge piece of code that is being 
> > replaced by a shortcut. There are better places to do some 
> > libification than this.
> 
> It is not about libification. It is plain readability issue. Look at 
> what list_for_each_* macros did to the source of Linux kernel.

Personally, I find the prepare/get_revision stuff not really too 
unreadable.

Ciao,
Dscho
