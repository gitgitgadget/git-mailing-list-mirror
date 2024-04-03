Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3979F692FC
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 23:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712185967; cv=none; b=PwGBD3sVvD7qLfAnVjBipAPyK9ThptN2glOCPYpoRy9rlPCAONHIasz3r7oyoKGFpFXXbnEbgnRoPW4pZhYvSlAhf2pDQJcbEZz8DL+s+0f9uhAkOLmk/ltFQ1FHmQ/cZiMZC0PS04ibSLaxdg4cJhpK3hD4PU+mgtlJjlIua5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712185967; c=relaxed/simple;
	bh=lSF38cKp/ZAhT5SmHfIGR5RAO21nJ4Zy7ZgMCUpZ1bM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iHkatccJw0Em1PHvl0FWT2dmPL5PC1QCxQfEHrNhYi34N9VeALfA4zuhlCzpJZAs8R7/9jYXS8b5vQVFQh9RMB90tXdmWVjSKpejDkhWNftycq4hbaxZx8IzbEKLxIwIK/wbjqpf1V5Jss+uDsf7CvrF770zhz0nMe1gbyAPogE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ssU7u0zY; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ssU7u0zY"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AAC071DE5B1;
	Wed,  3 Apr 2024 19:12:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=l
	SF38cKp/ZAhT5SmHfIGR5RAO21nJ4Zy7ZgMCUpZ1bM=; b=ssU7u0zYFbGEypeTH
	EJ2nW6nz3FKV4V4Rz5rVAu03rKA9KvDwrY2vnpgF4XBnwhfyxDKNW0eYpoTCUVVS
	BXPBuhr/je941Vcp7XOFgwFAanANBylTNASHvcpIxPRDSDIe9GA8fR4k8/nxpzFN
	AdsyTkrtw6G97hn7CXIy0XDlIE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A1BA51DE5B0;
	Wed,  3 Apr 2024 19:12:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DD3C91DE5AF;
	Wed,  3 Apr 2024 19:12:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Apr 2024, #02; Wed, 3)
X-master-at: 7774cfed6261ce2900c84e55906da708c711d601
X-next-at: 4b32163adf4863c6df3bb6b43540fa2ca3494e28
Date: Wed, 03 Apr 2024 16:12:41 -0700
Message-ID: <xmqq8r1u59cm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AC994E6A-F20F-11EE-B7B0-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen', and
aren't considered "accepted" at all and may be annotated with an URL
to a message that raises issues but they are no means exhaustive.  A
topic without enough support may be discarded after a long period of
no activity (of course they can be resubmit when new interests
arise).

Copies of the source code to Git live in many repositories, and the
following is a list of the ones I push into or their mirrors.  Some
repositories have only a subset of branches.

With maint, master, next, seen, todo:

	git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git/
	https://kernel.googlesource.com/pub/scm/git/git/
	https://github.com/git/git/
	https://gitlab.com/git-scm/git/

With all the integration branches and topics broken out:

	https://github.com/gitster/git/

Even though the preformatted documentation in HTML and man format
are not sources, they are published in these repositories for
convenience (replace "htmldocs" with "manpages" for the manual
pages):

	git://git.kernel.org/pub/scm/git/git-htmldocs.git/
	https://github.com/gitster/git-htmldocs.git/

Release tarballs are available at:

	https://www.kernel.org/pub/software/scm/git/

--------------------------------------------------
[Graduated to 'master']

* az/grep-group-error-message-update (2024-03-25) 1 commit
  (merged to 'next' on 2024-03-27 at 567bf00ed4)
 + grep: improve errors for unmatched ( and )

 Error message clarification.
 source: <tkz3a5jkalcz5ajemx4b4x42pe6kv45sfmgpin4zeai3moq42o@tarta.nabijaczleweli.xyz>


* bl/cherry-pick-empty (2024-03-25) 7 commits
  (merged to 'next' on 2024-03-28 at 22e8e4a68e)
 + cherry-pick: add `--empty` for more robust redundant commit handling
 + cherry-pick: enforce `--keep-redundant-commits` incompatibility
 + sequencer: do not require `allow_empty` for redundant commit options
 + sequencer: handle unborn branch with `--allow-empty`
 + rebase: update `--empty=ask` to `--empty=stop`
 + docs: clean up `--empty` formatting in git-rebase(1) and git-am(1)
 + docs: address inaccurate `--empty` default with `--exec`

 Allow git-cherry-pick(1) to automatically drop redundant commits via
 a new `--empty` option, similar to the `--empty` options for
 git-rebase(1) and git-am(1). Includes a soft deprecation of
 `--keep-redundant-commits` as well as some related docs changes and
 sequencer code cleanup.
 cf. <a397f3dd-e4e1-4275-b17d-1daca9e166fe@gmail.com>
 source: <20240119060721.3734775-2-brianmlyles@gmail.com>


