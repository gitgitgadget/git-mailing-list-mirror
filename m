From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2013, #06; Thu, 21)
Date: Thu, 21 Mar 2013 16:04:52 -0700
Message-ID: <7vzjxw8icr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 22 00:05:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIoYF-00023X-PD
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 00:05:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754007Ab3CUXE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 19:04:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43190 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751934Ab3CUXE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 19:04:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F451B16E;
	Thu, 21 Mar 2013 19:04:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=w
	wNfGHl2oY8C3Uv4UAXpGPrMJSE=; b=RwPbUauj3oKkVdB2nq5GiY0ySxvDpqWdM
	K3QpfQ7AfZHuWmIOnYn05BGEjAka7ko0fmrNWTcBZiZ2GpPUMWr8mCWcDmin6vpC
	BME+dGaPld7GIfAZi6pokP5xeykydyBUGa/Mg7mQJkLq3iHjPplAuOaErFU6tfTH
	OyQ97qXkgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=HtK
	swOITObtHNf6GZZhV5W5GSVIKrn1hO9XA8hDNevZmbiiDigkXOT8T7pOLAnsDhfg
	my30s8Cm8WV5/TJuEJ2gKnjrzaXdDFw7uCKGf5rHEKbT5hB2IdFwF/Lc07MPvr34
	dShtt1ZLqpXv3AHhMlA0UTD4gQ4tg+Fc8rECtGdo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82FF6B16D;
	Thu, 21 Mar 2013 19:04:55 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E2BAB167; Thu, 21 Mar 2013
 19:04:53 -0400 (EDT)
X-master-at: 7b592fadf1e23b10b913e0771b9f711770597266
X-next-at: ddc39398152011b6a071e28b0f18f69ba427d0c0
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BDBEB324-927B-11E2-9D01-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218771>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

Quite a few topics have graduated to 'master'; they were all cooking
in 'next' during the feature-freeze from the previous cycle.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ap/maint-update-index-h-is-for-help (2013-02-23) 1 commit
  (merged to 'next' on 2013-03-19 at 1d7d180)
 + update-index: allow "-h" to also display options

 Originally merged to 'next' on 2013-02-25

 "git update-index -h" did not do the usual "-h(elp)" thing.


* bc/commit-complete-lines-given-via-m-option (2013-02-19) 4 commits
  (merged to 'next' on 2013-03-19 at 1609f9d)
 + Documentation/git-commit.txt: rework the --cleanup section
 + git-commit: only append a newline to -m mesg if necessary
 + t7502: demonstrate breakage with a commit message with trailing newlines
 + t/t7502: compare entire commit message with what was expected

 Originally merged to 'next' on 2013-02-19

 'git commit -m "$str"' when $str was already terminated with a LF
 now avoids adding an extra LF to the message.


* da/difftool-fixes (2013-02-21) 4 commits
  (merged to 'next' on 2013-03-19 at ffcb23f)
 + t7800: "defaults" is no longer a builtin tool name
 + t7800: modernize tests
 + t7800: update copyright notice
 + difftool: silence uninitialized variable warning

 Originally merged to 'next' on 2013-02-25

 Minor maintenance updates to difftool, and updates to its tests.


* da/downcase-u-in-usage (2013-02-24) 20 commits
  (merged to 'next' on 2013-02-26 at 977b67e)
 + contrib/mw-to-git/t/install-wiki.sh: use a lowercase "usage:" string
 + contrib/examples/git-remote.perl: use a lowercase "usage:" string
 + tests: use a lowercase "usage:" string
 + git-svn: use a lowercase "usage:" string
 + Documentation/user-manual.txt: use a lowercase "usage:" string
 + templates/hooks--update.sample: use a lowercase "usage:" string
 + contrib/hooks/setgitperms.perl: use a lowercase "usage:" string
 + contrib/examples: use a lowercase "usage:" string
 + contrib/fast-import/import-zips.py: use spaces instead of tabs
 + contrib/fast-import/import-zips.py: fix broken error message
 + contrib/fast-import: use a lowercase "usage:" string
 + contrib/credential: use a lowercase "usage:" string
 + git-cvsimport: use a lowercase "usage:" string
 + git-cvsimport: use a lowercase "usage:" string
 + git-cvsexportcommit: use a lowercase "usage:" string
 + git-archimport: use a lowercase "usage:" string
 + git-merge-one-file: use a lowercase "usage:" string
 + git-relink: use a lowercase "usage:" string
 + git-svn: use a lowercase "usage:" string
 + git-sh-setup: use a lowercase "usage:" string

 Originally merged to 'next' on 2013-02-26


* dm/ni-maxhost-may-be-missing (2013-02-25) 1 commit
  (merged to 'next' on 2013-02-26 at 93ec2c9)
 + git-compat-util.h: Provide missing netdb.h definitions

 Originally merged to 'next' on 2013-02-26


* gp/avoid-explicit-mention-of-dot-git-refs (2013-02-24) 1 commit
  (merged to 'next' on 2013-02-26 at ec42d98)
 + Fix ".git/refs" stragglers

 Originally merged to 'next' on 2013-02-26


* gp/describe-match-uses-glob-pattern (2013-02-24) 1 commit
  (merged to 'next' on 2013-02-26 at c9cc789)
 + describe: Document --match pattern format

 Originally merged to 'next' on 2013-02-26


* jc/color-diff-doc (2013-02-22) 1 commit
  (merged to 'next' on 2013-02-25 at c37541c)
 + diff-options: unconfuse description of --color

 Originally merged to 'next' on 2013-02-25


