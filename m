From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jul 2013, #05; Fri, 12)
Date: Fri, 12 Jul 2013 15:53:50 -0700
Message-ID: <7vk3kvie4h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 13 00:54:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxmDw-0002XV-Ta
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 00:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757864Ab3GLWx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 18:53:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61982 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757839Ab3GLWxy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 18:53:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C74BD30583;
	Fri, 12 Jul 2013 22:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=h
	XkNAyN+4bvT1EHKAL+ZwblqiFg=; b=cQO5oJCAQlBH1nsAP92EwtjhpjvypO9Tf
	bcqjJGDOe6ejIimdHjWAIxdXTM+9WDpz83504bZrjJK9yjLD/SGQE3umEReWz8YS
	B/D/SteOzEi51wHO+87SD9kdrlgxS1xEwXicj+LzVpeT+LVmAd3OJTBQQj2L+MKE
	9aufmkMGg0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=rqM
	wf213BqQerSm4/bXwdJX/x9HAR5f826DVGJNU5WbtD0bDew5SfNJ9g5v8GwbHXTb
	WsFRslT6l8dGLRNoD9alHM4XIL+sTYG+xZQdrmbDWntkOYlSyVugR+zoKiyDW8wV
	1kJ6urTimUBJMoaNthInOhfhzhQvOAAtIoKnN5X4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDDC030582;
	Fri, 12 Jul 2013 22:53:53 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5BE833057D;
	Fri, 12 Jul 2013 22:53:52 +0000 (UTC)
X-master-at: 0da7a53a76b48ea1b2ee6ebe7bd7fbcd7d5c3f9d
X-next-at: 3a6d6276f9ce81c14c10f2d798b4fc9a9950eef6
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC46C6D2-EB45-11E2-950F-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230266>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

As many of you may know, I hate to do back-to-back "What's cooking",
but we ended up acquiring many new topics, and many existing ones
have moved from 'pu' to 'next' and 'next' to 'master'.

Those that graduated to 'master' are mostly code and documentation
clean-up patches.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* as/log-output-encoding-in-user-format (2013-07-05) 11 commits
  (merged to 'next' on 2013-07-08 at 2e1bdd9)
 + t4205 (log-pretty-formats): avoid using `sed`
 + t6006 (rev-list-format): add tests for "%b" and "%s" for the case i18n.commitEncoding is not set
 + t4205, t6006, t7102: make functions better readable
 + t4205 (log-pretty-formats): revert back single quotes
  (merged to 'next' on 2013-07-05 at d2c99e5)
 + t4041, t4205, t6006, t7102: use iso8859-1 rather than iso-8859-1
  (merged to 'next' on 2013-07-01 at 3318aa8)
 + t4205: replace .\+ with ..* in sed commands
  (merged to 'next' on 2013-06-28 at 4063330)
 + pretty: --format output should honor logOutputEncoding
 + pretty: Add failing tests: --format output should honor logOutputEncoding
 + t4205 (log-pretty-formats): don't hardcode SHA-1 in expected outputs
 + t7102 (reset): don't hardcode SHA-1 in expected outputs
 + t6006 (rev-list-format): don't hardcode SHA-1 in expected outputs

 "log --format=" did not honor i18n.logoutputencoding configuration
 and this attempts to fix it.


* ft/diff-rename-default-score-is-half (2013-07-05) 1 commit
  (merged to 'next' on 2013-07-09 at 6a6b57e)
 + diff-options: document default similarity index


* jc/remote-http-argv-array (2013-07-09) 1 commit
  (merged to 'next' on 2013-07-11 at 7fbe8bd)
 + remote-http: use argv-array


* jk/maint-config-multi-order (2013-07-07) 1 commit
  (merged to 'next' on 2013-07-09 at 0db1db9)
 + git-config(1): clarify precedence of multiple values


* jk/pull-to-integrate (2013-07-08) 2 commits
  (merged to 'next' on 2013-07-09 at 2ecac24)
 + pull: change the description to "integrate" changes
 + push: avoid suggesting "merging" remote changes


* ml/cygwin-does-not-have-fifo (2013-07-05) 1 commit
  (merged to 'next' on 2013-07-09 at 7d6849d)
 + test-lib.sh - cygwin does not have usable FIFOs


* ms/remote-tracking-branches-in-doc (2013-07-03) 1 commit
  (merged to 'next' on 2013-07-09 at 411a8bd)
 + Change "remote tracking" to "remote-tracking"


