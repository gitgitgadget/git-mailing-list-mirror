From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Tue, 2 Sep 2008 23:05:24 +0200
Message-ID: <20080902210524.GB7757@leksak.fem-net>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl> <7vk5dujn9h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 23:07:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kad59-0006zx-PF
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 23:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbYIBVF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 17:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbYIBVF3
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 17:05:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:45430 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751651AbYIBVF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 17:05:28 -0400
Received: (qmail invoked by alias); 02 Sep 2008 21:05:26 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp028) with SMTP; 02 Sep 2008 23:05:26 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+hxfQL7euhqTTGECDP0wDdDs7nImC1ybrfm7oXxe
	zVqgBNmYbxxnHC
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1Kad40-0002fA-9V; Tue, 02 Sep 2008 23:05:24 +0200
Content-Disposition: inline
In-Reply-To: <7vk5dujn9h.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94714>

Hi,

Junio C Hamano wrote:
> Pieter de Bie <pdebie@ai.rug.nl> writes:
> 
[..]
> > Vienna:git pieter$ ./git commit --allow-empty -m"test"
> > Created commit 6ce62c8b: test
> > You are on a detached head, so this commit has not been recorded in a branch.
> > If you don't want to lose this commit, checkout a branch and then run:
> > 	git merge 6ce62c8bfcfb341106f3587d1c141c3955c2544c
> >
> > Are there any comments to this / strong opinions against such a change?
> 
> Unconditionally doing this is too loud for my taste.  You probably can do
> this in your post-commit hook.

Well, Pieter probably can do this in his post-commit hook. But I think
this is useful for usability... especially for beginners who might not
even know what a hook is. ;)

For me this felt too loud, too, especially since "git status" and
"git commit" (without message option) already tells the user that
she is on a detached HEAD. And "git commit -a" is usually done after
a "git status", too, isn't it? (I do not use "git commit -a", I *use*
the index.)

But nonetheless... Some days ago I accidentally detached my head (hihi)
and at the end of the day, after switching and rebasing branches, I noticed
that some commits in my branch were "lost"... Such a patch may have helped.
(Yes, "git fsck --lost-found" and "git cherry-pick ..." helped.)

So I'm somewhere in between. I think this patch can be useful to
minimize some annoyance for git users, but on the other hand the
loud output can annoy people if they, for example, use git-commit in
scripts (like git-rebase and git-rebase--interactive does).

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
