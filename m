From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Newbie: report of first experience with git-rebase.
Date: Thu, 1 Nov 2007 11:10:16 -0400
Message-ID: <20071101151016.GA26103@fieldses.org>
References: <87d4uv3wh1.fsf@osv.gnss.ru> <20071031195702.GB24332@atjola.homenet> <874pg73u6h.fsf@osv.gnss.ru> <Pine.LNX.4.64.0710312111170.4362@racer.site> <7vhck7gdzs.fsf@gitster.siamese.dyndns.org> <87ve8m2mfn.fsf@osv.gnss.ru> <Pine.LNX.4.64.0711011423440.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergei Organov <osv@javad.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 01 16:10:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inbh0-0008JA-8S
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 16:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754675AbXKAPKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 11:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753500AbXKAPKY
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 11:10:24 -0400
Received: from mail.fieldses.org ([66.93.2.214]:39545 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752229AbXKAPKX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 11:10:23 -0400
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1InbgW-0006zD-A6; Thu, 01 Nov 2007 11:10:16 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711011423440.4362@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62971>

On Thu, Nov 01, 2007 at 02:24:37PM +0000, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 1 Nov 2007, Sergei Organov wrote:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> > 
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > >
> > >> On Wed, 31 Oct 2007, Sergei Organov wrote:
> > >>
> > >>> Yes, and that's the problem. Why 'git --continue' didn't just skip this 
> > >>> patch that *already became no-op* after conflict resolution and forced 
> > >>> me to explicitly use 'git --skip' instead?
> > >>
> > >> Isn't that obvious?  To prevent you from accidentally losing a commit.
> > >
> > > In case it is not obvious...
> > >
> > > A rebase conflict resolution that results in emptiness is a
> > > rather rare event (especially because rebase drops upfront the
> > > identical changes from the set of commits to be replayed), but
> > > it does happen.
> > 
> > Funny how 2 of my first 3 commits suffer from this "rather rare event",
> > and it was not Friday, 13 ;)
> 
> They are rare events.  In your case I guess that subtly different versions 
> were _actually_ applied (such as white space fixes),

That's actually pretty common, in my experience.

> which is why such a rare event hit you.

I'm using git to track some changes I submitted to a project that's
mainly text, and that I only get release tarballs of.  On my most recent
rebase all my patches got applied, but the text also got re-wrapped and
re-indented at the same time.  So all but I think one or two of a dozen
patches ended up with a conflict resolution and then --skip.

Which may not be a case git's really intended for--fair enough.  But
I've found it's pretty common in my kernel work too.  Either I'm
rebasing against changes I made myself, or else a maintainer took my
changes but fixed up some minor style problems along the way.

--b.
