From: Matthew Lear <matt@bubblegen.co.uk>
Subject: Unable to checkout a branch after cloning
Date: Tue, 11 Aug 2009 11:10:26 +0100
Message-ID: <4A814392.4080803@bubblegen.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 11 13:55:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MapxE-0000cc-RZ
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 13:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbZHKLxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 07:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbZHKLxG
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 07:53:06 -0400
Received: from relay.ptn-ipout01.plus.net ([212.159.7.35]:29039 "EHLO
	relay.ptn-ipout01.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751092AbZHKLxF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 07:53:05 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEADrigErUnw4U/2dsb2JhbADRQ4QZBQ
Received: from pih-relay08.plus.net ([212.159.14.20])
  by relay.ptn-ipout01.plus.net with ESMTP; 11 Aug 2009 11:18:54 +0100
Received: from [80.229.236.194] (helo=[192.136.1.12])
	 by pih-relay08.plus.net with esmtp (Exim) id 1MaoJH-0003xY-9u
	for git@vger.kernel.org; Tue, 11 Aug 2009 11:10:27 +0100
User-Agent: Thunderbird 2.0.0.22 (X11/20090626)
X-Plusnet-Relay: 13693960936ca0499fb18918b18e1140
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125516>

Hi all,

Apologies for perhaps a silly question, but I'd very much appreciate a
little bit of assistance.

I've set up a git repository on a machine accessible from the internet
with the intention to share code with another developer. We clone the
repository, commit changes then push back as you'd expect. The server
runs gitweb for repository browsing. Clients are running git v1.6.0.6.

When I created the initial repository I also created two additional
branches - 'upstream' and 'custom'. The former is to act as a 'vendor
branch' and the latter contains code specific to the custom platform
that we're working on. The master branch contains merges from the
upstream branch and also changes that we've made. The custom branch
contains merges from master with custom platform specific changes.

I've committed changes and on both upstream and custom branches as work
progressed, merged them where appropriate, added tags etc and pushed
everything to the remote repository. No problem. I can view the
branches, tags etc in gitweb and everything looks fine.

However, I can clone a new repository just fine but I'm unable to
checkout the upstream or custom branches. After cloning, only the master
branch is available, ie:

> git checkout upstream
error: pathspec 'upstream' did not match any file(s) known to git.

> git branch -a
* master
  origin/HEAD
  origin/master

.git/config:

[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        url = https://mysite/git/project.git
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master

But the initial local repository where I work (ie created the branches,
committed changes, tag, push etc) seems to be fine, ie

> git checkout upstream
Switched to branch "upstream"

> git branch -a
  custom
* master
  upstream

.git/config:

[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        url = https://mysite/git/project.git
        fetch = +refs/heads/*:refs/remotes/origin/*


Developers need to be able to clone the repository and then switch to
the appropriate branch in order to work. However it seems that after a
clone, only the master branch is available.

Why is this?

Any help would be much appreciated indeed.

Many thanks,
--  Matt
