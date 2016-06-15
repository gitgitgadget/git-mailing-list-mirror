From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Nov 2012, #04; Wed, 14)
Date: Wed, 14 Nov 2012 14:42:58 -0800
Message-ID: <7vhaorajrh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 14 23:43:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYlg1-0005qN-82
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 23:43:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945914Ab2KNWnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 17:43:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54542 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933178Ab2KNWnC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 17:43:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0FE7AAEC;
	Wed, 14 Nov 2012 17:43:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=K
	zCSq8l4WsB6JtlXfoWSCy9OnoM=; b=coEcyVmc/8aZZeiTMNMyzyxSfvsXDcRWv
	QWbXVXAfWCJSJaBiQO4DwTl5JXxbb+P8T3oOLLXVeTiu6R6HCvzmhx/l9lT8Wwl4
	ySfs45KTyhrgRbhwJjRHVygAlcWhJ2C74GDZgoo9Y3tw6NdwvSDYGQdwAQ0kBV+6
	lxKqAs8EZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=crz
	4lN21CHU17U/J6h8Ziya8jAMBY4/LJtJAmtI1eegSoAReL5V94bMQ2huE2F1GrBZ
	1B1QvGY88P2WproNaEJrPHdfH5FT57eqRmUiktQ7bMjsUtmEMRQxYel2KRho43ad
	yL/SSnt12fAzuSgLWSeVbACruwwIB17kwZhYuo04=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE51FAAEB;
	Wed, 14 Nov 2012 17:43:00 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99FA8AAEA; Wed, 14 Nov 2012
 17:42:59 -0500 (EST)
X-master-at: b0b00a3ee43b4813eb85728a482500f6422499fd
X-next-at: 7a667bc8d11125a8f74ecadedd74c71c91f5c0d4
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A4112FAC-2EAC-11E2-812C-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209755>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

Big thanks go to Jeff who curated topics in flight while I was on
vacation.  I merged a couple of topics to 'next', and will start
merging what he marked for 'master' after giving them a final look
by the end of the week.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* jl/submodule-rm (2012-11-14) 1 commit
 - docs: move submodule section


* sg/complete-help-undup (2012-11-14) 1 commit
 - completion: remove 'help' duplicate from porcelain commands

--------------------------------------------------
[Stalled]

* nd/pretty-placeholder-with-color-option (2012-09-30) 9 commits
 . pretty: support %>> that steal trailing spaces
 . pretty: support truncating in %>, %< and %><
 . pretty: support padding placeholders, %< %> and %><
 . pretty: two phase conversion for non utf-8 commits
 . utf8.c: add utf8_strnwidth() with the ability to skip ansi sequences
 . utf8.c: move display_mode_esc_sequence_len() for use by other functions
 . pretty: support %C(auto[,N]) to turn on coloring on next placeholder(s)
 . pretty: split parsing %C into a separate function
 . pretty: share code between format_decoration and show_decorations

 This causes warnings with -Wuninitialized, so I've ejected it from pu
 for the time being.


* rc/maint-complete-git-p4 (2012-09-24) 1 commit
  (merged to 'next' on 2012-10-29 at af52cef)
 + Teach git-completion about git p4

 Comment from Pete will need to be addressed in a follow-up patch.


* as/test-tweaks (2012-09-20) 7 commits
 - tests: paint unexpectedly fixed known breakages in bold red
 - tests: test the test framework more thoroughly
 - [SQUASH] t/t0000-basic.sh: quoting of TEST_DIRECTORY is screwed up
 - tests: refactor mechanics of testing in a sub test-lib
 - tests: paint skipped tests in bold blue
 - tests: test number comes first in 'not ok $count - $message'
 - tests: paint known breakages in bold yellow

 Various minor tweaks to the test framework to paint its output
 lines in colors that match what they mean better.

 Has the "is this really blue?" issue Peff raised resolved???


