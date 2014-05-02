From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Pull is Mostly Evil
Date: Fri, 02 May 2014 11:13:49 -0700
Message-ID: <xmqqoazgaw0y.fsf@gitster.dls.corp.google.com>
References: <5363BB9F.40102@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri May 02 20:14:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgHyB-0006QO-Gh
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 20:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbaEBSNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 14:13:55 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59176 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751501AbaEBSNy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 14:13:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1543210EEE;
	Fri,  2 May 2014 14:13:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+GCCuVYPWCMw1GHFNyP6mPoqBRk=; b=FOz7Oy
	sPMogUbD/dsU+VHWamOX+fJV1XoX0upHXLDUq5Mfs/q1Er6uVPYTbTHLK0XkWsa/
	qcmzKgCepGNwqR00twEYO8u2F9fFdAHwIOR/UCuwBERNh1dxTF+yLI8e3D9wJyhT
	QNyeiUellRYMTmh/NqzU2CsZIx7QLbW04qvUM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=POfwlwmnECPJ052vcQhl3EtaX4gZ3lcp
	dqC8/I73GIAFbc7WdY9xoaUDzG+dqz1ukvHFaE2fBHc0YV9hSeQl5pb7NRQpgHGE
	0tgmgogJ8bgnGdPrx5MtFVu/AjYWlo770wTKFP3EnPlS2kDDnEjc9QCgEOO/nMX7
	lHFnM3kB+zE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0B5A510EED;
	Fri,  2 May 2014 14:13:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 840C010EEA;
	Fri,  2 May 2014 14:13:51 -0400 (EDT)
