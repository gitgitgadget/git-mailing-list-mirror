From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCHv2] Documentation/git-submodule.txt: Add Description
	section
Date: Thu, 17 Jul 2008 14:18:13 +0200
Message-ID: <20080717121813.GC10151@machine.or.cz>
References: <20080715183705.GD4379@zakalwe.fi> <20080716184248.6524.38463.stgit@localhost> <20080717104124.GE4379@zakalwe.fi> <20080715183705.GD4379@zakalwe.fi> <20080716184248.6524.38463.stgit@localhost> <7vej5tr5kv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Heikki Orsila <shdl@zakalwe.fi>
X-From: git-owner@vger.kernel.org Thu Jul 17 14:20:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJSS6-0001X2-Fi
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 14:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759045AbYGQMST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 08:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759165AbYGQMSS
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 08:18:18 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45805 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759118AbYGQMSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 08:18:16 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 293D42C4C027; Thu, 17 Jul 2008 14:18:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080717104124.GE4379@zakalwe.fi> <7vej5tr5kv.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88838>

On Wed, Jul 16, 2008 at 12:29:03PM -0700, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> > index 76702a0..87c4ece 100644
> > --- a/Documentation/git-submodule.txt
> > +++ b/Documentation/git-submodule.txt
> > @@ -16,6 +16,28 @@ SYNOPSIS
> >  'git submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
> >  
> >  
> > +DESCRIPTION
> > +-----------
> > +Submodules are a special kind of tree entries which refer to a particular tree
> > +in another repository (living at a given URL).  ...
> 
> In the documentation, "tree" has a specific meaning.  Perhaps "a
> particular tree state" is a better wording than another alternative "a
> particular commit", because you mention "the exact revision" in the
> following sentence.

The two sentences are now highly redundant, so...

> I'd suggest dropping " (living at a given URL)" from here, though.

...actually, in the end I have completely rewritten this yet again. The
description was too low-level (and kind of in fact explained gitlinks
instead of submodules), while we should carefully explain the high-level
concept of submodules first, only then talk about tree entries.

> > ...  The tree entry describes
> > +the existence of a submodule with the given name and the exact revision that
> > +should be used, while the location of the repository is described in the
> > +`/.gitmodules` file.
> 
> Strictly speaking, ".gitmodules" merely gives a hint to be used by
> "submodule init", the canonical location from which the repository is
> expected to be cloned.  I do not think this overview needs to go into such
> a detail.  The description of "init" subcommand might need clarification,
> though.

I believe we should mention it. The users *will* see this file e.g.
during submodule merges, as well as in git status output when
manipulating submodules.


On Thu, Jul 17, 2008 at 01:41:24PM +0300, Heikki Orsila wrote:
> On Wed, Jul 16, 2008 at 08:44:12PM +0200, Petr Baudis wrote:
> > I have adjusted the description a bit; however, I believe mentioning
> > remotes in
> > the description would only raise the danger of confusion - I emphasized the
> > level of separation, though.
> 
> I think not doing a comparison actually creates confusion. My immediate 
> thought about submodules was "how does this differ from remotes? why do 
> submodules exist rather than just remotes?"

Ok, now I realize this is a good point, and it's a nice chance to give a
plug for the subtree merge strategy as an alternative. ;-)

-- 
				Petr "Pasky" Baudis
GNU, n. An animal of South Africa, which in its domesticated state
resembles a horse, a buffalo and a stag. In its wild condition it is
something like a thunderbolt, an earthquake and a cyclone. -- A. Pierce
