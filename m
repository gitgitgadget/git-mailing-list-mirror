From: david@lang.hm
Subject: Re: disallowing push to currently checked-out branch
Date: Sun, 15 Feb 2009 17:33:59 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <20090215232013.GA11543@zakalwe.fi> <20090216000443.GB3503@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Heikki Orsila <shdl@zakalwe.fi>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 01:30:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYrNi-0004ou-Qz
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 01:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754206AbZBPA3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 19:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754079AbZBPA3I
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 19:29:08 -0500
Received: from mail.lang.hm ([64.81.33.126]:33375 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752087AbZBPA3I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 19:29:08 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n1G0T1UJ019777;
	Sun, 15 Feb 2009 16:29:01 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20090216000443.GB3503@coredump.intra.peff.net>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110101>

On Sun, 15 Feb 2009, Jeff King wrote:

> On Mon, Feb 16, 2009 at 01:20:13AM +0200, Heikki Orsila wrote:
>
>>> * git-push to update the checked out branch will be refused by default
>>>
>>>   Make "git push" into a repository to update the branch that is checked
>>>   out fail by default.
>>>
>>>   http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007
>>
>> If this is implemented, it shouldn't, in my opinion, be a default
>> setting. I regularly push to checkout repos when I'm doing cross machine
>> development. However, I could live with a configurable setting as
>> proposed in the given URL. I think Git should not be too cautious about
>> following users instructions. The user knows what is best for him/her ;)
>
> It is already implemented; the proposal is about setting the default.
> The plans for 1.6.2 are already to issue a warning and ask the user to
> set the config variable to shut it up.

if this is going to be done the timeframe for making the change should be 
quite long. think in terms of debian stable or RHEL, whatever version they 
ship is what their users are going to use. it doesn't matter how many new 
versions and what warnings you have the produce in the meantime, the users 
won't see them.

to the progression needs to be

one upgrade cycle the user is using the old version with no warning.

next upgrade cycle the user is using a version with a warning.

the third upgrade cycle the user is using the version with the default 
changed.

the problem is that these upgrade cycles are 3-5 years each, and it's not 
unusual for the types of users that use dbian stable or RHEL to be running 
these systems in places where they do not get patched during their 
lifetime.

note that this isn't always stupid to do, if you are deploying them on a 
network with no Internet access the stability of knowing that things are 
_exactly_ what you tested may be worth more than updates that close bugs 
that you don't hit or add features that you aren't using (or introduce 
unexpected changes like spitting warnings or errors for things that the 
old version didn't, which is exactly what is being proposed.

David Lang
