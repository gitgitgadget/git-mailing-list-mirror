From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Sep 2010, #05; Wed, 15)
Date: Wed, 15 Sep 2010 15:19:18 -0700
Message-ID: <7viq266461.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 16 00:19:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ow0KD-0005ON-HQ
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 00:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861Ab0IOWTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 18:19:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53586 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab0IOWTY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 18:19:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 838B5D6425;
	Wed, 15 Sep 2010 18:19:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=4Q0a
	jzq28OGR3klw3TcFoX6MaAI=; b=PucyYopJhqdSmZOGrfj9zJ33aoyeYwQiUWA/
	c1Ym1n9h2BP8tMNLy5b275+L3A/LiD/ZjAJWBdk5h5z2NUBifxFkzVperKapwFC2
	qoPSmZY1fLBDWxgqh43tCZkhuM9coyNBIfpOyv1qKGp8787p5AKlqnj2gOFJz8II
	uAsqhs0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=g8o
	DYSGdnGfgEXTtEzCQU7CpJLy3b/qtGH7cJZaRRzZR2VsI6iZMQ8Rl+oFSScYOys5
	xYtLww5E3Y00ujrox5AufHAwr6I1wybH49FfLJ+gFMkxYZXUMh6GT/Yirb26KrAK
	JF1breMaZoPG4VRLxQ+fmNpw34Lp3J1rXSZn29Vc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 718D0D6423;
	Wed, 15 Sep 2010 18:19:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 408BAD6422; Wed, 15 Sep
 2010 18:19:20 -0400 (EDT)
X-master-at: 7e100effc6c3a8acbb4bf305638c7b324a63236d
X-next-at: bf93f8322c5e01b030ee9a1d3dee19e4d4dbd2d7
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4A993938-C117-11DF-9086-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156262>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

The tip of 'master' is now at 1.7.3-rc2; I am hoping that we can do the
real 1.7.3 release perhaps this weekend.  Please give it a final round of
beating so that we can find and fix the last minute regressions.

Thanks.

--------------------------------------------------
[Graduated to "master"]

* ch/filter-branch-deprecate-remap-to-ancestor (2010-08-27) 1 commit
  (merged to 'next' on 2010-09-10 at f91d974)
 + filter-branch: retire --remap-to-ancestor

* ch/maint-cannot-create-bundle-error (2010-08-27) 1 commit
  (merged to 'next' on 2010-09-10 at ba139f1)
 + bundle: detect if bundle file cannot be created

* dr/maint-ls-tree-prefix-recursion-fix (2010-09-11) 1 commit
  (merged to 'next' on 2010-09-12 at c9d05a6)
 + ls-tree $di $dir: do not mistakenly recurse into directories

* jl/fix-test (2010-09-07) 7 commits
  (merged to 'next' on 2010-09-10 at 849b1bb)
 + t1020: Get rid of 'cd "$HERE"' at the start of each test
 + t2016 (checkout -p): add missing &&
 + t1302 (core.repositoryversion): style tweaks
 + t2105 (gitfile): add missing &&
 + t1450 (fsck): remove dangling objects
 + tests: subshell indentation stylefix
 + Merge branch 'jl/maint-fix-test'
 (this branch uses jl/maint-fix-test.)

* jl/maint-fix-test (2010-09-06) 1 commit
 + Several tests: cd inside subshell instead of around
 (this branch is used by jl/fix-test.)

* ks/recursive-rename-add-identical (2010-09-01) 1 commit
  (merged to 'next' on 2010-09-03 at 1a5082f)
 + RE: [PATCH] Avoid rename/add conflict when contents are identical

* os/fix-rebase-diff-no-prefix (2010-09-09) 1 commit
  (merged to 'next' on 2010-09-10 at f1acd10)
 + Add --src/dst-prefix to git-formt-patch in git-rebase.sh

--------------------------------------------------
[New Topics]

* ab/send-email-catfile (2010-09-14) 1 commit
 - send-email: use catfile() to concatenate files

