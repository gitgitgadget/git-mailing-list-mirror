From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [RFC,PATCH] git-amend -- darcs like amend-record for git
Date: Wed, 3 Mar 2010 11:01:14 +0300
Organization: Marine Bridge & Navigation Systems
Message-ID: <20100303080114.GB2919@tugrik.mns.mnsspb.ru>
References: <1267107365-2973-1-git-send-email-kirr@mns.spb.ru> <be6fef0d1003010116p443985b3ib71f229a1978f831@mail.gmail.com> <20100301170859.GA4142@cthulhu> <1267107365-2973-1-git-send-email-kirr@mns.spb.ru> <be6fef0d1003010116p443985b3ib71f229a1978f831@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>,
	Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Wed Mar 03 09:04:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmjZC-0003x8-TH
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 09:04:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990Ab0CCIEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 03:04:22 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:54990 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753953Ab0CCIEV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 03:04:21 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1NmjYk-000087-3i; Wed, 03 Mar 2010 11:03:58 +0300
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1NmjW6-0000qD-2Z; Wed, 03 Mar 2010 11:01:14 +0300
Content-Disposition: inline
In-Reply-To: <20100301170859.GA4142@cthulhu> <be6fef0d1003010116p443985b3ib71f229a1978f831@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141440>

On Mon, Mar 01, 2010 at 05:16:24PM +0800, Tay Ray Chuan wrote:
> Hi,
> 
> On Thu, Feb 25, 2010 at 10:16 PM, Kirill Smelkov <kirr@mns.spb.ru> wrote:
> > Ever wanted to type `git commit --amend HEAD~3` ? But had to fall back to commit
> > and interactive rebase with fixup? And was tired by a lot of typing? And also
> > rebase works only on clean worktree, so stash save and stash pop have to be
> > used...
> >
> > Forget it.
> >
> > Now one can just do `git add ...` to prepare index, and then
> > `git amend <commit>` to merge that changes from index into <commit>.
> 
> this may be a little late, but I'd like to indicate my interest in
> such a feature.

On Mon, Mar 01, 2010 at 12:08:59PM -0500, Larry D'Anna wrote:
> I like it too.


Tay Ray, Larry, thanks for the feedback.

Now since it's obvious that at least some people need it too, I'll try
to polish it. In the meantime, latest version is always available at

    git://repo.or.cz/git/kirr.git   q/git-amend


But I'm short on spare time, so don't expect something fast...

> A suggestion: I believe this could be better advertised as git-rebase
> --interactive --edit. After all, you do replay the intervening commits
> (which is closer to git-rebase than git-commit).

Thanks.

Yes, I do replay commits, but is it really a rebase? And also as to
--edit thing - amending commits description is very handy, but is really
just a nice artifact :).

What I think is really important (in at least my workflow) is to prepare
changes in index, and then _merge_ them back to HEAD~2, i.e. not the
latest commit.

I don't need this often, but sometimes I do, and in such cases `git
amend` is right tool for the job.

That's why I still think git-amend is maybe a better name.

Though, I've found I'm now less reluctant to improving commit
descriptions as well, and exactly because of that nice --edit artifact
behaviour :)



As to the merging, the only a bit unclear moment to me, is to how
properly handle merge conflicts, when propagating index back to HEAD~2.


Kirill
