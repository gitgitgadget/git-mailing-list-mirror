From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Heads up: major rebase -i -p rework coming up
Date: Sun, 25 Jan 2009 03:25:12 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901250324320.14855@racer>
References: <alpine.DEB.1.00.0901242056070.14855@racer> <200901242347.23187.trast@student.ethz.ch> <alpine.DEB.1.00.0901250303150.14855@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Stephen Haberman <stephen@exigencecorp.com>,
	spearce@spearce.org,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jan 25 03:26:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQuhO-0006Jy-9d
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 03:26:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755212AbZAYCYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 21:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755204AbZAYCYp
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 21:24:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:50114 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755154AbZAYCYp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 21:24:45 -0500
Received: (qmail invoked by alias); 25 Jan 2009 02:24:43 -0000
Received: from pD9EB3F9A.dip0.t-ipconnect.de (EHLO noname) [217.235.63.154]
  by mail.gmx.net (mp067) with SMTP; 25 Jan 2009 03:24:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+lr/NghvilU6sYpakq1d+KtkseaDiD9uhjS4wOFs
	seN+MVgvYT7bIB
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0901250303150.14855@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107037>

Hi,

On Sun, 25 Jan 2009, Johannes Schindelin wrote:

> On Sat, 24 Jan 2009, Thomas Rast wrote:
> 
> > Johannes Schindelin wrote:
> > > Worse, the whole concept of "pick <merge-sha1>" just does not fly well.
> > [...]
> > > - merge $sha1 [$sha1...] was $sha1 "Merge ..."
> > > 
> > > 	will merge the given list of commits into the current HEAD, for 
> > > 	the user's reference and to keep up-to-date what was rewritten, the 
> > > 	original merge is shown after the keyword "was" (which is not a 
> > > 	valid SHA-1, luckily)
> > 
> > I really like the underlying idea.  I'm not even sure if the current 
> > semantics are well-defined in all cases; an explicit merge command at 
> > least makes it very clear what is going on.
> > 
> > However, I think the syntax as proposed above is a bit confusing in 
> > the usual two-parent merge.  I couldn't tell whether
> > 
> >   merge A was B
> > 
> > was intended to be read as "the merge of A into the current branch" or 
> > "the merge with sha1 A" right away, and I doubt I'll be able to tell 
> > without looking in the (rare) cases I have to invoke rebase -i -p.
> > 
> > I can't really come up with a better replacement for 'was', so how 
> > about
> > 
> >   merge A # was B "Merge..."
> > 
> > which would make it more clear that the "was B..." has no effect 
> > whatsoever on the merge's semantics.
> 
> Hmm.  You're right, that is not really intuitive.  How about
> 
> 	merge (B) A # Merge...
> 
> instead?

Or even better:

	merge B parent A' # Merge...

?

Ciao,
Dscho
