From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: Problem using git svn clone
Date: Thu, 24 May 2007 14:46:26 -0700
Message-ID: <m2wsyxnbd9.fsf@ziti.local>
References: <bf7b2dda0705241435t1563008o3c47607343a34a56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Gustaf Hendeby" <hendeby@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 24 23:46:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrL8l-0001i6-0T
	for gcvg-git@gmane.org; Thu, 24 May 2007 23:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbXEXVqd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 17:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbXEXVqc
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 17:46:32 -0400
Received: from nz-out-0506.google.com ([64.233.162.232]:23900 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbXEXVqc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 17:46:32 -0400
Received: by nz-out-0506.google.com with SMTP id n1so142583nzf
        for <git@vger.kernel.org>; Thu, 24 May 2007 14:46:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=bj8FF3ffMxLUeo0twy2A7odbyIOqzQQorYdnsvlB+o8sdBl+HsTTHiKt6Cmb/P5gjqJ9s0bQBkNZBxiCDExRrV1NSYt2rCOILqneTMZKzdS+DOHe+VldcQeHogy6BmEKix6wlZX2XRtneeoSXk6H8oukGxfRz71bWnRnoRc91cY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=F97VMe1j8wMnM5ByxAN34oBX/aI/d0gn6wK9+UzF/XC55MUU7f0CUqtjfHUAHkp6nCny5lGql24RqRBAb/u5nlV0pypDRyzx4FJp7oys71AuaYSZIEXxeNR8auWOOvgqmkoLGEvrPPD5V84stKZEwBW1LnZ/xowucXFT4Zh5/aQ=
Received: by 10.114.144.1 with SMTP id r1mr1164293wad.1180043191072;
        Thu, 24 May 2007 14:46:31 -0700 (PDT)
Received: from ziti.local ( [140.107.157.21])
        by mx.google.com with ESMTP id z20sm1376147pod.2007.05.24.14.46.30;
        Thu, 24 May 2007 14:46:30 -0700 (PDT)
In-Reply-To: <bf7b2dda0705241435t1563008o3c47607343a34a56@mail.gmail.com> (Gustaf Hendeby's message of "Thu, 24 May 2007 23:35:16 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48311>

"Gustaf Hendeby" <hendeby@gmail.com> writes:

> Hi!
>
> I have a problem with git-svn, which I hope the list can shed some
> light over.  I'm quite new to git (but so far I really like it, great
> job guys!) and I never use SVN, so don't really know what information
> may be needed to be able to help me on the right track.  I hope the
> below problem description is appropriate.

Although you've described in detail what you did, it isn't clear to me
what the problem is...

> The situation is as follows:
>
> I plan to use git and git svn to track a module in the middle of a SVN
> repository (which I have no control over) where I don't have read
> access more than to this specific module and the base directory, ie
> the layout is similar to this
> 	https://svn.foo.bar/a/b/c/trunk
> 	https://svn.foo.bar/a/b/c/tags
> 	https://svn.foo.bar/a/b/c/branches
> and I have read access to https://svm.foo.bar/a,
> https://svn.foo.bar/a/b/c and below, but nothing else.
>
> What I want to do is clone the whole thing, including tags and
> branches.  I expected to be able to use the following command to do
> this (git v1.5.2):
>
> $ git svn clone https://svn.foo.bar/a/b/c -T trunk -t tags -b branches
>
> Initialized empty Git repository in .git/
> Using higher level of URL: https://svn.foo.bar/a/b/c => https://svn.foo.bar/a
>
> W: Ignoring error from SVN, path probably does not exist: (175002): RA
> layer request failed: REPORT request failed on '/a/!svn/bc/100':
> REPORT of '/a/!svn/bc/100': Could not read chunk size: Secure
> connection truncated (https://svn.foo.bar)
> r306 = 83f0c10b988a8f1e77a3f354126c52f0cfdecf76 (trunk)
> [...]
> Found possible branch point: https://svn.foo.bar/a/b/c/trunk =>
> https://svn.foo.bar/a/b/c/tags/0.1, 314
> Found branch parent: (tags/0.1) ad6a2361d0e69d6288ef226bb335bb4bf3bdd12e
> Following parent with do_update
> Successfully followed parent
> r315 = 3b92c4885b9d6f60241533dd99fa5023eebb1c64 (tags/0.1)
> r316 = 02e3b828b4f11c5fab9d10d85076a8ff209afa00 (trunk)
> [...]
>
> However, it seems I just get the info about the revisions (shows up
> nicely in gitk) but no content at all.  The config file reads:
>
> [core]
>        repositoryformatversion = 0
>        filemode = true
>        bare = false
>        logallrefupdates = true
> [svn-remote "svn"]
>        url = https://svn.foo.bar/a/b/c/trunk
>        fetch = :refs/remotes/git-svn
>
>
> If I instead do:
>
> $ git svn clone https://svn.foo.bar/a/b/c/trunk
> Initialized empty Git repository in .git/
> W: Ignoring error from SVN, path probably does not exist: (175007):
> HTTP Path Not Found: REPORT request failed on
> '/a/!svn/bc/100/b/c/trunk': '/a/!svn/bc/100/b/c/trunk' path not found
> W: +empty_dir: source
> W: +empty_dir: test
> r306 = 83f0c10b988a8f1e77a3f354126c52f0cfdecf76 (git-svn)
>        A       resources/extensions/circuitparts.drext
> [...]
> r309 = 3a386e9b985c419d129461acbf24978795b36b96 (git-svn)
>        A       tools/source/physical.cc
> [...]
>
> I get all content in trunk and their revision history, but as expected
> no tag info.  The config file reads:
>
> [core]
>        repositoryformatversion = 0
>        filemode = true
>        bare = false
>        logallrefupdates = true
> [svn-remote "svn"]
>        url = https://svn.foo.bar/a
>        fetch = b/c/trunk:refs/remotes/trunk
>        branches = b/c/branches/*:refs/remotes/*
>        tags = b/c/tags/*:refs/remotes/tags/*

That looks like what you want.  Isn't it?

With that config, I would expect:

git svn fetch
   pull updates for trunk and all branches and tags from the svn
   server.

git checkout -b trunk remotes/git-svn
   checkout the current trunk

git svn rebase
   fetch and rebase trunk or current branch.  git svn should determine
   the right git branch from refs/remotes to rebase against.

Does that help any?

+ seth

-- 
Seth Falcon | Computational Biology | Fred Hutchinson Cancer Research Center
http://bioconductor.org
