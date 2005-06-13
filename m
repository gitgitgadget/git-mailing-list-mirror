From: linux@horizon.com
Subject: Re: [zooko@zooko.com: [Revctrl] colliding md5 hashes of human-meaningful
Date: 13 Jun 2005 23:03:24 -0000
Message-ID: <20050613230324.32002.qmail@science.horizon.com>
References: <Pine.LNX.4.58.0506131434260.8487@ppc970.osdl.org>
Cc: git@vger.kernel.org, linux@horizon.com
X-From: git-owner@vger.kernel.org Tue Jun 14 01:03:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhxxH-0005Gu-P9
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 01:02:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVFMXHT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Jun 2005 19:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbVFMXFv
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jun 2005 19:05:51 -0400
Received: from science.horizon.com ([192.35.100.1]:25406 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261183AbVFMXDZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2005 19:03:25 -0400
Received: (qmail 32003 invoked by uid 1000); 13 Jun 2005 23:03:24 -0000
To: torvalds@osdl.org
In-Reply-To: <Pine.LNX.4.58.0506131434260.8487@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Oh, for heaven's sake.  This is getting to be entirely too big
an issue.  For the record, I believe:

- There are far easier ways to back-door the public Linux kernel.
  (See the recent "subtly malicious code" contest.)
- There are far easier ways to back-door a particular target's
  kernel.
- There are easier ways than back-dooring their kernel to attack
  a particular target's computer.
- A 2^80 work factor is sufficient protection for quite a few
  years, especially as the processor speed growth curve finally
  seems to be flattening.

All I was trying to point out is that a sqrt(n) hash collision
attack *exists*.  Not that it's practical or anything.

For the quantity of computers required, it would be *cheaper* to start a
factory making my own line of PCI bus master network cards that included
remote memory sniffing features on-board!

> Yeah, yeah. You avoided a few laws of phsyics of your own.
>
> For example, when you say
>
>  "(With an n-bit hash and an automated way to make harmless changes
>   to source files, I can generate 2^(n/2) variants of each and expect to
>   get a match, even in the absence of a better attack.)"
>
> you kind of ignore the fact that "n" here is 160, and so you're going to 
> be searching for quite a few versions of each. Also, you have to compare 
> the sha's of all of those 2**80 versions against each other which is a lot 
> of work in itself.

I am most definitely NOT ignoring it.  That's what makes the attack infeasible.
(But I insist that 2^80 is a hell of a long way from violating any laws
of physics.)

As for the comparison, if the two texts have the same form, there are
well-known ways to reduce the storage requirements by large factors
like 2^40.  For texts of different form, regular Pollard's rho doesn't
work, but maybe something ingenious is possible.

All I was trying to say is that a sqrt(2^160) attack exists.  Remember
the original statement?

>>> So the problem is totally different from the way git uses a hash. In the 
>>> git model, an attacker by definition cannot control both versions of a 
>>> file, since if he controls just _one_ version, he doesn't need to do the 
>>> attack in the first place!
>>>
>>> Put another way: you could use this exact example for a version of git
>>> that uses md5-sums instead of sha1's, but it wouldn't show anything at all 
>>> about a git vulnerability even so.

*That's* what I was responding to.  It basically says "there is no
collision attack on the way git uses the hash", a statement I disagree
with.  I didn't say it was a realistic attack, because the whole reason
that SHA is 160 bits is so that it's resistant to a hash collision attack!


> Finally, you have to make sure that al the versions make sense, and that 
> people will take them 100% unmodified. 

Making them all make sense isn't hard; I can come up with 80 binary
variants on a piece of code by changing order of helper functions,
order of variable declarations, order of statements, comments,
spacing, and whatnot without even having to get into trailing
or redundant whitespace.

Making sure that nobody messes with it is trickier.  That would be
easier with a small patch, but that would in turn make the problem
of generating 2^80 plausible variants harder.

I'm reaching a bit, but hey, it was a quick description, not a
fully-fledged Cunning Plan.

> My plan was more interesting, I feel.

Oh for you, sure.  But as the one you had nominated to carry it
out, I'd like to object!

For plausibility, I prefer mine for manufacturing network cards with
built-in back doors.  There's a chance I could even get the Chinese
government to help fund it.
