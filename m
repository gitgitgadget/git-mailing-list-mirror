From: Johan Herland <johan@herland.net>
Subject: Re: [RFC] git integrated bugtracking
Date: Sun, 03 Jun 2007 15:48:29 +0200
Message-ID: <200706031548.30111.johan@herland.net>
References: <20070603114843.GA14336@artemis>
 <878xb19ot5.fsf@graviton.dyn.troilus.org> <20070603133109.GD14336@artemis>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Pierre Habouzit <madcoder@debian.org>,
	Michael Poole <mdpoole@troilus.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 03 15:48:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuqRn-0007Zy-B7
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 15:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbXFCNsf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 09:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbXFCNsf
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 09:48:35 -0400
Received: from smtp.getmail.no ([84.208.20.33]:56997 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbXFCNse (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 09:48:34 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJ200H05BOWJ600@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 03 Jun 2007 15:48:32 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJ200D0CBOU9FB0@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 03 Jun 2007 15:48:30 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJ2002WSBOUFM50@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 03 Jun 2007 15:48:30 +0200 (CEST)
In-reply-to: <20070603133109.GD14336@artemis>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48997>

On Sunday 03 June 2007, Pierre Habouzit wrote:
> On Sun, Jun 03, 2007 at 08:59:18AM -0400, Michael Poole wrote:
> > Pierre Habouzit writes:
> >
> > >   The other problem I see is that at the time a bug gets reported, the
> > > user knows it's found at a commit say 'X'. But it could in fact have
> > > been generated at a commit Y, with this pattern:
> > >
> > >   --o---o---Y---o---o---o---o---X---o---o--> master
> > >                      \
> > >                       o---o---o---o---o---o--> branch B
> > 
> > Mainly for that reason, I would suggest having it outside the code
> > base's namespace: probably a different root in the same $GIT_DIR, but
> > I can see people wanting to have a separate $GIT_DIR.  If the database
> > tracks bugs by what commit(s) introduce or expose the bug -- at least
> > once that is known -- then you get nearly free tracking of which
> > branches have the bug without having to check out largely redundant
> > trees.
> 
>   Sure, but if it's completely out-of-tree, then cloning a repository
> don't allow you to get the bug databases with it for free. I mean it'd
> be great to have it somehow linked to the repository, but also I agree
> that not everybody wants to clone the whole bugs databases. So maybe it
> should just be in another shadow branch that annotates the devel ones.
> Hmmm I definitely need to read the git-note thread...

I guess I'm the one responsible for starting that git-note thread...

For the moment, I'm busy implementing some concepts that came out of that 
discussion (refactoring tag objects and building some infrastructure needed 
to support notes without the drawbacks present in my first version).

Hopefully I'll have a proof-of-concept ready before too long. In the 
meantime I'll be happy to answer questions you might have.

Regarding the notes themselves, I thought about possibly using them as a 
link between the repo and the bug tracker, with some glue code in between 
for making the connections. I haven't thought about integrating them more 
deeply into a bug tracker, but it might be worth thinking along those 
lines, especially for the kind of system you're proposing.

Now, back to hacking...


Have fun! :)

...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
