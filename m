Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B21C20899
	for <e@80x24.org>; Sat, 12 Aug 2017 00:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751770AbdHLAyO (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 20:54:14 -0400
Received: from pb-sasl-trial3.pobox.com ([64.147.108.87]:61575 "EHLO
        pb-sasl-trial3.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbdHLAyL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 20:54:11 -0400
Received: from pb-sasl-trial3.pobox.com (ro.sql.listbox.com [127.0.0.1])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id 56B811A17A;
        Fri, 11 Aug 2017 20:54:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=q
        aiNqObIziXc0F94hMG8a5d3bEw=; b=fjTKkX5Htgg8X52GNKbZHs6KW9IKcyeqC
        OSmOf49emduawGJbNrL0a1BXTSc9jIYTwS7qkxyvArKTKXUYuebUwInL6dDhfs9k
        jeWWENcSTtOvoCwLcrlE6ocTstbCrwohewT2Tvnp6ko1yPpm0jgdGvM5zVcuEYwg
        bo8z3sacck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=r1s
        4hj0VbhjXlmMGilZdAfx2Rphr0iAT+scTeOqPl5p+JEliP/yEvkZ39V45GlbzZ8P
        zyW3DeYNHwHSlutNCU1eWZ8DObfVj0adkHMzYjWm01J7XyrgxTJuOY+nnySptfBF
        DORzL6MvV1t/93qmnSnwHhQWatInKaCo/MQbGbMQ=
Received: from pb-smtp1.nyi.icgroup.com (pb-smtp1.pobox.com [10.90.30.53])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id 3EDA61A179;
        Fri, 11 Aug 2017 20:54:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4BF459B487;
        Fri, 11 Aug 2017 20:54:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Aug 2017, #02; Fri, 11)
X-master-at: b3622a4ee94e4916cd05e6d96e41eeb36b941182
X-next-at: b18f417b8938ccf4d9dfc9a6ecca90dcaa2868f7
Date:   Fri, 11 Aug 2017 17:54:07 -0700
Message-ID: <xmqq7ey9y5ao.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF427FBE-7EF8-11E7-972A-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The first batch of 32 topics (not counting the v2.14.1 update which
was a security fix), which are the ones that have been cooking in
'next' during the pre-release freeze period, have now been merged to
'master'.  I have not really started pickng up new topics posted to
the list yet and yet to rewind and rebuild the 'next' branch to
start a new cycle.  Hopefully it can happen early next week.

The top part of the draft release notes for the next cycle, which I
tentatively called Git 2.15, declares that "git add ''" will still
be supported up to this release but will become illegal after that.
Given that a typical release cycle is 8-12 weeks, that will happen
sometime early next year.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ah/doc-wserrorhighlight (2017-07-25) 1 commit
  (merged to 'next' on 2017-07-27 at cd1bb28d95)
 + doc: add missing values "none" and "default" for diff.wsErrorHighlight

 Doc update.


* bc/object-id (2017-07-17) 12 commits
  (merged to 'next' on 2017-07-18 at fd161056e4)
 + sha1_name: convert uses of 40 to GIT_SHA1_HEXSZ
 + sha1_name: convert GET_SHA1* flags to GET_OID*
 + sha1_name: convert get_sha1* to get_oid*
 + Convert remaining callers of get_sha1 to get_oid.
 + builtin/unpack-file: convert to struct object_id
 + bisect: convert bisect_checkout to struct object_id
 + builtin/update_ref: convert to struct object_id
 + sequencer: convert to struct object_id
 + remote: convert struct push_cas to struct object_id
 + submodule: convert submodule config lookup to use object_id
 + builtin/merge-tree: convert remaining caller of get_sha1 to object_id
 + builtin/fsck: convert remaining caller of get_sha1 to object_id
 (this branch is used by bw/submodule-config-cleanup; uses sb/object-id.)

 Conversion from uchar[20] to struct object_id continues.


* bw/object-id (2017-07-17) 3 commits
  (merged to 'next' on 2017-07-18 at 90d27c0e7c)
 + receive-pack: don't access hash of NULL object_id pointer
 + notes: don't access hash of NULL object_id pointer
 + tree-diff: don't access hash of NULL object_id pointer

 Conversion from uchar[20] to struct object_id continues.


* cc/ref-is-hidden-microcleanup (2017-07-24) 1 commit
  (merged to 'next' on 2017-07-27 at 37af544e1c)
 + refs: use skip_prefix() in ref_is_hidden()

 Code cleanup.


* dc/fmt-merge-msg-microcleanup (2017-07-25) 1 commit
  (merged to 'next' on 2017-07-27 at 6df06eb788)
 + fmt-merge-msg: fix coding style

 Code cleanup.


* dl/credential-cache-socket-in-xdg-cache (2017-07-27) 1 commit
  (merged to 'next' on 2017-08-01 at 87687ae1d4)
 + credential-cache: interpret an ECONNRESET as an EOF

 A recently added test for the "credential-cache" helper revealed
 that EOF detection done around the time the connection to the cache
 daemon is torn down were flaky.  This was fixed by reacting to
 ECONNRESET and behaving as if we got an EOF.


* eb/contacts-reported-by (2017-07-27) 1 commit
  (merged to 'next' on 2017-08-01 at cca9972d6b)
 + git-contacts: also recognise "Reported-by:"

 "git contacts" (in contrib/) now lists the address on the
 "Reported-by:" trailer to its output, in addition to those on
 S-o-b: and other trailers, to make it easier to notify (and thank)
 the original bug reporter.


* hb/gitweb-project-list (2017-07-18) 1 commit
  (merged to 'next' on 2017-07-27 at c25d65ca25)
 + gitweb: skip unreadable subdirectories

 When a directory is not readable, "gitweb" fails to build the
 project list.  Work this around by skipping such a directory.

 It might end up hiding a problem under the rug and a better
 solution might be to loudly complain to the administrator pointing
 out the problematic directory, but this will at least make it
 "work".


* jb/t8008-cleanup (2017-07-26) 1 commit
  (merged to 'next' on 2017-08-01 at f979c9340d)
 + t8008: rely on rev-parse'd HEAD instead of sha1 value

 Code clean-up.


* jc/http-sslkey-and-ssl-cert-are-paths (2017-07-20) 1 commit
  (merged to 'next' on 2017-07-20 at 5489304b99)
 + http.c: http.sslcert and http.sslkey are both pathnames

 The http.{sslkey,sslCert} configuration variables are to be
 interpreted as a pathname that honors "~[username]/" prefix, but
 weren't, which has been fixed.


* jk/c99 (2017-07-18) 2 commits
  (merged to 'next' on 2017-07-18 at 1cfc30f7c1)
 + clean.c: use designated initializer
 + strbuf: use designated initializers in STRBUF_INIT

 Start using selected c99 constructs in small, stable and
 essentialpart of the system to catch people who care about
 older compilers that do not grok them.


* jk/ref-filter-colors (2017-07-13) 15 commits
  (merged to 'next' on 2017-07-18 at 75d4eb7ecf)
 + ref-filter: consult want_color() before emitting colors
 + pretty: respect color settings for %C placeholders
 + rev-list: pass diffopt->use_colors through to pretty-print
 + for-each-ref: load config earlier
 + color: check color.ui in git_default_config()
 + ref-filter: pass ref_format struct to atom parsers
 + ref-filter: factor out the parsing of sorting atoms
 + ref-filter: make parse_ref_filter_atom a private function
 + ref-filter: provide a function for parsing sort options
 + ref-filter: move need_color_reset_at_eol into ref_format
 + ref-filter: abstract ref format into its own struct
 + ref-filter: simplify automatic color reset
 + t: use test_decode_color rather than literal ANSI codes
 + docs/for-each-ref: update pointer to color syntax
 + check return value of verify_ref_format()

 "%C(color name)" in the pretty print format always produced ANSI
 color escape codes, which was an early design mistake.  They now
 honor the configuration (e.g. "color.ui = never") and also tty-ness
 of the output medium.


* jk/reflog-walk (2017-07-09) 9 commits
  (merged to 'next' on 2017-07-09 at 7449e964c6)
 + reflog-walk: apply --since/--until to reflog dates
 + reflog-walk: stop using fake parents
 + rev-list: check reflog_info before showing usage
 + get_revision_1(): replace do-while with an early return
 + log: do not free parents when walking reflog
 + log: clarify comment about reflog cycles
 + revision: disallow reflog walking with revs->limited
 + t1414: document some reflog-walk oddities
 + Merge branch 'jk/reflog-walk-maint' into jk/reflog-walk

 Numerous bugs in walking of reflogs via "log -g" and friends have
 been fixed.


* jk/rev-list-empty-input (2017-08-02) 4 commits
  (merged to 'next' on 2017-08-04 at cb4f9b84e0)
 + revision: do not fallback to default when rev_input_given is set
 + rev-list: don't show usage when we see empty ref patterns
 + revision: add rev_input_given flag
 + t6018: flesh out empty input/output rev-list tests

 "git log --tag=no-such-tag" showed log starting from HEAD, which
 has been fixed---it now shows nothing.


* js/git-gui-msgfmt-on-windows (2017-07-25) 7 commits
  (merged to 'next' on 2017-08-01 at 219577a73e)
 + Merge branch 'js/msgfmt-on-windows' of ../git-gui into js/git-gui-msgfmt-on-windows
 + git-gui (MinGW): make use of MSys2's msgfmt
 + Merge remote-tracking branch 'philoakley/dup-gui'
 + git gui: allow for a long recentrepo list
 + git gui: de-dup selected repo from recentrepo history
 + git gui: cope with duplicates in _get_recentrepo
 + git-gui: remove duplicate entries from .gitconfig's gui.recentrepo

 Because recent Git for Windows do come with a real msgfmt, the
 build procedure for git-gui has been updated to use it instead of a
 hand-rolled substitute.


* js/run-process-parallel-api-fix (2017-07-21) 1 commit
  (merged to 'next' on 2017-07-27 at 4b54b69172)
 + run_processes_parallel: change confusing task_cb convention

 API fix.


* jt/fsck-code-cleanup (2017-07-26) 3 commits
  (merged to 'next' on 2017-07-26 at 7a17e279da)
 + fsck: cleanup unused variable
  (merged to 'next' on 2017-07-20 at f7045a8c47)
 + object: remove "used" field from struct object
 + fsck: remove redundant parse_tree() invocation

 Code clean-up.


* jt/subprocess-handshake (2017-07-26) 3 commits
  (merged to 'next' on 2017-08-01 at a0f78deffd)
 + sub-process: refactor handshake to common function
 + Documentation: migrate sub-process docs to header
 + Merge branch 'ls/filter-process-delayed' into jt/subprocess-handshake
 (this branch uses ls/filter-process-delayed.)

 Code cleanup.


* jt/t1450-fsck-corrupt-packfile (2017-07-28) 1 commit
  (merged to 'next' on 2017-08-04 at 44d09da2fc)
 + tests: ensure fsck fails on corrupt packfiles

 A test update.


* ks/commit-abort-on-empty-message-fix (2017-07-17) 1 commit
  (merged to 'next' on 2017-07-27 at e81ad4c1dc)
 + commit: check for empty message before the check for untouched template

 "git commit" when seeing an totally empty message said "you did not
 edit the message", which is clearly wrong.  The message has been
 corrected.


* ks/prepare-commit-msg-sample (2017-07-12) 4 commits
  (merged to 'next' on 2017-07-18 at 48d9650a30)
 + hook: add a simple first example
 + hook: add sign-off using "interpret-trailers"
 + hook: name the positional variables
 + hook: cleanup script

 Remove an example that is now obsolete from a sample hook,
 and improve an old example in it that added a sign-off manually
 to use the interpret-trailers command.


* ls/filter-process-delayed (2017-06-30) 7 commits
  (merged to 'next' on 2017-07-05 at a35e644082)
 + convert: add "status=delayed" to filter process protocol
 + convert: refactor capabilities negotiation
 + convert: move multiple file filter error handling to separate function
 + convert: put the flags field before the flag itself for consistent style
 + t0021: write "OUT <size>" only on success
 + t0021: make debug log file name configurable
 + t0021: keep filter log files on comparison
 (this branch is used by jt/subprocess-handshake.)

 The filter-process interface learned to allow a process with long
 latency give a "delayed" response.


* ma/pager-per-subcommand-action (2017-08-03) 7 commits
  (merged to 'next' on 2017-08-04 at 0f760bcf5d)
 + git.c: ignore pager.* when launching builtin as dashed external
 + tag: change default of `pager.tag` to "on"
 + tag: respect `pager.tag` in list-mode only
 + t7006: add tests for how git tag paginates
 + git.c: provide setup_auto_pager()
 + git.c: let builtins opt for handling `pager.foo` themselves
 + builtin.h: take over documentation from api-builtin.txt

 The "tag.pager" configuration variable was useless for those who
 actually create tag objects, as it interfered with the use of an
 editor.  A new mechanism has been introduced for commands to enable
 pager depending on what operation is being carried out to fix this,
 and then "git tag -l" is made to run pager by default.

 If this works out OK, I think there are low-hanging fruits in
 other commands like "git branch" that outputs long list in one mode
 while taking input in another.


* rg/rerere-train-overwrite (2017-07-26) 1 commit
  (merged to 'next' on 2017-08-01 at 7fcd42974c)
 + contrib/rerere-train: optionally overwrite existing resolutions

 The "rerere-train" script (in contrib/) learned the "--overwrite"
 option to allow overwriting existing recorded resolutions.


* rs/bswap-ubsan-fix (2017-07-17) 2 commits
  (merged to 'next' on 2017-07-20 at ce6bad07b0)
 + bswap: convert get_be16, get_be32 and put_be32 to inline functions
 + bswap: convert to unsigned before shifting in get_be32

 Code clean-up.


* rs/move-array (2017-07-17) 4 commits
  (merged to 'next' on 2017-07-20 at f3086cd20e)
 + ls-files: don't try to prune an empty index
 + apply: use COPY_ARRAY and MOVE_ARRAY in update_image()
 + use MOVE_ARRAY
 + add MOVE_ARRAY

 Code clean-up.


* rs/pack-objects-pbase-cleanup (2017-07-20) 1 commit
  (merged to 'next' on 2017-07-20 at a6b618559b)
 + pack-objects: remove unnecessary NULL check

 Code clean-up.


* rs/stat-data-unaligned-reads-fix (2017-07-17) 1 commit
  (merged to 'next' on 2017-07-20 at e7d3782823)
 + dir: support platforms that require aligned reads

 Code clean-up.


* sb/hashmap-cleanup (2017-07-05) 10 commits
  (merged to 'next' on 2017-07-12 at ce31d06165)
 + t/helper/test-hashmap: use custom data instead of duplicate cmp functions
 + name-hash.c: drop hashmap_cmp_fn cast
 + submodule-config.c: drop hashmap_cmp_fn cast
 + remote.c: drop hashmap_cmp_fn cast
 + patch-ids.c: drop hashmap_cmp_fn cast
 + convert/sub-process: drop cast to hashmap_cmp_fn
 + config.c: drop hashmap_cmp_fn cast
 + builtin/describe: drop hashmap_cmp_fn cast
 + builtin/difftool.c: drop hashmap_cmp_fn cast
 + attr.c: drop hashmap_cmp_fn cast

 Many uses of comparision callback function the hashmap API uses
 cast the callback function type when registering it to
 hashmap_init(), which defeats the compile time type checking when
 the callback interface changes (e.g. gaining more parameters).
 The callback implementations have been updated to take "void *"
 pointers and cast them to the type they expect instead.


* sb/object-id (2017-07-13) 2 commits
  (merged to 'next' on 2017-07-18 at e4df0ba3b1)
 + tag: convert gpg_verify_tag to use struct object_id
 + commit: convert lookup_commit_graft to struct object_id
 (this branch is used by bc/object-id and bw/submodule-config-cleanup.)

 Conversion from uchar[20] to struct object_id continues.


* st/lib-gpg-kill-stray-agent (2017-07-20) 1 commit
  (merged to 'next' on 2017-07-20 at 8ea68c483f)
 + t: lib-gpg: flush gpg agent on startup

 Some versions of GnuPG fails to kill gpg-agent it auto-spawned
 and such a left-over agent can interfere with a test.  Work it
 around by attempting to kill one before starting a new test.


* wd/rebase-conflict-guide (2017-07-17) 1 commit
  (merged to 'next' on 2017-07-20 at c78e758b23)
 + rebase: make resolve message clearer for inexperienced users

 The advice message given when "git rebase" stops for conflicting
 changes has been improved.

--------------------------------------------------
[New Topics]

* ab/ref-filter-no-contains (2017-08-07) 1 commit
 - tests: don't give unportable ">" to "test" built-in, use -gt

 A test fix.

 Will merge to 'next'.


* ma/parse-maybe-bool (2017-08-07) 6 commits
 - parse_decoration_style: drop unused argument `var`
 - treewide: deprecate git_config_maybe_bool, use git_parse_maybe_bool
 - config: make git_{config,parse}_maybe_bool equivalent
 - config: introduce git_parse_maybe_bool_text
 - t5334: document that git push --signed=1 does not work
 - Doc/git-{push,send-pack}: correct --sign= to --signed=

 Code clean-up.

 Will merge to 'next'.


* mf/no-dashed-subcommands (2017-08-07) 1 commit
 - scripts: use "git foo" not "git-foo"

 Code clean-up.

 Will merge to 'next'.


* mk/diff-delta-uint-may-be-shorter-than-ulong (2017-08-10) 1 commit
 - diff-delta: fix encoding size that would not fit in "unsigned int"

 The machinery to create xdelta used in pack files received the
 sizes of the data in size_t, but lost the higher bits of them by
 storing them in "unsigned int" during the computation, which is
 fixed.

 Will merge to 'next'.


* rs/freebsd-getcwd-workaround (2017-08-07) 1 commit
 - t0001: skip test with restrictive permissions if getpwd(3) respects them

 Test portability fix for BSDs.

 Will merge to 'next'.


* rs/in-obsd-basename-dirname-take-const (2017-08-07) 1 commit
 - test-path-utils: handle const parameter of basename and dirname

 Portability fix.

 Will merge to 'next'.


* rs/t3700-clean-leftover (2017-08-08) 1 commit
 - t3700: fix broken test under !POSIXPERM

 A test fix.

 Will merge to 'next'.


* jc/perl-git-comment-typofix (2017-08-07) 1 commit
 - perl/Git.pm: typofix in a comment

 A comment fix.

 Will merge to 'next'.


* jk/drop-ancient-curl (2017-08-09) 5 commits
 . http: #error on too-old curl
 . curl: remove ifdef'd code never used with curl >=7.19.4
 . http: drop support for curl < 7.19.4
 . http: drop support for curl < 7.16.0
 . http: drop support for curl < 7.11.1


* jk/drop-sha1-entry-pos (2017-08-09) 1 commit
 - sha1_file: drop experimental GIT_USE_LOOKUP search

 Code clean-up.

 Will merge to 'next'.


* jk/hashcmp-memcmp (2017-08-09) 1 commit
 - hashcmp: use memcmp instead of open-coded loop

 Code clean-up.

 Will merge to 'next'.


* jk/trailers-parse (2017-08-10) 5 commits
 - interpret-trailers: add --parse convenience option
 - interpret-trailers: add an option to normalize output
 - interpret-trailers: add an option to show only existing trailers
 - interpret-trailers: add an option to show only the trailers
 - trailer: put process_trailers() options into a struct


* mk/use-size-t-in-zlib (2017-08-10) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

 Will merge to 'next'.


* pw/am-signoff (2017-08-08) 1 commit
 - am: fix signoff when other trailers are present

 "git am -s" has been taught that some input may end with a trailer
 block that is not Signed-off-by: and it should refrain from adding
 an extra blank line before adding a new sign-off in such a case.

 Will merge to 'next'.


* rj/add-chmod-error-message (2017-08-09) 1 commit
 - builtin/add: add detail to a 'cannot chmod' error message

 Message fix.

 Will merge to 'next'.


* rs/apply-lose-prefix-length (2017-08-09) 1 commit
 - apply: remove prefix_length member from apply_state

 Code clean-up.

 Will merge to 'next'.


* rs/find-pack-entry-bisection (2017-08-09) 1 commit
 - sha1_file: avoid comparison if no packed hash matches the first byte

 Code clean-up.

 Will merge to 'next'.


* rs/fsck-obj-leakfix (2017-08-10) 1 commit
 - fsck: free buffers on error in fsck_obj()

 Memory leak in an error codepath has been plugged.

 Will merge to 'next'.


* rs/merge-microcleanup (2017-08-10) 1 commit
 - merge: use skip_prefix()

 Code clean-up.

 Will merge to 'next'.


* rs/strbuf-getwholeline-fix (2017-08-10) 1 commit
 - strbuf: clear errno before calling getdelim(3)

 A helper function to read a single whole line into strbuf
 mistakenly triggered OOM error at EOF under certain conditions,
 which has been fixed.

 Will merge to 'next'.


* rs/t4062-obsd (2017-08-09) 1 commit
 - t4062: use less than 256 repetitions in regex

 Test portability fix.

 Will merge to 'next'.


* rs/unpack-entry-leakfix (2017-08-10) 1 commit
 - sha1_file: release delta_stack on error in unpack_entry()

 Memory leak in an error codepath has been plugged.

 Will merge to 'next'.


* rs/win32-syslog-leakfix (2017-08-10) 1 commit
 - win32: plug memory leak on realloc() failure in syslog()

 Memory leak in an error codepath has been plugged.

 Will merge to 'next'.


* sb/retire-t1200 (2017-08-10) 1 commit
 - t1200: remove t1200-tutorial.sh

 A test script that outlived its usefulness has been removed.

 Will merge to 'next'.


* ur/svn-local-zone (2017-08-08) 1 commit
 - git svn fetch: Create correct commit timestamp when using --localtime

 "git svn" used with "--localtime" option did not compute the tz
 offset for the timestamp in question and instead always used the
 current time, which has been corrected.

 Will merge to 'next'.


* jt/sha1-file-cleanup (2017-08-11) 2 commits
 - sha1_file: remove read_packed_sha1()
 - sha1_file: set whence in storage-specific info fn

 Preparatory code clean-up.

 Will merge to 'next'.


* kw/rebase-progress (2017-08-11) 2 commits
 - rebase: turn on progress option by default for format-patch
 - format-patch: have progress option while generating patches

 "git rebase", especially when it is run by mistake and ends up
 trying to replay many changes, spent long time in silence.  The
 command has been taught to show progress report when it spends
 long time preparing these many changes to replay (which would give
 the user a chance to abort with ^C).

 Waiting for a response.
 cf. <20170810232033.46ujnozvnodkguog@sigill.intra.peff.net>
 cf. <xmqqshgxycal.fsf@gitster.mtv.corp.google.com>


* mk/diff-delta-avoid-large-offset (2017-08-11) 1 commit
 - diff-delta: do not allow delta offset truncation

 The delta format used in the packfile cannot reference data at
 offset larger than what can be expressed in 4-byte, but the
 generator for the data failed to make sure the offset does not
 overflow.  This has been corrected.

 Will merge to 'next'.


* nm/stash-untracked (2017-08-11) 1 commit
 - stash: clean untracked files before reset

 "git stash -u" used the contents of the committed version of the
 ".gitignore" file to decide which paths are ignored, even when the
 file has local changes.  The command has been taught to instead use
 the locally modified contents.

 Will merge to 'next'.


* tc/curl-with-backports (2017-08-11) 2 commits
 - http: use a feature check to enable GSSAPI delegation control
 - http: fix handling of missing CURLPROTO_*

 Updates to the HTTP layer we made recently unconditionally used
 features of libCurl without checking the existence of them, causing
 compilation errors, which has been fixed.  Also migrate the code to
 check feature macros, not version numbers, to cope better with
 libCurl that vendor ships with backported features.

--------------------------------------------------
[Stalled]

* mg/status-in-progress-info (2017-05-10) 2 commits
 - status --short --inprogress: spell it as --in-progress
 - status: show in-progress info for short status

 "git status" learns an option to report various operations
 (e.g. "merging") that the user is in the middle of.

 cf. <xmqqmvakcdqw.fsf@gitster.mtv.corp.google.com>


* nd/worktree-move (2017-04-20) 6 commits
 - worktree remove: new command
 - worktree move: refuse to move worktrees with submodules
 - worktree move: accept destination as directory
 - worktree move: new command
 - worktree.c: add update_worktree_location()
 - worktree.c: add validate_worktree()

 "git worktree" learned move and remove subcommands.

 Expecting a reroll.
 cf. <20170420101024.7593-1-pclouds@gmail.com>
 cf. <20170421145916.mknekgqzhxffu7di@sigill.intra.peff.net>
 cf. <d0e81b1e-5869-299e-f462-4d43dc997bd1@ramsayjones.plus.com>


* sg/clone-refspec-from-command-line-config (2017-06-16) 2 commits
 - Documentation/clone: document ignored configuration variables
 - clone: respect additional configured fetch refspecs during initial fetch
 (this branch is used by sg/remote-no-string-refspecs.)

 "git clone -c var=val" is a way to set configuration variables in
 the resulting repository, but it is more useful to also make these
 variables take effect while the initial clone is happening,
 e.g. these configuration variables could be fetch refspecs.

 Waiting for a response.
 cf. <20170617112228.vugswym4o4owf6wj@sigill.intra.peff.net>
 cf. <xmqqmv8zhdap.fsf@gitster.mtv.corp.google.com>


* js/rebase-i-final (2017-07-27) 10 commits
 - rebase -i: rearrange fixup/squash lines using the rebase--helper
 - t3415: test fixup with wrapped oneline
 - rebase -i: skip unnecessary picks using the rebase--helper
 - rebase -i: check for missing commits in the rebase--helper
 - t3404: relax rebase.missingCommitsCheck tests
 - rebase -i: also expand/collapse the SHA-1s via the rebase--helper
 - rebase -i: do not invent onelines when expanding/collapsing SHA-1s
 - rebase -i: remove useless indentation
 - rebase -i: generate the script via rebase--helper
 - t3415: verify that an empty instructionFormat is handled as before

 The final batch to "git rebase -i" updates to move more code from
 the shell script to C.

 Expecting a reroll.


* bp/fsmonitor (2017-06-12) 6 commits
 - fsmonitor: add a sample query-fsmonitor hook script for Watchman
 - fsmonitor: add documentation for the fsmonitor extension.
 - fsmonitor: add test cases for fsmonitor extension
 - fsmonitor: teach git to optionally utilize a file system monitor to speed up detecting new or changed files.
 - dir: make lookup_untracked() available outside of dir.c
 - bswap: add 64 bit endianness helper get_be64

 We learned to talk to watchman to speed up "git status".

 Expecting a reroll.
 cf. <bade1166-e646-b05a-f65b-adb8da8ba0a7@gmail.com>

--------------------------------------------------
[Cooking]

* pw/sequence-rerere-autoupdate (2017-08-02) 6 commits
  (merged to 'next' on 2017-08-11 at cd2d165be2)
 + cherry-pick/revert: reject --rerere-autoupdate when continuing
 + cherry-pick/revert: remember --rerere-autoupdate
 + t3504: use test_commit
 + rebase -i: honor --rerere-autoupdate
 + rebase: honor --rerere-autoupdate
 + am: remember --rerere-autoupdate setting

 Commands like "git rebase" accepted the --rerere-autoupdate option
 from the command line, but did not always use it.  This has been
 fixed.

 Will merge to 'master'.


* bw/clone-recursive-quiet (2017-08-04) 1 commit
  (merged to 'next' on 2017-08-11 at f49ac463f7)
 + clone: teach recursive clones to respect -q

 "git clone --recurse-submodules --quiet" did not pass the quiet
 option down to submodules.

 Will merge to 'master'.


* lg/merge-signoff (2017-07-25) 1 commit
 - merge: add a --signoff flag

 "git merge" learned a "--signoff" option to add the Signed-off-by:
 trailer with the committer's name.


* pb/trailers-from-command-line (2017-07-25) 4 commits
 - SQUASH???
 - interpret-trailers: add options for actions
 - trailers: introduce struct new_trailer_item
 - trailers: export action enums and corresponding lookup functions

 "git interpret-trailers" learned to take the trailer specifications
 from the command line that overrides the configured values.

 Expecting a reroll for compilation fix.


* sb/submodule-recursive-checkout-detach-head (2017-07-28) 2 commits
 - Documentation/checkout: clarify submodule HEADs to be detached
 - recursive submodules: detach HEAD from new state

 "git checkout --recursive" may overwrite and rewind the history of
 the branch that happens to be checked out in submodule
 repositories, which might not be desirable.  Detach the HEAD but
 still allow the recursive checkout to succeed in such a case.

 Undecided.
 This needs justification in a larger picture; it is unclear why
 this is better than rejecting recursive checkout, for example.


* ti/external-sha1dc (2017-07-25) 1 commit
  (merged to 'next' on 2017-07-27 at d1ce394fe2)
 + hash: allow building with the external sha1dc library

 Platforms that ship with a separate sha1 with collision detection
 library can link to it instead of using the copy we ship as part of
 our source tree.

 Waiting for review to conclude
 cf. <CACBZZX7M=H8tNkZXpHBvv0rbY58EJk4dkoUzGKMftWoKUqF8sA@mail.gmail.com>


* bw/submodule-config-cleanup (2017-08-03) 17 commits
 - submodule: remove gitmodules_config
 - unpack-trees: improve loading of .gitmodules
 - submodule-config: lazy-load a repository's .gitmodules file
 - submodule-config: move submodule-config functions to submodule-config.c
 - submodule-config: remove support for overlaying repository config
 - diff: stop allowing diff to have submodules configured in .git/config
 - submodule: remove submodule_config callback routine
 - unpack-trees: don't respect submodule.update
 - submodule: don't rely on overlayed config when setting diffopts
 - fetch: don't overlay config with submodule-config
 - submodule--helper: don't overlay config in update-clone
 - submodule--helper: don't overlay config in remote_submodule_branch
 - add, reset: ensure submodules can be added or reset
 - submodule: don't use submodule_from_name
 - t7411: check configuration parsing errors
 - Merge branch 'bc/object-id' into bw/submodule-config-cleanup
 - Merge branch 'bw/grep-recurse-submodules' into bw/submodule-config-cleanup
 (this branch uses bw/grep-recurse-submodules.)

 Code clean-up to avoid mixing values read from the .gitmodules file
 and values read from the .git/config file.


* bw/push-options-recursively-to-submodules (2017-07-20) 1 commit
  (merged to 'next' on 2017-07-27 at 26b3af2544)
 + submodule--helper: teach push-check to handle HEAD

 "git push --recurse-submodules $there HEAD:$target" was not
 propagated down to the submodules, but now it is.

 Will merge to 'master'.


* jk/check-ref-format-oor-fix (2017-07-14) 1 commit
 - check-ref-format: require a repository for --branch

 Objected...
 cf. <20170717172709.GL93855@aiede.mtv.corp.google.com>


* bw/grep-recurse-submodules (2017-08-02) 10 commits
  (merged to 'next' on 2017-08-04 at 4e60c34bad)
 + grep: recurse in-process using 'struct repository'
 + submodule: merge repo_read_gitmodules and gitmodules_config
 + submodule: check for unmerged .gitmodules outside of config parsing
 + submodule: check for unstaged .gitmodules outside of config parsing
 + submodule: remove fetch.recursesubmodules from submodule-config parsing
 + submodule: remove submodule.fetchjobs from submodule-config parsing
 + config: add config_from_gitmodules
 + cache.h: add GITMODULES_FILE macro
 + repository: have the_repository use the_index
 + repo_read_index: don't discard the index
 (this branch is used by bw/submodule-config-cleanup.)

 "git grep --recurse-submodules" has been reworked to give a more
 consistent output across submodule boundary (and do its thing
 without having to fork a separate process).

 Will merge to 'master'.


* rs/sha1-file-micro-optim (2017-07-09) 2 commits
 - SQUASH???
 - sha1_file: add slash once in for_each_file_in_obj_subdir()

 Code cleanup.

 Perhaps drop.
 cf. <f59c8256-716b-9305-2a4f-d4fe49f666ff@web.de>


* jc/allow-lazy-cas (2017-07-06) 1 commit
 - push: disable lazy --force-with-lease by default

 Because "git push --force-with-lease[=<ref>]" that relies on the
 stability of remote-tracking branches is unsafe when something
 fetches into the repository behind user's back, it is now disabled
 by default.  A new configuration variable can be used to enable it
 by users who know what they are doing.  This would pave the way to
 possibly turn `--force` into `--force-with-lease`.

 Undecided.
 Independent from disabling the feature by default, this stirred up
 a discussion to replace the DWIM heuristics with a better one, which
 deserves to be its own topic.
 cf. <alpine.DEB.2.21.1.1707131435220.4193@virtualbox>


* ex/deprecate-empty-pathspec-as-match-all (2017-06-23) 2 commits
  (merged to 'next' on 2017-06-26 at d026281517)
 + pathspec: die on empty strings as pathspec
 + t0027: do not use an empty string as a pathspec element

 The final step to make an empty string as a pathspec element
 illegal.  We started this by first deprecating and warning a
 pathspec that has such an element in 2.11 (Nov 2016).

 Hopefully we can merge this down to the 'master' by the end of the
 year?  A deprecation warning period that is about 1 year does not
 sound too bad.

 Will cook in 'next'.


* mh/packed-ref-store (2017-07-27) 31 commits
  (merged to 'next' on 2017-07-27 at 857dcb8cba)
 + packed_ref_store: handle a packed-refs file that is a symlink
  (merged to 'next' on 2017-07-05 at 6c68c603cc)
 + read_packed_refs(): die if `packed-refs` contains bogus data
 + t3210: add some tests of bogus packed-refs file contents
 + repack_without_refs(): don't lock or unlock the packed refs
 + commit_packed_refs(): remove call to `packed_refs_unlock()`
 + clear_packed_ref_cache(): don't protest if the lock is held
 + packed_refs_unlock(), packed_refs_is_locked(): new functions
 + packed_refs_lock(): report errors via a `struct strbuf *err`
 + packed_refs_lock(): function renamed from lock_packed_refs()
 + commit_packed_refs(): use a staging file separate from the lockfile
 + commit_packed_refs(): report errors rather than dying
 + packed_ref_store: make class into a subclass of `ref_store`
 + packed-backend: new module for handling packed references
 + packed_read_raw_ref(): new function, replacing `resolve_packed_ref()`
 + packed_ref_store: support iteration
 + packed_peel_ref(): new function, extracted from `files_peel_ref()`
 + repack_without_refs(): take a `packed_ref_store *` parameter
 + get_packed_ref(): take a `packed_ref_store *` parameter
 + rollback_packed_refs(): take a `packed_ref_store *` parameter
 + commit_packed_refs(): take a `packed_ref_store *` parameter
 + lock_packed_refs(): take a `packed_ref_store *` parameter
 + add_packed_ref(): take a `packed_ref_store *` parameter
 + get_packed_refs(): take a `packed_ref_store *` parameter
 + get_packed_ref_cache(): take a `packed_ref_store *` parameter
 + validate_packed_ref_cache(): take a `packed_ref_store *` parameter
 + clear_packed_ref_cache(): take a `packed_ref_store *` parameter
 + packed_ref_store: move `packed_refs_lock` member here
 + packed_ref_store: move `packed_refs_path` here
 + packed_ref_store: new struct
 + add_packed_ref(): teach function to overwrite existing refs
 + t1408: add a test of stale packed refs covered by loose refs

 The "ref-store" code reorganization continues.

 Will merge to 'master'.


* sd/branch-copy (2017-06-18) 3 commits
  (merged to 'next' on 2017-07-18 at 5e3b9357ea)
 + branch: add a --copy (-c) option to go with --move (-m)
 + branch: add test for -m renaming multiple config sections
 + config: create a function to format section headers

 "git branch" learned "-c/-C" to create and switch to a new branch
 by copying an existing one.

 Will merge to 'master'.

 I personally do not think "branch --copy master backup" while on
 "master" that switches to "backup" is a good UI, and I *will* say
 "I told you so" when users complain after we merge this down to
 'master'.


* sb/diff-color-move (2017-06-30) 26 commits
  (merged to 'next' on 2017-07-06 at 758ed40e4f)
 + diff: document the new --color-moved setting
 + diff.c: add dimming to moved line detection
 + diff.c: color moved lines differently, plain mode
 + diff.c: color moved lines differently
 + diff.c: buffer all output if asked to
 + diff.c: emit_diff_symbol learns about DIFF_SYMBOL_SUMMARY
 + diff.c: emit_diff_symbol learns about DIFF_SYMBOL_STAT_SEP
 + diff.c: convert word diffing to use emit_diff_symbol
 + diff.c: convert show_stats to use emit_diff_symbol
 + diff.c: convert emit_binary_diff_body to use emit_diff_symbol
 + submodule.c: migrate diff output to use emit_diff_symbol
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_REWRITE_DIFF
 + diff.c: emit_diff_symbol learns about DIFF_SYMBOL_BINARY_FILES
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_HEADER
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_FILEPAIR_{PLUS, MINUS}
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_INCOMPLETE
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_WORDS[_PORCELAIN]
 + diff.c: migrate emit_line_checked to use emit_diff_symbol
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_NO_LF_EOF
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_FRAGINFO
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_MARKER
 + diff.c: introduce emit_diff_symbol
 + diff.c: factor out diff_flush_patch_all_file_pairs
 + diff.c: move line ending check into emit_hunk_header
 + diff.c: readability fix
 + Merge branch 'sb/hashmap-customize-comparison' into sb/diff-color-move

 "git diff" has been taught to optionally paint new lines that are
 the same as deleted lines elsewhere differently from genuinely new
 lines.

 Will merge to 'master'.

--------------------------------------------------
[Discarded]

* mh/packed-ref-store-prep-extra (2017-06-18) 1 commit
 . prefix_ref_iterator_advance(): relax the check of trim length

 Split out of mh/packed-ref-store-prep.


* nd/prune-in-worktree (2017-04-24) 12 commits
 . rev-list: expose and document --single-worktree
 . revision.c: --reflog add HEAD reflog from all worktrees
 . files-backend: make reflog iterator go through per-worktree reflog
 . revision.c: --all adds HEAD from all worktrees
 . refs: remove dead for_each_*_submodule()
 . revision.c: use refs_for_each*() instead of for_each_*_submodule()
 . refs: add refs_head_ref()
 . refs: move submodule slash stripping code to get_submodule_ref_store
 . refs.c: refactor get_submodule_ref_store(), share common free block
 . revision.c: --indexed-objects add objects from all worktrees
 . revision.c: refactor add_index_objects_to_pending()
 . revision.h: new flag in struct rev_info wrt. worktree-related refs

 "git gc" and friends when multiple worktrees are used off of a
 single repository did not consider the index and per-worktree refs
 of other worktrees as the root for reachability traversal, making
 objects that are in use only in other worktrees to be subject to
 garbage collection.