* rr/name-rev-stdin-doc (2013-07-07) 1 commit
  (merged to 'next' on 2013-07-09 at 7cfbff6)
 + name-rev doc: rewrite --stdin paragraph


* rs/pickaxe-simplify (2013-07-07) 1 commit
  (merged to 'next' on 2013-07-11 at c5972f7)
 + diffcore-pickaxe: simplify has_changes and contains


* tf/gitweb-extra-breadcrumbs (2013-07-04) 1 commit
  (merged to 'next' on 2013-07-09 at 525331b)
 + gitweb: allow extra breadcrumbs to prefix the trail

 An Gitweb installation that is a part of larger site can optionally
 show extra links that point at the levels higher than the Gitweb
 pages itself in the link hierarchy of pages.


* tr/test-lint-no-export-assignment-in-shell (2013-07-08) 2 commits
  (merged to 'next' on 2013-07-09 at 6f10ea2)
 + test-lint: detect 'export FOO=bar'
 + t9902: fix 'test A == B' to use = operator

--------------------------------------------------
[New Topics]

* es/check-mailmap (2013-07-11) 2 commits
 - t4203: test check-mailmap command invocation
 - builtin: add git-check-mailmap command

 A new command to allow scripts to query the mailmap information.

 Expecting a reroll to lose the -z option.


* jc/check-x-z (2013-07-11) 4 commits
 - check-attr -z: a single -z should apply to both input and output
 - check-ignore -z: a single -z should apply to both input and output
 - check-attr: the name of the character is NUL, not NULL
 - check-ignore: the name of the character is NUL, not NULL

 "git check-ignore -z" applied the NUL termination to both its input
 (with --stdin) and its output, but "git check-attr -z" ignored the
 option on the output side.

 This is potentially a backward incompatible fix.  I am tempted to
 merge this to and keep it in 'next' for a while to see if anybody
 screams before deciding if we want to do anything to help existing
 users (there may be none).


* jk/cat-file-batch-optim (2013-07-12) 8 commits
 - sha1_object_info_extended: pass object_info to helpers
 - sha1_object_info_extended: make type calculation optional
 - packed_object_info: make type lookup optional
 - packed_object_info: hoist delta type resolution to helper
 - sha1_loose_object_info: make type lookup optional
 - sha1_object_info_extended: rename "status" to "type"
 - cat-file: disable object/refname ambiguity check for batch mode
 - Merge branch 'nd/warn-ambiguous-object-name' into jk/cat-file-batch-optim
 (this branch uses jk/in-pack-size-measurement.)

 If somebody wants to only know on-disk footprint of an object
 without having to know its type or payload size, we can bypass a
 lot of code to cheaply learn it.


* jk/t0008-sigpipe-fix (2013-07-12) 1 commit
 - t0008: avoid SIGPIPE race condition on fifo

 Fix for recent test breakage on 'master'.

 Will merge to 'next'.


* mk/upload-pack-off-by-one-dead-code-removal (2013-07-11) 1 commit
 - upload-pack: Remove a piece of dead code

 Will merge to 'next'.


* sb/mailmap-updates (2013-07-12) 1 commit
 - .mailmap: Map email addresses to names

 Will merge to 'next'.


* tf/gitweb-ss-tweak (2013-07-09) 2 commits
 - gitweb: vertically centre contents of page footer
 - gitweb: Ensure OPML text fits inside its box.

 Comments?


* tr/fd-gotcha-fixes (2013-07-12) 2 commits
 - run-command: dup_devnull(): guard against syscalls failing
 - git_mkstemps: correctly test return value of open()

 Two places we did not check return value (expected to be a file
 descriptor) correctly.


* jc/mailmap-case-insensitivity (2013-07-12) 4 commits
 - add a testcase for checking case insensitivity of mailmap
 - mailmap: style fixes
 - mailmap: do not downcase mailmap entries
 - mailmap: do not lose single-letter names

 The test may need to be rerolled and enhanced.


* ms/fetch-prune-configuration (2013-07-12) 2 commits
 - squash???
 - fetch: make --prune configurable

 Allow fetch.prune and remote.*.prune configuration variables to be set,
 and "git fetch" to behave as if "--prune" is given.

--------------------------------------------------
[Stalled]

