From: David Greaves <david@dgreaves.com>
Subject: Re: I want to release a "git-1.0"
Date: Mon, 30 May 2005 23:11:44 +0100
Message-ID: <429B8FA0.1080903@dgreaves.com>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 00:10:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcsRX-0004ry-Ng
	for gcvg-git@gmane.org; Tue, 31 May 2005 00:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVE3WLo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 18:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbVE3WLo
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 18:11:44 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:16350 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261711AbVE3WLk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2005 18:11:40 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 4D839E6D76; Mon, 30 May 2005 23:11:21 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 32197-08; Mon, 30 May 2005 23:11:21 +0100 (BST)
Received: from oak.dgreaves.com (modem-3495.lemur.dialup.pol.co.uk [217.135.141.167])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 0F3B7E6DBF; Mon, 30 May 2005 23:11:20 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DcsU2-0000ya-Md; Mon, 30 May 2005 23:11:42 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:

>So before I do a 1.0 release, I want to write some stupid git tutorial for
>a complete beginner that has only used CVS before, with a real example of
>how to use raw git, and along those lines I actually want the thing to
>show how to do something useful.
>
>So before I do that, is there something people think is just too hard for
>somebody coming from the CVS world to understand? I already realized that
>the "git-write-tree" + "git-commit-tree" interfaces were just _too_ hard
>to put into a sane tutorial.
>
>I was showing off raw git to Steve Chamberlain yesterday, and showing it
>to him made some things pretty obvious - one of them being that
>"git-init-db" really needed to set up the initial refs etc). So I wrote
>this silly "git-commit-script" to make it at least half-way palatable, but
>what else do people feel is "too hard"?
>
>I think I'll move the "cvs2git" script thing to git proper before the 1.0 
>release (again, in order to have the tutorial able to show what to do if 
>you already have an existing CVS tree), what else?
>  
>

It seems to me that a tutorial for end users is inappropriate.
You should be writing a tutorial for porcelain implementors :)

Anyway, a while back I split the commands into manipulation and
interrogation and then into ancillary commands and scripts. Do you
actually agree with this grouping?
http://www.kernel.org/pub/software/scm/git/docs/git.html
It may help to position who should be doing what.

Also, if you're writing a git-init-script, it may be that you're simply
scripting common processes and could helpfully maintain consistency by
either pulling some of the really trivial Cogito scripts (cg-init,
cg-add, cg-rm) into the core 'ancillary' area or suggesting
modifications to Cogito as the current 'best of breed' implementation of
the low-level git usage process. Cogito also 'fixes' some useability
issues such as using "git-update-cache --add" == "cg-add"
I know you _can_ use git as an end user - but it seems that it's
designed to be used by plumbers.

Oh, I'd also like to see something along the lines of my cg-Xignore
before git hits 1.0

On the tutorial side - yesterday I started pulling together stuff from
the list about merging to complete the README where it says [ fixme:
talk about resolving merges here ]

I haven't done much other than collect some discussion from the list and
the text from git-read-tree.txt.
I do think this area needs more explanation as the whole 'stage' thing
is pretty alien to CVS.
I also noted a few people asking "so I did this merge - what do I do now?"

The working directory/cache/repository is also confusing sometimes -
especially when the cache and working-dir unexpectedly don't match.

I also see in my notes: "improve the docs around update-cache."

David