* jc/fetch-raw-sha1 (2013-02-07) 4 commits
  (merged to 'next' on 2013-03-19 at d5363f6)
 + fetch: fetch objects by their exact SHA-1 object names
 + upload-pack: optionally allow fetching from the tips of hidden refs
 + fetch: use struct ref to represent refs to be fetched
 + parse_fetch_refspec(): clarify the codeflow a bit

 Originally merged to 'next' on 2013-02-14

 Allows requests to fetch objects at any tip of refs (including
 hidden ones).  It seems that there may be use cases even outside
 Gerrit (e.g. $gmane/215701).


* jc/maint-push-refspec-default-doc (2013-03-08) 1 commit
  (merged to 'next' on 2013-03-19 at 0b2fa41)
 + Documentation/git-push: clarify the description of defaults

 Originally merged to 'next' on 2013-03-14

 Clarify in the documentation "what" gets pushed to "where" when the
 command line to "git push" does not say these explicitly.


* jc/perl-cat-blob (2013-02-22) 1 commit
  (merged to 'next' on 2013-03-19 at ad3aae3)
 + Git.pm: fix cat_blob crashes on large files

 Originally merged to 'next' on 2013-02-25

 perl/Git.pm::cat_blob slurped everything in core only to write it
 out to a file descriptor, which was not a very smart thing to do.


* jk/graph-c-expose-symbols-for-cgit (2013-03-03) 1 commit
  (merged to 'next' on 2013-03-04 at be35b12)
 + Revert "graph.c: mark private file-scope symbols as static"

 Originally merged to 'next' on 2013-03-04

 In the v1.8.0 era, we changed symbols that do not have to be global
 to file scope static, but a few functions in graph.c were used by
 CGit from sideways bypassing the entry points of the API the
 in-tree users use.


* jk/mailsplit-maildir-muttsort (2013-03-02) 1 commit
  (merged to 'next' on 2013-03-19 at 26f457c)
 + mailsplit: sort maildir filenames more cleverly

 Originally merged to 'next' on 2013-03-03

 Sort filenames read from the maildir/ in a way that is more likely
 to sort messages in the order the writing MUA meant to, by sorting
 numeric segment in numeric order and non-numeric segment in
 alphabetical order.


* jk/utf-8-can-be-spelled-differently (2013-02-25) 1 commit
  (merged to 'next' on 2013-03-19 at 18ebb43)
 + utf8: accept alternate spellings of UTF-8

 Originally merged to 'next' on 2013-02-26

 Some platforms and users spell UTF-8 differently; retry with the
 most official "UTF-8" when the system does not understand the
 user-supplied encoding name that are the common alternative
 spellings of UTF-8.


* jn/shell-disable-interactive (2013-03-09) 2 commits
  (merged to 'next' on 2013-03-19 at 4696604)
 + shell: new no-interactive-login command to print a custom message
 + shell doc: emphasize purpose and security model

 Originally merged to 'next' on 2013-03-14

 When the interactive access to git-shell is not enabled, we issue a
 message meant to help the system admininstrator to enable it. Add
 an explicit way to help the end users who connect to the service by
 issuing custom messages to refuse such an access.


* lf/bundle-verify-list-prereqs (2013-03-08) 2 commits
  (merged to 'next' on 2013-03-08 at 9e55d6d)
 + bundle: Add colons to list headings in "verify"
 + bundle: Fix "verify" output if history is complete

 Originally merged to 'next' on 2013-03-08


* mg/gpg-interface-using-status (2013-02-14) 5 commits
  (merged to 'next' on 2013-03-19 at bd54c7a)
 + pretty: make %GK output the signing key for signed commits
 + pretty: parse the gpg status lines rather than the output
 + gpg_interface: allow to request status return
 + log-tree: rely upon the check in the gpg_interface
 + gpg-interface: check good signature in a reliable way

 Originally merged to 'next' on 2013-02-26

 Call "gpg" using the right API when validating the signature on
 tags.


* mn/send-email-works-with-credential (2013-02-27) 6 commits
  (merged to 'next' on 2013-03-19 at 2daad63)
 + git-send-email: use git credential to obtain password
 + Git.pm: add interface for git credential command
 + Git.pm: allow pipes to be closed prior to calling command_close_bidi_pipe
 + Git.pm: refactor command_close_bidi_pipe to use _cmd_close
 + Git.pm: fix example in command_close_bidi_pipe documentation
 + Git.pm: allow command_close_bidi_pipe to be called as method

 Originally merged to 'next' on 2013-02-27

 Hooks the credential system to send-email.


* nd/branch-error-cases (2013-02-23) 1 commit
  (merged to 'next' on 2013-03-19 at 17834dd)
 + branch: segfault fixes and validation

 Originally merged to 'next' on 2013-02-25

 "git branch" had more cases where it did not bother to check
 nonsense command line parameters.


* nd/count-garbage (2013-02-15) 4 commits
  (merged to 'next' on 2013-03-19 at cf6fa47)
 + count-objects: report how much disk space taken by garbage files
 + count-objects: report garbage files in pack directory too
 + sha1_file: reorder code in prepare_packed_git_one()
 + git-count-objects.txt: describe each line in -v output

 Originally merged to 'next' on 2013-02-17

 "git count-objects -v" did not count leftover temporary packfiles
 and other kinds of garbage.