* jc/maint-name-rev (2012-09-17) 7 commits
 - describe --contains: use "name-rev --algorithm=weight"
 - name-rev --algorithm=weight: tests and documentation
 - name-rev --algorithm=weight: cache the computed weight in notes
 - name-rev --algorithm=weight: trivial optimization
 - name-rev: --algorithm option
 - name_rev: clarify the logic to assign a new tip-name to a commit
 - name-rev: lose unnecessary typedef

 "git name-rev" names the given revision based on a ref that can be
 reached in the smallest number of steps from the rev, but that is
 not useful when the caller wants to know which tag is the oldest one
 that contains the rev.  This teaches a new mode to the command that
 uses the oldest ref among those which contain the rev.

 I am not sure if this is worth it; for one thing, even with the help
 from notes-cache, it seems to make the "describe --contains" even
 slower. Also the command will be unusably slow for a user who does
 not have a write access (hence unable to create or update the
 notes-cache).

 Stalled mostly due to lack of responses.


* jc/xprm-generation (2012-09-14) 1 commit
 - test-generation: compute generation numbers and clock skews

 A toy to analyze how bad the clock skews are in histories of real
 world projects.

 Stalled mostly due to lack of responses.


* jc/blame-no-follow (2012-09-21) 2 commits
 - blame: pay attention to --no-follow
 - diff: accept --no-follow option

 Teaches "--no-follow" option to "git blame" to disable its
 whole-file rename detection.

 Stalled mostly due to lack of responses.


* jc/doc-default-format (2012-10-07) 2 commits
 - [SQAUSH] allow "cd Doc* && make DEFAULT_DOC_TARGET=..."
 - Allow generating a non-default set of documentation

 Need to address the installation half if this is to be any useful.


* mk/maint-graph-infinity-loop (2012-09-25) 1 commit
 - graph.c: infinite loop in git whatchanged --graph -m

 The --graph code fell into infinite loop when asked to do what the
 code did not expect ;-)

 Anybody who worked on "--graph" wants to comment?
 Stalled mostly due to lack of responses.


* jc/add-delete-default (2012-08-13) 1 commit
 - git add: notice removal of tracked paths by default

 "git add dir/" updated modified files and added new files, but does
 not notice removed files, which may be "Huh?" to some users.  They
 can of course use "git add -A dir/", but why should they?

 Resurrected from graveyard, as I thought it was a worthwhile thing
 to do in the longer term.

 Waiting for comments.


* mb/remote-default-nn-origin (2012-07-11) 6 commits
 - Teach get_default_remote to respect remote.default.
 - Test that plain "git fetch" uses remote.default when on a detached HEAD.
 - Teach clone to set remote.default.
 - Teach "git remote" about remote.default.
 - Teach remote.c about the remote.default configuration setting.
 - Rename remote.c's default_remote_name static variables.

 When the user does not specify what remote to interact with, we
 often attempt to use 'origin'.  This can now be customized via a
 configuration variable.

 Expecting a re-roll.

 "The first remote becomes the default" bit is better done as a
 separate step.


* mh/ceiling (2012-10-29) 8 commits
 - string_list_longest_prefix(): remove function
 - setup_git_directory_gently_1(): resolve symlinks in ceiling paths
 - longest_ancestor_length(): require prefix list entries to be normalized
 - longest_ancestor_length(): take a string_list argument for prefixes
 - longest_ancestor_length(): use string_list_split()
 - Introduce new function real_path_if_valid()
 - real_path_internal(): add comment explaining use of cwd
 - Introduce new static function real_path_internal()

 Elements of GIT_CEILING_DIRECTORIES list may not match the real
 pathname we obtain from getcwd(), leading the GIT_DIR discovery
 logic to escape the ceilings the user thought to have specified.

--------------------------------------------------
[Cooking]

* jk/maint-gitweb-xss (2012-11-12) 1 commit
  (merged to 'next' on 2012-11-14 at 7a667bc)
 + gitweb: escape html in rss title

 Fixes an XSS vulnerability in gitweb.


