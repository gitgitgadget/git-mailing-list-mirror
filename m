From: Max Horn <max@quendi.de>
Subject: Re: [PATCH 00/13] remote-hg: general updates
Date: Thu, 4 Apr 2013 02:25:10 +0200
Message-ID: <EF2F8946-4F60-4659-9215-6C21C9641AB0@quendi.de>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com> <20130402200948.GF2222@serenity.lan> <2670C2C0-E30F-47DA-8901-899FEE11059E@quendi.de> <CAMP44s3DETFBhexPhEEMP1TZGNrc91266=t16H2t_+VB_4V38w@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, gitifyhg@googlegroups.com
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 02:25:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNXzw-0006Kn-7V
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 02:25:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761060Ab3DDAZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 20:25:19 -0400
Received: from mail-ee0-f48.google.com ([74.125.83.48]:34259 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759285Ab3DDAZR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Apr 2013 20:25:17 -0400
Received: by mail-ee0-f48.google.com with SMTP id b15so874497eek.21
        for <git@vger.kernel.org>; Wed, 03 Apr 2013 17:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:subject:mime-version:content-type:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to:x-mailer;
        bh=Fr3J8n5G7mcZWmisrqG4pQDiVTfdgVraXK9xhWlmnLY=;
        b=klHUaZX77/JlShHCSgMPGs1Be3MFySWHGogSKfrPd8SRMOAWg+Y//NACA1u/KZPghA
         tX/Uin08kovZWfaUOEiPqjVKabqS975xxag2TTYzglSw9oKJvhnufcFOoduoVF7L4tzY
         sUdNMd5xBAJkBDrQvgRjzJORMcElZ0i96BYV0OgaIF5usYI12C6BOnP94+wTLIarn+WA
         7J2/p/gUwG5omCRpO5d5JZ8xGPrAyS7b8prKCpSqbF+BAhxcXwNC0eIfVx7kn/qHSlhz
         +qJm+jarCKMyR9lpt7gcl1suLak5ZffJU+jh/vlJ3Cyxj8JdE2nDWdKEVsMULgmXZADY
         4fVQ==
X-Received: by 10.15.36.67 with SMTP id h43mr6893422eev.5.1365035114648;
        Wed, 03 Apr 2013 17:25:14 -0700 (PDT)
Received: from [172.16.1.174] ([212.71.7.39])
        by mx.google.com with ESMTPS id s3sm9478116eem.4.2013.04.03.17.25.11
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 03 Apr 2013 17:25:12 -0700 (PDT)
In-Reply-To: <CAMP44s3DETFBhexPhEEMP1TZGNrc91266=t16H2t_+VB_4V38w@mail.gmail.com>
X-Mailer: Apple Mail (2.1283)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219979>


On 03.04.2013, at 03:31, Felipe Contreras wrote:

> On Tue, Apr 2, 2013 at 4:23 PM, Max Horn <max@quendi.de> wrote:
>> 
>> On 02.04.2013, at 22:09, John Keeping wrote:
>> 
>>> On Tue, Apr 02, 2013 at 01:02:49PM -0600, Felipe Contreras wrote:
>>>> Here is the next round of patches for remote-hg, some which have been
>>>> contributed through github.
>>>> 
>>>> Fortunately it seems to be working for the most part, but there are some
>>>> considerable issues while pushing branches and tags.
>>> 
>>> How does this compare to the current state of gitifyhg[1]?  That's built
>>> on top of this git-remote-hg script but seems to have been more actively
>>> developed recently.
> 
> I only learned about it recently, I've looked at the history and to me
> it seems rather chaotic, and a lot of the code was simply copied from
> git-remote-hg without comment.

gitifyhg was scrapped and completely restarted from scratch at some point. Based largely on your git-remote-hg code. A bit more on its history can be read here:
  http://archlinux.me/dusty/2013/01/06/gitifyhg-rewritten/


> 
>> * added many new test cases, sadly still including some xfails. Several of these (both passing and xfailing) also apply to remote-hg (i.e. the issue is also present in contrib's remote-hg)
> 
> I ran these test-cases with remote-hg, and the same test-cases pass. I
> only had to do minor modifications, most of the failures came from
> subtle differences such as different strategies to sanitize authors,
> and which branch to pick for HEAD.

Yeah, that's because what I wrote was based on the situation before your recent patch series. Glad to see that git/contrib's remote-hg is improving!


> 
>> * improved handling of hg user names (remote-hg is not able to deal with some pathological cases, failing to import commits). Sadly, mercurial allows arbitrary strings as usernames, git doesn't...
> 
> I wouldn't call it improved. In some cases the remote-hg result is
> better, in others gitifyhg is,

I'd love to learn about cases where remote-hg's result is better in your opinion, so that I can see if the mapping in gitifyhg could be improved for those cases.

That said, this part is really quite subjective I guess. In the end, since Mercurial names can be *anything*, one can never get a "perfect" mapping. Luckily, for most real repositories out there, user names will be quite sane and remote-hg and gitifyhg will produce identical results. (Although some hg repos out there have some really weird stuff going on. Yuck.)

> but there's only a single case where
> the author name becomes a significant problem. It's a trivial fix.

Excellent, looking forward to it then.

> 
>> * failed pushes to hg are cleanly rolled back (using mq.strip() from the mq extension), instead of resulting in inconsistent internal state. This is quite important in real life, and has bitten me several times with remote-hg (and was the initial reason why I switched to gitifyhg). A typical way to reproduce this is to push to a remote repository that has commits not yet in my local clone.
> 
> This is not an issue in remote-hg any more since now we force the
> push. It's not nice, but there's no other way to push multiple
> bookmarks (aka git branches) to the same branch (aka commit label).

Uhh, what? The push is forced? That sounds to me like a much, much bigger issue with remote-hg than anything else ever was, from my point of view. That seems tobe akin to making "--force" default to "git push", and I don't think anybody here would consider that a good idea.

> I doubt these inconsistent states can happen any more, but if they do,

Seriously? This is triggered quite frequently in real life. And it will very likely cause somebody to mess up a hg repository they work on. As long is this in, using remote-hg is a total no-go for me. Just consider the following scenario:
* user A clones a hg repository into a git repository
* user A commits some commits in the git clone
* meanwhile, user B pushes changes to the hg repository
* user A tries to push his changes to the hg remote

The last step causes this result in gitifyhg (similar to what one gets when the remote is a git repos):

 ! [rejected]        master -> master (non-fast-forward)
error: failed to push some refs to 'gitifyhg::URL'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Merge the remote changes (e.g. 'git pull')
hint: before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.


With remote-hg, you just force push the change, creating a new head in the remote repo. So, yeah, failed pushes which mess up the internal state don't happen anymore. But I rather have those than potentially mess up the upstream repository like that.


> the plan in remote-hg is to simply ignore those revisions, and only
> push the ones that have git refs. I have the code for that, but I'll
> not be pushing it to git.git for the time being.

I am not quite sure what you mean here, but I'll just wait for your code and hope it'll explain itself.

> 
>> * git notes are used to associate to each git commit the sha1 of the corresponding hg commit, to help users figure out that mapping
> 
> This is a minor feature. I've had the code for this for quite some
> time, but for the moment I think there are higher priorities.

Well, I guess it depends on how you use this. In my daily work with hg repositories, that's a quite important feature. 

Actually, I wonder: Are you actually using remote-hg yourself for day-to-day development? Or for any other regular activities? You seem to have quite different usage patterns from me and other people involved with gitifyhg.

> 
>> * internally, the marks are using the hg sha1s instead of the hg rev ids. The latter are not necessarily invariant, and using the sha1s makes it much easier to recover from semi-broken states.
> 
> I doubt this makes any difference (except for more wasted space).

I disagree. Especially since remote-hg does treat local hg repositories differently than remote ones, by not cloning them but rather working with them directly. As soon as somebody uses "hg strip" or "hg graft", etc. on that, your mark files will contain incorrect data.

With a  remote hg repository, that is of course not as much of an issue, since you have a local hg clone stored inside of .git/. In theory, the user would never touch that, so nothing in there changes. In reality, though, sometimes the user still has to dig in there and modify things (e.g. to undo a "bad" push; although of course for now you "fixed" that particular problem by force pushing). Of course in an ideal world, a user never should have to do that, but as long as there are bugs, users may have to. And based on painful experience, it is *much* easier to do that when the marks use the invariant hashes instead of the transient rev ids.

As for the wasted space: For a repository with 999,999 commits, the size of the "marks-hg file should increase from about 1.5 MB to about 5 MB. To use your words: Hardly worth mentioning.


> 
>> * Better handling of various hg errors, see e.g. [2]. More work is still needed there with both tools, though [3].
> 
> This is literally a three lines fix, and it simply makes one error
> nicer. Hardly worth mentioning.

Perhaps not for you, but for users who just want to use remote-hg resp. gitifyhg, getting a helpful error message instead of seeing an (to them) unreadable stack trace is quite important. I guess this just shows that we have quite different goals and ideas about how to interact with users of our respective tools :-).

Anyway, I hope you'll consider applying something like that three lines fix to remote-hg.

> 
>> * Support for creating hg tags from git (i.e. pushing light git tags to heavy hg tags)
> 
> remote-hg has the same.

Excellent.

> 
>> * The gitifyhg test suite is run after each push on Travis CI against several git / mercurial combinations [4].
>> In particular, unlike all other remote-hg implementations I know, we explicitly promise (and test) compatibility with a specific range of Mercurial versions (not just the one the dev happens to have installed right now). This has been a frequent issue for me with the msysgit remote-hg
> 
> I've personally checked against multiple versions of Mercurial. It's
> possible that some error might slip by, but it would get quickly
> noticed.

Really? This sounds close to some people who say things like "I don't need a test suite, I personally run some tests every now and then on my machine."
Of course clearly that is not at all how you operate. Rather you are very sensible and strive to provide a good testsuite which strives to test as much stuff as possible. As it should be. Which is why I am surprised that you compare (a) "personally" checking against some unspecified "multiple versions of Mercurial" at an unspecified frequency with (b) automatically running a testsuite after each push against a specific set of Mercurial versions. Versions which were specifically selected to match what Ubuntu 11.10, 12.04 LTS and 12.10 resp. Debian Wheezy provide, as well as recent versions. See also <https://github.com/buchuki/gitifyhg/blob/master/.travis.yml>. I would like to also let this check with multiple git versions, but that requires collecting / making suitable .debs which I have n
 ot yet gotten around to.

Furthermore, you don't seem to document what versions of Mercurial are supposed to work / not work. (Indeed, as far as I can tell, remote-hg has no documentation whatsoever, another difference. Granted, the gitifyhg README is not particular great at this point, but at least it exists and tells people how to get started and where to get help).

In contrast, the gitifyhg README clearly states that it "requires at least Mercurial 1.9". And its setup.py refuses to install it if the Mercurial version is too old. Again, for us devs that's not very important, but for users, I think it is. In recent months, I had to provide assistance with using hg to tons of people (*sigh*), and old Mercurial versions came up in a considerable portion of those (perhaps 30-40% or so). 

> 
>> * Renaming a gitifyhg remote just works [5]. Doing that with remote-hg triggers a re-clone of the remote repository (if it works at all, I don't remember).
> 
> Yeah, now you can change the alias of the remote, but you can't change
> the remote url.

That's simply wrong. You still can change the remote URL, it will just lead to the creation of a fresh separate local clone.

In contrast, with remote-hg, renaming the remote will create a fresh local clone, while changing the remote URL will *not* do that -- instead, the changes from the new remote will be pulled into the existing local clone. Which in some cases may be exactly what you want (e.g. if a repository just moved to a different remote URL). But in other cases, it won't be, namely when the repository at the new URL contains different content. This is not that unlikely when you consider that it comment Mercurial workflow to use separate repositories for different branches.


> This is not really an advantage, simply an almost
> imperceptible different choice.

These are indeed different design choices, but at least to me, they are very much perceptible :-). And we made this design choice quite consciously, after looking at how it is done in remote-hg, and not liking that.

Anyway: At least in my day-to-day operations, I occasionally rename a remote (very rare, but it happens). So far I never had to change a remote URL. Of course that is just me, perhaps others occasionally (well, more of than me :-) have to change remote URLs. But as I said, that's still possible in gitifyhg.

That said, the situation is certainly not ideal. The fact that remote helpers have no good way to notice if the remote name (or URL, or anything) have changed is the root problem at hand here, I'd say. But for now, we are happy enough with the solution we implemented in gitifyhg, at least for our purposes.


> I still don't see any good reason why a user might prefer gitifyhg,

Well, for me it is exactly the other way around :-). That said, gitifyhg certainly also still has issues and problems, but I am confident it will even better in the coming weeks. And it certainly wouldn't be were it is now without your great work on remote-hg, and also on related improvements you got into git.git. Kudos!