Sane; should be safe to be among the first batch after 1.7.3 release.

* bg/fix-t7003 (2010-09-10) 1 commit
  (merged to 'next' on 2010-09-13 at 9d7756e)
 + t7003: Use test_commit instead of custom function

Sane; should be safe to be among the first batch after 1.7.3 release.

* jc/grep-header-all-match-fix (2010-09-12) 2 commits
 - log --author: take union of multiple "author" requests
 - grep: move logic to compile header pattern into a separate helper
 (this branch is used by jc/grep-header-all-match-fix-debug.)

We might want to give a more comprehensive revamp to the "filter by
grepping the commit log message" feature some day, somehow allowing the
full "git grep" boolean expression.  But until then, this should suffice.

* jc/grep-header-all-match-fix-debug (2010-09-13) 1 commit
 - grep debugging, just in case
 (this branch uses jc/grep-header-all-match-fix.)

* jc/no-branch-name-with-dash-at-front (2010-09-14) 1 commit
 - disallow branch names that start with a hyphen

This also came up at $WORK; should be safe to be among the first batch
after 1.7.3 release.

* dm/mergetool-vimdiff (2010-09-14) 2 commits
 - mergetool-lib: add a three-way diff view for vim/gvim
 - mergetool-lib: combine vimdiff and gvimdiff run blocks

The bottom one should be without controversy.  I don't use vimdiff, so
cannot comment on the other one.

--------------------------------------------------
[Stalled]

* cb/ignored-paths-are-precious (2010-08-21) 1 commit
 - checkout/merge: optionally fail operation when ignored files need to be overwritten

I fixed up a trivial error in the configuration parser (which didn't
return immediately after parsing), and while at it flipped the default 
value of the configuration and the command line option to false.

This probably needs tests; also we know of longstanding bugs in related
area that needs to be addressed---they do not have to be part of this
series but their reproduction recipe would belong to the test script for
this topic.

It may hurt users to make the new feature on by default, especially the
ones with subdirectories that come and go.  For a patch that changes a
long established semantics, it came a bit late in the cycle, so it will
have to wait until the next release.

* jj/icase-directory (2010-08-16) 6 commits
  (merged to 'next' on 2010-08-26 at 9d8e1bc)
 + Support case folding in git fast-import when core.ignorecase=true
 + Support case folding for git add when core.ignorecase=true
 + Add case insensitivity support when using git ls-files
 + Add case insensitivity support for directories when using git status
 + Case insensitivity support for .gitignore via core.ignorecase
 + Add string comparison functions that respect the ignore_case variable.

Depends on GNU FNM_CASEFOLD.  Presumably a bit of tweak in Makefile for
non-windows but non-GNU platforms is all it takes?

* il/rfc-remote-fd-ext (2010-08-26) 7 commits
 - remote-ext/fd style fixup
 - Fix build on Windows
 - Simplify send_git_request()
 - Rewrite bidirectional traffic loop
 - gitignore: Ignore the new /git-remote-{ext,fd} helpers
 - New remote helper: git-remote-ext
 - New remote helper git-remote-fd

Needs a bit of usage illustration (this does not seem to come with any
documentation nor tests).

* zl/mailinfo-recode-patch (2010-06-14) 2 commits
 - add --recode-patch option to git-am
 - add --recode-patch option to git-mailinfo

I recall there was another round of re-roll planned for this one.

* jk/tag-contains (2010-07-05) 4 commits
 - Why is "git tag --contains" so slow?
 - default core.clockskew variable to one day
 - limit "contains" traversals based on commit timestamp
 - tag: speed up --contains calculation

The idea of the bottom one is probably Ok, except that the use of object
flags needs to be rethought, or at least the helper needs to be moved to
builtin/tag.c to make it clear that it should not be used outside the
current usage context.

* bc/describe-not-dirty-for-untracked-paths-in-submodule (2010-09-09) 1 commit
 - builtin/describe.c: ignore untracked changes in submodules