* nd/doc-index-format (2013-02-23) 3 commits
  (merged to 'next' on 2013-02-26 at 4d3caea)
 + update-index: list supported idx versions and their features
 + read-cache.c: use INDEX_FORMAT_{LB,UB} in verify_hdr()
 + index-format.txt: mention of v4 is missing in some places

 Originally merged to 'next' on 2013-02-26

 Update the index format documentation to mention the v4 format.


* nd/index-pack-l10n-buf-overflow (2013-03-16) 1 commit
  (merged to 'next' on 2013-03-19 at 01f0223)
 + index-pack: fix buffer overflow caused by translations

 Originally merged to 'next' on 2013-03-18


* nd/preallocate-hash (2013-03-16) 1 commit
  (merged to 'next' on 2013-03-19 at b92f720)
 + Preallocate hash tables when the number of inserts are known in advance

 Originally merged to 'next' on 2013-03-18

 When we know approximately how many entries we will have in the
 hash-table, it makes sense to size the hash table to that number
 from the beginning to avoid unnecessary rehashing.


* ob/imap-send-ssl-verify (2013-02-20) 1 commit
  (merged to 'next' on 2013-03-19 at 81aaed2)
 + imap-send: support Server Name Indication (RFC4366)

 Originally merged to 'next' on 2013-02-25

 Correctly connect to SSL/TLS sites that serve multiple hostnames on
 a single IP by including Server Name Indication in the client-hello.


* rj/msvc-build (2013-02-25) 5 commits
  (merged to 'next' on 2013-02-26 at 7493068)
 + msvc: avoid collisions between "tags" and "TAGS"
 + msvc: test-svn-fe: Fix linker "unresolved external" error
 + msvc: Fix build by adding missing symbol defines
 + msvc: git-daemon: Fix linker "unresolved external" errors
 + msvc: Fix compilation errors caused by poll.h emulation

 Originally merged to 'next' on 2013-02-26


* rs/zip-compresssed-size-with-export-subst (2013-02-27) 1 commit
  (merged to 'next' on 2013-03-19 at 3d2ff88)
 + archive-zip: fix compressed size for stored export-subst files
 (this branch is used by rs/archive-zip-raw-compression.)

 Originally merged to 'next' on 2013-03-03

 When export-subst is used, "zip" output recorded incorrect
 size of the file.


* rt/commit-cleanup-config (2013-02-23) 1 commit
  (merged to 'next' on 2013-03-19 at 846cf01)
 + t7502: perform commits using alternate editor in a subshell

 Originally merged to 'next' on 2013-02-25

 Fix tests that contaminated their environments and affected new
 tests introduced later in the sequence by containing their effects
 in their own subshells.


* tb/document-status-u-tradeoff (2013-03-16) 2 commits
  (merged to 'next' on 2013-03-19 at 01573b6)
 + status: advise to consider use of -u when read_directory takes too long
 + git status: document trade-offs in choosing parameters to the -u option

 Originally merged to 'next' on 2013-03-18

 Suggest users to look into using--untracked=no option when "git
 status" takes too long.


* tk/doc-filter-branch (2013-02-26) 2 commits
  (merged to 'next' on 2013-02-26 at bd4638b)
 + Documentation: filter-branch env-filter example
 + git-filter-branch.txt: clarify ident variables usage

 Originally merged to 'next' on 2013-02-26


* tz/credential-authinfo (2013-02-25) 1 commit
  (merged to 'next' on 2013-03-19 at 1a68953)
 + Add contrib/credentials/netrc with GPG support

 Originally merged to 'next' on 2013-02-27

 A new read-only credential helper (in contrib/) to interact with
 the .netrc/.authinfo files.  Hopefully mn/send-email-authinfo topic
 can rebuild on top of something like this.


* we/submodule-update-prefix-output (2013-03-03) 1 commit
  (merged to 'next' on 2013-03-19 at a818063)
 + submodule update: when using recursion, show full path

 Originally merged to 'next' on 2013-03-04

 "git submodule update", when recursed into sub-submodules, did not
 acccumulate the prefix paths.


* wk/doc-pre-rebase (2013-02-24) 1 commit
  (merged to 'next' on 2013-02-25 at a6ec310)
 + Documentation/githooks: Explain pre-rebase parameters

 Originally merged to 'next' on 2013-02-25


* wk/user-manual-literal-format (2013-02-25) 1 commit
  (merged to 'next' on 2013-02-26 at d59ce38)
 + user-manual: Standardize backtick quoting

 Originally merged to 'next' on 2013-02-26

--------------------------------------------------
[New Topics]

* jc/merge-tag-object (2013-03-19) 1 commit
 - merge: a random object may not necssarily be a commit

 "git merge $(git rev-parse v1.8.2)" behaved quite differently from
 "git merge v1.8.2" as if v1.8.2 were written as v1.8.2^0 and did
 not pay much attention to the annotated tag payload.

 This makes the code notice the type of the tag object, in addition
 to the dwim_ref() based classification the current code uses
 (i.e. the name appears in refs/tags/) to decide when to special
 case merging of tags.

 We may actually want to call the current behaviour a feature,
 though.  After all, the user went to great length to feed something
 different from the normal "v1.8.2" to the command.


* jk/index-pack-correct-depth-fix (2013-03-20) 1 commit
 - index-pack: always zero-initialize object_entry list

 "index-pack --fix-thin" used uninitialize value to compute delta
 depths of objects it appends to the resulting pack.


