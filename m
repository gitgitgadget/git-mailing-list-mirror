From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Diffing submodule does not yield complete logs for merge commits
Date: Tue, 2 Jun 2015 14:02:15 +0200
Message-ID: <20150602120214.GA7498@book.hvoigt.net>
References: <20150518123036.GB16841@book.hvoigt.net>
 <CAHd499CETM2jmZ2iJk=AoXtjLUCQ==u6q9Z5P-3EVGSY48FY_A@mail.gmail.com>
 <20150519104413.GA17458@book.hvoigt.net>
 <CAHd499D9vOtLOBj2s5EOfsojSStZY+HdZR35icZ5cssLNkcD-A@mail.gmail.com>
 <20150521125122.GA22553@book.hvoigt.net>
 <55691DE3.70200@gmail.com>
 <xmqqbnh2ateo.fsf@gitster.dls.corp.google.com>
 <CAHd499B+icDskcsR7zxPfZ=8Nqwg14eb2h2LBuDx6=fnoO24AQ@mail.gmail.com>
 <xmqq382dc043.fsf@gitster.dls.corp.google.com>
 <CAHd499CQb0ubfRKbaKC6Ypitq4e2ChXmTpGbKDyCVv=nrsJj=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 14:02:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzktY-0007MF-Ou
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 14:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754399AbbFBMCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 08:02:08 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.96]:55625 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754508AbbFBMCG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 08:02:06 -0400
Received: from [31.17.191.210] (helo=book.hvoigt.net)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1YzktN-0005qy-CU; Tue, 02 Jun 2015 14:02:01 +0200
Content-Disposition: inline
In-Reply-To: <CAHd499CQb0ubfRKbaKC6Ypitq4e2ChXmTpGbKDyCVv=nrsJj=g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270527>

On Sat, May 30, 2015 at 03:25:31PM -0500, Robert Dailey wrote:
> On Sat, May 30, 2015 at 2:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Robert Dailey <rcdailey.lists@gmail.com> writes:
> >
> >> On Sat, May 30, 2015 at 12:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >>> Robert Dailey <rcdailey.lists@gmail.com> writes:
> >>>
> >>>> In the meantime I'd like to ask, do we even need to add an option for
> >>>> this? What if we just make `diff.submodule log` not use
> >>>> --first-parent? This seems like a backward compatible change in of
> >>>> itself.
> >>>
> >>> Why?  People have relied on submodule-log not to include all the
> >>> noise coming from individual commits on side branches and instead
> >>> appreciated seeing only the overview by merges of side branch topics
> >>> being listed---why is regressing the system to inconvenience these
> >>> existing users "a backward compatible change"?
> >>
> >> Backward compatible in the sense that it does not break existing
> >> functionality....
> >
> > And adding one-line-per-commit from side branches does break
> > existing functionality.  You seem to be arguing that more
> > information is always good and does not break existing
> > functionality, but summarizing by omitting irrelevant details *is* a
> > feature.  Do you honestly believe that a change to make the full
> > "log -p" output in submodule log be a "backward compatible" change??
> >
> >>     > Merge branch "topic1" into "master"
> >>     > Merge branch "topic2" into "master"
> >>     > Merge branch "origin/develop" into "master"
> >>     > Merge branch "topic3" into "master"
> >
> > It is not a real argument; it is something you can fix by naming
> > your branches more sensibly, which would make you a better developer
> > regardless of how submodule-log is shown.
> 
> I just use git, I don't have the deep technical understanding of its
> implementation as you may have. From my perspective I can't think of
> how this breaks backward compatibility, or perhaps your definition of
> backward compatibility does not align with mine.

Yes from your perspective and thats the only thing what Junio is
criticising: Others might have a different perspective and thats why
this change is not backwards compatible in a general sense. For you it
might be but git is a very general tool.

> And please don't over generalize and misconvey what I said. I am not
> saying more information is always good. Did you not read anything I
> wrote?

I do not see where Junio did that. The only thing he was trying to do is
give an example why changing the default is not backwards compatible.