--------------------------------------------------
[Cooking]

* by/line-log (2010-09-11) 18 commits
  (merged to 'next' on 2010-09-12 at e29a029)
 + log -L: do not free parents lists we might need again
  (merged to 'next' on 2010-08-26 at a160ff1)
 + Document line history browser
 + Add tests for line history browser
 + Add --full-line-diff option
 + Add --graph prefix before line history output
 + Add parent rewriting to line history browser
 + Make graph_next_line external to other part of git
 + Make rewrite_parents public to other part of git
 + Hook line history into cmd_log, ensuring a topo-ordered walk
 + Print the line log
 + map/take range to the parent of commits
 + Add range clone functions
 + Export three functions from diff.c
 + Parse the -L options
 + Refactor parse_loc
 + Add the basic data structure for line level history
 + parse-options: add two helper functions
 + parse-options: enhance STOP_AT_NON_OPTION

How would one trace history of lines 440,450 in t/t7300-clean.sh starting
from the tip of 'pu'?  "git log -p -L 440,450 pu -- t/t7300-clean.sh"
would be the most natural but it does not work (it wants "pu" to be a
path).  "git log -p -L 440,450 t/t7300-clean.sh pu" doesn't work either.

The command line parser of this series needs to be rethought (didn't I say
that many times?  Perhaps I was ignored).  Might want to kick this out of
'next' and move to the stalled category after 1.7.3.

* jn/gitweb-test-lib (2010-09-12) 2 commits
  (merged to 'next' on 2010-09-12 at 4621733)
 + t/gitweb-lib.sh: Use tabs for indent consistently
 + t/gitweb-lib.sh: Use GIT_BUILD_DIR

Sane; should be safe to be among the first batch after 1.7.3 release.

* nd/index-doc (2010-09-06) 1 commit
  (merged to 'next' on 2010-09-10 at 2ab8572)
 + doc: technical details about the index file format

Half-written but it is a good start.  I may need to give some help in
describing more recent index extensions.

* tr/send-email-refuse-sending-unedited-cover-letter (2009-06-08) 1 commit
 - send-email: Refuse to send cover-letter template subject

Sane; should be safe to be among the first batch after 1.7.3 release.

* bc/fortran-userdiff (2010-09-10) 1 commit
  (merged to 'next' on 2010-09-10 at b76b831)
 + userdiff.c: add builtin fortran regex patterns

Sane; should be safe to be among the first batch after 1.7.3 release.

* en/rename-d-f (2010-09-08) 2 commits
  (merged to 'next' on 2010-09-15 at d6a2e1e)
 + merge-recursive: D/F conflicts where was_a_dir/file -> was_a_dir
 + t3509: Add rename + D/F conflict testcase that recursive strategy fails

I am not entirely convinced this is a regression free band-aid; need to
look at this a few more times.

* jk/read-tree-empty (2010-09-10) 1 commit
  (merged to 'next' on 2010-09-10 at 2f3a995)
 + read-tree: deprecate syntax without tree-ish args

Sane; should be safe to be among the first batch after 1.7.3 release.

* kf/post-receive-sample-hook (2010-09-10) 1 commit
  (merged to 'next' on 2010-09-10 at 53ebeba)
 + post-receive-email: ensure sent messages are not empty

I notice that it uses "PAGER= generate_email" where generate_email is a
shell function, which may break in some implementations of POSIX /bin/sh.
This is not a regression (the original also had the same issue), but
somebody who cares enough might want to look into it.

* ml/completion-zsh (2010-09-06) 1 commit
  (merged to 'next' on 2010-09-10 at b509ebc)
 + completion: make compatible with zsh

Comments from bash users regarding regressions?

* po/sendemail (2010-09-06) 3 commits
  (merged to 'next' on 2010-09-10 at d39274d)
 + New send-email option smtpserveroption.
 + Remove @smtp_host_parts variable as not used.
 + Minor indentation fix.

Comments from potential users?

