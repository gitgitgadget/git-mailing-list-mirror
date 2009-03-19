From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v2] Introduce %<branch> as shortcut to the tracked   branch
Date: Thu, 19 Mar 2009 16:17:52 +0100
Message-ID: <49C26220.8050603@drmicha.warpmail.net>
References: <200903181448.50706.agruen@suse.de> <20090318182603.GM8940@machine.or.cz> <alpine.DEB.1.00.0903182210310.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903182245280.10279@pacific.mpi-cbg.de> <7vr60ubgul.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de> <49C25C4A.2010202@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>,
	Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu Mar 19 16:21:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkK2O-0002YU-PQ
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 16:20:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757045AbZCSPSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 11:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757885AbZCSPSL
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 11:18:11 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:33553 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757045AbZCSPSJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 11:18:09 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id B9A8D2F70F8;
	Thu, 19 Mar 2009 11:18:07 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 19 Mar 2009 11:18:07 -0400
X-Sasl-enc: bvPf4JpJ2oQgGb1VumDM86JgQIgIuThdqPsXDxtHpOeg 1237475887
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7C8D12A429;
	Thu, 19 Mar 2009 11:18:06 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090319 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <49C25C4A.2010202@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113780>

Michael J Gruber venit, vidit, dixit 19.03.2009 15:52:
> Johannes Schindelin venit, vidit, dixit 18.03.2009 23:46:
>> Hi,
>>
>> On Wed, 18 Mar 2009, Junio C Hamano wrote:
>>
>>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>>
>>>> Suggested by Pasky.
>>>>
>>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>>
>>> In the longer term who suggested matters much less than why such a 
>>> feature is desirable, how it is used, and without it what is impossible 
>>> and/or cumbersome.  What's the motivation behind this?
>>>
>>> You do not have to explain it to me, but you should explain it to the 
>>> history that records this commit, and to the users who read doccos.
>>
>> And that's not all... Documentation updates and tests for % and %<branch> 
>> are missing, too.
>>
>> My main motivation to make this patch was to see how fast I could come up 
>> with something working that does not hurt my eyes.
>>
>> But I do not have time to do more today: My main project as well as Git 
>> got accepted into the Google Summer of Code program, so I am even more 
>> swamped than usually.
>>
>> So... if anybody feels like it, I would be very thankful for a proper 
>> commit message, documentation and tests...
> 
> Just a quick note that I'm feeling like it... Though it seems this does
> not quite work with local branches, i.e. a branch created with
> 
> git checkout --track -b tracking tracked
> 
> with "tracked" being a local branch. I don't see why on first inspection
> of the code (branch.tracking.merge = refs/heads/tracked, so what), but
> maybe you will...

So, for a local branch, branch_get() returns a branch without merge info
even though it's in the config (the remote is "." here). "git branch
--track" is specifically meant for (branching off a ) local branch,
because it's the default for remote branches anyway. Right? Does not
look right.

Michael
