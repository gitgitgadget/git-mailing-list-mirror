From: John Keeping <john@keeping.me.uk>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Mon, 5 May 2014 20:55:25 +0100
Message-ID: <20140505195525.GC23935@serenity.lan>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
 <20140505184546.GB23935@serenity.lan>
 <5367e1ac39571_5977e7531081@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 19:27:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whi8H-0006KZ-8D
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbaEEUDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 16:03:24 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:57758 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbaEEUDY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 16:03:24 -0400
X-Greylist: delayed 469 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 May 2014 16:03:23 EDT
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id D59AC2171D;
	Mon,  5 May 2014 20:55:33 +0100 (BST)
X-Quarantine-ID: <lmxR6jgBwEzR>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lmxR6jgBwEzR; Mon,  5 May 2014 20:55:32 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id AFE2E21823;
	Mon,  5 May 2014 20:55:32 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id A2F11161E5A9;
	Mon,  5 May 2014 20:55:32 +0100 (BST)
X-Quarantine-ID: <Wv9lJoaGYcpj>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Wv9lJoaGYcpj; Mon,  5 May 2014 20:55:32 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id AD4AE161E1A1;
	Mon,  5 May 2014 20:55:27 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <5367e1ac39571_5977e7531081@nysa.notmuch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248184>

On Mon, May 05, 2014 at 02:08:28PM -0500, Felipe Contreras wrote:
> John Keeping wrote:
> > I am not convinced that tools for interoperating with other VCSs need to
> > be part of core Git; as Junio has pointed out previously, while contrib/
> > was necessary for promoting associated tools when Git was young and had
> > not established mindshare, Git is now by far the most popular DVCS and
> > is rapidly catching up with centralized systems.  Associated tools can
> > therefore live on their own and do not need to be promoted as part of
> > Git itself (as git-imerge is doing successfully).
> 
> Then let's remove git-p4.

If git-p4 were not already in the core, I would be making precisely the
same argument regarding it (and the others you identify below).

> > In the case of git-remote-hg specifically, the remote helper has to use
> > an interface that the Mercurial developers consider unstable [1];
> 
> There is no other sensible way of doing them.
> 
> > the version currently on 'pu' fails the test suite for me because I
> > have Mercurial 3.0:
> > 
> > 	AttributeError: 'mqrepo' object has no attribute 'getbundle'
> 
> And because this patch has not been picked up[1].

And it is now probably too late for that to make Git 2.0, which means it
may be another 12 weeks before it makes it into a Git release.  Since
this is quite a minor change it may make it into a stable release, but
what would happen if the required changes were much more involved?

> > I do not want to end up in a situation where an update to Git is blocked
> > by a distribution because git-remote-hg is not updated to support newer
> > versions of Mercurial sufficiently quickly; this previously happened in
> > Gentoo due to git-svn and meant that was stuck on 1.7.8 until 1.7.13 was
> > released [2].
> 
> Travis-CI ensures that won't happen[2].

I don't see that building against Mercurial's default branch, so it will
not help with future releases.

> > Since the remote helper interface is stable and the remote helpers do
> > not use any of the Git internals, I consider the risks of including them
> > in core Git to outweigh the benefits of wider distribution.  In fact,
> > the remote helpers may benefit from having their own release cadences
> > so that they can respond to changes in related projects more quickly
> > than the normal Git release cycle.
> 
> Maybe, but git-remote-hg has already benefitted a lot from the wider
> exposure of being in 'contrib/', I'm sure it would benefit even more if
> it's distributed by default.

Is that because it was included in contrib/ or just as a result of being
publicised on this list and elsewhere?  I don't think git-imerge is
suffering from being its own project and git-subtree appears to have
received very little attention despite being in contrib/.

> Moreover, there's a ton of subpar tools out there[3], and I believe
> giving the burden of choosing one to the user is detrimental to the Git
> project. If we as a project say: this is the one we recommend, and has
> the Git stamp, that helps the users tremendously.

But by choosing one now, we are stuck promoting that one even if a
better alternative comes along in the future.  We have seen that with
git-cvsimport and it's not dissimilar to the situation with git-pull.

> Your point is valid though, but it's valid not just for
> git-remote-hg/bzr.
> 
> So I think these are the two options:
> 
>   1) Include git-remote-hg/bzr to the core and distribute them by
>      default (as is the current intention)
> 
>   2) Remove git-remote-hg/bzr entirely from the Git tree. And do the
>      same for other tools: git-p4, git-svn, git-cvs*. Given the huge
>      amount of people using Subversion, we might want to defer that one
>      for later, but eventually do it.

Don't forget git-archimport...

My personal vote would be for 2), splitting the bridges to other VCSs
into their own repositories but there would need to be some guarantee
that they would continue to be maintained.  I'm not sure it needs to
wait for a major Git release since most of the impact is on package
maintainers and not end users.

> I'd say for v2.0 we should go for 1), and 2) should be considered for
> v3.0, perhaps.

I don't think there is any advantage to adding new tools now if we only
intend to remove them in the future.

> [1] http://article.gmane.org/gmane.comp.version-control.git/248065
> [2] https://travis-ci.org/felipec/git
> [3] https://github.com/felipec/git/wiki/Comparison-of-git-remote-hg-alternatives
