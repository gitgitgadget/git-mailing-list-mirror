From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: tracking perms/ownership [was: empty directories]
Date: Sat, 25 Aug 2007 16:31:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708251630460.16728@wbgn129.biozentrum.uni-wuerzburg.de>
References: <1187716461.5986.71.camel@beauty> <20070821134030.b763e9d3.seanlkml@sympatico.ca>
 <1187817948.5986.159.camel@beauty> <alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
 <1187905879.5986.199.camel@beauty> <Pine.LNX.4.64.0708241136301.16728@wbgn129.biozentrum.uni-wuerzburg.de>
 <20070824095217.GB16853@coredump.intra.peff.net> <1187970632.6357.108.camel@beauty>
 <20070824205820.GA19152@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Josh England <jjengla@sandia.gov>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 25 16:31:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOwfu-0005K1-Po
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 16:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759315AbXHYObk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 10:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759500AbXHYObj
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 10:31:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:51962 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759145AbXHYObj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 10:31:39 -0400
Received: (qmail invoked by alias); 25 Aug 2007 14:31:37 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp033) with SMTP; 25 Aug 2007 16:31:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/mVckMfBjmEfUuSkX8Av2lutdonWsRMO8PihsJ3E
	5cdH5XeOb72HaG
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070824205820.GA19152@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56636>

Hi,

On Fri, 24 Aug 2007, Jeff King wrote:

> On Fri, Aug 24, 2007 at 09:50:32AM -0600, Josh England wrote:
> 
> > > direction and not at least consider people storing actual ACLs (or even
> > > other extended attributes). An already-standard format like that
> > 
> > Do you mean using acls through contrib/hooks/update-paranoid?  That is
> > the only place I see any mention of them.  clean and smudge seem out
> > because they are passed blob objects and have no notion of pathname.  I
> > don't see how to use this for automatic storing/restoring of
> > perms/ownership.
> 
> No, I mean filesystem ACLs. Your complaint is that git stores only the
> file _content_, not some specific metadata that you want (owner, group,
> permissions). My point is that there is _other_ metadata, too (such as
> POSIX ACLs) that could be stored. Even if you don't want to store them,
> if you are extending git's capabilities, it makes sense to at least
> consider how to handle those cases, too.
> 
> But yes, clean and smudge don't get the pathname. It would be a fairly
> trivial patch, though, so maybe I'll play with it.

Yes, please do.  Even if you do not end up implementing the perms/owner 
tracking using the clean/smudge filter, it seems odd that the filter 
should not get the filename.

Ciao,
Dscho
