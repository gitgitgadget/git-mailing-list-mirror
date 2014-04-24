From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 2/3] remote-helpers: move out of contrib
Date: Wed, 23 Apr 2014 19:23:50 -0500
Message-ID: <53585996ae447_3c7abff31065@nysa.notmuch>
References: <1398112633-23604-1-git-send-email-felipe.contreras@gmail.com>
 <1398112633-23604-3-git-send-email-felipe.contreras@gmail.com>
 <38F8C9C6-E186-4C42-B3F0-931AE73400FA@quendi.de>
 <5358286ba756e_24448772ec82@nysa.notmuch>
 <EFCABE07-971C-4699-9A03-C5076B3B45ED@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 02:34:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd7cM-0001OJ-1m
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 02:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbaDXAeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 20:34:17 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:45351 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbaDXAeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 20:34:16 -0400
Received: by mail-oa0-f48.google.com with SMTP id m1so1871825oag.35
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 17:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=lBaKCuNjRTi+kYsBC3HDoNtoiHe8jXeqDj1tskBUlvA=;
        b=IgWEjkCh6Squz3Oxjc/AbyCKLTdkU+PpTR+3F4DY9kscyKznFRrbzUvQdTG3CslC2V
         wbW9PFAGGN2IQJNklsHJP6WIKnA3fySpDfibNBIH+AcHa95kAeTrxfx4OPvNLTEXlKMw
         qgZR/eNRSpdsoj/x82kJT5S8m0YkkSZJ5YDqIm0FNFw47CFFyBoYl+W2FWB19MvwHQUG
         5lS8LxzYkJPqwiBrvL4V3F/7+ebzMsi+e+JqtAso9yEf/gw7ZvoZS3kHLhUxgHL875XT
         +aqtcp7eQMIPx7JT/OY+GvK7VdneazifSNM2V1y6BIGNt796wfmZZcepIp9bROYJB/Zp
         Rx7Q==
X-Received: by 10.60.159.36 with SMTP id wz4mr45802956oeb.30.1398299656014;
        Wed, 23 Apr 2014 17:34:16 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id y10sm5080327obk.4.2014.04.23.17.34.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 17:34:14 -0700 (PDT)
In-Reply-To: <EFCABE07-971C-4699-9A03-C5076B3B45ED@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246912>

Max Horn wrote:
> On 23.04.2014, at 22:54, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> > Max Horn wrote:
> >> On 21.04.2014, at 22:37, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> >> 
> >>> The remote-helpers in contrib/remote-helpers have proved to work, be
> >>> reliable, and stable. It's time to move them out of contrib, and be
> >>> distributed by default.
> >> 
> >> Really? While I agree that git-remote-hg by now works quite well for basic
> >> usage in simple situation, there are still unresolved bugs and fundamental
> >> issues with it.
> > 
> > s/basic usage in simple situation/complex usage in the vast majority of situations/
> 
> Yeah, hm, no. We can agree to disagree, I guess.

Right, except one of us has evidence to back this up:

* There hasn't been a single person coming to the Git mailing (or git-fc's
  bugtracker) reporting that they haven't been able to do something. This means
  if there's any situation where git-remote-hg doesn't work well, it hasn't
  been reported, and therefore the reasonable thing to assume is that if there
  are any, they are marginal at best.

> It might also depend on what you call "basic" or "complex" usage...
> 
> For example, whenever I need to
> - close a branch
> - fix a branch with multiple heads
> - deal with phases
> I need to switch to hg. I am pretty sure there are more things that make
> that necessary, but luckily they don't happen to me.

The fact that there are complex things you can't do, doesn't mean there isn't
any complex usage supported at all.

> Out of curiosity: How do you yourself use git-remote-hg in your daily work?

I don't.

> But I am worried about people hitting the edge cases where it does not quite
> work -- and then people are lost.

And which people are those? Are they imaginary by any chance?

> This is what concerns me -- and this concern would be alleviate if there was
> a list of known things that do not work (and perhaps cannot work, at least
> for now, due to fundamental differences between hg and git which need major
> work to bridge over).

That list is empty at the moment, because again, nobody has come reporting
anything they cannot do.

The things that have been reported, I've fixed.

> Anyway, despite my criticism, I'd like to emphasis that I am actually quite
> happy and grateful that your git-remote-hg exists and that you continue
> improving it and the surrounding infrastructure. I just wish you could do it
> while not acting like an asshole most of the time, but I'll survive that,
> too *shrug*.

I am being straight-forward, not an asshole.

If *you* have issues, why don't *you* list them? The people that have reported
anything back about git-remote-hg/bzr, have reported success, or their issue
was resolved. Even better would be if *you* fixed the issues you have.

> >> E.g. I recently showed you a reproducible use case involving git-remote-hg
> >> that puts the helper into a broken state from which it is difficult for a
> >> normal user to recover. Namely when a hg branch has multiple heads, then
> >> git-remote-hg exports all of those to git, but only adds a git ref for one of
> >> them; after pruning unreferenced commits, the fast-import marks file
> >> references git commits that now are missing, prompting git fast-import to
> >> crash and trash the marks file. Afterwards, attempts to push or pull from the
> >> remote hg repository are answered with an error.
> > 
> > Yes, and how often does that happen? A normal user would only see this if a
> > branch remains with multiple heads in Mercurial for more than one month or so.
> 
> There are projects who do exactly that, although I believe most of them use
> bookmarks, so the issue should indeed not affect those. Anyway, they do the
> wrong thing ;-). Still, if you are forced with such a repository, it's not
> very helpful to be told that this is your own fault...

