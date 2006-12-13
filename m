X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: svn versus git
Date: Thu, 14 Dec 2006 00:24:17 +0100
Organization: Dewire
Message-ID: <200612140024.17739.robin.rosenberg.lists@dewire.com>
References: <200612132200.41420.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 13 Dec 2006 23:21:50 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 1044 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 18:21:36 EST
User-Agent: KMail/1.9.4
In-Reply-To: <200612132200.41420.andyparkins@gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34253>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GudPx-0000Hq-0I for gcvg-git@gmane.org; Thu, 14 Dec
 2006 00:21:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751736AbWLMXVh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 18:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbWLMXVh
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 18:21:37 -0500
Received: from [83.140.172.130] ([83.140.172.130]:12936 "EHLO
 torino.dewire.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with
 ESMTP id S1751735AbWLMXVh (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec
 2006 18:21:37 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id B7D938030BB; Thu, 14 Dec 2006 00:17:37 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 18838-05; Thu, 14 Dec
 2006 00:17:37 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3]) by torino.dewire.com (Postfix)
 with ESMTP id 20D4E800199; Thu, 14 Dec 2006 00:17:37 +0100 (CET)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

onsdag 13 december 2006 23:00 skrev Andy Parkins:
[...]
> svn checkout::
> Checkout a working copy from a repository.  You may check out an
> arbitrary revision.
> git clone::
> git checkout::
> Git, of course, is different from subversion, as the whole repository is
> always available.  git-checkout is nearest in concept to svn-checkout
> though.  It changes the current working directory to a particular
> branch.  You may not checkout an arbitrary revision.  git-clone might
> also be considered as an svn checkout analog.  However,
>
> Subversion wins.  The output from Subversion's checkout is clear.  The
> output from git-clone gives output that is only understandable by
> someone familiar with git internals.
I'd say svn clone is the nearest equivalent as it does the initial fetch of 
data, no checkout is necessary after clone. it checks out master. Then
you git-checkout to switch branch, which corresponds to svn switch.

> svn commit::
> Pushes changes to the upstream respository from your working copy.
> git commit -a::
> Saves changes to the working copy as a new revision in the local
> repository.
>
> The need for "-a" (or not) because of git's staging area (the index)
> here makes it more confusing than svn-commit for new users.  However,
> the ability to do "git --amend" more than makes up for it.  Fixing a
> typo in your last log message is difficult in subversion.  Also, git's
> commit message template is much better: both uses the output of their
> status commands which is far clearer in git than in Subversion.
>
> Git wins.
You'll need to push too in order to get a copy in a central repository. 
git-commit stays locally, and you need a place to push to. If your SVN
repo isn't local this does not apply. git gives more freedom here.

> svn copy::
> Duplicate something in working copy or repository, remembering history.
> cp A B; git add B::
> Git doesn't have a direct equivalent of svn copy.  It's arguable whether
> it needs it once the user knows they can git-add so easily.
>
> Git wins.  Git's ability to detect copies after-the-fact, mean that a
> git-copy isn't necessary.
svn copy is more like git checout -b, i.e. it's primary purpose is not 
to "copy" things, it is to create branches. You generally do not copy
code (I hope).

> svn move::
> Move and/or rename something in working copy or repository.
> git-mv::
> Move or rename a file, directory or symlink.
>
> Git wins.  The two are equivalent except that git can do multiple moves
> in one command, just like normal "mv".  So "git mv src/* newsrc/" works
> while "svn mv src/* newsrc/" doesn't.  Additionally, if you forget to do
> moves with git and instead use the command line, you can easily use
> "update-index" to tell git about the move after the fact.  In subversion
> you have to undo all the moves and do them again with subversion.  This
> makes it inconvenient to use tools like "rename" to do regexp moves.
In svn this also renames a branch.

> svn switch::
> Update the working copy to a different URL.
> [no git equivalent]::
> git is distributed and can fetch from any number of remote repositories.
> The URL can be typed on the command line of git-fetch, or can be given a
> shortcut as a "remote".  If we're talking about a single repository
> (which we have to to compare against subversion), the repository is
> local anyway.
>
> Git wins.  Command is unnecessary.
svn switch corresponds to git-checkout. I don't think you can change the URL
unless the new URL actually points to the same repository.

> Discussion
> ----------
[...]
>  - svn revert: it's not easy to revert a single file in git; especially
>    once we bring the index into play.  Restoring a single file in the index
>    to HEAD while leaving the rest of the index AND the working directory
>    untouched requires something like
>    ----------------------------------------------------
>    git-ls-tree file | git-update-index --index-info
>    ----------------------------------------------------
>    Which isn't simple enough for a typical user.
Typically the user want to restore the index AND the working directory. 
Comparing typical workflows is more interesting than finding exact 
equivalents.

