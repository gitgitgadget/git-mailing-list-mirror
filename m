From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Apr 2011, #02; Wed, 6)
Date: Wed, 06 Apr 2011 13:04:40 -0700
Message-ID: <7v8vvni1t3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 06 22:05:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7YyH-0008U3-CV
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 22:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756760Ab1DFUEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 16:04:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50833 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753455Ab1DFUEu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 16:04:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8F82E48B0;
	Wed,  6 Apr 2011 16:06:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=R
	I+jpnCZiCOQhaGnvMNlyqvnXUg=; b=q/KCEn2hpazLRB+VVYe9YSODAeOZhMhh2
	0xLXrsWW+/kWYZy2hK6LQwBECBJDlT5klhX1xywUXL5Kq6G4cH3G/BfRaTtqH14s
	5IDQ4guhu1zCST5nE9kE4hHZKXAEdreLfeyYWG8PI2G4Qbvyzisy2YMnfI++/X8K
	N41onyI61g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=CIY
	cJufGQUbDj0qeTDf/4d09TJftkFecT1jRMu74X/AeAt+KUifX4Ad0Z5XMDgeCnKf
	EBgZPLGo6TTsSl5X970ZJjZKxy5oMGpkQU0JORvUaBpvhqwXVh3vT4wYTsHptCOB
	qnnpVu2snu9o1D6ICERuXgfwlMtlo9uf73Baczxs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7980948AD;
	Wed,  6 Apr 2011 16:06:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 04D8B48A3; Wed,  6 Apr 2011
 16:06:36 -0400 (EDT)
X-master-at: 6be0559183ac0b40680df314748141d1bdf28e41
X-next-at: 00b8c7c14947fdc050aa2896ceffcc245873ec3e
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 63E6BD54-6089-11E0-8D54-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171013>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

The tip of 'master' is at 1.7.5-rc1 now.

--------------------------------------------------
[New Topics]

* dm/http-cleanup (2011-03-30) 2 commits
 - http-push: refactor curl_easy_setup madness
 - http: make curl callbacks match contracts from curl header

* jc/pack-objects-bigfile (2011-04-05) 1 commit
 - Teach core.bigfilethreashold to pack-objects

* jk/maint-stash-oob (2011-04-06) 2 commits
 - stash: fix false positive in the invalid ref test.
 - stash: fix accidental apply of non-existent stashes

* nk/blame-abbrev (2011-04-06) 1 commit
 - blame: add --abbrev command line option and make it honor core.abbrev

* nm/submodule-update-force (2011-04-01) 1 commit
 - submodule: Add --force option for git submodule update

* jk/maint-upload-pack-shallow (2011-04-04) 1 commit
 - [REVISIT] upload-pack deadlock during a shallow clone

* jk/stash-loosen-safety (2011-04-05) 1 commit
 - stash: drop dirty worktree check on apply

--------------------------------------------------
[Graduated to "master"]

* jc/rev-list-options-fix (2011-04-01) 1 commit
  (merged to 'next' on 2011-04-03 at 91f19de)
 + "log --cherry-pick" documentation regression fix

* jk/maint-remote-mirror-safer (2011-03-30) 3 commits
  (merged to 'next' on 2011-04-03 at ccc9c1a)
 + remote: deprecate --mirror
 + remote: separate the concept of push and fetch mirrors
 + remote: disallow some nonsensical option combinations

This avoids a nonsense configuration to be created to confuse unsuspecting
users.

* jl/submodule-fetch-on-demand (2011-03-06) 7 commits
  (merged to 'next' on 2011-03-20 at a5e452d)
 + fetch/pull: Describe --recurse-submodule restrictions in the BUGS section
 + submodule update: Don't fetch when the submodule commit is already present
 + fetch/pull: Don't recurse into a submodule when commits are already present
 + Submodules: Add 'on-demand' value for the 'fetchRecurseSubmodule' option
 + config: teach the fetch.recurseSubmodules option the 'on-demand' value
 + fetch/pull: Add the 'on-demand' value to the --recurse-submodules option
 + fetch/pull: recurse into submodules when necessary

* mg/doc-revisions-txt (2011-04-04) 3 commits
  (merged to 'next' on 2011-04-04 at ebf3612)
 + revisions.txt: language improvements
 + revisions.txt: structure with a labelled list
 + revisions.txt: consistent use of quotes

* nm/maint-conflicted-submodule-entries (2011-03-30) 1 commit
  (merged to 'next' on 2011-04-03 at 40c5094)
 + submodule: process conflicting submodules only once

--------------------------------------------------
[Stalled]

* jh/gitweb-localtime (2011-03-23) 1 commit
 - gitweb: javascript ability to adjust time based on timezone

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

* dm/color-palette (2011-04-05) 1 commit
  (merged to 'next' on 2011-04-04 at 0244ef9)
 + Share color list between graph and show-branch

* mg/sha1-path-advise (2011-03-31) 2 commits
  (merged to 'next' on 2011-04-04 at e429e0c)
 + sha1_name: Suggest commit:./file for path in subdir
 + t1506: factor out test for "Did you mean..."

* ar/clean-rmdir-empty (2011-04-01) 1 commit
  (merged to 'next' on 2011-04-03 at c63fac8)
 + clean: unreadable directory may still be rmdir-able if it is empty

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

* mg/reflog-with-options (2011-04-01) 3 commits
  (merged to 'next' on 2011-04-03 at e69a95c)
 + reflog: fix overriding of command line options
 + t/t1411: test reflog with formats
 + builtin/log.c: separate default and setup of cmd_log_init()
 (this branch is used by mg/show-without-prune.)

Reasonable, but can wait.

* mh/git-svn-automkdirs (2011-04-01) 1 commit
  (merged to 'next' on 2011-04-03 at 7fa4978)
 + git-svn: add an option to skip the creation of empty directories

Should be safe, but I'd like an Ack from git-svn folks.

* jc/diff-irreversible-delete (2011-02-28) 1 commit
  (merged to 'next' on 2011-04-03 at 5a23b23)
 + git diff -D: omit the preimage of deletes

Unstuck, thanks to Michael J Gruber.

* jh/notes-add-ui (2011-03-30) 1 commit
 - Make "git notes add" more user-friendly when there are existing notes

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
to 'next' after giving another look.  Will not merge before 1.7.5, as
there is no user visible improvements up to this point.

* jk/maint-merge-rename-create (2011-03-25) 3 commits
  (merged to 'next' on 2011-03-31 at b9bc9f1)
 + merge: turn on rewrite detection
 + merge: handle renames with replacement content
 + t3030: fix accidental success in symlink rename

* mz/maint-rename-unmerged (2011-03-23) 1 commit
  (merged to 'next' on 2011-03-31 at c7b3d9a)
 + diffcore-rename: don't consider unmerged path as source

Will cook until 1.7.5 final.

* nd/struct-pathspec (2011-04-05) 5 commits
 - pathspec: rename per-item field has_wildcard to use_wildcard
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

Need to redo the advice after the "this is from root of the working tree"
magic pathspec.

* jc/rename-degrade-cc-to-c (2011-01-06) 4 commits
  (merged to 'next' on 2011-03-31 at 8d685d7)
 + diffcore-rename: fall back to -C when -C -C busts the rename limit
 + diffcore-rename: record filepair for rename src
 + diffcore-rename: refactor "too many candidates" logic
 + builtin/diff.c: remove duplicated call to diff_result_code()

Will hold.

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