* jk/send-email-sender-prompt (2012-11-13) 6 commits
 - send-email: do not prompt for explicit repo ident
 - Git.pm: teach "ident" to query explicitness
 - var: provide explicit/implicit ident information
 - var: accept multiple variables on the command line
 - ident: keep separate "explicit" flags for author and committer
 - ident: make user_ident_explicitly_given private

 Avoid annoying sender prompt in git-send-email, but only when it is
 safe to do so.

 Needs review.


* mg/replace-resolve-delete (2012-11-13) 1 commit
  (merged to 'next' on 2012-11-14 at fa785ae)
 + replace: parse revision argument for -d

 Be more user friendly to people using "git replace -d".


* ml/cygwin-mingw-headers (2012-11-12) 1 commit
 - Update cygwin.c for new mingw-64 win32 api headers

 Make git work on newer cygwin.

 Will merge to 'next'.


* mo/cvs-server-updates (2012-10-16) 10 commits
 - cvsserver Documentation: new cvs ... -r support
 - cvsserver: add t9402 to test branch and tag refs
 - cvsserver: support -r and sticky tags for most operations
 - cvsserver: Add version awareness to argsfromdir
 - cvsserver: generalize getmeta() to recognize commit refs
 - cvsserver: implement req_Sticky and related utilities
 - cvsserver: add misc commit lookup, file meta data, and file listing functions
 - cvsserver: define a tag name character escape mechanism
 - cvsserver: cleanup extra slashes in filename arguments
 - cvsserver: factor out git-log parsing logic

 Needs review by folks interested in cvsserver.


* ta/doc-cleanup (2012-10-25) 6 commits
  (merged to 'next' on 2012-11-13 at e11fafd)
 + Documentation: build html for all files in technical and howto
 + Documentation/howto: convert plain text files to asciidoc
 + Documentation/technical: convert plain text files to asciidoc
 + Change headline of technical/send-pack-pipeline.txt to not confuse its content with content from git-send-pack.txt
 + Shorten two over-long lines in git-bisect-lk2009.txt by abbreviating some sha1
 + Split over-long synopsis in git-fetch-pack.txt into several lines

 Will merge to 'master' in the sixth batch.


* lt/diff-stat-show-0-lines (2012-10-17) 1 commit
 - Fix "git diff --stat" for interesting - but empty - file changes

 We failed to mention a file without any content change but whose
 permission bit was modified, or (worse yet) a new file without any
 content in the "git diff --stat" output.

 Needs some test updates.


* jc/prettier-pretty-note (2012-11-13) 12 commits
  (merged to 'next' on 2012-11-14 at 7230f26)
 + format-patch: add a blank line between notes and diffstat
  (merged to 'next' on 2012-11-04 at 40e3e48)
 + Doc User-Manual: Patch cover letter, three dashes, and --notes
 + Doc format-patch: clarify --notes use case
 + Doc notes: Include the format-patch --notes option
 + Doc SubmittingPatches: Mention --notes option after "cover letter"
 + Documentation: decribe format-patch --notes
 + format-patch --notes: show notes after three-dashes
 + format-patch: append --signature after notes
 + pretty_print_commit(): do not append notes message
 + pretty: prepare notes message at a centralized place
 + format_note(): simplify API
 + pretty: remove reencode_commit_message()

 Emit the notes attached to the commit in "format-patch --notes"
 output after three-dashes.

 Will merge to 'master' in the fifth batch.


* jc/same-encoding (2012-11-04) 1 commit
  (merged to 'next' on 2012-11-04 at 54991f2)
 + reencode_string(): introduce and use same_encoding()

 Various codepaths checked if two encoding names are the same using
 ad-hoc code and some of them ended up asking iconv() to convert
 between "utf8" and "UTF-8".  The former is not a valid way to spell
 the encoding name, but often people use it by mistake, and we
 equated them in some but not all codepaths. Introduce a new helper
 function to make these codepaths consistent.

 Will merge to 'master' in the fifth batch.


* cr/cvsimport-local-zone (2012-11-04) 2 commits
  (merged to 'next' on 2012-11-04 at 292f0b4)
 + cvsimport: work around perl tzset issue
 + git-cvsimport: allow author-specific timezones

 Allows "cvsimport" to read per-author timezone from the author info
 file.

 Will merge to 'master' in the fifth batch.


