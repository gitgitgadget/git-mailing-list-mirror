From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2015, #05; Thu, 19)
Date: Thu, 19 Feb 2015 14:16:30 -0800
Message-ID: <xmqqioexzgw1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 23:16:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOZOh-0002bR-Sl
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 23:16:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852AbbBSWQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 17:16:35 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54516 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752314AbbBSWQe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2015 17:16:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E8A2C3A45B;
	Thu, 19 Feb 2015 17:16:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=k
	vvBDycUh/Vh3wxwzwjfol4d2q4=; b=WqEXRmrnvSntlJWCJtpwZDXSW7b2qJ5he
	CKmKDf+KuWKwfjpm7OVfRzTCykNypL7pDMuuG4PbQvRoekndR9v5+3GDNJD87/jN
	5b+yrS4zr5xpL89J4qYkUR7sDl/j4/fYA54yFkTSMSsAuRwrmmXdEUOl/+KV9l9R
	VDiUNpiJa4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Lp4
	LSQxb/+eQIz7wwxJGPVPyHM45i/76uzQHtlndeQHQ8yviiBOjreZETN5FC0cEIKa
	/bUGQGS4kNQSNbdButV6/C86Ic5XcnWAdahKe9yp0XlanRItuDXlNFEY2/CVsEek
	zwilhVDBh1dEsRZ37OeZ/KCPys2xzwzlW7pvrhcE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DC2E73A45A;
	Thu, 19 Feb 2015 17:16:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0FBF13A459;
	Thu, 19 Feb 2015 17:16:31 -0500 (EST)
X-master-at: f3f407747c1cce420ae4b4857c4a6806efe38680
X-next-at: b072d44c2c27039617e40171784569d7212f3148
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F56DD184-B884-11E4-B31B-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264115>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The second and third batch of topics have been merged to 'master'.
I am tempted to start discarding topics in the Stalled category that
haven't seen much reviews and discussions on for a long time.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* av/wincred-with-at-in-username-fix (2015-01-25) 1 commit
  (merged to 'next' on 2015-02-16 at 69dd76d)
 + wincred: fix get credential if username has "@"

 The credential helper for Windows (in contrib/) used to mishandle
 a user name with an at-sign in it.


* ch/new-gpg-drops-rfc-1991 (2015-01-29) 2 commits
  (merged to 'next' on 2015-02-16 at e2daf10)
 + t/lib-gpg: sanity-check that we can actually sign
 + t/lib-gpg: include separate public keys in keyring.gpg

 Older GnuPG implementations may not correctly import the keyring
 material we prepare for the tests to use.


* jc/push-cert (2015-02-12) 1 commit
  (merged to 'next' on 2015-02-16 at f40b3c5)
 + transport-helper: fix typo in error message when --signed is not supported

 "git push --signed" gave an incorrectly worded error message when
 the other side did not support the capability.


* jc/remote-set-url-doc (2015-01-29) 1 commit
  (merged to 'next' on 2015-02-16 at 1f9c342)
 + Documentation/git-remote.txt: stress that set-url is not for triangular

 Clarify in the documentation that "remote.<nick>.pushURL" and
 "remote.<nick>.URL" are there to name the same repository accessed
 via different transports, not two separate repositories.


* jk/config-no-ungetc-eof (2015-02-05) 2 commits
  (merged to 'next' on 2015-02-16 at b7fc890)
 + config_buf_ungetc: warn when pushing back a random character
 + config: do not ungetc EOF

 Reading configuration from a blob object, when it ends with a lone
 CR, use to confuse the configuration parser.


* jk/decimal-width-for-uintmax (2015-02-05) 1 commit
  (merged to 'next' on 2015-02-16 at e608239)
 + decimal_width: avoid integer overflow

 We didn't format an integer that wouldn't fit in "int" but in
 "uintmax_t" correctly.


* jk/pack-bitmap (2015-02-04) 1 commit
  (merged to 'next' on 2015-02-16 at 2e30424)
 + ewah: fix building with gcc < 3.4.0

 The pack bitmap support did not build with older versions of GCC.


