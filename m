From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 0.99.9n aka 1.0rc6
Date: Wed, 14 Dec 2005 18:36:40 -0800
Message-ID: <7v7ja7rsqv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Dec 15 03:37:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emiz8-0004x7-Cy
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 03:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160999AbVLOCgn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 14 Dec 2005 21:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030390AbVLOCgn
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 21:36:43 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:37797 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1030389AbVLOCgm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2005 21:36:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051215023602.YIMR3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Dec 2005 21:36:02 -0500
To: git@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13675>

GIT 0.99.9n aka 1.0rc6 is available at the usual places.

	RPM
		http://kernel.org:/pub/software/scm/git/RPMS/

	Debian
		http://kernel.org:/pub/software/scm/git/debian/

I hate to do this, but I ended up merging some more that changes user
experience.  Two notable non-fixes are:

 - big usage string cleanups (Fredrik).

 - git-am enhancements that made a lot of sense for non mbox
   users (HPA).

So git is still in perpetual state of 1.0rc X-<.

No more big changes from now on will be merged to the "master"
branch, except fixes and documentation enhancements.

Well, patches are always welcome, but non-fixes will have to
stay in the proposed updates branch until Wednesday 2005-12-21,
which is the date I am aiming the final 1.0 for.

Right now, I have two somewhat debatable patch in the proposed
updates branch:

 - when merging a branch that renames A->B and another branch
   that renames A->C, merge-recursive leaves B and C in stage 2
   and stage 3, instead of registering them at stage 0 as the
   current "master" branch does.

 - diff gets --abbrev option to shorten the blob object names in
   diff-raw and commit object names in diff-tree headers.

These will *not* be in 1.0 final, unless somebody really wants
them and jumps up-and-down.

I personally feel the "renaming merge" desirable if it works
correctly, but (1) it is a rare case anyway, (2) I have not
tested it extensively, and (3) having hacked it myself, I do not
think I will be able to spot bugs that involve cases I have not
thought about.  So maybe a good test script and an Ack or two
could push me into moving it forward but otherwise it is slated
post 1.0.

The "diff --abbrev" addition is lower impact and I find it
somewhat cute and especially useful while working on an
80-column terminal, but I'd like to make it find unambiguous
prefix, which it does not do currently, before pushing it out.

I am also holding off another one that changes things to use
textual symref for .git/HEAD everywhere, but I think it is well
known that that change is eventually coming sometime after 1.0.

-- >8 -- shortlog -- >8 --
Amos Waterland:
      git rebase loses author name/email if given bad email address

=46redrik Kuivinen:
      Usage message clean-up, take #2
      Trivial usage string clean-up
      git-verify-tag: Usage string clean-up, emit usage string at incor=
rect invocation
      git-revert: Usage string clean-up
      git-am: Usage string clean-up
      git-applypatch: Usage string clean-up, emit usage string at incor=
rect invocation
      git-cherry: Usage string clean-up, use the 'usage' function
      git-fetch: Usage string clean-up, emit usage string at unrecogniz=
ed option
      git-lost-found: Usage string clean-up, emit usage string at incor=
rect invocation
      git-prune: Usage string clean-up, use the 'usage' function
      git-rebase: Usage string clean-up, emit usage string at incorrect=
 invocation
      git-repack: Usage string clean-up, emit usage at incorrect invoca=
tion

H. Peter Anvin:
      git-am support for naked email messages (take 2)

Junio C Hamano:
      diffcore-break.c: check diff_delta() return value.
      Add deltifier test.
      diff-delta.c: allow delta with empty blob.
      Everyday: some examples.
      Revert "diff-delta.c: allow delta with empty blob."
      Revert "Add deltifier test."
      diffcore-break: do not break too small filepair.
      Everyday: a bit more example.
      Documentation: more examples.
      Documentation: fix missing links to git(7)
      Documentation: diff examples.
      Documentation: not learning core git commands.
      git-clone: tell the user a bit more about clone-pack failure.
      allow merging any committish
      checkout-index: fix checking out specific path.
      Everyday: a bit more examples.
      t3200: branch --help does not die anymore.
      applypatch: no need to do non-portable [[ ... ]]
      Documentation: topic branches
      rebase: do not get confused in fast-forward situation.
      Do not let errors pass by unnoticed when running `make check'.
      mailinfo and git-am: allow "John Doe <johndoe>"

Lukas Sandstr=F6m:
      Bugfixes for git-rebase

Martin Atukunda:
      define MAXPATHLEN for hosts that don't support it

Petr Baudis:
      Make git-send-pack exit with error when some refs couldn't be pus=
hed out
