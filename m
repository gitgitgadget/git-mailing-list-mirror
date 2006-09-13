From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git pull a subtree, embedded trees
Date: Wed, 13 Sep 2006 16:21:56 +0200
Organization: At home
Message-ID: <ee945j$h3u$1@sea.gmane.org>
References: <4508020F.2050604@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Sep 13 16:23:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNVeB-0000JW-KV
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 16:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWIMOXL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 10:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWIMOXL
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 10:23:11 -0400
Received: from main.gmane.org ([80.91.229.2]:24810 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750857AbWIMOXK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Sep 2006 10:23:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GNVd6-0008Sx-46
	for git@vger.kernel.org; Wed, 13 Sep 2006 16:22:20 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 16:22:20 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 16:22:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26911>

Tim Shimmin wrote:

> I'm new to git and have a couple of novice questions.
> 
> * Is it possible to only pull in a subtree from
> a repository.

I assume that by pull you mean checkout...

I think it is possible (try git-read-tree with --prefix option, 
and select subtree by giving either it's sha1, or e.g.
HEAD:<path> form), but not easy to do. Git revisions are 
snapshots of the whole project (the revisions are states of
the whole project).

> Moreover, is it possible to have a subtree based on another
> repository.

It is possible. For example, make empty directory <subproject>
somewhere, add this directory, or just all the files in it
either to .gitignore or .git/info/excludes file, then clone
the other project (subproject) to this place. You would have
the following directory structure

  /
  dir1
  dir2
  dir2/subdir
  subproject
  subproject/.git
  subproject/subprojectsubdir
  ...

> * Are there any tools for dumping out the contents of the
> git objects in the .git/objects directory.
> By dumping out, I mean an ascii representation of the data
> fields for the commit and tree objects in particular.
> I've written a simple small program to dump out the index
> entries (cache entries).

git-cat-file -p

> I just want to see what is exactly stored in the .git
> binary files and how they change when I do various git
> operations.

Loose object are stored type+compressed contents. But usually
everything except latest work is in packs.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
