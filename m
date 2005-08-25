From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 0.99.5
Date: Wed, 24 Aug 2005 19:38:01 -0700
Message-ID: <7vr7ci4u7q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Aug 25 04:38:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E87d3-0007NQ-7S
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 04:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbVHYCiE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 22:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbVHYCiE
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 22:38:04 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:51140 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932495AbVHYCiD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2005 22:38:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050825023801.LLJO16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 24 Aug 2005 22:38:01 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7737>

I've pushed out all of what has been in the proposed updates
branch, along with documentation updates.

Many changes all over:

 - pulling from packed repository.
 - cvsimport.
 - documentation coverage.
 - usability.
 - terminology clarification.
 - hooks for updates and commits.
 - updated gitk.
 - multi-head push, fetch, pull, octopus merge.
 - faster merge-base.
 - git from subdirectories.
 - build procedure cleanups.

Have fun.


What to expect after 0.99.5
===========================

This is written in a form of to-do list for me, so if I say
"accept patch", it means I do not currently plan to do that
myself.  People interested in seeing it materialize please take
a hint.


Documentation
-------------

* Accept patches from people who actually have done CVS
  migration and update the cvs-migration documentation.
  Link the documentation from the main git.txt page.

* Update the SubmittingPatches document to add MUA specific
  hints on how to disable unwanted MIME and flowed-text by
  collecting past list postings.  Accept patches from people who
  was hit by shiny blue bat to update the same.

* Talk about using rsync just once at the beginning when
  initializing a remote repository so that local packs do not
  need to be expanded.  I personally do not think we need tool
  support for this.

* Update tutorial to cover shared repository style a bit more,
  maybe with a toy project that involves two or three
  repositories.

* Update tutorial to cover setting up repository hooks to do
  common tasks.

* Get help to properly use asciidoc in tutorial.

* Maybe justify and demonstrate an Octopus in the tutorial.  Add
  it to the glossary.


Technical (heavier)
-------------------

* Tony Luck reported an unfortunate glitch in the 3-way merge.
  Encourage discussions to come up with a not-so-expensive way
  to catch the kind of ambiguities that led to his misery.


Technical (milder)
------------------

* When the branch head pointed by $GIT_DIR/HEAD changes while
  the index file and working tree are looking the other way
  (e.g. somebody pushed into your repository, or you ran "git
  fetch" to update the ref your working tree is on), "git
  checkout" without -f gets confused.  Figure out a good way to
  handle this.

* "git commit -m" should work for initial commits and perhaps
  merge commits as well.  Warning about merge is still a good
  thing to do, while -m is useful in scripted non-interactive
  use, so we need to be careful.

* Encourage concrete proposals to commit log message templates
  we discussed some time ago.

* Bug Ryan and work with him to update send-email easier to use.

* Look at portability fixes from Jason Riedy

    http://www.cs.berkeley.edu/~ejr/gits/git.git#portable 

* Accept patches to cause "read-tree -u" delete a directory when
  it makes it empty.

* Perhaps accept patches to introduce the concept of "patch flow
  expressed as ref mappings" Josef has been advocating about.

* MIMEified applymbox to grok B and Q encodings in headers and
  turn them into UTF-8; unwrap QP; explode multipart.

* "git cherry-pick" that applies the patch an existing commit
  introduces in its ancestry chain, possibly using the 3-way
  merge machinery; update rebase using the cherry-pick command.
  Carl's redo/undo might fall out naturally from this.

* A tool to detect, show and prune already merged topic
  branches.

* Perhaps "git branch -d" to delete a branch.

* Enhance "git repack" to not always use --all; this would be
  handy if the repository contains wagging heads like "pu" in
  git.git repository.

* Remove "git clone-dumb-http".
