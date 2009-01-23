From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow cloning an empty repository
Date: Fri, 23 Jan 2009 03:42:24 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901230333060.3586@pacific.mpi-cbg.de>
References: <1232669252-21881-1-git-send-email-srabbelier@gmail.com>  <7vwscm4xx0.fsf@gitster.siamese.dyndns.org> <bd6139dc0901221746h258f548etf857ab37399133da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 03:46:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQC43-0006by-Fd
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 03:46:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756072AbZAWCmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 21:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755907AbZAWCmQ
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 21:42:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:57232 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755307AbZAWCmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 21:42:16 -0500
Received: (qmail invoked by alias); 23 Jan 2009 02:42:14 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 23 Jan 2009 03:42:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19KY5VmnXRKT9CSCOlPR0ihqfmIstgYGQCwqVYEXN
	fn0I1ijl1GPY1q
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <bd6139dc0901221746h258f548etf857ab37399133da@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106823>

Hi,

On Fri, 23 Jan 2009, Sverre Rabbelier wrote:

> On Fri, Jan 23, 2009 at 02:24, Junio C Hamano <gitster@pobox.com> wrote:
> > I think the basic idea is Ok, but is it a reliable check at this point to
> > see if (refs == NULL) to tell if the target repository is an empty one?
> 
> This is the question I asked Dscho, and he said/guessed that it was.
> 
> > I am mostly worried about a failure case (connected but couldn't get 
> > the refs, or perhaps connection failed to start).  If you get a NULL 
> > in such a case you may end up saying "oh you cloned a void" when you 
> > should say "nah, such a remote repository does not exist".
> 
> Yes, this was my concern as well.

>From what I can see in get_remote_heads(), the native protocols would 
die(), as would rsync().

HTTP transport, however, would not die() on connection errors, from my 
cursory look.

That might be skewed, though, as I am on top of Mike's patches (in the 
hopefully not so futile hope that Mike -- after letting me wait for over 
one year -- finishes his work.

HTTP being 2nd class citizen anyway (and we can always fix it after Mike's 
cleanups), I'd say this patch is ready to roll.

Ciao,
Dscho
