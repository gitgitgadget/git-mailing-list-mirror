From: david@lang.hm
Subject: Re: disallowing push to currently checked-out branch
Date: Sun, 15 Feb 2009 21:05:33 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0902152057500.14911@asgard.lang.hm>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <20090215232013.GA11543@zakalwe.fi> <20090216000443.GB3503@coredump.intra.peff.net> <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm> <20090216035027.GA12689@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Heikki Orsila <shdl@zakalwe.fi>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 05:02:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYugP-0004PT-Nw
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 05:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756010AbZBPEAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 23:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755994AbZBPEAq
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 23:00:46 -0500
Received: from mail.lang.hm ([64.81.33.126]:59473 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755967AbZBPEAq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 23:00:46 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n1G40Xld020476;
	Sun, 15 Feb 2009 20:00:33 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20090216035027.GA12689@coredump.intra.peff.net>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110131>

On Sun, 15 Feb 2009, Jeff King wrote:

>>> It is already implemented; the proposal is about setting the default.
>>> The plans for 1.6.2 are already to issue a warning and ask the user to
>>> set the config variable to shut it up.
>>
>> if this is going to be done the timeframe for making the change should be
>
> I don't know that a particular timeframe for switching the default has
> been chosen at this point. There is a short warning in 1.6.1, and a much
> more comprehensive warning will be in 1.6.2 (which should be released
> shortly).
>
>> quite long. think in terms of debian stable or RHEL, whatever version they
>> ship is what their users are going to use. it doesn't matter how many new
>> versions and what warnings you have the produce in the meantime, the users
>> won't see them.
>
> Sadly, Debian 5.0 just shipped with git 1.5.6.5, which has no warning
> (and dashed commands!).
>
>> note that this isn't always stupid to do, if you are deploying them on a
>> network with no Internet access the stability of knowing that things are
>> _exactly_ what you tested may be worth more than updates that close bugs
>> that you don't hit or add features that you aren't using (or introduce
>> unexpected changes like spitting warnings or errors for things that the
>> old version didn't, which is exactly what is being proposed.
>
> I'm not sure I understand your argument here. If you have a machine that
> needs to do _exactly_ what you have tested, then wouldn't you be
> concerned about upgrading git 1.5.6.5 to (for example) git 1.7? Or since
> you are probably looking at a more macro-level, upgrading Debian 5.0 to
> Debian 6.0?

two points

1. someone running Debian 5 who then upgrades to Debian 6 should get the 
warning, not the refusal, then when they go to Debian 7 the refusal can be 
the standard (and substatute redhat enterprise version numbers for debian 
if you want)

2. you can't count on users upgrading any faster than I tak about in 
#1. Debian shipped 1.5.6.5 in 5.0, when users upgrade to Debian 6.0, you 
can't assume that they _ever_ patched the system, so even if you released 
a 1.5.6.6 today that had the warning in it, you can't assume that users 
saw it and so it's safe to remove the dashed commands in the version that 
will ship with Debian 6.0.

so a warning can go in at any time, but changing the default in a way 
that's not backwards compatible needs to be done over a _very_ long 
timeframe. so long that it's worth questioning if it's worth changing (as 
opposed to either just leaving the warning, or trying to figure out a 
different way)

David Lang