* ye/http-accept-language (2015-01-28) 1 commit
  (merged to 'next' on 2015-02-16 at 10ed819)
 + http: add Accept-Language header if possible

 Using environment variable LANGUAGE and friends on the client side,
 HTTP-based transports now send Accept-Language when making requests.

--------------------------------------------------
[New Topics]

* ak/git-pm-typofix (2015-02-18) 1 commit
 - Git.pm: two minor typo fixes

 Will merge to 'next'.


* jc/decorate-leaky-separator-color (2015-02-18) 1 commit
 - log --decorate: do not leak "commit" color into the next item

 "git log --decorate" did not reset colors correctly around the
 branch names.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* nd/list-files (2015-02-09) 21 commits
 . t3080: tests for git-list-files
 . list-files: -M aka diff-cached
 . list-files -F: show submodules with the new indicator '&'
 . list-files: add -F/--classify
 . list-files: show directories as well as files
 . list-files: do not show duplicate cached entries
 . list-files: sort output and remove duplicates
 . list-files: add -t back
 . list-files: add -1 short for --no-column
 . list-files: add -R/--recursive short for --max-depth=-1
 . list-files: -u does not imply showing stages
 . list-files: make alias 'ls' default to 'list-files'
 . list-files: a user friendly version of ls-files and more
 . ls-files: support --max-depth
 . ls-files: add --column
 . ls-files: add --color to highlight file names
 . ls-files: buffer full item in strbuf before printing
 . ls_colors.c: highlight submodules like directories
 . ls_colors.c: add a function to color a file name
 . ls_colors.c: parse color.ls.* from config file
 . ls_colors.c: add $LS_COLORS parsing code

 A new "git list-files" Porcelain command, "ls-files" with bells and
 whistles.

 No comments?  No reviews?  No interests?


* nd/untracked-cache (2015-02-09) 24 commits
 - git-status.txt: advertisement for untracked cache
 - untracked cache: guard and disable on system changes
 - mingw32: add uname()
 - t7063: tests for untracked cache
 - update-index: test the system before enabling untracked cache
 - update-index: manually enable or disable untracked cache
 - status: enable untracked cache
 - untracked-cache: temporarily disable with $GIT_DISABLE_UNTRACKED_CACHE
 - untracked cache: mark index dirty if untracked cache is updated
 - untracked cache: print stats with $GIT_TRACE_UNTRACKED_STATS
 - untracked cache: avoid racy timestamps
 - read-cache.c: split racy stat test to a separate function
 - untracked cache: invalidate at index addition or removal
 - untracked cache: load from UNTR index extension
 - untracked cache: save to an index extension
 - ewah: add convenient wrapper ewah_serialize_strbuf()
 - untracked cache: don't open non-existent .gitignore
 - untracked cache: mark what dirs should be recursed/saved
 - untracked cache: record/validate dir mtime and reuse cached output
 - untracked cache: make a wrapper around {open,read,close}dir()
 - untracked cache: invalidate dirs recursively if .gitignore changes
 - untracked cache: initial untracked cache validation
 - untracked cache: record .gitignore information and dir hierarchy
 - dir.c: optionally compute sha-1 of a .gitignore file

 Need extra sets of eyes to review this.


* tb/connect-ipv6-parse-fix (2015-01-22) 3 commits
 - t5500: show user name and host in diag-url
 - t5601: add more test cases for IPV6
 - connect.c: improve parsing of literal IPV6 addresses

 Parsing of literal IPv6 addresses.

 Will discard.


* ak/stash-store-create-help (2015-01-13) 1 commit
 - stash: show "create" and "store" subcommands in usage-help

 Will discard.


* bp/diff-relative-config (2015-01-07) 2 commits
 - diff: teach diff.relative to give default to --relative=<value>
 - diff: teach --no-relative to override earlier --relative

 No comments?  No interests?


* jc/diff-b-m (2015-02-17) 4 commits
 - WIP: diff-b-m
 - diffcore-rename: allow easier debugging
 - diffcore-rename.c: add locate_rename_src()
 - diffcore-break: allow debugging
 (this branch uses jc/diff-test-updates.)

 "git diff -B -M" produced incorrect patch when the postimage of a
 completely rewritten file is similar to the preimage of a removed
 file; such a resulting file must not be expressed as a rename from
 other place.

 The fix in this patch is broken, unfortunately.