* rr/format-patch-count-without-merges (2010-08-28) 2 commits
  (merged to 'next' on 2010-09-10 at c23bd48)
 + format-patch: Don't go over merge commits
 + t4014-format-patch: Call test_tick before committing

Should be safe to be among the first batch after 1.7.3 release.

* as/daemon-multi-listen (2010-08-29) 2 commits
  (merged to 'next' on 2010-09-10 at 69e4b23)
 + daemon: allow more than one host address given via --listen
 + daemon: add helper function setup_named_sock()

I think the idea is sound.  It probably needs a bit more polish.

If you give two --listen options and got some but not all sockets, the
code does not say anything even when no socket was created for one of
them, which is questionable.  Might want to kick this out of 'next' and
move to the stalled category after 1.7.3.

* jc/pickaxe-grep (2010-08-31) 4 commits
  (merged to 'next' on 2010-09-10 at 3604fc3)
 + diff/log -G<pattern>: tests
 + git log/diff: add -G<regexp> that greps in the patch text
 + diff: pass the entire diff-options to diffcore_pickaxe()
 + gitdiffcore doc: update pickaxe description

This is a re-roll of "grepping inside the log -p output" which is a
feature that is often asked for when people hear about -S option.

Should be safe to be among the first batch after 1.7.3 release.

* jl/fetch-submodule-recursive (2010-08-30) 2 commits
  (merged to 'next' on 2010-09-10 at 67a5138)
 + Submodules: Add the new "fetch" config option for fetch and pull
 + fetch/pull: Recursively fetch populated submodules

Further work expected after 1.7.3 between Jens and Kevin.

* en/object-list-with-pathspec (2010-08-26) 2 commits
 - Make rev-list --objects work together with pathspecs
 - Add testcases showing how pathspecs are ignored with rev-list --objects

There is a reroll helped by Duy, which I expect to be rerolled after
en/tree-walk-optim hits master.

* jf/merge-ignore-ws (2010-08-26) 4 commits
  (merged to 'next' on 2010-09-15 at bf93f83)
 + merge-recursive: options to ignore whitespace changes
 + merge-recursive --patience
 + ll-merge: replace flag argument with options struct
 + merge-recursive: expose merge options for builtin merge

Possibly one of the star features of the release after 1.7.3, whether it
is called 1.7.4 or 1.8.0.

* rr/fmt-merge-msg (2010-09-08) 5 commits
  (merged to 'next' on 2010-09-10 at 40fe79e)
 + t6200-fmt-merge-msg: Exercise '--log' to configure shortlog length
 + t6200-fmt-merge-msg: Exercise 'merge.log' to configure shortlog length
 + merge: Make 'merge.log' an integer or boolean option
 + merge: Make '--log' an integer option for number of shortlog entries
 + fmt_merge_msg: Change fmt_merge_msg API to accept shortlog_len

Should be safe to be among the first batch after 1.7.3 release.

* tr/merge-unborn-clobber (2010-08-22) 1 commit
 - Exhibit merge bug that clobbers index&WT

* en/tree-walk-optim (2010-08-26) 4 commits
  (merged to 'next' on 2010-09-10 at 65a9cde)
 + diff_tree(): Skip skip_uninteresting() when all remaining paths interesting
 + tree_entry_interesting(): Make return value more specific
 + tree-walk: Correct bitrotted comment about tree_entry()
 + Document pre-condition for tree_entry_interesting

Need to look at this a few more times to convince myself that this is Ok;
will happen after 1.7.3.

* po/etc-gitattributes (2010-09-01) 1 commit
  (merged to 'next' on 2010-09-10 at c503fd5)
 + Add global and system-wide gitattributes

Sane; should be safe to be among the first batch after 1.7.3 release.