In-Reply-To: <5363BB9F.40102@xiplink.com> (Marc Branchaud's message of "Fri,
	02 May 2014 11:37:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 83A53CAE-D225-11E3-9C27-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247948>

Marc Branchaud <marcnarc@xiplink.com> writes:

> (Apologies for not CCing all the folks who've participated in the "Pull is
> Evil" thread -- I couldn't find a good branch of that thread for this message.)
>
> OK, so maybe "git pull" is just Mostly Evil.  People seem to have found many
> different ways to make it work for them.
>
> But in reality "git pull" has become a chimera that confuses a large number
> of new users, and that experienced users either avoid entirely or customize
> to give them a convenient shorthand for working in their particular
> environment.  As a tool for new git users, it just doesn't seem to be
> achieving its goals.
>
> I think the git project as a whole would benefit if it started to treat "git
> pull" as an advanced command, in the sense that it needs to be configured by
> an experienced user in order to make it correctly follow a project's
> workflow.  Once it's configured properly, "git pull" is a powerful tool that
> gives users an easy way to do complex things.  In that sense, it may be
> appropriate for a project to tailor "git pull" as it likes, then teach its
> own users to use the command.
>
> However, when it comes to teaching people how to use git qua git, "git pull"
> should be the last thing they learn about, because it's only after you
> understand various basic git concepts that you can configure "git pull" to do
> the right thing.
>
> To that end, I suggest that pull's default behaviour should be to do
> *nothing*.  It should just print out a message to the effect that it hasn't
> been configured, and that the user should run "git help pull" for guidance.
>
> It'll take quite a bit of time, but I think that if we change our attitude
> towards "git pull" and take this unconfigured-by-default approach, then in a
> few years the entire git ecosystem will be in a better place.

Your earlier long-hand, together with the two examples that pulls
into the same "maint" branch Brian gave us, may give us a better
starting points to think about a saner way.

To me, the problem sounds like:

    Tutorials of Git often says "use 'git pull' to catch up your
    branch with your upstream work and then 'git push' back" (and
    worse yet, 'git push' that does not fast-forward suggests doing
    so), but 'git pull' that creates a merge in a wrong direction is
    not the right thing for many people.

And proposed solutions range from "let's write 'pull' off as a
failed experiment" to "let's forbid any merge made by use of 'pull'
by default, because it is likely that merge may be in reverse".

Let's look at Brian's examples, which may point at a good direction.

When he becomes in charge of producing a new 'maint' (in his
original, he says 'maintenance-branch'), he first does this:

    $ git checkout maint
    $ git pull --ff-only [ origin maint ]

He may have a stale 'maint' branch for a variety of reasons.  He may
have been the pumpking in the past, worked on his local 'maint' to
advance its tip with merges in the right direction and pushed the
result out to the central repository when he was done, and kept that
then-current 'maint' in his repository without removing when he
passed the pumpkin to somebody else.  As you said in the thread,
this could have been done on a detached head, but keeping the local
branch around is more convenient (you may want to do a disconnected
development and having a reference point is handy).  Or he may be
the long-term pumpking for 'maint' branch, but is working on a
machine different from the one he updated the shared 'maint' the
last time.

In either case, what is most important for this 'pull' is that he is
catching up with today's central repository, without losing any old
work that he forgot to push out when he was playing the pumpking the
last time (hence --ff-only to cause it to fail if that is the case)
in this local repository.

Then he integrates a topic by another and push the result with:

    $ git pull [--no-ff] developer-remote topic-branch
    $ git push [ origin maint ]

For this 'pull', he knows that this may not fast-forward (the
$DAYJOB convention to use a real merge even when the merge
fast-forwards is optional).

Even with the proposed "pull.mode" or "branch.maint.pullmode", these
two 'pull' cannot be given a convenient default.  The best we can do
with the approach is to set pull.mode to ff-only for safety to protect
his first 'pull' from the origin/maint, and have him remember to
override it from the command line with "--merge --no-ff" [*1*].

If we step back a bit, because we are forcing him to differentiate
these two pulls in his mental model anyway, perhaps it may help
people (both new and old) if we had a new command to make the
distinction stand out more.  What if the command sequence were like
this instead?

    $ git checkout maint
    $ git update [ origin maint ]

    $ git pull [--no-ff] developer-remote topic-branch
    $ git push [ origin maint ]

where the new command 'update' enforces the '--ff-only' update.  And
then we would stop telling "'git pull' first" when a push does not
fast-forward.

Stepping back even further, and thinking what is different between
these two pulls, we notice that the first one is pulling from the
place we push back to.  Perhaps a way to solve this issue, without
having to introduce a new 'git update' and updating the tutorials,
may be disallow fetch+merge by default only when pulling from the
place the result is going to be pushed back to?  That is one case in
which it is very clear that we are making a merge in the wrong
direction.  When you are pulling from developer-remote that is not
where you are going to push back, is there a reason to forbid a
non-ff pull from creating a merge?

Also I think what you said in a separate subthread merits more
thought:

    What's more, it seems to me that the only real advantage "git
    pull" provides here is a less typing compared to the non-pull
    equivalent:

      git fetch main-repo
      git checkout main-repo/maintenance-branch
      git fetch developer-remote
      git merge --no-ff developer-remote/topic-branch
      git push main-repo HEAD

    I suggest that this approach is superior for new users (despite
    the increased risk of finger cramps), because if main-repo's
    maintenance-branch is updated in the interim and the push fails,
    the user can use the exact same commands to resolve the
    situation.

I very much like the "you can easily tell the new person to redo the
whole thing when the last push does not fast-forwareed" aspect of
this approach.  Maybe a good alternative may be to encapsulate this
sequence to a handy "git update" (which is *NOT* the one I suggested
off-the-cuff in the above to replace the first 'git pull' in Brian's
example---it is more for the second one) wrapper and promote the use
of that in our tutorials.  Perhaps:

    $ git checkout maint
    $ git update developer-remote topic-branch
    $ git push [ origin maint ]

that tells us to fast-forward update the current branch (maint) from
its upstream (origin), fetch the developer's work and merge it.
When the last 'push' does not fast-forward, that has to be because
somebody else pushed (because we already made it up-to-date), so the
second time around, "git update" that notices that it cannot
fast-forward can offer to recreate the merge (or any further work
done since the local 'maint' diverged from the origin/maint), before
redoing the "git pull developer-remote topic-branch" phase.

A hypothetical transcript might go like this.

    $ git checkout maint
    $ git update developer-remote topic-branch
       ... does a rough equivalent of
       $ git pull --ff-only [ origin maint ]
       $ git pull [--no-ff] developer-remote topic-branch
    $ git push [ origin maint ]
    error: the push does not fast-forward.  "git update" before
    error: attempting to push again.

    $ git update
      ... internally does:
      $ git pull --ff-only [ origin maint ]
      ... which fails due to --ff-only
    info: You have some local work made on an old version of
    info: origin/maint.  Let's rebuild it on top of the latest.
      ... does a rough equivalent of
      $ git rebase --preserve-merges origin/maint

    $ git push [ origin maint ]
    ... this time it succeeds.

Note that this would also support, without any change, those who
build their own changes directly on top of their 'master' and push
the result back to the shared 'master'.

And to guard new people who type 'pull' when they meant 'update', 
we can notice if the pull is coming from the same place origin/maint
we will push back to.

Hmm?


[Footnote]

*1* I do not think it is *wrong* to say "we won't differentiate
    these two modes; if somebody pulls into the same branch this
    way, he is an integrator and should know better than newbies who
    gets harmed by a merge in the wrong direction" and stop our
    effort at this point.  I would say that is perfectly a valid
    position to take, as long as it is clearly documented: in order
    to help majority of new people, experienced ones are asked to do
    X and Y that they did not have to.
