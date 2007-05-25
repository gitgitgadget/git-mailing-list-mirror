From: "Gustaf Hendeby" <hendeby@gmail.com>
Subject: Re: Problem using git svn clone
Date: Fri, 25 May 2007 16:46:02 +0200
Message-ID: <bf7b2dda0705250746p33cb198exe1fe5daa6b18d801@mail.gmail.com>
References: <bf7b2dda0705241435t1563008o3c47607343a34a56@mail.gmail.com>
	 <m2wsyxnbd9.fsf@ziti.local>
	 <bf7b2dda0705241539i56f1b5b3kcd001e871e8688ef@mail.gmail.com>
	 <m21wh5kn3b.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Seth Falcon" <sethfalcon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 16:46:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrb3R-0000vm-4G
	for gcvg-git@gmane.org; Fri, 25 May 2007 16:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbXEYOqF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 10:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758663AbXEYOqF
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 10:46:05 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:59397 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbXEYOqD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 10:46:03 -0400
Received: by py-out-1112.google.com with SMTP id a73so1411953pye
        for <git@vger.kernel.org>; Fri, 25 May 2007 07:46:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q9gpZIwiL9gRsEqCo5+J7nLU9oROIV6KCOVDjaNzlbp8iymyYXq0KQEh5Bcixk0lDEQ4/izb+9sGIbDTnsImvcDqP3+PtWyhAYJS5kqtJvJTB4rj61gsPI3ip6VT4dhMgyobfUv8t9Fat8AfDO0qXC6WeJHRqwyQWUKh2AuSphs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pBQ1gGoCTyfpfPbe+aEHysRQuk7LNaxADYljbQ2koMaZK3/vKvlaayZXFMS0o2Q7THL9572skHOoGm4efFzoHbrEZDm6YiuBpQ2qMhsOCqQvdYCjsIyXnAhTErxxvw1z6n9wAn6d2g8m6sgbMVhGYafPkMx39VbyaGlVfhvDrYg=
Received: by 10.35.30.17 with SMTP id h17mr2469175pyj.1180104362358;
        Fri, 25 May 2007 07:46:02 -0700 (PDT)
Received: by 10.35.18.2 with HTTP; Fri, 25 May 2007 07:46:02 -0700 (PDT)
In-Reply-To: <m21wh5kn3b.fsf@ziti.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48383>

On 5/25/07, Seth Falcon <sethfalcon@gmail.com> wrote:
> "Gustaf Hendeby" <hendeby@gmail.com> writes:
> > Let me clarify. When trying to check out the module with tags, the first
> > example I only get the revisions, no content at all!  I have added some more
> > info on this below.
>
> If you see the output of the revisions being pulled from svn this
> seems very odd.  Does a 'du -sh' in the created directory confirm no
> data is there?  Are you sure it isn't just a matter of nothing getting
> checked out for you?

The following result is the same directly after the clone attempt and
after a git checkout -f master:

$ du -hs
357K    .
$ ls -a
 .  ..  .git

If it is just not checked out I don't know what I'm doing wrong trying
to check it out.

