From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Documentation/git-merge.txt: Expand the How Merge
	Works  section
Date: Thu, 17 Jul 2008 20:54:51 +0200
Message-ID: <20080717185451.GJ10151@machine.or.cz>
References: <20080717162922.12081.96582.stgit@localhost> <7v3am8gytp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 20:55:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJYdt-0002lw-9x
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 20:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758635AbYGQSyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 14:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757468AbYGQSyy
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 14:54:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59755 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757386AbYGQSyx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 14:54:53 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 912B7393B31C; Thu, 17 Jul 2008 20:54:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v3am8gytp.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88902>

  Hi,

  I'm not sure if I should resend the updated patch, or if you already
included your comments yourself.

On Thu, Jul 17, 2008 at 11:17:22AM -0700, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> > +* `HEAD` is already contained in the merged commit. This is the
> > +  most common case especially when involved through 'git pull':
> > +  you are tracking an upstream repository, committed no local
> > +  changes and now you want to update to a newer upstream revision.
> > +  So-called "fast-forward merge" is performed, simply repointing
> > +  your `HEAD` (and index) to the merged commit; no extra merge
> > +  commit is created.
> 
> I'd suggest rewording the last three lines:
> 
> 	Your `HEAD` (and the index) is updated to point the merged
							^ at
>         commit, without creating an extra merge commit.  This is
>         called "Fast-forward".

  Yes, that is better.

> > +Pre-flight requirements note
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +In certain special cases, your index is
> > +allowed to be different from the tree of the `HEAD` commit.
> 
> Now this paragraph is moved far away from the original context that said
> "your index must be clean before you start your merge", you would need to
> re-introduce that in this sentenece:
> 
> 	... tree of the `HEAD` before you run 'git-merge'.

  Done.

  I have to admit that I didn't even carefully read the rest of this
subsection, but I agree that we might as well update it when moving it
around already.

> > +... Also, your index entries
> > +may have differences from your `HEAD` commit that match
> > +the result of a trivial merge (e.g. you received the same patch
> > +from an external source to produce the same result as what you are
> > +merging).  For example, if a path did not exist in the common
> > +ancestor and your head commit but exists in the tree you are
> > +merging into your repository, and if you already happen to have
> > +that path exactly in your index, the merge does not have to
> > +fail.
> 
> I originally wrote the above paragraph purely for completeness, but I
> wonder if this happens a lot in practice.  This is not something the user
> can easily anticipate anyway, so we might want to drop this.

  I think that we can expect only users that have real interest in these
details to read through this, so I would keep it for the completeness.

> > +So in the above two "failed merge" case, you do not have to
> > +worry about loss of data --- you simply were not ready to do
> > +a merge, so no merge happened at all.  You may want to finish
> > +whatever you were in the middle of doing, and retry the same
> > +pull after you are done and ready.
> 
> I am not sure what two cases we were describing.  It could be that this
> paragraph was taken from a mailing list message responding to a question
> (e.g. "I got this merge failure message and my tree is screwed up.  Please
> help me get back to a good state, I am lost...") without copying the
> original sample failure scenario.

  Yes, I got confused by this too. I would perhaps simply drop this
paragraph altogether.

-- 
				Petr "Pasky" Baudis
GNU, n. An animal of South Africa, which in its domesticated state
resembles a horse, a buffalo and a stag. In its wild condition it is
something like a thunderbolt, an earthquake and a cyclone. -- A. Pierce