* jn/push-tests (2013-03-19) 3 commits
 - push test: rely on &&-chaining instead of 'if bad; then echo Oops; fi'
 - push test: simplify check of push result
 - push test: use test_config when appropriate

 Update t5516 with style fixes.


* nd/index-pack-threaded-fixes (2013-03-19) 2 commits
 - index-pack: guard nr_resolved_deltas reads by lock
 - index-pack: protect deepest_delta in multithread code

 "index-pack --verify-stat" used a few counters outside protection
 of mutex, possibly showing incorrect numbers.


* kb/status-ignored-optim (2013-03-19) 8 commits
 - dir.c: git-status: avoid is_excluded checks for tracked files
 - dir.c: replace is_path_excluded with now equivalent is_excluded API
 - dir.c: unify is_excluded and is_path_excluded APIs
 - dir.c: move prep_exclude and factor out parts of last_exclude_matching
 - dir.c: git-status --ignored: don't list empty directories as ignored
 - dir.c: git-status --ignored: don't list empty ignored directories
 - dir.c: git-status --ignored: don't list files in ignored directories
 - dir.c: git-status --ignored: don't drop ignored directories

 "git status --ignored" had many corner case bugs.  Also the command
 has been optimized by taking advantage of the fact that paths that
 are already known to the index do not have to be checked against
 the .gitignore mechanism most of the time.

 Expecting a review from others; this codepath is used not only by
 status but also in add and clean, so a bug in it can result in lost
 data.


* rr/tests-dedup-test-config (2013-03-19) 1 commit
 - t4018,7810,7811: remove test_config() redefinition

 Will merge to 'next'.


* ja/directory-attrs (2013-03-20) 1 commit
 - trailing slash required in .gitattributes

 Expose but not fix a recent regression that started not matching a
 directory "sub" with gitattributes pattern "sub" (without trailing
 slash).


* jn/add-2.0-u-A-sans-pathspec (2013-03-20) 5 commits
 - git add: -u/-A now affects the entire working tree
 - add -A: only show pathless 'add -A' warning when changes exist outside cwd
 - add -u: only show pathless 'add -u' warning when changes exist outside cwd
 - add: make warn_pathless_add() a no-op after first call
 - add: make pathless 'add [-u|-A]' warning a file-global function

 Replaces jc/add-2.0-u-A-sans-pathspec topic by not warning against
 "add -u/-A" that is ran without pathspec when there is no change
 outside the current directory.


* rr/test-3200-style (2013-03-20) 1 commit
 - t3200 (branch): modernize style

 Churns.

 Will merge to 'next'.


* tr/packed-object-info-wo-recursion (2013-03-20) 1 commit
 - sha1_file: remove recursion in packed_object_info

 Attempts to reduce the stack footprint of sha1_object_info()
 codepath.


* sr/am-show-final-message-in-applying-indicator (2013-03-21) 1 commit
 - git-am: show the final log message on "Applying:" indicator


* yd/doc-merge-annotated-tag (2013-03-21) 1 commit
 - Documentation: merging a tag is a special case


* yd/doc-is-in-asciidoc (2013-03-21) 1 commit
 - CodingGuidelines: our documents are in AsciiDoc

--------------------------------------------------
[Stalled]

* jc/format-patch (2013-02-21) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.

 Not ready for inclusion.


* mg/qnx6 (2013-02-25) 1 commit
 - QNX: newer QNX 6.x.x is not so crippled

 Not ready for inclusion.


* po/help-guides (2013-03-03) 5 commits
 - help doc: include --guide option description
 - help.c: add list_common_guides_help() function
 - help.c: add --guide option
 - help.c: use OPT_COUNTUP
 - show 'git help <guide>' usage, with examples

 Give more visibility to "concept guides" to help "git help" users.

 Expecting a reroll.
 $gmane/217384


* hv/config-from-strbuf (2013-03-10) 4 commits
 - teach config parsing to read from strbuf
 - config: make parsing stack struct independent from actual data source
 - config: drop file pointer validity check in get_next_char()
 - config: factor out config file stack management

 Expecting a reroll.
 $gmane/217811


* mb/gitweb-highlight-link-target (2012-12-20) 1 commit
 - Highlight the link target line in Gitweb using CSS

 Expecting a reroll.
 $gmane/211935


* mb/remote-default-nn-origin (2012-07-11) 6 commits
 - Teach get_default_remote to respect remote.default.
 - Test that plain "git fetch" uses remote.default when on a detached HEAD.
 - Teach clone to set remote.default.
 - Teach "git remote" about remote.default.
 - Teach remote.c about the remote.default configuration setting.
 - Rename remote.c's default_remote_name static variables.

 When the user does not specify what remote to interact with, we
 often attempt to use 'origin'.  This can now be customized via a
 configuration variable.

 Expecting a reroll.
 $gmane/210151

 "The first remote becomes the default" bit is better done as a
 separate step.

--------------------------------------------------
[Cooking]

* ap/combine-diff-ignore-whitespace (2013-03-14) 1 commit
  (merged to 'next' on 2013-03-19 at dfb2c98)
 + Allow combined diff to ignore white-spaces

 Originally merged to 'next' on 2013-03-18

 Teach "diff --cc" output to honor options to ignore various forms
 of whitespace changes.

 Will merge to 'master' in the 4th batch (Safe).