* bl/pretty-shorthand-config-fix (2024-03-25) 2 commits
  (merged to 'next' on 2024-03-28 at e2749914ab)
 + pretty: find pretty formats case-insensitively
 + pretty: update tests to use `test_config`

 The "--pretty=<shortHand>" option of the commands in the "git log"
 family, defined as "[pretty] shortHand = <expansion>" should have
 been looked up case insensitively, but was not, which has been
 corrected.
 source: <20240324214316.917513-1-brianmlyles@gmail.com>


* ds/config-internal-whitespace-fix (2024-03-21) 4 commits
  (merged to 'next' on 2024-03-25 at f3393cabe5)
 + config.txt: describe handling of whitespace further
 + t1300: add more tests for whitespace and inline comments
 + config: really keep value-internal whitespace verbatim
 + config: minor addition of whitespace

 "git config" corrupted literal HT characters written in the
 configuration file as part of a value, which has been corrected.
 source: <cover.1711001016.git.dsimic@manjaro.org>


* ds/grep-doc-updates (2024-03-25) 2 commits
  (merged to 'next' on 2024-03-27 at 681f08cbc5)
 + grep docs: describe --no-index further and improve formatting a bit
 + grep docs: describe --recurse-submodules further and improve formatting a bit

 Documentation updates.
 source: <cover.1711398665.git.dsimic@manjaro.org>


* jc/release-notes-entry-experiment (2024-03-26) 1 commit
  (merged to 'next' on 2024-03-27 at 74ebe224e9)
 + SubmittingPatches: release-notes entry experiment

 Introduce an experimental protocol for contributors to propose the
 topic description to be used in the "What's cooking" report, the
 merge commit message for the topic, and in the release notes and
 document it in the SubmittingPatches document.
 source: <xmqq8r26eyva.fsf@gitster.g>


* jk/doc-remote-helpers-markup-fix (2024-03-20) 1 commit
  (merged to 'next' on 2024-03-25 at 7c3dd28ca5)
 + doc/gitremote-helpers: fix more missing single-quotes

 Documentation mark-up fix.
 source: <20240320091748.GA2444639@coredump.intra.peff.net>


* jk/pretty-subject-cleanup (2024-03-22) 7 commits
  (merged to 'next' on 2024-03-22 at 2796f347ad)
 + format-patch: fix leak of empty header string
 + format-patch: simplify after-subject MIME header handling
 + format-patch: return an allocated string from log_write_email_headers()
 + log: do not set up extra_headers for non-email formats
 + pretty: drop print_email_subject flag
 + pretty: split oneline and email subject printing
 + shortlog: stop setting pp.print_email_subject

 Code clean-up in the "git log" machinery that implements custom log
 message formatting.
 source: <20240320002555.GB903718@coredump.intra.peff.net>


* jk/rebase-apply-leakfix (2024-03-22) 1 commit
  (merged to 'next' on 2024-03-25 at f9358272af)
 + rebase: use child_process_clear() to clean

 Leakfix.
 source: <20240322103502.GA2045297@coredump.intra.peff.net>


* jk/remote-helper-object-format-option-fix (2024-03-20) 3 commits
  (merged to 'next' on 2024-03-27 at 5c9d5be660)
 + transport-helper: send "true" value for object-format option
 + transport-helper: drop "object-format <algo>" option
 + transport-helper: use write helpers more consistently

 The implementation and documentation of "object-format" option
 exchange between the Git itself and its remote helpers did not
 quite match, which has been corrected.
 source: <20240320093226.GA2445531@coredump.intra.peff.net>


* pb/advice-merge-conflict (2024-03-18) 2 commits
  (merged to 'next' on 2024-03-25 at 4414e31d81)
 + builtin/am: allow disabling conflict advice
 + sequencer: allow disabling conflict advice

 Hints that suggest what to do after resolving conflicts can now be
 squelched by disabling advice.mergeConflict.

 Acked-by: Phillip Wood <phillip.wood123@gmail.com>
 cf. <e040c631-42d9-4501-a7b8-046f8dac6309@gmail.com>
 source: <pull.1682.v3.git.1710623790.gitgitgadget@gmail.com>


* pb/test-scripts-are-build-targets (2024-03-25) 1 commit
  (merged to 'next' on 2024-03-27 at 9ef22a39b6)
 + t/README: mention test files are make targets

 The t/README file now gives a hint on running individual tests in
 the "t/" directory with "make t<num>-*.sh t<num>-*.sh".
 source: <pull.1701.git.1711293246094.gitgitgadget@gmail.com>


