From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Document git-filter-branch
Date: Wed, 4 Jul 2007 00:17:05 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707040004200.4071@racer.site>
References: <Pine.LNX.4.64.0707031746400.4071@racer.site>
 <20070703220540.GN12721@planck.djpig.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Wed Jul 04 01:17:20 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5rcU-0005k5-NE
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 01:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756420AbXGCXRP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 19:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757125AbXGCXRO
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 19:17:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:36895 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756484AbXGCXRN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 19:17:13 -0400
Received: (qmail invoked by alias); 03 Jul 2007 23:17:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp015) with SMTP; 04 Jul 2007 01:17:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+dE6lwN6+db+B++Kbdxm2nQLOA25HPLQ3BZ1z3/r
	iUOunvMcxhYQ5/
X-X-Sender: gene099@racer.site
In-Reply-To: <20070703220540.GN12721@planck.djpig.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51550>

Hi,

[if you comment on just a small portion of the text, could you please 
quote only that? Thank you]

On Wed, 4 Jul 2007, Frank Lichtenheld wrote:

> General note: All the stuff in all uppercase should probably also
> have some asciidoc emphasis.

I do not understand. I grepped through all the docs for uppercase words 
emphasized in any way, and could not find one.

> On Tue, Jul 03, 2007 at 05:47:44PM +0100, Johannes Schindelin wrote:
>
> > +Note that since this operation is extensively I/O expensive, it might
> > +be a good idea to redirect the temporary directory it off-disk, e.g. on
>                                                     ^^^^^^
> The "it" probably doesn't belong there.

Right.

> > +The filters are applied in the order as listed below.  The <command>
> > +argument is always evaluated in shell using the 'eval' command.
> > +The $GIT_COMMIT environment variable is permanently set to contain
>                                            ^^^^^^^^^^^
> I find the use of this word in this context odd and a little confusing.
> Maybe better "always" or "each time"?

How about

	Prior to that, the $GIT_COMMIT environment variable will be set to 
	contain the id of the commit being rewritten.

> > +the id of the commit being rewritten.  The author/committer environment
> > +variables are set before the first filter is run.
> 
> Maybe give the actual names of the environment variables here?

If you think so:

	Also, GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, GIT_AUTHOR_DATE, 
	GIT_COMMITTER_NAME, GIT_COMMITTER_EMAIL, and GIT_COMMITTER_DATE is 
	set according to the current commit.

> > +	is then used as-is (new files are auto-added, disappeared files
> > +	are auto-removed - .gitignore files nor any other ignore rules
> > +	HAVE NO EFFECT!).
> 
> Is "nor" correct here? Not just "or"?

Do you like

	neither .gitignore files nor any other ignore rules HAVE ANY 
	EFFECT!

> [...]
> > +--subdirectory-filter <directory>::
> > +	Only regard the history, as seen by the given subdirectory. The
>                               ^^^
> Does this comma belong there?

This is my bad English. What I meant was this:

        Only ever look at the history, which touches the given 
	subdirectory.  The result will contain that directory as its 
	project root.

> > +-------------------------------------------------------------------------------
> > +git filter-branch --index-filter 'git update-index --remove filename' newbranch
> > +-------------------------------------------------------------------------------
> 
> Even if your code goes beyond 80 chars, the surrounding "---" doesn't
> have to and makes it even harder to read when reading the original
> asciidoc text.

I personally read the .txt files, and use asciidoc only when I am forced 
to. So it makes a difference for me.

> > +----------------------------------------------------------------------
> > +git filter-branch --parent-filter sed\ 's/^$/-p <graft-id>/' newbranch
> > +----------------------------------------------------------------------
> 
> Wouldn't have 'sed s/^$/-p <graft-id>/' exactly the same effect, since
> the quotes are interpreted by the original shell anyway and not the
> filter shell? Just wondering why it uses such a complicated way to
> express it.

Probably not. Since the shell would interpret "s/^$/-p" and "<graft-id>/" 
as two arguments to sed.

Besides, like Pasky, I am used to quote the argument, and not the whole 
line, that's why the line is still there as it is.

Thanks,
Dscho
