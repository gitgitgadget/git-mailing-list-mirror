From: Andreas Ericsson <ae@op5.se>
Subject: Re: Help designing work flow
Date: Mon, 09 Mar 2009 13:27:40 +0100
Message-ID: <49B50B3C.50700@op5.se>
References: <450196A1AAAE4B42A00A8B27A59278E709F07D30@EXCHANGE.trad.tradestation.com>	 <49B4F5A9.5060304@op5.se> <43d8ce650903090444n352f310fs9cd4b8b0184be010@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: John Dlugosz <JDlugosz@tradestation.com>, git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 13:29:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgebd-00085U-I2
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 13:29:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbZCIM1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 08:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbZCIM1s
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 08:27:48 -0400
Received: from spsmtp02oc.mail2world.com ([74.202.142.148]:3173 "EHLO
	spsmtp02oc.mail2world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbZCIM1s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 08:27:48 -0400
Received: from mail pickup service by spsmtp02oc.mail2world.com with Microsoft SMTPSVC;
	 Mon, 9 Mar 2009 05:26:12 -0700
auth-sender: exon@home.se
Received: from 212.112.174.166 unverified ([212.112.174.166]) by spsmtp02oc.mail2world.com with Mail2World SMTP Server; 
	Mon, 09 Mar 2009 05:26:11 -0700
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <43d8ce650903090444n352f310fs9cd4b8b0184be010@mail.gmail.com>
X-OriginalArrivalTime: 09 Mar 2009 12:26:12.0389 (UTC) FILETIME=[3BC0E550:01C9A0B2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112692>

John Tapsell wrote:
> 2009/3/9 Andreas Ericsson <ae@op5.se>:
>> John Dlugosz wrote:
>>> I know we (my group) should use "topic" branches and apply them back to
>>> the dev branch when done.  There is concern that the commit history gets
>>> too full of detailed stuff, especially with several developers, that you
>>> can't tell what "really changed".  So, our dev branch should appear to
>>> contain only commit nodes representing completed assignments; not every
>>> day's checkpoint and trying to keep one's own stuff on top to avoid
>>> merging later.
>>>
>>> I guess that's how it is on these Open Source projects where patches are
>>> submitted by email and applied by the maintainer.  We don't see the
>>> details, just the final patch.  But, my situation will be developers
>>> gathered around an in-house master repo, and everyone should be able to
>>> push their own changes as assignments are completed.
>>>
>>> What is the best procedure to achieve that?  Or what are some good
>>> alternatives with trade-offs?
>>>
>> Use topic-branches and let someone merge them into master after having
>> verified that they work properly.
>>
>> We usually commit simple bugfixes directly to master and then have
>> developers rebase their changes onto master when they're ready to
> 
> The trouble with rebasing is that it then you end up with lots of
> patches that haven't been tested.  You can end up with lots of
> uncompiling commits.
> 

Not really, no. Unit-tests can still run just fine, and integration
testing still needs to be done after each feature is completed.

> Although merging is no better either.  Then you end up with one single
> commit that tries to merge two trees, making it almost impossible to
> track down bugs that resulted from the merge.
> 

Not really. If bugs are in "unrelated" areas (if the topic changed some
API without changing its' other callers, fe), you can backstep between
each commit on the merged branch, remerge that commit (instead of the
tip) and then run the tests again. But really, such bugs should have
been detected prior to merging the branch, and in any case "git bisect"
will find the commit that introduced the bug for you either way.


For next time, please cut away those parts of the email you didn't
reply to. I had to scroll down to the bottom to make sure you hadn't
written more.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
