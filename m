From: Matthew Lear <matt@bubblegen.co.uk>
Subject: Re: Unable to checkout a branch after cloning
Date: Tue, 11 Aug 2009 15:54:48 +0100
Message-ID: <4A818638.8060806@bubblegen.co.uk>
References: <4A814392.4080803@bubblegen.co.uk> <4A815E49.60406@drmicha.warpmail.net> <4A81613F.2080309@bubblegen.co.uk> <4A817840.9000405@drmicha.warpmail.net> <4A817F3B.7070308@bubblegen.co.uk> <4A818119.6000302@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Aug 11 16:56:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MasmA-0001IG-Ux
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 16:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755167AbZHKOyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 10:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755105AbZHKOyu
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 10:54:50 -0400
Received: from relay.pcl-ipout02.plus.net ([212.159.7.100]:58292 "EHLO
	relay.pcl-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755176AbZHKOyu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 10:54:50 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEACMjgUrUnw4T/2dsb2JhbADTBYQZBQ
Received: from pih-relay06.plus.net ([212.159.14.19])
  by relay.pcl-ipout02.plus.net with ESMTP; 11 Aug 2009 15:54:50 +0100
Received: from [80.229.236.194] (helo=[192.136.1.12])
	 by pih-relay06.plus.net with esmtp (Exim) id 1MaskT-0004Wi-Cj; Tue, 11 Aug 2009 15:54:49 +0100
User-Agent: Thunderbird 2.0.0.22 (X11/20090626)
In-Reply-To: <4A818119.6000302@drmicha.warpmail.net>
X-Plusnet-Relay: fa3e0f2bef0c9d06fe4f57b112dcacde
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125567>

Michael J Gruber wrote:
> Matthew Lear venit, vidit, dixit 11.08.2009 16:24:
>> Michael J Gruber wrote:
>>> Matthew Lear venit, vidit, dixit 11.08.2009 14:17:
>>>> Hi Michael - thanks for your reply.
>>>> Michael J Gruber wrote:
>>>>> Matthew Lear venit, vidit, dixit 11.08.2009 12:10:
>>>>>> Hi all,
>>>>>>
>>>>>> Apologies for perhaps a silly question, but I'd very much appreciate a
>>>>>> little bit of assistance.
>>>>>>
>>>>>> I've set up a git repository on a machine accessible from the internet
>>>>>> with the intention to share code with another developer. We clone the
>>>>>> repository, commit changes then push back as you'd expect. The server
>>>>>> runs gitweb for repository browsing. Clients are running git v1.6.0.6.
>>>>>>
>>>>>> When I created the initial repository I also created two additional
>>>>>> branches - 'upstream' and 'custom'. The former is to act as a 'vendor
>>>>>> branch' and the latter contains code specific to the custom platform
>>>>>> that we're working on. The master branch contains merges from the
>>>>>> upstream branch and also changes that we've made. The custom branch
>>>>>> contains merges from master with custom platform specific changes.
>>>>>>
>>>>>> I've committed changes and on both upstream and custom branches as work
>>>>>> progressed, merged them where appropriate, added tags etc and pushed
>>>>>> everything to the remote repository. No problem. I can view the
>>>>>> branches, tags etc in gitweb and everything looks fine.
>>>>>>
>>>>>> However, I can clone a new repository just fine but I'm unable to
>>>>>> checkout the upstream or custom branches. After cloning, only the master
>>>>>> branch is available, ie:
>>>>>>
>>>>>>> git checkout upstream
>>>>>> error: pathspec 'upstream' did not match any file(s) known to git.
>>>>>>
>>>>>>> git branch -a
>>>>>> * master
>>>>>>   origin/HEAD
>>>>>>   origin/master
>>>>>>
>>>>>> .git/config:
>>>>>>
>>>>>> [core]
>>>>>>         repositoryformatversion = 0
>>>>>>         filemode = true
>>>>>>         bare = false
>>>>>>         logallrefupdates = true
>>>>>> [remote "origin"]
>>>>>>         url = https://mysite/git/project.git
>>>>>>         fetch = +refs/heads/*:refs/remotes/origin/*
>>>>>> [branch "master"]
>>>>>>         remote = origin
>>>>>>         merge = refs/heads/master
>>>>>>
>>>>>> But the initial local repository where I work (ie created the branches,
>>>>>> committed changes, tag, push etc) seems to be fine, ie
>>>>>>
>>>>>>> git checkout upstream
>>>>>> Switched to branch "upstream"
>>>>>>
>>>>>>> git branch -a
>>>>>>   custom
>>>>>> * master
>>>>>>   upstream
>>>>>>
>>>>>> .git/config:
>>>>>>
>>>>>> [core]
>>>>>>         repositoryformatversion = 0
>>>>>>         filemode = true
>>>>>>         bare = false
>>>>>>         logallrefupdates = true
>>>>>> [remote "origin"]
>>>>>>         url = https://mysite/git/project.git
>>>>>>         fetch = +refs/heads/*:refs/remotes/origin/*
>>>>>>
>>>>>>
>>>>>> Developers need to be able to clone the repository and then switch to
>>>>>> the appropriate branch in order to work. However it seems that after a
>>>>>> clone, only the master branch is available.
>>>>>>
>>>>>> Why is this?
>>>>>>
>>>>>> Any help would be much appreciated indeed.
>>>>> If I understand you correctly you have 3 repos: the "initial" one on
>>>>> which everything is as expected, the "server" one and the "new clone"
>>>>> which is missing branches.
>>>> Yes, that's correct.
>>>>
>>>>> Now: How's the server one doing, i.e. what does "git ls-remote
>>>>> https://mysite/git/project.git" say? I suspect that one either does not
>>>>> have the branches (you haven't told us how you pushed) or in the wrong
>>>>> place (remotes/).
>>>>> git ls-remote https://mysite/git/project.git
>>>> 065f5f13d5f8e786729db1623cc53767c963e959        HEAD
>>>> 065f5f13d5f8e786729db1623cc53767c963e959        refs/heads/master
>>>>
>>>> Hmm. So it seems that the branches are not actually on the server
>>>> repository. So how come I can see them with gitweb..?
>>>>
>>>> I've been pushing from the 'initial' repository with git push --all and
>>>> git push --tags.
>>>>
>>>> However, when I try a git push from the initial repository I get the
>>>> following:
>>>>
>>>>> git push --all
>>>> Fetching remote heads...
>>>>   refs/
>>>>   refs/heads/
>>>>   refs/tags/
>>>> 'refs/heads/custom': up-to-date
>>>> 'refs/heads/master': up-to-date
>>>> 'refs/heads/upstream': up-to-date
>>>>
>>>> -- Matt
>>> Does the situation improve if, on the server, you run git
>>> update-server-info? Do you have a post-update hook there?
>>>
>>> Michael
>> I ran git update-server-info on the server machine. I read about this
>> and thought I had made the necessary change to add it as a post commit
>> hook. I guess not (so will double check). However, something is still
>> not quite right upon cloning:
>>
>>> git clone https://mysite/git/project.git
>> Initialized empty Git repository in /home/matt/git-repos/project/.git/
>> Checking out files: 100% (26747/26747), done.
>>
>>> git branch -a
>> * master
>>   origin/HEAD
>>   origin/custom
>>   origin/master
>>   origin/upstream
> 
> We're making progress, that's good ;)
> Re. the hook: Make sure it's executable and the extension .sample is
> removed.
> 
> (gitweb and http access are two different things, which is a common
> source of confusion)
> 
>>> git checkout upstream
>> error: pathspec 'upstream' did not match any file(s) known to git.
>>
>> So it seems that the cloned repository is now aware of the branches
>> (improvement) but I'm still unable to switch to a branch.
>>
>> This is probably now a case of me reading the manual but I'd appreciate
>> your thoughts nonetheless.
> 
> Well, there is no branch names upstream. There's only one named
> origin/upstream, and it's a remote branch. Meaning: checking it out will
> produce a detached head, which may or may not be what you want. If you
> want to create a branch to work on upstream, do something like
> 
> git checkout -b myupstream origin/upstream
> 
> (git does something like git checkout -b master origin/master
> automatically when cloning, which I think is a common source of confusion)

I've fixed the server hook scripts (embarrassingly, they were executable
but still had the .sample suffix - that's really not going to work!).

I've actually just read through the manual about detached heads. This is
not what I want but your solution to create a branch to track the remote
branch is exactly what I need.

Where ever you are in the world, many thanks for your continued help and
assistance. Very much appreciated indeed.

Cheers,
--  Matt