* nd/slim-index-pack-memory-usage (2015-02-10) 3 commits
 - index-pack: kill union delta_base to save memory
 - FIXUP
 - index-pack: reduce memory footprint a bit

 Experimental?


* pw/remote-set-url-fetch (2014-11-26) 1 commit
 - remote: add --fetch and --both options to set-url

 Expecting a reroll.


* je/quiltimport-no-fuzz (2014-10-21) 2 commits
 - git-quiltimport: flip the default not to allow fuzz
 - git-quiltimport.sh: allow declining fuzz with --exact option

 "quiltimport" drove "git apply" always with -C1 option to reduce
 context of the patch in order to give more chance to somewhat stale
 patches to apply.  Add an "--exact" option to disable, and also
 "-C$n" option to customize this behaviour.  The top patch
 optionally flips the default to "--exact".

 Tired of waiting for an Ack
 Will discard.


* tr/remerge-diff (2014-11-10) 9 commits
 - t4213: avoid "|" in sed regexp
 - log --remerge-diff: show what the conflict resolution changed
 - name-hash: allow dir hashing even when !ignore_case
 - merge-recursive: allow storing conflict hunks in index
 - merge_diff_mode: fold all merge diff variants into an enum
 - combine-diff: do not pass revs->dense_combined_merges redundantly
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: internal flag to avoid touching the worktree
 - merge-recursive: remove dead conditional in update_stages()

 "log -p" output learns a new way to let users inspect a merge
 commit by showing the differences between the automerged result
 with conflicts the person who recorded the merge would have seen
 and the final conflict resolution that was recorded in the merge.

 Waiting for a reroll ($gmane/256591).


* hv/submodule-config (2014-11-11) 4 commits
 - do not die on error of parsing fetchrecursesubmodules option
 - use new config API for worktree configurations of submodules
 - extract functions for submodule config set and lookup
 - implement submodule config cache for lookup of submodule names

 Kicked back to 'pu' per request ($gmane/255610).


* ab/add-interactive-show-diff-func-name (2014-05-12) 2 commits
 - SQUASH??? git-add--interactive: Preserve diff heading when splitting hunks
 - git-add--interactive: Preserve diff heading when splitting hunks

 Waiting for a reroll.


* jn/gitweb-utf8-in-links (2014-05-27) 1 commit
 - gitweb: Harden UTF-8 handling in generated links

 $gmane/250758?


* ss/userdiff-update-csharp-java (2014-06-02) 2 commits
 - userdiff: support Java try keyword
 - userdiff: support C# async methods and correct C# keywords

 Reviews sent; waiting for a response.


* bg/rebase-off-of-previous-branch (2014-04-16) 1 commit
 - git-rebase: print name of rev when using shorthand

 Teach "git rebase -" to report the concrete name of the branch
 (i.e. the previous one).

 But it stops short and does not do the same for "git rebase @{-1}".
 Expecting a reroll.


* rb/merge-prepare-commit-msg-hook (2014-01-10) 4 commits
 - merge: drop unused arg from abort_commit method signature
 - merge: make prepare_to_commit responsible for write_merge_state
 - t7505: ensure cleanup after hook blocks merge
 - t7505: add missing &&

 Expose more merge states (e.g. $GIT_DIR/MERGE_MODE) to hooks that
 run during "git merge".  The log message stresses too much on one
 hook, prepare-commit-msg, but it would equally apply to other hooks
 like post-merge, I think.

 Waiting for a reroll.


* jc/graph-post-root-gap (2013-12-30) 3 commits
 - WIP: document what we want at the end
 - graph: remove unused code a bit
 - graph: stuff the current commit into graph->columns[]

 This was primarily a RFH ($gmane/239580).


* tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
 - perf-lib: add test_perf_cleanup target
 - perf-lib: split starting the test from the execution

 Add test_perf_cleanup shell function to the perf suite, that allows
 the script writers to define a test with a clean-up action.

 Will hold.


* jc/show-branch (2014-03-24) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary width
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it out.

--------------------------------------------------
[Cooking]

