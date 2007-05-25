From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Fri, 25 May 2007 15:16:56 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705251514220.4648@racer.site>
References: <Pine.LNX.4.64.0705240039370.4113@racer.site>
 <200705251427.46903.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0705251343550.4648@racer.site>
 <200705251559.53846.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Lars Hjemli <hjemli@gmail.com>, skimo@liacs.nl,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 25 16:17:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrabi-0002UP-BU
	for gcvg-git@gmane.org; Fri, 25 May 2007 16:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756524AbXEYORF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 10:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759467AbXEYORF
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 10:17:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:43158 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756524AbXEYORC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 10:17:02 -0400
Received: (qmail invoked by alias); 25 May 2007 14:17:00 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp038) with SMTP; 25 May 2007 16:17:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18NGRwEa04NWfHq2m5PAXF4vh3u7sZduayUpC3wcd
	RcqL0ylswkZ/gd
X-X-Sender: gene099@racer.site
In-Reply-To: <200705251559.53846.Josef.Weidendorfer@gmx.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48380>

Hi,

On Fri, 25 May 2007, Josef Weidendorfer wrote:

> On Friday 25 May 2007, Johannes Schindelin wrote:
> > > I assume you talk about a versioned .gitmodules file tied to the
> > > superproject history, and any fetch/pull would look into this
> > > file from the current working directory to lookup the default URL.
> > > 
> > > Wouldn't this have the problem that when you check out an old
> > > revision of the superproject you get out-of-date URLs, so that
> > > a fetch does not work (without local overrides)?
> > 
> > If you check out an old revision, wouldn't you have that _already_, so it 
> > does not matter what URL is given in .gitmodules?
> 
> Not necessary.
> * Submodules can appear/disappear any time in the superproject.
> Therefore, going back in time can make it necessary to have to clone
> a submodule you did not have before.
> * Not every submodule is interesting for every developer; therefore,
> an important design-decision for submodules is to allow at git-clone time
> to not clone some submodules at all. However, you can change your mind and
> want to follow a given submodule later.

Okay, so there are exceptions to the rule, just as everywhere.

We already talked about being able to override .gitmodules from 
.git/config. I think that should really, really be sufficient, as you 
cannot hope to have a one-size-fits-them-all solution for the exceptions 
you described. You'll have to cope with them manually anyway.

We should not design for the exception. Therefore I think the .gitmodules, 
overrideable by .git/config is sufficient.

And the point about my config being private still stands. You have no 
business looking into my config.

Ciao,
Dscho