> Also good branch names may help but that doesn't go into detail and
> explain features that may have been sitting on a topic branch for
> weeks. That's not a practical solution to the problem. Also branch
> names do not determine or influence the skill and quality of a
> developer, as you seem to imply.

Many people use the feature branch name as a kind of headline for the
topic. So in that sense it explains or at least gives a hint what that
feature was about. E.g. if you have the roadmap of a library you are
using in mind and want to know whether the update you are about to
commit contains a certain feature you were waiting for, that headline
can be enough.

You are right: Good commit messages and general naming does
functionality wise not determine your development skills in the short
term. On the other hand: In my experience good naming skills usually
align with good development skills. Long term it also means that your
code (and history) is easier to understand once others want to read your
code and build on it.

> I'll do us both a favor and end the discussion here, as I do not feel
> you are being very patient or welcoming in the discussion. I sense
> frustration on your side.

This is a typical situation which can happen in textual communication.
You read something which is not there. A thing that happened to me as
well when I submitted my first patch on a mailing list. But when I read
the conversation years later I realized it was not really that offending
as I experienced it. A general rule: People automatically appreciate
what you do when they criticise to you. Criticism means that you have
done something good (and worth criticising) but they want to make it
better. I think viewing it that way helps to not take arguments
personally.

> >>>> And it's simpler to implement. I can't think of a good
> >>>> justification to add more settings to an already hugely complex
> >>>> configuration scheme for such a minor difference in behavior.
> >>>
> >>> Careful, as that argument can cut both ways.  If it is so a minor
> >>> difference in behaviour, perhaps we can do without not just an
> >>> option but a feature to omit --first-parent here.  That would be
> >>> even simpler to implement, as you do not have to do anything.
> >>
> >> I don't really understand your contrasted example here. Can you explain:
> >>
> >>     "...we can do without not just an option but a feature to omit
> >> --first-parent..."
> >
> > I am not sure how to phrase that any easier. Sorry.
> 
> You mean you don't want to? That's fine, if you don't have the will or
> patience to explain then I won't bother caring.

And the rephrase follows...

> > Assuming that you consider output with and without --first-parent
> > does not make much of a difference (i.e. "minor difference in
> > behaviour"), instead of dropping --first-parent unconditionally,
> > like you seem to be pushing with the argument, we can
> > unconditionally keep the --first-parent and do not change anything.
> > The end result would not make much of a difference either way, and
> > not doing anything is much simpler than dropping --first-parent.
> >
> > Hopefully you can see how absurd that line of reasoning is.  So do
> > not make the same argument to push for changing the behaviour
> > unconditionally.
> >
> > If you think the new behaviour can help _some_ users, then you would
> > need the feature and a knob to enable it.
> 
> First of all, you keep calling this an argument. Perhaps it is for
> you, since you're being absurdly rude with me and impatient with the
> discussion. This is a brainstorming session. My suggestions may not
> seem rational or make sense, but this is natural since I am ignorant
> of the finer details of the application.
> 
> You're really just overanalyzing my statements from a nonsensical
> perspective. I am talking about not adding more settings to an already
> complex set of settings. I am not justifying my feature. I think the
> feature is just as justified as everything else. Git is FULL of tons
> of little options to cater to niche workflows.
> 
> I am not fighting against having another option. In fact, that was my
> idea to begin with. I am investigating and trying to discuss all
> possible approaches and perspectives.

Junios argument is quite absurd, but that is just to prove why we need
another option, nothing else. See above...

> Your attitude is not very welcoming to those that wish to contribute
> to the project. In fact, because of your attitude towards me, I will
> kindly see myself out. I do not have time to spend my free time
> dealing with this nonsense and irrational rudeness on a mailing list.
> 
> Thanks to Heiko and others that were more welcoming and kind.

I hope you reread this conversation more calmly and come to the same
realisation as me with my first patch. But opposed to me, maybe continue
to stay with the project.

Cheers Heiko