* ms/submodule-update-config-doc (2015-02-17) 2 commits
 - SQUASH???
 - submodule: clarify documentation for update subcommand

 The interaction between "git submodule update" and the
 submodule.*.update configuration was not clearly documented.

 The SQUASH may be sufficient as a reroll ($gmane/259037).


* dp/remove-duplicated-header-inclusion (2015-02-13) 1 commit
  (merged to 'next' on 2015-02-18 at a1bf108)
 + do not include the same header twice

 Code clean-up.

 Will merge to 'master'.


* jc/diff-test-updates (2015-02-15) 6 commits
  (merged to 'next' on 2015-02-18 at f152c9f)
 + t4008: modernise style
 + t/diff-lib: check exact object names in compare_diff_raw
 + tests: do not borrow from COPYING and README from the real source
 + t4010: correct expected object names
 + t9300: correct expected object names
 + t4008: correct stale comments
 (this branch is used by jc/diff-b-m.)

 Test clean-up.

 Will merge to 'master'.


* jc/send-email-sensible-encoding (2015-02-13) 1 commit
  (merged to 'next' on 2015-02-18 at 7457655)
 + send-email: ask confirmation if given encoding name is very short

 "git send-email" used to accept a mistaken "y" (or "yes") as an
 answer to "What encoding do you want to use [UTF-8]? " without
 questioning.  Now it asks for confirmation when the answer looks
 too short to be a valid encoding name.

 Will merge to 'master'.


* jk/push-config (2015-02-17) 4 commits
 - [NEEDSACK] push: allow --follow-tags to be set by config push.followTags
 - cmd_push: pass "flags" pointer to config callback
 - cmd_push: set "atomic" bit directly
 - git_push_config: drop cargo-culted wt_status pointer

 Waiting for Ack and/or update for the tip one from Dave Olszewski
 ($gmane/263880, $gmane/263991).


* km/send-email-getopt-long-workarounds (2015-02-16) 1 commit
  (merged to 'next' on 2015-02-18 at 84c1597)
 + git-send-email.perl: support no- prefix with older GetOptions

 Even though we officially haven't dropped Perl 5.8 support, the
 Getopt::Long package that came with it does not support "--no-"
 prefix to negate a boolean option; manually add support to help
 people with older Getopt::Long package.

 Will merge to 'master'.


* mh/transport-capabilities (2015-02-13) 2 commits
  (merged to 'next' on 2015-02-18 at 87e8fcc)
 + transport-helper: ask the helper to set the same options for import as for fetch
 + transport-helper: ask the helper to set progress and verbosity options after asking for its capabilities

 The transport-helper did not give transport options such as
 verbosity, progress, cloning, etc. to import and export based
 helpers, like it did for fetch and push based helpers, robbing them
 the chance to honor the wish of the end-users better.

 Will merge to 'master'.


* sb/hex-object-name-is-at-most-41-bytes-long (2015-02-13) 1 commit
  (merged to 'next' on 2015-02-18 at 53d522b)
 + hex.c: reduce memory footprint of sha1_to_hex static buffers

 Code clean-up.

 Will merge to 'master'.


* jk/daemon-interpolate (2015-02-17) 3 commits
 - daemon: sanitize incoming virtual hostname
 - t5570: test git-daemon's --interpolated-path option
 - git_connect: let user override virtual-host we send to daemon

 The "interpolated-path" option of "git daemon" inserted any string
 client declared on the "host=" capability request without checking.
 Sanitize and limit %H and %CH to a saner and a valid DNS name.

 Will merge to 'next'.


* rs/daemon-interpolate (2015-02-17) 2 commits
  (merged to 'next' on 2015-02-18 at c0f5750)
 + daemon: use callback to build interpolated path
 + daemon: look up client-supplied hostname lazily

 "git daemon" looked up the hostname even when "%CH" and "%IP"
 interpolations are not requested, which was unnecessary.

 Will merge to 'master'.


* sb/plug-leak-in-make-cache-entry (2015-02-17) 1 commit
  (merged to 'next' on 2015-02-18 at e637f65)
 + read-cache.c: free cache entry when refreshing fails

 "update-index --refresh" used to leak when an entry cannot be
 refreshed for whatever reason.

 Will merge to 'master'.


