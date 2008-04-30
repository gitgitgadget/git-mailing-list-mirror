From: Tim Harper <timcharper@gmail.com>
Subject: Re: Making submodules easier to work with (auto-update on checkout or merge, stash & restore submodules)
Date: Wed, 30 Apr 2008 14:19:38 -0600
Message-ID: <BC221793-3FB5-4249-8E8D-819C1B413592@gmail.com>
References: <8B885217-8C18-417E-8F11-BB6661792CD3@gmail.com> <alpine.DEB.1.00.0804301121240.17469@eeepc-johanness>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 22:20:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrIn6-0005Rj-2d
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 22:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755767AbYD3UTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 16:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756132AbYD3UTr
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 16:19:47 -0400
Received: from rn-out-0910.google.com ([64.233.170.187]:8787 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755004AbYD3UTq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 16:19:46 -0400
Received: by rn-out-0910.google.com with SMTP id e11so409930rng.17
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 13:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=SJYXIfP6BTtt4p1CXn9fefXOPIU88I3ygmVcRjU+LKU=;
        b=kihq1PBcGMKHe2eb+RK325a8bcIG2uY2vOiPRmAElVvGqb7ggai+uyXnxo9ZSau3dLcVk4hC8KqosFYqI+pL50aYIX5xRFYzd/RG7xbu1Mv/Vv6iWtGaOpoB/ulcbvppStQ6hv77j0844fBku5U5SX5Jma6U3zjJyZXZhQN2nF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=SBA82YjfeB5evO5FUTbCTRS4x5u+SjSR1pfULT7PriyaNPNWGX2CkEPyAluAhW9SxWnP4qsdG5BdwxhW35o7rxj4e83IiME5c8CGF/oGp5XjCHrllJqD8cH9YUpjUv3/h8ocqZMZFyI4Rx5w0je4IjLDw8ia2vtU9EihWwmQm1Q=
Received: by 10.142.230.11 with SMTP id c11mr458781wfh.334.1209586782436;
        Wed, 30 Apr 2008 13:19:42 -0700 (PDT)
Received: from ?10.0.1.193? ( [66.182.89.5])
        by mx.google.com with ESMTPS id 30sm3469236wff.8.2008.04.30.13.19.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Apr 2008 13:19:41 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0804301121240.17469@eeepc-johanness>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80868>

I had a feeling my proposal would be met with a mix of opposition and  
acceptance, depending on which "git camp" you are currently in.

On Apr 30, 2008, at 4:31 AM, Johannes Schindelin wrote:
> Hi,
>
> On Tue, 29 Apr 2008, Tim Harper wrote:
>
>> 1) The submodule stays in the working copy when changing to a branch
>>   that does not have a submodule.  This can break a build and cause
>>   problems.  To work around, I have to delete the folder completely
>>   (git-clean).  Then, when I switch back to the branch again, I  
>> have to
>>   re-download the submodule.
>
> The problem, of course, is that you can easily have valuable, but
> not-tracked, files in there.  Deleting the submodule is therefore no
> option.
>

Submodules are not deleted.  They are moved out of the working copy  
into a folder in .git.  Therefore, upon changing back to the branch  
with the submodule, they are restored, without nay a hair on their  
head lost.

>> 2) I have to type "git checkout branch && git submodule init && git
>>   submodule update" to be sure that I really have the whole  
>> contents of
>>   the branch.  That's 3 commands, and a lot of typing.
>
> There is no way around "checkout branch", and I think that is a good
> thing.
>

Naturally


> But once you did "submodule init", you will never need to run it  
> again,
> since it edits your .git/config, which does not change when switching
> branches.
>

If working in a collaborative environment, when someone adds a new  
submodule, it's extra burden to have to know "oh, there's a new  
submodule now, so I have to run "git submodule init".  I find it's  
more than sufficient just to run it everytime, and costs me nothing.   
Why aren't "gut submodule update" and "git submodule init" the same  
command?  Perhaps a compromise could be met with "git submodule update  
-i".


> And as for "submodule update", I like the fact that the submodule is  
> not
> updated automatically.  For example, when I actively develop a  
> submodule,
> but have to rebase the superproject, I would _hate_ it if the  
> submodule
> wass updated.
>

Then we could make my proposed idea a configuration variable :)  For  
my use case, I passionately dislike the fact that a submodule is not  
updated automatically.  There's never a time when I don't want to  
update the submodule.  The submodule is a very important piece of our  
project and the super-project depends on it being at the right version.

I suspect a large majority of git users who would use submodules, and  
a handful of those already using it, have a similar use case.  Though,  
I have no evidence to support this, other than my own observations.

> The whole idea about submodules is that they are repositories of  
> their own
> right, and therefore the superproject should not mess with them,  
> _unless_
> explicitely asked to, with "submodule update".
>
>> 3) If I don't run "git submodule update", and carelessly run "git  
>> commit
>>   -a"  or "git add .", I risk propagating a submodule version from
>>   another branch or undoing an important change.
>
> git commit -a is something that might make sense for newbies, but you
> really should learn to use git add -p and commit without -a.
>

Or... use my textmate bundle for git, which makes committing very  
easy. :)  The newbies are pointed to use "git add ." - just try typing  
"git add"

>> SUGGESTED ALGORITHM (AS HAS BEEN IMPLEMENTED IN THE GIT TEXTMATE  
>> BUNDLE)
>> When pulling / merging / changing branches:
>> 1) cache all submodules to ~/.git/submodules_cache
>> a) move from the working directory to a folder that is a MD5 hex- 
>> hash of
>> both the submodule path and the submodule url
>> 2) execute the pull / merge / branch change
>> 3) restore all defined submodules to ~/.git/submodules_cache (only  
>> the
>> submodules that are still defined after the merge / change / pull)
>> 4) execute git submodule init && git submodule update
>>
>>
>> PITFALLS:
>> pitfall)
>> If you commit a change on a submodule that's not on a branch, auto- 
>> updating
>> submodules will make it difficult to revive that change.
>>
>> workaround)
>> Don't allow the user to commit unless they are on a branch.
>>
>> ... couldn't think of anymore.  Anyone?
>
> I do not like that.  I think that the user should be responsible to  
> take
> care of the up-to-dateness of the submodule.  As far as the  
> superproject
> is concerned, it just keeps track of the committed submodule state,  
> but
> does not enforce it.
>

Does git serve me or do I serve git?  The whole point of software is  
to make our lives easier and more productive.  If submodules are apart  
of our project, why would not want git to handle making sure your  
submodules are at the right version?

I could see an issue if you changed the submodule version, and forgot  
to commit the version change in your super project, and then switched  
branches, and lost your version change.  Perhaps the correct behavior  
in this case would be to only automatically update the submodule  
version if it didn't differ from the superproject version in the  
"from" branch.

> FWIW I restarted on my --ignore-submodules patch, which can be seen  
> here:
>
> http://repo.or.cz/w/git/dscho.git?a=shortlog;h=refs/heads/my-next
>
> It lacks tests, therefore it has not been submitted for review yet.
>
> The basic idea is that not only "checkout" ignores the _contents_ of  
> the
> submodules, but optionally "diff", and using that option "stash" and
> "rebase".
>
> IOW you can "stash a

Leaving me hanging?  lol.

Thanks,
Tim
