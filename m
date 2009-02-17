From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: disallowing push to currently checked-out branch
Date: Tue, 17 Feb 2009 01:07:42 +0100
Message-ID: <4999FFCE.3060605@gmail.com>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <20090215232013.GA11543@zakalwe.fi> <20090216000443.GB3503@coredump.intra.peff.net> <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm> <alpine.DEB.1.10.0902151738450.14911@asgard.lang.hm> <alpine.LNX.1.00.0902160322530.19665@iabervon.org> <7veixybw7u.fsf@gitster.siamese.dyndns.org> <loom.20090216T101457-231@post.gmane.org> <20090216135812.GA20377@coredump.intra.peff.net> <49999ED6.7010608@gmail.com> <alpine.DEB.1.00.0902161839120.6289@intel-tinevez-2-302> <4999BD54.8090805@gmail.com> <alpine.DEB.1.00.0902162103580.6289@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 17 01:09:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZDWV-0004tr-D8
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 01:09:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbZBQAHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 19:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbZBQAHq
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 19:07:46 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:20199 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbZBQAHp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 19:07:45 -0500
Received: by fg-out-1718.google.com with SMTP id 16so330075fgg.17
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 16:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=tY1vjBOussTz9ATRlnMk21iTvFG7GEtZFXofWdtZPYM=;
        b=ddb8ca+ZwUjT6d2N86jn9jkWctfAj6HmB1e1T0o6l0V/iBwEMHpLmgd8nzrxcCeF94
         4U0IaMEPMd8G7s99wXKLBCpeZVPVEmTXHGi+rCkXb0SvPly8c/mjssl2ENPGTiVWWRJK
         hwXuDg44OvPzERPlP7YQytIZD+QmUUZRmLWu8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=OYJZ2q+WhkWEUIneg3s6y+BAvn+MFy9EF8WVsGHZdSDC0mXaGfyEpQm9f9RD9KRIlX
         LZmh9u8Xb4RUUYMi46l87P6uy5ZKa+//oOZJdzSrY3C6IYpuQvf3AvKEfvjLKpKPemx/
         cZZd0bTTCcDYMKnMO7lI10T9vFhjLaebUfEg8=
Received: by 10.103.218.19 with SMTP id v19mr705223muq.46.1234829263862;
        Mon, 16 Feb 2009 16:07:43 -0800 (PST)
Received: from ?192.168.1.99? (host172-56-dynamic.10-87-r.retail.telecomitalia.it [87.10.56.172])
        by mx.google.com with ESMTPS id y37sm781627mug.53.2009.02.16.16.07.42
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Feb 2009 16:07:43 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <alpine.DEB.1.00.0902162103580.6289@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110265>

Johannes Schindelin wrote:
> What you are suggesting, though, is that the _pusher_ detaches the HEAD.  
> So the _local_ user will never know.
>
>   
I am not sure that I get what you mean.  But if I get it right, the only 
reason why the local
user cannot know is precisely because "git commit" does not complain if 
you call it from a detached head.
Otherwise the local user would find out that a push happened behind his 
shoulder right at the first "status" or "commit", as he was expecting to 
be on a branch and he finds himself off it.
>> Btw, I am ignorant on this: is there some case where one wants and has 
>> reasons to commit to a detached head before making a temporary branch on 
>> it?
>>     
>
> Yes.  When you try fixups on a commit you just jumped to, for example.  Or 
> when bisecting.
>
> I often use the detached HEAD as kind of a stash during a bisect.  I try 
> to fix it there, at the bad commit, and then cherry-pick HEAD@{1} into 
> the branch after resetting the bisect.
>
>   
Interesting.  But it is sort of abusing the detached head thing, isn't 
it? You use it as a temporary unnamed branch, and it becomes the tip of 
a short-lived development burst... It is not anymore just a way to peek 
at some status as I remember it was initially introduced, is it?
>>>> Furthermore, one could do just a bit more than detaching, namely 
>>>> store the fact that head got detached and the name of the branch 
>>>> where the head was. With this, when the unconscious user types git 
>>>> status or git commit the system could alert him that head got 
>>>> detached because someone updated the branch behind his shoulders 
>>>> from remote...
>>>>         
>>> And of course, you need a way to show the user all the updates the branch
>>> went through while the HEAD was detached, so that the user has a chance of
>>> understanding what happened in the meantime.
>>>
>>> So much additional work, just to fix up the shortcomings of the 
>>> 'detach' paradigm?  I take it as a clear mark of a not-so-elegant 
>>> design.
>>>       
>>   
>> Well not that much additional work...
>>
>> when you push to the checked out branch, head gets detached and branch name
>> (say /ref/heads/master) gets stored (say in .git/pre_push_branch).
>> when you run status or commit, you realize that there is a pre_push_branch and
>> you give the warning, saying what the pre_push_branch was.
>>     
>
> Of course, you assume there that it was only one push between detaching 
> the HEAD and inspecting the mess.
>   
After the first push, the head is already detached, so pre_push_branch 
does not get touched by the second, the third, the forth push, etc...
Which I guess is what the local user should want. He expected to be at 
some commit at the tip of some branch and he needs to find out what has 
happened between that commit and the new tip of that branch. Does he 
really need to know in how many and what precise push operations the 
branch tip moved?

>> Now, since before the push you were at the tip of that branch, to know 
>> what happened it should be enough to ask the log (or the diff) from 
>> pre_push_branch to HEAD. At the first user command that moves HEAD, 
>> pre_push_branch should get deleted.
>>     
>
> And you call that not much work?
>
>   
>> Btw, what does happen now if you delete the branch the remote worktree 
>> is on?
>>     
>
>   
I tried.  With current git 1.6.1.3,  head remains pointing at a non 
existent branch and git status thinks that you need to do your initial 
commit.
When you commit, the deleted branch is immediately recreated from 
scratch and you loose the history that got you at that status.

Which brings me back to my former consideration.

I initially thought of detaching head because it looks like a way to 
save a bit of info that I would like to see preserved.  When someone 
pushes in my repo, if my current branch tip moves, at the first action 
that I attempt on the repo I would like to see a big alert that it did 
and have an easy way to find out at what commit I was before the push 
happened.  Otherwise, I cannot really find out what the push precisely 
changed, I cannot easily revert it if it was wrong, etc.

Sergio
