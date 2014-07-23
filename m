From: Ross Boylan <ross@biostat.ucsf.edu>
Subject: Re: confused about remote branch management
Date: Wed, 23 Jul 2014 12:22:16 -0700
Message-ID: <1406143336.29001.185.camel@localhost>
References: <1406083743.29001.139.camel@localhost>
	 <53CF66D4.7060201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 21:22:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA27K-0000sv-T0
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 21:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932892AbaGWTWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 15:22:19 -0400
Received: from upstrm185.psg-ucsf.org ([38.99.193.74]:43886 "EHLO
	biostat.ucsf.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932735AbaGWTWS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 15:22:18 -0400
Received: from ns204-a-650ts.psg.net ([10.0.2.3]:33006 helo=[192.168.40.102])
	by biostat.ucsf.edu with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <ross@biostat.ucsf.edu>)
	id 1XA27C-0000Jz-43; Wed, 23 Jul 2014 12:22:14 -0700
In-Reply-To: <53CF66D4.7060201@gmail.com>
X-Mailer: Evolution 3.4.4-3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254111>

I still don't know what I need to do to update origin/master in my local
repo.

Regarding Kevin's suggestion, I just tried "git fetch origin master".
It seems to have made no difference, at least judging by git show
origin/master.  I'm assuming the commit it show is  the head of the
branch.

For reasons given below, Chris's theory that there was a conflict also
doesn't seem to apply.

On Wed, 2014-07-23 at 19:40 +1200, Chris Packham wrote:
> On 23/07/14 14:49, Ross Boylan wrote:
> > My local master branch is the result of a merge of upstream master and
> > some local changes.  I want to merge in more recent upstream work.
> > git pull doesn't seem to have updated origin/master, and git checkout
> > origin/master also doesn't seem to work.
> > 
> > Here's some info that may be relevant.
> > 
> > 
> > ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git remote -v
> > origin	https://github.com/emacs-ess/ESS.git (fetch)
> > origin	https://github.com/emacs-ess/ESS.git (push)
> > personal	https://github.com/RossBoylan/ESS.git (fetch)
> > personal	https://github.com/RossBoylan/ESS.git (push)
> > # I think I originally cloned from what is now the "personal" remote
> > # and switched names later so origin refers to upstream.
> > ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git branch -v
> > * master 8fa569c [ahead 340] merge from origin
> > # 340 ahead of personal is plausible, but ahead from origin seems odd
> > ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git --version
> > git version 1.7.10.4
> > ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git branch -a
> > * master
> >   remotes/origin/S+eldoc
> >   remotes/origin/gretl
> >   remotes/origin/linewise_callbacks
> >   remotes/origin/litprog
> >   remotes/origin/master
> >   remotes/origin/transmissions
> >   remotes/personal/HEAD -> personal/master
> >   remotes/personal/S+eldoc
> >   remotes/personal/gretl
> >   remotes/personal/linewise_callbacks
> >   remotes/personal/litprog
> >   remotes/personal/master
> >   remotes/personal/transmissions
> > ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git status
> > # On branch master
> > # Your branch is ahead of 'personal/master' by 340 commits.
> > #
> > nothing to commit (working directory clean)
> > ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git checkout origin/master
> > Note: checking out 'origin/master'.
> > 
> > You are in 'detached HEAD' state. You can look around, make experimental
> > changes and commit them, and you can discard any commits you make in
> > this
> > state without impacting any branches by performing another checkout.
> > 
> > If you want to create a new branch to retain commits you create, you may
> > do so (now or later) by using -b with the checkout command again.
> > Example:
> > 
> >   git checkout -b new_branch_name
> > 
> > HEAD is now at a33a2f9... Merge branch 'trunk'
> > ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git checkout master
> > Previous HEAD position was a33a2f9... Merge branch 'trunk'
> > Switched to branch 'master'
> > ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git pull origin master
> > # [messages]
> > Not committing merge; use 'git commit' to complete the merge.
> 
> I think this is the relevant message. By doing a git pull you are asking
> to merge the branch 'master' from the remote 'origin' into the current
> branch (which happens to also be called 'master').
> 
> What I'm guessing is in "# [messages]" is something about a merge
> conflict that needs resolving before the merge can be completed. There
> are various ways to resolve the conflict but probably the easiest would be
Here are the full deleted messages:
remote: Counting objects: 388, done.        
remote: Compressing objects: 100% (159/159), done.        
remote: Total 356 (delta 257), reused 289 (delta 190)        
Receiving objects: 100% (356/356), 59.99 KiB, done.
Resolving deltas: 100% (257/257), completed with 29 local objects.
From https://github.com/emacs-ess/ESS
 * branch            master     -> FETCH_HEAD
error: Terminal is dumb, but EDITOR unset
Not committing merge; use 'git commit' to complete the merge.

So the lack of commit was not from a conflict, just it didn't know how
to bring up an editor (I was in a bash  session under emacs).

[snip discussion of merging]
> 
> 
> > ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git status
> > # On branch master
> > # Changes to be committed:
> > # [long list]
The list had only modified and added files; no conflicts.

Ross

> > ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git show origin/master
> > commit a33a2f9e06185a225af7d72ea3896cfd260e455e
> > Merge: 136742f 6b22a88
> > Author: Vitalie Spinu <spinuvit@gmail.com>
> > Date:   Mon Jan 20 00:43:30 2014 -0800
> > 
> >     Merge branch 'trunk'
> > # this was the head of origin/master BEFORE I did the pull.
> > # I think this means it has not been updated.
> > ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git commit -m "merge in
> > upstream, probably fe7d609..8fa569c"
> > [master 59f6841] merge in upstream, probably fe7d609..8fa569c
> > ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git show origin/master -v
> > # no change