* ps/clone-with-includeif-onbranch (2024-03-12) 1 commit
  (merged to 'next' on 2024-03-25 at 8d11bd8bd4)
 + t5601: exercise clones with "includeIf.*.onbranch"

 An additional test to demonstrate that clone would not choke on a
 global configuration file that uses includeIf.onbranch:*.path.
 source: <0bede59a53862585c49bc635f82e44e983144a7f.1710246859.git.ps@pks.im>


* ps/reftable-unit-test-nfs-workaround (2024-03-21) 1 commit
  (merged to 'next' on 2024-03-25 at 4d3d391330)
 + reftable: fix tests being broken by NFS' delete-after-close semantics

 A unit test for reftable code tried to enumerate all files in a
 directory after reftable operations and expected to see nothing but
 the files it wanted to leave there, but was fooled by .nfs* cruft
 files left, which has been corrected.
 source: <8ac5e94a3930cdd2aee9ea86acda3155674b635c.1711035529.git.ps@pks.im>


* ps/t7800-variable-interpolation-fix (2024-03-22) 3 commits
  (merged to 'next' on 2024-03-25 at e7b1ec4df4)
 + t/README: document how to loop around test cases
 + t7800: use single quotes for test bodies
 + t7800: improve test descriptions with empty arguments

 Fix the way recently added tests interpolate variables defined
 outside them, and document the best practice to help future
 developers.
 source: <cover.1711074118.git.ps@pks.im>


* pw/checkout-conflict-errorfix (2024-03-14) 5 commits
  (merged to 'next' on 2024-03-22 at 9977ac6c75)
 + checkout: fix interaction between --conflict and --merge
 + checkout: cleanup --conflict=<style> parsing
 + merge options: add a conflict style member
 + merge-ll: introduce LL_MERGE_OPTIONS_INIT
 + xdiff-interface: refactor parsing of merge.conflictstyle

 "git checkout --conflict=bad" reported a bad conflictStyle as if it
 were given to a configuration variable; it has been corrected to
 report that the command line option is bad.
 source: <pull.1684.v2.git.1710435907.gitgitgadget@gmail.com>


* rs/midx-use-strvec-pushf (2024-03-25) 1 commit
  (merged to 'next' on 2024-03-27 at 16969df3e8)
 + midx: use strvec_pushf() for pack-objects base name
 (this branch is used by tb/midx-write.)

 Code clean-up.
 source: <9483038c-9529-4243-9b9a-97254fac29c1@web.de>


* rs/strbuf-expand-bad-format (2024-03-25) 2 commits
  (merged to 'next' on 2024-03-27 at 1f9dbf70a0)
 + cat-file: use strbuf_expand_bad_format()
 + factor out strbuf_expand_bad_format()

 Code clean-up.
 source: <27cdcde7-74bc-4ee8-bc84-9a6046292cae@web.de>

--------------------------------------------------
[New Topics]

* kn/clarify-update-ref-doc (2024-04-02) 2 commits
  (merged to 'next' on 2024-04-02 at d1b9c5aa67)
 + githooks: use {old,new}-oid instead of {old,new}-value
 + update-ref: use {old,new}-oid instead of {old,new}value

 Doc update, as a preparation to enhance "git update-ref --stdin".

 Will merge to 'master'.
 source: <20240402064915.191104-1-knayak@gitlab.com>


* vs/complete-with-set-u-fix (2024-04-01) 2 commits
  (merged to 'next' on 2024-04-02 at d8f6a511e8)
 + completion: protect prompt against unset SHOWUPSTREAM in nounset mode
 + completion: fix prompt with unset SHOWCONFLICTSTATE in nounset mode

 Another "set -u" fix for the bash prompt (in contrib/) script.

 Will merge to 'master'.
 source: <20240401190751.8676-1-ville.skytta@iki.fi>


* ba/osxkeychain-updates (2024-04-01) 4 commits
 - osxkeychain: store new attributes
 - osxkeychain: erase matching passwords only
 - osxkeychain: erase all matching credentials
 - osxkeychain: replace deprecated SecKeychain API

 Update osxkeychain backend with features required for the recent
 credential subsystem.

 Will merge to 'next'?
 source: <pull.1667.git.1708212896.gitgitgadget@gmail.com>


* rs/imap-send-use-xsnprintf (2024-04-02) 1 commit
 - imap-send: use xsnprintf to format command

 Code clean-up and duplicate reduction.

 Will merge to 'next'.
 source: <f9ad9f41-5b9b-474e-9818-f91fc937daae@web.de>


* tb/midx-write (2024-04-01) 5 commits
 - midx-write.c: use `--stdin-packs` when repacking
 - midx-write.c: check count of packs to repack after grouping
 - midx-write.c: factor out common want_included_pack() routine
 - midx-write: move writing-related functions from midx.c
 - Merge branch 'rs/midx-use-strvec-pushf' into tb/midx-write

 Code clean-up by splitting code responsible for writing midx files
 into its own file.

 Will merge to 'next'?
 source: <cover.1712006190.git.me@ttaylorr.com>


