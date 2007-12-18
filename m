From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-stash: RFC: Adopt the default behavior to other commands
Date: Tue, 18 Dec 2007 17:06:18 +0100
Message-ID: <4767EFFA.1070909@op5.se>
References: <20071217110322.GH14889@albany.tokkee.org>	<506C6191-655D-46AE-A5C2-1335A9044F44@lrde.epita.fr>	<7vk5nd53lp.fsf@gitster.siamese.dyndns.org>	<57F403E7-AF5B-40F1-AE9D-8EA036675A67@lrde.epita.fr>	<7vfxy04ze7.fsf@gitster.siamese.dyndns.org>	<20071218105941.GA17251@albany.tokkee.org>	<Pine.LNX.4.64.0712181231420.23902@racer.site> <4767D7A2.30703@op5.se>	<Pine.LNX.4.64.0712181445420.23902@racer.site>	<4767E07A.2020100@op5.se>	<Pine.LNX.4.64.0712181513060.23902@racer.site>	<4767E717.2060902@op5.se> <m3lk7sovt0.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sebastian Harl <sh@tokkee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 17:06:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4exz-0001sP-Ec
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 17:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757518AbXLRQGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 11:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757373AbXLRQGY
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 11:06:24 -0500
Received: from mail.op5.se ([193.201.96.20]:60235 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754506AbXLRQGX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 11:06:23 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 60DAA1F08049;
	Tue, 18 Dec 2007 17:06:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qkJbG9DT9-Al; Tue, 18 Dec 2007 17:06:20 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id ADC891F08043;
	Tue, 18 Dec 2007 17:06:19 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <m3lk7sovt0.fsf@roke.D-201>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68769>

Jakub Narebski wrote:
> Andreas Ericsson <ae@op5.se> writes:
>> Johannes Schindelin wrote:
>>> On Tue, 18 Dec 2007, Andreas Ericsson wrote:
>>>> Johannes Schindelin wrote:
>>>>
>>>>> In the alternative, you could just scrap all those default
>>>>> actions, showing synopses instead.  For all commands, including
>>>>> "git commit", "git log", "git fetch", etc.
>>>> Like we do for the git wrapper, you mean? Yes, that would be one
>>>> solution, although not a very good one for all commands.
>>> Exactly.  Not a good one.
>>>
>>>> It's probably not a bad idea for commands where the primary use is
>>>> something else than producing visual output though, such as tag or
>>>> branch, but those handle creation/deletion of stuff, so the default
>>>> action for them is to list stuff of the kind they operate on. I
>>>> fail to see why stash should be any different.
>>> I also fail to see why stash should be any different.  And that's why
>>> I expect it to have a default operation, which is -- you guessed it -- 
>>> "stash the changes!"
>> Actually, I guessed "list the stashes".
>>
>>> If I am not sure what I am about to do, there is -- wonder of wonders -- 
>>> the "-h" option!  And indeed:
>>> 	$ git stash -h
>>> 	Usage: /home/gitte/bin/git-stash [  | save | list | show |
>>> apply | 		clear | create ]
>>> So what exactly was your point again?
>>>
>> My point is that it would be nice if all git commands that actually
>> manipulate objects (create/delete/modify) had a safe default, and
>> that experienced users such as yourself could endure the insufferable
>> agony of retraining your fingers to type five more chars so that
>> people won't have to get bitten by surprises.
> 
> Also for "git commit"?
> 

git commit has a very safe default; It runs "git status" and exits.

> In my opinion _basic_ usage of git-stash is simply using it with
> one stash only: "git stash" / "git unstash" (i.e. "git stash apply";
> by the way this is one (beside "git view") use case for builtin
> predefined aliases).  Using it with multiple stashes (only then
> "git stash list" is needed) is advanced usage; and for advanced
> usage longer form is preferred, I think.
> 

Perhaps. I'll stop quibbling about it. I don't care very deeply
about it anyway.

> "git branch", "git log" and "git remote" are horse of differenc color
> because the _cannot_ function without name of branch/tag/remote given,
> so hey provide "list" when no name was given.
> 

git stash takes a name too. It's optional though, and has caused any
number of source lines to be rewritten by grumbling authors who just
started to like git a little less because of it (yes, I know that has
been fixed, but it makes me look twice when discussing defaults for
git stash).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
