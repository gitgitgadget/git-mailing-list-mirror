From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jul 2010, #04; Mon, 19)
Date: Mon, 19 Jul 2010 13:27:21 -0700
Message-ID: <7vsk3fnro6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 19 22:27:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oaww4-0000h2-Cp
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 22:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966685Ab0GSU13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jul 2010 16:27:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38928 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966638Ab0GSU11 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 16:27:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 48AB4C65CC;
	Mon, 19 Jul 2010 16:27:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=zAoB
	7d24ut4y3TBzvoen9XRiAtc=; b=R+OoKislWKBg5E8PJZOr5WQp5ke9KrAoiKAE
	EF8XKprNbtOWBUzr/rxUNj5hYWTFy1m/6QNR4AddM+1F8eHpaGLwGaZr4seq3gzn
	2LkHPEru0S3qmzOBz+h8o3wxzX6OirxKEdgssBtYxnVqGHZ55voSpIob1PsNjE0o
	lJfdRe4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=W1b
	+aJJghbJz9ai8CY3bvDR4RWvtmIXeMgg2d343JrRUkacbefTgFZF1rJsrIcHIkGK
	jZE7oF0kso0sqXw7nNH7oyA60el5nXs2UR3aLOXGvkFB5zIBc72MyTYld5qdosGf
	Sd+vmkXTn2TlG3HdO/xtEHpb7zBzVEMkuYk7qO4U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 17528C65CA;
	Mon, 19 Jul 2010 16:27:25 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21F11C65C5; Mon, 19 Jul
 2010 16:27:22 -0400 (EDT)
X-master-at: c5212b87dafb3f559ceb898bd9b40bfc3cd0ad68
X-next-at: b7c600f132949b7f995ac2643ab9728272d3aaab
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0AC64222-9374-11DF-95B5-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151274>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

I've ended up merging a few more fixes to 'master'; please give it a good
final round of testing so that we can have the real thing in a couple of
days.

Thanks.

--------------------------------------------------
[Graduated to "master"]

* jl/add-n-ignore-missing (2010-07-10) 2 commits
 + git submodule add: Require the new --force option to add ignored paths
 + git add: Add the "--ignore-missing" option for the dry run

--------------------------------------------------
[Stalled -- would discard unless there are some movements soon]

* by/log-range-diff (2010-07-12) 18 commits
 . Minimum fix to make by/log-range-diff topic at least compile
 . add test cases for '--graph' of line level log
 . line.c output the '--graph' padding before each line
 . add parent rewrite feature to line level log
 . make rewrite_parents an external function
 . some document update
 . add two test cases
 . add --always-print option
 . map/print ranges along traversing the history topologically
 . print the line log
 . map/take range to parent
 . add range clone functions
 . export three functions from diff.c
 . parse the -L options
 . refactor parse_loc
 . add the basic data structure for line level history
 . parse-options: add two helper functions
 . parse-options: stop when encounter a non-option

Seems to break some tests in t403X range but we are not in a hurry.

* ps/gitweb-soc (2010-06-02) 2 commits
  (merged to 'next' on 2010-06-13 at 92245ae)
 + git-instaweb: Add option to reuse previous config file
 + Makefile: Use $(sharedir)/gitweb for target 'install-gitweb'

If we are going to have a configuration variable to control this, I
strongly suspect that --reuse-config should be renamed so that the
variable can be named more sanely and in line with whatever option
that replaces it.

No responses; I think we will eventually want to have a configuration to
always enable the new option, so the renaming of the command line option
is inevitable.  I plan to kick this out of 'next' once the upcoming
release is out, and expect a re-roll with configuration variable.

* js/rebase-origin-x (2010-02-05) 1 commit
 - [RFC w/o test and incomplete] rebase: add -x option to record original commit name

I retract my objection against the idea of -x; needs polishing before
moving forward.

No responses; I plan to drop this entirely after the upcoming release
without prejudice.

* zl/mailinfo-recode-patch (2010-06-14) 2 commits
 - add --recode-patch option to git-am
 - add --recode-patch option to git-mailinfo

I recall there was another round of re-roll planned for this one.

* jk/tag-contains (2010-07-05) 4 commits
 - Why is "git tag --contains" so slow?
 - default core.clockskew variable to one day
 - limit "contains" traversals based on commit timestamp
 - tag: speed up --contains calculation

