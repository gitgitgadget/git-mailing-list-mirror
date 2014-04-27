From: Jeremy Morton <admin@game-point.net>
Subject: Re: Recording the current branch on each commit?
Date: Sun, 27 Apr 2014 21:55:13 +0100
Message-ID: <535D6EB1.9080208@game-point.net>
References: <535C47BF.2070805@game-point.net>	<CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>	<535D4085.4040707@game-point.net> <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Apr 27 22:55:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeW6Z-0004la-Va
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 22:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbaD0UzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 16:55:11 -0400
Received: from mail.gooeysoftware.com ([208.100.15.213]:35151 "EHLO
	mail.gooeysoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbaD0UzK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2014 16:55:10 -0400
Received: from [192.168.0.2] (82-69-83-224.dsl.in-addr.zen.co.uk [82.69.83.224])
	by mail.gooeysoftware.com (Postfix) with ESMTPSA id 8103918A09AC;
	Sun, 27 Apr 2014 16:02:59 -0500 (CDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247227>

On 27/04/2014 20:33, Johan Herland wrote:
> On Sun, Apr 27, 2014 at 7:38 PM, Jeremy Morton<admin@game-point.net>  wrote:
>> On 27/04/2014 10:09, Johan Herland wrote:
>> As far as I can tell from that discussion, the general opposition to
>> encoding the branch name as a structural part of the commit object is that,
>> for some people's workflows, it would be unhelpful and/or misleading. Well
>> fair enough then - why don't we make it a setting that is off by default,
>> and can easily be switched on?  That way the people for whom tagging the
>> branch name would be useful have a very easy way to switch it on.
>
> Therefore, the most pragmatic and constructive thing to do at this
> point, is IMHO to work within the confines of the existing commit
> object structure. I actually believe using commit message trailers
> like "Made-on-branch: frotz" in addition to some helpful
> infrastructure (hooks, templates, git-interpret-trailers, etc.) should
> get you pretty much exactly what you want. And if this feature turns
> out to be extremely useful for a lot of users, we can certainly
> consider changing the commit object format in the future.

OK, fair enough.  So I guess what I'd like to see, then, is good 
built-in functionality in Git for these commit message trailers, so that 
they are very easy to turn on.  I'd like to be able to tell 
co-developers to add a one-liner to their git config file rather than 
some post-commit script.

>> I know
>> that for the workflows I personally have used in the past, such tagging
>> would be very useful.  Quite often I have been looking through the Git log
>> and wondered what feature a commit was "part of", because I have feature
>> branches.  Just knowing that branch name would be really useful, but the
>> branch has since been deleted... and in the case of a ff-merge (which I
>> thought was recommended in Git if possible), the branch name is completely
>> gone.
>
> True. The branch name is - for better or worse - simply not considered
> very important by Git, and a Git commit is simply not considered (by
> Git at least) to "be part of" or otherwise "belong to" any branch.

Please understand that I know this full well.  :-)  I'm saying that the 
'ephemeral' pointers' names are, in themselves, useful - if, like me, 
you give them meaningful names.  What I'm proposing is pretty much an 
automatic tagging (somehow...) of each commit with the current branch 
name (if one is available); information that carries roughly the same 
weight as the commit message.  It could be crap, but equally it could be 
very useful, in some workflows.  I think most of us can agree on that.

> seems to only have come up a few times on the mailing list. This is

But it has come up more than once, which would seem to indicate that I'm 
not the only one with this request. ;-)

> IINM, Mercurial does this differently, so that may be a better fit for

"If I'm Not Mistaken" - I had to look that one up.

> the workflows where keeping track of branch names is very important.

Nah, I had a look at Mercurial and I think I prefer Git - this branch 
name thing is just my one bugbear.  I definitely prefer Git's concept of 
a staging area rather than just committing all changes.  To do that in 
Mercurial you have to use mq and all the different (IMHO unintuative) 
commands that entails, and if you accidentally "mq commit" then you 
screw everything up. :-)  Mercurial also discourages history rewriting 
(ie. cleaning up of messy commits), which Git doesn't.  I prefer Git's 
approach here too.

