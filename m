From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.8.1-rc1
Date: Fri, 07 Dec 2012 16:20:35 -0800
Message-ID: <7vwqwte6ng.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Sat Dec 08 01:21:03 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Th8A9-0002bh-Gt
	for glk-linux-kernel-3@plane.gmane.org; Sat, 08 Dec 2012 01:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410Ab2LHAUm (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 7 Dec 2012 19:20:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43798 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932300Ab2LHAUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Dec 2012 19:20:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E56D79EBF;
	Fri,  7 Dec 2012 19:20:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=W
	ewQQ6bZMPt/ws3MGgERRwXu0Z4=; b=NinRZsmLIyuWIfoTaHEHmJHus75yzQahK
	L9FzFN2px/9+TM+Nze7qikSHnm70FpZxpTW6FJLfW5TaEN3yk1VGBvjAivBsf0Rl
	YLLdxztax6nZgRVdVQboKc+FaxYZ0cMq3hubS64KJfKife33nmYAItlyiIhtc2wG
	m2pkLqYZZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=dKNWS145Pez2Zth3C5gu2Q1gw6KF1ZZWwrkQ0IxXs5s0ptL74PSPc+NI
	kxFNecHETfN1fFFPofYBaYKGf7U4zV1+Qt07F2VILL36sVMs3RHcC1cwOXXADE4D
	JNaxU3VcmG2vH6+V3KttulXYlOkg+LxWdHLNu8enTL0Km0XXIzM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D18639EBE;
	Fri,  7 Dec 2012 19:20:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5D929EBA; Fri,  7 Dec 2012
 19:20:37 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1750E3F4-40CD-11E2-82FC-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211205>

A release candidate Git v1.8.1-rc1 is now available for testing
at the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

4b451bb5b7125349c35cf15118e8f1893569e48f  git-1.8.1.rc1.tar.gz
7416b28a0917fef26ca06f22bc493ebea371267f  git-htmldocs-1.8.1.rc1.tar.gz
b5758adf5814d64ee8e0d26bdfb919be1c605071  git-manpages-1.8.1.rc1.tar.gz

Also the following public repositories all have a copy of the v1.8.1-rc1
tag and the master branch that the tag points at:

  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

Git v1.8.1 Release Notes (draft)
========================

Backward compatibility notes
----------------------------

In the next major release (not *this* one), we will change the
behavior of the "git push" command.

When "git push [$there]" does not say what to push, we have used the
traditional "matching" semantics so far (all your branches were sent
to the remote as long as there already are branches of the same name
over there).  We will use the "simple" semantics that pushes the
current branch to the branch with the same name, only when the current
branch is set to integrate with that remote branch.  There is a user
preference configuration variable "push.default" to change this, and
"git push" will warn about the upcoming change until you set this
variable in this release.

"git branch --set-upstream" is deprecated and may be removed in a
relatively distant future.  "git branch [-u|--set-upstream-to]" has
been introduced with a saner order of arguments to replace it.


Updates since v1.8.0
--------------------

UI, Workflows & Features

 * Command-line completion scripts for tcsh and zsh have been added.

 * A new remote-helper interface for Mercurial has been added to
   contrib/remote-helpers.

 * We used to have a workaround for a bug in ancient "less" that
   causes it to exit without any output when the terminal is resized.
   The bug has been fixed in "less" version 406 (June 2007), and the
   workaround has been removed in this release.

 * Some documentation pages that used to ship only in the plain text
   format are now formatted in HTML as well.

 * "git-prompt" scriptlet (in contrib/completion) can be told to paint
   pieces of the hints in the prompt string in colors.

 * A new configuration variable "diff.context" can be used to
   give the default number of context lines in the patch output, to
   override the hardcoded default of 3 lines.

 * When "git checkout" checks out a branch, it tells the user how far
   behind (or ahead) the new branch is relative to the remote tracking
   branch it builds upon.  The message now also advises how to sync
   them up by pushing or pulling.  This can be disabled with the
   advice.statusHints configuration variable.

 * "git config --get" used to diagnose presence of multiple
   definitions of the same variable in the same configuration file as
   an error, but it now applies the "last one wins" rule used by the
   internal configuration logic.  Strictly speaking, this may be an
   API regression but it is expected that nobody will notice it in
   practice.

 * "git log -p -S<string>" now looks for the <string> after applying
   the textconv filter (if defined); earlier it inspected the contents
   of the blobs without filtering.

 * "git format-patch" learned the "--notes=<ref>" option to give
   notes for the commit after the three-dash lines in its output.

 * "git log --grep=<pcre>" learned to honor the "grep.patterntype"
   configuration set to "perl".

 * "git replace -d <object>" now interprets <object> as an extended
   SHA-1 (e.g. HEAD~4 is allowed), instead of only accepting full hex
   object name.

 * "git rm $submodule" used to punt on removing a submodule working
   tree to avoid losing the repository embedded in it.  Because
   recent git uses a mechanism to separate the submodule repository
   from the submodule working tree, "git rm" learned to detect this
   case and removes the submodule working tree when it is safe to do so.

 * "git send-email" used to prompt for the sender address, even when
   the committer identity is well specified (e.g. via user.name and
   user.email configuration variables).  The command no longer gives
   this prompt when not necessary.

 * "git send-email" did not allow non-address garbage strings to
   appear after addresses on Cc: lines in the patch files (and when
   told to pick them up to find more recipients), e.g.

     Cc: Stable Kernel <stable@k.org> # for v3.2 and up

   The command now strips " # for v3.2 and up" part before adding the
   remainder of this line to the list of recipients.

 * "git submodule add" learned to add a new submodule at the same
   path as the path where an unrelated submodule was bound to in an
   existing revision via the "--name" option.

 * "git submodule sync" learned the "--recursive" option.

 * "diff.submodule" configuration variable can be used to give custom
   default value to the "git diff --submodule" option.

 * "git symbolic-ref" learned the "-d $symref" option to delete the
   named symbolic ref, which is more intuitive way to spell it than
   "update-ref -d --no-deref $symref".


Foreign Interface

 * "git cvsimport" can be told to record timezones (other than GMT)
   per-author via its author info file.

 * The remote helper interface to interact with subversion
   repositories (one of the GSoC 2012 projects) has been merged.


Performance, Internal Implementation, etc.

 * Compilation on Cygwin with newer header files are supported now.

 * The logic to generate the initial advertisement from "upload-pack"
   (i.e. what is invoked by "git fetch" on the other side of the
   connection) to list what refs are available in the repository has
   been optimized.

 * The logic to find set of attributes that match a given path has
   been optimized.

 * Use preloadindex in "git diff-index" and "git update-index", which
   has a nice speedup on systems with slow stat calls (and even on
   Linux).


Also contains minor documentation updates and code clean-ups.


Fixes since v1.8.0
------------------

Unless otherwise noted, all the fixes since v1.8.0 in the maintenance
track are contained in this release (see release notes to them for
details).

 * The configuration parser had an unnecessary hardcoded limit on
   variable names that was not checked consistently.

 * The "say" function in the test scaffolding incorrectly allowed
   "echo" to interpret "\a" as if it were a C-string asking for a
   BEL output.

 * "git mergetool" feeds /dev/null as a common ancestor when dealing
   with an add/add conflict, but p4merge backend cannot handle
   it. Work it around by passing a temporary empty file.

 * "git log -F -E --grep='<ere>'" failed to use the given <ere>
   pattern as extended regular expression, and instead looked for the
   string literally.

 * "git grep -e pattern <tree>" asked the attribute system to read
   "<tree>:.gitattributes" file in the working tree, which was
   nonsense.

 * A symbolic ref refs/heads/SYM was not correctly removed with "git
   branch -d SYM"; the command removed the ref pointed by SYM
   instead.

 * Update "remote tracking branch" in the documentation to
   "remote-tracking branch".

 * "git pull --rebase" run while the HEAD is detached tried to find
   the upstream branch of the detached HEAD (which by definition
   does not exist) and emitted unnecessary error messages.

 * The refs/replace hierarchy was not mentioned in the
   repository-layout docs.

 * Various rfc2047 quoting issues around a non-ASCII name on the
   From: line in the output from format-patch have been corrected.

 * Sometimes curl_multi_timeout() function suggested a wrong timeout
   value when there is no file descriptor to wait on and the http
   transport ended up sleeping for minutes in select(2) system call.
   A workaround has been added for this.

 * For a fetch refspec (or the result of applying wildcard on one),
   we always want the RHS to map to something inside "refs/"
   hierarchy, but the logic to check it was not exactly right.
   (merge 5c08c1f jc/maint-fetch-tighten-refname-check later to maint).

 * "git diff -G<pattern>" did not honor textconv filter when looking
   for changes.

 * Some HTTP servers ask for auth only during the actual packing phase
   (not in ls-remote phase); this is not really a recommended
   configuration, but the clients used to fail to authenticate with
   such servers.
   (merge 2e736fd jk/maint-http-half-auth-fetch later to maint).

 * "git p4" used to try expanding malformed "$keyword$" that spans
   across multiple lines.

 * Syntax highlighting in "gitweb" was not quite working.

 * RSS feed from "gitweb" had a xss hole in its title output.

 * "git config --path $key" segfaulted on "[section] key" (a boolean
   "true" spelled without "=", not "[section] key = true").

 * "git checkout -b foo" while on an unborn branch did not say
   "Switched to a new branch 'foo'" like other cases.

 * Various codepaths have workaround for a common misconfiguration to
   spell "UTF-8" as "utf8", but it was not used uniformly.  Most
   notably, mailinfo (which is used by "git am") lacked this support.

 * We failed to mention a file without any content change but whose
   permission bit was modified, or (worse yet) a new file without any
   content in the "git diff --stat" output.

 * When "--stat-count" hides a diffstat for binary contents, the total
   number of added and removed lines at the bottom was computed
   incorrectly.

 * When "--stat-count" hides a diffstat for unmerged paths, the total
   number of affected files at the bottom of the "diff --stat" output
   was computed incorrectly.

 * "diff --shortstat" miscounted the total number of affected files
   when there were unmerged paths.

 * "update-ref -d --deref SYM" to delete a ref through a symbolic ref
   that points to it did not remove it correctly.

----------------------------------------------------------------

Changes since v1.8.1-rc0 are as follows:

Jiang Xin (1):
      l10n: Update git.pot (5 new, 1 removed messages)

Junio C Hamano (3):
      Update draft release notes to 1.8.0.2
      Documentation/diff-config: work around AsciiDoc misfortune
      Git 1.8.1-rc1

Matthieu Moy (1):
      document that statusHints affects git checkout

Peter Krefting (1):
      l10n: Update Swedish translation (1979t0f0u)

Ralf Thielow (2):
      l10n: de.po: translate 825 new messages
      l10n: de.po: translate 22 new messages

Ramkumar Ramachandra (4):
      t4041 (diff-submodule-option): don't hardcode SHA-1 in expected outputs
      t4041 (diff-submodule-option): parse digests sensibly
      t4041 (diff-submodule-option): rewrite add_file() routine
      t4041 (diff-submodule-option): modernize style

Tran Ngoc Quan (1):
      l10n: vi.po: update to git-v1.8.0.1-347-gf94c3