* gb/shell-ext (2010-08-27) 6 commits
  (merged to 'next' on 2010-08-27 at e1ef3c1)
 + shell: Display errors from improperly-formatted command lines
 + Merge branch 'gb/split-cmdline-errmsg' into gb/shell-ext
  (merged to 'next' on 2010-08-24 at 49ea7b8)
 + shell: Rewrite documentation and improve error message
 + Add sample commands for git-shell
 + Add interactive mode to git-shell for user-friendliness
 + Allow creation of arbitrary git-shell commands

Should be safe to be among the first batch after 1.7.3 release.

* ab/i18n (2010-09-14) 140 commits
 - gettextize: git-bisect bisect_next_check "You need to" message
 - gettextize: git-bisect [Y/n] messages
 - gettextize: git-bisect bisect_replay + $1 messages
 - gettextize: git-bisect bisect_reset + $1 messages
 - gettextize: git-bisect bisect_run + $@ messages
 - gettextize: git-bisect die + eval_gettext messages
 - gettextize: git-bisect die + gettext messages
 - gettextize: git-bisect echo + eval_gettext message
 - gettextize: git-bisect echo + gettext messages
 - gettextize: git-bisect gettext + echo message
 - gettextize: git-bisect add git-sh-i18n
 - gettextize: git-stash drop_stash say/die messages
 - gettextize: git-stash "unknown option" message
 - gettextize: git-stash die + eval_gettext $1 messages
 - gettextize: git-stash die + eval_gettext $* messages
 - gettextize: git-stash die + eval_gettext messages
 - gettextize: git-stash die + gettext messages
 - gettextize: git-stash say + gettext messages
 - gettextize: git-stash echo + gettext message
 - gettextize: git-stash add git-sh-i18n
 - gettextize: git-submodule "blob" and "submodule" messages
 - gettextize: git-submodule "path not initialized" message
 - gettextize: git-submodule "[...] path is ignored" message
 - gettextize: git-submodule "Entering [...]" message
 - gettextize: git-submodule $errmsg messages
 - gettextize: git-submodule "Submodule change[...]" messages
 - gettextize: git-submodule "cached cannot be used" message
 - gettextize: git-submodule $update_module say + die messages
 - gettextize: git-submodule die + eval_gettext messages
 - gettextize: git-submodule say + eval_gettext messages
 - gettextize: git-submodule echo + eval_gettext messages
 - gettextize: git-submodule add git-sh-i18n
 - gettextize: git-pull "rebase against" / "merge with" messages
 - gettextize: git-pull "[...] not currently on a branch" message
 - gettextize: git-pull "You asked to pull" message
 - gettextize: git-pull split up "no candidate" message
 - gettextize: git-pull eval_gettext + warning message
 - gettextize: git-pull eval_gettext + die message
 - gettextize: git-pull die messages
 - gettextize: git-pull add git-sh-i18n
 - gettext docs: add "Testing marked strings" section to po/README
 - gettext docs: the Git::I18N Perl interface
 - gettext docs: the git-sh-i18n.sh Shell interface
 - gettext docs: the gettext.h C interface
 - gettext docs: add "Marking strings for translation" section in po/README
 - gettext docs: add a "Testing your changes" section to po/README
 - po/hi.po: add Hindi Translation
 - po/pl.po: add Polish translation
 - po/en_GB.po: add British English translation
 - po/de.po: add German translation
 - po/is.po: add Icelandic translation
 - Makefile: only add gettext tests on XGETTEXT_INCLUDE_TESTS=YesPlease
 - gettext docs: add po/README file documenting Git's gettext
 - gettextize: git-am printf(1) message to eval_gettext
 - gettextize: git-am core say messages
 - gettextize: git-am "Apply?" message
 - gettextize: git-am clean_abort messages
 - gettextize: git-am cannot_fallback messages
 - gettextize: git-am die messages
 - gettextize: git-am eval_gettext messages
 - gettextize: git-am multi-line getttext $msg; echo
 - gettextize: git-am one-line gettext $msg; echo
 - gettextize: git-am add git-sh-i18n
 - gettext: add GETTEXT_POISON tests for shell scripts
 - gettext: add GETTEXT_POISON support for shell scripts
 - Makefile: MSGFMT="msgfmt --check" under GNU_GETTEXT
 - Makefile: add GNU_GETTEXT, set when we expect GNU gettext
 - gettextize: git-shortlog basic messages
 - gettextize: git-revert split up "could not revert/apply" message
 - gettextize: git-revert literal "me" messages
 - gettextize: git-revert "Your local changes" message
 - gettextize: git-revert basic messages
 - gettextize: git-notes "Refusing to %s notes in %s" message
 - gettextize: git-notes GIT_NOTES_REWRITE_MODE error message
 - gettextize: git-notes basic commands
 - gettextize: git-gc "Auto packing the repository" message
 - gettextize: git-gc basic messages
 - gettextize: git-describe basic messages
 - gettextize: git-clean clean.requireForce messages
 - gettextize: git-clean basic messages
 - gettextize: git-bundle basic messages
 - gettextize: git-archive basic messages
 - gettextize: git-status shortstatus messages
 - gettextize: git-status basic messages
 - gettextize: git-push basic messages
 - gettextize: git-tag tag_template message
 - gettextize: git-tag basic messages
 - gettextize: git-reset reset_type_names messages
 - gettextize: git-reset basic messages
 - gettextize: git-rm basic messages
 - gettextize: git-mv "bad" messages
 - gettextize: git-mv basic messages
 - gettextize: git-merge basic messages
 - gettextize: git-log basic messages
 - gettextize: git-grep basic messages
 - gettextize: git-fetch split up "(non-fast-forward)" message
 - gettextize: git-fetch update_local_ref messages
 - gettextize: git-fetch formatting messages
 - gettextize: git-fetch basic messages
 - gettextize: git-diff basic messages
 - gettextize: git-commit advice messages
 - gettextize: git-commit formatting messages
 - gettextize: git-commit basic messages
 - gettextize: git-checkout "Switched to a .. branch" message
 - gettextize: git-checkout describe_detached_head messages
 - gettextize: git-checkout basic messages
 - gettextize: git-checkout: our/their version message
 - gettextize: git-branch "(no branch)" message
 - gettextize: git-branch "git branch -v" messages
 - gettextize: git-branch "remote branch '%s' not found" message
 - gettextize: git-branch basic messages
 - gettextize: git-add refresh_index message
 - gettextize: git-add basic messages
 - gettextize: git-clone "Cloning into" message
 - gettextize: git-clone basic messages
 - gettext tests: skip breaking tests under GETTEXT_POISON
 - gettext tests: skip lib-gettext.sh tests under GETTEXT_POISON
 - gettext tests: add GETTEXT_POISON=YesPlease Makefile parameter
 - gettext tests: remove old sanity test under NO_GETTEXT
 - gettext tests: test message re-encoding under C
 - gettext tests: mark a test message as not needing translation
 - gettext tests: test re-encoding with a UTF-8 msgid under Shell
 - gettext tests: test message re-encoding under Shell
 - gettext tests: add detection for is_IS.ISO-8859-1 locale
 - gettext tests: update test/is.po to match t/t0200/test.c
 - gettext tests: test if $VERSION exists before using it
 - gettext.c: work around us not using setlocale(LC_CTYPE, "")
 - gettext: localize the main git-init message
 - gettext: make the simple parts of git-init localizable
 - builtin.h: Include gettext.h
 - Makefile: use variables and shorter lines for xgettext
 - Makefile: tell xgettext(1) that our source is in UTF-8
 - Makefile: provide a --msgid-bugs-address to xgettext(1)
 - Makefile: A variable for options used by xgettext(1) calls
 - gettext tests: locate i18n lib&data correctly under --valgrind
 - gettext: setlocale(LC_CTYPE, "") breaks Git's C function assumptions
 - gettext tests: rename test to work around GNU gettext bug
 - gettext: add infrastructure for translating Git with gettext
 - builtin: use builtin.h for all builtin commands
 - tests: use test_cmp instead of piping to diff(1)