> even more importantly, why gitifyhg developers don't contribute to
> remote-hg.

I can only speak for myself, as a (minor) contributor to both remote-hg and gitifyhg. But here are my reasons why I prefer contributing to remote-hg over gitifyhg:

1) Apparent difference between your goals and mine / those of gitifyhg. I think this is quite visible if one looks at our exchange above. Features that are quite important to me, even crucial, are unimportant for you, or even outright rejected. In contrast, so far with the couple people working on gitifyhg we always managed to arrive at solutions that satisfy all of us. I.e. it seems our ideas and goals are much better aligned within that group.

2) Lack of reactions on pull requests and bug reports on your github pages. Perhaps you never intended this to be used for pull requests / bug reports, but I never (until recently) saw you state that, nor can one read such a statement on your github pages. 

3) Not shipping gitifyhg as part of git/contrib but rather as a separate package is important to me, too. It means that we can make new releases whenever we want, not tied to git. Users can install it easily via "pip", and I also think it gets a lot more visibility this way.


> 
> Also, unlike remote-hg, which basically passes all the tests of
> gitifyhg, gitifyhg barely passes any tests of remote-hg (three).

Heh, bad, but OK (as I said, my message was based on an older version of remote-hg, and actually also on an older gitifyhg). Thank you for the report, I'll look into it as soon as I can (or somebody else might).

BTW, I just pulled you hg-next branch, and run "make test" in that. The tests in test-hg-hg-git.sh actually all failed (with remote-hg). Do I need to do something special for those to work?


Cheers,
Max