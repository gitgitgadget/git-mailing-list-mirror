From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2013, #04; Sat, 9)
Date: Sat, 09 Feb 2013 15:39:33 -0800
Message-ID: <7vtxplt5u2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 10 00:40:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4K1a-0004Kc-PC
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 00:40:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760878Ab3BIXji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 18:39:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62551 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370Ab3BIXjg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 18:39:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1759B9B3;
	Sat,  9 Feb 2013 18:39:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=Y
	TX3pdrTC/O5h9rJZnvxCwrh+no=; b=k47Rec+BI/1f7J3lwyP9b7VmojOa9biEw
	cxK+9ZxwnaOtgyEvh3cyJwZICN2IsH3QnHe3Zgmfy+qnaMXwIfwliQgukU6Xr5Ys
	QIyAL2oeidf/hmSPhtaBidx9WzDsMBctRanpeCjP0/FErazpJEWCxHrkr1FDZNos
	TYaAKaACsg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Q4a
	lg40SvhZQnn/v2vCMGAOZu1G9mAWuTyfQPJaT0q4uwifqtu0E0d8cGTNm3RNelke
	H/hz7+YAgcricXKHeP7Po2uYoP5PkolwxIJjiEAZB00bZBDcF/wW9b+1Y9w/XX3I
	qDHnxmnpyXlKjSsA7wgDTayDcVNulO7J0Ox0pVPs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C20F7B9B2;
	Sat,  9 Feb 2013 18:39:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B252EB9AF; Sat,  9 Feb 2013
 18:39:34 -0500 (EST)
X-master-at: b3310b5e2f576ef807f90eab0e6e178b65bbfb55
X-next-at: f4474081034ce8695a8a64dcf1a0414f6544ae2c
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F5A48FE0-7311-11E2-B0F6-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215885>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

As usual, this cycle is expected to last for 8 to 10 weeks, with a
preview -rc0 late next week.  I expect that topics that are not
mentioned in this message will not have enough time to be in the
upcomming release (unless they are obvious regression fixes or
documentation updates).

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ab/gitweb-use-same-scheme (2013-01-28) 1 commit
  (merged to 'next' on 2013-02-02 at 7e4a108)
 + gitweb: refer to picon/gravatar images over the same scheme

 Avoid mixed contents on a page coming via http and https when
 gitweb is hosted on a https server.


* ct/autoconf-htmldir (2013-02-02) 1 commit
  (merged to 'next' on 2013-02-05 at bba4f8c)
 + Honor configure's htmldir switch

 The autoconf subsystem passed --mandir down to generated
 config.mak.autogen but forgot to do the same for --htmldir.


* da/mergetool-docs (2013-02-02) 5 commits
  (merged to 'next' on 2013-02-03 at f822dcf)
 + doc: generate a list of valid merge tools
 + mergetool--lib: list user configured tools in '--tool-help'
 + mergetool--lib: add functions for finding available tools
 + mergetool--lib: improve the help text in guess_merge_tool()
 + mergetool--lib: simplify command expressions
 (this branch uses jk/mergetool.)

 Build on top of the clean-up done by jk/mergetool and automatically
 generate the list of mergetool and difftool backends the build
 supports to be included in the documentation.


* jc/combine-diff-many-parents (2013-02-05) 2 commits
  (merged to 'next' on 2013-02-05 at e382aa6)
 + t4038: add tests for "diff --cc --raw <trees>"
 + combine-diff: lift 32-way limit of combined diff

 We used to have an arbitrary 32 limit for combined diff input,
 resulting in incorrect number of leading colons shown when showing
 the "--raw --cc" output.


* jk/apply-similaritly-parsing (2013-02-03) 1 commit
  (merged to 'next' on 2013-02-05 at ccf1c97)
 + builtin/apply: tighten (dis)similarity index parsing

 Make sure the similarity value shown in the "apply --summary"
 output is sensible, even when the input had a bogus value.


* jk/doc-makefile-cleanup (2013-02-01) 1 commit
  (merged to 'next' on 2013-02-02 at 86ff373)
 + Documentation/Makefile: clean up MAN*_TXT lists