* jk/checkout-attribute-lookup (2013-03-20) 3 commits
  (merged to 'next' on 2013-03-20 at 43a89e8)
 + t2003: work around path mangling issue on Windows
  (merged to 'next' on 2013-03-19 at b063a55)
 + entry: fix filter lookup
 + t2003: modernize style

 Originally merged to 'next' on 2013-03-15

 Codepath to stream blob object contents directly from the object
 store to filesystem did not use the correct path to find conversion
 filters when writing to temporary files.

 Will merge to 'master' in the 4th batch (Safe).


* jk/difftool-dir-diff-edit-fix (2013-03-14) 3 commits
  (merged to 'next' on 2013-03-19 at e68014a)
 + difftool --dir-diff: symlink all files matching the working tree
 + difftool: avoid double slashes in symlink targets
 + git-difftool(1): fix formatting of --symlink description

 Originally merged to 'next' on 2013-03-15

 "git difftool --dir-diff" made symlinks to working tree files when
 preparing a temporary directory structure, so that accidental edits
 of these files in the difftool are reflected back to the working
 tree, but the logic to decide when to do so was not quite right.

 Will merge to 'master' in the 4th batch (Safe).


* lf/setup-prefix-pathspec (2013-03-14) 2 commits
  (merged to 'next' on 2013-03-19 at 0017e9e)
 + setup.c: check that the pathspec magic ends with ")"
 + setup.c: stop prefix_pathspec() from looping past the end of string

 Originally merged to 'next' on 2013-03-14

 "git cmd -- ':(top'" was not diagnosed as an invalid syntax, and
 instead the parser kept reading beyond the end of the string.

 Will merge to 'master' in the 3rd batch (Safe).


* jk/fully-peeled-packed-ref (2013-03-18) 4 commits
  (merged to 'next' on 2013-03-19 at fa92bc7)
 + pack-refs: add fully-peeled trait
 + pack-refs: write peeled entry for non-tags
 + use parse_object_or_die instead of die("bad object")
 + avoid segfaults on parse_object failure

 Originally merged to 'next' on 2013-03-18

 Not that we do not actively encourage having annotated tags outside
 refs/tags/ hierarchy, but they were not advertised correctly to the
 ls-remote and fetch with recent version of Git.

 Will merge to 'master' in the 3rd batch (Safe).


* jk/peel-ref (2013-03-16) 3 commits
  (merged to 'next' on 2013-03-19 at f0d4c16)
 + upload-pack: load non-tip "want" objects from disk
 + upload-pack: make sure "want" objects are parsed
 + upload-pack: drop lookup-before-parse optimization

 Originally merged to 'next' on 2013-03-18

 Recent optimization broke shallow clones.

 Will merge to 'master' in the 3rd batch (Safe).


* nd/magic-pathspecs (2013-03-21) 46 commits
 - fixup
 - Rename field "raw" to "_raw" in struct pathspec
 - pathspec: support :(glob) syntax
 - pathspec: make --literal-pathspecs disable pathspec magic
 - pathspec: support :(literal) syntax for noglob pathspec
 - Kill limit_pathspec_to_literal() as it's only used by parse_pathspec()
 - parse_pathspec: preserve prefix length via PATHSPEC_PREFIX_ORIGIN
 - parse_pathspec: make sure the prefix part is wildcard-free
 - tree-diff: remove the use of pathspec's raw[] in follow-rename codepath
 - Remove match_pathspec() in favor of match_pathspec_depth()
 - Remove init_pathspec() in favor of parse_pathspec()
 - Remove diff_tree_{setup,release}_paths
 - Convert common_prefix() to use struct pathspec
 - Convert add_files_to_cache to take struct pathspec
 - Convert {read,fill}_directory to take struct pathspec
 - Convert refresh_index to take struct pathspec
 - Convert report_path_error to take struct pathspec
 - checkout: convert read_tree_some to take struct pathspec
 - Convert unmerge_cache to take struct pathspec
 - Convert run_add_interactive to use struct pathspec
 - Convert read_cache_preload() to take struct pathspec
 - reset: convert to use parse_pathspec
 - add: convert to use parse_pathspec
 - check-ignore: convert to use parse_pathspec
 - archive: convert to use parse_pathspec
 - ls-files: convert to use parse_pathspec
 - rm: convert to use parse_pathspec
 - checkout: convert to use parse_pathspec
 - rerere: convert to use parse_pathspec
 - status: convert to use parse_pathspec
 - commit: convert to use parse_pathspec
 - clean: convert to use parse_pathspec
 - Guard against new pathspec magic in pathspec matching code
 - parse_pathspec: support prefixing original patterns
 - parse_pathspec: support stripping/checking submodule paths
 - parse_pathspec: support stripping submodule trailing slashes
 - parse_pathspec: a special flag for max_depth feature
 - Convert some get_pathspec() calls to parse_pathspec()
 - parse_pathspec: add PATHSPEC_PREFER_{CWD,FULL}
 - parse_pathspec: save original pathspec for reporting
 - Add parse_pathspec() that converts cmdline args to struct pathspec
 - pathspec: add copy_pathspec
 - pathspec: i18n-ize error strings in pathspec parsing code
 - Move struct pathspec and related functions to pathspec.[ch]
 - clean: remove unused variable "seen"
 - setup.c: check that the pathspec magic ends with ")"

 Migrate the rest of codebase to use "struct pathspec" more.


* pe/pull-rebase-v-q (2013-03-16) 1 commit
  (merged to 'next' on 2013-03-19 at 10b311c)
 + pull: Apply -q and -v options to rebase mode as well

 Originally merged to 'next' on 2013-03-18

 Teach "git pull --rebase" to pass "-v/-q" command line options to
 underlying "git rebase".

 Will merge to 'master' in the 2nd batch (Safe).


