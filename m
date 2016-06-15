From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Apr 2011, #01; Sun, 3)
Date: Sun, 03 Apr 2011 16:21:07 -0700
Message-ID: <7v62quc464.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 04 01:21:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6Wbk-0005Oj-51
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 01:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077Ab1DCXVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 19:21:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65032 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab1DCXVR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 19:21:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BB7C857FC;
	Sun,  3 Apr 2011 19:23:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=h
	lQAAkxGyBrIDPRODty2DuynncE=; b=VgSS5pqOq9/AdYR1DbWbHwOa23slu2HdK
	WrKuNPDfnbe4OVMbw2d4aTwjEG72DP8qxUSq+S4Qn41sdRKHcm8stgSKqrHA3KS6
	937YtcmxvgnP778JDHLcyA+JxL9df+oRTQB2BGu/8mGWUlIsuq+FV2iwuv2Re3d7
	LGQ3M9bMIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=x47
	OHp3ntop2TneKERC9fpLfEO7kJqqsd0E9Pb5o8hthXpanPQnbf3BJiB9f5BNTJGY
	IL88ZBCcxqGMxtv4ESJ0K6YCdXsENr/M13ChkWpFh8d0/6sljrIyaIGGOwu0dbE2
	CC4+qGOLlON02CD3y4XBLH/njXd1OEYi1xHOMMKk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A26F157FB;
	Sun,  3 Apr 2011 19:23:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 48A2A57FA; Sun,  3 Apr 2011
 19:23:00 -0400 (EDT)
X-master-at: 44bc573436c98b7c6cd798af04c538f6e76f0f6e
X-next-at: c63fac87daebf1437e8dc8c7ead5a4c7cadf15e0
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 52300878-5E49-11E0-AA1A-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170792>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

Hopefully we will have 1.7.5-rc1 coming Wednesday.

--------------------------------------------------
[New Topics]

* ar/clean-rmdir-empty (2011-04-01) 1 commit
  (merged to 'next' on 2011-04-03 at c63fac8)
 + clean: unreadable directory may still be rmdir-able if it is empty

This should be very safe and Ok to merge before -rc1; it is not urgent,
though.

* jc/rev-list-options-fix (2011-04-01) 1 commit
  (merged to 'next' on 2011-04-03 at 91f19de)
 + "log --cherry-pick" documentation regression fix

We should merge this before -rc1, but there might be other similar
breakages in the text flow due to the same f98fd43 (git-log.txt,
rev-list-options.txt: put option blocks in proper order, 2011-03-08).

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

* mg/doc-revisions-txt (2011-04-01) 3 commits
 - revisions.txt: language improvements
 - revisions.txt: structure with a labelled list
 - revisions.txt: consistent use of quotes

Most parts looked reasonable except for some nits.

* mg/reflog-with-options (2011-04-01) 3 commits
  (merged to 'next' on 2011-04-03 at e69a95c)
 + reflog: fix overriding of command line options
 + t/t1411: test reflog with formats
 + builtin/log.c: separate default and setup of cmd_log_init()
 (this branch is used by mg/show-without-prune.)

Reasonable, but can wait.

* mg/show-without-prune (2011-04-01) 1 commit
 - builtin/show: do not prune by pathspec
 (this branch uses mg/reflog-with-options.)

I wanted to like this, but it still feels like too much magic.

* mh/git-svn-automkdirs (2011-04-01) 1 commit
  (merged to 'next' on 2011-04-03 at 7fa4978)
 + git-svn: add an option to skip the creation of empty directories

Should be safe, but I'd like an Ack from git-svn folks.

* nm/maint-conflicted-submodule-entries (2011-03-30) 1 commit
  (merged to 'next' on 2011-04-03 at 40c5094)
 + submodule: process conflicting submodules only once

A fix to a rather common operation and the implementation looked
low-impact enough.  Do submodule people want this in 1.7.5?

* dm/color-palette (2011-03-30) 1 commit
 - Share color list between graph and show-branch

* mg/sha1-path-advise (2011-03-31) 2 commits
 - sha1_name: Suggest commit:./file for path in subdir
 - t1506: factor out test for "Did you mean..."

--------------------------------------------------
[Graduated to "master"]

