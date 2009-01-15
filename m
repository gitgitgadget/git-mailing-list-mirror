From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: rebase -p confusion in 1.6.1
Date: Thu, 15 Jan 2009 15:45:04 +0100
Message-ID: <496F4BF0.6020805@drmicha.warpmail.net>
References: <slrngmu4j5.e1u.sitaramc@sitaramc.homelinux.net> <496F3C99.1040800@drmicha.warpmail.net> <20090115135518.GB10045@leksak.fem-net> <496F44AC.2060607@drmicha.warpmail.net> <alpine.DEB.1.00.0901151518520.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org,
	Stephen Haberman <stephen@exigencecorp.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 15 15:47:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNTUT-0002xG-5S
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 15:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756438AbZAOOpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 09:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761004AbZAOOpK
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 09:45:10 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56622 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756438AbZAOOpI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jan 2009 09:45:08 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 0DD37213343;
	Thu, 15 Jan 2009 09:45:05 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 15 Jan 2009 09:45:05 -0500
X-Sasl-enc: xXFRRHDaN5DuLvYFl6SziH7zN2I/UWkB857QCJgzYoUV 1232030704
Received: from [139.174.44.34] (pascal.math.tu-clausthal.de [139.174.44.34])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0924345EE0;
	Thu, 15 Jan 2009 09:45:03 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <alpine.DEB.1.00.0901151518520.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105823>

Johannes Schindelin venit, vidit, dixit 15.01.2009 15:25:
> Hi,
> 
> On Thu, 15 Jan 2009, Michael J Gruber wrote:
> 
>> Stephan Beyer venit, vidit, dixit 15.01.2009 14:55:
>>
>>>> First of all: git 1.6.0.6 gives you the unchanged graph after using
>>>> rebase -i -p.
>>> This is true and it is a far better behavior than now, but I think it's
>>> not the expected behavior. (I have written about the behavior I'd expect
>>> in another reply to the original mail.)
>> Yep, I think -p should preserve only merges in side branches
> 
> you mean everything in master..work?
> 
>> (and therefore produce what you suggest, and what you get without -p). 
>> If it preserves all merges then there is nothing to rewrite here.
> 
> The merge _is_ outside of master, so I do not understand what the heck you 
> are talking about.

Easy Dscho, easy ;)
[meaning "take it such..."]

I'm not sure what -p is supposed to do:

A) Should it preserve all merge commits which it would need to rewrite?
That is lot to ask. Previous behaviour (intended or not) seemed to be to
do nothing in this case where the merge connects master and work.

B) Should it preserve only merges in side branches? I seem to mean by
that branches where the parents are on work and other branches but not
on master.

So at least on my side there is confusion about the intention behind
'-p' (say design goal), and therefore about the expectation.

> The more I think about it, I think it's possible I broke it with the 
> introduction of the "noop".
> 
> However, there could be a _different_ test case where the current -p 
> handling shows the same error.  Dunno.

It certainly worked after the noop introduction before the r-i-p series,
but not any more after. "worked" meaning it at least didn't leave out
commits in this case (but reproduced the existing DAG). I'm getting the
impression you suggest R.I.P. for r-i-p series ;) Fine with me...

Cheers,
Michael