* jc/t2104-style-update (2024-04-02) 1 commit
  (merged to 'next' on 2024-04-03 at 0449835479)
 + t2104: style fixes

 Coding style fixes.

 Will merge to 'master'.
 source: <xmqqmsqb4ngg.fsf@gitster.g>


* rs/t-prio-queue-cleanup (2024-04-02) 1 commit
 - t-prio-queue: simplify using compound literals

 t-prio-queue test has been cleaned up by using C99 compound
 literals; this is meant to also serve as a weather-balloon to smoke
 out folks with compilers who have trouble compiling code that uses
 the feature.

 Will merge to 'next'?
 source: <520da361-1b80-4ba3-87b2-86d6fdfc18b5@web.de>


* jk/libcurl-8.7-regression-workaround (2024-04-02) 2 commits
 - INSTALL: bump libcurl version to 7.21.3
 - http: reset POSTFIELDSIZE when clearing curl handle

 Fix was added to work around a regression in libcURL 8.7.0 (which has
 already been fixed in their tip of the tree).

 Expecting a reroll.
 cf. <20240403032045.GA1559972@coredump.intra.peff.net>
 source: <20240402200254.GA874754@coredump.intra.peff.net>


* tb/t7700-fixup (2024-04-03) 1 commit
 - t/t7700-repack.sh: fix test breakages with `GIT_TEST_MULTI_PACK_INDEX=1 `

 source: <7e8d435d58eea19d2aae0be366720f5956d29a5d.1712075189.git.me@ttaylorr.com>

--------------------------------------------------
[Cooking]

* es/test-cron-safety (2024-03-31) 1 commit
  (merged to 'next' on 2024-04-02 at e383c8cfb2)
 + test-lib: fix non-functioning GIT_TEST_MAINT_SCHEDULER fallback

 The test script had an incomplete and ineffective attempt to avoid
 clobbering the testing user's real crontab (and its equivalents),
 which has been completed.

 Will merge to 'master'.
 source: <20240329222703.9343-1-ericsunshine@charter.net>


* gt/add-u-commit-i-pathspec-check (2024-04-03) 3 commits
 - builtin/add: error out when passing untracked path with -u
 - builtin/commit: error out when passing untracked path with -i
 - revision: optionally record matches with pathspec elements

 "git add -u <pathspec>" and "git commit [-i] <pathspec>" did not
 diagnose a pathspec element that did not match any files in certain
 situations, unlike "git add <pathspec>" did.

 Will merge to 'next'?
 source: <20240402213640.139682-2-shyamthakkar001@gmail.com>


* jc/advice-sans-trailing-whitespace (2024-03-29) 1 commit
  (merged to 'next' on 2024-04-02 at 3cb0fda1bf)
 + advice: omit trailing whitespace

 The "hint:" messages given by the advice mechanism, when given a
 message with a blank line, left a line with trailing whitespace,
 which has been cleansed.

 Will merge to 'master'.
 source: <xmqq4jcooddp.fsf@gitster.g>


* jt/reftable-geometric-compaction (2024-04-03) 2 commits
 . reftable/stack: use geometric table compaction
 . reftable/stack: add env to disable autocompaction

 The strategy to compat multiple tables of reftables after many
 operations accumulate many entries has been improved to avoid
 accumulating too many tables uncollected.

 Expecting a reroll.
 cf. <b24jjzw72rlcpctteokr5yfbuwuy2cc3qvibzhuju4gbj63lfa@gbtsmvufyuhd>
 source: <pull.1683.v4.git.1712103636.gitgitgadget@gmail.com>


* ds/typofix-core-config-doc (2024-03-31) 1 commit
  (merged to 'next' on 2024-04-02 at 79496fcfc4)
 + config: fix some small capitalization issues, as spotted

 Typofix.

 Will merge to 'master'.
 source: <26135b06c48565ee8ac6dcfc1ef5431511e6202c.1711918168.git.dsimic@manjaro.org>


* jc/checkout-detach-wo-tracking-report (2024-03-30) 1 commit
 - checkout: omit "tracking" information on a detached HEAD

 "git checkout/switch --detach foo", after switching to the detached
 HEAD state, gave the tracking information for the 'foo' branch,
 which was pointless.

 Will merge to 'next'?
 source: <xmqqa5mfl7ud.fsf@gitster.g>


