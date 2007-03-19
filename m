From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Libification project (SoC)
Date: Mon, 19 Mar 2007 13:37:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703191329220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070316042406.7e750ed0@home.brethil>  <20070316060033.GD31606@spearce.org>
  <7vps79wueu.fsf@assigned-by-dhcp.cox.net> 
 <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
 <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de> 
 <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
 <20070318140816.GG4489@pasky.or.cz>  <Pine.LNX.4.63.0703190045520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
  <20070319012111.GS18276@pasky.or.cz> 
 <Pine.LNX.4.63.0703190235330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550703190001k761541c7v2c259ef3f7695b10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Rocco Rutte <pdmef@gmx.net>,
	git@vger.kernel.org, tytso@mit.edu, spearce@spearce.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 13:37:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTH7W-0007dD-NP
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 13:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933849AbXCSMhX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 08:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933845AbXCSMhW
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 08:37:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:47295 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933849AbXCSMhV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 08:37:21 -0400
Received: (qmail invoked by alias); 19 Mar 2007 12:37:19 -0000
X-Provags-ID: V01U2FsdGVkX19pFAh9Kr9pALuFaBT3nVq/erskJjXgl2x9I5JJXx
	Bj1ksvOMaoLUXI
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <e5bfff550703190001k761541c7v2c259ef3f7695b10@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42610>

Hi,

On Mon, 19 Mar 2007, Marco Costalba wrote:

> On 3/19/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > I don't see _any_ problem in making an API which works with _one_ repo
> > first. This has several advantages:
> > 
> > - most users (if any!) will work that way,
> > 
> 
> Sometime could be useful to write a list of possible users before
> starting to code.

Fair enough.

I expect the most visible users of libgit to be: the core Git programs! 
Because if we don't eat our own dog food, why should anybody else?

And I am absolutely utterly opposed to make them slower just to support a 
program which wants to cache meta data from multiple repositories.

Yes, you could write a program which can compare objects from several 
repos, but that is easy in fact: just set GIT_ALTERNATE_OBJECT_DIRECTORIES 
and you're done. Without changing the core of Git at all!

Having said that, I never liked the idea of having static variables to 
talk with config handlers, and would have preferred cb_data like 
for_each_ref() does. That is a low hanging fruit, which does not affect 
performance, and is _definitely_ a clean up.

I am not so sure about the impact of changing the index to a non-static 
structure.

Ciao,
Dscho
