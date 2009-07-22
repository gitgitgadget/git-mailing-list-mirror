From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: How has learning the advanced features of git helped you to
 write  software more effectively?
Date: Wed, 22 Jul 2009 18:32:56 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0907221734000.2147@iabervon.org>
References: <e1a5e9a00907221421m27f0f836t98d361dffc7bd87f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-900205663-1248299501=:2147"
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: Tim Harper <timcharper@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 00:33:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTkMy-0006qg-Hx
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 00:33:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149AbZGVWc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 18:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754125AbZGVWc5
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 18:32:57 -0400
Received: from iabervon.org ([66.92.72.58]:39822 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753641AbZGVWc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 18:32:56 -0400
Received: (qmail 10824 invoked by uid 1000); 22 Jul 2009 22:32:56 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Jul 2009 22:32:56 -0000
In-Reply-To: <e1a5e9a00907221421m27f0f836t98d361dffc7bd87f@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Content-ID: <alpine.LNX.2.00.0907221752120.2147@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123807>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-900205663-1248299501=:2147
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LNX.2.00.0907221752121.2147@iabervon.org>

On Wed, 22 Jul 2009, Tim Harper wrote:

> On Wed, Jul 22, 2009 at 3:07 PM, Dmitry Potapov<dpotapov@gmail.com> wrote:
> > On Tue, Jul 21, 2009 at 11:08:31PM -0600, Tim Harper wrote:
> >>
> >> How has mastering the advanced features of git helped you to be a
> >> better programmer?
> >
> > I don't think that features itself make as big difference as the fact
> > Git provides you much more flexibility in choosing a more appropriate
> > workflow than you have with any centralized VCS. (Yes, you will still
> > find many Git features handy even if you work with it as you did with
> > CVS, but you will miss most benefits of Git).
> >
> > To really understand what benefits Git offers, you have to realize first
> > what is wrong CVS and CVS-like VCSes. Unfortunately, it is difficult to
> > explain just in a few words. Some implementation deficiency of CVS is
> > obvious (and it was addressed in some CVS clones like Subversion), but
> > more fundamental problems are far less obvious even for people who used
> > CVS for many years.
> >
> > To be fair to CVS, it is far from the worst VCS. There are some insane
> > lock-based VCS, which were so painful to use (mostly due to these
> > exclusive locks but often due to some other insanity too) that anyone
> > who worked with may think about CVS as a really nice system...
> >
> > In some way, CVS was really revolutionary for its time, because it used
> > the copy-modify-merge paradigm instead of excluding locking, which was
> > dominant before the CVS era. Those exclusive locks not only could not
> > work over the Internet, they were so excruciatingly annoying even if
> > everyone was sitting in the same room... Despite some initial skepticism
> > about essentially the lock-free VCS, I think it is safe to say now that
> > the copy-modify-merge paradigm won. Period.
> >
> > However, if you look at the support of this paradigm in CVS and other
> > centralized VCSes, it is very limited in every aspect:
> > - copy: you can have a copy only one revision. (it may not be a big
> >  issue unless you like to work offline and to look at history).
> > - modify: there is no problem with modification itself, but you cannot
> >  save your changes without committing that to the official repo, which
> >  is not such a good thing if they are not ready yet or were not reviewed
> >  properly.
> > - merge: well.. I don't think there is any sane person who enjoyed
> >  merging branches in CVS... The only merge that was _relatively_ easy
> >  to do was merging your worktree with the upstream. Even that is not
> >  perfect in CVS, because you cannot save your changes before merge. So,
> >  if you made a mistake during 'cvs update', you risk to losing your
> >  work... Also, there is no possibility to review the merge later or to
> >  delegate to someone else when its resolution happens to be tricky...
> >
> > The above limitations have further consequences with negatively affect
> > co-operation among developers. For instance, it is very difficult to
> > organize the review process with any centralized VCS. Typically, a
> > review process may require saving and share your work with reviewer
> > without committing it to the central repo. Also, this work should be
> > split into logical steps to make review easier. The only way to do that
> > with a centralized VCS is to use some patch management system on top of
> > it.... and at that point you may ask whether you want to learn two
> > systems with overlapping functionality and not so well integrated with
> > each other?
> >
> > Another important reason why feature branches are so useful is that they
> > allow to postpone the decision about integration of some feature to the
> > master branch to the time when you convince that it is ready and useful.
> > In a "centralized" workflow, people often commit as they progress to
> > their goal, but some ideas may not so good as they initially appeared.
> > At the time when you realize that, your changes already intervened with
> > other people changes. There is no easy way to remove them cleanly. And,
> > some work even if it is useful may be not ready to the time when you
> > planned to realize a new version. This results in unnecessary delays in
> > release.
> >
> > There are more problems with the "centralized" workflow used by CVS and
> > alike. They may be not very noticeable on small projects, but it tends
> > to get worse as any project growths over time.
> >
> >
> > So, the main advantage of Git is not in the number of features (and Git
> > has plenty of them despite of efforts to limit them to only truly useful
> > for many users), but its conceptual wholeness and flexibility, which
> > allows you to choose the appropriate workflow for your needs.
> >
> >
> > Dmitry
> >
> 
> I agree whole heartedly with you that git is the best SCM in town.
> It's my favorite, and I completely agree that CVS and SVN are
> fundamentally flawed in how they implement branches.  I'm not looking
> for why you should choose git over another tool :)  Let me rephrase
> the question:
> 
> :: QUESTION REPHRASED ::
> 
> Out of the shoot, you get a lot of value learning the basic features
> of git: easy branching, merging, etc.  How has learning the advanced
> features of git (bisect, rebase, rebase -i, add -p, etc.) helped you
> to write software more effectively?

The main benefit I see with advanced personal git usage is that you get an 
idea not only of the state that you've got your code in, but also the 
steps that it goes through to get from one state to another state. Instead 
of just trying to arrange a good state, you're choreographing a good way 
to reach that state. This isn't even particular to writing code, so much 
as constructing an argument or something of that sort.

Another benefit that you get from *other people* using advanced git 
features to produce a clean history is that the history ends up being a 
better explanation of the code than the final state by itself. You can 
find a lot of programming wisdom in the commit messages for the changes 
that modify particular lines of interest; if all of this text were in the 
source file, it would be very interesting, but it would be impossible to 
find the actual code in the middle of it.

	-Daniel
*This .sig left intentionally blank*
--1547844168-900205663-1248299501=:2147--
