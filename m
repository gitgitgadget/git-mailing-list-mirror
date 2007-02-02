From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Fri, 2 Feb 2007 10:32:17 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702021027450.15057@woody.linux-foundation.org>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
 <200702010058.43431.jnareb@gmail.com> <20070201003429.GQ10108@waste.org>
 <200702021055.49428.jnareb@gmail.com> <slrnes6mmr.3l6.mdw@metalzone.distorted.org.uk>
 <epvnln$fmn$1@sea.gmane.org> <Pine.LNX.4.64.0702020835550.15057@woody.linux-foundation.org>
 <20070202175923.GA6304@xanadu.kublai.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, mercurial@selenic.com,
	git@vger.kernel.org
To: Brendan Cully <brendan@kublai.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 19:32:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD3DE-00029E-Qy
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 19:32:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946024AbXBBSci (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 13:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946026AbXBBSch
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 13:32:37 -0500
Received: from smtp.osdl.org ([65.172.181.24]:34176 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946024AbXBBSch (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 13:32:37 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l12IWI43012569
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 2 Feb 2007 10:32:18 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l12IWHfk014566;
	Fri, 2 Feb 2007 10:32:17 -0800
In-Reply-To: <20070202175923.GA6304@xanadu.kublai.com>
X-Spam-Status: No, hits=-0.416 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38524>



On Fri, 2 Feb 2007, Brendan Cully wrote:

> On Friday, 02 February 2007 at 08:42, Linus Torvalds wrote:
> > 
> > 
> > On Fri, 2 Feb 2007, Jakub Narebski wrote:
> > > 
> > > Gaaah. Why anyone would want to have non-propagated tags?
> > 
> > That's *definitely* not the mistake.
> > 
> > I use private tags (and branches, for that matter) all the time. I'd be 
> > very upset indeed if all my tags were always pushed out when I push 
> > something out.
> > 
> > The mistake seems to be to think that tags get "versioned", and are part 
> > of the tree history. That's insane. It means that you can never have a tag 
> > to a newer tree than the one you are on.
> 
> The tags you use can simply be those from the tip of the repository,
> regardless of which revision you've currently checked out.

Did you not understand the problem?

If I want to push out my history, that does NOT mean that I don't want to 
push out my tags. At least not to the public sites. I migth want to push 
them out to my other *private* copies, though.

In other words, tags are just like branches. You don't tie two tags 
together, because one may (and does) make sense without the other.

Tying tags into history is silly. They're not "part of" history. They are 
pointers *to* history. And trying to make them part of history has all 
these obvious problems.

			Linus
