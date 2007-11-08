From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] user-manual: add advanced topic "bisecting merges"
Date: Thu, 08 Nov 2007 10:53:28 +0100
Message-ID: <4732DC98.70304@viscovery.net>
References: <20071104112302.GA2119@ins.uni-bonn.de> <11944722214046-git-send-email-prohaska@zib.de> <4732B899.6000908@viscovery.net> <6E62E205-0951-4CCB-A807-AC107E40ACE1@zib.de> <4732D2CC.1010008@viscovery.net> <4732D7F6.7040006@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, Ralf.Wildenhues@gmx.de, tsuna@lrde.epita.fr,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>, Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 10:53:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq455-0000tM-N3
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 10:53:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757492AbXKHJxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 04:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756447AbXKHJxc
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 04:53:32 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:63657 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725AbXKHJxc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 04:53:32 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Iq44K-0007UA-IF; Thu, 08 Nov 2007 10:53:00 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5249B6B7; Thu,  8 Nov 2007 10:53:28 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <4732D7F6.7040006@op5.se>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63985>

Andreas Ericsson schrieb:
> Johannes Sixt wrote:
>> Steffen Prohaska schrieb:
>>>
>>> On Nov 8, 2007, at 8:19 AM, Johannes Sixt wrote:
>>>
>>>> Steffen Prohaska schrieb:
>>>>> +If you linearize the history by rebasing the lower branch on
>>>>> +top of the upper, instead of merging, the bug becomes much easier to
>>>>> +find and understand.  Your history would instead be:
>>>>
>>>> At this point I'm missing the words
>>>>
>>>>     The solution is ...
>>>>
>>>> I.e.:
>>>>
>>>> The solution is to linearize the history by rebasing the lower 
>>>> branch on
>>>> top of the upper, instead of merging. Now the bug becomes much 
>>>> easier to
>>>> find and understand.  Your history would instead be:
>>>
>>> Hmm. It might be a solution if you did not publish history.
>>
>> This is about finding the commit that introduced a bug. Once you found 
>> it, better: you know how to fix the bug, you are expected to throw 
>> away the rebased branch, not to publish it! Maybe a note along these 
>> lines could be appended:
>>
>> Now that you know what caused the error (and how to fix it), throw 
>> away the rebased branch, and commit a fix on top of D.
>>
> 
> Well, if rebasing becomes the standard for normal development, it's hardly
> right to throw it away, is it? I like Steffen's suggestion better.

There is a big misunderstanding. The text that the patch amends is about 
bisecting history that reveals that a merge commit breaks, which is not 
helpful, and then how to find where and what and why the breakage really was 
introduce.

And the answer to "how to find" is to rebase and bisect in the rebased history.

My initial complaint was that in the flow of reading the instructions the 
pointer to "the solution" was missing. Rather, at the point where the reader 
is supposed to think "ah, yes, that's how to do it", there is the 
conditional statement "If you linearize history". My suggestion is to put a 
big emphasis on the solution by using the words "The solution is".

Now, the user can *always* rebase one of the branches on top of the other, 
even if both histories are already published. *But* if both were indeed 
published, then the rebased history must be thrown away, and the only thing 
you learnt from it was where and what and why the breakage really was 
introduced.

Of course we could include a few "ifs" and "unlesses" (about published 
histories), before suggesting to throw away rebased history. But once the 
task is accomplished (find the bogus commit), throwing away the rebased 
history (and continuing at commit D) is always correct, but keeping it (and 
continuing at D*) is not.

-- Hannes
