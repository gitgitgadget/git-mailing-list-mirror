From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Apr 2010, #06; Sat, 17)
Date: Sat, 17 Apr 2010 23:16:00 -0700
Message-ID: <7v7ho5xp3z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 18 08:16:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3Nnz-0007Lg-00
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 08:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447Ab0DRGQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 02:16:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43833 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228Ab0DRGQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 02:16:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1115DAB496;
	Sun, 18 Apr 2010 02:16:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=6fLA
	gST07FxdEkE9H0xz+BSiDUE=; b=X3lTL7ljVTHf1YjpqzC5EYof14IQtS9Dedg1
	C9bbqvJ+E5TCcZV4JAix4oiZTxU4vcBNUMJn5ff5ObLm31vfX7xYXzHZ3BT1h9bs
	xtiqdtK64jWRUajbJkkNTDRPCG4RPoEcdp7quq9wuW1GhM/OPD8esHRLcaV8FVdI
	iCRDt8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Hm6
	hXaxX9QY29SbWnYFPCHcPk4/U2e9kHMYpQJZgv2liHJaQpA2b1vppGDCI1kT8LHE
	G6zW1XdU6BemF6tfa14B2gBjyuJT80D72u26ZALKwxTVqiRHBezxXWtGUARBwFMV
	GG9aHTsNFeNCOkWaBpWt/oTSfN0lGQGPnALO1S40=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F2B39AB491;
	Sun, 18 Apr 2010 02:16:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE6AFAB48E; Sun, 18 Apr
 2010 02:16:01 -0400 (EDT)
X-master-at: f3bd6ab7ea7b35ca5f26f106eb00a00f257716d7
X-next-at: 22727aa2c81752284a340d8f7b0dd7df7aecf06f
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DE0FEDD8-4AB1-11DF-A93B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145215>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

I'll soon be tagging 1.7.1-rc2; please test 'master', report & fix
regressions.

--------------------------------------------------
[New Topics]

* jk/maint-diffstat-overflow (2010-04-17) 1 commit
 - diff: use large integers for diffstat calculations

* jn/t7006-fixup (2010-04-14) 1 commit
 - t7006: guard cleanup with test_expect_success

* js/maint-receive-pack-symref-alias (2010-04-15) 2 commits
 - receive-pack: ignore duplicated commands which can occur with symrefs
 - receive-pack: Switch global variable 'commands' to a parameter

* sp/maint-dumb-http-pack-reidx (2010-04-17) 11 commits
 - http-fetch: Use temporary files for pack-*.idx until verified
 - http-fetch: Use index-pack rather than verify-pack to check packs
 - Allow parse_pack_index on temporary files
 - Extract verify_pack_index for reuse from verify_pack
 - Introduce close_pack_index to permit replacement
 - http.c: Remove unnecessary strdup of sha1_to_hex result
 - http.c: Don't store destination name in request structures
 - http.c: Drop useless != NULL test in finish_http_pack_request
 - http.c: Tiny refactoring of finish_http_pack_request
 - t5550-http-fetch: Use subshell for repository operations
 - http.c: Remove bad free of static block

* wp/doc-filter-direction (2010-04-17) 1 commit
 - documentation: clarify direction of core.autocrlf

--------------------------------------------------
[Graduated to "master"]

* jc/doc-submit-gmail (2010-04-07) 1 commit
  (merged to 'next' on 2010-04-10 at cd4e8cf)
 + SubmittingPatches: update GMail section

--------------------------------------------------
[Stalled]

* rr/remote-helper-doc (2010-04-07) 3 commits
 - Documentation/remote-helpers: Add invocation section
 - Documentation/urls: Rewrite to accomodate <transport>::<address>
 - Documentation/remote-helpers: Rewrite description

I'd like acks or rewrites from transport people on this topic.

* js/rebase-origin-x (2010-02-05) 1 commit
 - [RFC w/o test and incomplete] rebase: add -x option to record original commit name

I retract my objection against the idea of -x; needs polishing before
moving forward.

* js/grep-open (2010-03-26) 2 commits
 - grep -O: allow optional argument specifying the pager (or editor)
 - grep: Add the option '--open-files-in-pager'
 (this branch is used by jp/hold-string-list-sanity.)

Probably needs to support --no-index mode as well.

* jp/hold-string-list-sanity (2010-04-06) 9 commits
 . string_list: Fix argument order for string_list_append
 . Merge branch 'sr/remote-helper-export' into HEAD
 . Merge branch 'js/grep-open' into HEAD
 . Merge branch 'sb/fmt-merge-msg' into HEAD
 . string_list: Fix argument order for string_list_lookup
 . string_list: Fix argument order for string_list_insert_at_index
 . string_list: Fix argument order for string_list_insert
 . string_list: Fix argument order for for_each_string_list
 . string_list: Fix argument order for print_string_list
 (this branch uses js/grep-open and sr/remote-helper-export.)

Building this on top of slushy codebase is not a very promising endeavor.
Good thing to do, but bad timing.

--------------------------------------------------
[Cooking]

