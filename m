From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Sat, 19 Aug 2006 12:25:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608191218470.11811@g5.osdl.org>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com> 
 <Pine.LNX.4.64.0608172323520.11359@localhost.localdomain> 
 <9e4733910608180615q4895334bw57c55e59a4ac5482@mail.gmail.com> 
 <Pine.LNX.4.63.0608181536250.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <9e4733910608180650j4542ab09q7daf4250825d3333@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>,
	Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 19 21:25:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEWRr-00038L-RV
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 21:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbWHSTZc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Aug 2006 15:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbWHSTZb
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Aug 2006 15:25:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57279 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751776AbWHSTZb (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Aug 2006 15:25:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7JJP9nW018833
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 19 Aug 2006 12:25:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7JJP8ps031275;
	Sat, 19 Aug 2006 12:25:08 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910608180650j4542ab09q7daf4250825d3333@mail.gmail.com>
X-Spam-Status: No, hits=-0.43 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.142 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25732>



On Fri, 18 Aug 2006, Jon Smirl wrote:

> On 8/18/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> > 
> > On Fri, 18 Aug 2006, Jon Smirl wrote:
> > 
> > > I suspect the size reduction is directly proportional to the age of
> > > the repository. The kernel repository only has three years worth of
> > > data in it.  Linus has the full history in another repository that is
> > > not in general distribution. We can get it from him when he gets back
> > > from vacation.
> > 
> > Maybe you mean
> > 
> > http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/tglx/history.git
> 
> That one only goes to 2002, the full one goes back to around 1990.

I don't actually have such a "full" history. It would be wonderful if 
somebody took the time to try to piece such a thing together (and git 
actually makes that a _lot_ easier than some other SCM's, because you can 
just import random versions in any order, and then re-stich just the 
commit history when you add a new thing in the middle, without generating 
any new trees or deltas or anything strange at all).

But it's a lot of work. I tried to do a "Linux-Historic" archive about a 
year ago (and imported some of the old kernels I had), but I gave up, just 
because it was such a pain to try to do a good job and try to find old 
release notes etc to import into the changelogs etc. 

Oh, well.

So the only "old" history I have is indeed that BK conversion by Thomas 
Gleixner. Any pre-BK stuff only exists as patches and tar-balls on various 
ftp sites (and I don't have any magic repository of my own, so everybody 
else can do exactly as well as I could, with possibly the exception that I 
might remember some random details about some old release history - but 
considering my memory, that's pretty unlikely too. Google is your friend)

			Linus