* rs/archive-zip-raw-compression (2013-03-16) 1 commit
  (merged to 'next' on 2013-03-19 at 8cc1cb3)
 + archive-zip: use deflateInit2() to ask for raw compressed data

 Originally merged to 'next' on 2013-03-18

 Will merge to 'master' in the 4th batch (Safe).


* jk/fast-export-object-lookup (2013-03-17) 2 commits
  (merged to 'next' on 2013-03-19 at 026ac3d)
 + fast-export: do not load blob objects twice
 + fast-export: rename handle_object function

 Originally merged to 'next' on 2013-03-18

 Will merge to 'master' in the 3rd batch (Safe).


* sw/safe-create-leading-dir-race (2013-03-17) 2 commits
 - SQUASH???
 - safe_create_leading_directories: fix race that could give a false negative

 Waiting for response to review comments.


* ph/tag-force-no-warn-on-creation (2013-03-13) 1 commit
  (merged to 'next' on 2013-03-19 at b273fd3)
 + tag: --force does not have to warn when creating tags

 Originally merged to 'next' on 2013-03-14

 "git tag -f <tag>" always said "Updated tag '<tag>'" even when
 creating a new tag (i.e. not overwriting nor updating).

 Will merge to 'master' in the 3rd batch (Safe).


* nd/branch-show-rebase-bisect-state (2013-03-16) 6 commits
 - branch: show more information when HEAD is detached
 - status: show more info than "currently not on any branch"
 - wt-status: move wt_status_get_state() out to wt_status_print()
 - wt-status: split wt_status_state parsing function out
 - wt-status: move strbuf into read_and_strip_branch()
 - Merge branch 'jc/reflog-reverse-walk' into nd/branch-show-rebase-bisect-state
 (this branch uses jc/reflog-reverse-walk.)

 Originally merged to 'next' on 2013-03-18

 The "biseting X" display is iffy.


* kb/p4merge (2013-03-13) 2 commits
  (merged to 'next' on 2013-03-19 at 43cc599)
 + mergetools/p4merge: create a base if none available
 + mergetools/p4merge: swap LOCAL and REMOTE

 Originally merged to 'next' on 2013-03-14

 Adjust the order mergetools feeds the files to the p4merge backend
 to match the p4 convention.

 Will merge to 'master' in the 3rd batch (Safe).


* jc/reflog-reverse-walk (2013-03-08) 3 commits
  (merged to 'next' on 2013-03-19 at 25beb2a)
 + reflog: add for_each_reflog_ent_reverse() API
 + for_each_recent_reflog_ent(): simplify opening of a reflog file
 + for_each_reflog_ent(): extract a helper to process a single entry
 (this branch is used by nd/branch-show-rebase-bisect-state.)

 Originally merged to 'next' on 2013-03-14

 An internal function used to implement "git checkout @{-1}" was
 hard to use correctly.

 Will merge to 'master' in the 3rd batch (Safe).


* jk/alias-in-bare (2013-03-08) 3 commits
  (merged to 'next' on 2013-03-19 at d2b4227)
 + setup: suppress implicit "." work-tree for bare repos
 + environment: add GIT_PREFIX to local_repo_env
 + cache.h: drop LOCAL_REPO_ENV_SIZE

 Originally merged to 'next' on 2013-03-09

 An aliased command spawned from a bare repository that does not say
 it is bare with "core.bare = yes" is treated as non-bare by mistake.

 Will merge to 'master' in the 3rd batch (Safe).


* pw/p4-symlinked-root (2013-03-11) 3 commits
  (merged to 'next' on 2013-03-19 at 9127e82)
 + git p4: avoid expanding client paths in chdir
 + git p4 test: should honor symlink in p4 client root
 + git p4 test: make sure P4CONFIG relative path works

 Originally merged to 'next' on 2013-03-12

 "git p4" did not behave well when the path to the root of the P4
 client was not its real path.

 Will merge to 'master' in the 3rd batch (Safe).


* jc/add-2.0-delete-default (2013-03-08) 3 commits
 - git add <pathspec>... defaults to "-A"
 - git add: start preparing for "git add <pathspec>..." to default to "-A"
 - builtin/add.c: simplify boolean variables

 Originally merged to 'next' on 2013-03-14

 "git add dir/" updated modified files and added new files, but does
 not notice removed files, which may be "Huh?" to some users.  They
 can of course use "git add -A dir/", but why should they?

 There seemed to be some interest in this topic, so resurrected and
 rebased on top of recent documentation updates to propose a
 possible transition plan.

 Will cook in 'next' until Git 2.0.


* jk/empty-archive (2013-03-10) 2 commits
  (merged to 'next' on 2013-03-19 at bb4eb61)
 + archive: handle commits with an empty tree
 + test-lib: factor out $GIT_UNZIP setup

 Originally merged to 'next' on 2013-03-12

 "git archive" reports a failure when asked to create an archive out
 of an empty tree.  It would be more intuitive to give an empty
 archive back in such a case.

 Will merge to 'master' in the 3rd batch (Safe).


* jc/nobody-sets-src-peer-ref (2013-03-04) 1 commit
 - match_push_refs(): nobody sets src->peer_ref anymore

 Originally merged to 'next' on 2013-03-07

 Dead code removal.

 Even though I think this change is correct, please report
 immediately if you find any unintended side effect.

 Will merge to 'master' in the 4th batch (Risky).


