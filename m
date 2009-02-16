From: david@lang.hm
Subject: Re: disallowing push to currently checked-out branch
Date: Sun, 15 Feb 2009 21:55:24 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0902152143430.14911@asgard.lang.hm>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <20090215232013.GA11543@zakalwe.fi> <20090216000443.GB3503@coredump.intra.peff.net> <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm> <20090216035027.GA12689@coredump.intra.peff.net>
 <alpine.DEB.1.10.0902152057500.14911@asgard.lang.hm> <20090216040529.GC12689@coredump.intra.peff.net> <alpine.DEB.1.10.0902152113380.14911@asgard.lang.hm> <20090216043708.GB12986@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Heikki Orsila <shdl@zakalwe.fi>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 05:52:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYvSZ-0004XZ-62
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 05:51:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756164AbZBPEuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 23:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756061AbZBPEub
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 23:50:31 -0500
Received: from mail.lang.hm ([64.81.33.126]:38049 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755948AbZBPEua (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 23:50:30 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n1G4oPf4020649;
	Sun, 15 Feb 2009 20:50:25 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20090216043708.GB12986@coredump.intra.peff.net>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110137>

On Sun, 15 Feb 2009, Jeff King wrote:

> On Sun, Feb 15, 2009 at 09:18:47PM -0800, david@lang.hm wrote:
>
>>> So people doing major version upgrades of their OS don't need to read
>>> release notes or re-test behavior?
>>
>> when was the last time you read the release notes for an entire distro?
>
> Since you ask, I track Debian unstable and I read the release notes
> (NEWS.Debian) for every package that I upgrade, and skim the changelogs
> for perhaps half.
>
> But yes, I realize that is not common; I don't expect that every user
> reads every release note.
>
> My point is that things _are_ going to change in a major version OS
> upgrade. It is up to the user to make the tradeoff of how much time they
> want to spend researching those changes versus the likelihood and
> severity of breakage. If I have a mission critical system running git,
> I'm going to read git's release notes. If I don't, then I will probably
> accept that something could break, and fix it if it does.

in that case there's no reason for any warning time. just change the 
default and put a comment about it in the changelog.

that worked well for the dashed names didn't it.

>> and it's not a matter of reading the release notes. it's a matter of them
>> running a version that gives them a warning before you feed them a version
>> that will cause their existing stuff to fail.
>
> The warning is not a panacea:
>
>  1. It might actually cause breakage. Less likely than a straight
>     change in behavior, but still possible.
>
>  2. Users don't necessarily see the warning. By definition, it is not
>     changing the behavior. So unless they are examining the output
>     (which might not be the case for an unattended system), it can go
>     unnoticed.
>
> So all of the problems you are talking about are still possible even
> with an extremely long change cycle.
>
>> I recognise that not all software is concerned about backwards
>> compatibility, but if git wasn't concerned with backwards compatibility
>> and a graceful upgrade process, this thread wouldn't exist.
>
> I think git is much better about backwards compatibility than most
> packages I have seen. But there is a cost to maintaining it completely
> and forever, in that you are either hampered in what you can do (i.e.,
> there are enhancements you would like to make but can't) or you pay an
> awful burden in development cost maintaining two diverging codebases.
>
> Based on the numbers in your last email, you seem to be advocating a
> 9-15 year lag on making any behavior changes in git. I'm sorry, but I
> have no interest in waiting that long to see enhancements I work on in
> git make it into a released version.

two cycles of changes, not three, so 6-10 years for changes that break 
existing bahavior without a _really_ pressing reason. so new functions, 
new commands, new flags don't have to wait at all. it's only if you want 
to change something that will cause grief for users if they get a new 
version and run their existing tools against it.

> I think Junio is doing a fine job at dealing with backwards
> compatibility and keeping things moving at a reasonable pace. If you
> think it should go slower, you are certainly welcome to fork and release
> an "ultra-stable" version of git that reverts any backwards incompatible
> changes while keeping up with other new features.

I am not interested in forking git. but I am saying that a backwards 
incompatible change had better _really_ be worth it, and not just be worth 
it for the people who live an breath git, but for the users as well (this 
is a test that the dashed name elimination failed. in spite of a volcal 
few saying that all the commands in the path were causing problems, most 
people couldn't understand why the git people wanted to remove them)

for anything less than a fairly critical bug, if it's in a public 
interface you really don't want to change it (in part becouse the 
timeframe to properly depriciate it, with warnings, needs to happen on 
timescales measured in years)

and I agree that Junio is doing a good job with this. he's the one who 
started this thread to discuss the possible changes after all.

David Lang

> -Peff
>
