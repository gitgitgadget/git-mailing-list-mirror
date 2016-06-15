From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.8.3-rc0
Date: Fri, 26 Apr 2013 17:22:22 -0700
Message-ID: <7vvc78u8jl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Sat Apr 27 02:22:49 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1UVsue-0006si-UZ
	for glk-linux-kernel-3@plane.gmane.org; Sat, 27 Apr 2013 02:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756860Ab3D0AWj (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 26 Apr 2013 20:22:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60559 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756652Ab3D0AWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Apr 2013 20:22:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69EE3D8A4;
	Sat, 27 Apr 2013 00:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=q
	oX27qMql3Qs2aKC3dTntOZb4KY=; b=sVFvcaHlyYrJPrItEUW9igB/EgtRqVcVZ
	RfGjy1lR7HaMEs0j/uye8DjKr6Dta1OveocUPEFCvk7GW5Z96Ua3s5TvdYmhIbQJ
	46AFz2cjyedjwCjKV5bba5CcZ/dNPSu3n9sew3CbxhFENSE/VKss1kaDCkT3EisL
	CzY0/pKLBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=SSGE6Y1ad9ahvX9La4l0fOo8aNi0FRvCHbYyrul94PQfiNHtlkuzu7Ga
	YSSntOI3XVZG5qrVyf1FTcPawa/ctj/iDDxlJKE/7lwEdmE38jKWJtB43Rl3Ji3S
	beZS/2Oerii/KPYcP3pfehWbwc2ofY9A3+sO36AilVI/H4CiKOM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 613B8D8A3;
	Sat, 27 Apr 2013 00:22:35 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B42F8D89E;
	Sat, 27 Apr 2013 00:22:33 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E3EF55C-AED0-11E2-999D-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222610>

A release candidate preview Git v1.8.3-rc0 is now available for
testing at the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

f0b0b415f0c693865895c1918859b12c4a7d5b17  git-1.8.3.rc0.tar.gz
089efc61b3d45504cb53003719d1bb3d953a41a8  git-htmldocs-1.8.3.rc0.tar.gz
57a6e889667597f2699e4d6fb97c8cf6e595cb4a  git-manpages-1.8.3.rc0.tar.gz

Also the following public repositories all have a copy of the v1.8.3-rc0
tag and the master branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

Git v1.8.3 Release Notes (draft)
========================

Backward compatibility notes (for Git 2.0)
------------------------------------------

When "git push [$there]" does not say what to push, we have used the
traditional "matching" semantics so far (all your branches were sent
to the remote as long as there already are branches of the same name
over there).  In Git 2.0, the default will change to the "simple"
semantics that pushes the current branch to the branch with the same
name, only when the current branch is set to integrate with that
remote branch.  There is a user preference configuration variable
"push.default" to change this.  If you are an old-timer who is used
to the "matching" semantics, you can set it to "matching" to keep the
traditional behaviour.  If you want to live in the future early,
you can set it to "simple" today without waiting for Git 2.0.

When "git add -u" and "git add -A", that does not specify what paths
to add on the command line is run from inside a subdirectory, these
commands will operate on the entire tree in Git 2.0 for consistency
with "git commit -a" and other commands. Because there will be no
mechanism to make "git add -u" behave as if "git add -u .", it is
important for those who are used to "git add -u" (without pathspec)
updating the index only for paths in the current subdirectory to start
training their fingers to explicitly say "git add -u ." when they mean
it before Git 2.0 comes.  A warning is issued when these commands are
run without a pathspec and when you have local changes outside the
current directory, because the behaviour in Git 2.0 will be different
from today's version in such a situation.

In Git 2.0, "git add <path>" will behave as "git add -A <path>", so
that "git add dir/" will notice paths you removed from the directory
and record the removal.  Versions before Git 2.0, including this
release, will keep ignoring removals, but the users who rely on this
behaviour is encouraged to use "git add --ignore-removal <path>" and
get used to it.


Updates since v1.8.2
--------------------

Foreign interface

 * remote-hg and remote-bzr helpers (in contrib/) have been updated.


UI, Workflows & Features

 * "git branch --vv" learned to paint the name of the branch it
   integrates with in a different color (color.branch.upstream,
   which defaults to blue).

 * In a sparsely populated working tree, "git checkout <pathspec>" no
   longer unmarks paths that match the given pathspec that were
   originally ignored with "--sparse" (use --ignore-skip-worktree-bits
   option to resurrect these paths out of the index if you really want
   to).

 * "git log --format" specifier learned %C(auto) token that tells Git
   to use color when interpolating %d (decoration), %h (short commit
   object name), etc. for terminal output.

 * "git bisect" leaves the final outcome as a comment in its bisect
   log file.

 * "git clone --reference" can now refer to a gitfile "textual symlink"
   that points at the real location of the repository.

 * "git count-objects" learned "--human-readable" aka "-H" option to
   show various large numbers in Ki/Mi/GiB scaled as necessary.

 * "git cherry-pick $blob" and "git cherry-pick $tree" are nonsense,
   and a more readable error message e.g. "can't cherry-pick a tree"
   is given (we used to say "expected exactly one commit").

 * The "--annotate" option to "git send-email" can be turned on (or
   off) by default with sendemail.annotate configuration variable (you
   can use --no-annotate from the command line to override it).

 * The "--cover-letter" option to "git format-patch" can be turned on
   (or off) by default with format.coverLetter configuration
   variable. By setting it to 'auto', you can turn it on only for a
   series with two or more patches.

 * The bash completion support (in contrib/) learned that cherry-pick
   takes a few more options than it already knew about.

 * "git help" learned "-g" option to show the list of guides just like
   list of commands are given with "-a".

 * A triangular "pull from one place, push to another place" workflow
   is supported better by new remote.pushdefault (overrides the
   "origin" thing) and branch.*.pushremote (overrides the
   branch.*.remote) configuration variables.

 * "git status" learned to report that you are in the middle of a
   revert session, just like it does for a cherry-pick and a bisect
   session.

 * The handling by "git branch --set-upstream-to" against various forms
   of erroneous inputs was suboptimal and has been improved.

 * When the interactive access to git-shell is not enabled, it issues
   a message meant to help the system administrator to enable it.
   An explicit way to help the end users who connect to the service by
   issuing custom messages to refuse such an access has been added.

 * In addition to the case where the user edits the log message with
   the "e)dit" option of "am -i", replace the "Applying: this patch"
   message with the final log message contents after applymsg hook
   munges it.

 * "git status" suggests users to look into using --untracked=no option
   when it takes too long.

 * "git status" shows a bit more information to "git status" during a
   rebase/bisect session.

 * "git fetch" learned to fetch a commit at the tip of an unadvertised
   ref by specifying a raw object name from the command line when the
   server side supports this feature.

 * Output from "git log --graph" works better with submodule log
   output now.

 * "git count-objects -v" learned to report leftover temporary
   packfiles and other garbage in the object store.

 * A new read-only credential helper (in contrib/) to interact with
   the .netrc/.authinfo files has been added.

 * "git send-email" can be used with the credential helper system.

 * There was no Porcelain way to say "I no longer am interested in
   this submodule", once you express your interest in a submodule with
   "submodule init".  "submodule deinit" is the way to do so.

 * "git pull --rebase" learned to pass "-v/-q" options to underlying
   "git rebase".

 * The new "--follow-tags" option tells "git push" to push relevant
   annotated tags when pushing branches out.

 * "git merge" and "git pull" can optionally be told to inspect and
   reject when merging a commit that does not carry a trusted GPG
   signature.

 * "git mergetool" now feeds files to the "p4merge" backend in the
   order that matches the p4 convention, where "theirs" is usually
   shown on the left side, which is the opposite from other backend
   expects.

 * "show/log" now honors gpg.program configuration just like other
   parts of the code that use GnuPG.

 * "git log" that shows the difference between the parent and the
   child has been optimized somewhat.

 * "git difftool" allows the user to write into the temporary files
   being shown; if the user makes changes to the working tree at the
   same time, one of the changes has to be lost in such a case, but it
   tells the user what happened and refrains from overwriting the copy
   in the working tree.

 * There was no good way to ask "I have a random string that came from
   outside world. I want to turn it into a 40-hex object name while
   making sure such an object exists".  A new peeling suffix ^{object}
   can be used for that purpose, together with "rev-parse --verify".


Performance, Internal Implementation, etc.

 * Updates for building under msvc.

 * A handful of issues in the code to traverse working tree to find
   untracked and/or ignored files have been fixed, and the general
   codepath involved in "status -u" and "clean" have been cleaned up
   and optimized.

 * The stack footprint of some codepaths that access an object from a
   pack has been shrunk.

 * The logic to coalesce the same lines removed from the parents in
   the output from "diff -c/--cc" has been updated, but with an O(n^2)
   complexity, so this might turn out to be undesirable.

 * The code to enforce permission bits on files in $GIT_DIR/ for
   shared repositories have been simplified.

 * A few codepaths knew how much data they need to put in the
   hashtables they use upfront, but still started from a small table
   repeatedly growing and rehashing.

 * The API to walk reflog entries from the latest to older, which was
   necessary for operations such as "git checkout -", was cumbersome
   to use correctly and also inefficient.

 * Codepaths that inspect log-message-to-be and decide when to add a
   new Signed-off-by line in various commands have been consolidated.

 * The pkt-line API, implementation and its callers have been cleaned
   up to make them more robust.

 * Cygwin port has a faster-but-lying lstat(2) emulation whose
   incorrectness does not matter in practice except for a few
   codepaths, and setting permission bits to directories is a codepath
   that needs to use a more correct one.

 * "git checkout" had repeated pathspec matches on the same paths,
   which have been consolidated.  Also a bug in "git checkout dir/"
   that is started from an unmerged index has been fixed.

 * A few bugfixes to "git rerere" working on corner case merge
   conflicts have been applied.


Also contains various documentation updates and code clean-ups.


Fixes since v1.8.2
------------------

Unless otherwise noted, all the fixes since v1.8.2 in the maintenance
track are contained in this release (see release notes to them for
details).

 * When receive-pack detects error in the pack header it received in
   order to decide which of unpack-objects or index-pack to run, it
   returned without closing the error stream, which led to a hang
   sideband thread.

 * Zsh completion forgot that '%' character used to signal untracked
   files needs to be escaped with another '%'.

 * A commit object whose author or committer ident are malformed
   crashed some code that trusted that a name, an email and an
   timestamp can always be found in it.

 * When "upload-pack" fails while generating a pack in response to
   "git fetch" (or "git clone"), the receiving side mistakenly said
   there was a programming error to trigger the die handler
   recursively.

 * "rev-list --stdin" and friends kept bogus pointers into input
   buffer around as human readble object names.  This was not a huge
   problem but was exposed by a new change that uses these names in
   error output.
   (merge 70d26c6 tr/copy-revisions-from-stdin later to maint).

 * Smart-capable HTTP servers were not restricted via the
   GIT_NAMESPACE mechanism when talking with commit-walker clients,
   like they do when talking with smart HTTP clients.
   (merge 6130f86 jk/http-dumb-namespaces later to maint).

 * "git merge-tree" did not omit a merge result that is identical to
   "our" side in certain cases.
   (merge aacecc3 jk/merge-tree-added-identically later to maint).

 * Perl scripts like "git-svn" closed (not redirecting to /dev/null)
   the standard error stream, which is not a very smart thing to do.
   Later open may return file descriptor #2 for unrelated purpose, and
   error reporting code may write into them.

 * "git show-branch" was not prepared to show a very long run of
   ancestor operators e.g. foobar^2~2^2^2^2...^2~4 correctly.

 * "git diff --diff-algorithm algo" is also understood as "git diff
   --diff-algorithm=algo".

 * The new core.commentchar configuration was not applied to a few
   places.

 * "git bundle" did not like a bundle created using a commit without
   any message as its one of the prerequistes.

 * "git log -S/-G" started paying attention to textconv filter, but
   there was no way to disable this.  Make it honor --no-textconv
   option.

 * When used with "-d temporary-directory" option, "git filter-branch"
   failed to come back to the original working tree to perform the
   final clean-up procedure.

 * "git merge $(git rev-parse v1.8.2)" behaved quite differently from
   "git merge v1.8.2", as if v1.8.2 were written as v1.8.2^0 and did
   not pay much attention to the annotated tag payload.  Make the code
   notice the type of the tag object, in addition to the dwim_ref()
   based classification the current code uses (i.e. the name appears
   in refs/tags/) to decide when to special case merging of tags.

 * Fix 1.8.1.x regression that stopped matching "dir" (without
   trailing slash) to a directory "dir".
   (merge efa5f82 jc/directory-attrs-regression-fix later to maint-1.8.1).

 * "git apply --whitespace=fix" was not prepared to see a line getting
   longer after fixing whitespaces (e.g. tab-in-indent aka Python).
   (merge 329b26e jc/apply-ws-fix-tab-in-indent later to maint-1.8.1).

 * The prompt string generator (in contrib/completion/) did not notice
   when we are in a middle of a "git revert" session.

 * "submodule summary --summary-limit" option did not support
   "--option=value" form.

 * "index-pack --fix-thin" used an uninitialized value to compute
   delta depths of objects it appends to the resulting pack.

 * "index-pack --verify-stat" used a few counters outside protection
   of mutex, possibly showing incorrect numbers.

 * The code to keep track of what directory names are known to Git on
   platforms with case insensitive filesystems can get confused upon a
   hash collision between these pathnames and looped forever.

 * Annotated tags outside refs/tags/ hierarchy were not advertised
   correctly to the ls-remote and fetch with recent version of Git.

 * Recent optimization broke shallow clones.

 * "git cmd -- ':(top'" was not diagnosed as an invalid syntax, and
   instead the parser kept reading beyond the end of the string.

 * "git tag -f <tag>" always said "Updated tag '<tag>'" even when
   creating a new tag (i.e. not overwriting nor updating).

 * "git p4" did not behave well when the path to the root of the P4
   client was not its real path.
   (merge bbd8486 pw/p4-symlinked-root later to maint).

 * "git archive" reports a failure when asked to create an archive out
   of an empty tree.  It would be more intuitive to give an empty
   archive back in such a case.

 * When "format-patch" quoted a non-ascii strings on the header files,
   it incorrectly applied rfc2047 and chopped a single character in
   the middle of it.

 * An aliased command spawned from a bare repository that does not say
   it is bare with "core.bare = yes" is treated as non-bare by mistake.

 * In "git reflog expire", REACHABLE bit was not cleared from the
   correct objects.

 * The logic used by "git diff -M --stat" to shorten the names of
   files before and after a rename did not work correctly when the
   common prefix and suffix between the two filenames overlapped.

 * The "--match=<pattern>" option of "git describe", when used with
   "--all" to allow refs that are not annotated tags to be used as a
   base of description, did not restrict the output from the command
   to those that match the given pattern.

 * Clarify in the documentation "what" gets pushed to "where" when the
   command line to "git push" does not say these explicitly.

 * The "--color=<when>" argument to the commands in the diff family
   was described poorly.

 * The arguments given to pre-rebase hook were not documented.

 * The v4 index format was not documented.

 * The "--match=<pattern>" argument "git describe" takes uses glob
   pattern but it wasn't obvious from the documentation.

 * Some sources failed to compile on systems that lack NI_MAXHOST in
   their system header (e.g. z/OS).

 * Add an example use of "--env-filter" in "filter-branch"
   documentation.

 * "git bundle verify" did not say "records a complete history" for a
   bundle that does not have any prerequisites.

 * In the v1.8.0 era, we changed symbols that do not have to be global
   to file scope static, but a few functions in graph.c were used by
   CGit from sideways bypassing the entry points of the API the
   in-tree users use.

 * "git update-index -h" did not do the usual "-h(elp)" thing.

 * "git index-pack" had a buffer-overflow while preparing an
   informational message when the translated version of it was too
   long.

 * 'git commit -m "$msg"' used to add an extra newline even when
   $msg already ended with one.

 * The SSL peer verification done by "git imap-send" did not ask for
   Server Name Indication (RFC 4366), failing to connect SSL/TLS
   sites that serve multiple hostnames on a single IP.

 * perl/Git.pm::cat_blob slurped everything in core only to write it
   out to a file descriptor, which was not a very smart thing to do.

 * "git branch" did not bother to check nonsense command line
   parameters and issue errors in many cases.

 * Verification of signed tags were not done correctly when not in C
   or en/US locale.

 * Some platforms and users spell UTF-8 differently; retry with the
   most official "UTF-8" when the system does not understand the
   user-supplied encoding name that are the common alternative
   spellings of UTF-8.

 * When export-subst is used, "zip" output recorded incorrect
   size of the file.

 * "git am $maildir/" applied messages in an unexpected order; sort
   filenames read from the maildir/ in a way that is more likely to
   sort messages in the order the writing MUA meant to, by sorting
   numeric segment in numeric order and non-numeric segment in
   alphabetical order.

 * "git submodule update", when recursed into sub-submodules, did not
   accumulate the prefix paths.