* fc/zsh-completion (2012-10-29) 3 commits
 - completion: add new zsh completion
 - completion: add new __gitcompadd helper
 - completion: get rid of empty COMPREPLY assignments

 There were some comments on this, but I wasn't clear on the outcome.

 Need to take a closer look.


* jc/apply-trailing-blank-removal (2012-10-12) 1 commit
 - apply.c:update_pre_post_images(): the preimage can be truncated

 Fix to update_pre_post_images() that did not take into account the
 possibility that whitespace fix could shrink the preimage and
 change the number of lines in it.

 Extra set of eyeballs appreciated.


* jn/warn-on-inaccessible-loosen (2012-10-14) 4 commits
 - config: exit on error accessing any config file
 - doc: advertise GIT_CONFIG_NOSYSTEM
 - config: treat user and xdg config permission problems as errors
 - config, gitignore: failure to access with ENOTDIR is ok

 An RFC to deal with a situation where .config/git is a file and we
 notice .config/git/config is not readable due to ENOTDIR, not
 ENOENT; I think a bit more refactored approach to consistently
 address permission errors across config, exclude and attrs is
 desirable.  Don't we also need a check for an opposite situation
 where we open .config/git/config or .gitattributes for reading but
 they turn out to be directories?


* as/check-ignore (2012-11-08) 14 commits
 - t0007: fix tests on Windows
 - Documentation/check-ignore: we show the deciding match, not the first
 - Add git-check-ignore sub-command
 - dir.c: provide free_directory() for reclaiming dir_struct memory
 - pathspec.c: move reusable code from builtin/add.c
 - dir.c: refactor treat_gitlinks()
 - dir.c: keep track of where patterns came from
 - dir.c: refactor is_path_excluded()
 - dir.c: refactor is_excluded()
 - dir.c: refactor is_excluded_from_list()
 - dir.c: rename excluded() to is_excluded()
 - dir.c: rename excluded_from_list() to is_excluded_from_list()
 - dir.c: rename path_excluded() to is_path_excluded()
 - dir.c: rename cryptic 'which' variable to more consistent name

 Duy helped to reroll this.

 Expecting a re-roll.


* so/prompt-command (2012-10-17) 4 commits
  (merged to 'next' on 2012-10-25 at 79565a1)
 + coloured git-prompt: paint detached HEAD marker in red
 + Fix up colored git-prompt
 + show color hints based on state of the git tree
 + Allow __git_ps1 to be used in PROMPT_COMMAND

 Updates __git_ps1 so that it can be used as $PROMPT_COMMAND,
 instead of being used for command substitution in $PS1, to embed
 color escape sequences in its output.

 Will cook in 'next'.


* aw/rebase-am-failure-detection (2012-10-11) 1 commit
 - rebase: Handle cases where format-patch fails

 I am unhappy a bit about the possible performance implications of
 having to store the output in a temporary file only for a rare case
 of format-patch aborting.


* nd/wildmatch (2012-10-15) 13 commits
  (merged to 'next' on 2012-10-25 at 510e8df)
 + Support "**" wildcard in .gitignore and .gitattributes
 + wildmatch: make /**/ match zero or more directories
 + wildmatch: adjust "**" behavior
 + wildmatch: fix case-insensitive matching
 + wildmatch: remove static variable force_lower_case
 + wildmatch: make wildmatch's return value compatible with fnmatch
 + t3070: disable unreliable fnmatch tests
 + Integrate wildmatch to git
 + wildmatch: follow Git's coding convention
 + wildmatch: remove unnecessary functions
 + Import wildmatch from rsync
 + ctype: support iscntrl, ispunct, isxdigit and isprint
 + ctype: make sane_ctype[] const array

 Allows pathname patterns in .gitignore and .gitattributes files
 with double-asterisks "foo/**/bar" to match any number of directory
 hierarchies.

 I suspect that this needs to be plugged to pathspec matching code;
 otherwise "git log -- 'Docum*/**/*.txt'" would not show the log for
 commits that touch Documentation/git.txt, which would be confusing
 to the users.

 Will cook in 'next'.