* rr/send-email-ssl-verify (2013-07-06) 6 commits
 - SQUASH??? update to support SSL_ca_file as well as SSL_ca_path
 - SQUASH??? send-email: cover both smtps and starttls cases
 - fixup! send-email: squelch warning from Net::SMTP::SSL
 - SQUASH??? send-email giving default value to ssl-cert-path with ||= assignment
 - send-email: introduce sendemail.smtpsslcertpath
 - send-email: squelch warning from Net::SMTP::SSL

 The issue seems a lot deeper than the initial attempt and needs
 somebody to sit down and sort out to get the version dependencies
 and lazy loading right.


* rj/read-default-config-in-show-ref-pack-refs (2013-06-17) 3 commits
 - ### DONTMERGE: needs better explanation on what config they need
 - pack-refs.c: Add missing call to git_config()
 - show-ref.c: Add missing call to git_config()

 The changes themselves are probably good, but it is unclear what
 basic setting needs to be read for which exact operation.

 Waiting for clarification.
 $gmane/228294


* jh/shorten-refname (2013-05-07) 4 commits
 - t1514: refname shortening is done after dereferencing symbolic refs
 - shorten_unambiguous_ref(): Fix shortening refs/remotes/origin/HEAD to origin
 - t1514: Demonstrate failure to correctly shorten "refs/remotes/origin/HEAD"
 - t1514: Add tests of shortening refnames in strict/loose mode

 When remotes/origin/HEAD is not a symbolic ref, "rev-parse
 --abbrev-ref remotes/origin/HEAD" ought to show "origin", not
 "origin/HEAD", which is fixed with this series (if it is a symbolic
 ref that points at remotes/origin/something, then it should show
 "origin/something" and it already does).

 Expecting a reroll, as an early part of a larger series.
 $gmane/225137


* jl/submodule-mv (2013-04-23) 5 commits
 - submodule.c: duplicate real_path's return value
 - rm: delete .gitmodules entry of submodules removed from the work tree
 - Teach mv to update the path entry in .gitmodules for moved submodules
 - Teach mv to move submodules using a gitfile
 - Teach mv to move submodules together with their work trees

 "git mv A B" when moving a submodule A does "the right thing",
 inclusing relocating its working tree and adjusting the paths in
 the .gitmodules file.

 Waiting for a reroll.
 $gmane/226294


* jk/list-objects-sans-blobs (2013-06-06) 4 commits
 . archive: ignore blob objects when checking reachability
 . list-objects: optimize "revs->blob_objects = 0" case
 . upload-archive: restrict remote objects with reachability check
 . clear parsed flag when we free tree buffers

 Attempt to allow "archive --remote=$there $arbitrary_sha1" while
 keeping the reachability safety.

 Seems to break some tests in a trivial and obvious way.


* mg/more-textconv (2013-05-10) 7 commits
 - grep: honor --textconv for the case rev:path
 - grep: allow to use textconv filters
 - t7008: demonstrate behavior of grep with textconv
 - cat-file: do not die on --textconv without textconv filters
 - show: honor --textconv for blobs
 - diff_opt: track whether flags have been set explicitly
 - t4030: demonstrate behavior of show with textconv

 Make "git grep" and "git show" pay attention to --textconv when
 dealing with blob objects.

 I thought this was pretty well designed and executed, but it seems
 there are some doubts on the list; kicked back to 'pu'.


* mh/multimail (2013-04-21) 1 commit
 - git-multimail: a replacement for post-receive-email

 Waiting for the initial history to pull from.
 $gmane/223564


* jc/format-patch (2013-04-22) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.

 Not ready for inclusion.

 Will discard unless we hear from anybody who is interested in
 tying its loose ends.


* jk/gitweb-utf8 (2013-04-08) 4 commits
 - gitweb: Fix broken blob action parameters on blob/commitdiff pages
 - gitweb: Don't append ';js=(0|1)' to external links
 - gitweb: Make feed title valid utf8
 - gitweb: Fix utf8 encoding for blob_plain, blobdiff_plain, commitdiff_plain, and patch

 Various fixes to gitweb.

 Drew Northup volunteered to take a look into this.
 $gmane/226216


* jc/show-branch (2013-06-07) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary width
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it out.

--------------------------------------------------
[Cooking]

* jk/gcc-function-attributes (2013-07-09) 3 commits
  (merged to 'next' on 2013-07-12 at 5a7081f)
 + wt-status: use "format" function attribute for status_printf
 + use "sentinel" function attribute for variadic lists
 + add missing "format" function attributes

 Use the function attributes extension to catch mistakes in use of
 our own variadic functions that use NULL sentinel at the end
 (i.e. like execl(3)) and format strings (i.e. like printf(3)).

 Will merge to 'master'.