* hg/id-munging (2010-04-06) 2 commits
 - convert: Keep foreign $Id$ on checkout.
 - convert: Safer handling of $Id$ contraction.

* jn/submodule-basic-test (2010-04-10) 3 commits
 - t7400: clarify submodule update tests
 - t7400: clarify 'submodule add' tests
 - t7400: split setup into multiple tests

* np/index-pack-memsave (2010-04-12) 3 commits
 - index-pack: smarter memory usage when appending objects
 - index-pack: rationalize unpack_entry_data()
 - index-pack: smarter memory usage when resolving deltas

* jg/auto-initialize-notes-with-percent-n-in-format (2010-04-13) 1 commit
 - pretty: Initialize notes if %N is used

* jc/am-3-show-corrupted-patch (2010-04-09) 1 commit
 - am -3: recover the diagnostic messages for corrupt patches

* jc/maint-no-reflog-expire-unreach-for-head (2010-04-09) 3 commits
 - reflog --expire-unreachable: special case entries in "HEAD" reflog
 - more war on "sleep" in tests
 - Document gc.<pattern>.reflogexpire variables
 (this branch uses jc/maint-reflog-expire-unreachable.)

Rerolled; instead of ignoring the configuration like the previous round
did, this one prunes stale entries that are unreachable from any ref from
the reflog of HEAD.

* cw/maint-exec-defpath (2010-04-15) 2 commits
 - autoconf: Check if <paths.h> exists and set HAVE_PATHS_H
 - exec_cmd.c: replace hard-coded path list with one from <paths.h>

* tr/word-diff (2010-04-14) 1 commit
 - diff: add --word-diff option that generalizes --color-words

There are gitk patches that go with this series.

* sp/maint-describe-tiebreak-with-tagger-date (2010-04-12) 5 commits
 - describe: Break annotated tag ties by tagger date
 - tag.c: Parse tagger date (if present)
 - tag.c: Refactor parse_tag_buffer to be saner to program
 - tag.h: Remove unused signature field
 - tag.c: Correct indentation

* bg/apply-blank-trailing-context (2010-04-08) 1 commit
  (merged to 'next' on 2010-04-14 at a393c0b)
 + apply: Allow blank *trailing* context lines to match beyond EOF

