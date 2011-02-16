From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2011, #04; Wed, 16)
Date: Wed, 16 Feb 2011 15:23:46 -0800
Message-ID: <7vk4gzh8cd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 17 00:24:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppqj2-0003LH-Qx
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 00:24:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555Ab1BPXXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 18:23:55 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63787 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767Ab1BPXXx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 18:23:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 76F3D3073;
	Wed, 16 Feb 2011 18:24:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=OyIj
	jZVidNgNf3I2ZRh/DU5htvs=; b=DDf7ImDOAcInSVtXmHsZfrU3I/9UkWuq//X0
	PyR5MIt7//+ZjjYCoHL2Iw+5/cN4feNpTWHagRe1Abo1amzY7q0ScaGXk/c91huZ
	+x3miGcOmAI7gr1bW4tXh2rq5tRCsgKE3rUDlfKw1Xv68SCU27qUeOKWxAMLzETY
	iuPc1ek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=rrP
	4jnKJNS5hRHkdi2j8/eId5THVsiSNcuqhsB8sYqCELQ6kmN0ycE8aXP/vuuYqgPQ
	EeteZylMPY3lmVLaJCSwhDmQnCPATRIta/SKSdryTxYsdxG8K+aVI65WlLg5g4KM
	yEo8kkQ4SutndILcdFFGII3VKJy2ST2lZ24i7VyI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 647B43072;
	Wed, 16 Feb 2011 18:24:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2CB093071; Wed, 16 Feb 2011
 18:24:55 -0500 (EST)
X-master-at: 5673d695fcce217b26d1a5956c1184ff62dc74f1
X-next-at: a71843abac0d3679ef8ee8e818795c39d1910e44
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F835A1BE-3A23-11E0-83DA-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167021>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

--------------------------------------------------
[New Topics]

* jh/do-not-track-non-branches (2011-02-16) 1 commit
 - branch/checkout --track: Ensure that upstream branch is indeed a branch

Conflicts with tr/maint-branch-no-track-head but we should probably say
that this supersedes it.

* jh/push-default-upstream-configname (2011-02-16) 1 commit
 - push.default: Rename 'tracking' to 'upstream'

This is not "renaming" in the sense that breaks existing practice, but
giving a new official name and deprecating the existing one.

* js/maint-merge-use-prepare-commit-msg-hook (2011-02-14) 1 commit
 - merge: honor prepare-commit-msg hook

Will merge to 'next'.

* mg/patch-id (2011-02-16) 2 commits
 - git-patch-id: do not trip over "no newline" markers
 - git-patch-id: test for "no newline" markers

The tip one is too strict in determining "\ No newline..." that needs to
be loosened to be in line with what "git apply" does.

* mg/placeholders-are-lowercase (2011-02-15) 4 commits
 - Make <identifier> lowercase as per CodingGuidelines
 - Make <identifier> lowercase as per CodingGuidelines
 - Make <identifier> lowercase as per CodingGuidelines
 - CodingGuidelines: downcase placeholders in usage messages

Will merge to 'next'.

* mo/perl-bidi-pipe-envfix (2011-02-15) 1 commit
  (merged to 'next' on 2011-02-15 at c36e816)
 + perl: command_bidi_pipe() method should set-up git environmens

Looked reasonable.

* nd/sorted-builtin-command-list (2011-02-15) 1 commit
 - git.c: reorder builtin command list

Looked Ok and low impact.  Will merge to 'next'.

* sp/maint-smart-http-sans-100-continue (2011-02-15) 1 commit
  (merged to 'next' on 2011-02-15 at 553e3e5)
 + smart-http: Don't use Expect: 100-Continue

* jc/grep--no-index-pathspec-fix (2011-02-16) 1 commit
 - grep --no-index: honor pathspecs correctly
 (this branch uses nd/struct-pathspec; is tangled with en/object-list-with-pathspec.)

--------------------------------------------------
[Stalled]

* pw/p4 (2011-02-05) 8 commits
 - git-p4: support clone --bare
 - git-p4: decode p4 wildcard characters
 - git-p4: better message for "git-p4 sync" when not cloned
 - git-p4: reinterpret confusing p4 message
 - git-p4: accommodate new move/delete type in p4
 - git-p4: add missing newline in initial import message
 - git-p4: fix key error for p4 problem
 - git-p4: test script

