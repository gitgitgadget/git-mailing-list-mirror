From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.2-rc0
Date: Sat, 07 Feb 2009 13:54:37 -0800
Message-ID: <7vvdrlsyjm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 07 22:56:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVv9o-0001ou-Em
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 22:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542AbZBGVyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 16:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752089AbZBGVyq
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 16:54:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64521 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbZBGVyp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 16:54:45 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 91A6C2AA6F;
	Sat,  7 Feb 2009 16:54:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 686A62AA3C; Sat, 
 7 Feb 2009 16:54:39 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ED79E694-F561-11DD-8504-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108892>

The 0th release candidate for 1.6.2 is available at the usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.2-rc0.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.2-rc0.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.2-rc0.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are also provided
as courtesy.

  testing/git-*-1.6.2-rc0-1.fc9.$arch.rpm	(RPM)

----------------------------------------------------------------

GIT v1.6.2 Release Notes (draft)
================================

With the next major release, "git push" into a branch that is
currently checked out will be refused by default.  You can choose
what should happen upon such a push by setting the configuration
variable receive.denyCurrentBranch in the receiving repository.

To ease the transition plan, the receiving repository of such a
push running this release will issue a big warning when the
configuration variable is missing.  Please refer to:

  http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007

for more details on the transition plan.


Updates since v1.6.1
--------------------

(subsystems)

* git-svn updates.

* gitweb updates, including a new patch view and RSS/Atom feed
  improvements.

* (contrib) git.el updates for better XEmacs compatibility; vc-git.el
  is not shiped with git anymore (it is part of official Emacs)

(performance)

* pack-objects autodetects the number of CPUs available and uses threaded
  version.

(usability, bells and whistles)

* automatic typo correction works on aliases as well

* Initial support for "git notes" implemented.

* @{-1} is a way to refer to the last branch you were on.  This is
  accepted not only where an object name is expected, but anywhere
  a branch name is expected.  E.g. "git branch --track mybranch @{-1}"
  "git rev-parse --symbolic-full-name @{-1}".

* "git add -p" learned 'g'oto action to jump directly to a hunk.

* "git add -p" learned to find a hunk with given text with '/'.

* "git add -p" optionally can be told to work with just the command letter
  without Enter.

* when "git am" stops upon a patch that does not apply, it shows the
  title of the offending patch.

* "git am --directory=<dir>" and "git am --reject" passes these options
  to underlying "git apply".

* "git am" learned --ignore-date option.

* "git blame" aligns author names better when they are spelled in
  non US-ASCII encoding.

* "git clone" now makes its best effort when cloning from an empty
  repository to set up configuration variables to refer to the remote
  repository.

* "git checkout -" is a shorthand for "git checkout @{-1}".

* "git cherry" defaults to whatever the current branch is tracking (if
  exists) when the <upstream> argument is not given.

* "git cvsserver" can be told not to add extra "via git-CVS emulator" to
  the commit log message it serves via gitcvs.commitmsgannotation
  configuration.

* "git cvsserver" learned to handle 'noop' command some CVS clients seem
  to expect to work.

* "git diff" learned a new option --inter-hunk-context to coalesce close
  hunks together and show context between them.

* The definition of what constitutes a word for "git diff --color-words"
  can be customized via gitattributes, command line or a configuration.

* "git diff" learned --patience to run "patience diff" algorithm.

* "git filter-branch" learned --prune-empty option that discards commits
  that do not change the contents.

* "git fsck" now checks loose objects in alternate object stores, instead
  of misreporting them as missing.

* "git grep -w" and "git grep" for fixed strings have been optimized.

* "git mergetool" learned -y(--no-prompt) option to disable prompting.

* "git rebase -i" can transplant a history down to root to elsewhere
  with --root option.

* "git reset --merge" is a new mode that works similar to the way
  "git checkout" switches branches, taking the local changes while
  switching to another commit.

* "git tag" learned --contains that works the same way as the same option
  from "git branch".


Fixes since v1.6.1
------------------

All of the fixes in v1.6.1.X maintenance series are included in this
release, unless otherwise noted.

Here are fixes that this release has, but have not been backported to
v1.6.1.X series.

* "git-add sub/file" when sub is a submodule incorrectly added the path to
  the superproject.

* "git bundle" did not exclude annotated tags even when a range given
  from the command line wanted to.

* "git filter-branch" unnecessarily refused to work when you had
  checked out a different commit from what is recorded in the superproject
  index in a submodule.

* "git filter-branch" incorrectly tried to update a nonexistent work tree
  at the end when it is run in a bare repository.

* "git mergetool" used to ignore autocrlf and other attributes
  based content rewriting.

* branch switching and merges had a silly bug that did not validate
  the correct directory when making sure an existing subdirectory is
  clean.

* "git -p cmd" when cmd is not a built-in one left the display in funny state
  when killed in the middle.
