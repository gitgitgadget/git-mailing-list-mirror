Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 444241F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 23:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752811AbdAZXT0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 18:19:26 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52753 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752373AbdAZXTV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 18:19:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BFF146408C;
        Thu, 26 Jan 2017 18:19:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=6
        Q7TFfW4isxbAo3tVfp1utK/G2A=; b=JniasfLKEDqF0M4I7Ns7lakAdwpEovyHl
        aaddTGftRoICz2eeVJ2D8getr5ripVDIFFaWU9vnTWAKTL+Cf5X7xkyT5LqFaPEM
        P4SbjK24iwZJFKQK0zRkjNjUFdBNd4C94tFXY26s3xa2hw+RdMOhtlT0xPBNHQmo
        srVAohALII=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=lWK
        XnUL0XXkbyGxZ0hHQnJHSZnfdf1YB07ehZJnnbUGHM9L2MZ49QtdBpGr90F+i7Sw
        tj+642zLGb6/Two5UTp6HCAsqDEJa0TBhCKY64andEQasRD0MQGPVH58Jda7+Xnz
        w1SawTFh+eG2NPRumB8N6vIyyBU9208/N4FTDM4E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B62EA6408B;
        Thu, 26 Jan 2017 18:19:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CA6496408A;
        Thu, 26 Jan 2017 18:19:17 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jan 2017, #05; Thu, 26)
X-master-at: 4e59582ff70d299f5a88449891e78d15b4b3fabe
X-next-at: 5f4715cea687c4077e2acd25706e1369a5cb338e
Date:   Thu, 26 Jan 2017 15:19:16 -0800
Message-ID: <xmqq4m0l2yvf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC0DD1D2-E41D-11E6-9CD7-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* js/mingw-hooks-with-exe-suffix (2017-01-26) 1 commit
 - mingw: allow hooks to be .exe files

 Names of the various hook scripts must be spelled exactly, but on
 Windows, an .exe binary must be named with .exe suffix; notice
 $GIT_DIR/hooks/<hookname>.exe as a valid <hookname> hook.

 Will merge to 'next'.


* js/retire-relink (2017-01-25) 2 commits
 - relink: really remove the command
 - relink: retire the command

 Cruft removal.

 Will merge to 'next'.


* js/status-pre-rebase-i (2017-01-26) 1 commit
 - status: be prepared for not-yet-started interactive rebase

 After starting "git rebase -i", which first opens the user's editor
 to edit the series of patches to apply, but before saving the
 contents of that file, "git status" failed to show the current
 state (i.e. you are in an interactive rebase session, but you have
 applied no steps yet) correctly.

 Will merge to 'next'.


* ps/urlmatch-wildcard (2017-01-26) 5 commits
 - SQUASH???
 - urlmatch: allow globbing for the URL host part
 - urlmatch: split host and port fields in `struct url_info`
 - urlmatch: enable normalization of URLs with globs
 - mailmap: add Patrick Steinhardt's work address

 The <url> part in "http.<url>.<variable>" configuration variable
 can now be spelled with '*' that serves as wildcard.
 E.g. "http.https://*.example.com.proxy" can be used to specify the
 proxy used for https://a.example.com, https://b.example.com, etc.,
 i.e. any host in the example.com domain.


* rs/absolute-pathdup (2017-01-26) 2 commits
 - use absolute_pathdup()
 - abspath: add absolute_pathdup()

 Code cleanup.

 Will merge to 'next'.


* sb/submodule-recursive-absorb (2017-01-26) 3 commits
 - submodule absorbing: fix worktree/gitdir pointers recursively for non-moves
 - cache.h: expose the dying procedure for reading gitlinks
 - setup: add gentle version of resolve_git_dir

 When a submodule "sub", which has another submodule "module" nested
 within it, is "absorbed" into the top-level superproject, the inner
 submodule "module" is left in a strange state.

 Will merge to 'next'.


