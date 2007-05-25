From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: Problem using git svn clone
Date: Fri, 25 May 2007 07:13:44 -0700
Message-ID: <m21wh5kn3b.fsf@ziti.local>
References: <bf7b2dda0705241435t1563008o3c47607343a34a56@mail.gmail.com>
	<m2wsyxnbd9.fsf@ziti.local>
	<bf7b2dda0705241539i56f1b5b3kcd001e871e8688ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Gustaf Hendeby" <hendeby@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 16:14:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HraYP-0001dr-4V
	for gcvg-git@gmane.org; Fri, 25 May 2007 16:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbXEYON4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 10:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752491AbXEYON4
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 10:13:56 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:16961 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427AbXEYONz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 10:13:55 -0400
Received: by an-out-0708.google.com with SMTP id d31so211334and
        for <git@vger.kernel.org>; Fri, 25 May 2007 07:13:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=eC3xxrI1NH3rpmcl/EVrbyUnyU0HqHgIKYHaA4pkO43dOqQEDazys6yg5uG75drvzghTAwINBw7/hPPeN/wnIQqTAW82scemj+t/lQ0GArUz8vboQ75TWiW0TDktFoF03fwyZkKkYPiuWO1UYd1266pwFOneGEcyTit5SLrDy6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=WwmaJBFbsZVh2iL6PTsFHHvfpN71wY5z+Xuxk+Gc69U4uaY8uj4vUb3Os9SMSf0rYop0zI+m272CMN7FKvadlND/f+mgbNFL8jaYWWMGQgcyMomrMj9rTCWcpzCHPU0XXcVTV/Tl8Pri/X/rSvZ8AjB69hk81pE/474KlcU/LJg=
Received: by 10.115.76.1 with SMTP id d1mr1525575wal.1180102428539;
        Fri, 25 May 2007 07:13:48 -0700 (PDT)
Received: from ziti.local ( [24.19.38.22])
        by mx.google.com with ESMTP id q20sm2924954pog.2007.05.25.07.13.47;
        Fri, 25 May 2007 07:13:48 -0700 (PDT)
In-Reply-To: <bf7b2dda0705241539i56f1b5b3kcd001e871e8688ef@mail.gmail.com> (Gustaf Hendeby's message of "Fri, 25 May 2007 00:39:44 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48378>

"Gustaf Hendeby" <hendeby@gmail.com> writes:
> Let me clarify. When trying to check out the module with tags, the first
> example I only get the revisions, no content at all!  I have added some more
> info on this below.

If you see the output of the revisions being pulled from svn this
seems very odd.  Does a 'du -sh' in the created directory confirm no
data is there?  Are you sure it isn't just a matter of nothing getting
checked out for you?

> The second case works as I expected it, I included it as reference, and to
> show that it worked (probably not the smartest thing to do I guess).  Hence,
> probably just the first example is of interest.
>
>> The situation is as follows:
>> >
>> > I plan to use git and git svn to track a module in the middle of a SVN
>> > repository (which I have no control over) where I don't have read
>> > access more than to this specific module and the base directory, ie
>> > the layout is similar to this
>> >       https://svn.foo.bar/a/b/c/trunk
>> >       https://svn.foo.bar/a/b/c/tags
>> >       https://svn.foo.bar/a/b/c/branches
>> > and I have read access to https://svm.foo.bar/a,
>> > https://svn.foo.bar/a/b/c and below, but nothing else.
>> >
>> > What I want to do is clone the whole thing, including tags and
>> > branches.  I expected to be able to use the following command to do
>> > this (git v1.5.2):
>> >
>> > $ git svn clone https://svn.foo.bar/a/b/c -T trunk -t tags -b branches
>> >
>> > Initialized empty Git repository in .git/
>> > Using higher level of URL: https://svn.foo.bar/a/b/c =>
>> https://svn.foo.bar/a
>> >
>> > W: Ignoring error from SVN, path probably does not exist: (175002): RA
>> > layer request failed: REPORT request failed on '/a/!svn/bc/100':
>> > REPORT of '/a/!svn/bc/100': Could not read chunk size: Secure
>> > connection truncated (https://svn.foo.bar)
>> > r306 = 83f0c10b988a8f1e77a3f354126c52f0cfdecf76 (trunk)
>> > [...]
>> > Found possible branch point: https://svn.foo.bar/a/b/c/trunk =>
>> > https://svn.foo.bar/a/b/c/tags/0.1, 314
>> > Found branch parent: (tags/0.1) ad6a2361d0e69d6288ef226bb335bb4bf3bdd12e
>> > Following parent with do_update
>> > Successfully followed parent
>> > r315 = 3b92c4885b9d6f60241533dd99fa5023eebb1c64 (tags/0.1)
>> > r316 = 02e3b828b4f11c5fab9d10d85076a8ff209afa00 (trunk)
>> > [...]
>> >
>> > However, it seems I just get the info about the revisions (shows up
>> > nicely in gitk) but no content at all.  The config file reads:
>
>
> I'm really sorry, I mixed up the config files. :(  So I actually get this
> for the first example not the second:
>
> [core]
>        repositoryformatversion = 0
>        filemode = true
>        bare = false
>        logallrefupdates = true
> [svn-remote "svn"]
>        url = https://foo.bar/a
>        fetch = b/c/trunk:refs/remotes/trunk
>        branches = b/c/branches/*:refs/remotes/*
>        tags = b/c/tags/*:refs/remotes/tags/*
>
> Which looks good I guess...  But to be a bit more clear about what this
> actually gives me in the directory I just cloned to, and this is the
> problem:
>
> $ git checkout -f master

What's in .git/refs/remotes?

Does 'git checkout -b mytrunk refs/remotes/git-svn' work?

> Already on branch "master"
> $ ls -a
> .  ..  .git
> $ du -hs .git/objects
> 186K    .git/objects

A du of the entire .git dir would be more informative.

+ seth
