From: Marius Seritan <mseritan@decodeideas.com>
Subject: Re: hot to fix git svn import or just discard 'branches' folder
Date: Wed, 4 Feb 2009 12:21:03 -0800
Message-ID: <217FD3AA-39FA-4F81-A4A6-DC7F6F6905B5@decodeideas.com>
References: <7E976223-6794-4E87-94A5-DEA224759700@decodeideas.com> <D92EB2AE-392D-4F05-8DF3-999BE78C80FF@silverinsanity.com> <5713EFD1-E6E7-4FD5-BF17-FDA5FF6F7C6B@decodeideas.com> <06C1D783-D51B-49E9-92A2-C1EA035BE3D6@decodeideas.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 21:22:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUoGm-00044I-RR
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 21:22:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756318AbZBDUVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 15:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755942AbZBDUVL
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 15:21:11 -0500
Received: from mail-gx0-f21.google.com ([209.85.217.21]:55274 "EHLO
	mail-gx0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756151AbZBDUVK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 15:21:10 -0500
Received: by gxk14 with SMTP id 14so2318704gxk.13
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 12:21:09 -0800 (PST)
Received: by 10.65.156.17 with SMTP id i17mr3738089qbo.98.1233778867882;
        Wed, 04 Feb 2009 12:21:07 -0800 (PST)
Received: from ?192.168.2.201? ([72.14.241.158])
        by mx.google.com with ESMTPS id s35sm2461175qbs.26.2009.02.04.12.21.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 12:21:06 -0800 (PST)
In-Reply-To: <06C1D783-D51B-49E9-92A2-C1EA035BE3D6@decodeideas.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108423>


On Feb 4, 2009, at 11:24 AM, Marius Seritan wrote:

>
> On Feb 4, 2009, at 11:05 AM, Marius Seritan wrote:
>>>
>>> I believe fixing this without reimporting requires using "git  
>>> filter-branch".  I'm unfamiliar with it, so I can't help you with  
>>> that part.
>>
>> Thanks, I will look into it. From the first read this seems to be  
>> pretty advanced.
>
> Ok, I think I killed it :-/
>
> I did
> git filter-branch --subdirectory-filter trunk -- --all
>
> This cleaned up git and I have just the trunk for 218MB, that's much  
> more acceptable. Unfortunately 'git svn rebase' now returns:
>
> Unable to determine upstream SVN information from working tree history
>
> I went into the .git/config and added a trunk but no luck. I also  
> edited .git/svn/.metadata in the same way.
>
> As another data point git svn log is still working.
>
>
> Marius
>
>


Last follow-up on svn git. I ended up re-reading the docs (duh) and  
doing the following:

git svn init -s --prefix=svn/   http://svn.name.com/svn/project
git svn fetch -r 800:HEAD

This brought down the last 2 branches and the trunk. It took a couple  
of minutes and uses 120MB of disk space. Much better than hours and  
3GB of disk.

Love it,

Marius