* rj/use-adv-if-enabled (2024-03-30) 3 commits
  (merged to 'next' on 2024-04-02 at 31d4453035)
 + add: use advise_if_enabled for ADVICE_ADD_EMBEDDED_REPO
 + add: use advise_if_enabled for ADVICE_ADD_EMPTY_PATHSPEC
 + add: use advise_if_enabled for ADVICE_ADD_IGNORED_FILE

 Use advice_if_enabled() API to rewrite a simple pattern to
 call advise() after checking advice_enabled().

 Will merge to 'master'.
 source: <46fba030-d7aa-49d2-88fa-e506850f7b6a@gmail.com>


* rs/mem-pool-size-t-safety (2024-03-31) 1 commit
  (merged to 'next' on 2024-04-02 at 3517d48210)
 + mem-pool: use st_add() in mem_pool_strvfmt()

 size_t arithmetic safety.

 Will merge to 'master'.
 source: <bbe00b9e-64d8-4ec8-a2b9-2c6917c72dbd@web.de>


* ew/khash-to-khashl (2024-03-28) 3 commits
 - khashl: fix ensemble lookups on empty table
 - treewide: switch to khashl for memory savings
 - list-objects-filter: use kh_size API

 The hashtable library "khash.h" has been replaced with "khashl.h"
 that has better memory usage characteristics.

 Needs review.
 source: <20240328101356.300374-1-e@80x24.org>


* ps/reftable-block-iteration-optim (2024-03-27) 9 commits
 - reftable/block: reuse `zstream` state on inflation
 - reftable/block: open-code call to `uncompress2()`
 - reftable/block: reuse uncompressed blocks
 - reftable/reader: iterate to next block in place
 - reftable/block: move ownership of block reader into `struct table_iter`
 - reftable/block: introduce `block_reader_release()`
 - reftable/block: better grouping of functions
 - reftable/block: merge `block_iter_seek()` and `block_reader_seek()`
 - reftable/block: rename `block_reader_start()`

 The code to iterate over reftable blocks has seen some optimization
 to reduce memory allocation and deallocation.

 Needs review.
 source: <cover.1711519925.git.ps@pks.im>


* rj/add-p-explicit-reshow (2024-03-29) 2 commits
  (merged to 'next' on 2024-04-02 at 05c7e930af)
 + add-patch: do not print hunks repeatedly
 + add-patch: introduce 'p' in interactive-patch

 "git add -p" and other "interactive hunk selection" UI has learned to
 skip showing the hunk immediately after it has already been shown, and
 an additional action to explicitly ask to reshow the current hunk.

 Will merge to 'master'.
 source: <a9c515fe-6664-4b5d-abca-d88fdd32a883@gmail.com>


* bc/credential-scheme-enhancement (2024-03-27) 12 commits
 . credential: add support for multistage credential rounds
 . t5563: refactor for multi-stage authentication
 . docs: set a limit on credential line length
 . credential: enable state capability
 . credential: add an argument to keep state
 . http: add support for authtype and credential
 . docs: indicate new credential protocol fields
 . credential: gate new fields on capability
 . credential: add a field for pre-encoded credentials
 . http: use new headers for each object request
 . remote-curl: reset headers on new request
 . credential: add an authtype field

 The credential helper protocol, together with the HTTP layer, have
 been enhanced to support authentication schemes different from
 username & password pair, like Bearer and NTLM.

 Expecting a reroll.
 cf. <ZgSQ5o_KyqDaxz1m@tapette.crustytoothpaste.net>
 source: <20240324011301.1553072-1-sandals@crustytoothpaste.net>


* ja/doc-markup-updates (2024-03-29) 5 commits
  (merged to 'next' on 2024-04-02 at 69b015d7ce)
 + doc: git-clone: do not autoreference the manpage in itself
 + doc: git-clone: apply new documentation formatting guidelines
 + doc: git-init: apply new documentation formatting guidelines
 + doc: allow literal and emphasis format in doc vs help tests
 + doc: rework CodingGuidelines with new formatting rules

 Documentation rules has been explicitly described how to mark-up
 literal parts and a few manual pages have been updated as examples.

 Will merge to 'master'.
 source: <pull.1702.v2.git.1711711181.gitgitgadget@gmail.com>


* mg/editorconfig-makefile (2024-03-23) 1 commit
  (merged to 'next' on 2024-04-02 at 907b55579e)
 + editorconfig: add Makefiles to "text files"

 The .editorconfig file has been taught that a Makefile uses HT
 indentation.

 Will merge to 'master'.
 source: <20240322221813.13019-1-mg@max.gautier.name>


* ps/reftable-binsearch-updates (2024-04-03) 7 commits
 - reftable/block: avoid decoding keys when searching restart points
 - reftable/record: extract function to decode key lengths
 - reftable/block: fix error handling when searching restart points
 - reftable/block: refactor binary search over restart points
 - reftable/refname: refactor binary search over refnames
 - reftable/basics: improve `binsearch()` test
 - reftable/basics: fix return type of `binsearch()` to be `size_t`

 Reftable code clean-up and some bugfixes.

 Will merge to 'next'?
 source: <cover.1712123093.git.ps@pks.im>


