Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BDC12018E
	for <e@80x24.org>; Mon,  8 Aug 2016 22:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbcHHWc5 (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 18:32:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52708 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750938AbcHHWcz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 18:32:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C01C3300D;
	Mon,  8 Aug 2016 18:32:54 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=P
	WwEzBgdTUWl8ngTom1VH0PvBJ4=; b=klWgc2s70h3yiAJZfQGk+sSHcfY4X2QtO
	KieiLWvmxy8W9Ui+z0a1lJWP/XmV0zZq51yTEWZQJqodCPcnFx6ZQOPrMy3lu/Mw
	JYz1y1Sk1ScMAkCWGE2O992X19fRvAofj8LKd5ZLXGZtr2+IWoZRHi/A1v9NdNRw
	YQqtJO+s5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=GTB
	20c9lPiegUNI3jgolcYBuOjf+15ZMtuNxFCAjJqNBqfFpSJJkO9Jj20qYtN7NX8l
	MZ1LZKAs7Y2QqHbbLWgggc3linLR1hYutF4V8wA0KC/nE1hssxfkLM6kvq4cEvFu
	5j6AK0GImaJ/l0R9TeYa3rPtoMLOGu2i9oCTfv9E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 243263300C;
	Mon,  8 Aug 2016 18:32:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5B6793300B;
	Mon,  8 Aug 2016 18:32:53 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	git@vger.kernel.org
Subject: What's cooking in git.git (Aug 2016, #03; Mon, 8)
X-master-at: a0a1831b034af10e5d5b37b99489a7558f9cc547
X-next-at: 2eb946ae7c35488b71879c33eec3b14b822dee14
Date:	Mon, 08 Aug 2016 15:32:51 -0700
Message-ID: <xmqqwpjqdh7w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0BBFCA76-5DB8-11E6-980A-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

Many topics in "Cooking" section without seeing activity have been
moved to "Stalled" status and marked as "Will discard".  This is
unfortunate but with way many people wanting to throw random new
topics while too few people able/willing to review them, it is
inevitable.

On the 'master' front, the individual commit count now exceeds 500
since the last major release, and the early preview -rc0 is expected
to happen at the end of the week.

The 'maint' branch has been accumulating enough material to make it
the next maintenance release v2.9.3, which hopefully happen late
this week.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ab/gitweb-link-html-escape (2016-08-01) 1 commit
  (merged to 'next' on 2016-08-03 at 44b6088)
 + gitweb: escape link body in format_ref_marker

 The characters in the label shown for tags/refs for commits in
 "gitweb" output are now properly escaped for proper HTML output.


* cp/completion-clone-recurse-submodules (2016-07-27) 1 commit
  (merged to 'next' on 2016-08-03 at cbf0d94)
 + completion: add option '--recurse-submodules' to 'git clone'



* da/subtree-modernize (2016-07-27) 2 commits
  (merged to 'next' on 2016-08-03 at 06ad015)
 + subtree: adjust function definitions to match CodingGuidelines
 + subtree: adjust style to match CodingGuidelines

 Style fixes for "git subtree" (in contrib/).


* ew/build-time-pager-tweaks (2016-08-04) 1 commit
  (merged to 'next' on 2016-08-05 at 4f0b11b)
 + pager: move pager-specific setup into the build

 The build procedure learned PAGER_ENV knob that lists what default
 environment variable settings to export for popular pagers.  This
 mechanism is used to tweak the default settings to MORE on FreeBSD.


* ew/git-svn-http-tests (2016-07-25) 2 commits
  (merged to 'next' on 2016-08-03 at 2b23920)
 + git svn: migrate tests to use lib-httpd
 + t/t91*: do not say how to avoid the tests

 Tests for "git svn" have been taught to reuse the lib-httpd test
 infrastructure when testing the subversion integration that
 interacts with subversion repositories served over the http://
 protocol.


* ib/t3700-add-chmod-x-updates (2016-08-01) 3 commits
  (merged to 'next' on 2016-08-03 at 1753346)
 + t3700: add a test_mode_in_index helper function
 + t3700: merge two tests into one
 + t3700: remove unwanted leftover files before running new tests

 The t3700 test about "add --chmod=-x" have been made a bit more
 robust and generally cleaned up.


* jc/hashmap-doc-init (2016-08-02) 1 commit
  (merged to 'next' on 2016-08-05 at 2eb946a)
 + hashmap: clarify that hashmap_entry can safely be discarded

 The API documentation for hashmap was unclear if hashmap_entry
 can be safely discarded without any other consideration.  State
 that it is safe to do so.


* jh/clean-smudge-f-doc (2016-08-03) 1 commit
  (merged to 'next' on 2016-08-04 at c2fc8e6)
 + clarify %f documentation

 A minor documentation update.

 This was split out from a stalled jh/clean-smudge-annex topic
 before discarding it.


* jk/difftool-in-subdir (2016-07-28) 3 commits
  (merged to 'next' on 2016-08-03 at 90f195a)
 + difftool: use Git::* functions instead of passing around state
 + difftool: avoid $GIT_DIR and $GIT_WORK_TREE
 + difftool: fix argument handling in subdirs

 "git difftool <paths>..." started in a subdirectory failed to
 interpret the paths relative to that directory, which has been
 fixed.


* jk/pack-objects-optim (2016-07-29) 6 commits
  (merged to 'next' on 2016-08-03 at ad8caca)
 + pack-objects: compute local/ignore_pack_keep early
 + pack-objects: break out of want_object loop early
 + find_pack_entry: replace last_found_pack with MRU cache
 + add generic most-recently-used list
 + sha1_file: drop free_pack_by_name
 + t/perf: add tests for many-pack scenarios
 (this branch is used by jk/pack-objects-optim-mru and ks/pack-objects-bitmap.)

 "git pack-objects" has a few options that tell it not to pack
 objects found in certain packfiles, which require it to scan .idx
 files of all available packs.  The codepaths involved in these
 operations have been optimized for a common case of not having any
 non-local pack and/or any .kept pack.


* jk/parseopt-string-list (2016-08-03) 1 commit
  (merged to 'next' on 2016-08-04 at a7f0cd2)
 + blame: drop strdup of string literal

 A small memory leak in the command line parsing of "git blame"
 has been plugged.


* jk/reflog-date (2016-07-27) 7 commits
  (merged to 'next' on 2016-08-03 at cd8e92b)
 + date: clarify --date=raw description
 + date: add "unix" format
 + date: document and test "raw-local" mode
 + doc/pretty-formats: explain shortening of %gd
 + doc/pretty-formats: describe index/time formats for %gd
 + doc/rev-list-options: explain "-g" output formats
 + doc/rev-list-options: clarify "commit@{Nth}" for "-g" option

 The reflog output format is documented better, and a new format
 --date=unix to report the seconds-since-epoch (without timezone)
 has been added.


* jk/t4205-cleanup (2016-07-27) 2 commits
  (merged to 'next' on 2016-08-03 at ba9b594)
 + t4205: indent here documents
 + t4205: drop top-level &&-chaining

 Test modernization.


* js/nedmalloc-gcc6-warnings (2016-08-05) 2 commits
  (merged to 'next' on 2016-08-05 at b31baa7)
 + nedmalloc: work around overzealous GCC 6 warning
 + nedmalloc: fix misleading indentation

 Squelch compiler warnings for netmalloc (in compat/) library.


* js/rebase-i-progress-tidy (2016-07-28) 1 commit
  (merged to 'next' on 2016-08-03 at bb1b414)
 + rebase-interactive: trim leading whitespace from progress count

 Regression fix for an i18n topic already in 'master'.


* js/t4130-rename-without-ino (2016-08-03) 1 commit
  (merged to 'next' on 2016-08-04 at 044fb33)
 + t4130: work around Windows limitation

 Windows port was failing some tests in t4130, due to the lack of
 inum in the returned values by its lstat(2) emulation.

 Will merge to 'maint'.


* nd/fbsd-lazy-mtime (2016-08-04) 1 commit
  (merged to 'next' on 2016-08-05 at 7294870)
 + t7063: work around FreeBSD's lazy mtime update feature

 FreeBSD can lie when asked mtime of a directory, which made the
 untracked cache code to fall back to a slow-path, which in turn
 caused tests in t7063 to fail because it wanted to verify the
 behaviour of the fast-path.


* nd/fetch-ref-summary (2016-07-26) 1 commit
  (merged to 'next' on 2016-08-03 at c045704)
 + t5510: skip tests under GETTEXT_POISON build

 Hotfix of a test in a topic that has already been merged to 'master'.


* nd/log-decorate-color-head-arrow (2016-07-12) 1 commit
  (merged to 'next' on 2016-08-05 at a966c0e)
 + log: decorate HEAD -> branch with the same color for arrow and HEAD

 An entry "git log --decorate" for the tip of the current branch is
 shown as "HEAD -> name" (where "name" is the name of the branch);
 paint the arrow in the same color as "HEAD", not in the color for
 commits.


* rs/st-mult (2016-08-01) 1 commit
  (merged to 'next' on 2016-08-03 at 5c6956a)
 + pass constants as first argument to st_mult()

 Micro optimization of st_mult() facility used to check the integer
 overflow coming from multiplication to compute size of memory
 allocation.


* rs/use-strbuf-addstr (2016-08-05) 2 commits
  (merged to 'next' on 2016-08-05 at 62d16d7)
 + use strbuf_addstr() instead of strbuf_addf() with "%s"
  (merged to 'next' on 2016-08-03 at 523422f)
 + use strbuf_addstr() for adding constant strings to a strbuf


* sb/submodule-recommend-shallowness (2016-08-03) 1 commit
  (merged to 'next' on 2016-08-04 at 9f23a7e)
 + gitmodules: document shallow recommendation

 Doc update.


* va/i18n (2016-07-28) 2 commits
  (merged to 'next' on 2016-08-03 at cf753d2)
 + i18n: config: unfold error messages marked for translation
 + i18n: notes: mark comment for translation

 More i18n marking.

--------------------------------------------------
[New Topics]

* jk/big-and-future-archive-tar (2016-08-06) 1 commit
 - archive-tar: make write_extended_header() void

 A small code clean-up.

 Will merge to 'next'.


* js/mv-dir-to-new-directory (2016-08-08) 1 commit
 - git mv: do not keep slash in `git mv dir non-existing-dir/`

 "git mv dir non-existing-dir/" did not work in some environments
 the same way as existing mainstream platforms.  The code now moves
 "dir" to "non-existing-dir", without relying on rename("A", "B/")
 that strips the trailing slash of '/'.

 Will merge to 'next'.


* ks/pack-objects-bitmap (2016-08-08) 2 commits
 - pack-objects: use reachability bitmap index when generating non-stdout pack
 - pack-objects: respect --local/--honor-pack-keep/--incremental when bitmap is in use

 Waiting for review discussion to settle.
 cf. <20160808185541.6433-1-kirr@nexedi.com>
 cf. <20160808181942.GD3995@teco.navytux.spb.ru>


* rs/child-process-init (2016-08-05) 1 commit
 - use CHILD_PROCESS_INIT to initialize automatic variables

 A small code clean-up.

 Will merge to 'next'.


* rs/merge-add-strategies-simplification (2016-08-05) 1 commit
 - merge: use string_list_split() in add_strategies()

 A small code clean-up.

 Will merge to 'next'.


* rs/merge-recursive-string-list-init (2016-08-05) 1 commit
 - merge-recursive: use STRING_LIST_INIT_NODUP

 A small code clean-up.

 Will merge to 'next'.


* rs/use-strbuf-add-unique-abbrev (2016-08-06) 1 commit
 - use strbuf_add_unique_abbrev() for adding short hashes

 A small code clean-up.

 Will merge to 'next'.


* sb/submodule-clone-rr (2016-08-06) 6 commits
 - clone: reference flag is used for submodules as well
 - submodule update: add super-reference flag
 - submodule--helper update-clone: allow multiple references
 - submodule--helper module-clone: allow multiple references
 - t7408: merge short tests, factor out testing method
 - t7408: modernize style

 Waiting for review discussion to settle.
 cf. <20160806012318.17968-1-sbeller@google.com>

--------------------------------------------------
[Stalled]

* jc/bundle (2016-03-03) 6 commits
 - index-pack: --clone-bundle option
 - Merge branch 'jc/index-pack' into jc/bundle
 - bundle v3: the beginning
 - bundle: keep a copy of bundle file name in the in-core bundle header
 - bundle: plug resource leak
 - bundle doc: 'verify' is not about verifying the bundle

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

 Will discard.


* jc/blame-reverse (2016-06-14) 2 commits
 - blame: dwim "blame --reverse OLD" as "blame --reverse OLD.."
 - blame: improve diagnosis for "--reverse NEW"

 It is a common mistake to say "git blame --reverse OLD path",
 expecting that the command line is dwimmed as if asking how lines
 in path in an old revision OLD have survived up to the current
 commit.

 Has been waiting for positive responses without seeing any.

 Will discard.


* dt/index-helper (2016-07-06) 21 commits
 - index-helper: indexhelper.exitAfter config
 - trace: measure where the time is spent in the index-heavy operations
 - index-helper: optionally automatically run
 - index-helper: autorun mode
 - index-helper: don't run if already running
 - index-helper: kill mode
 - watchman: add a config option to enable the extension
 - unpack-trees: preserve index extensions
 - update-index: enable/disable watchman support
 - index-helper: use watchman to avoid refreshing index with lstat()
 - watchman: support watchman to reduce index refresh cost
 - read-cache: add watchman 'WAMA' extension
 - index-helper: log warnings
 - index-helper: add --detach
 - daemonize(): set a flag before exiting the main process
 - index-helper: add --strict
 - index-helper: new daemon for caching index and related stuff
 - unix-socket.c: add stub implementation when unix sockets are not supported
 - pkt-line: add gentle version of packet_write
 - read-cache: allow to keep mmap'd memory after reading
 - read-cache.c: fix constness of verify_hdr()

 A new "index-helper" daemon has been introduced to give newly
 spawned Git process a quicker access to the data in the index, and
 optionally interface with the watchman daemon to further reduce the
 refresh cost.

 Not quite ready yet, it seems.
 cf. <alpine.DEB.2.20.1607061016330.6426@virtualbox>
 cf. <CACsJy8AiER_=5aJ65r+GPCE_nXbrPTAMKJi=FuJgT8zzV2-NFw@mail.gmail.com>


* po/range-doc (2016-07-20) 8 commits
 - doc: revisions - clarify reachability examples
 - doc: revisions - define `reachable`
 - doc: gitrevisions - clarify 'latter case' is revision walk
 - doc: gitrevisions - use 'reachable' in page description
 - doc: give headings for the two and three dot notations
 - doc: show the actual left, right, and boundary marks
 - doc: revisions - name the left and right sides
 - doc: use 'symmetric difference' consistently

 Clarify various ways to specify the "revision ranges" in the
 documentation.

 Updates in 4/8 ("give headings") is reported to break formatting?
 cf. <57913C97.1030001@xiplink.com>


* jc/attr (2016-05-25) 18 commits
 - attr: support quoting pathname patterns in C style
 - attr: expose validity check for attribute names
 - attr: add counted string version of git_attr()
 - attr: add counted string version of git_check_attr()
 - attr: retire git_check_attrs() API
 - attr: convert git_check_attrs() callers to use the new API
 - attr: convert git_all_attrs() to use "struct git_attr_check"
 - attr: (re)introduce git_check_attr() and struct git_attr_check
 - attr: rename function and struct related to checking attributes
 - attr.c: plug small leak in parse_attr_line()
 - attr.c: tighten constness around "git_attr" structure
 - attr.c: simplify macroexpand_one()
 - attr.c: mark where #if DEBUG ends more clearly
 - attr.c: complete a sentence in a comment
 - attr.c: explain the lack of attr-name syntax check in parse_attr()
 - attr.c: update a stale comment on "struct match_attr"
 - attr.c: use strchrnul() to scan for one line
 - commit.c: use strchrnul() to scan for one line
 (this branch is used by jc/attr-more, sb/pathspec-label and sb/submodule-default-paths.)

 The attributes API has been updated so that it can later be
 optimized using the knowledge of which attributes are queried.

 I wanted to polish this topic further to make the attribute
 subsystem thread-ready, but because other topics depend on this
 topic and they do not (yet) need it to be thread-ready.

 As the authors of topics that depend on this seem not in a hurry,
 let's discard this and dependent topics and restart them some other
 day.

 Will discard.


* jc/attr-more (2016-06-09) 8 commits
 - attr.c: outline the future plans by heavily commenting
 - attr.c: always pass check[] to collect_some_attrs()
 - attr.c: introduce empty_attr_check_elems()
 - attr.c: correct ugly hack for git_all_attrs()
 - attr.c: rename a local variable check
 - fixup! d5ad6c13
 - attr.c: pass struct git_attr_check down the callchain
 - attr.c: add push_stack() helper
 (this branch uses jc/attr; is tangled with sb/pathspec-label and sb/submodule-default-paths.)

 The beginning of long and tortuous journey to clean-up attribute
 subsystem implementation.

 Needs to be redone.
 Will discard.


* sb/submodule-default-paths (2016-06-20) 5 commits
 - completion: clone can recurse into submodules
 - clone: add --init-submodule=<pathspec> switch
 - submodule update: add `--init-default-path` switch
 - Merge branch 'sb/pathspec-label' into sb/submodule-default-paths
 - Merge branch 'jc/attr' into sb/submodule-default-paths
 (this branch uses jc/attr and sb/pathspec-label; is tangled with jc/attr-more.)

 Allow specifying the set of submodules the user is interested in on
 the command line of "git clone" that clones the superproject.

 Will discard.


* sb/pathspec-label (2016-06-03) 6 commits
 - pathspec: disable preload-index when attribute pathspec magic is in use
 - pathspec: allow escaped query values
 - pathspec: allow querying for attributes
 - pathspec: move prefix check out of the inner loop
 - pathspec: move long magic parsing out of prefix_pathspec
 - Documentation: fix a typo
 (this branch is used by sb/submodule-default-paths; uses jc/attr; is tangled with jc/attr-more.)

 The pathspec mechanism learned ":(attr:X)$pattern" pathspec magic
 to limit paths that match $pattern further by attribute settings.
 The preload-index mechanism is disabled when the new pathspec magic
 is in use (at least for now), because the attribute subsystem is
 not thread-ready.

 Will discard.


* mh/connect (2016-06-06) 10 commits
 - connect: [host:port] is legacy for ssh
 - connect: move ssh command line preparation to a separate function
 - connect: actively reject git:// urls with a user part
 - connect: change the --diag-url output to separate user and host
 - connect: make parse_connect_url() return the user part of the url as a separate value
 - connect: group CONNECT_DIAG_URL handling code
 - connect: make parse_connect_url() return separated host and port
 - connect: re-derive a host:port string from the separate host and port variables
 - connect: call get_host_and_port() earlier
 - connect: document why we sometimes call get_port after get_host_and_port

 Rewrite Git-URL parsing routine (hopefully) without changing any
 behaviour.

 It has been two months without any support.  We may want to discard
 this.


* sb/bisect (2016-04-15) 22 commits
 . SQUASH???
 . bisect: get back halfway shortcut
 . bisect: compute best bisection in compute_relevant_weights()
 . bisect: use a bottom-up traversal to find relevant weights
 . bisect: prepare for different algorithms based on find_all
 . bisect: rename count_distance() to compute_weight()
 . bisect: make total number of commits global
 . bisect: introduce distance_direction()
 . bisect: extract get_distance() function from code duplication
 . bisect: use commit instead of commit list as arguments when appropriate
 . bisect: replace clear_distance() by unique markers
 . bisect: use struct node_data array instead of int array
 . bisect: get rid of recursion in count_distance()
 . bisect: make algorithm behavior independent of DEBUG_BISECT
 . bisect: make bisect compile if DEBUG_BISECT is set
 . bisect: plug the biggest memory leak
 . bisect: add test for the bisect algorithm
 . t6030: generalize test to not rely on current implementation
 . t: use test_cmp_rev() where appropriate
 . t/test-lib-functions.sh: generalize test_cmp_rev
 . bisect: allow 'bisect run' if no good commit is known
 . bisect: write about `bisect next` in documentation

 The internal algorithm used in "git bisect" to find the next commit
 to check has been optimized greatly.

 Was expecting a reroll, but now pb/bisect topic starts removinging
 more and more parts from git-bisect.sh, this needs to see a fresh
 reroll.

 Will discard.
 cf. <1460294354-7031-1-git-send-email-s-beyer@gmx.net>


* sg/completion-updates (2016-02-28) 21 commits
 . completion: cache the path to the repository
 . completion: extract repository discovery from __gitdir()
 . completion: don't guard git executions with __gitdir()
 . completion: consolidate silencing errors from git commands
 . completion: don't use __gitdir() for git commands
 . completion: respect 'git -C <path>'
 . completion: fix completion after 'git -C <path>'
 . completion: don't offer commands when 'git --opt' needs an argument
 . rev-parse: add '--absolute-git-dir' option
 . completion: list short refs from a remote given as a URL
 . completion: don't list 'HEAD' when trying refs completion outside of a repo
 . completion: list refs from remote when remote's name matches a directory
 . completion: respect 'git --git-dir=<path>' when listing remote refs
 . completion: fix most spots not respecting 'git --git-dir=<path>'
 . completion: ensure that the repository path given on the command line exists
 . completion tests: add tests for the __git_refs() helper function
 . completion tests: check __gitdir()'s output in the error cases
 . completion tests: consolidate getting path of current working directory
 . completion tests: make the $cur variable local to the test helper functions
 . completion tests: don't add test cruft to the test repository
 . completion: improve __git_refs()'s in-code documentation

 Has been waiting for a reroll for too long.
 cf. <1456754714-25237-1-git-send-email-szeder@ira.uka.de>

 Will discard.


* ec/annotate-deleted (2015-11-20) 1 commit
 - annotate: skip checking working tree if a revision is provided

 Usability fix for annotate-specific "<file> <rev>" syntax with deleted
 files.

 Has been waiting for a review for too long without seeing anything.

 Will discard.


* dk/gc-more-wo-pack (2016-01-13) 4 commits
 - gc: clean garbage .bitmap files from pack dir
 - t5304: ensure non-garbage files are not deleted
 - t5304: test .bitmap garbage files
 - prepare_packed_git(): find more garbage

 Follow-on to dk/gc-idx-wo-pack topic, to clean up stale
 .bitmap and .keep files.

 Has been waiting for a reroll for too long.
 cf. <xmqq60ypbeng.fsf@gitster.mtv.corp.google.com>

 Will discard.


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

* jh/status-v2-porcelain (2016-08-05) 10 commits
 - status: unit tests for --porcelain=v2
 - test-lib-functions.sh: Add lf_to_nul
 - git-status.txt: describe --porcelain=v2 format
 - status: print branch info with --porcelain=v2 --branch
 - status: print per-file porcelain v2 status data
 - SQUASH???
 - status: collect per-file data for --porcelain=v2
 - status: support --porcelain[=<version>]
 - status: cleanup API to wt_status_print
 - status: rename long-format print routines

 Enhance "git status --porcelain" output by collecting more data on
 the state of the index and the working tree files, which may
 further be used to teach git-prompt (in contrib/) to make fewer
 calls to git.

 Waiting for review discussion to settle.
 cf. <1470147137-17498-1-git-send-email-git@jeffhostetler.com>


* js/import-tars-hardlinks (2016-08-03) 1 commit
 - import-tars: support hard links

 "import-tars" fast-import script (in contrib/) used to ignore a
 hardlink target and replaced it with an empty file, which has been
 corrected to record the same blob as the other file the hardlink is
 shared with.

 Will merge to 'next'.


* jk/trace-fixup (2016-08-05) 8 commits
 - trace: do not fall back to stderr
 - write_or_die: drop write_or_whine_pipe()
 - trace: disable key after write error
 - trace: correct variable name in write() error message
 - trace: cosmetic fixes for error messages
 - trace: use warning() for printing trace errors
 - trace: stop using write_or_whine_pipe()
 - trace: handle NULL argument in trace_disable()

 Various small fixups to the "GIT_TRACE" facility.

 Will merge to 'next'.


* mh/diff-indent-heuristic (2016-08-04) 8 commits
 - diff: improve positioning of add/delete blocks in diffs
 - is_blank_line: take a single xrecord_t as argument
 - xdl_change_compact(): keep track of the earliest end
 - xdl_change_compact(): fix compaction heuristic to adjust io
 - xdl_change_compact(): do one final shift or the other, not both
 - xdl_change_compact(): rename i to end
 - xdl_change_compact(): clarify code
 - xdl_change_compact(): rename some local variables for clarity

 Output from "git diff" can be made easier to read by selecting
 which lines are common and which lines are added/deleted
 intelligently when the lines before and after the changed section
 are the same.  A command line option is added to help with the
 experiment to find a good heuristics.

 Waiting for review discussion to settle.
 cf. <cover.1470259583.git.mhagger@alum.mit.edu>
 cf. <20160804072705.a53mospcccksiz4e@sigill.intra.peff.net>
 cf. <20160804075631.jakbi5dbsbxsqcpr@sigill.intra.peff.net>
 cf. <29c40cdd-363a-df09-f9e2-fe9070bb8a9c@ramsayjones.plus.com>


* jt/format-patch-from-config (2016-08-01) 1 commit
  (merged to 'next' on 2016-08-05 at 897e986)
 + format-patch: format.from gives the default for --from

 "git format-patch" learned format.from configuration variable to
 specify the default settings for its "--from" option.

 Will merge to 'master'.


* sb/submodule-update-dot-branch (2016-08-03) 7 commits
  (merged to 'next' on 2016-08-04 at 47bff41)
 + submodule update: allow '.' for branch value
 + submodule--helper: add remote-branch helper
 + submodule-config: keep configured branch around
 + submodule--helper: fix usage string for relative-path
 + submodule update: narrow scope of local variable
 + submodule update: respect depth in subsequent fetches
 + t7406: future proof tests with hard coded depth

 A few updates to "git submodule update".

 Will merge to 'master'.


* cc/apply-am (2016-08-01) 42 commits
 . fixup! apply: make it possible to silently apply
 . builtin/am: use apply api in run_apply()
 . apply: refactor `git apply` option parsing
 . apply: change error_routine when silent
 . usage: add get_error_routine() and get_warn_routine()
 . usage: add set_warn_routine()
 . apply: don't print on stdout in verbosity_silent mode
 . apply: make it possible to silently apply
 . write_or_die: use warning() instead of fprintf(stderr, ...)
 . environment: add set_index_file()
 . apply: use error_errno() where possible
 . apply: make some parsing functions static again
 . apply: move libified code from builtin/apply.c to apply.{c,h}
 . apply: rename and move opt constants to apply.h
 . builtin/apply: rename option parsing functions
 . builtin/apply: make create_one_file() return -1 on error
 . builtin/apply: make try_create_file() return -1 on error
 . builtin/apply: make write_out_results() return -1 on error
 . builtin/apply: make write_out_one_result() return -1 on error
 . builtin/apply: make create_file() return -1 on error
 . builtin/apply: make add_index_file() return -1 on error
 . builtin/apply: make add_conflicted_stages_file() return -1 on error
 . builtin/apply: make remove_file() return -1 on error
 . builtin/apply: make build_fake_ancestor() return -1 on error
 . builtin/apply: change die_on_unsafe_path() to check_unsafe_path()
 . builtin/apply: make gitdiff_*() return -1 on error
 . builtin/apply: make gitdiff_*() return 1 at end of header
 . builtin/apply: make parse_traditional_patch() return -1 on error
 . builtin/apply: make apply_all_patches() return 128 or 1 on error
 . builtin/apply: move check_apply_state() to apply.c
 . builtin/apply: make check_apply_state() return -1 instead of die()ing
 . apply: make init_apply_state() return -1 instead of exit()ing
 . builtin/apply: move init_apply_state() to apply.c
 . builtin/apply: make parse_ignorewhitespace_option() return -1 instead of die()ing
 . builtin/apply: make parse_whitespace_option() return -1 instead of die()ing
 . builtin/apply: make parse_single_patch() return -1 on error
 . builtin/apply: make parse_chunk() return a negative integer on error
 . builtin/apply: make find_header() return -128 instead of die()ing
 . builtin/apply: read_patch_file() return -1 instead of die()ing
 . builtin/apply: make apply_patch() return -1 or -128 instead of die()ing
 . apply: move 'struct apply_state' to apply.h
 . apply: make some names more specific
 (this branch is used by jh/clean-smudge-annex.)

 "git am" has been taught to make an internal call to "git apply"'s
 innards without spawning the latter as a separate process.

 Temporarily kicked out of 'pu', as it adds more calling sites to a
 function that is going away.

 cf. <20160804212157.cn7ecyxcbyf4okd7@sigill.intra.peff.net>


* jk/pack-objects-optim-mru (2016-07-29) 1 commit
 - pack-objects: use mru list when iterating over packs

 This is still questionable in that it can attempt to create a cycle
 in delta-chain, only to be stopped by the last-ditch recovery logic
 in there.


* kw/patch-ids-optim (2016-08-04) 5 commits
 - SQUASH???
 - rebase: avoid computing unnecessary patch IDs
 - patch-ids: add flag to create the diff patch id using header only data
 - patch-ids: replace the seen indicator with a commit pointer
 - patch-ids: stop using a hand-rolled hashmap implementation

 When "git rebase" tries to compare set of changes on the updated
 upstream and our own branch, it computes patch-id for all of these
 changes and attempts to find matches. This has been optimized by
 lazily computing the full patch-id (which is expensive) to be
 compared only for changes that touch the same set of paths.

 Will merge to 'next' after squashing the fix in.


* jk/rebase-i-drop-ident-check (2016-07-29) 1 commit
 - rebase-interactive: drop early check for valid ident

 Even when "git pull --rebase=preserve" (and the underlying "git
 rebase --preserve") can complete without creating any new commit
 (i.e. fast-forwards), it still insisted on having a usable ident
 information (read: user.email is set correctly), which was less
 than nice.  As the underlying commands used inside "git rebase"
 would fail with a more meaningful error message and advice text
 when the bogus ident matters, this extra check was removed.

 Will hold.
 cf. <20160729224944.GA23242@sigill.intra.peff.net>


* jk/reset-ident-time-per-commit (2016-08-01) 1 commit
  (merged to 'next' on 2016-08-03 at 76d569c)
 + am: reset cached ident date for each patch

 Not-so-recent rewrite of "git am" that started making internal
 calls into the commit machinery had an unintended regression, in
 that no matter how many seconds it took to apply many patches, the
 resulting committer timestamp for the resulting commits were all
 the same.

 Will merge to 'master'.


* jk/push-force-with-lease-creation (2016-08-04) 4 commits
  (merged to 'next' on 2016-08-04 at e42ce85)
 + t5533: make it pass on case-sensitive filesystems
  (merged to 'next' on 2016-08-03 at 475c080)
 + push: allow pushing new branches with --force-with-lease
 + push: add shorthand for --force-with-lease branch creation
 + Documentation/git-push: fix placeholder formatting

 "git push --force-with-lease" already had enough logic to allow
 ensuring that such a push results in creation of a ref (i.e. the
 receiving end did not have another push from sideways that would be
 discarded by our force-pushing), but didn't expose this possibility
 to the users.  It does so now.

 Will merge to 'master'.


* js/am-3-merge-recursive-direct (2016-08-01) 16 commits
  (merged to 'next' on 2016-08-05 at dc1c9bb)
 + merge-recursive: flush output buffer even when erroring out
 + merge_trees(): ensure that the callers release output buffer
 + merge-recursive: offer an option to retain the output in 'obuf'
 + merge-recursive: write the commit title in one go
 + merge-recursive: flush output buffer before printing error messages
 + am -3: use merge_recursive() directly again
 + merge-recursive: switch to returning errors instead of dying
 + merge-recursive: handle return values indicating errors
 + merge-recursive: allow write_tree_from_memory() to error out
 + merge-recursive: avoid returning a wholesale struct
 + merge_recursive: abort properly upon errors
 + prepare the builtins for a libified merge_recursive()
 + merge-recursive: clarify code in was_tracked()
 + die(_("BUG")): avoid translating bug messages
 + die("bug"): report bugs consistently
 + t5520: verify that `pull --rebase` shows the helpful advice when failing

 "git am -3" calls "git merge-recursive" when it needs to fall back
 to a three-way merge; this call has been turned into an internal
 subroutine call instead of spawning a separate subprocess.

 Will merge to 'master'.

 Eyes from other people are highly appreciated, as my eyes (and the
 original author's, too) have rotten by staring many rerolls of the
 same topic and are not effective in spotting errors.


* dp/autoconf-curl-ssl (2016-06-28) 1 commit
 - ./configure.ac: detect SSL in libcurl using curl-config

 The ./configure script generated from configure.ac was taught how
 to detect support of SSL by libcurl better.

 Needs review.


* jc/pull-rebase-ff (2016-07-28) 1 commit
 - pull: fast-forward "pull --rebase=true"

 "git pull --rebase", when there is no new commits on our side since
 we forked from the upstream, should be able to fast-forward without
 invoking "git rebase", but it didn't.

 Needs a real log message and a few tests.


* ex/deprecate-empty-pathspec-as-match-all (2016-06-22) 1 commit
  (merged to 'next' on 2016-07-13 at d9ca7fb)
 + pathspec: warn on empty strings as pathspec

 An empty string used as a pathspec element has always meant
 'everything matches', but it is too easy to write a script that
 finds a path to remove in $path and run 'git rm "$paht"', which
 ends up removing everything.  Start warning about this use of an
 empty string used for 'everything matches' and ask users to use a
 more explicit '.' for that instead.

 The hope is that existing users will not mind this change, and
 eventually the warning can be turned into a hard error, upgrading
 the deprecation into removal of this (mis)feature.

 Will hold to see if people scream.


* mh/ref-store (2016-06-20) 38 commits
 - refs: implement iteration over only per-worktree refs
 - refs: make lock generic
 - refs: add method to rename refs
 - refs: add methods to init refs db
 - refs: make delete_refs() virtual
 - refs: add method for initial ref transaction commit
 - refs: add methods for reflog
 - refs: add method iterator_begin
 - files_ref_iterator_begin(): take a ref_store argument
 - split_symref_update(): add a files_ref_store argument
 - lock_ref_sha1_basic(): add a files_ref_store argument
 - lock_ref_for_update(): add a files_ref_store argument
 - commit_ref_update(): add a files_ref_store argument
 - lock_raw_ref(): add a files_ref_store argument
 - repack_without_refs(): add a files_ref_store argument
 - refs: make peel_ref() virtual
 - refs: make create_symref() virtual
 - refs: make pack_refs() virtual
 - refs: make verify_refname_available() virtual
 - refs: make read_raw_ref() virtual
 - resolve_gitlink_ref(): rename path parameter to submodule
 - resolve_gitlink_ref(): avoid memory allocation in many cases
 - resolve_gitlink_ref(): implement using resolve_ref_recursively()
 - resolve_ref_recursively(): new function
 - read_raw_ref(): take a (struct ref_store *) argument
 - resolve_gitlink_packed_ref(): remove function
 - resolve_packed_ref(): rename function from resolve_missing_loose_ref()
 - refs: reorder definitions
 - refs: add a transaction_commit() method
 - {lock,commit,rollback}_packed_refs(): add files_ref_store arguments
 - resolve_missing_loose_ref(): add a files_ref_store argument
 - get_packed_ref(): add a files_ref_store argument
 - add_packed_ref(): add a files_ref_store argument
 - refs: create a base class "ref_store" for files_ref_store
 - refs: add a backend method structure
 - refs: rename struct ref_cache to files_ref_store
 - rename_ref_available(): add docstring
 - resolve_gitlink_ref(): eliminate temporary variable

 The ref-store abstraction was introduced to the refs API so that we
 can plug in different backends to store references.

 Needs a fixup.
 cf. <576D9885.2020901@ramsayjones.plus.com>


* nd/shallow-deepen (2016-06-13) 27 commits
 - fetch, upload-pack: --deepen=N extends shallow boundary by N commits
 - upload-pack: add get_reachable_list()
 - upload-pack: split check_unreachable() in two, prep for get_reachable_list()
 - t5500, t5539: tests for shallow depth excluding a ref
 - clone: define shallow clone boundary with --shallow-exclude
 - fetch: define shallow boundary with --shallow-exclude
 - upload-pack: support define shallow boundary by excluding revisions
 - refs: add expand_ref()
 - t5500, t5539: tests for shallow depth since a specific date
 - clone: define shallow clone boundary based on time with --shallow-since
 - fetch: define shallow boundary with --shallow-since
 - upload-pack: add deepen-since to cut shallow repos based on time
 - shallow.c: implement a generic shallow boundary finder based on rev-list
 - fetch-pack: use a separate flag for fetch in deepening mode
 - fetch-pack.c: mark strings for translating
 - fetch-pack: use a common function for verbose printing
 - fetch-pack: use skip_prefix() instead of starts_with()
 - upload-pack: move rev-list code out of check_non_tip()
 - upload-pack: make check_non_tip() clean things up on error
 - upload-pack: tighten number parsing at "deepen" lines
 - upload-pack: use skip_prefix() instead of starts_with()
 - upload-pack: move "unshallow" sending code out of deepen()
 - upload-pack: remove unused variable "backup"
 - upload-pack: move "shallow" sending code out of deepen()
 - upload-pack: move shallow deepen code out of receive_needs()
 - transport-helper.c: refactor set_helper_option()
 - remote-curl.c: convert fetch_git() to use argv_array

 The existing "git fetch --depth=<n>" option was hard to use
 correctly when making the history of an existing shallow clone
 deeper.  A new option, "--deepen=<n>", has been added to make this
 easier to use.  "git clone" also learned "--shallow-since=<date>"
 and "--shallow-exclude=<tag>" options to make it easier to specify
 "I am interested only in the recent N months worth of history" and
 "Give me only the history since that version".

 Needs review.

 Rerolled.  What this topic attempts to achieve is worthwhile, I
 would think.


* pb/bisect (2016-08-02) 13 commits
 . bisect--helper: `bisect_start` shell function partially in C
 . bisect--helper: `get_terms` & `bisect_terms` shell function in C
 . bisect--helper: `bisect_next_check` shell function in C
 . bisect--helper: `check_and_set_terms` shell function in C
 . bisect--helper: `bisect_write` shell function in C
 . bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
 . bisect--helper: `bisect_reset` shell function in C
 . wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 . t6030: explicitly test for bisection cleanup
 . bisect--helper: `bisect_clean_state` shell function in C
 . bisect--helper: `write_terms` shell function in C
 . bisect: rewrite `check_term_format` shell function in C
 . bisect--helper: use OPT_CMDMODE instead of OPT_BOOL

 GSoC "bisect" topic.

 I'd prefer to see early part solidified so that reviews can focus
 on the later part that is still in flux.  We are almost there but
 not quite yet.


* kn/ref-filter-branch-list (2016-05-17) 17 commits
 - branch: implement '--format' option
 - branch: use ref-filter printing APIs
 - branch, tag: use porcelain output
 - ref-filter: allow porcelain to translate messages in the output
 - ref-filter: add `:dir` and `:base` options for ref printing atoms
 - ref-filter: make remote_ref_atom_parser() use refname_atom_parser_internal()
 - ref-filter: introduce symref_atom_parser() and refname_atom_parser()
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

 Rerolled.
 This also really needs review.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
 - merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007, and issues a deprecation
 warning message since v2.5.0.

 It has been reported that git-gui still uses the deprecated syntax,
 which needs to be fixed before this final step can proceed.
 cf. <5671DB28.8020901@kdbg.org>

--------------------------------------------------
[Discarded]

* jh/clean-smudge-annex (2016-08-01) 9 commits
 . use smudgeToFile filter in recursive merge
 . use smudgeToFile filter in git am
 . better recovery from failure of smudgeToFile filter
 . warn on unusable smudgeToFile/cleanFromFile config
 . use smudgeToFile in git checkout etc
 . use cleanFromFile in git add
 . add smudgeToFile and cleanFromFile filter configs
 . clarify %f documentation
 . Merge branch 'cc/apply-am' into HEAD
 (this branch uses cc/apply-am.)

 The interface to "clean/smudge" filters require Git to feed the
 whole contents via pipe, which is suboptimal for some applications.
 "cleanFromFile/smudgeToFile" commands are the moral equilvalents
 for these filters but they interact with the files on the
 filesystem directly.

 This is starting to bit-rot, as the topic it is built upon keeps
 getting rerolled.  I _think_ I rebased it correctly, but I would
 not be surprised if I made a mistake.