* km/http-curl-config-per-url (2013-07-12) 2 commits
 - config: add support for http.<url>.* settings
 - http.c: fix parsing of http.sslCertPasswordProtected variable

 Allows custom curl configuration per URL when talking over http.


* hv/config-from-blob (2013-07-12) 5 commits
 - do not die when error in config parsing of buf occurs
 - teach config --blob option to parse config from database
 - config: make parsing stack struct independent from actual data source
 - config: drop cf validity check in get_next_char()
 - config: factor out config file stack management

 Rerolled.

 Will merge to 'next'.


* bc/push-match-many-refs (2013-07-08) 1 commit
  (merged to 'next' on 2013-07-11 at df4d56d)
 + remote.c: avoid O(m*n) behavior in match_push_refs

 Pushing to repositories with many refs employed O(m*n) algorithm
 where n is the number of refs on the receiving end.

 Will merge to 'master'.


* jc/name-rev-exact-ref (2013-07-09) 3 commits
  (merged to 'next' on 2013-07-11 at fd5b30c)
 + describe: use argv-array
 + name-rev: allow converting the exact object name at the tip of a ref
 + name-ref: factor out name shortening logic from name_ref()

 Corrects the longstanding sloppiness in the implementation of
 name-rev that conflated "we take commit-ish" and "differences
 between tags and commits do not matter".

 Will merge to 'master'.


* jk/in-pack-size-measurement (2013-07-12) 10 commits
  (merged to 'next' on 2013-07-12 at 5ba720f)
 + pack-revindex: radix-sort the revindex
 + pack-revindex: use unsigned to store number of objects
 + cat-file: split --batch input lines on whitespace
 + cat-file: add %(objectsize:disk) format atom
 + cat-file: add --batch-check=<format>
 + cat-file: refactor --batch option parsing
 + cat-file: teach --batch to stream blob objects
 + t1006: modernize output comparisons
 + teach sha1_object_info_extended a "disk_size" query
 + zero-initialize object_info structs
 (this branch is used by jk/cat-file-batch-optim.)

 Allow on-disk footprint of objects in packfiles (often they are a
 lot smaller than their true size, when expressed as deltas).

 Will merge to 'master'.


* jk/maint-clone-shared-no-connectivity-validation (2013-07-08) 1 commit
  (merged to 'next' on 2013-07-11 at 8183412)
 + clone: drop connectivity check for local clones
 (this branch is used by jk/clone-shared-no-connectivity-validation.)

 "git clone -s/-l" is a filesystem level copy and does not offer any
 protection against source repository being corrupt.  While the
 connectivity validation checks commits and trees being readable, it
 made the otherwise instantaneous local modes of clone much more
 expensive, without protecting blob data from bitflips.

 Will merge to 'master'.


* km/svn-1.8-serf-only (2013-07-07) 2 commits
  (merged to 'next' on 2013-07-12 at 70e0b95)
 + git-svn: allow git-svn fetching to work using serf
 + Git.pm: add new temp_is_locked function

 Subversion 1.8.0 that was recently released breaks older subversion
 clients coming over http/https in various ways.


* tr/merge-recursive-index-only (2013-07-07) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: untangle double meaning of o->call_depth
 - merge-recursive: remove dead conditional in update_stages()


* es/overlapping-range-set (2013-07-09) 2 commits
  (merged to 'next' on 2013-07-11 at 3df5a94)
 + range_set: fix coalescing bug when range is a subset of another
 + t4211: fix broken test when one -L range is subset of another

 Will merge to 'master'.


* jc/push-cas (2013-07-11) 6 commits
 - t5533: test "push --lockref"
 - push --lockref: tie it all together
 - push --lockref: implement logic to populate old_sha1_expect[]
 - remote.c: add command line option parser for "--lockref"
 - builtin/push.c: use OPT_BOOL, not OPT_BOOLEAN
 - cache.h: move remote/connect API out of it

 Allow a safer "rewind of the remote tip" push than blind "--force",
 by requiring that the overwritten remote ref to be unchanged since
 the new history to replace it was prepared.

 The machinery is more or less ready.  The "--force" option is again
 the big red button to override any safety, thanks to J6t's sanity
 (the original round allowed --lockref to defeat --force).

 Waiting for comments.