* ab/i18n-st (2011-02-22) 69 commits
  (merged to 'next' on 2011-03-23 at e2732e2)
 + i18n: git-shortlog basic messages
 + i18n: git-revert split up "could not revert/apply" message
 + i18n: git-revert literal "me" messages
 + i18n: git-revert "Your local changes" message
 + i18n: git-revert basic messages
 + i18n: git-notes GIT_NOTES_REWRITE_MODE error message
 + i18n: git-notes basic commands
 + i18n: git-gc "Auto packing the repository" message
 + i18n: git-gc basic messages
 + i18n: git-describe basic messages
 + i18n: git-clean clean.requireForce messages
 + i18n: git-clean basic messages
 + i18n: git-bundle basic messages
 + i18n: git-archive basic messages
 + i18n: git-status "renamed: " message
 + i18n: git-status "Initial commit" message
 + i18n: git-status "Changes to be committed" message
 + i18n: git-status shortstatus messages
 + i18n: git-status "nothing to commit" messages
 + i18n: git-status basic messages
 + i18n: git-push "prevent you from losing" message
 + i18n: git-push basic messages
 + i18n: git-tag tag_template message
 + i18n: git-tag basic messages
 + i18n: git-reset "Unstaged changes after reset" message
 + i18n: git-reset reset_type_names messages
 + i18n: git-reset basic messages
 + i18n: git-rm basic messages
 + i18n: git-mv "bad" messages
 + i18n: git-mv basic messages
 + i18n: git-merge "Wonderful" message
 + i18n: git-merge "You have not concluded your merge" messages
 + i18n: git-merge "Updating %s..%s" message
 + i18n: git-merge basic messages
 + i18n: git-log "--OPT does not make sense" messages
 + i18n: git-log basic messages
 + i18n: git-grep "--open-files-in-pager" message
 + i18n: git-grep basic messages
 + i18n: git-fetch split up "(non-fast-forward)" message
 + i18n: git-fetch update_local_ref messages
 + i18n: git-fetch formatting messages
 + i18n: git-fetch basic messages
 + i18n: git-diff basic messages
 + i18n: git-commit advice messages
 + i18n: git-commit "enter the commit message" message
 + i18n: git-commit print_summary messages
 + i18n: git-commit formatting messages
 + i18n: git-commit "middle of a merge" message
 + i18n: git-commit basic messages
 + i18n: git-checkout "Switched to a .. branch" message
 + i18n: git-checkout "HEAD is now at" message
 + i18n: git-checkout describe_detached_head messages
 + i18n: git-checkout: our/their version message
 + i18n: git-checkout basic messages
 + i18n: git-branch "(no branch)" message
 + i18n: git-branch "git branch -v" messages
 + i18n: git-branch "Deleted branch [...]" message
 + i18n: git-branch "remote branch '%s' not found" message
 + i18n: git-branch basic messages
 + i18n: git-add "Unstaged changes" message
 + i18n: git-add "remove '%s'" message
 + i18n: git-add "did not match any files" message
 + i18n: git-add "The following paths are ignored" message
 + i18n: git-add basic messages
 + i18n: git-clone "Cloning into" message
 + i18n: git-clone "Cloning into" message
 + i18n: git-clone basic messages
 + i18n: git-init "Initialized [...] repository" message
 + i18n: git-init basic messages

* jc/merge-sans-branch (2011-03-23) 2 commits
  (merged to 'next' on 2011-03-31 at 754a6af)
 + merge: merge with the default upstream branch without argument
 + merge: match the help text with the documentation

* jk/pull-into-empty (2011-03-25) 2 commits
  (merged to 'next' on 2011-03-31 at d4dd598)
 + pull: do not clobber untracked files on initial pull
 + merge: merge unborn index before setting ref

* jr/grep-en-config (2011-03-30) 1 commit
  (merged to 'next' on 2011-03-31 at 2a73028)
 + grep: allow -E and -n to be turned on by default via configuration

* nd/init-gitdir (2011-03-19) 2 commits
  (merged to 'next' on 2011-03-31 at 3b8fb40)
 + init, clone: support --separate-git-dir for .git file
 + git-init.txt: move description section up

* sb/sparse-more (2011-03-21) 1 commit
  (merged to 'next' on 2011-03-23 at 4bec1d1)
 + Makefile: Cover more files with make check

--------------------------------------------------
[Stalled]

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

* jc/diff-irreversible-delete (2011-02-28) 1 commit
  (merged to 'next' on 2011-04-03 at 5a23b23)
 + git diff -D: omit the preimage of deletes

Unstuck, thanks to Michael J Gruber.

* jh/notes-add-ui (2011-03-30) 1 commit
 - Make "git notes add" more user-friendly when there are existing notes

* jk/maint-remote-mirror-safer (2011-03-30) 3 commits
  (merged to 'next' on 2011-04-03 at ccc9c1a)
 + remote: deprecate --mirror
 + remote: separate the concept of push and fetch mirrors
 + remote: disallow some nonsensical option combinations

May want to merge by 1.7.5 as this avoids a nonsense configuration to be
created to confuse unsuspecting users.

* jk/notes-ui-updates (2011-03-30) 7 commits
 - log/pretty-options: Document --[no-]notes and deprecate old notes options
 - revision.c: make --no-notes reset --notes list
 - revision.c: support --notes command-line option
 - notes: refactor display notes default handling
 - notes: refactor display notes extra refs field
 - revision.c: refactor notes ref expansion
 - notes: make expand_notes_ref globally accessible