Will be re-rolled after collecting comments (Pete Wyckoff, 2011-02-07).

* js/checkout-untracked-symlink (2011-02-05) 2 commits
 . (weatherbaloon) needs in-code explanation updates
 . Demonstrate breakage: checkout overwrites untracked symlink with directory

The "fix" seems to test t6035, #2.

Will discard the following topics carried over since pre-1.7.4 era.

* nd/index-doc (2010-09-06) 1 commit
 - doc: technical details about the index file format

Half-written but it is a good start.  I may need to give some help in
describing more recent index extensions.

* cb/ignored-paths-are-precious (2010-08-21) 1 commit
 - checkout/merge: optionally fail operation when ignored files need to be overwritten

This needs tests; also we know of longstanding bugs in related area that
needs to be addressed---they do not have to be part of this series but
their reproduction recipe would belong to the test script for this topic.

It would hurt users to make the new feature on by default, especially the
ones with subdirectories that come and go.

* jk/tag-contains (2010-07-05) 4 commits
 - Why is "git tag --contains" so slow?
 - default core.clockskew variable to one day
 - limit "contains" traversals based on commit timestamp
 - tag: speed up --contains calculation

The idea of the bottom one is probably Ok, except that the use of object
flags needs to be rethought, or at least the helper needs to be moved to
builtin/tag.c to make it clear that it should not be used outside the
current usage context.

* jc/rename-degrade-cc-to-c (2011-01-06) 3 commits
 - diffcore-rename: fall back to -C when -C -C busts the rename limit
 - diffcore-rename: record filepair for rename src
 - diffcore-rename: refactor "too many candidates" logic

IIRC, this was a weather-baloon "if you wanted to, this may be how you
would do it" without test updates.  People who care need to help moving
things forward.

* ab/p4 (2011-01-11) 1 commit
 - git-p4: correct indenting and formatting

Lacks sign-off.  There are a few topics in the same area discussed among
Pete Wyckoff, Vitor Antunes and Tor Arvid Lund that I won't be picking up
myself before the dust settles, so I'd discard this soonish, and wait for
the resolution of the other topics.

* tr/maint-branch-no-track-head (2010-12-14) 1 commit
 - branch: do not attempt to track HEAD implicitly

See jh/do-not-track-non-branches topic.

--------------------------------------------------
[Cooking]

* mz/rebase (2011-02-09) 32 commits
 - rebase: use @{upstream} if no upstream specified
 - rebase -i: remove unnecessary state rebase-root
 - rebase -i: don't read unused variable preserve_merges
 - git-rebase--am: remove unnecessary --3way option
 - rebase -m: don't print exit code 2 when merge fails
 - rebase -m: remember allow_rerere_autoupdate option
 - rebase: remember strategy and strategy options
 - rebase: remember verbose option
 - rebase: extract code for writing basic state
 - rebase: factor out sub command handling
 - rebase: make -v a tiny bit more verbose
 - rebase -i: align variable names
 - rebase: show consistent conflict resolution hint
 - rebase: extract am code to new source file
 - rebase: extract merge code to new source file
 - rebase: remove $branch as synonym for $orig_head
 - rebase -i: support --stat
 - rebase: factor out call to pre-rebase hook
 - rebase: factor out clean work tree check
 - rebase: factor out reference parsing
 - rebase: reorder validation steps
 - rebase -i: remove now unnecessary directory checks
 - rebase: factor out command line option processing
 - rebase: align variable content
 - rebase: align variable names
 - rebase: stricter check of standalone sub command
 - rebase: act on command line outside parsing loop
 - rebase: improve detection of rebase in progress
 - rebase: remove unused rebase state 'prev_head'
 - rebase: read state outside loop
 - rebase: refactor reading of state
 - rebase: clearer names for directory variables

Minor UI regression was reported but otherwise it looked like that the
topic is in a good shape.  Will merge to 'next'.