* jk/mergetool (2013-01-28) 8 commits
  (merged to 'next' on 2013-02-03 at 2ff5dee)
 + mergetools: simplify how we handle "vim" and "defaults"
 + mergetool--lib: don't call "exit" in setup_tool
 + mergetool--lib: improve show_tool_help() output
 + mergetools/vim: remove redundant diff command
 + git-difftool: use git-mergetool--lib for "--tool-help"
 + git-mergetool: don't hardcode 'mergetool' in show_tool_help
 + git-mergetool: remove redundant assignment
 + git-mergetool: move show_tool_help to mergetool--lib
 (this branch is used by da/mergetool-docs.)

 Cleans up mergetool/difftool combo.


* jk/python-styles (2013-01-30) 1 commit
  (merged to 'next' on 2013-02-02 at 293edc1)
 + CodingGuidelines: add Python coding guidelines


* jk/remote-helpers-doc (2013-02-01) 1 commit
  (merged to 'next' on 2013-02-02 at ce1461a)
 + Rename {git- => git}remote-helpers.txt

 "git help remote-helpers" did not work; 'remote-helpers' is not
 a subcommand name but a concept, so its documentation should have
 been in gitremote-helpers, not git-remote-helpers.


* mk/tcsh-complete-only-known-paths (2013-02-03) 1 commit
  (merged to 'next' on 2013-02-05 at 4409b08)
 + completion: handle path completion and colon for tcsh script
 (this branch uses mp/complete-paths.)

 Manlio's "complete with known paths only" update to completion
 scripts returns directory names without trailing slash to
 compensate the addition of '/' done by bash that reads from our
 completion result.  tcsh completion code that reads from our
 internal completion result does not add '/', so let it ask our
 complletion code to keep the '/' at the end.


* mp/complete-paths (2013-01-11) 1 commit
  (merged to 'next' on 2013-01-30 at 70e4f1a)
 + git-completion.bash: add support for path completion
 (this branch is used by mk/tcsh-complete-only-known-paths.)

 The completion script used to let the default completer to suggest
 pathnames, which gave too many irrelevant choices (e.g. "git add"
 would not want to add an unmodified path).  Teach it to use a more
 git-aware logic to enumerate only relevant ones.


* nd/branch-error-cases (2013-01-31) 6 commits
  (merged to 'next' on 2013-02-02 at cf5e745)
 + branch: let branch filters imply --list
 + docs: clarify git-branch --list behavior
 + branch: mark more strings for translation
 + Merge branch 'nd/edit-branch-desc-while-detached' into HEAD
 + branch: give a more helpful message on redundant arguments
 + branch: reject -D/-d without branch name

 Fix various error messages and conditions in "git branch", e.g. we
 advertised "branch -d/-D" to remove one or more branches but actually
 implemented removal of zero or more branches---request to remove no
 branches was not rejected.


* sb/gpg-i18n (2013-01-31) 1 commit
  (merged to 'next' on 2013-02-02 at 7a54574)
 + gpg: allow translation of more error messages


* sb/run-command-fd-error-reporting (2013-02-01) 1 commit
  (merged to 'next' on 2013-02-02 at be7e970)
 + run-command: be more informative about what failed


* ss/mergetools-tortoise (2013-02-01) 2 commits
  (merged to 'next' on 2013-02-03 at d306b83)
 + mergetools: teach tortoisemerge to handle filenames with SP correctly
 + mergetools: support TortoiseGitMerge

 Update mergetools to work better with newer merge helper tortoise ships.

--------------------------------------------------
[New Topics]

* jc/fetch-raw-sha1 (2013-02-07) 4 commits
 - fetch: fetch objects by their exact SHA-1 object names
 - upload-pack: optionally allow fetching from the tips of hidden refs
 - fetch: use struct ref to represent refs to be fetched
 - parse_fetch_refspec(): clarify the codeflow a bit
 (this branch uses jc/hidden-refs.)

 Allows requests to fetch objects at any tip of refs (including
 hidden ones).  It seems that there may be use cases even outside
 Gerrit (e.g. $gmane/215701).


