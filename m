From: Ray Lee <ray-lk@madrabbit.org>
Subject: Re: [darcs-devel] Darcs and git: plan of action
Date: Mon, 18 Apr 2005 18:42:11 -0700
Organization: http://madrabbit.org/
Message-ID: <1113874931.23938.111.camel@orca.madrabbit.org>
References: <20050418210436.23935.qmail@science.horizon.com>
	 <1113869248.23938.94.camel@orca.madrabbit.org>
	 <42645969.2090609@qualitycode.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, darcs-devel@darcs.net
X-From: git-owner@vger.kernel.org Tue Apr 19 03:38:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNhhE-00013W-Rk
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 03:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVDSBm1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 21:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVDSBm0
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 21:42:26 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:15077 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S261190AbVDSBmN
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 21:42:13 -0400
Received: from orca.madrabbit.org (orca.madrabbit.org [192.168.1.51])
	by madrabbit.org (Postfix) with ESMTP
	id A9BE44C1442; Mon, 18 Apr 2005 18:42:12 -0700 (PDT)
To: Kevin Smith <yarcs@qualitycode.com>
In-Reply-To: <42645969.2090609@qualitycode.com>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-04-18 at 21:05 -0400, Kevin Smith wrote:
> >>The other is "replace very instace of identifier `foo` with identifier`bar`".
> > That could be derived, however, by a particularly smart parser [1].
> 
> No, it can't. Seriously. A darcs replace patch is encoded as rules, not
> effects, and it is impossible to derive the rules just by looking at the
> results. Not difficult. Impossible.

Okay, either I'm a sight stupider than I thought, or I'm not
communicating well. Same net effect either way, I 'spose.

If I do a token replace in an editor (say one of those fancy new-fangled
refactoring thangs, or good ol' vi), a token-level comparator can
discover what I did. That link I sent is an example of one such beast.

> You could guess, but that's not good
> enough for darcs to be able to reliably commute the patches later.

Who said anything about guessing? If a user replaces all instances of
foo with bar, that's as close to proof as you can ever get, without
recording intent of the user at the time it's done. Now, I realize that
darcs *does* record intent, but I claim that's immaterial.

Perhaps I'm clueless; it's happened before, I'm resigned to it happening
again. So, tell it to me with full jargon, if you will. When it comes
down to brass tacks, why does my suggestion place weaker guarantees
about the quality of the resulting patch operator?

> > As for "darcs mv", that can be derived from the before/after pictures of
> > the trees.
> 
> Perhaps. If a file is moved and edited within the same commit, I'm not
> sure that you can be certain whether it was done with d 'darcs mv' or
> not.

Agreed. But then you go lart the committer of that patch.

> Requiring separate checkins for the rename and the subsequent
> modify would make things easier on SCM's, but is impractical in real
> life.

Eh? Why? "darcs mv" *is* a commit. Just because it doesn't seem to look
like one doesn't change the fact that you just invoked the SCM.

> Automated refactoring tools, for example, perform the
> rename+modify as an atomic operation.

And that's harder, I agree. But unless I'm missing some nifty
refactoring editor out there that integrates with darcs during the edit
session, the user *still* has to tell the SCM about the rename manually.

> Now, git might not need to deal with any of this, because it only needs
> to work with the kernel project.

It'd be unfortunate if git were limited to such a small developer base.

> I'm *not* advocating cluttering up git with features that are not
> directly needed for kernel development.

I'm not claiming you are. We want the same thing -- a nuanced SCM that
can take some of the drudge-work away from this stuff.

Ray