* tb/pseudo-merge-reachability-bitmap (2024-03-20) 24 commits
 - t/perf: implement performace tests for pseudo-merge bitmaps
 - pseudo-merge: implement support for finding existing merges
 - ewah: `bitmap_equals_ewah()`
 - pack-bitmap: extra trace2 information
 - pack-bitmap.c: use pseudo-merges during traversal
 - t/test-lib-functions.sh: support `--date` in `test_commit_bulk()`
 - pack-bitmap: implement test helpers for pseudo-merge
 - ewah: implement `ewah_bitmap_popcount()`
 - pseudo-merge: implement support for reading pseudo-merge commits
 - pack-bitmap.c: read pseudo-merge extension
 - pseudo-merge: scaffolding for reads
 - pack-bitmap: extract `read_bitmap()` function
 - pack-bitmap-write.c: write pseudo-merge table
 - pack-bitmap-write.c: select pseudo-merge commits
 - pseudo-merge: implement support for selecting pseudo-merge commits
 - pack-bitmap: make `bitmap_writer_push_bitmapped_commit()` public
 - pack-bitmap: implement `bitmap_writer_has_bitmapped_object_id()`
 - pack-bitmap-write: support storing pseudo-merge commits
 - pseudo-merge.ch: initial commit
 - pack-bitmap: move some initialization to `bitmap_writer_init()`
 - pack-bitmap: drop unused `max_bitmaps` parameter
 - ewah: implement `ewah_bitmap_is_subset()`
 - config: repo_config_get_expiry()
 - Documentation/technical: describe pseudo-merge bitmaps format

 The pack-bitmap machinery learned to write pseudo-merge bitmaps,
 which act as imaginary octopus merges covering un-bitmapped
 reference tips. This enhances bitmap coverage, and thus,
 performance, for repositories with many references using bitmaps.

 Expecting a reroll.
 cf. <ZfyxCLpjbaScIdWA@nand.local>
 source: <cover.1710972293.git.me@ttaylorr.com>


* dg/myfirstobjectwalk-updates (2024-03-27) 5 commits
  (merged to 'next' on 2024-04-02 at effa6a98a6)
 + MyFirstObjectWalk: add stderr to pipe processing
 + MyFirstObjectWalk: fix description for counting omitted objects
 + MyFirstObjectWalk: fix filtered object walk
 + MyFirstObjectWalk: fix misspelled "builtins/"
 + MyFirstObjectWalk: use additional arg in config_fn_t

 Update a more recent tutorial doc.

 Will merge to 'master'.
 source: <cover.1711537370.git.dirk@gouders.net>


* jc/apply-parse-diff-git-header-names-fix (2024-03-29) 3 commits
  (merged to 'next' on 2024-04-02 at d1fa726c41)
 + t4126: fix "funny directory name" test on Windows (again)
  (merged to 'next' on 2024-03-28 at a35de15836)
 + t4126: make sure a directory with SP at the end is usable
  (merged to 'next' on 2024-03-27 at d586367985)
 + apply: parse names out of "diff --git" more carefully

 "git apply" failed to extract the filename the patch applied to,
 when the change was about an empty file created in or deleted from
 a directory whose name ends with a SP, which has been corrected.

 Will merge to 'master'.
 source: <xmqqfrwlltjn.fsf@gitster.g>
 source: <xmqqh6gqt674.fsf_-_@gitster.g>
 source: <xmqq5xx50x8p.fsf_-_@gitster.g>


* la/hide-trailer-info (2024-03-16) 7 commits
 - trailer: retire trailer_info_get() from API
 - trailer: make trailer_info struct private
 - trailer: make parse_trailers() return trailer_info pointer
 - interpret-trailers: access trailer_info with new helpers
 - sequencer: use the trailer iterator
 - trailer: teach iterator about non-trailer lines
 - Merge branch 'la/format-trailer-info' into la/hide-trailer-info
 (this branch uses la/format-trailer-info.)

 The trailer API has been reshuffled a bit.

 Needs review.
 source: <pull.1696.git.1710570428.gitgitgadget@gmail.com>