> Yeah, sure. Author and Date (and Committer, for that matter) is just
> metadata, and the current branch name is simply just another kind of
> metadata. All of them are more-or-less free-form text fields, and off
> the top of my head, I can't really say that if we were to design Git
> from scratch today, they wouldn't all become optional trailers (or
> headers, or what-have-you).
>
> However, we're not designing Git from scratch, and we have to work
> with what is already there...

Fair point.

>>>> The branch name can provide useful
>>>> contextual information.  For instance, let's say I'm developing a suite
>>>> of
>>>> games.  If the commit message says "Added basic options dialog", it might
>>>> be
>>>> useful to see that the branch name is "pacman-minigame" indicating that
>>>> the
>>>> commit pertains to the options dialog in the Pacman minigame.
>>>
>>> In that partcular case, ISTM that the context ("pacman-minigame")
>>> would actually be better preserved elsewhere. E.g. the commits touch
>>> files in a particular "minigames/pacman" subdir, or you prefix the
>>> context in the commit message ("pacman-minigame: Added basic options
>>> dialog"). Also, such a "topic" branch is often tied to a specific
>>
>> Again, this is a pain because you have to remember to manually tag every
>> commit message with "pacman-minigame", and it takes up precious space in the
>> (already short) commit message.
>
> Yes, which is why I advise you to look at commit message templates,
> hooks, and interpret-trailers to see if you can find a way to automate
> this for you and your co-workers.

What I'd like to see, then, is this trailer functionality built in to 
Git so that a very minimal amount of setup is needed to get everybody 
using it.  We're basically talking about hijacking the commit messages 
and tacking on information that they weren't really intended to hold 
(ie. stuff the developer hasn't manually typed in as a commit message), 
because of the limitation of the Git commit format.  In hindsight, I 
guess it would've been better to have the Git commit format be more 
flexible in terms of what headers it allows, so that new headers could 
easily be added and some headers could be optional.

>> Only if it's a non-ff merge, which results in less tidy commit trees, and
>> hence is often recommended against.
>
> Not at all. If you're developing a series of commits with a common
> purpose (a.k.a. a topic branch) I would very much argue for
> non-ff-merging this, _exactly_ because the merge commit allows you to
> introduce the entire topic as a single entity. The merge commit
> message (in addition to containing the branch name) is also the
> natural place to describe more general things about the topic as a
> whole - sort of like the cover letter to a patch series.

Would you recommend that every single commit be made in a branch that 
gets merged into master, then?  So, no direct commits to master?

> The problem is not really "less tidy commit trees" - by which I gather
> you mean history graphs that are non-linear. IMHO, the history graph
> should reflect parallel/branched development when that is useful.
> Blindly rebasing everything into a single line is IMHO just as bad as
> doing all your work directly on master and blindly running "git pull"
> between each of your own commits (which results in a lot of useless
> merges). The merge commits themselves are not the problem. Merge
> commits are a tool, and when used properly (to introduce topics to the
> master branch like described above) they are a good tool. When abused
> (like blindly running "git pull" and accepting useless "merge
> bubbles") they create more problems than they solve.

Sounds like the default behaviour of "git pull" might not be ideal if it 
easily causes these problems.

>>   Whatsmore, tracking down which branch a
>> commit pertains to is still rather difficult using this approach.  You can
>> go back through the history and find "Merge branch 'pacman-minigame'", but
>> how do you know which commit was the *start* of that branch, if they are not
>> tagged with the branch name?
>
> Once you have found the merge commit (M), git log M^1..M^2 should list
> all the commits that were made on that branch. The parent of the last
> in that list can be considered the starting point for the branch.

I don't quite understand this; your suggestion would only work on the 
assumption that no merges have been made from master to that branch; git 
log M^1..M^2 will get the most recent common ancestor of the two and 
show the commits between them, but if there has been a merge from master 
to branch, it will not show the commits to the branch before that 
merge... so it's not as useful as tagging.  You'd have to do some work 
to get all the branch's commits, which is rather undesirable when you 
could just see the branch name (when perusing 'git log') if it were 
tagged as part of the commit.

> Hope this helps,
>
> ...Johan

-- 
Best regards,
Jeremy Morton (Jez)
