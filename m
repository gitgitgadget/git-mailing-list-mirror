From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git 1.0 Synopis (Draft v4)
Date: Tue, 16 Aug 2005 00:28:00 -0700
Message-ID: <7vy872fiin.fsf@assigned-by-dhcp.cox.net>
References: <20050729082941.GD32263@mythryan2.michonline.com>
	<200507312215.j6VMFeqn030963@laptop11.inf.utfsm.cl>
	<20050815045546.GA7001@mythryan2.michonline.com>
	<7vr7cv7p61.fsf@assigned-by-dhcp.cox.net>
	<20050815065833.GE7001@mythryan2.michonline.com>
	<7v7jen6545.fsf@assigned-by-dhcp.cox.net>
	<20050815080218.GG7001@mythryan2.michonline.com>
	<7vhddr397g.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508151453100.21501@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 09:28:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4vrk-0000Uy-KV
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 09:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbVHPH2E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 03:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965130AbVHPH2E
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 03:28:04 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:18382 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S965128AbVHPH2C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 03:28:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050816072800.RAML19627.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 16 Aug 2005 03:28:00 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Daniel Barkalow <barkalow@iabervon.org> writes:

> It might be worth putting the list of things left to do before 1.0 in the 
> tree (since they clearly covary), and it would be useful to know what 
> you're thinking of as preventing the release at any particular stage.

Yeah, yeah.  Call me lazy.

Excerpts from my "last mile to 1.0", my Itchlist, and pieces from
random other messages since then.

- Documentation. [I really need help here --- among ~7000 lines
  there, I've written around 2500 lines, David Greaves another
  2500, and Linus 1400.  And it is not very easy to proofread
  what you wrote yourself.]

  - Are all the core commands described in Documentation/
    directory?

  - Many files under Documentation/ directory have become stale.
    I've tried to do one pass of full sweep recently [and
    another since I wrote the original "last mile" message], but
    I'd like somebody else to make another pass to make sure
    that the usage strings in programs, what the programs do,
    and what Documentation says they do match.  Also, the
    spelling and grammar fixes, which I am very bad at and have
    not done any attempt, needs to be done.

    Volunteers?

  - Are all the files in Documentation/ reachable from git(7)
    or otherwise made into a standalone document using asciidoc
    by the Makefile?  I haven't looked into documentation
    generation myself (I use only the text files as they are);
    help to update the Makefile by somebody handy with asciidoc
    suite is greatly appreciated here.

    Volunteers?

  - We may want to describe more Best Current Practices, along
    the lines of "Working with Others" section in the tutorial.
    Please write on your faviorite topic and send patches in
    ;-)) [ryan started collecting Documentation/howto which
    would greatly help in this area].

  - Glossary documentation Johannes Schindelin is working on.

    I think coming up with the concensus of terms would come
    fairly quickly on the list.  Updating docs to match the
    concensus may take some time.  Help is greatly appreciated.

  - Maybe doing another pass at tutorial.  Could somebody run
    (or preferably, find a friend who has never touched git and
    have her run) the tutorial examples from the beginning to
    the end, and find rooms of improvements?  Does the order of
    materials presented make sense?  Do we talk about things
    assuming that the user knows something else that we have not
    talked about?  Have we introduced better way of doing the
    same thing since the tutorial was written?

    I've done that once with the text that is currently in the
    head of the master branch, but that is getting rather stale,
    and also I did that myself so I am sure I've sidestepped
    pitfalls without even realizing.

The above does not have to be all there in 0.99.5, but I
consider that lack of any of the above to block 1.0.

- Commit walker downloading from packed repository is finally
  complete.  Thanks, Daniel!

- Teach fetch-pack reference renaming.

  On the push side, send-pack now knows updating arbitrary
  remote references from local references.  We need something
  similar for fetching [since then I outlined the design of the
  new shorthand file format and semantics but have not got
  around to actually do it.  Maybe on my next GIT day...].  This
  is scheduled for 0.99.5.

- commit template filler discussed with Pasky some time ago,
  with perhaps pre-commit and post-commit hooks.  Somehow the
  discussion died out but that does not mean _I_ forgot about
  it.

- Binary packaging.  Should _I_ worry about "/usr/bin/git" stay
  there myself --- I think not.  But I _do_ want to help Debian
  packaging folks if that path is causing problems in their
  effort to push git-core into the official Debian archive.

  As Linus mentioned earlier, this seems to be a Debian specific
  problem, and will not block 1.0 --- if Debian heavyweights do
  not want to stay compatible with the rest of the world, so be
  it.

- I have not heard from Darwin or BSD people for some time.  Is
  your portfile up to date?  Do you have updates you want me to
  include?  Have we introduced non-Linux non-GNU
  incompatibilities lately that you want to see fixed and/or
  worked around?

  Again, I consider binary packaging issue independent from our
  release schedule; it is a distribution local issue, so this
  would not block 1.0 in any way.  But I _am_ willing to help
  them.

- Oh, another itch I did not list in the previous message.  Is
  anybody interested in doing an Emacs VC back-end for GIT?

- git prune and git fsck-cache; think about their interactions
  with an object database that borrows from another.  This
  includes the case where .git/objects itself is symlinked to
  somewhere else (i.e. running "git prune" that somewhere else
  without consulting this repository would lose objects), and
  alternates pointing at somewhere else (i.e. ditto).

  My personal feeling is that we should just warn users about
  doing .git/objects symlinking and/or alternates pointing ---
  do not do it unless you have an off-line arrangement with the
  owner of the repository you are borrowing from.  Even if that
  would become our official position to take, it needs to be
  documented clearly before we declare this issue to have been
  "dealt with".

I am sure I am forgetting something, but the above would be a
good start.