* jk/lua-hackery (2012-10-07) 6 commits
 - pretty: fix up one-off format_commit_message calls
 - Minimum compilation fixup
 - Makefile: make "lua" a bit more configurable
 - add a "lua" pretty format
 - add basic lua infrastructure
 - pretty: make some commit-parsing helpers more public

 Interesting exercise. When we do this for real, we probably would want
 to wrap a commit to make it more like an "object" with methods like
 "parents", etc.


* jc/maint-fetch-tighten-refname-check (2012-10-19) 1 commit
  (merged to 'next' on 2012-11-04 at eda85ef)
 + get_fetch_map(): tighten checks on dest refs

 This was split out from discarded jc/maint-push-refs-all topic.

 Will merge to 'master' in the fifth batch.


* jh/symbolic-ref-d (2012-10-21) 1 commit
  (merged to 'next' on 2012-11-04 at b0762f5)
 + git symbolic-ref --delete $symref

 Add "symbolic-ref -d SYM" to delete a symbolic ref SYM.

 It is already possible to remove a symbolic ref with "update-ref -d
 --no-deref", but it may be a good addition for completeness.

 Will merge to 'master' in the fifth batch.


* jh/update-ref-d-through-symref (2012-10-21) 2 commits
 - Fix failure to delete a packed ref through a symref
 - t1400-update-ref: Add test verifying bug with symrefs in delete_ref()

 "update-ref -d --deref SYM" to delete a ref through a symbolic ref
 that points to it did not remove it correctly.

 Need to check reviews, but is probably ready for 'next'.


* jk/config-ignore-duplicates (2012-10-29) 9 commits
  (merged to 'next' on 2012-10-29 at 67fa0a2)
 + builtin/config.c: Fix a sparse warning
  (merged to 'next' on 2012-10-25 at 233df08)
 + git-config: use git_config_with_options
 + git-config: do not complain about duplicate entries
 + git-config: collect values instead of immediately printing
 + git-config: fix regexp memory leaks on error conditions
 + git-config: remove memory leak of key regexp
 + t1300: test "git config --get-all" more thoroughly
 + t1300: remove redundant test
 + t1300: style updates

 Drop duplicate detection from git-config; this lets it
 better match the internal config callbacks, which clears up
 some corner cases with includes.

 Will merge to 'master' in the sixth batch.


* ph/submodule-sync-recursive (2012-10-29) 2 commits
  (merged to 'next' on 2012-11-04 at a000f78)
 + Add tests for submodule sync --recursive
 + Teach --recursive to submodule sync

 Adds "--recursive" option to submodule sync.

 Will merge to 'master' in the fifth batch.


* fc/completion-test-simplification (2012-10-29) 2 commits
 - completion: simplify __gitcomp test helper
 - completion: refactor __gitcomp related tests

 Clean up completion tests.

 There were some comments on the list.

 Expecting a re-roll.


* fc/remote-testgit-feature-done (2012-10-29) 1 commit
 - remote-testgit: properly check for errors

 Needs review.


* jk/maint-diff-grep-textconv (2012-10-28) 1 commit
  (merged to 'next' on 2012-11-04 at 790337b)
 + diff_grep: use textconv buffers for add/deleted files
 (this branch is used by jk/pickaxe-textconv.)

 Fixes inconsistent use of textconv with "git log -G".

 Will merge to 'master' in the fifth batch.


* jk/pickaxe-textconv (2012-10-28) 2 commits
 - pickaxe: use textconv for -S counting
 - pickaxe: hoist empty needle check
 (this branch uses jk/maint-diff-grep-textconv.)

 Use textconv filters when searching with "log -S".

 Waiting for a sanity check and review from Junio.


