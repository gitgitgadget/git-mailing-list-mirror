From: MALET Jean-Luc <jeanluc.malet@gmail.com>
Subject: Re: git svn : some feedback and wonder...
Date: Tue, 12 May 2009 00:11:32 +0200
Message-ID: <4A08A294.1060100@gmail.com>
References: <1de9d39c0905110852v65b07bebl47cc9a58046c5288@mail.gmail.com> <4A08560F.8030800@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 12 00:12:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3djy-0005uV-4q
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 00:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754910AbZEKWMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 18:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756398AbZEKWMd
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 18:12:33 -0400
Received: from mail-ew0-f224.google.com ([209.85.219.224]:47609 "EHLO
	mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755887AbZEKWMb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 18:12:31 -0400
Received: by mail-ew0-f224.google.com with SMTP id 24so3807542ewy.37
        for <git@vger.kernel.org>; Mon, 11 May 2009 15:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=5d18d8tBOWku+ahHPeHXPhiWAVSkQ3G3c7+y7pg4yUs=;
        b=qq31N7h9HjkTXyYVqVyVrAo4JO6ufV9tvpbYdXVsMRqX81Xgx5Grxy32ArEm8qAoWr
         jRwi5DUYym9rxaHEFaGl7xlg0oNVWUS8GP/tBwe3inYwlzh50UaivSlZdiJIv3eraS0k
         xyTJtnWOccoRMRdGi8R3ArY/lwSlS+k3ieckk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=HGIPgzKwXe66VYZ1XcOfLiC37i2d6j0kne9zQSb4HmC9J4eOi/DealTsQteEPkr6fV
         lv+clbJjZ2a3UmoJMBi/WQolCg68faBvnZwrXcl1YzZsV/oG4sROo6OKU6J68MZBIBps
         v7j/uSN8FmVWHqQ/pVnR1p/eTJjK/ERsJ4Jc8=
Received: by 10.210.59.14 with SMTP id h14mr5287106eba.53.1242079952714;
        Mon, 11 May 2009 15:12:32 -0700 (PDT)
Received: from jlmport.sorcerer (124.115.97-84.rev.gaoland.net [84.97.115.124])
        by mx.google.com with ESMTPS id 7sm406665eyb.45.2009.05.11.15.12.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 May 2009 15:12:31 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.18 (X11/20090308)
In-Reply-To: <4A08560F.8030800@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118856>

Michael J Gruber wrote:
> jean-luc malet venit, vidit, dixit 11.05.2009 17:52:
>   
>> hi
>> I'm just toying with git svn....
>> so I have an svn repository and I do a git svn clone -s
>> http://path.to/my/repository
>> here all is fine it checkout my trunk into master branch
>>
>> 1) when I do a git branch -a, it show 2 branches : master and trunk,
>> shouldn't it be master and svn/trunk?
>>     
>
> No. Not unless you said --prefix=svn during clone.
>
>   
>> 2) when I create a branch using git svn branch it create an empty
>> directory and not as expected a branch from the current revision of
>> trunk
>>     
>
> I get a branch as you expect. Can you repeat the commands which
> generated an unexpected result for you?
>
>   
>> 3) the branch appears in git branch -a without a remote
>> information.... not easy to track
>>     
>
> See 1)
>
>   
>> 4) you can't do git branch --track newbranch (where new branch is the
>> svn branch), since the branch name isn't prefixed by svn/ you can't
>> reuse the same name
>>     
>
> You certainly can create a local branch with the same name. I just did.
> I always do. If b is that name, say
>
> git branch --track b remotes/b
>
> unless you have used --prefix, of course.
>
>   
>> 5) why having called dcommit instead of push? it would have been more
>> understable (more coherent) git svn push would have pushed current
>> branch on corresponding svn branch and git svn push somebranch would
>> have do a git svn branch followed by the commits...
>>     
>
> The latter would be inconsistent with git push as well.
>
> Dcommit may be for historical reasons, but keep in mind that dcommit is
> not simply pushing. It involves rebasing and a whole git-svn-git
> roundtrip. It really is "do the commits" on the svn side.
>
>   
>> 6) why having called rebase instead of pull? git svn pull would have
>> fetched svn/trackedbranch and merged into current branch, git svn pull
>> somebranch would have merged into current branch the svn/somebranch
>> (without traking info)
>>     
>
> Because pull does not rebase by default, it uses merge!
>
> Let me just add that with some more git experience, which includes
> reading man pages and trying things out, there certainly will be more
> insight into the why's and why not's of git-svn ;)
>
> Cheers,
> Michael
>   
hi,
can't do it from here, will retry tomorrow
I'll try 1)  2) and 3) again tomorrow, however why --prefix=svn isn't 
the default? that's odd behaviour and not really consitent with other 
remote operation I find
for 4) I think that push works more like dcommit, the underlying process 
isn't the same because svn and git don't share the same tree, but if we 
look at the result we have the same : all commit made on host are 
visible on repository, git do it by transfering the content because all 
blob/tree are sha1 name and then can't conflict, on svn we can't because 
there are no uniqueness so you have to replay the commits one by ones... 
git just optimize the process because of the nature of the filetree...
for rebase.... well I know that some people prefer it to merge, as well 
as some people prefer that a merge to be fast forward... I prefer to 
keep the branch information... it's hard to restart a dev from a branch 
that isn't visible anymore... fast forward merge and rebase sadely do 
lose those branch information... however I agree that in case of svn a 
rebase looks more like an svn update...
and yes, sorry I forgot that the opposite of push is... fetch ;) so yes 
it's more clear now in my mind....
thanks
JLM