* nd/const-struct-cache-entry (2013-07-09) 1 commit
 - Convert "struct cache_entry *" to "const ..." wherever possible

 Will merge to 'next'.


* jk/fetch-pack-many-refs (2013-07-02) 3 commits
  (merged to 'next' on 2013-07-09 at a53b7c7)
 + fetch-pack: avoid quadratic behavior in rev_list_push
 + commit.c: make compare_commits_by_commit_date global
 + fetch-pack: avoid quadratic list insertion in mark_complete

 Fetching between repositories with many refs employed O(n^2)
 algorithm to match up the common objects, which has been corrected.

 Will merge to 'master'.


* jk/format-patch-from (2013-07-03) 2 commits
  (merged to 'next' on 2013-07-09 at 6ed86d5)
 + teach format-patch to place other authors into in-body "From"
 + pretty.c: drop const-ness from pretty_print_context

 "git format-patch" learned "--from[=whom]" option, which sets the
 "From: " header to the specified person (or the person who runs the
 command, if "=whom" part is missing) and move the original author
 information to an in-body From: header as necessary.

 Will merge to 'master'.


* bc/commit-invalid-utf8 (2013-07-09) 3 commits
  (merged to 'next' on 2013-07-11 at a2ee572)
 + commit: reject non-characters
 + commit: reject overlong UTF-8 sequences
 + commit: reject invalid UTF-8 codepoints

 Tighten up autodetection of UTF-8 encoded strings.

 Will merge to 'master'.


* bc/send-email-use-port-as-separate-param (2013-07-04) 1 commit
  (merged to 'next' on 2013-07-09 at a569eb5)
 + send-email: provide port separately from hostname

 Will merge to 'master'.


* es/contacts (2013-07-03) 3 commits
 - contrib: contacts: interpret committish akin to format-patch
 - contrib: contacts: add ability to parse from committish
 - contrib: add git-contacts helper

 A helper to read from a set of format-patch output files or a range
 of commits and find those who may have insights to the code that
 the changes touch by running a series of "git blame" commands.

 Still needs to add mailmap support and other niceties but the
 basics already look sound, and the enhancements can be done
 in-tree. Assuming that "git contact" is something we may want to
 have as a member of the official set of commands someday, that is.

 Will merge to 'next'.


* cp/submodule-custom-update (2013-07-03) 1 commit
  (merged to 'next' on 2013-07-09 at 3d27516)
 + submodule update: allow custom command to update submodule working tree

 In addition to the choice from "rebase, merge, or checkout-detach",
 allow a custom command to be used in "submodule update" to update
 the working tree of submodules.

 Will merge to 'master'.


* mv/merge-ff-tristate (2013-07-02) 1 commit
  (merged to 'next' on 2013-07-09 at c32b95d)
 + merge: handle --ff/--no-ff/--ff-only as a tri-state option

 The configuration variable "merge.ff" was cleary a tri-state to
 choose one from "favor fast-forward when possible", "always create
 a merge even when the history could fast-forward" and "do not
 create any merge, only update when the history fast-forwards", but
 the command line parser did not implement the usual convention of
 "last one wins, and command line overrides the configuration"
 correctly.

 Will merge to 'master'.


* rr/rebase-reflog-message-reword (2013-06-23) 2 commits
  (merged to 'next' on 2013-07-11 at 59921e0)
 + rebase -i: use a better reflog message
 + rebase: use a better reflog message

 "git rebase [-i]" used to leave just "rebase" as its reflog message
 for some operations. This rewords them to be more informative.

 Will merge to 'master'.


* bp/mediawiki-preview (2013-07-08) 7 commits
  (merged to 'next' on 2013-07-12 at 870890a)
 + git-remote-mediawiki: add preview subcommand into git mw
 + git-remote-mediawiki: add git-mw command
 + git-remote-mediawiki: factoring code between git-remote-mediawiki and Git::Mediawiki
 + git-remote-mediawiki: update tests to run with the new bin-wrapper
 + git-remote-mediawiki: add a git bin-wrapper for developement
 + wrap-for-bin: make bin-wrappers chainable
 + git-remote-mediawiki: introduction of Git::Mediawiki.pm

 Add a command to allow previewing the contents locally before
 pushing it out, when working with a MediaWiki remote.

 I personally do not think this belongs to Git.  If you are working
 on a set of AsciiDoc source files, you sure do want to locally
 format to preview what you will be pushing out, and if you are
 working on a set of C or Java source files, you do want to test it
 before pushing it out, too.  That kind of thing belongs to your
 build script, not to your SCM.

 But I'll let it pass, as this is only a contrib/ thing.

 Will merge to 'master'.


