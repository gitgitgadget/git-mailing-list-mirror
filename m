From: David Kastrup <dak@gnu.org>
Subject: Re: Terminology question about remote branches.
Date: Sat, 04 Aug 2007 17:22:59 +0200
Message-ID: <85k5sbfhnw.fsf@lola.goethe.zz>
References: <854pjfin68.fsf@lola.goethe.zz>
	<20070804092933.aaec6d52.seanlkml@sympatico.ca>
	<85ejijgzzg.fsf@lola.goethe.zz>
	<20070804104851.162d7e00.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sat Aug 04 17:23:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHLTA-0000XX-LD
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 17:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758180AbXHDPXF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 11:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756957AbXHDPXE
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 11:23:04 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:37801 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755230AbXHDPXC (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 11:23:02 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 5F58F4C958;
	Sat,  4 Aug 2007 17:23:01 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id 457D8212FAE;
	Sat,  4 Aug 2007 17:23:01 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-010-037.pools.arcor-ip.net [84.61.10.37])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 1FE3530ABDE;
	Sat,  4 Aug 2007 17:23:01 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id AE2DA1C4F932; Sat,  4 Aug 2007 17:22:59 +0200 (CEST)
In-Reply-To: <20070804104851.162d7e00.seanlkml@sympatico.ca> (Sean's message of "Sat\, 4 Aug 2007 10\:48\:51 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3854/Sat Aug  4 06:49:48 2007 on mail-in-03.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54865>

Sean <seanlkml@sympatico.ca> writes:

> On Sat, 04 Aug 2007 16:01:55 +0200
> David Kastrup <dak@gnu.org> wrote:
>
>> So --track does not set up a tracking branch, but makes a local
>> _following_ branch _refer_ to a tracking branch.
>
> Sure, that's one way to describe it; perhaps it would be best if
> we switched to that nomenclature in the documentation.

Not according to my current understanding, but that can, of course,
change again in the next few hours.  As far as I understand right now,
such a branch indeed tracks a remote branch (and not a remote tracking
branch), it just does not track it recklessly: it has a head of its
own, and it won't use git-fetch -f for updating it.

> It's not a problem, you could just add an appropriate [branch...] section
> in your .git/config.   Actually looking at a typical branch section
> is even more confusing to me:
>
>     $ git branch fudge origin/fix1
>
> adds this to the .git/config:
>
>     [branch "fudge"]
>         remote = origin
>         merge = refs/heads/fix1
>
> The config file does not record the remote-tracking-branch, instead
> it explicitly records the remote repository information.  So it sure
> appears that if you add the --track option, it _does_ make the local
> branch track a remote directly.  Thus it's hard to call it anything
> but what you labelled it, a local tracking-branch.

Yes, it seems --track does track after all.  Just more cautiously than
a remote tracking branch does.

> While I thought i had a handle on this, i'm now officially more
> confused than you;

Good.  It means that I may not be a complete idiot.  It may also mean
that the documentation can be improved in places.  With a lot of
"grep" and fine-combing I realized that quite a bit of the information
_is_ "available" (and some conflicting information as well).

This is one reason why I would prefer to have something like a typical
Texinfo manual, at least on the organisational level: a manual is
supposed to present a single connected view to the available
documentation.  And the information for git is scattered through a
bunch of mostly disconnected files.

If you want to see a more staggering example of this approach, take a
look at the "guilt" documentation.  It consists only of the man pages
for the individual commands, and then some few README-like files which
mostly say something like "guilt is just like quilt, or like
Mercurial's patch sets".  That's rather extreme as far as
user-accessible information goes.  git has a few more generally useful
files explaining underlying concepts, but they still are basically
thrown into one large self-service heap, not a coherent document.

> hopefully someone with knowledge of the guts of Git will speak up.

I think I am slowly getting it, thanks to Lars and others.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
