From: Jan Hudec <bulb@ucw.cz>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 17:56:24 +0200
Message-ID: <20061021155624.GF29843@artax.karlin.mff.cuni.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <87zmbucs86.wl%cworth@cworth.org> <45359F36.6050609@utoronto.ca> <200610181120.49749.jnareb@gmail.com> <453656F8.3000504@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	bazaar-ng@lists.canonical.com, Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, Petr Baudis <pasky@suse.cz>,
	Carl Worth <cworth@cworth.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 17:56:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbJCw-0004iK-4b
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 17:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993118AbWJUP4T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 11:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993120AbWJUP4T
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 11:56:19 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:18112 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S2993118AbWJUP4S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 11:56:18 -0400
Received: by artax.karlin.mff.cuni.cz (Postfix, from userid 17196)
	id 384BD48E4; Sat, 21 Oct 2006 17:56:24 +0200 (CEST)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
Content-Disposition: inline
In-Reply-To: <453656F8.3000504@utoronto.ca>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29627>

On Wed, Oct 18, 2006 at 12:31:52PM -0400, Aaron Bentley wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Jakub Narebski wrote:
> > Aaron Bentley wrote:
> > 
> >>Carl Worth wrote:
> >>>There are even more important reasons to prefer a series of
> >>>micro-commits over a mega-patch than just ease of merging.
> >>
> >>A bundle isn't a mega-patch.  It contains all the source revisions.  So
> >>when you merge or pull it, you get all the original revisions in your
> >>repository.
> > 
> > 
> > But what patch reviewer see is a mega-patch showing the changeset
> > of a whole "bundle", isn't it?
> > [...]
> 
> Yes.  Carl was saying that, aside from the issue of what a reviewer
> sees, a bundle is bad for other reasons.  I am saying those other
> reasons don't apply.  I wasn't addressing the issue of what a reviewer sees.
> 
> To me, seeing the individual patches is like reading a book where every
> page has a different word on it, and so it's hard to put it together
> into a full sentence.  I'm not saying my way is The Right Way, just my
> personal preference.
> 
> For larger pieces of work, we try to split them up into logical units,
> and merge those units independently.
> 
> The Bundle format can also support a patch-by-patch output, but we don't
> have UI to select that.

As for what the reviewer wants to see, I think it depends on what kind
of code it is. Kernel code is complex and does not have (at least I have
not heared of) unit-tests, so short patches are preferable for review.
And since C is of the more verbose languages, short patches mean
spliting them up into several pieces.

On the other hand bzr has unit-tests and python is less verbose, so the
single patch for a feature is not so big and is manageable. The patches
to bzr still come in logical steps, but usually one step per feature is
enough.

Also programmers usually don't develop even the single logical step as a
single commit. Instead they they also commit to backup their work,
when they try something they think they may in future return, when they
need to continue on another computer and so on. And these commits are
generally not logical steps. Also the steps are often not in a logical
order. Therefore showing diff for each commit in the bundle often does
not make sense.

So there is one bundle per logical step and therefore has a summary
diff. Individual bundles for individual steps are preferable anyway,
since the maintainer may decide to accept just some of them.  A tool to
generate a series of bundles (either each with just one commit or each
with several commits) would be possible, just noone was interested
enough to do it yet.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