* jk/diff-graph-cleanup (2013-02-07) 6 commits
 - combine-diff.c: teach combined diffs about line prefix
 - diff.c: use diff_line_prefix() where applicable
 - diff: add diff_line_prefix function
 - diff.c: make constant string arguments const
 - diff: write prefix to the correct file
 - graph: output padding for merge subsequent parents

 Refactors a lot of repetitive code sequence from the graph drawing
 code and adds it to the combined diff output.

 Will merge to 'next'.


* mn/send-email-works-with-credential (2013-02-07) 5 commits
 - git-send-email: use git credential to obtain password
 - Git.pm: add interface for git credential command
 - Git.pm: allow pipes to be closed prior to calling command_close_bidi_pipe
 - Git.pm: fix example in command_close_bidi_pipe documentation
 - Git.pm: allow command_close_bidi_pipe to be called as method

 Hooks the credential system to send-email.

 Expecting a reroll.
 $gmane/215752


* tz/perl-styles (2013-02-06) 1 commit
  (merged to 'next' on 2013-02-09 at c8cff17)
 + Update CodingGuidelines for Perl

 Add coding guidelines for writing Perl scripts for Git.

 Will merge to 'master'.


* al/mergetool-printf-fix (2013-02-08) 1 commit
 - git-mergetool: print filename when it contains %

 Will merge to 'next'.


* jk/error-const-return (2013-02-08) 1 commit
 - Use __VA_ARGS__ for all of error's arguments

 Will merge to 'next'.


* mm/allow-contrib-build (2013-02-07) 2 commits
 - perl.mak: introduce $(GIT_ROOT_DIR) to allow inclusion from other directories
 - Makefile: extract perl-related rules to make them available from other dirs

 Will merge to 'next'.


* mm/remote-mediawiki-build (2013-02-08) 2 commits
 - git-remote-mediawiki: use toplevel's Makefile
 - Makefile: make script-related rules usable from subdirectories

 Will merge to 'next'.


* nd/branch-show-rebase-bisect-state (2013-02-08) 1 commit
 - branch: show rebase/bisect info when possible instead of "(no branch)"

 Will merge to 'next'.


* nd/count-garbage (2013-02-08) 3 commits
 - count-objects: report how much disk space taken by garbage files
 - count-objects: report garbage files in pack directory too
 - git-count-objects.txt: describe each line in -v output

 Expecting a reroll.
 $gmane/215843


* wk/gc-auto-is-available-these-days (2013-02-08) 1 commit
 - user-manual: Rewrite git-gc section for automatic packing

 Will merge to 'next'.


* wk/man-deny-current-branch-is-default-these-days (2013-02-08) 1 commit
 - user-manual: Update for receive.denyCurrentBranch=refuse

 Will merge to 'next'.


* bw/get-tz-offset-perl (2013-02-09) 3 commits
 - cvsimport: format commit timestamp ourselves without using strftime
 - perl/Git.pm: fix get_tz_offset to properly handle DST boundary cases
 - Move Git::SVN::get_tz to Git::get_tz_offset

 Will merge to 'next'.


* mg/bisect-doc (2013-02-09) 1 commit
 - git-bisect.txt: clarify that reset finishes bisect

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* mp/diff-algo-config (2013-01-16) 3 commits
 - diff: Introduce --diff-algorithm command line option
 - config: Introduce diff.algorithm variable
 - git-completion.bash: Autocomplete --minimal and --histogram for git-diff

 Add diff.algorithm configuration so that the user does not type
 "diff --histogram".

 Looking better; may want tests to protect it from future breakages,
 but otherwise it looks ready for 'next'.

 Expecting a follow-up to add tests.


* mb/gitweb-highlight-link-target (2012-12-20) 1 commit
 - Highlight the link target line in Gitweb using CSS

 Expecting a reroll.
 $gmane/211935


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


* rc/maint-complete-git-p4 (2012-09-24) 1 commit
 - Teach git-completion about git p4

 Comment from Pete will need to be addressed ($gmane/206172).


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


