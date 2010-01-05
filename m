From: David Aguilar <davvid@gmail.com>
Subject: Re: A question about changing remote repo name
Date: Tue, 5 Jan 2010 13:15:23 -0800
Message-ID: <20100105211521.GC2657@gmail.com>
References: <60ce8d251001032245n4e0267b1o1ecc796f324f8179@mail.gmail.com> <c1b8b6671001041852w4740b7d6g4b8db1221c5dc744@mail.gmail.com> <60ce8d251001042030l75c5443gf173f127ad206df3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Russell Steicke <russellsteicke@gmail.com>, git@vger.kernel.org
To: Dongas <dongas86@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 22:15:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSGka-0003tD-3C
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 22:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755284Ab0AEVPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 16:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079Ab0AEVPb
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 16:15:31 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:35504 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764Ab0AEVPa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 16:15:30 -0500
Received: by mail-fx0-f225.google.com with SMTP id 25so10217448fxm.21
        for <git@vger.kernel.org>; Tue, 05 Jan 2010 13:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=wnWLTZwqXyOwsdAuPlJ3ACCoIo/h+0rW4PY7CiFG8kg=;
        b=VJtcXDEUYC1baXB/yCv2qpWyHhdJ28Lcuf/J3HbsBx/f5XBOAT7MtPpf9NRFUzpTRK
         m3XaHFQoAV+yFS2tgwxkUWAGeuXYawcYbdw//1MAIihGFuLDk4KioVj2PN+m+LTDlAqX
         6vVQWD8r8bvCpaQOYPG3k6QFCQlNo7JksDTjE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RCVYlsGaAfXokCP1fIZPguNL33u0oGMStafUkRPj1FvQZk81bzZuzw+OxV/6mfNAou
         OvbuyJlkUDbQMvrZuxPTgW57uuP0TTC36+qHIUCQlRsLwK0f37fcOlU/TGGPqvAhqAbD
         jZ7tvEhJmwkGP0I+oTGmViGEC8MSQFLsTGZEU=
Received: by 10.216.87.197 with SMTP id y47mr9756703wee.202.1262726129556;
        Tue, 05 Jan 2010 13:15:29 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id g9sm52161350gvc.25.2010.01.05.13.15.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 Jan 2010 13:15:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <60ce8d251001042030l75c5443gf173f127ad206df3@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136210>


Hi,

On Tue, Jan 05, 2010 at 12:30:03PM +0800, Dongas wrote:
> 2010/1/5 Russell Steicke <russellsteicke@gmail.com>:
> > On Mon, Jan 4, 2010 at 2:45 PM, Dongas <dongas86@gmail.com> wrote:
> 
> Thanks a lot, Russell.
> I followed you instruction but it seemed it needs more changes.
> 
> Execute your steps....
> Becomes:
> root@ubuntu:/work/git-repo/free_monkey# tree -a

Just a note: I would recommend against being root.
You cloned the repo so you should own it.

More below...


> root@ubuntu:/work/git-repo/free_monkey# cat .git/config
> [core]
> 	repositoryformatversion = 0
> 	filemode = true
> 	bare = false
> 	logallrefupdates = true
> [remote "karmic"]
> 	url = git@192.168.1.116:free_monkey.git
> 	fetch = +refs/heads/*:refs/remotes/karmic/*
> [branch "master"]
> 	remote = karmic
> 	merge = refs/heads/master
> 
> But the result was:
> root@ubuntu:/work/git-repo/free_monkey# git branch -a
> * master
>   karmic/HEAD
>   origin/master
> The 'origin/master' was still not changed.


A safter alternative would be to leave the "origin" lines in
place as a duplicate of karmic:

[remote "karmic"]
	url = git@192.168.1.116:free_monkey.git
	fetch = +refs/heads/*:refs/karmic/origin/*

[remote "origin"]
	url = git@192.168.1.116:free_monkey.git
	fetch = +refs/heads/*:refs/remotes/origin/*


At that point you will have two remotes, "karmic" and "origin".
"git fetch karmic" to get the latest branches.

Finally, "git remote rm origin" to remove all references to it.

> I did a few more steps:
> root@ubuntu:/work/git-repo/free_monkey# grep -wrin 'origin' .
> ./.git/packed-refs:2:abfae429bb4081043e84681e5ee94102085f87e0
> refs/remotes/origin/master
> ./.git/refs/remotes/karmic/HEAD:1:ref: refs/remotes/origin/master
> 
> Change 'origin' to 'karmic' in above files.


You can skip this step by using "git remote rm" as described
above.


> The steps are a little complicated.
> Do you know if there's a way to rename the remote on server side?
> If there is, then everyone could just clone the project with a new
> remote name rather than the defaul 'origin'.

Unfortunately, no.  "origin" is actually a local thing.
Your local git client gives it that name.  As you can see, the
remote does not care whether we call it "origin" or "karmic".


There were some patches flying around on the ML some time ago
that allowed you to change the default "origin" name on the
client side at "git clone" time (or maybe patches never
materialized and it was purely discussion).

That was a while ago (probably over a year ago) and this wasn't
anybody's itch to scratch in the meantime so nothing every
materialized.  It think this is only the 2nd time this has come
up in that whole time.  Sorry, I wasn't able to find the thread.


Here's a nice middle ground --

instead of naming your branch "master" you can call your default
branch "karmic".

To make it the default for "git clone" then you'll need to push
your local master branch and call it "karmic" over there:

	git push origin master:karmic

Then, go to that server and change the repo's HEAD entry so that
it points to karmic instead of master.

	ssh admin@gitbox
	cd /path/to/repo.git
	vi HEAD

>From then on, everyone who clones the repo will have a "karmic"
branch by default instead of the master branch.

To get that branch on repos that were cloned before the change:

	git fetch origin
	git checkout -b karmic origin/karmic



With this setup you might even want to remove the "master"
branch altogether since it might be confusing to have both:

Once:
	git push origin :master

In everyone's repo:
	git remote prune origin


You will need to make sure everyone has either:
	a) cloned from the new master-less repo
	b) run the "checkout -b" and "remote prune" commands

Otherwise someone'll likely "git push" the master branch back
into existence.


-- 
		David