* jh/merge-sans-branch (2011-02-10) 4 commits
 . merge: add support for merging from upstream by default
 - merge: introduce per-branch-configuration helper function
 - merge: introduce setup_merge_commit helper function
 - merge: update the usage information to be more modern

There was an objection to the tip one that determines the upstream in a
wrong way?

* lp/config-vername-check (2011-02-10) 4 commits
 - Fix-up detection of configuration key without section or variable
 - Disallow empty section and variable names
 - Fix-up configuration variable name parsing
 - Sanity-check config variable names

Will merge to 'next' but the two "Fix-up"s should be squashed in first.

* mz/rerere-remaining (2011-02-16) 2 commits
 - mergetool: don't skip modify/remove conflicts
 - rerere "remaining"

Looked much better than my weatherbaloon patch.  Will merge to 'next'.

* nd/hash-object-sanity (2011-02-05) 1 commit
 - Make hash-object more robust against malformed objects

Should be low-impact enough.  Will merge to 'next'.

* hv/mingw-fs-funnies (2011-02-07) 5 commits
  (merged to 'next' on 2011-02-09 at 3d0bb1a)
 + mingw_rmdir: set errno=ENOTEMPTY when appropriate
 + mingw: add fallback for rmdir in case directory is in use
 + mingw: make failures to unlink or move raise a question
 + mingw: work around irregular failures of unlink on windows
 + mingw: move unlink wrapper to mingw.c

Rerolled and seems ready to move forward.

* nd/struct-pathspec (2011-01-31) 22 commits
  (merged to 'next' on 2011-02-09 at b1e64ee)
 + t6004: add pathspec globbing test for log family
 + t7810: overlapping pathspecs and depth limit
 + grep: drop pathspec_matches() in favor of tree_entry_interesting()
 + grep: use writable strbuf from caller for grep_tree()
 + grep: use match_pathspec_depth() for cache/worktree grepping
 + grep: convert to use struct pathspec
 + Convert ce_path_match() to use match_pathspec_depth()
 + Convert ce_path_match() to use struct pathspec
 + struct rev_info: convert prune_data to struct pathspec
 + pathspec: add match_pathspec_depth()
 + tree_entry_interesting(): optimize wildcard matching when base is matched
 + tree_entry_interesting(): support wildcard matching
 + tree_entry_interesting(): fix depth limit with overlapping pathspecs
 + tree_entry_interesting(): support depth limit
 + tree_entry_interesting(): refactor into separate smaller functions
 + diff-tree: convert base+baselen to writable strbuf
 + glossary: define pathspec
 + Move tree_entry_interesting() to tree-walk.c and export it
 + tree_entry_interesting(): remove dependency on struct diff_options
 + Convert struct diff_options to use struct pathspec
 + diff-no-index: use diff_tree_setup_paths()
 + Add struct pathspec
 (this branch is used by en/object-list-with-pathspec and jc/grep--no-index-pathspec-fix.)

* en/object-list-with-pathspec (2010-09-20) 2 commits
  (merged to 'next' on 2011-02-09 at ccf6c6a)
 + Add testcases showing how pathspecs are handled with rev-list --objects
 + Make rev-list --objects work together with pathspecs
 (this branch uses nd/struct-pathspec; is tangled with jc/grep--no-index-pathspec-fix.)

* uk/checkout-ambiguous-ref (2011-02-15) 5 commits
  (merged to 'next' on 2011-02-15 at 645dad6)
 + Rename t2019 with typo "amiguous" that meant "ambiguous"
 + checkout: rearrange update_refs_for_switch for clarity
 + checkout: introduce --detach synonym for "git checkout foo^{commit}"
 + checkout: split off a function to peel away branchname arg
  (merged to 'next' on 2011-02-03 at 9044724)
 + checkout: fix bug with ambiguous refs

The topic has become about "checkout --detach" ;-).

--------------------------------------------------
[Discarded]

* jc/rerere-remaining (2011-01-06) 1 commit
 . rerere "remaining"

Just a handful of weatherballoon patches without proper tests, in response
to feature/minor fix requests.

* ab/i18n (2010-10-07) 161 commits
 . po/de.po: complete German translation
 ....
 . t7004-tag.sh: re-arrange git tag comment for clarity

Will be re-rolled.
