From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: simple git use case
Date: Thu, 5 Feb 2009 03:21:46 -0500
Message-ID: <76718490902050021u5f53c94aq2f1c20c871c98f9c@mail.gmail.com>
References: <498A7073.4060206@biostat.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Erik Iverson <iverson@biostat.wisc.edu>
X-From: git-owner@vger.kernel.org Thu Feb 05 09:23:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUzVz-0005r2-7j
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 09:23:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756359AbZBEIVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 03:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756094AbZBEIVt
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 03:21:49 -0500
Received: from rv-out-0506.google.com ([209.85.198.224]:35520 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754267AbZBEIVs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 03:21:48 -0500
Received: by rv-out-0506.google.com with SMTP id k40so144542rvb.1
        for <git@vger.kernel.org>; Thu, 05 Feb 2009 00:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4Skh3RFGDZlfuoFfZttNvsPvv1yjSSMSMptepr/DA1g=;
        b=mXhS3VG9IoaR2xp+sjw45nqlKqILj3mMnPOkQwmycPNw4blpwJEEmIgcJyrVMpfOLk
         8FmvAkJc4GVZIs/VwrvjphVjQXCq6TkKPsDz85uM/ytoRFzuG57RRox3e3D6q2FRtqkx
         91SOGMyNZO6440TPEXlyAx7oWz2qSiYcKTjUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dVgALAMPOuvlmxbyCwRIMCscu0orEkKBRJvEBhP10ZysAe4GBM7V/w/WChAGUT3ltt
         8Cp942vsK/mPZ4PGRSxh2jyUKqJQdswr7znDPgr03Khc8kROR40WsZH5DoYXBKHjnqbb
         hWvUx2gI1YF2DTjZ02x9nAR0yAVAJDvFdIF7Y=
Received: by 10.141.175.5 with SMTP id c5mr156142rvp.162.1233822106756; Thu, 
	05 Feb 2009 00:21:46 -0800 (PST)
In-Reply-To: <498A7073.4060206@biostat.wisc.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108533>

On Wed, Feb 4, 2009 at 11:52 PM, Erik Iverson <iverson@biostat.wisc.edu> wrote:
> Dear all,
>
> I sincerely hope this is not an annoying question, I promise I have tried to
> do my homework here, but am stuck.  My use case is simple.  I have a desktop
> and a laptop.  When I go on the trips, I'd love to be able to bring my
> "git-test" directory with me on the laptop, code some, and then get the new
> revisions back on the desktop when I get home (bonus if I can get the
> revisions back to my desktop over the internet while still on the road, in
> case, for example, my laptop gets stolen).  No one else will be working on
> this stuff, it's strictly for me.

You may wish to read:

  http://git.or.cz/gitwiki/GitFaq#head-b96f48bc9c925074be9f95c0fce69bcece5f6e73
  (Why won't I see changes...)

and:

  http://git.or.cz/gitwiki/GitFaq#push-is-reverse-of-fetch
  (How would I use "git push"...)


> OK, so here's what I do.
>
> Desktop (dt):
>
> dt> cd git-test
> dt> git-init
> Initialized empty Git repository in /home/erik/projects/git-test/.git/
> dt> git add .
> dt> git-commit -am 'initial commit'
> Created initial commit c150815: initial commit
>  3 files changed, 14 insertions(+), 0 deletions(-)
>  create mode 100644 test.R
>  create mode 100644 test.sas
>  create mode 100644 test.tex
>
> Looks good...
> Now over to the laptop (lt)!
>
> lt> git-clone ssh://myip/path/to/project
>
> And great, I have the three test.* files, looks good!
> So I make some changes to test.R on laptop, like I'm on the road. Then, on
> laptop:
>
> lt> git-commit -am 'an update'
>
> Looks good.
>
> Now I become a mouth-breather...and need some help :).
>
> My instinct was to git-push from the laptop,
>
> lt> git-push
>
> which succeeds

When you did the clone operation, you set things up such that the
branch called "master" on the desktop is replicated to a branch called
"origin/master" on the laptop. Whenever you do a "pull" on the laptop
(which clone did for you initially), it will do two things:

1) Fetch the latest master from desktop and store it as origin/master
on the laptop.
2) Merge origin/master (on the laptop) with master (again on the
laptop) and update your working copy with the result.

Now, whenever you do a "push" on the laptop, it is *not* a symmetrical
operation to fetch/merge. Rather, the push updates master on the
desktop to match master from the laptop. However, the working copy on
the desktop is not touched. So when you login to the desktop, you need
to manually refresh the working copy from what was pushed. You do this
with "git reset --hard master". But be careful, if you have made
changes on the desktop and not committed them, these changes will be
lost when you do the reset.

The FAQ entries above discuss two alternatives to make this safer. One
alternative updates the working copy automatically and mostly safely
via a hook, while the other alternative discusses making the "push"
from the laptop symmetrical to the "fetch".

I'll elaborate on the later alternative slightly. You could do your
clone like this:

lt> git-clone -o desktop ssh://myip/path/to/project
lt> git branch -a
* master
  desktop/HEAD
  desktop/master

The only difference is we've used "-o" so that we have a more
descriptive name for the desktop than "origin".

To make the push operation on the laptop symmetrical to the fetch
(remember, pull = fetch + merge), do this:

lt> git config remote.desktop.push "+refs/heads/*:refs/remotes/laptop/*"

Now take a look at .git/config and notice the fetch and push are symmetric:

[remote "desktop"]
	url = ssh://myip/path/to/project
	fetch = +refs/heads/*:refs/remotes/desktop/*
	push = +refs/heads/*:refs/remotes/laptop/*

Let's do a commit and push it:

lt> echo bar > bar && git add bar && git commit -m "added bar"
lt> git push
To ssh://myip/path/to/project
 * [new branch]      master -> laptop/master

Back on the desktop:

dt> git branch -a
* master
  laptop/master

Ah hah. So the changes have been pushed to laptop/master, but of
course, the working copy is not up-to-date. When can fix that with:

dt> git merge laptop/master
Updating 785a74b..09ab37d
Fast forward
 bar |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 bar

This merges laptop/master into master, then updates the working copy
with the result. If you'd like "git pull" to be an alias for "git
merge laptop/master", you can:

dt> git config branch.master.remote .
dt> git config branch.master.merge refs/remotes/laptop/master
dt> git pull
From .
 * remote branch     laptop/master -> FETCH_HEAD
Already up-to-date.

j.
