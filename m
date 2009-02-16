From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: disallowing push to currently checked-out branch
Date: Mon, 16 Feb 2009 20:24:04 +0100
Message-ID: <4999BD54.8090805@gmail.com>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <20090215232013.GA11543@zakalwe.fi> <20090216000443.GB3503@coredump.intra.peff.net> <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm> <alpine.DEB.1.10.0902151738450.14911@asgard.lang.hm> <alpine.LNX.1.00.0902160322530.19665@iabervon.org> <7veixybw7u.fsf@gitster.siamese.dyndns.org> <loom.20090216T101457-231@post.gmane.org> <20090216135812.GA20377@coredump.intra.peff.net> <49999ED6.7010608@gmail.com> <alpine.DEB.1.00.0902161839120.6289@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 16 20:25:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ964-0007iw-Re
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 20:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbZBPTYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 14:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbZBPTYK
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 14:24:10 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:34211 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbZBPTYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 14:24:09 -0500
Received: by bwz5 with SMTP id 5so3337200bwz.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 11:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=lp3NrMtP1tWnZ38eSMYmp8oGeq2pLJldlCynhAcihxE=;
        b=v+qWKVj/dOUDR3u5mIktzBXRb67rNVcochS4oE5CjDdINLnxRlY2P2ce9DEX2JVzcv
         pW+X58TFyglUaYm94EQyO+Tu6OCC72JdbLjg+NLYQujifmOG6mY+l1L+sI7K7xixsqb5
         HKwyyGtAkpcOrGyZQaVEMCNfurpSdrVU1by2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=ULHXaE702gA6FyeHOJ8XjwspYvjKbJ39wi8TvFxvNWn9I4Sp+1aU5Prj+t8f6arzvq
         GFFYZAj6gqSnor91yyXZPZOC9R21ojIbyt0j/JgqsAgW10Xxm9tkpTsO2lFM/P87GgRy
         mDUnjcgsLZqEeR5a4EcdoNoYDuKmG2ou5/PnM=
Received: by 10.103.49.12 with SMTP id b12mr3134816muk.81.1234812246550;
        Mon, 16 Feb 2009 11:24:06 -0800 (PST)
Received: from ?192.168.1.99? (host172-56-dynamic.10-87-r.retail.telecomitalia.it [87.10.56.172])
        by mx.google.com with ESMTPS id n10sm514973mue.9.2009.02.16.11.24.04
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Feb 2009 11:24:05 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <alpine.DEB.1.00.0902161839120.6289@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110230>

Johannes Schindelin wrote:
> Wrong.  It cries out loud when you detach, not when you commit to a 
> detached HEAD.  For good reason: Already at the second commit it would 
> stop being funny.
>   
Right, I was wrong in expecting complaints. But... if it cried out at 
the first commit, for many people there would probably not be a second. 
Btw, I am ignorant on this: is there some case where one wants and has 
reasons to commit to a detached head before making a temporary branch on it?
>   
>> Furthermore, one could do just a bit more than detaching, namely store 
>> the fact that head got detached and the name of the branch where the 
>> head was. With this, when the unconscious user types git status or git 
>> commit the system could alert him that head got detached because someone 
>> updated the branch behind his shoulders from remote...
>>     
>
> And of course, you need a way to show the user all the updates the branch 
> went through while the HEAD was detached, so that the user has a chance of 
> understanding what happened in the meantime.
>   
> So much additional work, just to fix up the shortcomings of the 'detach' 
> paradigm?  I take it as a clear mark of a not-so-elegant design.
>   
Well not that much additional work...

when you push to the checked out branch, head gets detached and branch 
name (say /ref/heads/master) gets stored (say in .git/pre_push_branch).
when you run status or commit, you realize that there is a 
pre_push_branch and you give the warning, saying what the 
pre_push_branch was.
Now, since before the push you were at the tip of that branch, to know 
what happened it should be enough to ask the log (or the diff) from 
pre_push_branch to HEAD.
At the first user command that moves HEAD, pre_push_branch should get 
deleted.
Btw, what does happen now if you delete the branch the remote worktree 
is on? Don't you get a "dangling" head pointing to a non-existing branch 
and the system claiming that it is at the initial commit? Maybe, this 
too is a bit inelegant. In the other scenario, you would get a detached 
head and in pre_push_branch the info the name of a no more existing 
branch (mainig clear that you were on a branch that got deleted) and 
this info could be returned to the user.

Of course, I am not claiming that forbidding pushes to branches with 
checked out tree is bad. It is a good idea in my opinion.
I am just suggesting that one still wanting to allow that push in spite 
of all the potential consequences (namely wanting to mess with the 
relevant config variable), might prefer detaching head, storing the 
pre_push_branch and getting some info on status and commit rather than 
merely allowing the push.

In fact, I believe that the point is that with the current push-allowing 
behavior, when the push happens you loose the information about the 
precise commit against which the changes in the worktree were made. 
Which might be a useful piece of info.

Ciao,

Sergio
