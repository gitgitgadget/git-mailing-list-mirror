Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96AE92047F
	for <e@80x24.org>; Fri,  4 Aug 2017 16:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752873AbdHDQzm (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 12:55:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57608 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752262AbdHDQzk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 12:55:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3938A9E796;
        Fri,  4 Aug 2017 12:55:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=5
        rt2UI2SEEwVrl1gmkRzj3nVBvE=; b=kSCU8NyZRtUR2VE8ZNszUofW1IVMFljse
        9/NyMJ2La1oHAAh6UfW1avSXR36V3hiZluq48nVNns9Kr0EZOser0P7BlBfqw7gf
        ctwPvPbYWTRZKul6avOn8qo8l5BatK68yNh3jVkoycLOe3QKQEU8FKL8Yg2PVrLX
        cNLFucLrZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=ZXL
        3fGPp/twmsnYp6MSsn0IK5zvkVSzyOfng6TQRcbHZQ90R1ijuMAY3kr5Tn9QW6Xc
        etOT5x7OPxG7tyPpYEkf3eWQAeUxXWFn7pZNuOPiCyRfY8S9+CeCzq5w2VLNkA4o
        ZbX4Nb4aZgvGRo2excTxwBYdf4DK+l/8J4UmYNXs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 306599E795;
        Fri,  4 Aug 2017 12:55:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 633019E792;
        Fri,  4 Aug 2017 12:55:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Aug 2017, #01; Fri, 4)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
X-master-at: 4384e3cde2ce8ecd194202e171ae16333d241326
X-next-at: 98096fd7a85b93626db8757f944f2d8ffdf7e96a
Date:   Fri, 04 Aug 2017 09:55:38 -0700
Message-ID: <xmqqvam3tgqd.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE7D92BC-7935-11E7-BECE-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The 2.14-rc2 was a bit delayed for various reasons and then there
wasn't any last-minite regressions discovered and fixed during that
timeframe, so I just decided to skip the second release candidate
and go straight to tag the final, which was done a few minutes ago.

I expect that the tree to stay a bit quiet for a week until the first
maintenance release for 2.14 series is tagged, perhaps by the end of
the next week.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ah/patch-id-doc (2017-07-28) 1 commit
  (merged to 'next' on 2017-08-04 at 7808b7abd3)
 + doc: remove unsupported parameter from patch-id

 Docfix.


* as/diff-options-grammofix (2017-07-31) 1 commit
  (merged to 'next' on 2017-08-01 at bfc60e3ec5)
 + diff-options doc: grammar fix

 A grammofix.


* js/blame-lib (2017-07-24) 1 commit
  (merged to 'next' on 2017-07-26 at db0d081012)
 + blame: fix memory corruption scrambling revision name in error message

 A hotfix to a topic already in 'master'.

--------------------------------------------------
[New Topics]

* jk/rev-list-empty-input (2017-08-02) 4 commits
  (merged to 'next' on 2017-08-04 at cb4f9b84e0)
 + revision: do not fallback to default when rev_input_given is set
 + rev-list: don't show usage when we see empty ref patterns
 + revision: add rev_input_given flag
 + t6018: flesh out empty input/output rev-list tests

 "git log --tag=no-such-tag" showed log starting from HEAD, which
 has been fixed---it now shows nothing.

 Will cook in 'next'.


* jt/t1450-fsck-corrupt-packfile (2017-07-28) 1 commit
  (merged to 'next' on 2017-08-04 at 44d09da2fc)
 + tests: ensure fsck fails on corrupt packfiles

 A test update.

 Will cook in 'next'.


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

 Will cook in 'next'.

 If this works out OK, I think there are low-hanging fruits in
 other commands like "git branch" that outputs long list in one mode
 while taking input in another.


* pw/sequence-rerere-autoupdate (2017-08-02) 6 commits
 - cherry-pick/revert: reject --rerere-autoupdate when continuing
 - cherry-pick/revert: remember --rerere-autoupdate
 - t3504: use test_commit
 - rebase -i: honor --rerere-autoupdate
 - rebase: honor --rerere-autoupdate
 - am: remember --rerere-autoupdate setting

 Commands like "git rebase" accepted the --rerere-autoupdate option
 from the command line, but did not always use it.  This has been
 fixed.

 Will merge to and cook in 'next'.


* bw/clone-recursive-quiet (2017-08-04) 1 commit
 - clone: teach recursive clones to respect -q

 "git clone --recurse-submodules --quiet" did not pass the quiet
 option down to submodules.

 Will merge to and cook in 'next'.

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

* ah/doc-wserrorhighlight (2017-07-25) 1 commit
  (merged to 'next' on 2017-07-27 at cd1bb28d95)
 + doc: add missing values "none" and "default" for diff.wsErrorHighlight

 Doc update.

 Will cook in 'next'.


* dc/fmt-merge-msg-microcleanup (2017-07-25) 1 commit
  (merged to 'next' on 2017-07-27 at 6df06eb788)
 + fmt-merge-msg: fix coding style

 Code cleanup.

 Will cook in 'next'.


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

 Will cook in 'next'.
 As we haven't heard from Pat, let's advance the update to 'next'
 ourselves.


* jt/subprocess-handshake (2017-07-26) 3 commits
  (merged to 'next' on 2017-08-01 at a0f78deffd)
 + sub-process: refactor handshake to common function
 + Documentation: migrate sub-process docs to header
 + Merge branch 'ls/filter-process-delayed' into jt/subprocess-handshake
 (this branch uses ls/filter-process-delayed.)

 Code cleanup.

 Will cook in 'next'.


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
 (this branch uses bc/object-id, bw/grep-recurse-submodules and sb/object-id.)

 Code clean-up to avoid mixing values read from the .gitmodules file
 and values read from the .git/config file.


* jb/t8008-cleanup (2017-07-26) 1 commit
  (merged to 'next' on 2017-08-01 at f979c9340d)
 + t8008: rely on rev-parse'd HEAD instead of sha1 value

 Code clean-up.

 Will cook in 'next'.


* rg/rerere-train-overwrite (2017-07-26) 1 commit
  (merged to 'next' on 2017-08-01 at 7fcd42974c)
 + contrib/rerere-train: optionally overwrite existing resolutions

 The "rerere-train" script (in contrib/) learned the "--overwrite"
 option to allow overwriting existing recorded resolutions.

 Will cook in 'next'.


* dl/credential-cache-socket-in-xdg-cache (2017-07-27) 1 commit
  (merged to 'next' on 2017-08-01 at 87687ae1d4)
 + credential-cache: interpret an ECONNRESET as an EOF

 A recently added test for the "credential-cache" helper revealed
 that EOF detection done around the time the connection to the cache
 daemon is torn down were flaky.  This was fixed by reacting to
 ECONNRESET and behaving as if we got an EOF.

 Will cook in 'next'.


* eb/contacts-reported-by (2017-07-27) 1 commit
  (merged to 'next' on 2017-08-01 at cca9972d6b)
 + git-contacts: also recognise "Reported-by:"

 "git contacts" (in contrib/) now lists the address on the
 "Reported-by:" trailer to its output, in addition to those on
 S-o-b: and other trailers, to make it easier to notify (and thank)
 the original bug reporter.

 Will cook in 'next'.


* js/run-process-parallel-api-fix (2017-07-21) 1 commit
  (merged to 'next' on 2017-07-27 at 4b54b69172)
 + run_processes_parallel: change confusing task_cb convention

 API fix.

 Will cook in 'next'.


* cc/ref-is-hidden-microcleanup (2017-07-24) 1 commit
  (merged to 'next' on 2017-07-27 at 37af544e1c)
 + refs: use skip_prefix() in ref_is_hidden()

 Code cleanup.

 Will cook in 'next'.


* bw/push-options-recursively-to-submodules (2017-07-20) 1 commit
  (merged to 'next' on 2017-07-27 at 26b3af2544)
 + submodule--helper: teach push-check to handle HEAD

 "git push --recurse-submodules $there HEAD:$target" was not
 propagated down to the submodules, but now it is.

 Will cook in 'next'.


* jc/http-sslkey-and-ssl-cert-are-paths (2017-07-20) 1 commit
  (merged to 'next' on 2017-07-20 at 5489304b99)
 + http.c: http.sslcert and http.sslkey are both pathnames

 The http.{sslkey,sslCert} configuration variables are to be
 interpreted as a pathname that honors "~[username]/" prefix, but
 weren't, which has been fixed.

 Will cook in 'next'.


* jt/fsck-code-cleanup (2017-07-26) 3 commits
  (merged to 'next' on 2017-07-26 at 7a17e279da)
 + fsck: cleanup unused variable
  (merged to 'next' on 2017-07-20 at f7045a8c47)
 + object: remove "used" field from struct object
 + fsck: remove redundant parse_tree() invocation

 Code clean-up.

 Will cook in 'next'.


* rs/pack-objects-pbase-cleanup (2017-07-20) 1 commit
  (merged to 'next' on 2017-07-20 at a6b618559b)
 + pack-objects: remove unnecessary NULL check

 Code clean-up.

 Will cook in 'next'.


* st/lib-gpg-kill-stray-agent (2017-07-20) 1 commit
  (merged to 'next' on 2017-07-20 at 8ea68c483f)
 + t: lib-gpg: flush gpg agent on startup

 Some versions of GnuPG fails to kill gpg-agent it auto-spawned
 and such a left-over agent can interfere with a test.  Work it
 around by attempting to kill one before starting a new test.

 Will cook in 'next'.


* jk/c99 (2017-07-18) 2 commits
  (merged to 'next' on 2017-07-18 at 1cfc30f7c1)
 + clean.c: use designated initializer
 + strbuf: use designated initializers in STRBUF_INIT

 Start using selected c99 constructs in small, stable and
 essentialpart of the system to catch people who care about
 older compilers that do not grok them.

 Will cook in 'next'.


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

 Will cook in 'next'.


* bw/object-id (2017-07-17) 3 commits
  (merged to 'next' on 2017-07-18 at 90d27c0e7c)
 + receive-pack: don't access hash of NULL object_id pointer
 + notes: don't access hash of NULL object_id pointer
 + tree-diff: don't access hash of NULL object_id pointer

 Conversion from uchar[20] to struct object_id continues.

 Will cook in 'next'.


* ks/commit-abort-on-empty-message-fix (2017-07-17) 1 commit
  (merged to 'next' on 2017-07-27 at e81ad4c1dc)
 + commit: check for empty message before the check for untouched template

 "git commit" when seeing an totally empty message said "you did not
 edit the message", which is clearly wrong.  The message has been
 corrected.

 Will cook in 'next'.


* rs/bswap-ubsan-fix (2017-07-17) 2 commits
  (merged to 'next' on 2017-07-20 at ce6bad07b0)
 + bswap: convert get_be16, get_be32 and put_be32 to inline functions
 + bswap: convert to unsigned before shifting in get_be32

 Code clean-up.

 Will cook in 'next'.


* rs/move-array (2017-07-17) 4 commits
  (merged to 'next' on 2017-07-20 at f3086cd20e)
 + ls-files: don't try to prune an empty index
 + apply: use COPY_ARRAY and MOVE_ARRAY in update_image()
 + use MOVE_ARRAY
 + add MOVE_ARRAY

 Code clean-up.

 Will cook in 'next'.


* rs/stat-data-unaligned-reads-fix (2017-07-17) 1 commit
  (merged to 'next' on 2017-07-20 at e7d3782823)
 + dir: support platforms that require aligned reads

 Code clean-up.

 Will cook in 'next'.


* wd/rebase-conflict-guide (2017-07-17) 1 commit
  (merged to 'next' on 2017-07-20 at c78e758b23)
 + rebase: make resolve message clearer for inexperienced users

 The advice message given when "git rebase" stops for conflicting
 changes has been improved.

 Will cook in 'next'.


* hb/gitweb-project-list (2017-07-18) 1 commit
  (merged to 'next' on 2017-07-27 at c25d65ca25)
 + gitweb: skip unreadable subdirectories

 When a directory is not readable, "gitweb" fails to build the
 project list.  Work this around by skipping such a directory.

 Will cook in 'next'.

 It might end up hiding a problem under the rug and a better
 solution might be to loudly complain to the administrator pointing
 out the problematic directory, but this will at least make it
 "work".


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

 Will cook in 'next'.


* sb/object-id (2017-07-13) 2 commits
  (merged to 'next' on 2017-07-18 at e4df0ba3b1)
 + tag: convert gpg_verify_tag to use struct object_id
 + commit: convert lookup_commit_graft to struct object_id
 (this branch is used by bc/object-id and bw/submodule-config-cleanup.)

 Conversion from uchar[20] to struct object_id continues.

 Will cook in 'next'.


* rs/sha1-file-micro-optim (2017-07-09) 2 commits
 - SQUASH???
 - sha1_file: add slash once in for_each_file_in_obj_subdir()

 Code cleanup.

 Perhaps drop.
 cf. <f59c8256-716b-9305-2a4f-d4fe49f666ff@web.de>


* ks/prepare-commit-msg-sample (2017-07-12) 4 commits
  (merged to 'next' on 2017-07-18 at 48d9650a30)
 + hook: add a simple first example
 + hook: add sign-off using "interpret-trailers"
 + hook: name the positional variables
 + hook: cleanup script

 Remove an example that is now obsolete from a sample hook,
 and improve an old example in it that added a sign-off manually
 to use the interpret-trailers command.

 Will cook in 'next'.


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

 Will cook in 'next'.


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

 Will cook in 'next'.


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

 Will cook in 'next'.


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

 Will cook in 'next'.


* sd/branch-copy (2017-06-18) 3 commits
  (merged to 'next' on 2017-07-18 at 5e3b9357ea)
 + branch: add a --copy (-c) option to go with --move (-m)
 + branch: add test for -m renaming multiple config sections
 + config: create a function to format section headers

 "git branch" learned "-c/-C" to create and switch to a new branch
 by copying an existing one.

 Will cook in 'next'.

 I personally do not think "branch --copy master backup" while on
 "master" that switches to "backup" is a good UI, and I *will* say
 "I told you so" when users complain after we merge this down to
 'master'.


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

 Will cook in 'next'.


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

 Will cook in 'next'.

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