* ps/pack-refs-auto (2024-03-25) 16 commits
  (merged to 'next' on 2024-04-02 at 1d76dc3648)
 + builtin/gc: pack refs when using `git maintenance run --auto`
 + builtin/gc: forward git-gc(1)'s `--auto` flag when packing refs
 + t6500: extract objects with "17" prefix
 + builtin/gc: move `struct maintenance_run_opts`
 + builtin/pack-refs: introduce new "--auto" flag
 + builtin/pack-refs: release allocated memory
 + refs/reftable: expose auto compaction via new flag
 + refs: remove `PACK_REFS_ALL` flag
 + refs: move `struct pack_refs_opts` to where it's used
 + t/helper: drop pack-refs wrapper
 + refs/reftable: print errors on compaction failure
 + reftable/stack: gracefully handle failed auto-compaction due to locks
 + reftable/stack: use error codes when locking fails during compaction
 + reftable/error: discern locked/outdated errors
 + reftable/stack: fix error handling in `reftable_stack_init_addition()`
 + Merge branch 'ps/reftable-stack-tempfile' into ps/pack-refs-auto

 "git pack-refs" learned the "--auto" option, which is a useful
 addition to be triggered from "git gc --auto".

 Acked-by: Karthik Nayak <karthik.188@gmail.com>
 cf. <CAOLa=ZRAEA7rSUoYL0h-2qfEELdbPHbeGpgBJRqesyhHi9Q6WQ@mail.gmail.com>

 Will merge to 'master'.
 source: <cover.1711360631.git.ps@pks.im>


* ds/doc-config-reflow (2024-03-14) 1 commit
 - config.txt: perform some minor reformatting

 Reflow a paragraph in the documentation source without any effect
 to the formatted text.

 Will discard.
 source: <97bdaf075bf5a68554cca1731eca78aff2662907.1710444774.git.dsimic@manjaro.org>


* la/format-trailer-info (2024-03-15) 5 commits
 - trailer: finish formatting unification
 - trailer: begin formatting unification
 - format_trailer_info(): append newline for non-trailer lines
 - format_trailer_info(): drop redundant unfold_value()
 - format_trailer_info(): use trailer_item objects
 (this branch is used by la/hide-trailer-info.)

 The code to format trailers have been cleaned up.

 Comments?
 source: <pull.1694.git.1710485706.gitgitgadget@gmail.com>


* rs/config-comment (2024-03-15) 3 commits
  (merged to 'next' on 2024-03-28 at 83eaadc2b6)
 + config: allow tweaking whitespace between value and comment
 + config: fix --comment formatting
 + config: add --comment option to add a comment

 "git config" learned "--comment=<message>" option to leave a
 comment immediately after the "variable = value" on the same line
 in the configuration file.

 Will merge to 'master'.
 source: <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>


* ie/config-includeif-hostname (2024-03-19) 2 commits
 - config: learn the "hostname:" includeIf condition
 - t: add a test helper for getting hostname

 The conditional inclusion mechanism for configuration files learned
 to switch on the hostname.

 Expecting a reroll.
 cf. <20240319210428.GC1159535@coredump.intra.peff.net>
 cf. <20240320001934.GA903718@coredump.intra.peff.net>
 source: <20240319183722.211300-1-ignacio@iencinas.com>


* jk/core-comment-string (2024-03-27) 17 commits
  (merged to 'next' on 2024-03-28 at fbf8eb9331)
 + config: add core.commentString
 + config: allow multi-byte core.commentChar
 + environment: drop comment_line_char compatibility macro
 + wt-status: drop custom comment-char stringification
 + sequencer: handle multi-byte comment characters when writing todo list
 + find multi-byte comment chars in unterminated buffers
 + find multi-byte comment chars in NUL-terminated strings
 + prefer comment_line_str to comment_line_char for printing
 + strbuf: accept a comment string for strbuf_add_commented_lines()
 + strbuf: accept a comment string for strbuf_commented_addf()
 + strbuf: accept a comment string for strbuf_stripspace()
 + environment: store comment_line_char as a string
 + strbuf: avoid shadowing global comment_line_char name
 + commit: refactor base-case of adjust_comment_line_char()
 + strbuf: avoid static variables in strbuf_add_commented_lines()
 + strbuf: simplify comment-handling in add_lines() helper
 + config: forbid newline as core.commentChar

 core.commentChar used to be limited to a single byte, but has been
 updated to allow an arbitrary multi-byte sequence.

 Will merge to 'master'.
 source: <20240312091013.GA95442@coredump.intra.peff.net>
 source: <20240327081922.GA830163@coredump.intra.peff.net>


* js/build-fuzz-more-often (2024-03-05) 3 commits
 - SQUASH???
 - fuzz: link fuzz programs with `make all` on Linux
 - ci: also define CXX environment variable

 In addition to building the objects needed, try to link the objects
 that are used in fuzzer tests, to make sure at least they build
 without bitrot, in Linux CI runs.

 Stalled.
 cf. <xmqq1q7w8xx6.fsf@gitster.g>
 source: <cover.1709673020.git.steadmon@google.com>