* as/maint-doc-fix-no-post-rewrite (2012-11-02) 1 commit
  (merged to 'next' on 2012-11-09 at 117a91e)
 + commit: fixup misplacement of --no-post-rewrite description

 Will merge to 'master' in the fifth batch.


* fc/remote-bzr (2012-11-08) 5 commits
 - remote-bzr: update working tree
 - remote-bzr: add support for remote repositories
 - remote-bzr: add support for pushing
 - remote-bzr: add simple tests
 - Add new remote-bzr transport helper

 New remote helper for bzr.

 Will merge to 'next'.


* fc/remote-hg (2012-11-12) 20 commits
 - remote-hg: avoid bad refs
 - remote-hg: try the 'tip' if no checkout present
 - remote-hg: fix compatibility with older versions of hg
 - remote-hg: add missing config for basic tests
 - remote-hg: the author email can be null
 - remote-hg: add option to not track branches
 - remote-hg: add extra author test
 - remote-hg: add tests to compare with hg-git
 - remote-hg: add bidirectional tests
 - test-lib: avoid full path to store test results
 - remote-hg: add basic tests
 - remote-hg: fake bookmark when there's none
 - remote-hg: add compat for hg-git author fixes
 - remote-hg: add support for hg-git compat mode
 - remote-hg: match hg merge behavior
 - remote-hg: make sure the encoding is correct
 - remote-hg: add support to push URLs
 - remote-hg: add support for remote pushing
 - remote-hg: add support for pushing
 - Add new remote-hg transport helper

 New remote helper for hg.

 Will merge to 'next'.


* jk/maint-http-half-auth-fetch (2012-10-31) 2 commits
  (merged to 'next' on 2012-11-09 at af69926)
 + remote-curl: retry failed requests for auth even with gzip
 + remote-curl: hoist gzip buffer size to top of post_rpc

 Fixes fetch from servers that ask for auth only during the actual
 packing phase. This is not really a recommended configuration, but it
 cleans up the code at the same time.

 Will merge to 'master' in the sixth batch.


* js/hp-nonstop (2012-10-30) 1 commit
  (merged to 'next' on 2012-11-09 at fe58205)
 + fix 'make test' for HP NonStop

 Will merge to 'master' in the fifth batch.


* kb/preload-index-more (2012-11-02) 1 commit
  (merged to 'next' on 2012-11-09 at a750ebd)
 + update-index/diff-index: use core.preloadindex to improve performance

 Use preloadindex in more places, which has a nice speedup on systems
 with slow stat calls (and even on Linux).

 Will merge to 'master' in the sixth batch.


* mh/notes-string-list (2012-11-08) 5 commits
  (merged to 'next' on 2012-11-09 at 7a4c58c)
 + string_list_add_refs_from_colon_sep(): use string_list_split()
 + notes: fix handling of colon-separated values
 + combine_notes_cat_sort_uniq(): sort and dedup lines all at once
 + Initialize sort_uniq_list using named constant
 + string_list: add a function string_list_remove_empty_items()

 Improve the asymptotic performance of the cat_sort_uniq notes merge
 strategy.

 Will merge to 'master' in the fifth batch.


* mh/strbuf-split (2012-11-04) 4 commits
  (merged to 'next' on 2012-11-09 at fa984b1)
 + strbuf_split*(): document functions
 + strbuf_split*(): rename "delim" parameter to "terminator"
 + strbuf_split_buf(): simplify iteration
 + strbuf_split_buf(): use ALLOC_GROW()

 Cleanups and documentation for strbuf_split.

 Will merge to 'master' in the fifth batch.


* mm/maint-doc-commit-edit (2012-11-02) 1 commit
  (merged to 'next' on 2012-11-09 at 8dab7f5)
 + Document 'git commit --no-edit' explicitly

 Will merge to 'master' in the fifth batch.


* cr/push-force-tag-update (2012-11-12) 5 commits
 - push: update remote tags only with force
 - push: flag updates that require force
 - push: flag updates
 - push: add advice for rejected tag reference
 - push: return reject reasons via a mask

 Require "-f" for push to update a tag, even if it is a fast-forward.

 Needs review.

 I'm undecided yet on whether the goal is the right thing to do, but it
 does prevent some potential mistakes. I haven't looked closely at the
 implementation itself; review from interested parties would be helpful.


