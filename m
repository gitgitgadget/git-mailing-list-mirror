From: Andreas Ericsson <ae@op5.se>
Subject: Re: Adding push configuration to .git/config
Date: Thu, 22 Nov 2007 08:52:49 +0100
Message-ID: <47453551.3060502@op5.se>
References: <20071121105517.GA11875@denkbrett.schottelius.org> <7vabp79hjt.fsf@gitster.siamese.dyndns.org> <C297CFC3-8DD0-4EEE-8FD3-BF997F6E269A@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nico -telmich- Schottelius <nico-linux-git@schottelius.org>,
	git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Nov 22 08:53:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv6s5-0004rK-K1
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 08:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbXKVHwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 02:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbXKVHwz
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 02:52:55 -0500
Received: from mail.op5.se ([193.201.96.20]:59343 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751719AbXKVHwy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 02:52:54 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 6D25E1F08049;
	Thu, 22 Nov 2007 08:52:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XRB-aZgW8ToE; Thu, 22 Nov 2007 08:52:52 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 4A7FA1F0803B;
	Thu, 22 Nov 2007 08:52:52 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <C297CFC3-8DD0-4EEE-8FD3-BF997F6E269A@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65747>

Steffen Prohaska wrote:
> 
> On Nov 22, 2007, at 2:48 AM, Junio C Hamano wrote:
> 
>> Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
>> writes:
>>
>>> Nice would be
>>>
>>> [branch "master"]
>>>    remote-push          = origin
>>>    remote-push-merge    = another_branch
>>>
>>> And thus perhaps also changing the existing specs:
>>>
>>>    remote = ... to remote-fetch = ...
>>>    merge = ... to remote-fetch-merge =
>>
>> I do not think doing this is worth it, not because I think a
>> single branch.$name.remote should be good enough for everybody,
>> but because once you need a separate remote each for fetching
>> and pushing, there is no reason to say one per direction is
>> enough.
>>
>> An alternative could be to split [remote "name"] url into two
>> variants, fetch-url and push-url.  While fetching by default
>> from two places without telling from which one does not make any
>> sense, pushing by default to two different places is quite a
>> normal thing to do, and we already do support more than one url
>> entries in [remote "name"] section used for pushing.
>>
>> If we were to do this, it might also make sense to rename the
>> word 'origin' we use for the default remote name to 'default' or
>> something.  People with shared repository workflow would fetch
>> from one repository and push back to the same repository, so the
>> distinction would not matter, but for others who need something
>> like you suggest, the default repository for fetching and
>> pushing are different, and while you may still consider where
>> you fetch from your 'origin', where you push into is not your
>> 'origin' anymore.
> 
> I like this idea.
> 

I don't. It's troublesome enough to try to teach the finer points
of git to my co-workers without different defaults between versions.

So far we're getting around the problem by the relatively crude
expedient of forcing everyone to update to the latest stable from
master each time I say so. It works, but doesn't scale too well, and
since every major distro now ships git packages, it would be nice if
default-names at least settled down and were only changed with new
major releases (that is, from 1.x to 2.x).

On the other hand, I'm sure we'll cope whatever you decide.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