Nobody said it's their fault, what I'm saying is that those people don't exist,
or haven't bothered to report such issues.
 
> But this kind of issue also happens in any other scenario were heads are not
> mapped to a git reference.

And where is that?

> At the very least, it also happens for closed hg branches. These are quite
> common, and I also run into that in real life.

If a branch is closed, it's ignored by git-remote-hg, so that doesn't cause a
problem. If there's any scenario where it would be a problem, it's certain more
complex than having a closed branch.

> [And to reply to a claim you made in another mail: No, I am not deliberately
> "hoarding" issues to make you look bad. But analyzing a breakage you run into
> and then properly writing it up takes time; and when you know you will likely
> be insulted when reporting it doesn't really help to motivate me to sit
> down and do that...]

Show me exactly where anybody did insult you for reporting an issue.

> > In practice that's very unlikely, and proof of that is that nobody has reported
> > such issues.
> 
> No, that logic is flawed. For example, It could also mean that not many
> people are using the tool, and of those not many bother to report issues via
> your github bug tracker.

Yes, it could mean that as well, if that's your contention then it doesn't
matter either; most people are not being affected.

> >> There are more issues related to unresolved clashes between the git and hg
> >> ways of naming things. E.g. I am collaborating on a hg repository that has
> >> branches "foo" and "foo/bar" which git-remote-hg cannot handle because it
> >> translates them to git branch names, and, well, git cannot handle that.
> > 
> > I don't see this as a limitation of git-remote-hg, ideally Git remote-helpers
> > should have a standardized way to let users map external branch names.
> 
> Agreed. But in the meantime, I think users should still be warned about it.
> Or perhaps git-remote-hg could detect this and print a more helpful message
> that tells the user what is wrong...?

Yes, the tool could do that, but that is not something that should prevent the
move out of contrib, so it's not relevant for $subject.

> >> It may be hard to deal with some of them, and admittedly I wouldn't
> >> necessarily expect that all of these are handled from the outset, i.e. "in
> >> version 1.0". But I think at the very least, users should be warned about
> >> these things.
> >> 
> >> More broadly speaking, there is currently no documentation at all in git.git
> >> for those remote helpers, which I find worrisome.
> > 
> > Here is the documentation:
> > https://github.com/felipec/git/wiki/git-remote-hg
> > https://github.com/felipec/git/wiki/git-remote-hg
> 
> [I assume you meant one of the links to be for -bzr; but your point is clear in any case].
> 
> Great! But my point was not that there is no documentation, rather that
> there is none in the git repository. Since you already have some
> documentation, this should be easy enough to resolve; e.g. for starters,
> those links could be included in the repository. Though I think that if the
> helpers are moved out of contrib, they'd deserve a proper help page.

Yes, it should be trivial to copy that documentation. This is not a
make-or-break point against the move.

> >> That said, I don't know what the criteria are for moving something out of
> >> contrib. Perhaps it is OK to move an undocumented remote-helper with known
> >> bugs out of contrib.
> > 
> > There are no known bugs. This is the list of open bugs:
> > 
> > https://github.com/felipec/git/issues
> 
> At the time of writing, I was not aware that you had fixed the bug with the
> marks file getting trashed. I did not yet have a chance to test your fix,
> but I trust it works, so yeah, that resolve that. Excellent, thanks.
> 
> So, for now, there are just some "known limitations", but that's fine, I
> guess.
> 
> Note that there are more limitations than those I listed above; not because
> I want to "hoard" them, but because it seems rather trivial to come up with
> those if one thinks about it for 5 minutes, so I simply assume(d?) you are
> aware of most of them. Here's what I can think of right now; this still may
> not be complete; nor do I mean to say those should hold up anything; I merely
> want to get them out to prevent any future accusations about "hoarding"
> stuff)
> 
> - close hg branches cannot be referenced from git, and thus not easily
>   reopened (at least not from their old tip)

Easy to fix: closed-branches/$name, or only
refs/hg/$remote/closed-branches/$name.

Hardly an issue. Nobody has reported this.

> - multiple tips/heads of a hg branch cannot be referenced; only a single
>   "random" head (in the sense that it is not documented how it is chosen)
>   is visible

Not random, the tip of the branch.

And who cares?

> - more name clashes, e.g. the somewhat hypothetical case of having a hg
>   branch "foo" and a hg bookmark "branches/foo"

Very important (not).

> - renaming remotes is a bit problematic (this is IMHO a shortcoming of the
>   remote helpers interface, not of git-remote-{hg,bzr}). I.e. it
>   can result in commits being re-exported, and hence in diverging history.

That's not true. That's an issue of gitifyhg, not git-remote-hg.

> - Not sure if this is still a problem, but I was seeing some issues when
>   a hg remote pruned some commits. Of course this is a bad thing to do in
>   the first place, but sadly it sometimes happens. IIRC this resulted in a
>   truncated marks file (which, as I understand, should be fixed already),
>   but I am a bit fuzzy on the details (it was quite some time ago, and since
>   something bad and exceptional was done on the hg side, I didn't bother to
>   look closer at it.

I don't see how that could be of any issue issue since the mark files have been
updated.

I don't see how any of these should prevent the move out of contrib, so how is
that relevant to the $subject? Most of these are so marginal that I wouldn't
even bother documenting them. Maybe making a list as a to-consider, or
to-think-about-fixing-later would make sense, but with the exception of closed
branches and foo vs foo/bar, I don't see much point in worrying about these
myself. Of course patches are welcome.

-- 
Felipe Contreras