I like what this does, but it probably can wait.

* nd/maint-setup (2011-03-26) 2 commits
  (merged to 'next' on 2011-03-31 at 2c36f6a)
 + Kill off get_relative_cwd()
 + setup: return correct prefix if worktree is '/'

This benefits only the minority who use /.git at the root level of the
filesystem, but the changed code is used from many codepaths; will not
merge before 1.7.5.

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
after giving another look.  Will not merge before 1.7.5, as there is no
user visible improvements up to this point.

* jh/gitweb-localtime (2011-03-23) 1 commit
 - gitweb: javascript ability to adjust time based on timezone

* jk/maint-merge-rename-create (2011-03-25) 3 commits
  (merged to 'next' on 2011-03-31 at b9bc9f1)
 + merge: turn on rewrite detection
 + merge: handle renames with replacement content
 + t3030: fix accidental success in symlink rename

May merge before rc1, but it is Ok to wait.

* mz/maint-rename-unmerged (2011-03-23) 1 commit
  (merged to 'next' on 2011-03-31 at c7b3d9a)
 + diffcore-rename: don't consider unmerged path as source

Will cook until 1.7.5 final.

* nd/struct-pathspec (2011-03-25) 4 commits
  (merged to 'next' on 2011-03-31 at 66cbb7d)
 + Improve tree_entry_interesting() handling code
 + Convert read_tree{,_recursive} to support struct pathspec
 + Reimplement read_tree_recursive() using tree_entry_interesting()
 + Merge branch 'en/object-list-with-pathspec' into 'nd/struct-pathspec'

Will cook until 1.7.5 final.

* jc/add-u-migration (2011-03-22) 3 commits
 - add: make "add -u/-A" update full tree without pathspec (step 3)
 - add: make "add -u/-A" update full tree without pathspec (step 2)
  (merged to 'next' on 2011-03-31 at 962e058)
 + add: make "add -u/-A" update full tree without pathspec

The bottom one is a necessary first step toward the UI clean-up planned
for 1.8.0 which we discussed in length in the earlier part of the cycle;
the change is low impact, isolated, and has no risk of breaking the system
as a whole, but I would wait until the ":/" magic pathspec materializes,
as the advice message would have to become different, and the way to get
more stable semantics will become more direct.

* jc/rename-degrade-cc-to-c (2011-01-06) 4 commits
  (merged to 'next' on 2011-03-31 at 8d685d7)
 + diffcore-rename: fall back to -C when -C -C busts the rename limit
 + diffcore-rename: record filepair for rename src
 + diffcore-rename: refactor "too many candidates" logic
 + builtin/diff.c: remove duplicated call to diff_result_code()

Will hold.

* cn/system-path-tweak (2011-03-17) 1 commit
 - system_path: use a static buffer

* en/merge-recursive (2011-03-17) 4 commits
  (merged to 'next' on 2011-03-18 at a32016b)
 + merge-recursive: tweak magic band-aid
  (merged to 'next' on 2011-03-09 at 3762932)
 + merge-recursive: When we detect we can skip an update, actually skip it
 + t6022: New test checking for unnecessary updates of files in D/F conflicts
 + t6022: New test checking for unnecessary updates of renamed+modified files

I am not happy with these magic band aids.  Will hold.

* jl/submodule-fetch-on-demand (2011-03-06) 7 commits
  (merged to 'next' on 2011-03-20 at a5e452d)
 + fetch/pull: Describe --recurse-submodule restrictions in the BUGS section
 + submodule update: Don't fetch when the submodule commit is already present
 + fetch/pull: Don't recurse into a submodule when commits are already present
 + Submodules: Add 'on-demand' value for the 'fetchRecurseSubmodule' option
 + config: teach the fetch.recurseSubmodules option the 'on-demand' value
 + fetch/pull: Add the 'on-demand' value to the --recurse-submodules option
 + fetch/pull: recurse into submodules when necessary

Will merge.

--------------------------------------------------
[Discarded]

* jk/edit-notes-in-commit-log (2011-03-07) 2 commits
 . [wip] commit: allow editing notes in commit message editor
 . notes: make expand_notes_ref globally accessible

* jk/progress-with-pager (2011-03-24) 4 commits
 . diff: turn on rename detection progress reporting
 . show: turn on rename detection progress reporting
 . progress: use pager's original_stderr if available
 . pager: save the original stderr when redirecting to pager

* mg/grep-full-tree (2011-03-01) 2 commits
 . grep: make --full-tree work with pathspecs
 . grep: --full-tree

It would be preferable to use ":/" or whatever magic pathspec that is
relative to the root of the working tree.