* jc/add-delete-default (2012-08-13) 1 commit
 - git add: notice removal of tracked paths by default

 "git add dir/" updated modified files and added new files, but does
 not notice removed files, which may be "Huh?" to some users.  They
 can of course use "git add -A dir/", but why should they?

 Resurrected from graveyard, as I thought it was a worthwhile thing
 to do in the longer term.

 Stalled mostly due to lack of responses.


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

 Expecting a reroll.
 $gmane/210151

 "The first remote becomes the default" bit is better done as a
 separate step.


* nd/parse-pathspec (2013-01-11) 20 commits
 . Convert more init_pathspec() to parse_pathspec()
 . Convert add_files_to_cache to take struct pathspec
 . Convert {read,fill}_directory to take struct pathspec
 . Convert refresh_index to take struct pathspec
 . Convert report_path_error to take struct pathspec
 . checkout: convert read_tree_some to take struct pathspec
 . Convert unmerge_cache to take struct pathspec
 . Convert read_cache_preload() to take struct pathspec
 . add: convert to use parse_pathspec
 . archive: convert to use parse_pathspec
 . ls-files: convert to use parse_pathspec
 . rm: convert to use parse_pathspec
 . checkout: convert to use parse_pathspec
 . rerere: convert to use parse_pathspec
 . status: convert to use parse_pathspec
 . commit: convert to use parse_pathspec
 . clean: convert to use parse_pathspec
 . Export parse_pathspec() and convert some get_pathspec() calls
 . Add parse_pathspec() that converts cmdline args to struct pathspec
 . pathspec: save the non-wildcard length part

 Uses the parsed pathspec structure in more places where we used to
 use the raw "array of strings" pathspec.

 Ejected from 'pu' for now; will take a look at the rerolled one
 later ($gmane/213340).

--------------------------------------------------
[Cooking]

* jc/extended-fake-ancestor-for-gitlink (2013-02-05) 1 commit
  (merged to 'next' on 2013-02-09 at 2d3547b)
 + apply: verify submodule commit object name better

 Instead of requiring the full 40-hex object names on the index
 line, we can read submodule commit object names from the textual
 diff when synthesizing a fake ancestore tree for "git am -3".

 Will merge to 'master'.


* tz/credential-authinfo (2013-02-05) 1 commit
 - Add contrib/credentials/netrc with GPG support

 A new read-only credential helper (in contrib/) to interact with
 the .netrc/.authinfo files.  Hopefully mn/send-email-authinfo topic
 can rebuild on top of something like this.

 Expecting a reroll.
 $gmane/215556


* jx/utf8-printf-width (2013-02-09) 1 commit
 - Add utf8_fprintf helper that returns correct number of columns

 Use a new helper that prints a message and counts its display width
 to align the help messages parse-options produces.

 Will merge to 'next'.


* dg/subtree-fixes (2013-02-05) 6 commits
  (merged to 'next' on 2013-02-09 at 8f19ebe)
 + contrib/subtree: make the manual directory if needed
 + contrib/subtree: honor DESTDIR
 + contrib/subtree: fix synopsis
 + contrib/subtree: better error handling for 'subtree add'
 + contrib/subtree: use %B for split subject/body
 + contrib/subtree: remove test number comments

 contrib/subtree updates, but here are only the ones that looked
 ready to be merged to 'next'.  For the remainder, they will have
 another day.

 Will merge to 'master'.


* jl/submodule-deinit (2013-02-06) 1 commit
 - submodule: add 'deinit' command

 There was no Porcelain way to say "I no longer am interested in
 this submodule", once you express your interest in a submodule with
 "submodule init".  "submodule deinit" is the way to do so.

 Will merge to 'next'.


* jc/remove-export-from-config-mak-in (2013-02-03) 1 commit
  (merged to 'next' on 2013-02-07 at 33f7d4f)
 + config.mak.in: remove unused definitions

 config.mak.in template had an "export" line to cause a few
 common makefile variables to be exported; if they need to be
 expoted for autoconf/configure users, they should also be exported
 for people who write config.mak the same way.  Move the "export" to
 the main Makefile.


* nd/status-show-in-progress (2013-02-05) 1 commit
 - status: show the branch name if possible in in-progress info

 Will merge to 'next'.


