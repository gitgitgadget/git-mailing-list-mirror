From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Apr 2011, #04; Tue, 12)
Date: Tue, 12 Apr 2011 15:43:26 -0700
Message-ID: <7vaafvnl9t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 00:43:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9mJ7-0001RL-Vd
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 00:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838Ab1DLWng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 18:43:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45133 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810Ab1DLWne (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 18:43:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 857B9569C;
	Tue, 12 Apr 2011 18:45:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=P
	9n4adovjAZltIK8QMHLTfEaZp4=; b=adk30JLXE2D5g1oJHjpSu9iwNy4n1GKWE
	QOePfteSgfwXiOP5djmFflveUgmgYEaxJFyJaZ0G1Qml956ZPDYmW6MzMi84puU+
	oQ1V3I2csSm2PHRtaKq0v+coMt3ZXCof7zMWh9cSf4r11eQ/09H54FKoU9cJu/LO
	iYB1xROF1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=KCn
	7Z8K3AiwXWx7mN/3xi0LWoPq5yg/W+Km34y9a0O242vs9cwTZmuLD8nQcDeqzz3v
	tehqxPSK03ELqM9Dx9Chd71LsoYKRsSdl11Ru8A71xlOV7yF8evv4miXAnmvO3T4
	ZxeYoJhMaVnYeJmnAxb1ttBEPeIqBODHHPTrabHY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 73E65569B;
	Tue, 12 Apr 2011 18:45:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0E218569A; Tue, 12 Apr 2011
 18:45:25 -0400 (EDT)
X-master-at: 9db19414582fdb154384ff1ca457cbf9095fef48
X-next-at: d93e7e3f2508f46a0fb8be7796d959f6c18e83bb
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 904E851C-6556-11E0-B072-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171424>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

As we are already in pre-release feature freeze, some of the trivially
correct features and fixes to non-regression bugs are only queued to
'next' but not in 'master'.  They are marked as post 1.7.5 candidates in
this list.

--------------------------------------------------
[New Topics]

* ef/maint-strbuf-init (2011-04-10) 2 commits
  (merged to 'next' on 2011-04-11 at 1dd34d9)
 + config: support values longer than 1023 bytes
 + strbuf: make sure buffer is zero-terminated

Should graduate soon after 1.7.5 ships and merged to 1.7.4.X and 1.7.5.1
release.

* jh/dirstat (2011-04-12) 4 commits
  (merged to 'next' on 2011-04-12 at dd2c308)
 + --dirstat: In case of renames, use target filename instead of source filename
  (merged to 'next' on 2011-04-11 at 33d0417)
 + Teach --dirstat not to completely ignore rearranged lines within a file
 + --dirstat-by-file: Make it faster and more correct
 + --dirstat: Describe non-obvious differences relative to --stat or regular diff

Should graduate soon after 1.7.5 ships and merged to 1.7.4.X and 1.7.5.1
releases.

* jm/mergetool-submodules (2011-04-08) 1 commit
 - mergetool: Teach about submodules

Looked sane if inefficient when both branches have the submodule but was
dubious in delete/modify conflict case. Awaiting response and possibly a
reroll.

* rj/sparse (2011-04-07) 7 commits
 - sparse: Fix some "symbol not declared" warnings
 - sparse: Fix errors due to missing target-specific variables
 - sparse: Fix an "symbol 'merge_file' not decared" warning
 - sparse: Fix an "symbol 'format_subject' not declared" warning
 - sparse: Fix some "Using plain integer as NULL pointer" warnings
 - sparse: Fix an "symbol 'cmd_index_pack' not declared" warning
 - Makefile: Use cgcc rather than sparse in the check target

* ab/i18n-fixup (2011-04-12) 8 commits
  (merged to 'next' on 2011-04-12 at a94aa85)
 + i18n: do not overuse C_LOCALE_OUTPUT
 + i18n: mark init-db messages for translation
 + i18n: mark checkout plural warning for translation
 + i18n: mark checkout --detach messages for translation
 + i18n: mark clone nonexistent repository message for translation
 + i18n: mark merge CHERRY_PICK_HEAD messages for translation
 + i18n: mark merge "upstream" messages for translation
 + i18n: mark merge "Could not read from" message for translation

It would be nice to have this before 1.7.5 final; even if we didn't, we
would have to force people to build on top of this, not on 1.7.5, which
would essentially mean that we would commit to this series anyway.

* cn/format-patch-quiet (2011-04-12) 2 commits
  (merged to 'next' on 2011-04-12 at 915a915)
 + format-patch: document --quiet option
 + format-patch: don't pass on the --quiet flag

Should graduate soon after 1.7.5 ships and merged to 1.7.4.X and 1.7.5.1
release.

--------------------------------------------------
[Stalled]

* jc/maint-add-p-overlapping-hunks (2011-04-06) 2 commits
 - "add -p": work-around an old laziness that does not coalesce hunks
 - add--interactive.perl: factor out repeated --recount option

This came from http://thread.gmane.org/gmane.comp.version-control.git/170685/focus=171000;
we may want to add tests before moving it forward.

* jh/gitweb-localtime (2011-03-23) 1 commit
 - gitweb: javascript ability to adjust time based on timezone

Re-roll posted on the list, but I haven't picked it up.

* mg/show-without-prune (2011-04-01) 1 commit
 - builtin/show: do not prune by pathspec
 (this branch uses mg/reflog-with-options.)

I wanted to like this, but it still feels like too much magic.

* gr/cvsimport-alternative-cvspass-location (2011-02-18) 1 commit
 - Look for password in both CVS and CVSNT password files.

It seems that we need separate parsers for these two formats in order not
to regress the users of the original cvs.

* jc/index-pack (2011-02-25) 5 commits
 - index-pack --verify: read anomalous offsets from v2 idx file
 - write_idx_file: need_large_offset() helper function
 - index-pack: --verify
 - write_idx_file: introduce a struct to hold idx customization options
 - index-pack: group the delta-base array entries also by type

Still a WIP, and will not be ready for 1.7.5. Need to put histogram output
into index-pack --verify to really kill verify-pack.

* jk/tag-contains (2010-07-05) 4 commits
 - Why is "git tag --contains" so slow?
 - default core.clockskew variable to one day
 - limit "contains" traversals based on commit timestamp
 - tag: speed up --contains calculation

The idea of the bottom one is probably Ok, except that the use of object
flags needs to be rethought, or at least the helper needs to be moved to
builtin/tag.c to make it clear that it should not be used outside the
current usage context.

--------------------------------------------------
[Cooking]

* dm/stash-k-i-p (2011-04-07) 2 commits
  (merged to 'next' on 2011-04-11 at 8349531)
 + stash: ensure --no-keep-index and --patch can be used in any order
 + stash: add two more tests for --no-keep-index

Should graduate soon after 1.7.5 ships and merged to 1.7.4.X and 1.7.5.1
releases.

* jc/magic-pathspec (2011-04-06) 3 commits
  (merged to 'next' on 2011-04-08 at c5247ce)
 + magic pathspec: add ":(icase)path" to match case insensitively
 + magic pathspec: futureproof shorthand form
 + magic pathspec: add tentative ":/path/from/top/level" pathspec support
 (this branch is tangled with jc/add-u-migration-2.)

Thanks to Peff, Duy, and Michael for helping to whip the syntax and
the basic semantics into a not-so-horrible shape.  Will not merge until
the 1.7.5 ships, though.

* jc/merge-dash-previous (2011-04-07) 1 commit
  (merged to 'next' on 2011-04-11 at 06480d1)
 + merge: allow "-" as a short-hand for "previous branch"

Should graduate soon after 1.7.5 ships.

* rr/doc-content-type (2011-04-07) 4 commits
  (merged to 'next' on 2011-04-11 at dca8914)
 + Documentation: Allow custom diff tools to be specified in 'diff.tool'
 + Documentation: Add diff.<driver>.* to config
 + Documentation: Move diff.<driver>.* from config.txt to diff-config.txt
 + Documentation: Add filter.<driver>.* to config

Is everybody happy with the new wording?

Should graduate soon after 1.7.5 ships and merged to 1.7.4.X and 1.7.5.1
releases.

* dm/http-cleanup (2011-03-30) 2 commits
 - http-push: refactor curl_easy_setup madness
 - http: make curl callbacks match contracts from curl header

I didn't see anything glaringly wrong with this, but I would appreciate
extra sets of eyeballs from people who have worked on HTTP transports to
double check.

* jc/pack-objects-bigfile (2011-04-05) 1 commit
  (merged to 'next' on 2011-04-11 at 86c52b1)
 + Teach core.bigfilethreashold to pack-objects

Should graduate soon after 1.7.5 ships and merged to 1.7.4.X and 1.7.5.1
releases.

* jk/maint-stash-oob (2011-04-06) 2 commits
  (merged to 'next' on 2011-04-11 at d882935)
 + stash: fix false positive in the invalid ref test.
 + stash: fix accidental apply of non-existent stashes

Should graduate soon after 1.7.5 ships and merged to 1.7.4.X and 1.7.5.1
releases.

* nk/blame-abbrev (2011-04-06) 1 commit
  (merged to 'next' on 2011-04-11 at 19e8676)
 + blame: add --abbrev command line option and make it honor core.abbrev

Should graduate soon after 1.7.5 ships.

* nm/submodule-update-force (2011-04-01) 1 commit
  (merged to 'next' on 2011-04-11 at d94f6f3)
 + submodule: Add --force option for git submodule update

Are submodule users happy with this change?

Should graduate soon after 1.7.5 ships.

* jk/maint-upload-pack-shallow (2011-04-06) 1 commit
  (merged to 'next' on 2011-04-11 at 9104545)
 + upload-pack: start pack-objects before async rev-list

A sensible and low-impact fix.  Should graduate soon after 1.7.5 ships
and merged to 1.7.4.X and 1.7.5.1 releases.

* jk/stash-loosen-safety (2011-04-05) 1 commit
  (merged to 'next' on 2011-04-11 at b59c533)
 + stash: drop dirty worktree check on apply

Should graduate soon after 1.7.5 ships.

* dm/color-palette (2011-04-05) 1 commit
  (merged to 'next' on 2011-04-04 at 0244ef9)
 + Share color list between graph and show-branch

Should graduate soon after 1.7.5 ships.

* mg/sha1-path-advise (2011-03-31) 2 commits
  (merged to 'next' on 2011-04-04 at e429e0c)
 + sha1_name: Suggest commit:./file for path in subdir
 + t1506: factor out test for "Did you mean..."

Should graduate soon after 1.7.5 ships and merged to 1.7.5.1 release.

* ar/clean-rmdir-empty (2011-04-01) 1 commit
  (merged to 'next' on 2011-04-03 at c63fac8)
 + clean: unreadable directory may still be rmdir-able if it is empty

Should graduate soon after 1.7.5 ships and merged to 1.7.4.X and 1.7.5.1
releases.

* jk/maint-push-async-hang (2011-03-31) 4 commits
 - send-pack: abort sideband demuxer on pack-objects error
 - run-command: allow aborting async code prematurely
 - finish_async: be quiet when waiting for async process
 - teach wait_or_whine a "quiet" mode
 (this branch is used by jk/maint-push-async-hang-threads.)

* jk/maint-push-async-hang-threads (2011-03-31) 2 commits
 - run-command: implement abort_async for pthreads
 - Merge branch 'jk/maint-push-async-hang' into jk/maint-push-async-hang-threads
 (this branch uses jk/maint-push-async-hang.)

These two series aim for a good goal, but needs reroll after 1.7.5 with
sign-offs.

* mg/reflog-with-options (2011-04-01) 3 commits
  (merged to 'next' on 2011-04-03 at e69a95c)
 + reflog: fix overriding of command line options
 + t/t1411: test reflog with formats
 + builtin/log.c: separate default and setup of cmd_log_init()
 (this branch is used by mg/show-without-prune.)

Should graduate soon after 1.7.5 ships and merged to 1.7.5.1 release.

* mh/git-svn-automkdirs (2011-04-01) 1 commit
  (merged to 'next' on 2011-04-03 at 7fa4978)
 + git-svn: add an option to skip the creation of empty directories

Should be safe, but I'd like an Ack from git-svn folks.

* jc/diff-irreversible-delete (2011-02-28) 1 commit
  (merged to 'next' on 2011-04-03 at 5a23b23)
 + git diff -D: omit the preimage of deletes

Should graduate soon after 1.7.5 ships.

* jh/notes-add-ui (2011-03-30) 1 commit
  (merged to 'next' on 2011-04-11 at 72e7c39)
 + Make "git notes add" more user-friendly when there are existing notes

Should graduate soon after 1.7.5 ships and merged to 1.7.5.1 release.

* jk/notes-ui-updates (2011-03-30) 7 commits
  (merged to 'next' on 2011-04-11 at 313d6c4)
 + log/pretty-options: Document --[no-]notes and deprecate old notes options
 + revision.c: make --no-notes reset --notes list
 + revision.c: support --notes command-line option
 + notes: refactor display notes default handling
 + notes: refactor display notes extra refs field
 + revision.c: refactor notes ref expansion
 + notes: make expand_notes_ref globally accessible

Should graduate soon after 1.7.5 ships.

* nd/maint-setup (2011-03-26) 2 commits
  (merged to 'next' on 2011-03-31 at 2c36f6a)
 + Kill off get_relative_cwd()
 + setup: return correct prefix if worktree is '/'

This benefits only the minority who use /.git at the root level of the
filesystem, but the changed code is used from many codepaths.

Should graduate soon after 1.7.5 ships and merged to 1.7.5.1 release.

* mz/rebase (2011-02-28) 34 commits
  (merged to 'next' on 2011-03-31 at 3b1343c)
 + rebase: define options in OPTIONS_SPEC
  (merged to 'next' on 2011-02-25 at 52caa7a)
 + Makefile: do not install sourced rebase scripts
  (merged to 'next' on 2011-02-22 at 3219155)
 + rebase: use @{upstream} if no upstream specified
 + rebase -i: remove unnecessary state rebase-root
 + rebase -i: don't read unused variable preserve_merges
 + git-rebase--am: remove unnecessary --3way option
 + rebase -m: don't print exit code 2 when merge fails
 + rebase -m: remember allow_rerere_autoupdate option
 + rebase: remember strategy and strategy options
 + rebase: remember verbose option
 + rebase: extract code for writing basic state
 + rebase: factor out sub command handling
 + rebase: make -v a tiny bit more verbose
 + rebase -i: align variable names
 + rebase: show consistent conflict resolution hint
 + rebase: extract am code to new source file
 + rebase: extract merge code to new source file
 + rebase: remove $branch as synonym for $orig_head
 + rebase -i: support --stat
 + rebase: factor out call to pre-rebase hook
 + rebase: factor out clean work tree check
 + rebase: factor out reference parsing
 + rebase: reorder validation steps
 + rebase -i: remove now unnecessary directory checks
 + rebase: factor out command line option processing
 + rebase: align variable content
 + rebase: align variable names
 + rebase: stricter check of standalone sub command
 + rebase: act on command line outside parsing loop
 + rebase: improve detection of rebase in progress
 + rebase: remove unused rebase state 'prev_head'
 + rebase: read state outside loop
 + rebase: refactor reading of state
 + rebase: clearer names for directory variables

I wanted to wait for an independent Ack or two for the tip one, which was
a response to regression concerns raised by J6t, but ended up merging it
to 'next' after giving another look.  Will not merge before 1.7.5, as
there is no user visible improvements up to this point.

* jk/maint-merge-rename-create (2011-03-25) 3 commits
  (merged to 'next' on 2011-03-31 at b9bc9f1)
 + merge: turn on rewrite detection
 + merge: handle renames with replacement content
 + t3030: fix accidental success in symlink rename

Peff wanted to reroll this.

* mz/maint-rename-unmerged (2011-03-23) 1 commit
  (merged to 'next' on 2011-03-31 at c7b3d9a)
 + diffcore-rename: don't consider unmerged path as source

Will cook until 1.7.5 final.

* nd/struct-pathspec (2011-04-05) 5 commits
  (merged to 'next' on 2011-04-11 at ee794a5)
 + pathspec: rename per-item field has_wildcard to use_wildcard
  (merged to 'next' on 2011-03-31 at 66cbb7d)
 + Improve tree_entry_interesting() handling code
 + Convert read_tree{,_recursive} to support struct pathspec
 + Reimplement read_tree_recursive() using tree_entry_interesting()
 + Merge branch 'en/object-list-with-pathspec' into 'nd/struct-pathspec'

Will cook until 1.7.5 final.

* jc/rename-degrade-cc-to-c (2011-01-06) 4 commits
  (merged to 'next' on 2011-03-31 at 8d685d7)
 + diffcore-rename: fall back to -C when -C -C busts the rename limit
 + diffcore-rename: record filepair for rename src
 + diffcore-rename: refactor "too many candidates" logic
 + builtin/diff.c: remove duplicated call to diff_result_code()

Should graduate soon after 1.7.5 ships.

* cn/system-path-tweak (2011-03-17) 1 commit
 - system_path: use a static buffer

Don't see much point in this itself. Probably will drop.

* en/merge-recursive (2011-03-17) 4 commits
  (merged to 'next' on 2011-03-18 at a32016b)
 + merge-recursive: tweak magic band-aid
  (merged to 'next' on 2011-03-09 at 3762932)
 + merge-recursive: When we detect we can skip an update, actually skip it
 + t6022: New test checking for unnecessary updates of files in D/F conflicts
 + t6022: New test checking for unnecessary updates of renamed+modified files

I am not happy with these magic band aids.  Will hold.

--------------------------------------------------
[Discarded]

* jc/add-u-migration (2011-03-22) 3 commits
 . add: make "add -u/-A" update full tree without pathspec (step 3)
 . add: make "add -u/-A" update full tree without pathspec (step 2)
  (merged to 'next' on 2011-03-31 at 962e058)
 + add: make "add -u/-A" update full tree without pathspec
 (this branch is tangled with jc/add-u-migration-2.)

* jc/add-u-migration-2 (2011-04-08) 5 commits
  (merged to 'next' on 2011-04-08 at 524e365)
 + Revert "add -u" default change plans
  (merged to 'next' on 2011-04-06 at 4a6bb82)
 + add -u: get rid of "treewideupdate" configuration
 + Merge branch 'jc/magic-pathspec' into early parts of jc/add-u-migration
 + magic pathspec: add tentative ":/path/from/top/level" pathspec support
  (merged to 'next' on 2011-03-31 at 962e058)
 + add: make "add -u/-A" update full tree without pathspec
 (this branch is tangled with jc/add-u-migration and jc/magic-pathspec.)

These attempt "add -u" migration plans (two versions), but then revert
both of them at the end where they are merged to 'next'.
