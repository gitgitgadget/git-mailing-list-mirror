From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Mon, 1 Jan 2007 00:19:45 -0800 (PST)
Message-ID: <997672.38239.qm@web31814.mail.mud.yahoo.com>
References: <7vfyav8ae1.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Mon Jan 01 09:20:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1IOl-0001D0-U5
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 09:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933259AbXAAITs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 03:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933258AbXAAITs
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 03:19:48 -0500
Received: from web31814.mail.mud.yahoo.com ([68.142.206.167]:31286 "HELO
	web31814.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933256AbXAAITq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jan 2007 03:19:46 -0500
Received: (qmail 38973 invoked by uid 60001); 1 Jan 2007 08:19:46 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=bRESVMTv0Liw32FcMUNS1tptPXwY5qxPl6q+O9tzMKFaDFg5wRqdU5XtboA9UK2CYY7qWu87Cs0LrstmMOnjeVilXd6elinQCMfkSNAT/CxKMdBRan6lJCFsFlCGUBeO00xY+ulbKBPbpZOgqMbnGqgpBUEIHZdp87cF/z+9Hj0=;
X-YMail-OSG: q6wJ758VM1lk74bCemPYuyKkJ5H5ZS8ICiRExRwK1fQB6Ou6tGrqzUlMMa0j2oJgSl0jOGvb._IgaJm5NUIZ3dwflFk1ErljAlq8gpdRRYW6ayjmprZQNFl3mRQoj_.tMKkEA9lyHsYp0NoK5hmBQ978unuSgRXhbUXUQFf5ynM8kiTcwhkdAFiK
Received: from [71.84.31.238] by web31814.mail.mud.yahoo.com via HTTP; Mon, 01 Jan 2007 00:19:45 PST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyav8ae1.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35733>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > --- "J. Bruce Fields" <bfields@fieldses.org> wrote:
> > ...
> >> Could you explain a situation where this would be useful?
> >
> > I don't know how to respond to this question.
> >
> >>  A
> >> "parent<-->child" relationship, where there's one upstream branch that
> >> is always merged in, is easily handled;
> >
> > e is the base of natural logarithms.
> 
> You lost me here; I am guessing this is some sarcasm not worth
> paying attention to, so I'd ignore this part for now.

Absolutely correct. I just needed to respond to an obvious fact with
another obvious fact.

> >> just replace your "git pull parent" by a "git pull", right?
> >
> > Yes, but I don't want to just type "git-pull", I want to explicitly
> > type "git-pull parent" and depending in which branch I'm at, "parent"
> > would have identical meaning but would merge a different branch... because
> > I'm in a different branch...
> >
> >> Am I misunderstanding the proposal?
> >
> > I did give an example of usage in my email to which you replied.
> 
> But what confuses me (and I think JBF shares the same confusion
> with me) is that you had only one example "parent".

More complicated and exotic examples exist.  See my response
to JBF, which I just posted a moment ago.

> While I understand that it would make sense to define "parent"

No, no, no.  Forget about the semantic attibute of "parent".
I could've called it "xyz" for that matter.

What I'm talking about is the concept of "branch spec".  It
is a well known concept in SCMs.

We currently implement it, in git specific way, for remotes/
only, but not for local ("topic") branches.

Another way to look at it is that a Topic, can have many
other self-contained sub-Topics, each one building on the one
"before" it, extending it, yet introducing new functionality,
and only in the "leaf" branch, do you get a fully capable software.
Each sub-topic branch is also a working software but only implements
part of the functionality of your product and/or toned down version
of it, say if someone doesn't want support for feature ABC, which
uses 100MiB of memory...

> for each branch in a downstream developer's workflow, (1) I do
> not see the difference between your wording, "parent", and what
> we traditionally have called "origin",

I've always contended that it is the same and had mentioned
that it is only implemented for remotes/.

> and (2) I do not think of
> relationship other than "parent" ("origin") that is applicable
> commonly (in other words, "worth having your 'symbolic'
> mechanism for, because it is so commonly applicable") to
> branches offhand.  Hence, JBF's suggestion to use "git pull"
> without using noiseword "parent" or "origin" feels very natural
> to me --- if there can be only one valid thing to say, why do
> you even have to say it?

Well, this is the question...  Can you stipulate that there is
only _one_ valid thing to say?  Wouldn't it be easier to generalize
the concept of "branch spec" to local "topic" branches as we do
now for remotes/.  Wouldn't this allow people to have more freedom
at what and how they'd like to set their software dependencies?

The SCM industry seem to have generalized this with the
concept of a "branch spec".

> Because I do not understand what you would want "parent" for and
> why "git pull" is not sufficient,

Because it _implicitly_ defines the relationship.  Nothing wrong
with that, but also allowing an explicit naming of the relationship,
as is currently done for remotes/, would give git much, much more
power to define even the most complicated software development
setup (locally).

As I pointed out before, "branch.<name>..{fetch,merge}" would
cover the "git-pull" case.  "branch..<symbolic-ref>.{fetch,merge}"
should be illegal since it is the same as remotes/, and
"branch.<name>.<symbolic-ref>.{fetch, merge}" matches
"git-pull <symbolic-ref>".

> I cannot tell if this would
> help solving what you are trying to solve in a different way,

1) It would help solve it the proper way and,
2) it would give git the concept of "branch spec" universally, i.e.
local branches as well as remotes.

> but I suspect a useful thing to have might be a per-branch
> alias.  For example, we could allow "git merge" without
> parameters to alias to "git merge origin/next" when you are on
> your 'next' and the same "git merge" could be aliased to "git
> merge origin/master" when you are on your 'master'.

Any why not solve the absolute general case forever, by
implementing what I have described above, and move on
to more interesting things?

     Luben
