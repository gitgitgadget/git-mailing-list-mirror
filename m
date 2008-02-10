From: Steven Grimm <koreth@midwinter.com>
Subject: git/hg discussion from the memcached mailing list
Date: Sat, 9 Feb 2008 17:43:15 -0800
Message-ID: <196C7ED3-67BC-4BF9-8E5B-4E2187D8A93B@midwinter.com>
References: <D6147D3B-2E67-4D33-8EEC-BFCD641A6D52@spy.net>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Users List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 02:51:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO1LN-0004gB-UT
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 02:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbYBJBt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 20:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbYBJBt6
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 20:49:58 -0500
Received: from tater.midwinter.com ([216.32.86.90]:34060 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750982AbYBJBt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 20:49:57 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Feb 2008 20:49:56 EST
Received: (qmail 10957 invoked from network); 10 Feb 2008 01:43:15 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=jSWeHUS40MJOWZJKcYjiIyOU4ltiWi1yphuxVbOkYEkqkhibKVS9Mgg99a4Kan00  ;
Received: from localhost (127.0.0.1)
  by localhost with SMTP; 10 Feb 2008 01:43:15 -0000
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73288>

The folks managing the memcached project are looking at switching from  
svn, and there's a discussion going on about whether to switch to git  
or hg. One of the prominent list members is an hg fan, but he's open  
to giving git a try. Here's his latest message from that thread; the  
start of the thread is at

http://lists.danga.com/pipermail/memcached/2008-February/006335.html

I'd say hg is winning the ease-of-use side of things at the moment, by  
virtue of its commands doing what people want by default rather than  
requiring additional arguments. Examples of that in the quoted message.

Unfortunately I'm in semi-crunch mode at work right now and don't have  
time to really dive into this discussion, but maybe someone else would  
be interested in doing so. If nothing else the thread points out some  
things that could be discussed the next time there's talk about git's  
user interface.

-Steve


Begin forwarded message:

> From: Dustin Sallings <dustin@spy.net>
> Date: February 9, 2008 5:30:48 PM PST
> To: dormando <dormando@rydia.net>
> Cc: memcached list <memcached@lists.danga.com>
> Subject: Re: Upcoming memcached releases + rambling.
>
>
> On Feb 9, 2008, at 0:28, dormando wrote:
>
>> incoming/outgoing:
>>
>> If I _think_ I understand these right, you can actually sometimes git
>> diff with the second repo as an argument. That'll show the  
>> differences
>> since the target repo/branch (git diff . /path/to/other/repo#branch),
>> which will be incoming or outgoing.
>
> 	Hmm...  Trying that, but it doesn't take ``origin'' nor the URL of  
> origin as an argument.  Not quite what I'm looking for anyway...
>
>> That'll show the raw changes... for showing the difference in  
>> changeset,
>> you can do a: git log --since HEAD origin
>> ... if origin were the remote repo. If you don't have the latest
>> changes, fetch more, rebase your repo on top of that, then git log
>> --since will show you what you have to upload.
>
> 	My log (1.5.3.7) doesn't have --since (fatal: unrecognized  
> argument:  --since)
>
>> Otherwise you can use git fetch to "pull" the remote changes into a
>> branch but not apply anywhere, then use git log with relative  
>> commit ids
>> to show the changesets (with -p to show the full changes!)
>
> 	Is that the old..new stuff it printed when I fetched?  I guess  
> that's close enough to what I want to accomplish, but it only seems  
> to work once I've got the changes.
>
>> Unless I'm getting my wires crossed and this is a patch management
>> thinger, in that case it's 'git format-patch' and 'git am' (although
>> there's an alternative to am).
>
> 	OK, I don't think this is doing what what I want.  I did a ``git  
> format-patch origin..'' and it didn't do anything.  I rebased my  
> changes and did it and it included a bunch of changes I didn't  
> make.  I did a ``git checkout HEAD'' to try to go back to sanity and  
> format-patch now includes just the things I changed.
>
> 	I think ``git log origin..'' does what I want here (except in the  
> case of git svn in which case origin is called something else and  
> doesn't show up under git remote).
>
>> export:
>>
>> Appears to be git log --pretty=[format] [-p] ?
>
> 	I think it's probably ``git log --pretty=raw -n 1 -p [id]''
>
> 	I haven't tried git-am to see if it would apply this properly.  git- 
> apply does not (it modifies the tree, I want the change committed by  
> the original author with the original date, etc...).
>
>> bundle:
>>
>> git bundle, same feature. push/pull accept bundles too, it seems.
>
> 	Right.  The equiv seems to be:
>
> 	git bundle create /some/file origin..
>
>> serve:
>>
>> You got me here. I've been doing the "scp a bare repo up to my  
>> webhost,
>> run a script to prep it for http pull's" thing. Usually takes a few
>> minutes if I don't forget what to do, and the basic tutorials show  
>> how
>> to do this.
>
> 	You can do the above with mercurial, but they don't advertise it  
> much because it's slow on the consumer side.  You don't need a  
> script or anything to prep it, though.  Just dump your working tree  
> on a web server.
>
>> No built in webbrick a-like though. I guess that's twistd?
>> Or something? Dunno, that's pretty swanky, but my laptop doesn't  
>> usually
>> have direct internet access so I upload it to my webhost anyway.
>
> 	No, python has a built-in web server.  It's just using that.
>
>> Mercurial does appear to work better with pushing things around,  
>> while
>> git is primarily pull oriented. I don't mind the loss there, pushing
>> between distributed repos is kinda crazy. Or maybe I just haven't  
>> used
>> hg enough.
>
> 	pull is definitely better than push in general.  Except in the case  
> I ran into yesterday where the only option I had other than pushing  
> was emailing a bundle.  :)
>
>> I've spread git within a company of 15+ developers (now way more? I
>> hope) to replace SVN. Slow adoption at first but they love it, and  
>> were
>> having very severe performance problems.
>
> 	That's good.  I'm sure I just haven't learned it enough yet.  You  
> may provide me with an opportunity to do so.  :)
>
>> I think a bunch of the ruby folk use git? We should have someone  
>> who can
>> say a word or two about it?
>
> 	All the ruby stuff I can find uses svn, it's like...built into the  
> tools.  They may be using git-svn, but that's really a different  
> tool from what I can tell.  For example, cloning a git-svn clone  
> doesn't give you a git-svn clone.
>
>>>   Should memcached choose git, it may be as simple as putting up a
>>> page that says, ``this is how you clone, this is how you work,  
>>> this is
>>> how you submit your changes back.''
>>>
>>
>> I've been stuck in the stone-age with git apparently! Every time I go
>> read the tutorials I find four other commands I don't need to run
>> anymore. It looks like with 1.4 or 1.5+ all you need to do is  
>> clone, do
>> some git remote's, and 'git pull' until you're bored. Then rebase  
>> your
>> branch on top of origin, and git-format-patch a patch series. Or  
>> shove
>> your repo up with http accessability and tell someone to pull.
>>
>> In which case I'd add a remote for their repo and pull into a branch.
>>
>> Anyway, I'm totally glad you asked because it finally gave me  
>> something
>> to look up. Brian once asked about bundle, but I had yet to find a
>> difference :)
>
>
> 	Well here's a summary of the differences in commands so far.  Let's  
> assume I've done a clone of the hypothetical git repo and hg repo.   
> The following commands would be equivalent based on what I found up  
> here:
>
> Look for incoming changes:
>
> 	hg in
> 	git fetch && git log [copy and paste in the stuff from the old..new  
> line]
>
> Look for outgoing changes:
>
> 	hg out
> 	git fetch && git log origin..
>
> Export a single changeset to be moved elsewhere:
>
> 	hg export [change]
> 	git log --pretty=raw -n 1 -p [change]
>
> Import an exported changeset:
>
> 	hg import /some/file
> 	git ??? /some/file
>
> Send changes as individual email patches:
>
> 	# note: hg requires patchbomb to be enabled in your .hgrc for this
>
> 	hg email -o
> 	git format-patch origin.. && ??email script?? [0-9]*.patch
>
> Send changes as a single portable patch series:
>
> 	hg out -p
> 	git fetch origin && git log -p origin..
>
> Send changes as a single bundle:
>
> 	hg bundle /some/file
> 	git bundle create /some/file origin..
>
> 	[then send /some/file as an attachment]
>
> Share changes via plain http:
>
> 	[hg]#  rsync -va tree/ server:public_html/tree/
> 	[git]# rsync -va tree/ server:public_html/tree/ && ssh server "?? 
> setup-tree??"
>
> Share changes on a LAN party:
>
> 	hg serve
> 	git daemon --base-path=$PWD --export-all
>
>
> 	This is actually good progress (although perhaps a bad forum).   
> I've been wanting a git cheat sheet, and this is helping me get it  
> together.
>
> 	Of course, when it comes to contributing, I think there will have  
> to some published recommendations on how to contribute changes.
>
> -- 
> Dustin Sallings
>
>
>
