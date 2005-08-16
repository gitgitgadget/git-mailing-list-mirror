From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Alternate object pool mechanism updates.
Date: Tue, 16 Aug 2005 15:45:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508161519090.23242@iabervon.org>
References: <7vmznmp5ja.fsf@assigned-by-dhcp.cox.net> <20050813120815.GC5608@pasky.ji.cz>
 <7v1x4wcca0.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0508141726390.3553@g5.osdl.org>
 <7vr7cw7ypt.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0508161156430.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 21:44:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E57LG-0007Fg-9o
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 21:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVHPTmA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 15:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbVHPTmA
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 15:42:00 -0400
Received: from iabervon.org ([66.92.72.58]:38664 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932370AbVHPTmA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2005 15:42:00 -0400
Received: (qmail 27895 invoked by uid 1000); 16 Aug 2005 15:45:20 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Aug 2005 15:45:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508161156430.3553@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 16 Aug 2005, Linus Torvalds wrote:

> Finally, I have to say that that "info" directory is confusing. Namely,
> there's two of them - the "git info" and the "object info" directories are
> totally different directories - maybe logical, but to me it smells like
> "info" is here a code-name for "misc files that don't make sense anywhere
> else".
>
> What this all is leading up to is that I think we'd be better off with a
> totally new "git config" file, in ".git/config", and we'd have all the
> startup configuration there. Including things like alternate object
> directories, perhaps standard preferences for that particular repo, and
> things like the "grafts" thing.
>
> Wouldn't that be nice?

I'd originally proposed the .git/info directory because I keep multiple
working trees for the same repository, by having symlinks for .git/objects
and .git/refs, and I could also get other per-repository things to be
shared properly without knowing exactly what they are if they're in a
subdirectory of .git that could be a symlink. This would mean that a
".git/config" would be per-working-tree, like .git/index or .git/HEAD, not
pre-repository like ".git/info/config". Of course, the core didn't have
any thing to go in .git/info at the time, so it didn't really get tacked
down.

(I find it convenient to have mainline and my latest work both checked out
for reference while I'm generating a series of commits for a patch set,
and I don't want three different repositories which could be out of sync;
this also keeps the repository safely out of pwd, since I have the actual
repositories as ~/git/{project}.git/)

	-Daniel
*This .sig left intentionally blank*