* sj/userdiff-c-sharp (2024-04-03) 1 commit
 - userdiff: better method/property matching for C#

 The userdiff patterns for C# has been updated.

 Will merge to 'next'?
 source: <pull.1682.v5.git.git.1712180564927.gitgitgadget@gmail.com>


* cw/git-std-lib (2024-02-28) 4 commits
 - SQUASH??? get rid of apparent debugging crufts
 - test-stdlib: show that git-std-lib is independent
 - git-std-lib: introduce Git Standard Library
 - pager: include stdint.h because uintmax_t is used

 Split libgit.a out to a separate git-std-lib tor easier reuse.

 Expecting a reroll.
 source: <cover.1696021277.git.jonathantanmy@google.com>


* js/cmake-with-test-tool (2024-02-23) 2 commits
 - cmake: let `test-tool` run the unit tests, too
 - Merge branch 'js/unit-test-suite-runner' into js/cmake-with-test-tool
 (this branch uses js/unit-test-suite-runner.)

 "test-tool" is now built in CMake build to also run the unit tests.

 May want to roll it into the base topic.
 source: <pull.1666.git.1708038924522.gitgitgadget@gmail.com>


* js/unit-test-suite-runner (2024-02-23) 8 commits
 - ci: use test-tool as unit test runner on Windows
 - t/Makefile: run unit tests alongside shell tests
 - unit tests: add rule for running with test-tool
 - test-tool run-command testsuite: support unit tests
 - test-tool run-command testsuite: remove hardcoded filter
 - test-tool run-command testsuite: get shell from env
 - t0080: turn t-basic unit test into a helper
 - Merge branch 'jk/unit-tests-buildfix' into js/unit-test-suite-runner
 (this branch is used by js/cmake-with-test-tool.)

 The "test-tool" has been taught to run testsuite tests in parallel,
 bypassing the need to use the "prove" tool.

 Needs review.
 source: <cover.1708728717.git.steadmon@google.com>


* bk/complete-dirname-for-am-and-format-patch (2024-01-12) 1 commit
 - completion: dir-type optargs for am, format-patch

 Command line completion support (in contrib/) has been
 updated for a few commands to complete directory names where a
 directory name is expected.

 Expecting a reroll.
 cf. <40c3a824-a961-490b-94d4-4eb23c8f713d@gmail.com>
 cf. <6683f24e-7e56-489d-be2d-8afe1fc38d2b@gmail.com>
 source: <d37781c3-6af2-409b-95a8-660a9b92d20b@smtp-relay.sendinblue.com>


* bk/complete-send-email (2024-01-12) 1 commit
 - completion: don't complete revs when --no-format-patch

 Command line completion support (in contrib/) has been taught to
 avoid offering revision names as candidates to "git send-email" when
 the command is used to send pre-generated files.

 Expecting a reroll.
 cf. <CAC4O8c88Z3ZqxH2VVaNPpEGB3moL5dJcg3cOWuLWwQ_hLrJMtA@mail.gmail.com>
 source: <a718b5ee-afb0-44bd-a299-3208fac43506@smtp-relay.sendinblue.com>


* tb/path-filter-fix (2024-01-31) 16 commits
 - bloom: introduce `deinit_bloom_filters()`
 - commit-graph: reuse existing Bloom filters where possible
 - object.h: fix mis-aligned flag bits table
 - commit-graph: new Bloom filter version that fixes murmur3
 - commit-graph: unconditionally load Bloom filters
 - bloom: prepare to discard incompatible Bloom filters
 - bloom: annotate filters with hash version
 - repo-settings: introduce commitgraph.changedPathsVersion
 - t4216: test changed path filters with high bit paths
 - t/helper/test-read-graph: implement `bloom-filters` mode
 - bloom.h: make `load_bloom_filter_from_graph()` public
 - t/helper/test-read-graph.c: extract `dump_graph_info()`
 - gitformat-commit-graph: describe version 2 of BDAT
 - commit-graph: ensure Bloom filters are read with consistent settings
 - revision.c: consult Bloom filters for root commits
 - t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`

 The Bloom filter used for path limited history traversal was broken
 on systems whose "char" is unsigned; update the implementation and
 bump the format version to 2.

 Waiting for a final ack?
 cf. <ZcFjkfbsBfk7JQIH@nand.local>
 source: <cover.1706741516.git.me@ttaylorr.com>


* jc/rerere-cleanup (2023-08-25) 4 commits
 - rerere: modernize use of empty strbuf
 - rerere: try_merge() should use LL_MERGE_ERROR when it means an error
 - rerere: fix comment on handle_file() helper
 - rerere: simplify check_one_conflict() helper function

 Code clean-up.

 Not ready to be reviewed yet.
 source: <20230824205456.1231371-1-gitster@pobox.com>