* sb/submodule-update-initial-runs-custom-script (2017-01-26) 1 commit
 - submodule update: run custom update script for initial populating as well

 The user can specify a custom update method that is run when
 "submodule update" updates an already checked out submodule.  This
 was ignored when checking the submodule out for the first time and
 we instead always just checked out the commit that is bound to the
 path in the superproject's index.

 Will merge to 'next'.


* sf/putty-w-args (2017-01-26) 3 commits
 - connect: support GIT_SSH_VARIANT and ssh.variant
 - connect: rename tortoiseplink and putty variables
 - connect: handle putty/plink also in GIT_SSH_COMMAND

 The command line options for ssh invocation needs to be tweaked for
 some implementations of SSH (e.g. PuTTY plink wants "-P <port>"
 while OpenSSH wants "-p <port>" to specify port to connect to), and
 the variant was guessed when GIT_SSH environment variable is used
 to specify it.  Extend the guess to the command specified by the
 newer GIT_SSH_COMMAND and also core.sshcommand configuration
 variable, and give an escape hatch for users to deal with
 misdetected cases.

 Expecting a reroll of the last step.

--------------------------------------------------
[Stalled]

* jc/diff-b-m (2015-02-23) 5 commits
 . WIPWIP
 . WIP: diff-b-m
 - diffcore-rename: allow easier debugging
 - diffcore-rename.c: add locate_rename_src()
 - diffcore-break: allow debugging

 "git diff -B -M" produced incorrect patch when the postimage of a
 completely rewritten file is similar to the preimage of a removed
 file; such a resulting file must not be expressed as a rename from
 other place.

 The fix in this patch is broken, unfortunately.

 Will discard.

--------------------------------------------------
[Cooking]

* sh/grep-tree-obj-tweak-output (2017-01-20) 2 commits
 - grep: use '/' delimiter for paths
 - grep: only add delimiter if there isn't one already

 "git grep", when fed a tree-ish as an input, shows each hit
 prefixed with "<tree-ish>:<path>:<lineno>:".  As <tree-ish> is
 almost always either a commit or a tag that points at a commit, the
 early part of the output "<tree-ish>:<path>" can be used as the
 name of the blob and given to "git show".  When <tree-ish> is a
 tree given in the extended SHA-1 syntax (e.g. "<commit>:", or
 "<commit>:<dir>"), however, this results in a string that does not
 name a blob (e.g. "<commit>::<path>" or "<commit>:<dir>:<path>").
 "git grep" has been taught to be a bit more intelligent about these
 cases and omit a colon (in the former case) or use slash (in the
 latter case) to produce "<commit>:<path>" and
 "<commit>:<dir>/<path>" that can be used as the name of a blob.

 Waiting for the review discussion to settle, followed by a reroll.