* bg/send-email-smtpdomain (2010-04-10) 4 commits
  (merged to 'next' on 2010-04-14 at 88fff99)
 + send-email: Cleanup smtp-domain and add config
 + Document send-email --smtp-domain
 + send-email: Don't use FQDNs without a '.'
 + send-email: Cleanup { style

* rc/ls-remote-default (2010-04-09) 1 commit
  (merged to 'next' on 2010-04-14 at d5081bd)
 + ls-remote: fall-back to default remotes when no remote specified

* rc/maint-curl-helper (2010-04-08) 3 commits
  (merged to 'next' on 2010-04-14 at 2eb9177)
 + remote-curl: ensure that URLs have a trailing slash
 + http: make end_url_with_slash() public
 + t5541-http-push: add test for URLs with trailing slash

* hg/maint-attr-fix (2010-04-06) 3 commits
  (merged to 'next' on 2010-04-14 at a27c7d7)
 + attr: Expand macros immediately when encountered.
 + attr: Allow multiple changes to an attribute on the same line.
 + attr: Fixed debug output for macro expansion.

* jc/status-show-ignored (2010-04-10) 5 commits
 - status: --ignored option shows ignored files
 - wt-status: rename and restructure status-print-untracked
 - wt-status: collect ignored files
 - wt-status: plug memory leak while collecting untracked files
 - wt-status: remove unused workdir_untracked member

This is merely an illustration patch.  I am negative about conflating the
JSON output to the mix at this point.  If we are going to add JSON option
to everywhere we would generate "machine readable" output with the -z
and/or --porcelain options, that is fine, but let's stabilize "status"
with the existing --porcelain/-z option first.

* eb/unpretty-b-format (2010-03-24) 1 commit
  (merged to 'next' on 2010-04-07 at 7f5c112)
 + Add `%B' in format strings for raw commit body in `git log' and friends

* ab/commit-empty-message (2010-04-06) 1 commit
  (merged to 'next' on 2010-04-07 at 701e863)
 + Add option to git-commit to allow empty log messages

* jc/test-sleepless (2010-04-06) 1 commit
  (merged to 'next' on 2010-04-07 at 8ccf40a)
 + war on "sleep" in tests

* jc/maint-reflog-expire-unreachable (2010-04-07) 1 commit
 - reflog --expire-unreachable: avoid merge-base computation
 (this branch is used by jc/maint-no-reflog-expire-unreach-for-head.)

* np/malloc-threading (2010-04-08) 2 commits
  (merged to 'next' on 2010-04-10 at e1730fb)
 + Thread-safe xmalloc and xrealloc needs a recursive mutex
 + Make xmalloc and xrealloc thread-safe

The fix should eventually go to 'maint' and 'master'.  This queues the one
from J6t for Windows compatibility.

* js/async-thread (2010-03-09) 7 commits
 - Enable threaded async procedures whenever pthreads is available
  (merged to 'next' on 2010-03-20 at 9939243)
 + Dying in an async procedure should only exit the thread, not the process.
 + Reimplement async procedures using pthreads
 + Windows: more pthreads functions
 + Fix signature of fcntl() compatibility dummy
 + Make report() from usage.c public as vreportf() and use it.
 + Modernize t5530-upload-pack-error.

Been waiting for resolution of locking issues in malloc-threading.

* sd/log-decorate (2010-04-08) 6 commits
  (merged to 'next' on 2010-04-08 at 68fee56)
 + log.decorate: only ignore it under "log --pretty=raw"
 + script with rev-list instead of log
  (merged to 'next' on 2010-04-06 at 992c9ad)
 + log --pretty/--oneline: ignore log.decorate
  (merged to 'next' on 2010-03-08 at 58a6fba)
 + log.decorate: usability fixes
 + Add `log.decorate' configuration variable.
 + git_config_maybe_bool()

* mh/status-optionally-refresh (2010-04-03) 3 commits
  (merged to 'next' on 2010-04-05 at 0e64aac)
 + t7508: add a test for "git status" in a read-only repository
 + git status: refresh the index if possible
 + t7508: add test for "git status" refreshing the index

* cw/ws-indent-with-tab (2010-04-03) 6 commits
  (merged to 'next' on 2010-04-05 at 5b5e579)
 + whitespace: tests for git-apply --whitespace=fix with tab-in-indent
 + whitespace: add tab-in-indent support for --whitespace=fix
 + whitespace: replumb ws_fix_copy to take a strbuf *dst instead of char *dst
 + whitespace: tests for git-diff --check with tab-in-indent error class
 + whitespace: add tab-in-indent error class
 + whitespace: we cannot "catch all errors known to git" anymore

* sr/remote-helper-export (2010-04-12) 9 commits
  (merged to 'next' on 2010-04-12 at cefbb2f)
 + t5800: testgit helper requires Python support
  (merged to 'next' on 2010-04-09 at 94f6e3d)
 + Makefile: Simplify handling of python scripts
  (merged to 'next' on 2010-04-07 at 5651307)
 + remote-helpers: add tests for testgit helper
 + remote-helpers: add testgit helper
 + remote-helpers: add support for an export command
 + remote-helpers: allow requesing the path to the .git directory
 + fast-import: always create marks_file directories
 + clone: also configure url for bare clones
 + clone: pass the remote name to remote_get
 (this branch is used by jp/hold-string-list-sanity.)

* cc/revert-strategy (2010-03-31) 5 commits
  (merged to 'next' on 2010-04-05 at 50909c1)
 + revert: add "--strategy" option to choose merge strategy
 + merge: make function try_merge_command non static
 + merge: refactor code that calls "git merge-STRATEGY"
 + revert: refactor merge recursive code into its own function
 + revert: use strbuf to refactor the code that writes the merge message

This is more about debugging and we are not in a great hurry.

* sc/http-late-auth (2010-04-01) 1 commit
  (merged to 'next' on 2010-04-02 at c991acf)
 + Prompt for a username when an HTTP request 401s

* jk/cached-textconv (2010-04-01) 5 commits
  (merged to 'next' on 2010-04-02 at a023e3c)
 + diff: avoid useless filespec population
 + diff: cache textconv output
 + textconv: refactor calls to run_textconv
 + introduce notes-cache interface
 + make commit_tree a library function

The small leak fixes in the beginning of the series has been merged to
'master' after a minor fixup.

* ld/discovery-limit-to-fs (2010-04-04) 6 commits
 - write-index: check and warn when worktree crosses a filesystem boundary
  (merged to 'next' on 2010-04-07 at 11ea09a)
 + Rename ONE_FILESYSTEM to DISCOVERY_ACROSS_FILESYSTEM
 + GIT_ONE_FILESYSTEM: flip the default to stop at filesystem boundaries
 + Add support for GIT_ONE_FILESYSTEM
 + truncate cwd string before printing error message
 + config.c: remove static keyword from git_env_bool()

The tip one is a bit iffy; the whole series changes behaviour in a corner
case, and is not a 1.7.1 material.

* pc/remove-warn (2010-03-26) 4 commits
  (merged to 'next' on 2010-04-02 at 52fc00d)
 + Remove a redundant errno test in a usage of remove_path
 + Introduce remove_or_warn function
 + Implement the rmdir_or_warn function
 + Generalise the unlink_or_warn function

I cherry-picked only obviously sensible bits.

* em/checkout-orphan (2010-03-21) 1 commit
  (merged to 'next' on 2010-03-28 at 86b6a4f)
 + git checkout: create unparented branch by --orphan

Perhaps needs a bit of documentation updates, describing the "going open
source" scenario.

* ar/config-from-command-line (2010-03-26) 2 commits
  (merged to 'next' on 2010-04-07 at e50fd3a)
 + Use strbufs instead of open-coded string manipulation
 + Allow passing of configuration parameters in the command line
