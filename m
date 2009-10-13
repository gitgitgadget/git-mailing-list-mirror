From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when
 appropriate to do so
Date: Wed, 14 Oct 2009 01:22:26 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910140117280.4985@pacific.mpi-cbg.de>
References: <0016e68fd0123a175304754694b4@google.com> <200910130836.57011.trast@student.ethz.ch> <7vljjf226t.fsf@alter.siamese.dyndns.org> <200910131051.47117.trast@student.ethz.ch> <7vy6nfwssk.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910132302380.4985@pacific.mpi-cbg.de>
 <20091013220640.GB12603@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Euguess@gmail.com,
	Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 14 01:22:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxqhP-0007Rv-A5
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 01:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761610AbZJMXUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 19:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761585AbZJMXUg
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 19:20:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:45076 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761231AbZJMXUf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 19:20:35 -0400
Received: (qmail invoked by alias); 13 Oct 2009 23:19:47 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp054) with SMTP; 14 Oct 2009 01:19:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18NtHccTvAN7BhEv69xyKbc3lqQxWt4kUZ94aJt8g
	3mJ81p+99k893v
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20091013220640.GB12603@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130230>

Hi,

On Tue, 13 Oct 2009, Jeff King wrote:

> On Tue, Oct 13, 2009 at 11:20:28PM +0200, Johannes Schindelin wrote:
> 
> > So in my opinion, we should DWIM "git checkout $X" to mean "git checkout 
> > -b $X refs/remotes/$REMOTE/$X" when there is no ref $X, refs/heads/$X and 
> > no other refs/remotes/$OTHER/$X.
> 
> The similar suggestion that is less magical is to say something like
> "there is no $X; maybe you meant $REMOTE/$X?".

At some point, trying to educate the user is not helpful but annoying.  If 
Git already knows what I want, why does it not do it already?  _That_ is 
the question I already hear in my ears.

> Is there a reason not to phase in the behavior, to make sure it is not 
> doing unexpected things?

Sure, I have nothing against that.  But just insisting on the current 
behavior, or on some behavior that is not helpful at all, well, is not 
really clever.

Note that I am fully aware that my "git checkout -t origin/master" DWIMery 
backfired quite badly.  So I am in the same boat.

> In other words:
> 
>   1. In v1.6.6, find all error-correcting candidates and print them as
>      a suggestion (similar to what we do with "git foo").
> 
>   2. Then, if we all agree that it seems to be producing sane results,
>      the next step is to turn the unambiguous cases into a DWIM (and
>      leave the ambiguous ones with the "did you mean?" message).
> 
> Because right now I think there are a lot of hypothetical "maybe it
> would be less convenient or more confusing in this instance", but we
> don't have any data on how often those instances occur, or how actual
> users might react.

Oh, I do not want to spam the list with user experiences.  But I do have 
not only a faint idea how users react.  Thankyouverymuch.

> So doing step (1) would be a way of collecting some of that data (will 
> users say "stupid git, if you knew what I wanted, why didn't you just do 
> it?" or "stupid git, your suggestion is just confusing me!").

I disagree.  It is not about collecting data.  We will not get any 
feedback from the affected people.  You know that, I know that.

The step (1) would help in the way that it is a smoother transition.

Ciao,
Dscho
