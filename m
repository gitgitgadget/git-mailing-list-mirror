From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Sat, 17 Oct 2009 16:32:14 +0100 (BST)
Message-ID: <alpine.LNX.2.00.0910171617580.6644@reaper.quantumfyre.co.uk>
References: <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com> <alpine.LNX.2.00.0910141509200.32515@iabervon.org> <alpine.LFD.2.00.0910141616530.20122@xanadu.home> <7v7huxbtbk.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org> <20091014230934.GC29664@coredump.intra.peff.net> <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com> <alpine.LNX.2.00.0910151523020.32515@iabervon.org> <alpine.LNX.2.00.0910161311460.28491@reaper.quantumfyre.co.uk>
 <20091016143041.GA11821@atjola.homenet> <alpine.LNX.2.00.0910161821230.30589@reaper.quantumfyre.co.uk> <7vvdiftb0d.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0910162029460.31673@reaper.quantumfyre.co.uk> <7vk4yvt7kp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 17:39:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzBNt-0006Vb-26
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 17:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbZJQPjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2009 11:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751988AbZJQPjr
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 11:39:47 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:44321 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751911AbZJQPjq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Oct 2009 11:39:46 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 19110355318
	for <git@vger.kernel.org>; Sat, 17 Oct 2009 16:39:50 +0100 (BST)
Received: (qmail 25446 invoked by uid 103); 17 Oct 2009 16:32:14 +0100
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.95.2/9906. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.025836 secs); 17 Oct 2009 15:32:14 -0000
Received: from reaper.quantumfyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 17 Oct 2009 16:32:14 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <7vk4yvt7kp.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130561>

On Fri, 16 Oct 2009, Junio C Hamano wrote:

> Julian Phillips <julian@quantumfyre.co.uk> writes:
>
>> On Fri, 16 Oct 2009, Junio C Hamano wrote:
>>
>>> Julian Phillips <julian@quantumfyre.co.uk> writes:
>>> ...
>>>> I don't care what git has to do, I'm talking about the user experience
>>>
>>> But Bj?rn is showing two commands the _user_ has to type, iow, the comment
>>> is about the user experience.
>>
>> Only Currently.  My point was that _if_ we wanted to support this sort
>> of thing, then we can make is simpler to do by providing a simple
>> command for the user.
>>
>> The point I wanted to make was that the decision on what to do should
>> be driven by the user's experience - not by the fact that it is easier
>> to implement something else.
>
> Sorry, but I do not see in what way what you said in the thread connects
> to the above three lines.  Are you talking about this one from you a few
> messages back?
>
>    How about:
>
>    $ git checkout origin/master
>    $ git fetch
>    Refusing to fetch, as it would update a checkedout branch
>    "git fetch -f" will force the update, but you will need to run "git
>    reset --hard HEAD" to update your checkout to match.
>
> I am not seeing "not the implementation ease but the user experience"
> drive in this suggestion.  If you are driving from the user experience
> point of view, I would have instead suggested:
>
>    How about:
>
>    $ git checkout origin/master
>    $ git fetch
>
>    and fetch happily updates the tracked branch, without affecting the
>    HEAD state (nor index nor the work tree, of course).

True.  I was saying that having git stop and explain things is better than 
making a mess for the user to clear up.  Having it just work would of 
course be even better.  Hoist by my own petard indead ...

>> My interest in this thread is solely that it might provide a mechanism
>> to find out which tag was checked out.
>
> Hmm, what is lacking in "git describe HEAD" for that?  I am not
> complaining that you might be asking for something that exists, but I _do_
> want to know if something that exists is not a satisfactory solution and
> if so how it can be improved.

What is lacking is the "checked out" part.  "git describe HEAD" will tell 
me _a_ tag that matches the currently checked out state.  However, it 
makes no guarantee that it was the one I checked out.  If I tag the code 
with "v1.0.0", and a colleague later tags it with "this_version_sucks", 
then when I check out and build the code for the customer the version it 
reports could well be "this_version_sucks" instead of "v1.0.0" ...

Nicolas Pitre suggested using the reflog, which does seem to include the 
information that I want, but I feel a little uneasy about accessing it via 
a script - how certain is it that the format of the message won't change? 
Is accessing the reflog the sort of thing people expect as part of the 
scripting interface?

-- 
Julian

  ---
Those who would repeat the past must control the teaching of history.

   -- Bene Gesserit Coda