* jn/doc-api-errors (2014-12-04) 1 commit
  (merged to 'next' on 2015-02-18 at f60eda6)
 + doc: document error handling functions and conventions

 The error handling functions and conventions are now documented in
 the API manual.

 Will merge to 'master'.


* jk/sanity (2015-02-15) 3 commits
  (merged to 'next' on 2015-02-18 at 5c54b53)
 + test-lib.sh: set prerequisite SANITY by testing what we really need
 + tests: correct misuses of POSIXPERM
 + t/lib-httpd: switch SANITY check for NOT_ROOT

 The tests that wanted to see that file becomes unreadable after
 running "chmod a-r file", and the tests that wanted to make sure it
 is not run as root, we used "can we write into the / directory?" as
 a cheap substitute, but on some platforms that is not a good
 heuristics.  The tests and their prerequisites have been updated to
 check what they really require.

 Will merge to 'master'.


* ab/merge-file-prefix (2015-02-11) 1 commit
  (merged to 'next' on 2015-02-16 at 89e0252)
 + merge-file: correctly open files when in a subdir

 "git merge-file" did not work correctly in a subdirectory.

 Will merge to 'master'.


* es/blame-commit-info-fix (2015-02-10) 1 commit
  (merged to 'next' on 2015-02-16 at f76ff44)
 + builtin/blame: destroy initialized commit_info only

 "git blame" died, trying to free an uninitialized piece of memory.

 Will merge to 'master'.


* es/squelch-openssl-warnings-on-macosx (2015-02-09) 1 commit
  (merged to 'next' on 2015-02-16 at bbe2880)
 + git-compat-util: do not step on MAC_OS_X_VERSION_MIN_REQUIRED

 An earlier workaround to squelch unhelpful deprecation warnings
 from the complier on Mac OSX unnecessarily set minimum required
 version of the OS, which the user might want to raise (or lower)
 for other reasons.

 Will merge to 'master'.


* jc/max-io-size-and-ssize-max (2015-02-12) 1 commit
  (merged to 'next' on 2015-02-18 at 0c8a4da)
 + xread/xwrite: clip MAX_IO_SIZE to SSIZE_MAX

 Our default I/O size (8 MiB) for large files was too large for some
 platforms with smaller SSIZE_MAX, leading to read(2)/write(2)
 failures.

 Will merge to 'master'.


* jk/fast-import-die-nicely-fix (2015-02-10) 1 commit
  (merged to 'next' on 2015-02-18 at e249425)
 + fast-import: avoid running end_packfile recursively

 "git fast-import" used to crash when it could not close and
 conclude the resulting packfile cleanly.

 Will merge to 'master'.


* mh/expire-updateref-fixes (2015-02-09) 10 commits
 - reflog_expire(): lock symbolic refs themselves, not their referent
 - reflog_expire(): never update a reference to null_sha1
 - reflog_expire(): ignore --updateref for symbolic references
 - reflog: rearrange the manpage
 - reflog: fix documentation
 - lock_ref_sha1_basic(): do not set force_write for missing references
 - write_ref_sha1(): Move write elision test to callers
 - write_ref_sha1(): remove check for lock == NULL
 - Merge branch 'sb/atomic-push' into mh/ref-trans-value-check
 - Merge branch 'mh/reflog-expire' into mh/ref-trans-value-check

 Under discussion ($gmane/263552)


* mh/refs-have-new (2015-02-17) 13 commits
 - refs.h: remove duplication in function docstrings
 - update_ref(): improve documentation
 - ref_transaction_verify(): new function to check a reference's value
 - ref_transaction_delete(): check that old_sha1 is not null_sha1
 - ref_transaction_create(): check that new_sha1 is valid
 - commit: avoid race when creating orphan commits
 - commit: add tests of commit races
 - ref_transaction_delete(): remove "have_old" parameter
 - ref_transaction_update(): remove "have_old" parameter
 - struct ref_update: move "have_old" into "flags"
 - refs.c: change some "flags" to "unsigned int"
 - refs: remove the gap in the REF_* constant values
 - refs: move REF_DELETING to refs.c

 Simplify the ref transaction API around how "the ref should be
 pointing at this object" is specified.

 Looked sensible.
 Will merge to 'next', unless there is an objection.