* sp/smart-http-content-type-check (2013-02-06) 3 commits
  (merged to 'next' on 2013-02-06 at 8bc6434)
 + http_request: reset "type" strbuf before adding
  (merged to 'next' on 2013-02-05 at 157812c)
 + t5551: fix expected error output
  (merged to 'next' on 2013-02-04 at d0759cb)
 + Verify Content-Type from smart HTTP servers

 The smart HTTP clients forgot to verify the content-type that comes
 back from the server side to make sure that the request is being
 handled properly.

 Will merge to 'master'.


* jc/mention-tracking-for-pull-default (2013-01-31) 1 commit
 - doc: mention tracking for pull.default

 We stopped mentioning `tracking` is a deprecated but supported
 synonym for `upstream` in pull.default even though we have no
 intention of removing the support for it.

 This is my "don't list it to catch readers' eyes, but make sure it
 can be found if the reader looks for it" version; I'm not married
 to the layout and will be happy to take a replacement patch.

 Waiting for couter-proposal patches.


* jc/hidden-refs (2013-02-07) 3 commits
 - upload/receive-pack: allow hiding ref hierarchies
 - upload-pack: simplify request validation
 - upload-pack: share more code
 (this branch is used by jc/fetch-raw-sha1.)

 Allow the server side to redact the refs/ namespace it shows to the
 client.

 I think this is ready for 'next'.


* jc/remove-treesame-parent-in-simplify-merges (2013-01-17) 1 commit
  (merged to 'next' on 2013-01-30 at b639b47)
 + simplify-merges: drop merge from irrelevant side branch

 The --simplify-merges logic did not cull irrelevant parents from a
 merge that is otherwise not interesting with respect to the paths
 we are following.

 This touches a fairly core part of the revision traversal
 infrastructure; even though I think this change is correct, please
 report immediately if you find any unintended side effect.

 Will cook in 'next'.


* jc/push-2.0-default-to-simple (2013-01-16) 14 commits
  (merged to 'next' on 2013-01-16 at 23f5df2)
 + t5570: do not assume the "matching" push is the default
 + t5551: do not assume the "matching" push is the default
 + t5550: do not assume the "matching" push is the default
  (merged to 'next' on 2013-01-09 at 74c3498)
 + doc: push.default is no longer "matching"
 + push: switch default from "matching" to "simple"
 + t9401: do not assume the "matching" push is the default
 + t9400: do not assume the "matching" push is the default
 + t7406: do not assume the "matching" push is the default
 + t5531: do not assume the "matching" push is the default
 + t5519: do not assume the "matching" push is the default
 + t5517: do not assume the "matching" push is the default
 + t5516: do not assume the "matching" push is the default
 + t5505: do not assume the "matching" push is the default
 + t5404: do not assume the "matching" push is the default

 Will cook in 'next' until Git 2.0 ;-).


* bc/append-signed-off-by (2013-01-27) 11 commits
 - Unify appending signoff in format-patch, commit and sequencer
 - format-patch: update append_signoff prototype
 - t4014: more tests about appending s-o-b lines
 - sequencer.c: teach append_signoff to avoid adding a duplicate newline
 - sequencer.c: teach append_signoff how to detect duplicate s-o-b
 - sequencer.c: always separate "(cherry picked from" from commit body
 - sequencer.c: recognize "(cherry picked from ..." as part of s-o-b footer
 - t/t3511: add some tests of 'cherry-pick -s' functionality
 - t/test-lib-functions.sh: allow to specify the tag name to test_commit
 - commit, cherry-pick -s: remove broken support for multiline rfc2822 fields
 - sequencer.c: rework search for start of footer to improve clarity

 Waiting for the final round of reroll before merging to 'next'.
 After that we will go incremental.

--------------------------------------------------
[Discarded]

* mn/send-email-authinfo (2013-01-29) 1 commit
 . git-send-email: add ~/.authinfo parsing

 Instead of making send-email directly read from .netrc/.authinfo,
 mn/send-email-works-with-credential topic hooks the program to our
 credential framework, and tz/credential-authinfo topic gives access
 to these file formats to credential consumers.
