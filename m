From: Junio C Hamano <junkio@cox.net>
Subject: GIT 0.99.4 preview: current status
Date: Mon, 08 Aug 2005 02:09:52 -0700
Message-ID: <7vacjsdcbj.fsf@assigned-by-dhcp.cox.net>
References: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net>
	<7vr7d6z3pn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Aug 08 11:10:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E23dt-0002dS-44
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 11:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbVHHJJy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 05:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVHHJJy
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 05:09:54 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:57304 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750782AbVHHJJy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 05:09:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050808090952.EJNX12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 Aug 2005 05:09:52 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Things are looking almost ready for a new release.  The list at
the end of this message shows what went into the release
candidate branch since 0.99.3: Dan's commit walker updates to
deal with a packed repository, Johannes fixed quite a lot of
problems in the documentation, I did reference-renaming push, a
couple of usability improvements from Linus, gitk updates from
Paul, and Ryan added an bulk e-mailer.  With help from Kalle,
Horst and Chris Wright, binary packaging looks in a better shape
now.  I'll let this simmer for a couple more days, and plan to
merge them back to the master branch on Wednesday and tag it as
v0.99.4.  Some of the patches I will receive before Wednesday
from the list, and some of what I already have in the proposed
update branch, may graduate to the master branch before that
happens.

Earlier, I posted my itchlist.  I would of course appreciate if
somebody scratches them, but at the same time would appreciate
people to voice their own itches.  My personal 0.99.5 itches are
to enhance fetch to deal with multiple references and have
local-pull to deal with a packed repository.  Dan's help would be
greatly appreciated on the latter one.

Oh, another itch I did not list in the previous message.  Is
anybody interested in doing an Emacs VC back-end for GIT?

BTW, I used "git log v0.99.3..rc | git shortlog" to prepare the
attached list, but ended up hand-removing many "Merge with blah"
entries.  It may not be a bad idea to have an option to filter
out the merge entries at "git log" time.  Adding
'--single-parent-only' flag to git-rev-list would be one way of
doing it.  Suggestions?

------------
Alecs King:
  Fix sparse warnings

barkalow@iabervon.org:
  Object library enhancements
  Parallelize the pull algorithm
  Parallelize pulling by ssh

Holger Eitzenberger:
  git: add git_mkstemp()
  git: use git_mkstemp() instead of mkstemp() for diff generation.

Horst von Brand:
  RPM spec updates.

Johannes Schindelin:
  git-commit-script fix for degenerated merge
  Assorted documentation patches

Junio C Hamano:
  Clean t/trash upon "make clean" as well.
  Make send-pack --all and explicit ref mutually exclusive.
  receive-pack hooks updates.
  Make sure leading directories exist when pushing refs.
  git-send-email-script: minimum whitespace cleanup.
  send-pack: handle partial pushes correctly.
  Install sample hooks
  Renaming push.
  git-send-pack: documentation
  Retire check-files.
  Retire git-check-files documentation too.
  git-bisect termination condition fix.
  git-init-db: brown paper bag bugfix.
  Fix send-pack for non-commitish tags.
  Update get_sha1() to grok extended format.
  Teach rev-list since..til notation.
  daemon.c: squelch error message from EINTR
  git-applymbox: allow retrying after fixing up.
  Fix refname termination.
  Fix ref_newer() in send-pack.
  send-pack: allow the same source to be pushed more than once.
  send-pack: allow generic sha1 expression on the source side.
  gitk proposed fix: handle more than one SHA1 links.
  Redo the templates generation and installation.
  GIT 0.99.4 (release candidate)
  Fix RPM build that omitted templates and tools.
  Fix build rules for debian package.
  (revert local fix)
  Update Maintainer field of debian/control

Kalle Valo:
  Fix debian doc-base

Linus Torvalds:
  Make git-sh-setup-script do what it was supposed to do
  Extend "git reset" to take a reset point
  gitk "parent information" in commit window

Nicolas Pitre:
  list shortlog items in commit order

Paul Mackerras:
  Compress the graph horizontally if it gets too wide.
  Add forward and back buttons and make SHA1 IDs clickable links.
  Change cursor to a hand cursor when over a SHA1 ID link.
  Use lf translation rather than binary when reading commit data.
  Better graph line details display and expand history coverage.

Petr Baudis:
  Fix git-merge-cache -q

Ryan Anderson:
  Add git-send-email-script - tool to send emails from git-format-patch-script
  Add documentation for git-send-email-script
  Add new dependencies caused by git-send-email-script to debian/control
  Convert from using quoted-printable to just 8bit encoding on all emails.
  Cleanup initial comments, add copyright notices.
  Add "--chain-reply-to" to git-send-email-script, to control whether or not the
  git-send-email-script: Reformat readline interface and generate a better message-id.
  Make the SMTP server used by git-sendm-email-script configurable on the command line with "--smtp-server"
  git-send-email-script - fix 2 small bugs that snuck through an untested bout of editing.
  git-send-email-script - Fix loops that limit emails to unique values to be pedantically correct.
  Doc: update git-send-email-script documentation.

Sergey Vlasov:
  Plug memory leaks in git-unpack-objects