* jc/diff-files-ita (2015-02-04) 1 commit
  (merged to 'next' on 2015-02-16 at d7867a3)
 + run_diff_files(): clarify computation of sha1 validity

 Code cleanup.

 Will merge to 'master'.


* ss/check-builtins-on-windows (2015-02-05) 1 commit
  (merged to 'next' on 2015-02-16 at 2c10cc1)
 + check-builtins: strip executable suffix $X when enumerating builtins

 Will merge to 'master'.


* jc/apply-beyond-symlink (2015-02-10) 4 commits
  (merged to 'next' on 2015-02-18 at 4109de1)
 + apply: do not touch a file beyond a symbolic link
 + apply: do not read from beyond a symbolic link
 + apply: do not read from the filesystem under --index
 + apply: reject input that touches outside the working area

 "git apply" was not very careful about reading from, removing,
 updating and creating paths outside the working tree (under
 --index/--cached) or the current directory (when used as a
 replacement for GNU patch).

 Will merge to 'master'.


* jk/prune-mtime (2015-02-09) 2 commits
  (merged to 'next' on 2015-02-16 at 3d46eae)
 + sha1_file: fix iterating loose alternate objects
 + for_each_loose_file_in_objdir: take an optional strbuf path

 In v2.2.0, we broke "git prune" that runs in a repository that
 borrows from an alternate object store.

 Will merge to 'master'.


* ps/submodule-sanitize-path-upon-add (2015-02-02) 1 commit
  (merged to 'next' on 2015-02-16 at 8253132)
 + git-submodule.sh: fix '/././' path normalization

 "git submodule add" failed to squash "path/to/././submodule" to
 "path/to/submodule".

 Will merge to 'master'.


* tc/curl-vernum-output-broken-in-7.11 (2015-02-03) 1 commit
  (merged to 'next' on 2015-02-16 at de90f95)
 + Makefile: handle broken curl version number in version check

 Certain older vintages of cURL give irregular output from
 "curl-config --vernum", which confused our build system.

 Will merge to 'master'.


* tc/missing-http-proxyauth (2015-02-03) 1 commit
  (merged to 'next' on 2015-02-18 at 8ff01ad)
 + http: support curl < 7.10.7

 We did not check the curl library version before using
 CURLOPT_PROXYAUTH feature that may not exist.

 Will merge to 'master'.


* jc/apply-ws-fix-expands-report (2015-01-22) 1 commit
  (merged to 'next' on 2015-02-18 at b571668)
 + apply: detect and mark whitespace errors in context lines when fixing

 "git apply --whitespace=fix" fixed whitespace errors in the common
 context lines but did so without reporting.

 Will merge to 'master'.


* jc/conf-var-doc (2015-02-02) 3 commits
  (merged to 'next' on 2015-02-16 at 97512a3)
 + CodingGuidelines: describe naming rules for configuration variables
 + config.txt: mark deprecated variables more prominently
 + config.txt: clarify that add.ignore-errors is deprecated

 Longstanding configuration variable naming rules has been added to
 the documentation.

 Will merge to 'master'.


* js/fsck-opt (2015-01-21) 19 commits
 - fsck: support ignoring objects in `git fsck` via fsck.skiplist
 - fsck: git receive-pack: support excluding objects from fsck'ing
 - fsck: introduce `git fsck --quick`
 - fsck: support demoting errors to warnings
 - fsck: document the new receive.fsck.* options
 - fsck: allow upgrading fsck warnings to errors
 - fsck: optionally ignore specific fsck issues completely
 - fsck: disallow demoting grave fsck errors to warnings
 - fsck: add a simple test for receive.fsck.*
 - fsck: make fsck_tag() warn-friendly
 - fsck: handle multiple authors in commits specially
 - fsck: make fsck_commit() warn-friendly
 - fsck: make fsck_ident() warn-friendly
 - fsck: report the ID of the error/warning
 - fsck: allow demoting errors to warnings via receive.fsck.warn = <key>
 - fsck: offer a function to demote fsck errors to warnings
 - fsck: provide a function to parse fsck message IDs
 - fsck: introduce identifiers for fsck messages
 - fsck: introduce fsck options

 "fsck.warnings = <list of error tokens>" I suggested turned out to
 be an unpopular choice (sorry Dscho).

 Expecting a reroll.


