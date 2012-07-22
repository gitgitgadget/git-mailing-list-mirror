From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.7.11.3
Date: Sun, 22 Jul 2012 14:27:26 -0700
Message-ID: <7vk3xvpjup.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Sun Jul 22 23:27:43 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1St3gk-0008Bd-Pq
	for glk-linux-kernel-3@plane.gmane.org; Sun, 22 Jul 2012 23:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704Ab2GVV1d (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 22 Jul 2012 17:27:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65348 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752626Ab2GVV1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jul 2012 17:27:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFA778EE3;
	Sun, 22 Jul 2012 17:27:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=F
	Ukhz8U/WxXWlFmwKx6tENiY/PY=; b=Wz8rYuJB3Va8zra7R2f+K5hQAP5KB/m5T
	kKUSuygLHqAmxOepb8csh8EJT+TpNv8w/VFqRoLsmE5oi86oL3G10yepQg9CHYfe
	OY2VGpydtHi3gQuVebTRZ48VrpJJ3f97eX6Qr3LlY4x04IhlUe7sw8YiKWTzPGN8
	N6RZogiDAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=Di7IlwbZ0TWqTagM3AW+m3b/MS/1gu0TQNej2kituFF0r6QzvFvPx96c
	RgQnR4wXOOtkpyLYNAZqnpID2BshC1yEmVNxqt5DOm9XbwuUbczmePUB9K5iIlgp
	A/BevVBbQhUmoPMhIS/i7F3TuMaQsmzEKjGcj1WvoON3dUAmyAU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE59B8EE2;
	Sun, 22 Jul 2012 17:27:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DBCAD8EDF; Sun, 22 Jul 2012
 17:27:27 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0970CBD2-D444-11E1-B91A-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201869>

The latest maintenance release Git v1.7.11.3 is now available at
the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

a10c420e4d9152d6059f41825904cfac3062b135  git-1.7.11.3.tar.gz
41500708e87787d6139de413c4da91629aa79fa8  git-htmldocs-1.7.11.3.tar.gz
10151406ace1da92a70d203a7eb1c86024fdd919  git-manpages-1.7.11.3.tar.gz

Also the following public repositories all have a copy of the v1.7.11.3
tag and the maint branch that the tag points at:

  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

Git v1.7.11.3 Release Notes
===========================

Fixes since v1.7.11.3
---------------------

 * The error message from "git push $there :bogo" (and its equivalent
   "git push $there --delete bogo") mentioned that we tried and failed
   to guess what ref is being deleted based on the LHS of the refspec,
   which we don't.

 * A handful of files and directories we create had tighter than
   necessary permission bits when the user wanted to have group
   writability (e.g. by setting "umask 002").

 * "commit --amend" used to refuse amending a commit with an empty log
   message, with or without "--allow-empty-message".

 * "git commit --amend --only --" was meant to allow "Clever" people to
   rewrite the commit message without making any change even when they
   have already changes for the next commit added to their index, but
   it never worked as advertised since it was introduced in 1.3.0 era.

 * Even though the index can record pathnames longer than 1<<12 bytes,
   in some places we were not comparing them in full, potentially
   replacing index entries instead of adding.

 * "git show"'s auto-walking behaviour was an unreliable and
   unpredictable hack; it now behaves just like "git log" does when it
   walks.

 * "git diff", "git status" and anything that internally uses the
   comparison machinery was utterly broken when the difference
   involved a file with "-" as its name.  This was due to the way "git
   diff --no-index" was incorrectly bolted on to the system, making
   any comparison that involves a file "-" at the root level
   incorrectly read from the standard input.

 * We did not have test to make sure "git rebase" without extra options
   filters out an empty commit in the original history.

 * "git fast-export" produced an input stream for fast-import without
   properly quoting pathnames when they contain SPs in them.

 * "git checkout --detach", when you are still on an unborn branch,
   should be forbidden, but it wasn't.

 * Some implementations of Perl terminates "lines" with CRLF even when
   the script is operating on just a sequence of bytes.  Make sure to
   use "$PERL_PATH", the version of Perl the user told Git to use, in
   our tests to avoid unnecessary breakages in tests.

Also contains minor typofixes and documentation updates.

----------------------------------------------------------------

Changes since v1.7.11.2 are as follows:

Alex Riesen (1):
      Restore umasks influence on the permissions of work tree created by clone

Chris Webb (2):
      git-checkout: disallow --detach on unborn branch
      Allow edit of empty message with commit --amend

Jay Soffian (1):
      fast-export: quote paths with spaces

Jeff King (3):
      push: don't guess at qualifying remote refs on deletion
      add: create ADD_EDIT.patch with mode 0666
      commit: fix "--amend --only" with no pathspec

Junio C Hamano (10):
      show: fix "range implies walking"
      t/test-lib.sh: export PERL_PATH for use in scripts
      tests: enclose $PERL_PATH in double quotes
      t/README: add a bit more Don'ts
      diff-index.c: do not pretend paths are pathspecs
      diff-index.c: unify handling of command line paths
      diff-index.c: "git diff" has no need to read blob from the standard input
      rerere: make rr-cache fanout directory honor umask
      cache_name_compare(): do not truncate while comparing paths
      Git 1.7.11.3

Martin von Zweigbergk (1):
      add test case for rebase of empty commit

Thomas Rast (1):
      Demonstrate git-show is broken with ranges

Vincent van Ravesteijn (1):
      t: Replace 'perl' by $PERL_PATH
