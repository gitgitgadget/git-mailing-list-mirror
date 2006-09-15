From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Tracking a branch using StGIT
Date: Fri, 15 Sep 2006 13:42:25 +0200
Organization: At home
Message-ID: <eee3i5$ib6$1@sea.gmane.org>
References: <64de5c8b0609150120h3aeee6dcv976da13134396654@mail.gmail.com> <b0943d9e0609150342y6105d8d1o61abb1934da9f51b@mail.gmail.com> <64de5c8b0609150432o5d6835a8pb578082746576864@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Sep 15 13:42:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOC5W-00054y-Bs
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 13:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWIOLmU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 07:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWIOLmU
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 07:42:20 -0400
Received: from main.gmane.org ([80.91.229.2]:61340 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750982AbWIOLmU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Sep 2006 07:42:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GOC5G-00051J-Va
	for git@vger.kernel.org; Fri, 15 Sep 2006 13:42:15 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Sep 2006 13:42:14 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Sep 2006 13:42:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27080>

Rajkumar S wrote:

> On 9/15/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> 
>> After StGIT pops all the patches, it just calls "git pull origin". My
>> understanding of GIT is that this should update local RELENG_1 with
>> the remote RELENG_1 from the "origin" repository. Anything wrong with
>> my assumptions?
> 
> I checked this again, this time with out using stgit, and the results
> are the same. So this is not a StGIT problem but a user error :(
> 
> My sequence of test is as follows:
> 
> # root@beastie:# git clone /usr/local/pfSense/upstream/pfSense/ releng_1
> <snip>
>  100% (1220/1220) done
> # cd releng_1/
> 
> # cat .git/remotes/origin
> URL: /usr/local/pfSense/upstream/pfSense/.git
> Pull: refs/heads/master:refs/heads/origin
> Pull: refs/heads/avendor:refs/heads/avendor
> Pull: refs/heads/Package-Reorg-2005:refs/heads/Package-Reorg-2005
> Pull: refs/heads/RELENG_1:refs/heads/RELENG_1
> 
> # git branch
>   Package-Reorg-2005
>   RELENG_1
>   avendor
> * master
>   origin
> 
> # git pull
> Already up-to-date.
> 
> # git checkout RELENG_1
> 
> # git pull
[...]
> 
> As you can see, when I switched to RELENG_1 branch and did a git pull,
> I am getting errors. I am wondering where I am wrong.

git pull is git fetch + merge of first head in remotes file with _current_
branch.

You'd better git fetch if you are on RELENG_1 branch (if you are not on
master), then git checkout master && git pull . origin
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
