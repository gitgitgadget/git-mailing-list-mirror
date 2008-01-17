From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable frozen)
Date: Wed, 16 Jan 2008 19:01:00 -0800
Message-ID: <7vk5m9kvf7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 17 04:01:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFL0k-0000vt-4T
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 04:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbYAQDBR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jan 2008 22:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbYAQDBR
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 22:01:17 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53809 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbYAQDBQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 22:01:16 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C7645482B;
	Wed, 16 Jan 2008 22:01:14 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B87E4822;
	Wed, 16 Jan 2008 22:01:12 -0500 (EST)
X-maint-at: aadd4efa715f56e0eac5ac459c8ff4933b56d4ce
X-master-at: b531394d5829b22fd40e38e1d3aa6e97cb5b84ef
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70819>

There are a good deal of bugfixes in 'master', the largest of
which is Brandon Casey's fix to builtin-commit and others'
misuse of lockfile API.  A tentative fix for the issue was
pushed out last night but the approach has known issues for our
Windowsy friends, and this attempts to address them.

We've been taking pride that the tip of 'master' is always,
without regression, more stable than any released version, but
today's one might have uncovered glitches.  Please help testing
it so that we do not have to leave it broken for a long time if
it indeed is.

I spent quite a lot of time trying to come up with a simple
reproduction recipe for the builtin-commit breakage, but I
couldn't.  I also wanted to apply the patch to remove the use
(but not implementation) of repo-config along with a removal
notice in the release notes but haven't got around to.

Aside from obviously correct trivial fixes that may come from
the list, what currently is not in 'master' but should be in the
rc4 are very minimal.  Brandon Casey's lockfile fix needs to be
tested for some time, repo-config deprecation notice needs to be
posted, and "\C-+" patch for gitk needs to be pulled from Paul.
I see French translation for git-gui in Shawn's repository, but
I do not know if it, along with other changes to git-gui, are
meant for 1.5.4 or not.  If they are, I'd like to include them
all before tagging rc4.

----------------------------------------------------------------

* The 'master' branch has these since the last announcement
  in addition to the above.

Bill Lear (1):
  Correct spelling in diff.c comment

Brandon Casey (3):
  close_lock_file(): new function in the lockfile API
  Improve use of lockfile API
  refs.c: rework ref_locks by abstracting from underlying struct lock_f=
ile

Dan McGee (2):
  Remove usage of git- (dash) commands from email hook
  cvsimport: remove last use of repo-config from git standard tools

Dave Peticolas (1):
  Documentation: fix and clarify grammar in git-merge docs.

Dmitry Potapov (1):
  treat any file with NUL as binary

Jean-Luc Herren (1):
  Make default pre-commit hook less noisy

Junio C Hamano (4):
  Revert "builtin-commit.c: remove useless check added by faulty cut an=
d
    paste"
  Fix git-rerere documentation
  Squelch bogus progress output from git-rebase--interactive
  Document lockfile API

Kristian H=C3=B8gsberg (1):
  git-commit: fix double close(2) that can close a wrong file descripto=
r

Linus Torvalds (3):
  Make builtin-commit.c more careful about parenthood
  Make 'git fsck' complain about non-commit branches
  Be more careful about updating refs

Mark Drago (1):
  hg-to-git: improve popen calls

Miklos Vajna (2):
  Add using merge subtree How-To
  ls-remote: add -t and -h options.
