From: tactical <a5158017@nepwk.com>
Subject: Re: More Beginning Git Questions
Date: Sun, 25 Sep 2011 03:16:06 +0100
Message-ID: <1wllqv48uqfjq.lt9yp4rbxugb.dlg@40tude.net>
References: <4E7C9AAD.7060209@gmail.com> <m3ipojqhpm.fsf@localhost.localdomain> <4E7CCCA0.50909@gmail.com> <14gm3o851q0ad.1uoossmxgfyit.dlg@40tude.net> <op.v2byz2p80aolir@keputer.lokaal> <1m2c90ds9e46c.7agk88pbgjl8$.dlg@40tude.net> <201109242259.p8OMxqIM026259@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 04:16:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7eGY-0002L9-UU
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 04:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277Ab1IYCQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Sep 2011 22:16:22 -0400
Received: from lo.gmane.org ([80.91.229.12]:58343 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736Ab1IYCQV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2011 22:16:21 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R7eGS-0002KP-B2
	for git@vger.kernel.org; Sun, 25 Sep 2011 04:16:20 +0200
Received: from 31.64.39.2 ([31.64.39.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Sep 2011 04:16:20 +0200
Received: from a5158017 by 31.64.39.2 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Sep 2011 04:16:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 31.64.39.2
User-Agent: 40tude_Dialog/2.0.15.84
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182053>

Seth Robertson wrote:

> As I explained on IRC, you can use the following workflow to create a
> three way merge.
> 
> git stash
> git fetch
> git merge @{u} stash
> git mergetool
> git stash drop
> 
> You can then do whatever other work you want.  You can repeat this
> workflow as often as you want.  When you are done, then you can
> commit:
> 
> git commit -a -m "My important work"
> 
> This is of course easily scriptable so it becomes one command to you.
> And since you mentioned it, if the merge went poorly and you wanted to
> start over (only before you dropped the stash of course), you can:
> 
> git reset --hard HEAD
> git merge @{u} stash

Thanks.  It's a shame, however, that Git makes the user jump through hoops
to achieve such a simple thing.

> Of course, I would recommend you consider some of the more gitish
> workflows.

And that, I feel, is a problem with Git.  In some cases, you can't do
things how you want -- you have to do things how Git wants.

Another example of this is the lack of support for anonymous branching as
part of a normal workflow in Git.  Anonymous branching is very powerful and
very simple.  I use it all the time in Mercurial.

> Commit early and often.  `git pull --rebase` as often as
> you want, and then use `git rebase -i @{u}^` to squash all of your
> in-progress commits together.  With appropriate in-progress commit
> message crafting, you can use the --autosquash functionality of
> git-rebase to make this process easier.

Thanks for the ideas, but they don't solve my particular problem.  The
reason I regularly pull with local changes is that I like to use clones for
short-term branching (because it's powerful and flexible -- for example,
when I create my "TryFeatureX" clone, I have two versions of my project on
disk, and I can run them side by side).

In order to avoid pointless merges, I sometimes don't commit until I've
pulled.  Sure, I could commit and then rebase instead, but, in this
situation, rebasing is effectively merging and committing in one step.
With my workflow, however, after I merge, I can still make changes (and do
other stuff like running unit tests) before finally committing.