> > The second case works as I expected it, I included it as reference, and to
> > show that it worked (probably not the smartest thing to do I guess).  Hence,
> > probably just the first example is of interest.
> >
> >> The situation is as follows:
> >> >
> >> > I plan to use git and git svn to track a module in the middle of a SVN
> >> > repository (which I have no control over) where I don't have read
> >> > access more than to this specific module and the base directory, ie
> >> > the layout is similar to this
> >> >       https://svn.foo.bar/a/b/c/trunk
> >> >       https://svn.foo.bar/a/b/c/tags
> >> >       https://svn.foo.bar/a/b/c/branches
> >> > and I have read access to https://svm.foo.bar/a,
> >> > https://svn.foo.bar/a/b/c and below, but nothing else.
> >> >
> >> > What I want to do is clone the whole thing, including tags and
> >> > branches.  I expected to be able to use the following command to do
> >> > this (git v1.5.2):
> >> >
> >> > $ git svn clone https://svn.foo.bar/a/b/c -T trunk -t tags -b branches
> >> >
> >> > Initialized empty Git repository in .git/
> >> > Using higher level of URL: https://svn.foo.bar/a/b/c =>
> >> https://svn.foo.bar/a
> >> >
> >> > W: Ignoring error from SVN, path probably does not exist: (175002): RA
> >> > layer request failed: REPORT request failed on '/a/!svn/bc/100':
> >> > REPORT of '/a/!svn/bc/100': Could not read chunk size: Secure
> >> > connection truncated (https://svn.foo.bar)
> >> > r306 = 83f0c10b988a8f1e77a3f354126c52f0cfdecf76 (trunk)
> >> > [...]
> >> > Found possible branch point: https://svn.foo.bar/a/b/c/trunk =>
> >> > https://svn.foo.bar/a/b/c/tags/0.1, 314
> >> > Found branch parent: (tags/0.1) ad6a2361d0e69d6288ef226bb335bb4bf3bdd12e
> >> > Following parent with do_update
> >> > Successfully followed parent
> >> > r315 = 3b92c4885b9d6f60241533dd99fa5023eebb1c64 (tags/0.1)
> >> > r316 = 02e3b828b4f11c5fab9d10d85076a8ff209afa00 (trunk)
> >> > [...]
> >> >
> >> > However, it seems I just get the info about the revisions (shows up
> >> > nicely in gitk) but no content at all.  The config file reads:
> >
> >
> > I'm really sorry, I mixed up the config files. :(  So I actually get this
> > for the first example not the second:
> >
> > [core]
> >        repositoryformatversion = 0
> >        filemode = true
> >        bare = false
> >        logallrefupdates = true
> > [svn-remote "svn"]
> >        url = https://foo.bar/a
> >        fetch = b/c/trunk:refs/remotes/trunk
> >        branches = b/c/branches/*:refs/remotes/*
> >        tags = b/c/tags/*:refs/remotes/tags/*
> >
> > Which looks good I guess...  But to be a bit more clear about what this
> > actually gives me in the directory I just cloned to, and this is the
> > problem:
> >
> > $ git checkout -f master
>
> What's in .git/refs/remotes?

$ ls -R .git/refs/remotes/
.git/refs/remotes/:
tags  trunk

.git/refs/remotes/tags:
0.1  0.1.1  0.2.0  0.2.1

So, in some way there seems to be tag information, but git doesn't
seem to handle them as tags.

>
> Does 'git checkout -b mytrunk refs/remotes/git-svn' work?

$ git checkout -b mytrunk refs/remotes/git-svn
git checkout: updating paths is incompatible with switching branches/forcing
Did you intend to checkout 'refs/remotes/git-svn' which can not be
resolved as commit?

However
$ git checkout -b mytrunk refs/remotes/trunk
works but is without any content.

>
> > Already on branch "master"
> > $ ls -a
> > .  ..  .git
> > $ du -hs .git/objects
> > 186K    .git/objects
>
> A du of the entire .git dir would be more informative.

$ du -hs .git
356K    .git

For the checkout of the trunk, that works but don't obtain what I'm
looking for has:
$ du -hs .git
5.9M    .git
More stuff has been stored here.  The clone process here also
indicates lots of added and changed files, not just list SVN revision
numbers with matching SHA1s as in the case shown above.

Also, this may be totally natural, but I find the warning that I get
at the start of the clone quite strange (from above):

W: Ignoring error from SVN, path probably does not exist: (175002): RA
layer request failed: REPORT request failed on '/a/!svn/bc/100':
REPORT of '/a/!svn/bc/100': Could not read chunk size: Secure
connection truncated (https://svn.foo.bar)

>From where comes the !svn/bc/100 ?  Is it supposed to be like that?
Also, it feels a bit dangerous to me to fall back to a position in the
SVN tree where there is a level that I don't have any access to
between the base and the module I want and have access to.

/Gustaf