* vp/show-ref-verify-head (2017-01-23) 6 commits
  (merged to 'next' on 2017-01-23 at af6dd9d239)
 + show-ref: remove a stale comment
 + show-ref: remove dead `if (verify)' check
 + show-ref: detect dangling refs under --verify as well
 + show-ref: move --quiet handling into show_one()
 + show-ref: allow -d to work with --verify
 + show-ref: accept HEAD with --verify

 "git show-ref HEAD" used with "--verify" because the user is not
 interested in seeing refs/remotes/origin/HEAD, and used with
 "--head" because the user does not want HEAD to be filtered out,
 i.e. "git show-ref --head --verify HEAD", did not work as expected.

 Will merge to 'master'.


* bc/use-asciidoctor-opt (2017-01-26) 9 commits
 - SQUASH???
 - Documentation: implement linkgit macro for Asciidoctor
 - Makefile: add a knob to enable the use of Asciidoctor
 - Documentation: move dblatex arguments into variable
 - Documentation: add XSLT to fix DocBook for Texinfo
 - Documentation: sort sources for gitman.texi
 - Documentation: remove unneeded argument in cat-texi.perl
 - Documentation: modernize cat-texi.perl
 - Documentation: fix warning in cat-texi.perl

 Asciidoctor, an alternative reimplementation of AsciiDoc, still
 needs some changes to work with documents meant to be formatted
 with AsciiDoc.  "make USE_ASCIIDOCTOR=YesPlease" to use it out of
 the box to document our pages is getting closer to reality.


* ls/travis-p4-on-macos (2017-01-23) 1 commit
  (merged to 'next' on 2017-01-23 at 2d51987faa)
 + travis-ci: fix Perforce install on macOS

 Update the definition of the MacOSX test environment used by
 TravisCI.

 Will merge to 'master'.


* rs/qsort-s (2017-01-23) 5 commits
  (merged to 'next' on 2017-01-23 at 7e2813848b)
 + ref-filter: use QSORT_S in ref_array_sort()
 + string-list: use QSORT_S in string_list_sort()
 + perf: add basic sort performance test
 + add QSORT_S
 + compat: add qsort_s()

 A few codepaths had to rely on a global variable when sorting
 elements of an array because sort(3) API does not allow extra data
 to be passed to the comparison function.  Use qsort_s() when
 natively available, and a fallback implementation of it when not,
 to eliminate the need, which is a prerequisite for making the
 codepath reentrant.

 Will merge to 'master'.


* jk/coding-guidelines-update (2017-01-17) 1 commit
  (merged to 'next' on 2017-01-23 at 8c57afa288)
 + CodingGuidelines: clarify multi-line brace style

 Developer doc update.

 Will merge to 'master'.


* jk/fsck-connectivity-check-fix (2017-01-26) 9 commits
  (merged to 'next' on 2017-01-26 at dd03f7a17f)
 + fsck: lazily load types under --connectivity-only
 + fsck: move typename() printing to its own function
  (merged to 'next' on 2017-01-25 at f3d7d93785)
 + t1450: use "mv -f" within loose object directory
  (merged to 'next' on 2017-01-23 at e8e9b76b84)
 + fsck: check HAS_OBJ more consistently
 + fsck: do not fallback "git fsck <bogus>" to "git fsck"
 + fsck: tighten error-checks of "git fsck <head>"
 + fsck: prepare dummy objects for --connectivity-check
 + fsck: report trees as dangling
 + t1450: clean up sub-objects in duplicate-entry test

 "git fsck --connectivity-check" was not working at all.

 Will merge to 'master'.


* js/exec-path-coverity-workaround (2017-01-09) 2 commits
  (merged to 'next' on 2017-01-23 at bf5dfbf860)
 + git_exec_path: do not return the result of getenv()
 + git_exec_path: avoid Coverity warning about unfree()d result

 Code cleanup.

 Will merge to 'master'.
 Split out of another topic.


* js/mingw-isatty (2017-01-18) 1 commit
  (merged to 'next' on 2017-01-23 at ae0f80e058)
 + mingw: follow-up to "replace isatty() hack"

 An update to a topic that is already in 'master'.

 Will merge to 'master'.


* js/sequencer-i-countdown-3 (2017-01-17) 38 commits
  (merged to 'next' on 2017-01-23 at 251dd15139)
 + sequencer (rebase -i): write out the final message
 + sequencer (rebase -i): write the progress into files
 + sequencer (rebase -i): show the progress
 + sequencer (rebase -i): suggest --edit-todo upon unknown command
 + sequencer (rebase -i): show only failed cherry-picks' output
 + sequencer (rebase -i): show only failed `git commit`'s output
 + sequencer: use run_command() directly
 + sequencer: update reading author-script
 + sequencer (rebase -i): differentiate between comments and 'noop'
 + sequencer (rebase -i): implement the 'drop' command
 + sequencer (rebase -i): allow rescheduling commands
 + sequencer (rebase -i): respect strategy/strategy_opts settings
 + sequencer (rebase -i): respect the rebase.autostash setting
 + sequencer (rebase -i): run the post-rewrite hook, if needed
 + sequencer (rebase -i): record interrupted commits in rewritten, too
 + sequencer (rebase -i): copy commit notes at end
 + sequencer (rebase -i): set the reflog message consistently
 + sequencer (rebase -i): refactor setting the reflog message
 + sequencer (rebase -i): allow fast-forwarding for edit/reword
 + sequencer (rebase -i): implement the 'reword' command
 + sequencer (rebase -i): leave a patch upon error
 + sequencer (rebase -i): update refs after a successful rebase
 + sequencer (rebase -i): the todo can be empty when continuing
 + sequencer (rebase -i): skip some revert/cherry-pick specific code path
 + sequencer (rebase -i): remove CHERRY_PICK_HEAD when no longer needed
 + sequencer (rebase -i): allow continuing with staged changes
 + sequencer (rebase -i): write an author-script file
 + sequencer (rebase -i): implement the short commands
 + sequencer (rebase -i): add support for the 'fixup' and 'squash' commands
 + sequencer (rebase -i): write the 'done' file
 + sequencer (rebase -i): learn about the 'verbose' mode
 + sequencer (rebase -i): implement the 'exec' command
 + sequencer (rebase -i): implement the 'edit' command
 + sequencer (rebase -i): implement the 'noop' command
 + sequencer: support a new action: 'interactive rebase'
 + sequencer: use a helper to find the commit message
 + sequencer: move "else" keyword onto the same line as preceding brace
 + sequencer: avoid unnecessary curly braces

 The sequencer machinery has been further enhanced so that a later
 set of patches can start using it to reimplement "rebase -i".

 Will merge to 'master'.
 I think I've said everything that needs to be said on this topic.


* jk/clear-delta-base-cache-fix (2017-01-19) 1 commit
  (merged to 'next' on 2017-01-23 at 5f4af2b0a5)
 + clear_delta_base_cache(): don't modify hashmap while iterating

 A crashing bug introduced in v2.11 timeframe has been found (it is
 triggerable only in fast-import) and fixed.

 Will merge to 'master'.


* jk/describe-omit-some-refs (2017-01-23) 5 commits
  (merged to 'next' on 2017-01-23 at f8a14b4996)
 + describe: teach describe negative pattern matches
 + describe: teach --match to accept multiple patterns
 + name-rev: add support to exclude refs by pattern match
 + name-rev: extend --refs to accept multiple patterns
 + doc: add documentation for OPT_STRING_LIST

 "git describe" and "git name-rev" have been taught to take more
 than one refname patterns to restrict the set of refs to base their
 naming output on, and also learned to take negative patterns to
 name refs not to be used for naming via their "--exclude" option.

 Will merge to 'next'.


* js/remote-rename-with-half-configured-remote (2017-01-19) 2 commits
  (merged to 'next' on 2017-01-23 at a1b655dbac)
 + remote rename: more carefully determine whether a remote is configured
 + remote rename: demonstrate a bogus "remote exists" bug

 With anticipatory tweaking for remotes defined in ~/.gitconfig
 (e.g. "remote.origin.prune" set to true, even though there may or
 may not actually be "origin" remote defined in a particular Git
 repository), "git remote rename" and other commands misinterpreted
 and behaved as if such a non-existing remote actually existed.

 Will merge to 'master'.


* sb/in-core-index-doc (2017-01-19) 4 commits
  (merged to 'next' on 2017-01-23 at 30224463e8)
 + documentation: retire unfinished documentation
 + cache.h: document add_[file_]to_index
 + cache.h: document remove_index_entry_at
 + cache.h: document index_name_pos

 Documentation and in-code comments updates.

 Will merge to 'master'.


* sb/retire-convert-objects-from-contrib (2017-01-19) 1 commit
  (merged to 'next' on 2017-01-23 at decc1e237d)
 + contrib: remove git-convert-objects

 Remove an ancient tool left in contrib/.

 Will merge to 'master'.


* ep/commit-static-buf-cleanup (2017-01-13) 2 commits
 - builtin/commit.c: switch to xstrfmt(), instead of snprintf()
 - builtin/commit.c: remove the PATH_MAX limitation via dynamic allocation

 Code clean-up.

 Expecting a reroll.
 The tip one would instead be done with strbuf.
 cf. <CA+EOSB=4-TKpi6mr-yVbwRsFrVzE=vo4Y9Qm3VMm7pn=UB1_hQ@mail.gmail.com>


* jk/vreport-sanitize (2017-01-11) 2 commits
  (merged to 'next' on 2017-01-18 at 4bbf370981)
 + vreport: sanitize ASCII control chars
 + Revert "vreportf: avoid intermediate buffer"

 An error message with an ASCII control character like '\r' in it
 can alter the message to hide its early part, which is problematic
 when a remote side gives such an error message that the local side
 will relay with a "remote: " prefix.

 Will merge to 'master'.


* sb/unpack-trees-super-prefix (2017-01-25) 4 commits
 - unpack-trees: support super-prefix option
 - t1001: modernize style
 - t1000: modernize style
 - read-tree: use OPT_BOOL instead of OPT_SET_INT

 "git read-tree" and its underlying unpack_trees() machinery learned
 to report problematic paths prefixed with the --super-prefix option.

 Will merge to 'next'.


* sb/submodule-doc (2017-01-12) 3 commits
 - submodules: add a background story
 - submodule update documentation: don't repeat ourselves
 - submodule documentation: add options to the subcommand

 Needs review.


* bw/attr (2017-01-23) 27 commits
 - attr: reformat git_attr_set_direction() function
 - attr: push the bare repo check into read_attr()
 - attr: store attribute stack in attr_check structure
 - attr: tighten const correctness with git_attr and match_attr
 - attr: remove maybe-real, maybe-macro from git_attr
 - attr: eliminate global check_all_attr array
 - attr: use hashmap for attribute dictionary
 - attr: change validity check for attribute names to use positive logic
 - attr: pass struct attr_check to collect_some_attrs
 - attr: retire git_check_attrs() API
 - attr: convert git_check_attrs() callers to use the new API
 - attr: convert git_all_attrs() to use "struct attr_check"
 - attr: (re)introduce git_check_attr() and struct attr_check
 - attr: rename function and struct related to checking attributes
 - attr.c: outline the future plans by heavily commenting
 - Documentation/gitattributes.txt: fix a typo
 - attr.c: add push_stack() helper
 - attr: support quoting pathname patterns in C style
 - attr.c: plug small leak in parse_attr_line()
 - attr.c: tighten constness around "git_attr" structure
 - attr.c: simplify macroexpand_one()
 - attr.c: mark where #if DEBUG ends more clearly
 - attr.c: complete a sentence in a comment
 - attr.c: explain the lack of attr-name syntax check in parse_attr()
 - attr.c: update a stale comment on "struct match_attr"
 - attr.c: use strchrnul() to scan for one line
 - commit.c: use strchrnul() to scan for one line

 The gitattributes machinery is being taught to work better in a
 multi-threaded environment.

 Expecting a reroll.


* jk/loose-object-fsck (2017-01-15) 6 commits
  (merged to 'next' on 2017-01-23 at 4302ad090d)
 + fsck: detect trailing garbage in all object types
 + fsck: parse loose object paths directly
 + sha1_file: add read_loose_object() function
 + t1450: test fsck of packed objects
 + sha1_file: fix error message for alternate objects
 + t1450: refactor loose-object removal

 "git fsck" inspects loose objects more carefully now.

 Will merge to 'master'.


* vn/xdiff-func-context (2017-01-15) 1 commit
 - xdiff -W: relax end-of-file function detection

 "git diff -W" has been taught to handle the case where a new
 function is added at the end of the file better.

 Will hold.
 An follow-up change to go back from the line that matches the
 funcline to show comments before the function definition is still
 being discussed.


* mh/ref-remove-empty-directory (2017-01-07) 23 commits
 - files_transaction_commit(): clean up empty directories
 - try_remove_empty_parents(): teach to remove parents of reflogs, too
 - try_remove_empty_parents(): don't trash argument contents
 - try_remove_empty_parents(): rename parameter "name" -> "refname"
 - delete_ref_loose(): inline function
 - delete_ref_loose(): derive loose reference path from lock
 - log_ref_write_1(): inline function
 - log_ref_setup(): manage the name of the reflog file internally
 - log_ref_write_1(): don't depend on logfile argument
 - log_ref_setup(): pass the open file descriptor back to the caller
 - log_ref_setup(): improve robustness against races
 - log_ref_setup(): separate code for create vs non-create
 - log_ref_write(): inline function
 - rename_tmp_log(): improve error reporting
 - rename_tmp_log(): use raceproof_create_file()
 - lock_ref_sha1_basic(): use raceproof_create_file()
 - lock_ref_sha1_basic(): inline constant
 - raceproof_create_file(): new function
 - safe_create_leading_directories(): set errno on SCLD_EXISTS
 - safe_create_leading_directories_const(): preserve errno
 - t5505: use "for-each-ref" to test for the non-existence of references
 - refname_is_safe(): correct docstring
 - files_rename_ref(): tidy up whitespace

 Deletion of a branch "foo/bar" could remove .git/refs/heads/foo
 once there no longer is any other branch whose name begins with
 "foo/", but we didn't do so so far.  Now we do.

 Expecting a reroll.
 cf. <5051c78e-51f9-becd-e1a6-9c0b781d6912@alum.mit.edu>


* ls/filter-process-delayed (2017-01-08) 1 commit
 . convert: add "status=delayed" to filter process protocol

 Ejected, as does not build when merged to 'pu'.


* nd/worktree-move (2017-01-09) 6 commits
 - worktree remove: new command
 - worktree move: refuse to move worktrees with submodules
 - worktree move: accept destination as directory
 - worktree move: new command
 - worktree.c: add update_worktree_location()
 - worktree.c: add validate_worktree()

 "git worktree" learned move and remove subcommands.

 Needs review.


* nd/log-graph-configurable-colors (2017-01-23) 3 commits
  (merged to 'next' on 2017-01-23 at c369982ad8)
 + log --graph: customize the graph lines with config log.graphColors
 + color.c: trim leading spaces in color_parse_mem()
 + color.c: fix color_parse_mem() with value_len == 0

 Some people feel the default set of colors used by "git log --graph"
 rather limiting.  A mechanism to customize the set of colors has
 been introduced.

 Will merge to 'next'.


* cc/split-index-config (2016-12-26) 21 commits
 - Documentation/git-update-index: explain splitIndex.*
 - Documentation/config: add splitIndex.sharedIndexExpire
 - read-cache: use freshen_shared_index() in read_index_from()
 - read-cache: refactor read_index_from()
 - t1700: test shared index file expiration
 - read-cache: unlink old sharedindex files
 - config: add git_config_get_expiry() from gc.c
 - read-cache: touch shared index files when used
 - sha1_file: make check_and_freshen_file() non static
 - Documentation/config: add splitIndex.maxPercentChange
 - t1700: add tests for splitIndex.maxPercentChange
 - read-cache: regenerate shared index if necessary
 - config: add git_config_get_max_percent_split_change()
 - Documentation/git-update-index: talk about core.splitIndex config var
 - Documentation/config: add information for core.splitIndex
 - t1700: add tests for core.splitIndex
 - update-index: warn in case of split-index incoherency
 - read-cache: add and then use tweak_split_index()
 - split-index: add {add,remove}_split_index() functions
 - config: add git_config_get_split_index()
 - config: mark an error message up for translation

 The experimental "split index" feature has gained a few
 configuration variables to make it easier to use.

 Waiting for review comments to be addressed.
 cf. <20161226102222.17150-1-chriscool@tuxfamily.org>
 cf. <a1a44640-ff6c-2294-72ac-46322eff8505@ramsayjones.plus.com>


* bw/push-submodule-only (2016-12-20) 3 commits
  (merged to 'next' on 2017-01-23 at d6cd1c60ae)
 + push: add option to push only submodules
 + submodules: add RECURSE_SUBMODULES_ONLY value
 + transport: reformat flag #defines to be more readable

 "git submodule push" learned "--recurse-submodules=only option to
 push submodules out without pushing the top-level superproject.

 Will merge to 'master'.


* ls/p4-path-encoding (2016-12-18) 1 commit
 - git-p4: fix git-p4.pathEncoding for removed files

 When "git p4" imports changelist that removes paths, it failed to
 convert pathnames when the p4 used encoding different from the one
 used on the Git side.  This has been corrected.

 Will be rerolled.
 cf. <7E1C7387-4F37-423F-803D-3B5690B49D40@gmail.com>


* js/difftool-builtin (2017-01-25) 4 commits
  (merged to 'next' on 2017-01-25 at 87d2a0976a)
 + difftool: hack around -Wzero-length-format warning
  (merged to 'next' on 2017-01-23 at 6f4810dbd9)
 + difftool: retire the scripted version
 + difftool: implement the functionality in the builtin
 + difftool: add a skeleton for the upcoming builtin

 Rewrite a scripted porcelain "git difftool" in C.

 Will merge to 'master'.


* sb/push-make-submodule-check-the-default (2017-01-26) 3 commits
  (merged to 'next' on 2017-01-26 at 5f4715cea6)
 + Revert "push: change submodule default to check when submodules exist"
  (merged to 'next' on 2016-12-12 at 1863e05af5)
 + push: change submodule default to check when submodules exist
 + submodule add: extend force flag to add existing repos

 Turn the default of "push.recurseSubmodules" to "check" when
 submodules seem to be in use.

 I'll probably remove the tip-two commits and advance the bottom one
 separately.


* kn/ref-filter-branch-list (2017-01-10) 21 commits
 - SQUASH???
 - branch: implement '--format' option
 - branch: use ref-filter printing APIs
 - branch, tag: use porcelain output
 - ref-filter: allow porcelain to translate messages in the output
 - ref-filter: add an 'rstrip=<N>' option to atoms which deal with refnames
 - ref-filter: modify the 'lstrip=<N>' option to work with negative '<N>'
 - ref-filter: Do not abruptly die when using the 'lstrip=<N>' option
 - ref-filter: rename the 'strip' option to 'lstrip'
 - ref-filter: make remote_ref_atom_parser() use refname_atom_parser_internal()
 - ref-filter: introduce refname_atom_parser()
 - ref-filter: introduce refname_atom_parser_internal()
 - ref-filter: make "%(symref)" atom work with the ':short' modifier
 - ref-filter: add support for %(upstream:track,nobracket)
 - ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
 - ref-filter: introduce format_ref_array_item()
 - ref-filter: move get_head_description() from branch.c
 - ref-filter: modify "%(objectname:short)" to take length
 - ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
 - ref-filter: include reference to 'used_atom' within 'atom_value'
 - ref-filter: implement %(if), %(then), and %(else) atoms

 The code to list branches in "git branch" has been consolidated
 with the more generic ref-filter API.

 I think this is almost ready.  Will wait for a few days, squash
 fixes in if needed and merge to 'next'.


* jk/no-looking-at-dotgit-outside-repo-final (2016-10-26) 1 commit
  (merged to 'next' on 2016-12-05 at 0c77e39cd5)
 + setup_git_env: avoid blind fall-back to ".git"

 Originally merged to 'next' on 2016-10-26

 This is the endgame of the topic to avoid blindly falling back to
 ".git" when the setup sequence said we are _not_ in Git repository.
 A corner case that happens to work right now may be broken by a
 call to die("BUG").

 Will cook in 'next'.


* pb/bisect (2016-10-18) 27 commits
 - bisect--helper: remove the dequote in bisect_start()
 - bisect--helper: retire `--bisect-auto-next` subcommand
 - bisect--helper: retire `--bisect-autostart` subcommand
 - bisect--helper: retire `--bisect-write` subcommand
 - bisect--helper: `bisect_replay` shell function in C
 - bisect--helper: `bisect_log` shell function in C
 - bisect--helper: retire `--write-terms` subcommand
 - bisect--helper: retire `--check-expected-revs` subcommand
 - bisect--helper: `bisect_state` & `bisect_head` shell function in C
 - bisect--helper: `bisect_autostart` shell function in C
 - bisect--helper: retire `--next-all` subcommand
 - bisect--helper: retire `--bisect-clean-state` subcommand
 - bisect--helper: `bisect_next` and `bisect_auto_next` shell function in C
 - t6030: no cleanup with bad merge base
 - bisect--helper: `bisect_start` shell function partially in C
 - bisect--helper: `get_terms` & `bisect_terms` shell function in C
 - bisect--helper: `bisect_next_check` & bisect_voc shell function in C
 - bisect--helper: `check_and_set_terms` shell function in C
 - bisect--helper: `bisect_write` shell function in C
 - bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
 - bisect--helper: `bisect_reset` shell function in C
 - wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 - t6030: explicitly test for bisection cleanup
 - bisect--helper: `bisect_clean_state` shell function in C
 - bisect--helper: `write_terms` shell function in C
 - bisect: rewrite `check_term_format` shell function in C
 - bisect--helper: use OPT_CMDMODE instead of OPT_BOOL

 Move more parts of "git bisect" to C.

 Expecting a reroll.
 cf. <CAFZEwPPXPPHi8KiEGS9ggzNHDCGhuqMgH9Z8-Pf9GLshg8+LPA@mail.gmail.com>
 cf. <CAFZEwPM9RSTGN54dzaw9gO9iZmsYjJ_d1SjUD4EzSDDbmh-XuA@mail.gmail.com>


* st/verify-tag (2017-01-18) 6 commits
  (merged to 'next' on 2017-01-23 at 2810959427)
 + t/t7004-tag: Add --format specifier tests
 + t/t7030-verify-tag: Add --format specifier tests
 + builtin/tag: add --format argument for tag -v
 + builtin/verify-tag: add --format to verify-tag
 + ref-filter: add function to print single ref_array_item
 + gpg-interface, tag: add GPG_VERIFY_OMIT_STATUS flag

 "git tag" and "git verify-tag" learned to put GPG verification
 status in their "--format=<placeholders>" output format.

 Will merge to 'master'.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
  (merged to 'next' on 2016-12-05 at 041946dae0)
 + merge: drop 'git merge <message> HEAD <commit>' syntax

 Originally merged to 'next' on 2016-10-11

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007, and issues a deprecation
 warning message since v2.5.0.

 Will cook in 'next'.

--------------------------------------------------
[Discarded]

* jc/bundle (2016-03-03) 6 commits
 . index-pack: --clone-bundle option
 . Merge branch 'jc/index-pack' into jc/bundle
 . bundle v3: the beginning
 . bundle: keep a copy of bundle file name in the in-core bundle header
 . bundle: plug resource leak
 . bundle doc: 'verify' is not about verifying the bundle

 The beginning of "split bundle", which could be one of the
 ingredients to allow "git clone" traffic off of the core server
 network to CDN.

 While I think it would make it easier for people to experiment and
 build on if the topic is merged to 'next', I am at the same time a
 bit reluctant to merge an unproven new topic that introduces a new
 file format, which we may end up having to support til the end of
 time.  It is likely that to support a "prime clone from CDN", it
 would need a lot more than just "these are the heads and the pack
 data is over there", so this may not be sufficient.


* jk/nofollow-attr-ignore (2016-11-02) 5 commits
 . exclude: do not respect symlinks for in-tree .gitignore
 . attr: do not respect symlinks for in-tree .gitattributes
 . exclude: convert "check_index" into a flags field
 . attr: convert "macro_ok" into a flags field
 . add open_nofollow() helper

 As we do not follow symbolic links when reading control files like
 .gitignore and .gitattributes from the index, match the behaviour
 and not follow symbolic links when reading them from the working
 tree.  This also tightens security a bit by not leaking contents of
 an unrelated file in the error messages when it is pointed at by
 one of these files that is a symbolic link.

 Perhaps we want to cover .gitmodules too with the same mechanism?
