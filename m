From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished summary continued
Date: Thu, 25 Oct 2007 14:04:40 +0200
Message-ID: <8C2ADF84-2E35-46D3-B894-68341CF26A81@zib.de>
References: <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com> <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de> <Pine.LNX.4.64.0710231155321.25221@racer.site> <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de> <20071024192058.GF29830@fieldses.org> <471F9FD1.6080002@op5.se> <20071024194849.GH29830@fieldses.org> <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de> <20071024203335.GJ29830@fieldses.org> <471FB3D0.4040800@op5.se> <20071024212854.GB6069@xp.machine.xx> <05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de> <Pine.LNX.4.64.0710242258201.25221@racer.site> <008A7EF9-6F58-47AE-9AA0-B466797F6B1D@zib.de> <Pine.LNX.4.64.0710250021430.25221@racer.site> <79366145-3C91-4417-B62C-FFF9EC452076@zib.de> <Pine.LNX.4.64.0710251117310.25221@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Peter Baumann <waste.manager@gmx.de>, Andreas Ericsson <ae@op5.se>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 25 14:06:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il1SW-0000HA-8D
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 14:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757196AbXJYMEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 08:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757124AbXJYMEy
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 08:04:54 -0400
Received: from mailer.zib.de ([130.73.108.11]:38250 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756899AbXJYMEx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 08:04:53 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9PC3CTY011535;
	Thu, 25 Oct 2007 14:04:45 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9PC3BxR029848
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 25 Oct 2007 14:03:11 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0710251117310.25221@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62311>


On Oct 25, 2007, at 12:27 PM, Johannes Schindelin wrote:

> Hi,
>
> On Thu, 25 Oct 2007, Steffen Prohaska wrote:
>
>> On Oct 25, 2007, at 1:28 AM, Johannes Schindelin wrote:
>>
>>> On Thu, 25 Oct 2007, Steffen Prohaska wrote:
>>>
>>>> On Oct 25, 2007, at 12:14 AM, Johannes Schindelin wrote:

[...]

>>>>> But here is a proposal which should make you and your developers
>>>>> happy, _and_ should be even easier to explain:
>>>>>
>>>>> Work with topic branches.  And when you're done, delete them.
>>>>
>>>> Again, if you want to share the topic branch the situation gets  
>>>> more
>>>> complex.
>>>
>>> Hardly so.  In my proposed solution to your problem, there is  
>>> nothing
>>> which prevents you from working off of another branch than "master".
>>
>> Well if you have several local branches checked out that are
>> shared with others you run into the "git push" problem again ...
>> (see below at git push origin master).
>
> Do the same as I, always say "git push origin master" (of course, you
> should exchange "master" with whatever branch you want to push).  Be
> precise.

Well, I'm lazy. git already knows everything. It knows that
the current branch is associated with a specific remote and it
pushes matching branches by default. And I took care to not
pollute the namespace. All my branches are named identical
in all repositories I'm dealing with. It's reasonable to want
"git push" to do the right thing.



>>>>> So the beginning of the day could look like this:
>>>>>
>>>>> 	git fetch
>>>>> 	git checkout -b todays-topic origin/master
>>>>>
>>>>> 	[hack hack hack]
>>>>> 	[test test test]
>>>>> 	[debug debug debug]
>>>>> 	[occasionally commit]
>>>>> 	[occasionally git rebase -i origin/master]
>>>>>
>>>>> and the end of the topic
>>>>>
>>>>> 	git branch -M master
>>
>> Isn't this a bit dangerous? It forces to overwrite master no matter
>> what's on it. You don't see diffstats nor a fast forward message that
>> confirms what you're doing.
>
> Yeah, I should have said something like "git branch -m master"
> (implicitely assuming that you have no current "master" branch).
>
>>>>> 	git push origin master
>>
>> I'd like to see "git push" here.
>
> I think it is not asking too much for the user to be a bit more  
> precise.
> If you really do not trust your developers to be capable of that,  
> point
> them to git gui.

Well I was more precise and got lazy over time. Now the most I do
is "git push --dry-run" and if it looks good I do "git push".
Most of the time I just say "git push".

As I pointed out earlier, "git push origin <some-branch>" can create
a new branch on the remote. "git push" never creates a new branch.
I believe "git push" is safer.


>>    git branch -m <shared_branch>
>>    git push origin <shared_branch>
>>    git checkout do-not-work-here
>>    git branch -D <shared_branch>
>
> Actually, the last two commands would better be
>
> 	git checkout HEAD^{commit}
> 	git branch -d <shared_branch>

Wow, looks weird (not too me but to someone who doesn't know git).


>>> The problem I see here: you know git quite well.  Others don't, and
>>> will be mightily confused why pull updates local branches sometimes,
>>> and sometimes not.
>>
>> But it already happens now. "git pull" sometimes merges a remote  
>> branch
>> (--track) and sometimes it reports an error that is fails to do so
>> (--no-track).
>
> If there really is an inconsistent behaviour, then we'll have to  
> fix that.
> We should not introduce inconsistent behaviour on top of that.

It's not inconsistent. It's an option of a branch. Git supports two
flavours of local branches. Some branches automatically merge and other
don't.

	Steffen