* fg/submodule-clone-depth (2013-07-03) 1 commit
  (merged to 'next' on 2013-07-09 at ab156f3)
 + Add --depth to submodule update/add

 Allow shallow-cloning of submodules with "git submodule update".

 Will merge to 'master'.


* jc/pull-training-wheel (2013-06-27) 1 commit
 - pull: require choice between rebase/merge on non-fast-forward pull

 Make "git pull" refuse with "it does not fast forward; choose between
 'pull --merge' and 'pull --rebase'".

 John Keeping seems to want to restrict this to "git pull" without
 any other argument. I personally do not have a strong opinion
 either way, but I'm inclined to take such a patch to loosen the new
 logic with other people's support.  Hint, hint...


* jk/fast-import-empty-ls (2013-06-23) 4 commits
 - fast-import: allow moving the root tree
 - fast-import: allow ls or filecopy of the root tree
 - fast-import: set valid mode on root tree in "ls"
 - t9300: document fast-import empty path issues

 Waiting for reviews.
 $gmane/228741


* rj/cygwin-clarify-use-of-cheating-lstat (2013-07-11) 1 commit
 - cygwin: Add fast_lstat() and fast_fstat() functions

 Turns quite a many uses of lstat() into fast_lstat() to mark
 callsites that allow "a faster but cheating and incorrect variant".
 Defining fast_lstat() to be the same as lstat(), is fine from
 correctness point of view, but it can be replaced with an
 alternative implementation that more quickly grabs only the part of
 the stat information that matter (e.g. cygwin).  The places where
 we _do_ require a fully correct lstat() are left as lstat().

 The damage this patch makes to the the core codepath on systems may
 be rather large from readability's point of view, though.


* jc/reflog-doc (2013-06-19) 1 commit
 - setup_reflog_action: document the rules for using GIT_REFLOG_ACTION

 Document rules to use GIT_REFLOG_ACTION variable in the scripted
 Porcelain.  git-rebase--interactive locally violates this, but it
 is a leaf user that does not call out to or dot-sources other
 scripts, so fixing it is not all that urgent.


* mh/ref-races-optim-invalidate-cached (2013-06-20) 1 commit
 - refs: do not invalidate the packed-refs cache unnecessarily

 This requires the platform lstat() to be correct to avoid false
 negatives.


* jx/clean-interactive (2013-06-26) 16 commits
  (merged to 'next' on 2013-07-12 at 61dd42d)
 + test: run testcases with POSIX absolute paths on Windows
 + test: add t7301 for git-clean--interactive
 + git-clean: add documentation for interactive git-clean
 + git-clean: add ask each interactive action
 + git-clean: add select by numbers interactive action
 + git-clean: add filter by pattern interactive action
 + git-clean: use a git-add-interactive compatible UI
 + git-clean: add colors to interactive git-clean
 + git-clean: show items of del_list in columns
 + git-clean: add support for -i/--interactive
  (merged to 'next' on 2013-06-26 at f7be2d8)
 + git-clean: refactor git-clean into two phases
 + write_name{_quoted_relative,}(): remove redundant parameters
 + quote_path_relative(): remove redundant parameter
 + quote.c: substitute path_relative with relative_path
 + path.c: refactor relative_path(), not only strip prefix
 + test: add test cases for relative_path

 Add "interactive" mode to "git clean".

 The early part to refactor relative path related helper functions
 looked sensible.

 Will merge to 'master'.


* jn/add-2.0-u-A-sans-pathspec (2013-04-26) 1 commit
 - git add: -u/-A now affects the entire working tree

 Will cook in 'next' until Git 2.0.


* jc/core-checkstat-2.0 (2013-05-06) 1 commit
 - core.statinfo: remove as promised in Git 2.0

 Will cook in 'next' until Git 2.0.


* jc/push-2.0-default-to-simple (2013-06-18) 1 commit
 - push: switch default from "matching" to "simple"

 Will cook in 'next' until Git 2.0.


* jc/add-2.0-ignore-removal (2013-04-22) 1 commit
 - git add <pathspec>... defaults to "-A"

 Updated endgame for "git add <pathspec>" that defaults to "--all"
 aka "--no-ignore-removal".

 Will cook in 'next' until Git 2.0.
