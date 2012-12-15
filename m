From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.8.1-rc2
Date: Sat, 15 Dec 2012 12:54:06 -0800
Message-ID: <7v7gojrq8h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Sat Dec 15 21:54:36 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Tjykj-0006ZB-Ra
	for glk-linux-kernel-3@plane.gmane.org; Sat, 15 Dec 2012 21:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138Ab2LOUyM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sat, 15 Dec 2012 15:54:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38245 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763Ab2LOUyK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Dec 2012 15:54:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81332AE1A;
	Sat, 15 Dec 2012 15:54:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=swgzKjfAkPe2+avVB7Q2/ZpUq
	KY=; b=RwaZwI7gFmoxJHYzb9BZ+ZBY8UrCcQz3k012X+bZt7GBbp1b1HXByvN4L
	+o+0Fwny0+IwaTR7o49rre27DYhWoh31Y5rbxV4R/WOATsKfT3bnpum0Y7/Wu+/J
	GiY+s6Wr8EdwMl67KNYzCwyTisxUT401q1HHw2LSwDiu6DRxHE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=GtNpip3E/qi31ruAV23
	UxsKp8APcbwdE7DPLrBUJ27CmWAITKhwmCeBOcYz5m64PYhTszNBIus5wQ6B56cC
	0ePDJ6vaK6kJR9z92p85fk9RuAYS7Y8jag6sONek+njXGRTmVta1HYspi4I4M1a9
	QuFH9DBpbD/TPG9whKIjQNh0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CDD8AE19;
	Sat, 15 Dec 2012 15:54:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5EB52AE16; Sat, 15 Dec 2012
 15:54:08 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 91F32220-46F9-11E2-BFBF-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211571>

A release candidate Git v1.8.1-rc2 is now available for testing
at the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

0a65a3d203b8d6e320f15abb040e1137e333c967  git-1.8.1.rc2.tar.gz
e6bc111686e6864cc3f078b9523ef1057a7fff8f  git-htmldocs-1.8.1.rc2.tar.gz
2c97472ae861454ff445868c40b49db66fa09f50  git-manpages-1.8.1.rc2.tar.gz

Also the following public repositories all have a copy of the v1.8.1-rc=
2
tag and the master branch that the tag points at:

  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git v1.8.1 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

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

 * "git format-patch" learned the "--notes=3D<ref>" option to give
   notes for the commit after the three-dash lines in its output.

 * "git log --grep=3D<pcre>" learned to honor the "grep.patterntype"
   configuration set to "perl".

 * "git replace -d <object>" now interprets <object> as an extended
   SHA-1 (e.g. HEAD~4 is allowed), instead of only accepting full hex
   object name.

 * "git rm $submodule" used to punt on removing a submodule working
   tree to avoid losing the repository embedded in it.  Because
   recent git uses a mechanism to separate the submodule repository
   from the submodule working tree, "git rm" learned to detect this
   case and removes the submodule working tree when it is safe to do so=
=2E

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


=46oreign Interface

 * "git cvsimport" can be told to record timezones (other than GMT)
   per-author via its author info file.

 * The remote helper interface to interact with subversion
   repositories (one of the GSoC 2012 projects) has been merged.

 * The documentation for git(1) was pointing at a page at an external
   site for the list of authors that no longer existed.  The link has
   been updated to point at an alternative site.


Performance, Internal Implementation, etc.

 * Compilation on Cygwin with newer header files are supported now.

 * A couple of low-level implementation updates on MinGW.

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


=46ixes since v1.8.0
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

 * "git log -F -E --grep=3D'<ere>'" failed to use the given <ere>
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
   "true" spelled without "=3D", not "[section] key =3D true").

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

Changes since v1.8.1-rc1 are as follows:

Anders Kaseorg (1):
      git-prompt: Document GIT_PS1_DESCRIBE_STYLE

Erik Faye-Lund (7):
      mingw: correct exit-code for SIGALRM's SIG_DFL
      mingw: make fgetc raise SIGINT if apropriate
      compat/terminal: factor out echo-disabling
      compat/terminal: separate input and output handles
      mingw: reuse tty-version of git_terminal_prompt
      mingw: get rid of getpass implementation
      mingw_rmdir: do not prompt for retry when non-empty

Jeff King (1):
      remote-testsvn: fix unitialized variable

Junio C Hamano (5):
      git(1): remove a defunct link to "list of authors"
      Git 1.8.0.2
      git-prompt.sh: update PROMPT_COMMAND documentation
      git(1): show link to contributor summary page
      Git 1.8.1-rc2

Manlio Perillo (1):
      git.txt: add missing info about --git-dir command-line option

Marc Khouzam (1):
      Add file completion to tcsh git completion.

Matthew Daley (1):
      Fix sizeof usage in get_permutations

Max Horn (6):
      git-remote-helpers.txt: document invocation before input format
      git-remote-helpers.txt: document missing capabilities
      git-remote-helpers.txt: minor grammar fix
      git-remote-helpers.txt: rearrange description of capabilities
      git-remote-helpers.txt: clarify command <-> capability correspond=
ences
      git-remote-helpers.txt: clarify options & ref list attributes

Stefano Lattarini (1):
      Makefile: whitespace style fixes in macro definitions

S=C3=A9bastien Loriot (1):
      Documentation/git-stash.txt: add a missing verb

Thomas Ackermann (1):
      Renumber list in api-command.txt
