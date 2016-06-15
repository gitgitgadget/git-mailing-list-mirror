From: Mike Hommey <mh@glandium.org>
Subject: Re: What's cooking in git.git (Jun 2016, #04; Tue, 14)
Date: Wed, 15 Jun 2016 11:36:58 +0900
Message-ID: <20160615023658.GA21270@glandium.org>
References: <xmqqtwgv77az.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 05:06:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bD19k-0002dB-PW
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 05:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbcFODGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 23:06:11 -0400
Received: from [109.144.235.227] ([109.144.235.227]:42530 "EHLO glandium.org"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752983AbcFODGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 23:06:09 -0400
X-Greylist: delayed 1747 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jun 2016 23:06:08 EDT
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1bD0hO-0005bJ-Kz; Wed, 15 Jun 2016 11:36:58 +0900
Content-Disposition: inline
In-Reply-To: <xmqqtwgv77az.fsf@gitster.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297349>

On Tue, Jun 14, 2016 at 03:08:04PM -0700, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
> 
> Git 2.9 has been tagged.  Let's wait for a few days to clean up
> possible fallout and then start a new cycle by rewinding the tip of
> 'next'.  I expect I'd eject a few premature topics out of 'next'
> while doing so.
> 
> You can find the changes described here in the integration branches
> of the repositories listed at
> 
>     http://git-blame.blogspot.com/p/git-public-repositories.html
> 
> --------------------------------------------------
> [Graduated to "master"]
> 
> * jc/t2300-setup (2016-06-01) 1 commit
>   (merged to 'next' on 2016-06-06 at 20f7f83)
>  + t2300: run git-sh-setup in an environment that better mimics the real life
>  (this branch is used by va/i18n-even-more.)
> 
>  A test fix.
> 
> 
> * jk/diff-compact-heuristic (2016-06-10) 1 commit
>  - diff: disable compaction heuristic for now
> 
>  It turns out that the earlier effort to update the heuristics may
>  want to use a bit more time to mature.  Turn it off by default.
> 
> 
> * jk/shell-portability (2016-06-01) 2 commits
>   (merged to 'next' on 2016-06-06 at 5de784e)
>  + t5500 & t7403: lose bash-ism "local"
>  + test-lib: add in-shell "env" replacement
> 
>  test fixes.
> 
> --------------------------------------------------
> [New Topics]
> 
> * lv/status-say-working-tree-not-directory (2016-06-09) 1 commit
>  - Use "working tree" instead of "working directory" for git status
> 
>  "git status" used to say "working directory" when it meant "working
>  tree".
> 
>  Will merge to 'next'.
> 
> 
> * jk/parseopt-string-list (2016-06-13) 3 commits
>  - blame,shortlog: don't make local option variables static
>  - interpret-trailers: don't duplicate option strings
>  - parse_opt_string_list: stop allocating new strings
>  (this branch is used by jk/string-list-static-init.)
> 
>  The command line argument parsing that uses OPT_STRING_LIST() often
>  made a copy of the argv[] element, which was unnecessary.
> 
>  Will merge to 'next'.
> 
> 
> * jk/repack-keep-unreachable (2016-06-14) 3 commits
>  - repack: extend --keep-unreachable to loose objects
>  - repack: add --keep-unreachable option
>  - repack: document --unpack-unreachable option
> 
>  "git repack" learned the "--keep-unreachable" option, which sends
>  loose unreachable objects to a pack instead of leaving them loose.
>  This helps heuristics based on the number of loose objects
>  (e.g. "gc --auto").
> 
>  Will merge to 'next'.
> 
> 
> * lf/recv-sideband-cleanup (2016-06-13) 1 commit
>  - sideband.c: refactor recv_sideband()
> 
>  Code simplification.  It however loses the atomicity of the output
>  9ac13ec9 (atomic write for sideband remote messages, 2006-10-11)
>  tried to add to an once-much-simpler codebase.
> 
>  Expecting a reroll.
> 
> 
> * nd/test-lib-httpd-show-error-log-in-verbose (2016-06-13) 1 commit
>  - lib-httpd.sh: print error.log on error
> 
>  Debugging aid.
> 
>  Will merge to 'next'.
> 
> 
> * pc/occurred (2016-06-10) 2 commits
>  - config.c: fix misspelt "occurred" in an error message
>  - refs.h: fix misspelt "occurred" in a comment
> 
>  Will merge to 'next'.
> 
> 
> * sb/submodule-clone-retry (2016-06-13) 2 commits
>  - submodule update: continue when a clone fails
>  - submodule--helper: initial clone learns retry logic
>  (this branch uses sb/submodule-recommend-shallowness.)
> 
>  "git submodule update" that drives many "git clone" could
>  eventually hit flaky servers/network conditions on one of the
>  submodules; the command learned to retry the attempt.
> 
> 
> * jc/blame-reverse (2016-06-14) 2 commits
>  - blame: dwim "blame --reverse OLD" as "blame --reverse OLD.."
>  - blame: improve diagnosis for "--reverse NEW"
> 
> 
> * jc/deref-tag (2016-06-14) 1 commit
>  - blame, line-log: do not loop around deref_tag()
> 
>  Code clean-up.
> 
>  Will merge to 'next'.
> 
> 
> * jk/fetch-prune-doc (2016-06-14) 1 commit
>  - fetch: document that pruning happens before fetching
> 
>  Will merge to 'next'.
> 
> 
> * km/fetch-do-not-free-remote-name (2016-06-14) 1 commit
>  - builtin/fetch.c: don't free remote->name after fetch
> 
>  Will merge to 'next'.
> 
> 
> * nb/gnome-keyring-build (2016-06-14) 1 commit
>  - gnome-keyring: Don't hard-code pkg-config executable
> 
>  Build improvements for gnome-keyring (in contrib/)
> 
>  Will merge to 'next'.
> 
> 
> * pb/strbuf-read-file-doc (2016-06-14) 1 commit
>  - strbuf: describe the return value of strbuf_read_file
> 
>  Will merge to 'next'.
> 
> --------------------------------------------------
> [Stalled]
> 
> * sb/bisect (2016-04-15) 22 commits
>  - SQUASH???
>  - bisect: get back halfway shortcut
>  - bisect: compute best bisection in compute_relevant_weights()
>  - bisect: use a bottom-up traversal to find relevant weights
>  - bisect: prepare for different algorithms based on find_all
>  - bisect: rename count_distance() to compute_weight()
>  - bisect: make total number of commits global
>  - bisect: introduce distance_direction()
>  - bisect: extract get_distance() function from code duplication
>  - bisect: use commit instead of commit list as arguments when appropriate
>  - bisect: replace clear_distance() by unique markers
>  - bisect: use struct node_data array instead of int array
>  - bisect: get rid of recursion in count_distance()
>  - bisect: make algorithm behavior independent of DEBUG_BISECT
>  - bisect: make bisect compile if DEBUG_BISECT is set
>  - bisect: plug the biggest memory leak
>  - bisect: add test for the bisect algorithm
>  - t6030: generalize test to not rely on current implementation
>  - t: use test_cmp_rev() where appropriate
>  - t/test-lib-functions.sh: generalize test_cmp_rev
>  - bisect: allow 'bisect run' if no good commit is known
>  - bisect: write about `bisect next` in documentation
> 
>  The internal algorithm used in "git bisect" to find the next commit
>  to check has been optimized greatly.
> 
>  Expecting a reroll.
>  ($gmane/291163)
> 
> 
> * sg/completion-updates (2016-02-28) 21 commits
>  . completion: cache the path to the repository
>  . completion: extract repository discovery from __gitdir()
>  . completion: don't guard git executions with __gitdir()
>  . completion: consolidate silencing errors from git commands
>  . completion: don't use __gitdir() for git commands
>  . completion: respect 'git -C <path>'
>  . completion: fix completion after 'git -C <path>'
>  . completion: don't offer commands when 'git --opt' needs an argument
>  . rev-parse: add '--absolute-git-dir' option
>  . completion: list short refs from a remote given as a URL
>  . completion: don't list 'HEAD' when trying refs completion outside of a repo
>  . completion: list refs from remote when remote's name matches a directory
>  . completion: respect 'git --git-dir=<path>' when listing remote refs
>  . completion: fix most spots not respecting 'git --git-dir=<path>'
>  . completion: ensure that the repository path given on the command line exists
>  . completion tests: add tests for the __git_refs() helper function
>  . completion tests: check __gitdir()'s output in the error cases
>  . completion tests: consolidate getting path of current working directory
>  . completion tests: make the $cur variable local to the test helper functions
>  . completion tests: don't add test cruft to the test repository
>  . completion: improve __git_refs()'s in-code documentation
> 
>  Will be rerolled.
>  ($gmane/287839)
> 
> 
> * az/p4-bare-no-rebase (2016-02-19) 1 commit
>  - git-p4.py: Don't try to rebase on submit from bare repository
> 
>  "git p4 submit" attempts to do a rebase, which would fail if done
>  in a bare repository.  Not doing this rebase would paper over the
>  failure, which is what this patch does, but it is unclear what the
>  side effect of not rebasing is.
> 
>  Needs a better explanation.
> 
> 
> * nd/icase (2016-02-15) 12 commits
>  - grep.c: reuse "icase" variable
>  - diffcore-pickaxe: support case insensitive match on non-ascii
>  - diffcore-pickaxe: "share" regex error handling code
>  - grep/pcre: support utf-8
>  - gettext: add is_utf8_locale()
>  - grep/pcre: prepare locale-dependent tables for icase matching
>  - grep/icase: avoid kwsset when -F is specified
>  - grep/icase: avoid kwsset on literal non-ascii strings
>  - test-regex: expose full regcomp() to the command line
>  - test-regex: isolate the bug test code
>  - grep: break down an "if" stmt in preparation for next changes
>  - grep: allow -F -i combination
> 
>  "git grep -i" has been taught to fold case in non-ascii locales.
> 
>  Needs review.
>  ($gmane/286137)
> 
> 
> * ec/annotate-deleted (2015-11-20) 1 commit
>  - annotate: skip checking working tree if a revision is provided
> 
>  Usability fix for annotate-specific "<file> <rev>" syntax with deleted
>  files.
> 
>  Waiting for review.
> 
> 
> * dg/subtree-rebase-test (2016-01-19) 1 commit
>  - contrib/subtree: Add a test for subtree rebase that loses commits
> 
>  Reviewed up to v5.
>  Will be rerolled.
>  ($gmane/284426)
> 
> 
> * js/am-3-merge-recursive-direct (2015-10-12) 2 commits
>  - am: make a direct call to merge_recursive
>  - merge_recursive_options: introduce the "gently" flag
> 
>  The merge_recursive_generic() function has been made a bit safer to
>  call from inside a process.  "git am -3" was taught to make a direct
>  call to the function when falling back to three-way merge.
> 
>  Being able to make a direct call would be good in general, but as a
>  performance thing, the change needs to be backed up by numbers.
> 
>  I haven't gone through the "gently" change with fine toothed comb;
>  I can see that the change avoids calling die(), but I haven't made
>  sure that the program states (e.g. what's in the in-core index) are
>  adjusted sensibly when it returns to the caller instead of dying,
>  or the codepaths that used to die() are free of resource leaks.
>  The original code certainly did not care the program states at the
>  point of dying exactly because it knew it is going to exit, but now
>  they have to care, and they need to be audited.
> 
>  Will be rerolled.
>  ($gmane/292205)
> 
> 
> * dk/gc-more-wo-pack (2016-01-13) 4 commits
>  - gc: clean garbage .bitmap files from pack dir
>  - t5304: ensure non-garbage files are not deleted
>  - t5304: test .bitmap garbage files
>  - prepare_packed_git(): find more garbage
> 
>  Follow-on to dk/gc-idx-wo-pack topic, to clean up stale
>  .bitmap and .keep files.
> 
>  Waiting for a reroll.
>  ($gmane/284368).
> 
> 
> * jc/diff-b-m (2015-02-23) 5 commits
>  . WIPWIP
>  . WIP: diff-b-m
>  - diffcore-rename: allow easier debugging
>  - diffcore-rename.c: add locate_rename_src()
>  - diffcore-break: allow debugging
> 
>  "git diff -B -M" produced incorrect patch when the postimage of a
>  completely rewritten file is similar to the preimage of a removed
>  file; such a resulting file must not be expressed as a rename from
>  other place.
> 
>  The fix in this patch is broken, unfortunately.
>  Will discard.
> 
> 
> * jc/merge-impossible-no-commit (2016-04-26) 2 commits
>  - merge: warn --no-commit merge when no new commit is created
>  - merge: do not contaminate option_commit with --squash
> 
>  "git merge --no-commit" silently succeeded when there is no need to
>  create any commit, either when you are more recent than the commit
>  you tried to merge, or you can fast-forward to the commit you tried
>  to merge.  The command gives a warning message in such cases.
> 
>  Just tying loose ends in a discussion.  Unless somebody else
>  champions this topic, I'll drop it.
> 
>  Will discard.
> 
> --------------------------------------------------
> [Cooking]
> 
> * nd/shallow-deepen (2016-06-13) 27 commits
>  - fetch, upload-pack: --deepen=N extends shallow boundary by N commits
>  - upload-pack: add get_reachable_list()
>  - upload-pack: split check_unreachable() in two, prep for get_reachable_list()
>  - t5500, t5539: tests for shallow depth excluding a ref
>  - clone: define shallow clone boundary with --shallow-exclude
>  - fetch: define shallow boundary with --shallow-exclude
>  - upload-pack: support define shallow boundary by excluding revisions
>  - refs: add expand_ref()
>  - t5500, t5539: tests for shallow depth since a specific date
>  - clone: define shallow clone boundary based on time with --shallow-since
>  - fetch: define shallow boundary with --shallow-since
>  - upload-pack: add deepen-since to cut shallow repos based on time
>  - shallow.c: implement a generic shallow boundary finder based on rev-list
>  - fetch-pack: use a separate flag for fetch in deepening mode
>  - fetch-pack.c: mark strings for translating
>  - fetch-pack: use a common function for verbose printing
>  - fetch-pack: use skip_prefix() instead of starts_with()
>  - upload-pack: move rev-list code out of check_non_tip()
>  - upload-pack: make check_non_tip() clean things up on error
>  - upload-pack: tighten number parsing at "deepen" lines
>  - upload-pack: use skip_prefix() instead of starts_with()
>  - upload-pack: move "unshallow" sending code out of deepen()
>  - upload-pack: remove unused variable "backup"
>  - upload-pack: move "shallow" sending code out of deepen()
>  - upload-pack: move shallow deepen code out of receive_needs()
>  - transport-helper.c: refactor set_helper_option()
>  - remote-curl.c: convert fetch_git() to use argv_array
> 
>  The existing "git fetch --depth=<n>" option was hard to use
>  correctly when making the history of an existing shallow clone
>  deeper.  A new option, "--deepen=<n>", has been added to make this
>  easier to use.  "git clone" also learned "--shallow-since=<date>"
>  and "--shallow-exclude=<tag>" options to make it easier to specify
>  "I am interested only in the recent N months worth of history" and
>  "Give me only the history since that version".
> 
>  Rerolled.
> 
> 
> * jk/avoid-unbounded-alloca (2016-06-07) 1 commit
>  - tree-diff: avoid alloca for large allocations
> 
>  Will merge to 'next'.
> 
> 
> * jk/send-pack-stdio (2016-06-10) 2 commits
>  - write_or_die: remove the unused write_or_whine() function
>  - send-pack: use buffered I/O to talk to pack-objects
> 
>  Code clean-up.
> 
>  Will merge to 'next'.
> 
> 
> * pb/commit-editmsg-path (2016-06-09) 1 commit
>  - builtin/commit.c: memoize git-path for COMMIT_EDITMSG
> 
>  Code clean-up.
> 
>  Will merge to 'next'.
> 
> 
> * wd/userdiff-css (2016-06-03) 1 commit
>   (merged to 'next' on 2016-06-06 at 536102f)
>  + userdiff: add built-in pattern for CSS
> 
>  Update the funcname definition to support css files.
> 
>  Will merge to 'master' after 2.9 final.
> 
> 
> * jc/attr-more (2016-06-09) 8 commits
>  - attr.c: outline the future plans by heavily commenting
>  - attr.c: always pass check[] to collect_some_attrs()
>  - attr.c: introduce empty_attr_check_elems()
>  - attr.c: correct ugly hack for git_all_attrs()
>  - attr.c: rename a local variable check
>  - fixup! d5ad6c13
>  - attr.c: pass struct git_attr_check down the callchain
>  - attr.c: add push_stack() helper
>  (this branch uses jc/attr; is tangled with sb/pathspec-label and sb/submodule-default-paths.)
> 
>  The beginning of long and tortuous journey to clean-up attribute
>  subsystem implementation.
> 
> 
> * jk/rev-list-count-with-bitmap (2016-06-03) 2 commits
>   (merged to 'next' on 2016-06-06 at dd9b30f)
>  + rev-list: disable bitmaps when "-n" is used with listing objects
>  + rev-list: "adjust" results of "--count --use-bitmap-index -n"
> 
>  "git rev-list --count" whose walk-length is limited with "-n"
>  option did not work well with the counting optimized to look at the
>  bitmap index.
> 
>  Will merge to 'master' after 2.9 final.
> 
> 
> * mh/ref-iterators (2016-06-03) 13 commits
>   (merged to 'next' on 2016-06-06 at c8e79dc)
>  + for_each_reflog(): reimplement using iterators
>  + dir_iterator: new API for iterating over a directory tree
>  + for_each_reflog(): don't abort for bad references
>  + do_for_each_ref(): reimplement using reference iteration
>  + refs: introduce an iterator interface
>  + ref_resolves_to_object(): new function
>  + entry_resolves_to_object(): rename function from ref_resolves_to_object()
>  + get_ref_cache(): only create an instance if there is a submodule
>  + remote rm: handle symbolic refs correctly
>  + delete_refs(): add a flags argument
>  + refs: use name "prefix" consistently
>  + do_for_each_ref(): move docstring to the header file
>  + refs: remove unnecessary "extern" keywords
>  (this branch is used by mh/ref-store; uses mh/split-under-lock; is tangled with mh/update-ref-errors.)
> 
>  The API to iterate over all the refs (i.e. for_each_ref(), etc.)
>  has been revamped.
> 
>  Will merge to 'master' after 2.9 final.
> 
> 
> * ew/mboxrd-format-am (2016-06-06) 3 commits
>  - am: support --patch-format=mboxrd
>  - mailsplit: support unescaping mboxrd messages
>  - pretty: support "mboxrd" output format
> 
>  Teach format-patch and mailsplit (hence "am") how a line that
>  happens to begin with "From " in the e-mail message is quoted with
>  ">", so that these lines can be restored to their original shape.
> 
> 
> * lf/receive-pack-auto-gc-to-client (2016-06-06) 1 commit
>  - receive-pack: send auto-gc output over sideband 2
> 
>  Allow messages that are generated by auto gc during "git push" on
>  the receiving end to be explicitly passed back to the sending end
>  over sideband, so that they are shown with "remote: " prefix to
>  avoid confusing the users.
> 
> 
> * mg/cherry-pick-multi-on-unborn (2016-06-06) 1 commit
>  - cherry-pick: allow to pick to unborn branches
> 
>  "git cherry-pick A" worked on an unborn branch, but "git
>  cherry-pick A..B" didn't.
> 
> 
> * mj/log-show-signature-conf (2016-06-06) 2 commits
>  - log: "--no-show-signature" commmand-line option
>  - log: add "log.showsignature" configuration variable
> 
>  "git log" learns log.showSignature configuration variable, and a
>  command line option "--no-show-signature" to countermand it.
> 
>  The order of the commits in the topic need to be reversed.
> 
> 
> * nd/i-t-a-commitable (2016-06-06) 3 commits
>  - commit: don't count i-t-a entries when checking if the new commit is empty
>  - Resurrect "diff-lib.c: adjust position of i-t-a entries in diff"
>  - diff.h: extend "flags" field to 64 bits because we're out of bits
> 
>  "rm .git/index && git add -N * && git commit" allows you to create
>  an empty commit without --allow-empty; attempt to forbid it.
> 
>  Breaks many tests by completely butchering "git commit", it seems.
> 
> 
> * sg/reflog-past-root (2016-06-06) 1 commit
>  - reflog: continue walking the reflog past root commits
> 
>  "git reflog" stopped upon seeing an entry that denotes a branch
>  creation event (aka "unborn"), which made it appear as if the
>  reflog was truncated.
> 
> 
> * tb/complete-status (2016-06-10) 3 commits
>  - completion: add git status
>  - completion: add __git_get_option_value helper
>  - completion: factor out untracked file modes into a variable
> 
>  The completion script (in contrib/) learned to complete "git
>  status" options.
> 
> 
> * tr/doc-tt (2016-06-08) 4 commits
>  - doc: change configuration variables format
>  - doc: more consistency in environment variables format
>  - doc: change environment variables format
>  - doc: clearer rule about formatting literals
> 
>  The documentation set has been updated so that literal commands,
>  configuration variables and environment variables are consistently
>  typeset in fixed-width font and bold in manpages.
> 
>  Will merge to 'next'.
> 
> 
> * vs/prompt-avoid-unset-variable (2016-06-06) 1 commit
>  - git-prompt.sh: Don't error on null ${ZSH,BASH}_VERSION, $short_sha
> 
>  The git-prompt scriptlet (in contrib/) was not friendly with those
>  who uses "set -u", which has been fixed.
> 
> 
> * rj/compat-regex-size-max-fix (2016-06-06) 1 commit
>  - regex: fix a SIZE_MAX macro redefinition warning
> 
>  A compilation fix.
> 
>  Will merge to 'next'.
> 
> 
> * bc/cocci-object-id (2016-06-06) 8 commits
>  - merge-recursive: convert merge_recursive_generic to object_id
>  - merge-recursive: convert leaf functions to use struct object_id
>  - merge-recursive: convert struct merge_file_info to object_id
>  - merge-recursive: convert struct stage_data to use object_id
>  - Rename struct diff_filespec's sha1_valid member.
>  - Convert struct diff_filespec to struct object_id
>  - Apply standard object_id Coccinelle transformations.
>  - Add basic Coccinelle transforms.
> 
>  Move from "unsigned char [20]" to "struct object_id" continues,
>  with help from an automated tool.
> 
> 
> * et/add-chmod-x (2016-06-07) 1 commit
>  - add: add --chmod=+x / --chmod=-x options
> 
>  "git update-index --add --chmod=+x file" may be usable as an escape
>  hatch, but not a friendly thing to force for people who do need to
>  use it regularly.  "git add --chmod=+x file" can be used instead.
> 
>  Will merge to 'next'.
> 
> 
> * mh/connect (2016-06-06) 10 commits
>  - connect: [host:port] is legacy for ssh
>  - connect: move ssh command line preparation to a separate function
>  - connect: actively reject git:// urls with a user part
>  - connect: change the --diag-url output to separate user and host
>  - connect: make parse_connect_url() return the user part of the url as a separate value
>  - connect: group CONNECT_DIAG_URL handling code
>  - connect: make parse_connect_url() return separated host and port
>  - connect: re-derive a host:port string from the separate host and port variables
>  - connect: call get_host_and_port() earlier
>  - connect: document why we sometimes call get_port after get_host_and_port
> 
>  Ok, folks, is everybody happy with this version?

$gmane/296609
$gmane/296610

Mike
