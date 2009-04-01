From: Andreas Ericsson <ae@op5.se>
Subject: Re: On git 1.6 (novice's opinion)
Date: Wed, 01 Apr 2009 10:37:24 +0200
Message-ID: <49D327C4.7000101@op5.se>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <49CCAF5D.21814.24B4DE63@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <f9d2a5e10903292318w6108bc50u2ddc830a6d9d85df@mail.gmail.com> <49D339B2.4388.6B1DEF@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Russ Dill <russ.dill@gmail.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Wed Apr 01 10:39:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lovyw-0006Zs-Rm
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 10:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761993AbZDAIhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 04:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754757AbZDAIhi
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 04:37:38 -0400
Received: from mail.op5.se ([193.201.96.20]:44912 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762182AbZDAIhe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 04:37:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 88C471B80F34;
	Wed,  1 Apr 2009 10:15:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EW8F1j+IkcJA; Wed,  1 Apr 2009 10:15:00 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.14])
	by mail.op5.se (Postfix) with ESMTP id C4B631B80F1A;
	Wed,  1 Apr 2009 10:14:59 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <49D339B2.4388.6B1DEF@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115356>

Ulrich Windl wrote:
> On 29 Mar 2009 at 23:18, Russ Dill wrote:
> 
>> On Fri, Mar 27, 2009 at 2:50 AM, Ulrich Windl
>> <ulrich.windl@rz.uni-regensburg.de> wrote:
>>> On 27 Mar 2009 at 9:05, H.Merijn Brand wrote:
>>>
>>>> On Fri, 27 Mar 2009 08:21:36 +0100, "Ulrich Windl"
>>>> <ulrich.windl@rz.uni-regensburg.de> wrote:
>>>>
>>>>> What I'd like to see in git (My apologies if some were already discussed to
>>>>> death):
>>>>>
>>>>> 1) The ability to use the file's time at the time of add/commit instead of
>>>>>    the current time, and the ability tho check outfiles with the times stored
>>>>>    in the repository.
>>>>>
>>>>> 2) Keyword substitution. I know it's controverse (dealing with binary files),
>>>>>    but I'd like to have some automatic version numbering keyword at least:
>>>>>    Initial idea is that every commit with a change increments the number by
>>>>>    one, and when merging numbers a and b, the resulting number is max(a, b) + 1.
>>>> impossible. Even with checkin- and checkout hooks, you won't get that
>>>> SCCS behaviour. They have to be better in something too :)
>>>> /me still misses that but got used to it
>>> Hi,
>>>
>>> what made me wonder is this (about item 1): I thought I've read that blobs store
>>> content and attributes, so very obviously I wondered why not store thr "right
>>> attributes" (i.e. the time of the file). My reasoning: You make some changes, then
>>> test them (which might last several hours or days). The if I'm happy I'll
>>> "commit". Naturally I want to see the time of change for each file when the change
>>> had been actually made, not when the change was committed. Likewise when checking
>>> out, I want to be able to see the time of modification, not the time of commit.
>>> I'm aware that many people don't care about such differences...
>>>
>> Ok, so if Nancy did some work on the part number form 6 months ago,
>> but it got merged into master yesterday. What date should the file
>> have? This kind of incremental version number, and trusting of file
> 
> If Nancy committed it with my semantics, the file's date would be 6 months old 
> before the merge. If the merge would not require any change, the file's date would 
> still be six months old. If a change was required, the file's date would be the 
> time of change. That sounds quite logical to me.
> 

But if you built the old source before you merged but after Nancy made her
changes, make wouldn't grok that the file is actually changed. Trust me,
the current semantics are far better.

>> dates really only matters on a centralized system with a single
>> branch.
>>
>> Not only that, but modification times are much more useful with make.
>> Merging or pulling small changes into a tree shouldn't require a full
>> rebuild of the entire tree which in some cases could take hours.
> 
> Git is not a build system, and I really dislike "full rebuilds", but for 
> stability, before releasing anything, one should test it with a full rebuild.

I build all the time. Before and after every commit (merges are one type of
commit). I rely on file timestamps to be an accurate indicator of when the
file last changed *on my disk*.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
