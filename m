From: Ittay Dror <ittay.dror@gmail.com>
Subject: Re: switching upstream tips
Date: Wed, 13 May 2009 10:49:53 +0300
Message-ID: <4A0A7BA1.4030500@gmail.com>
References: <4A0A6BD1.7050907@gmail.com>	 <81b0412b0905130019x114d53d1v86833217bff613bc@mail.gmail.com>	 <4A0A777E.7080506@gmail.com> <81b0412b0905130041t327ef5f2m3b6d1dfac51fc1b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 09:50:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M49Ej-0000VG-TP
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 09:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbZEMHug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 03:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752128AbZEMHuf
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 03:50:35 -0400
Received: from mail-qy0-f133.google.com ([209.85.221.133]:57569 "EHLO
	mail-qy0-f133.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbZEMHue (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 03:50:34 -0400
Received: by qyk39 with SMTP id 39so932023qyk.33
        for <git@vger.kernel.org>; Wed, 13 May 2009 00:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=6txFBtJ76DeR1r7cqfPcRPb50CPun+Oy/i+dHkxvapk=;
        b=KeP+DiA5VDTjmDSuJLd13WTj4ewoIBPLH6LC4/4NqaPuhE9YP0P3HZqPb3wyXtQ8HG
         v1AlEBmlaNRo9boYhSCHoRBgurWHpg8MgfSXDpwmS3wAUzvPW0aBAvSR/AGM8ax/xSyp
         Ffbx6OSDIx50NVeoZwNioN75aIEOQiRcxFO1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=sq1mCjJxGHS93U+frvD7fqH0E3+gjkXjWvuD63xnxhEKROrnu5QFClkqWvnu5n53oA
         VvrKBUxNdOzmN+fHU/haSiOTVyk7iknM6fj+kAD84u06RNo4hGvhYCrKqVqirO7R9axa
         kgD6D7rTcUSal/zCH/T39R4zCB45Tkd4PcbLI=
Received: by 10.220.85.6 with SMTP id m6mr350423vcl.69.1242201035369;
        Wed, 13 May 2009 00:50:35 -0700 (PDT)
Received: from ?10.10.2.8? ([212.143.191.180])
        by mx.google.com with ESMTPS id 9sm2695876yxs.53.2009.05.13.00.50.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 May 2009 00:50:34 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
In-Reply-To: <81b0412b0905130041t327ef5f2m3b6d1dfac51fc1b1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118996>



Alex Riesen wrote:

> 2009/5/13 Ittay Dror <ittay.dror@gmail.com>:
>   
>>> Alex Riesen wrote:
>>>       
>>>> * Reorder my history so that my commits are on top of the tip of the old
>>>> upstream repository.
>>>>         
>>> Look at "git rebase -i" (interactive rebase)
>>>       
>> well, i was hoping for something more automatic. git rebase will list all
>> commits without author, so i'll have to manually figure which of them is
>> mine from the commend and reorder
>>     
>
> git rebase will list only commits not on upstream (simplified).
> Has nothing to do with author being absent.
>   
tried git rebase, this is what i get:
 > git rebase -i upstream master
fatal: Needed a single revision
Invalid base

>   
>>>> * Change the upstream repository reference so it points to the new
>>>> repository
>>>>         
>>> Just edit your .git/config and re-fetch.
>>>       
>> but then git suddenly sees a bunch of new objects (because of the svn
>> changes) and i get a lot of conflicts.
>>     
>
> "git fetch" and "git remote update" do not produce conflicts. You cannot
> get them unless you also do a merge (like when you do "git merge" or
> "git pull").
>
>   
>> note that it is not the directory structure that changed, just the svn
>> repository which is included in the commit comment (by git-svn) and
>> so changes the commit sha1.
>>     
>
> Ok, that simplifies everything. Just cherry-pick (see "git cherry-pick")
> your commits on new upstream. You might find it easiest if you cherry-pick
> them on commits in new upstream which correspond the old-upstream
> exactly.
>   
can you explain a bit more how to work with git cherry-pick? if i 
understand correctly, i need to write down my commits, switch to the new 
upstream tip ('git checkout upstream master'?) and then call git 
cherry-pick for each of my commits.


ittay