* fc/fast-export-fixes (2012-11-08) 14 commits
 - fast-export: don't handle uninteresting refs
 - fast-export: make sure updated refs get updated
 - fast-export: fix comparison in tests
 - fast-export: trivial cleanup
 - remote-testgit: make clear the 'done' feature
 - remote-testgit: report success after an import
 - remote-testgit: exercise more features
 - remote-testgit: cleanup tests
 - remote-testgit: remove irrelevant test
 - remote-testgit: get rid of non-local functionality
 - Add new simplified git-remote-testgit
 - Rename git-remote-testgit to git-remote-testpy
 - remote-testgit: fix direction of marks
 - fast-export: avoid importing blob marks

 Improvements to fix fast-export bugs, including how refs pointing to
 already-seen commits are handled. An earlier 4-commit version of this
 series looked good to me, but this much-expanded version has not seen
 any comments.

 Looks like it has been re-rolled, but I haven't checked it out yet.

 Needs review.


* mg/maint-pull-suggest-upstream-to (2012-11-08) 1 commit
  (merged to 'next' on 2012-11-13 at bd74252)
 + push/pull: adjust missing upstream help text to changed interface

 Follow-on to the new "--set-upstream-to" topic from v1.8.0 to avoid
 suggesting the deprecated "--set-upstream".

 Will merge to 'master' in the fifth batch.


* mh/alt-odb-string-list-cleanup (2012-11-08) 2 commits
  (merged to 'next' on 2012-11-13 at 2bf41d9)
 + link_alt_odb_entries(): take (char *, len) rather than two pointers
 + link_alt_odb_entries(): use string_list_split_in_place()

 Cleanups in the alternates code. Fixes a potential bug and makes the
 code much cleaner.

 Will merge to 'master' in the sixth batch.


* pf/editor-ignore-sigint (2012-11-11) 5 commits
 - launch_editor: propagate SIGINT from editor to git
 - run-command: do not warn about child death by SIGINT
 - run-command: drop silent_exec_failure arg from wait_or_whine
 - launch_editor: ignore SIGINT while the editor has control
 - launch_editor: refactor to use start/finish_command

 Avoid confusing cases where the user hits Ctrl-C while in the editor
 session, not realizing git will receive the signal. Since most editors
 will take over the terminal and will block SIGINT, this is not likely
 to confuse anyone.

 Some people raised issues with emacsclient, which are addressed by this
 re-roll. It should probably also handle SIGQUIT, and there were a
 handful of other review comments.

 Expecting a re-roll.


* pp/gitweb-config-underscore (2012-11-08) 1 commit
 - gitweb: make remote_heads config setting work

 The key "gitweb.remote_heads" is not legal git config; this maps it to
 "gitweb.remoteheads".

 Junio raised a good point about the implementation for three-level
 variables.

 Expecting a re-roll.


* pw/maint-p4-rcs-expansion-newline (2012-11-08) 1 commit
  (merged to 'next' on 2012-11-13 at e90cc7c)
 + git p4: RCS expansion should not span newlines

 I do not have p4 to play with, but looks obviously correct to me.

 Will merge to 'master' in the sixth batch.


* rh/maint-gitweb-highlight-ext (2012-11-08) 1 commit
  (merged to 'next' on 2012-11-13 at c57d856)
 + gitweb.perl: fix %highlight_ext mappings

 Fixes a clever misuse of perl's list interpretation.

 Will merge to 'master' in the sixth batch.


* rr/submodule-diff-config (2012-11-08) 3 commits
 - submodule: display summary header in bold
 - diff: introduce diff.submodule configuration variable
 - Documentation: move diff.wordRegex from config.txt to diff-config.txt

 Lets "git diff --submodule=log" become the default via configuration.

 Almost there. Looks like a new version has been posted, but I haven't
 picked it up yet.

 Needs review.