--------------------------------------------------
[Cooking]

* ab/report-corrupt-object-with-type (2010-06-10) 1 commit
 - sha1_file: Show the the type and path to corrupt objects

* cc/revert (2010-07-14) 4 commits
 - revert: improve success message by adding abbreviated commit sha1
 - revert: don't print "Finished one cherry-pick." if commit failed
 - revert: refactor commit code into a new run_git_commit() function
 - revert: report success when using option --strategy

* en/fast-export-fix (2010-07-17) 2 commits
 - fast-export: Add a --full-tree option
 - fast-export: Fix dropping of files with --import-marks and path limiting

* jn/parse-date-basic (2010-07-15) 1 commit
 - Export parse_date_basic() to convert a date string to timestamp
 (this branch is used by rr/svn-export.)

* kf/post-receive-sample-hook (2010-07-16) 1 commit
 - post-receive-email: optional message line count limit

* tr/rfc-reset-doc (2010-07-18) 5 commits
 - Documentation/reset: move "undo permanently" example behind "make topic"
 - Documentation/reset: reorder examples to match description
 - Documentation/reset: promote 'examples' one section up
 - Documentation/reset: separate options by mode
 - Documentation/git-reset: reorder modes for soft-mixed-hard progression

* rr/svn-export (2010-07-15) 8 commits
 - Add SVN dump parser
 - Add infrastructure to write revisions in fast-export format
 - Add stream helper library
 - Add string-specific memory pool
 - vcs-svn: treap_search should return NULL for missing items
 - Add treap implementation
 - Add memory pool library
 - Introduce vcs-svn lib
 (this branch uses jn/parse-date-basic.)

* hv/autosquash-config (2010-07-14) 1 commit
 - add configuration variable for --autosquash option of interactive rebase

* jh/graph-next-line (2010-07-13) 2 commits
 - Enable custom schemes for column colors in the graph API
 - Make graph_next_line() available in the graph.h API

* ar/string-list-foreach (2010-07-03) 2 commits
 - Convert the users of for_each_string_list to for_each_string_list_item macro
 - Add a for_each_string_list_item macro
 (this branch is used by tf/string-list-init.)

* il/rfc-remote-fd-ext (2010-07-19) 3 commits
 - gitignore: Ignore the new /git-remote-{ext,fd} helpers
 - New remote helper: git-remote-ext
 - New remote helper git-remote-fd

* gp/pack-refs-remove-empty-dirs (2010-07-06) 1 commit
  (merged to 'next' on 2010-07-14 at 7d25131)
 + pack-refs: remove newly empty directories

* hv/submodule-find-ff-merge (2010-07-07) 3 commits
 - Implement automatic fast-forward merge for submodules
 - setup_revisions(): Allow walking history in a submodule
 - Teach ref iteration module about submodules

* jn/fast-import-subtree (2010-06-30) 1 commit
 - Teach fast-import to import subtrees named by tree id

* sg/rerere-gc-old-still-used (2010-07-13) 2 commits
 - rerere: fix overeager gc
 - mingw_utime(): handle NULL times parameter

* tf/string-list-init (2010-07-04) 1 commit
 - string_list: Add STRING_LIST_INIT macro and make use of it.
 (this branch uses ar/string-list-foreach.)

* en/d-f-conflict-fix (2010-07-09) 6 commits
  (merged to 'next' on 2010-07-14 at 2b2a810)
 + fast-import: Improve robustness when D->F changes provided in wrong order
 + fast-export: Fix output order of D/F changes
 + merge_recursive: Fix renames across paths below D/F conflicts
 + merge-recursive: Fix D/F conflicts
 + Add a rename + D/F conflict testcase
 + Add additional testcases for D/F conflicts

* ab/i18n (2010-07-10) 1 commit
 - Add infrastructure for translating Git with gettext

* tc/checkout-B (2010-06-24) 3 commits
 - builtin/checkout: learn -B
 - builtin/checkout: reword hint for -b
 - add tests for checkout -b

* eb/double-convert-before-merge (2010-07-02) 3 commits
 - Don't expand CRLFs when normalizing text during merge
 - Try normalizing files to avoid delete/modify conflicts when merging
 - Avoid conflicts when merging branches with mixed normalization
