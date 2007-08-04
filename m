From: David Kastrup <dak@gnu.org>
Subject: Re: Terminology question about remote branches.
Date: Sat, 04 Aug 2007 14:36:07 +0200
Message-ID: <85tzrfh3yg.fsf@lola.goethe.zz>
References: <854pjfin68.fsf@lola.goethe.zz>
	<20070804120243.GB9716@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 04 14:36:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHIrr-00005H-T1
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 14:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757432AbXHDMgM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 08:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756421AbXHDMgL
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 08:36:11 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:42900 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756129AbXHDMgJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 08:36:09 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 97D5B1F579C;
	Sat,  4 Aug 2007 14:36:08 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id 78442ABAE0;
	Sat,  4 Aug 2007 14:36:08 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-010-037.pools.arcor-ip.net [84.61.10.37])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 474A0292B61;
	Sat,  4 Aug 2007 14:36:08 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 1A97F1C4F932; Sat,  4 Aug 2007 14:36:07 +0200 (CEST)
In-Reply-To: <20070804120243.GB9716@coredump.intra.peff.net> (Jeff King's message of "Sat\, 4 Aug 2007 08\:02\:43 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3854/Sat Aug  4 06:49:48 2007 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54838>

Jeff King <peff@peff.net> writes:

> On Sat, Aug 04, 2007 at 12:55:43PM +0200, David Kastrup wrote:
>
>> A local branch is one with a local branch head.  In contrast, checking
>> out a remote branch, while possible, leaves one with a detached head.
>
> Yes, if by "remote branch" you mean a "remote tracking branch".

Jeff, I actually have no _clue_ what I "mean" with respect to the
established git terminology because I can't reconcile the
documentation's use of words with my meagre understanding of the
technical processes involved.

So I can't even tell you whether "by remote branch I mean a remote
tracking branch".

>> "remote-tracking" basically means that git-pull will update the
>> branch according to changes in the remote repository.
>
> A "remote tracking branch" is a branch in refs/remotes/* that is
> updated by _git-fetch_ (which is in turn called by git-pull) to
> track a remote's position of a branch.
>
> A local branch which tracks a remote branch (I don't recall seeing
> the phrase "remote-tracking" -- where did this come from?) has the
> correct magic in .git/config to pull from a specific remote branch
> when 'git-pull' is given without arguments.
>
>> Creating a branch using git-branch or git-checkout will always
>> create a local branch which may or may not be remote-tracking
>> according to the --no-track or --track options.
>
> Yes, although again, I think calling it a "remote-tracking branch"
> to mean "a local branch that tracks a remote branch" is confusingly
> similar to the more common "remote tracking branch" to mean "a
> branch in refs/remotes that track's a remote repository's idea of a
> branch".

Well, of _course_ it is confusingly similar.  After all, I am posting
this question because I _am_ confused!  And I am trying to both clear
up my confusion as well as get an idea how to fix the documentation to
be less confusing.

>> So there are basically three types of branches in a repository that
>> I can see:
>> 
>> local branch, not remote-tracking local branch, remote-tracking
>> remote branch, remote-tracking
>
> No, the remote branch is not remote-tracking in the sense that you
> defined above; it is not meant to be pulled into.

Sigh.  But it is cached and updated locally in some manner when
pulling, isn't it?  I can diff against it.

> I think you are confused by two uses of the word "track". In one
> case, we mean that git-fetch will remember the remote's idea of a
> branch in refs/remotes/<remote>/<branch>. In another, we mean that a
> local branch will default to pulling from a particular
> (remote,branch) combination.
>
>> So the terminology seems fuzzy at the moment, and my attempt to
>> clear it up might not be the preferred way of doing it.
>
> Yes, it is very fuzzy. Using "track" for the concept of a local
> branch defaulting to a particular (remote,branch) pair for git-pull
> is, I think, more recent and less used. If there were another term
> for this, it might be more clear.

It is not just git-pull.  I don't get the fine lines between "remote",
"remote tracking" and the respective details in either the user manual
or the manual pages of branch-related commands.

And it's actually worse after your explanations.  Previously I
imagined to have a chance to figure this out on my own, by trying to
abstract from what I see happening when using the various commands.

Now I think that I basically have no chance figuring this out on my
own sufficiently well to be able to improve the documentation.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