* jc/push-follow-tag (2013-03-05) 4 commits
  (merged to 'next' on 2013-03-19 at d302a10)
 + push: --follow-tags
 + commit.c: use clear_commit_marks_many() in in_merge_bases_many()
 + commit.c: add in_merge_bases_many()
 + commit.c: add clear_commit_marks_many()

 Originally merged to 'next' on 2013-03-09

 The new "--follow-tags" option tells "git push" to push relevant
 annotated tags when pushing branches out.

 Will merge to 'master' in the 3rd batch (Safe).


* jc/maint-reflog-expire-clean-mark-typofix (2013-03-05) 1 commit
  (merged to 'next' on 2013-03-19 at a4f9eac)
 + reflog: fix typo in "reflog expire" clean-up codepath

 Originally merged to 'next' on 2013-03-07

 In "git reflog expire", REACHABLE bit was not cleared from the
 correct objects.

 Will merge to 'master' in the 3rd batch (Safe).


* ks/rfc2047-one-char-at-a-time (2013-03-09) 1 commit
  (merged to 'next' on 2013-03-19 at 577ddf2)
 + format-patch: RFC 2047 says multi-octet character may not be split

 Originally merged to 'next' on 2013-03-09

 When "format-patch" quoted a non-ascii strings on the header files,
 it incorrectly applied rfc2047 and chopped a single character in
 the middle of it.

 Will merge to 'master' in the 3rd batch (Safe).


* kb/name-hash (2013-02-27) 1 commit
 - name-hash.c: fix endless loop with core.ignorecase=true

 Originally merged to 'next' on 2013-03-05

 The code to keep track of what directory names are known to Git on
 platforms with case insensitive filesystems can get confused upon
 a hash collision between these pathnames and looped forever.

 Even though I think this change is correct, please report
 immediately if you find any unintended side effect.

 Will merge to 'master' in the 4th batch (Risky).


* jc/describe (2013-02-28) 1 commit
  (merged to 'next' on 2013-03-19 at 89e6e47)
 + describe: --match=<pattern> must limit the refs even when used with --all

 Originally merged to 'next' on 2013-03-05

 The "--match=<pattern>" option of "git describe", when used with
 "--all" to allow refs that are not annotated tags to be used as a
 base of description, did not restrict the output from the command
 to those that match the given pattern.

 We may want to have a looser matching that does not restrict to tags,
 but that can be done as a follow-up topic; this step is purely a bugfix.

 Will merge to 'master' in the 3rd batch (Safe).


* tr/line-log (2013-03-21) 6 commits
 - Speed up log -L... -M
 - log -L: :pattern:file syntax to find by funcname
 - Implement line-history search (git log -L)
 - Export rewrite_parents() for 'log -L'
 - fixup
 - Refactor parse_loc

 Rerolled; collides with nd/magic-pathspecs.
 Does not seem to pass its own test (t4211-line-log.sh).


* ap/maint-diff-rename-avoid-overlap (2013-03-06) 3 commits
  (merged to 'next' on 2013-03-19 at c3276cf)
 + tests: make sure rename pretty print works
 + diff: prevent pprint_rename from underrunning input
 + diff: Fix rename pretty-print when suffix and prefix overlap

 Originally merged to 'next' on 2013-03-06

 The logic used by "git diff -M --stat" to shorten the names of
 files before and after a rename did not work correctly when the
 common prefix and suffix between the two filenames overlapped.

 Will merge to 'master' in the 3rd batch (Safe).


* jk/common-make-variables-export-safety (2013-02-25) 1 commit
 - Makefile: make mandir, htmldir and infodir absolute

 Originally merged to 'next' on 2013-03-05

 Make the three variables safer to be exported to submakes by
 ensuring that they are full paths so that they can be used as
 installation location.

 Even though I think this change is correct, please report
 immediately if you find any unintended side effect.

 Will merge to 'master' in the 4th batch (Risky).


* jk/suppress-clang-warning (2013-02-25) 1 commit
  (merged to 'next' on 2013-03-19 at 1fd6858)
 + fix clang -Wtautological-compare with unsigned enum

 Originally merged to 'next' on 2013-03-14

 Will merge to 'master' in the 3rd batch (Safe).


* mg/unsigned-time-t (2013-02-25) 2 commits
  (merged to 'next' on 2013-03-19 at 1fc1ad6)
 + Fix time offset calculation in case of unsigned time_t
 + date.c: fix unsigned time_t comparison

 Originally merged to 'next' on 2013-03-14

 A few workarounds for systems with unsigned time_t.

 Will merge to 'master' in the 3rd batch (Safe).


* jk/pkt-line-cleanup (2013-03-21) 20 commits
 - do not use GIT_TRACE_PACKET=3 in tests
 - remote-curl: always parse incoming refs
 - remote-curl: move ref-parsing code up in file
 - remote-curl: pass buffer straight to get_remote_heads
 - teach get_remote_heads to read from a memory buffer
 - pkt-line: share buffer/descriptor reading implementation
 - pkt-line: provide a LARGE_PACKET_MAX static buffer
 - pkt-line: move LARGE_PACKET_MAX definition from sideband
 - pkt-line: teach packet_read_line to chomp newlines
 - pkt-line: provide a generic reading function with options
 - pkt-line: drop safe_write function
 - pkt-line: move a misplaced comment
 - write_or_die: raise SIGPIPE when we get EPIPE
 - upload-archive: use argv_array to store client arguments
 - upload-archive: do not copy repo name
 - send-pack: prefer prefixcmp over memcmp in receive_status
 - fetch-pack: fix out-of-bounds buffer offset in get_ack
 - upload-pack: remove packet debugging harness
 - upload-pack: do not add duplicate objects to shallow list
 - upload-pack: use get_sha1_hex to parse "shallow" lines

 Originally merged to 'next' on 2013-02-25

 Cleans up pkt-line API, implementation and its callers to make them
 more robust.  Even though I think this change is correct, please
 report immediately if you find any unintended side effect.

 Will merge to 'master' in the 3rd batch (Risky).