* jk/strbuf-doc-to-header (2015-01-16) 7 commits
  (merged to 'next' on 2015-02-18 at 0482c65)
 + strbuf.h: group documentation for trim functions
 + strbuf.h: drop boilerplate descriptions of strbuf_split_*
 + strbuf.h: reorganize api function grouping headers
 + strbuf.h: format asciidoc code blocks as 4-space indent
 + strbuf.h: drop asciidoc list formatting from API docs
 + strbuf.h: unify documentation comments beginnings
 + strbuf.h: integrate api-strbuf.txt documentation

 Resolve the "doc vs header" to favor the latter.

 Will merge to 'master'.


* nd/attr-optim (2014-12-29) 3 commits
  (merged to 'next' on 2015-02-18 at 598e68a)
 + attr: avoid heavy work when we know the specified attr is not defined
 + attr: do not attempt to expand when we know it's not a macro
 + attr.c: rename arg name attr_nr to avoid shadowing the global one

 Optimize attribute look-up, mostly useful in "git grep" on a
 project that does not use many attributes, by avoiding it when we
 (should) know that the attributes are not defined in the first
 place.

 Will merge to 'master'.


* nd/multiple-work-trees (2015-01-27) 38 commits
  (merged to 'next' on 2015-02-18 at b51f696)
 + t2026 needs procondition SANITY
 + git-checkout.txt: a note about multiple checkout support for submodules
 + checkout: add --ignore-other-wortrees
 + checkout: pass whole struct to parse_branchname_arg instead of individual flags
 + git-common-dir: make "modules/" per-working-directory directory
 + checkout: do not fail if target is an empty directory
 + t2025: add a test to make sure grafts is working from a linked checkout
 + checkout: don't require a work tree when checking out into a new one
 + git_path(): keep "info/sparse-checkout" per work-tree
 + count-objects: report unused files in $GIT_DIR/worktrees/...
 + gc: support prune --worktrees
 + gc: factor out gc.pruneexpire parsing code
 + gc: style change -- no SP before closing parenthesis
 + checkout: clean up half-prepared directories in --to mode
 + checkout: reject if the branch is already checked out elsewhere
 + prune: strategies for linked checkouts
 + checkout: support checking out into a new working directory
 + use new wrapper write_file() for simple file writing
 + wrapper.c: wrapper to open a file, fprintf then close
 + setup.c: support multi-checkout repo setup
 + setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
 + setup.c: convert check_repository_format_gently to use strbuf
 + setup.c: detect $GIT_COMMON_DIR in is_git_directory()
 + setup.c: convert is_git_directory() to use strbuf
 + git-stash: avoid hardcoding $GIT_DIR/logs/....
 + *.sh: avoid hardcoding $GIT_DIR/hooks/...
 + git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
 + $GIT_COMMON_DIR: a new environment variable
 + commit: use SEQ_DIR instead of hardcoding "sequencer"
 + fast-import: use git_path() for accessing .git dir instead of get_git_dir()
 + reflog: avoid constructing .lock path with git_path
 + *.sh: respect $GIT_INDEX_FILE
 + git_path(): be aware of file relocation in $GIT_DIR
 + path.c: group git_path(), git_pathdup() and strbuf_git_path() together
 + path.c: rename vsnpath() to do_git_path()
 + git_snpath(): retire and replace with strbuf_git_path()
 + path.c: make get_pathname() call sites return const char *
 + path.c: make get_pathname() return strbuf instead of static buffer

 A replacement for contrib/workdir/git-new-workdir that does not
 rely on symbolic links and make sharing of objects and refs safer
 by making the borrowee and borrowers aware of each other.

 Will cook in 'next'.

--------------------------------------------------
[Discarded]

* tc/t9001-noxmailer (2015-01-30) 1 commit
 . t9001: use older Getopt::Long boolean prefix '--no' rather than '--no-'

 Kyle's update to explicitly support --no-option with older
 Getopt::Long ($gmane/263203) makes this unnecessary.