* jl/submodule-deinit (2013-03-04) 1 commit
  (merged to 'next' on 2013-03-19 at d8367c5)
 + submodule: add 'deinit' command

 Originally merged to 'next' on 2013-03-05

 There was no Porcelain way to say "I no longer am interested in
 this submodule", once you express your interest in a submodule with
 "submodule init".  "submodule deinit" is the way to do so.

 Will merge to 'master' in the 3rd batch (Safe).


* jc/remove-export-from-config-mak-in (2013-03-05) 3 commits
 - Fix `make install` when configured with autoconf
 - Makefile: do not export mandir/htmldir/infodir
 - config.mak.in: remove unused definitions

 Originally merged to 'next' on 2013-03-05

 config.mak.in template had an "export" line to cause a few
 common makefile variables to be exported; if they need to be
 expoted for autoconf/configure users, they should also be exported
 for people who write config.mak the same way.  Move the "export" to
 the main Makefile.  Also, stop exporting mandir that used to be
 exported (only) when config.mak.autogen was used.  It would have
 broken installation of manpages (but not other documentation
 formats).

 Even though I think this change is correct, please report
 immediately if you find any unintended side effect.

 Will merge to 'master' in the 4th batch (Risky).


* jc/remove-treesame-parent-in-simplify-merges (2013-01-17) 1 commit
 - simplify-merges: drop merge from irrelevant side branch

 Originally merged to 'next' on 2013-01-30

 The --simplify-merges logic did not cull irrelevant parents from a
 merge that is otherwise not interesting with respect to the paths
 we are following.

 This touches a fairly core part of the revision traversal
 infrastructure; even though I think this change is correct, please
 report immediately if you find any unintended side effect.

 Will merge to 'master' in the 2nd batch (Risky).


* jc/push-2.0-default-to-simple (2013-03-18) 15 commits
 - advice: Remove unused advice_push_non_ff_default
 - t5570: do not assume the "matching" push is the default
 - t5551: do not assume the "matching" push is the default
 - t5550: do not assume the "matching" push is the default
 - doc: push.default is no longer "matching"
 - push: switch default from "matching" to "simple"
 - t9401: do not assume the "matching" push is the default
 - t9400: do not assume the "matching" push is the default
 - t7406: do not assume the "matching" push is the default
 - t5531: do not assume the "matching" push is the default
 - t5519: do not assume the "matching" push is the default
 - t5517: do not assume the "matching" push is the default
 - t5516: do not assume the "matching" push is the default
 - t5505: do not assume the "matching" push is the default
 - t5404: do not assume the "matching" push is the default

 Originally merged to 'next' on 2013-03-18

 Will cook in 'next' until Git 2.0.


* bc/append-signed-off-by (2013-02-23) 13 commits
 - git-commit: populate the edit buffer with 2 blank lines before s-o-b
 - Unify appending signoff in format-patch, commit and sequencer
 - format-patch: update append_signoff prototype
 - t4014: more tests about appending s-o-b lines
 - sequencer.c: teach append_signoff to avoid adding a duplicate newline
 - sequencer.c: teach append_signoff how to detect duplicate s-o-b
 - sequencer.c: always separate "(cherry picked from" from commit body
 - sequencer.c: require a conforming footer to be preceded by a blank line
 - sequencer.c: recognize "(cherry picked from ..." as part of s-o-b footer
 - t/t3511: add some tests of 'cherry-pick -s' functionality
 - t/test-lib-functions.sh: allow to specify the tag name to test_commit
 - commit, cherry-pick -s: remove broken support for multiline rfc2822 fields
 - sequencer.c: rework search for start of footer to improve clarity

 Originally merged to 'next' on 2013-02-25

 Consolidates codepaths that inspect log-message-to-be and decide to
 add a new Signed-off-by line in various commands.  I think there is
 no negative behaviour change in this series, but please report any
 iffy behaviour change immediately if you notice one.

 Will merge to 'master' in the 3rd batch (Risky).

--------------------------------------------------
[Discarded]

* nd/read-directory-recursive-optim (2013-02-17) 1 commit
 . read_directory: avoid invoking exclude machinery on tracked files

 "git status" has been optimized by taking advantage of the fact
 that paths that are already known to the index do not have to be
 checked against the .gitignore mechanism under some conditions.
 Even though I think this change is correct, please report
 immediately if you find any unintended side effect.

 kb/status-ignored-optim may supersede this.


* jc/add-2.0-u-A-sans-pathspec (2013-03-14) 1 commit
 . git add: -u/-A now affects the entire working tree

 Originally merged to 'next' on 2013-03-14

 "git add -u/-A" without pathspec has traditonally limited its
 operation to the current directory and its subdirectories, but in
 Git 1.8.2 we started encouraging users to be more explicit to
 specify "." when they mean it (and use ":/" to make it affect the
 entire working tree).  With this, we finally change the behaviour
 and make it affect the entire working tree in Git 2.0.
