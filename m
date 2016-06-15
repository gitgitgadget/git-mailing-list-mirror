From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Apr 2012, #01; Mon, 2)
Date: Mon, 02 Apr 2012 14:44:17 -0700
Message-ID: <7v4nt1erm6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 02 23:44:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEp36-0003Cz-3h
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 23:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977Ab2DBVoX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Apr 2012 17:44:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58719 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751861Ab2DBVoU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Apr 2012 17:44:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 284997F95;
	Mon,  2 Apr 2012 17:44:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=ViVSSUG7AhdAAW28vGh0nHVst
	Lk=; b=Rn03Dh6GhErwREbwRNzsfbd7YZ1lM7qqhHd88wDKqep9IL8Uwa0D7UUmS
	5SHB1mlnOClBPr0+QTiN3XbD1jiQcnwDarueNrlc9jaI84RuJAY1A3esM2hUn3mn
	YPmHzINijXO4c/WybNTk45VOARzPGIMe3fDWwEpB22qhJwqC1U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=j44CjtG5sERsGyzGnYC
	+qqm0K3Jcj2C9+ZWXUSsIyhyIY1utdaxc2FdstjjmTWodizAcOkH/7pHTge/B9gz
	V1b/yOlCPP2ilic3QAkCy85SIA/cMGA8ThTAYB7JS+lrVahg4ji4DvMoZveXqvMf
	ioki4iNCXva3gWsls9we2V68=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FCFD7F94;
	Mon,  2 Apr 2012 17:44:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27B8E7F93; Mon,  2 Apr 2012
 17:44:19 -0400 (EDT)
X-master-at: d82829b6128263951569221ca0c00dd143da055c
X-next-at: 534144fcf8debe1f1ee527931c7346ce866f9ef5
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 00595214-7D0D-11E1-AB78-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194568>

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' (proposed updates) while commits prefixed with '+' are in =
'next'.

It seems that a last minute bug or two slipped in with the latest gitk
updates, so I'll probably do the 1.7.10-rc4 tonight or tomorrow with th=
e
two patches posted yesterday and schedule the final by the end of the
week.  In the meantime, 1.7.9.6 is also out, to give GIT_MERGE_AUTOEDIT
support for the maintenance track.

You can find the changes described here in the integration branches of =
the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* pt/gitk (2012-04-02) 2 commits
 - gitk: fix setting font display with new tabbed dialog layout.
 - gitk: fix tabbed preferences construction when using tcl 8.4

Pat spotted and fixed a few bugs in the latest gitk updates; we may nee=
d
these in 1.7.10 so testing on various platforms is very much appreciate=
d.

* bw/spawn-via-shell-path (2012-03-31) 2 commits
 - fixup? Quote SHELL_PATH the same way as DEFAULT_EDITOR for C
 - Use SHELL_PATH from build system in run_command.c:prepare_shell_cmd

"sh" on the user's PATH may be utterly broken on some systems;
consistently use SHELL_PATH even from inside run-command API.

Will squash the fixup and schedule it to merge soon after 1.7.10.

* jc/commit-unedited-template (2012-04-01) 4 commits
 - git-commit.txt: clarify -t requires editing message
 - commit: rephrase the error when user did not touch templated log mes=
sage
 - commit: do not trigger bogus "has templated message edited" check
 - t7501: test the right kind of breakage

When "git commit --template F" errors out because the user did not touc=
h
the message, it claimed that it aborts due to "empty message", which wa=
s
utterly wrong.

* jc/push-upstream-sanity (2012-03-30) 1 commit
 - push: detect nonsense "upstream" check more carefully

"git push $there" without refspec, when the current branch is set to pu=
sh
to a remote different from $there, used to push to $there using the
upstream information to a remote unreleated to $there.

This is necessary if we were to switch the push.default to 'current'.

* jk/http-backend-keep-committer-ident-env (2012-03-30) 1 commit
 - http-backend: respect existing GIT_COMMITTER_* variables

The smart-http backend used to always override GIT_COMMITTER_* variable=
s
with REMOTE_USER and REMOTE_ADDR.

* mk/gitweb-diff-hl (2012-03-29) 8 commits
 - gitweb: Refinement highlightning in combined diffs
 - gitweb: Highlight interesting parts of diff
 - gitweb: Push formatting diff lines to print_diff_chunk()
 - gitweb: Move HTML-formatting diff line back to process_diff_line()
 - gitweb: Use print_diff_chunk() for both side-by-side and inline diff=
s
 - gitweb: Extract print_sidebyside_diff_lines()
 - gitweb: Pass esc_html_hl_regions() options to esc_html()
 - gitweb: esc_html_hl_regions(): Don't create empty <span> elements

* it/fetch-pack-many-refs (2012-04-02) 5 commits
 - remote-curl: main test case for the OS command line overflow
 - fetch-pack: test cases for the new --stdin option
 - fixup? no longer need flex argv[]
 - remote-curl: send the refs to fetch-pack on stdin
 - fetch-pack: new --stdin option to read refs from stdin

Will squash the fix-up one and then requeue.

* jn/debian-customizes-default-editor (2012-03-31) 3 commits
 - fixup? do not hide the "usual" default from readers
 - var doc: advertise current DEFAULT_PAGER and DEFAULT_EDITOR settings
 - var doc: default editor and pager are configurable at build time

Haven't heard anything back for the fix-up suggestion, but otherwise
looked sane.

* rs/commit-list-sort-in-batch (2012-04-02) 3 commits
 - revision: insert unsorted, then sort in prepare_revision_walk()
 - commit: use mergesort() in commit_list_sort_by_date()
 - add mergesort() for linked lists

--------------------------------------------------
[Stalled]

* lp/maint-diff-three-dash-with-graph (2012-03-20) 3 commits
 - t4202: add test for "log --graph --stat -p" separator lines
 - log --graph: fix break in graph lines
 - log --graph --stat: three-dash separator should come after graph lin=
es

The combination of two options "log --graph --stat" was an obscure corn=
er
case nobody cared about, and did not correctly show the ancestry graph
lines.

I've split the original patch into three pieces, one for fixes to two
different issues and a test.  Also the test is adjusted so that the ser=
ies
can be back-merged to older codebase that did not have 7f81463 (Use
correct grammar in diffstat summary line, 2012-02-01) that first appear=
ed
in v1.7.9.2

With a review from Zbigniew, I would expect that this would be rerolled
again.

* cn/apply-fix-ws-can-lengthen-lines (2012-03-11) 1 commit
 . apply: reallocate the postimage buffer when needed

Attempts to address an ancient bug that dates back to the addition
of an oddball "tab-in-indent" whitespace breakage class that wants
to have longer lines than the original when fixing things up.

Needs more work; results in double-frees.

* nd/columns (2012-03-13) 12 commits
 - column: support grouping entries
 - column: support "denser" mode
 - ls-files: support --column
 - tag: add --column
 - column: support piping stdout to external git-column process
 - status: add --column
 - branch: add --column
 - help: reuse print_columns() for help -a
 - column: add dense layout support
 - column: add columnar layout
 - Stop starting pager recursively
 - Add column layout skeleton and git-column

Rerolled again.  Modulo minor nits, looked nicer than the previous roun=
d.

* nd/threaded-index-pack (2012-03-11) 2 commits
 - index-pack: support multithreaded delta resolving
 - index-pack: split second pass obj handling into own function

Another reroll after a bugreport on pthread usage discovered by Ramsey,
but it seems the topic is cooking between Ramsay and Duy out of tree.
Waiting for resolution.

* jh/apply-free-patch (2012-03-28) 7 commits
 - apply.c: WIP ownership audit
 - apply: free unused fragments for submodule patch
 - apply: free patch->result
 - apply: release memory for fn_table
 - apply: free patch->{def,old,new}_name fields
 - apply: rename free_patch() to free_patch_list()
 - apply: do not leak patches and fragments

Valgrind reports quite a lot of discarded memory inside apply.  I start=
ed
auditing the memory ownership rules in the command, and am almost done.

Will defer til 1.7.10.

* ss/git-svn-prompt-sans-terminal (2012-01-04) 3 commits
 - fixup! 15eaaf4
 - git-svn, perl/Git.pm: extend Git::prompt helper for querying users
 - perl/Git.pm: "prompt" helper to honor GIT_ASKPASS and SSH_ASKPASS

The bottom one has been replaced with a rewrite based on comments
from =C3=86var. The second one needs more work, both in perl/Git.pm and
prompt.c, to give precedence to tty over SSH_ASKPASS when terminal
is available.

* jc/split-blob (2012-03-16) 6 commits
 - chunked-object: streaming checkout
 - chunked-object: fallback checkout codepaths
 - bulk-checkin: support chunked-object encoding
 - bulk-checkin: allow the same data to be multiply hashed
 - new representation types in the packstream
 - varint-in-pack: refactor varint encoding/decoding

Not ready.

I finished the streaming checkout codepath, but as explained in
127b177 (bulk-checkin: support chunked-object encoding, 2011-11-30),
these are still early steps of a long and painful journey. At least
pack-objects and fsck need to learn the new encoding for the series
to be usable locally, and then index-pack/unpack-objects needs to
learn it to be used remotely.

Given that I heard a lot of noise that people want large files, and
that I was asked by somebody at GitTogether'11 privately for an
advice on how to pay developers (not me) to help adding necessary
support, I am somewhat dissapointed that the original patch series
that was sent almost two months ago still remains here without much
comments and updates from the developer community. I even made the
interface to the logic that decides where to split chunks easily
replaceable, and I deliberately made the logic in the original patch
extremely stupid to entice others, especially the "bup" fanboys, to
come up with a better logic, thinking that giving people an easy
target to shoot for, they may be encouraged to help out. The plan is
not working :-(.

--------------------------------------------------
[Cooking]

* hv/submodule-recurse-push (2012-03-30) 3 commits
 - push: teach --recurse-submodules the on-demand option
 - Refactor submodule push check to use string list instead of integer
 - Teach revision walking machinery to walk multiple times sequencially

* dg/subtree (2012-03-25) 112 commits
 - Add 'contrib/subtree/' from commit '2e63f75b8f49abe220ef55ec4e978e7a=
3b8dc351'
 - Add Subtree Test Makefile
 - Build Subtree
 - Use Project Config Files
 - Remove Unneeded Files
 - ...

A test merge of the 'subtree'.

* jk/branch-quiet (2012-03-26) 2 commits
 - teach "git branch" a --quiet option
 - checkout: suppress tracking message with "-q"

Even with "-q"uiet option, "checkout" used to report setting up trackin=
g.
Also "branch" learns "-q"uiet option to squelch informational message.

* jk/run-command-eacces (2012-03-30) 1 commit
 - run-command: treat inaccessible directories as ENOENT

When PATH contains an unreadable directory, alias expansion code did no=
t
kick in, and failed with an error that said "git-subcmd" was not found.

* jb/am-include (2012-03-28) 1 commit
 - am: support --include option

* jc/am-report-3way (2012-03-28) 1 commit
 - am -3: list the paths that needed 3-way fallback

* rs/combine-diff-zero-context-at-the-beginning (2012-03-25) 1 commit
 - combine-diff: fix loop index underflow

=46ixes an age old corner case bug in combine diff (only triggered with=
 -U0
and the hunk at the beginning of the file needs to be shown).

* sl/autoconf (2012-03-26) 3 commits
 - configure: be more idiomatic
 - configure: avoid some code repetitions thanks to m4_{push,pop}def
 - configure: move definitions of private m4 macros before AC_INIT invo=
cation

Updates our configure.ac to follow a better "autoconf" style.

* wk/gitweb-snapshot-use-if-modified-since (2012-03-30) 3 commits
 - gitweb: add If-Modified-Since handling to git_snapshot().
 - gitweb: refactor If-Modified-Since handling
 - gitweb: add `status` headers to git_feed() responses.

Makes 'snapshot' request to "gitweb" honor If-Modified-Since: header,
based on the commit date.

* jk/diff-no-rename-empty (2012-03-23) 4 commits
 - merge-recursive: don't detect renames of empty files
 - teach diffcore-rename to optionally ignore empty content
 - make is_empty_blob_sha1 available everywhere
 - drop casts from users EMPTY_TREE_SHA1_BIN

=46orbids rename detection logic from matching two empty files as renam=
es
during merge-recursive to prevent mismerges.

* th/difftool-diffall (2012-03-29) 9 commits
 - difftool: print list of valid tools with '--tool-help'
 - difftool: teach difftool to handle directory diffs
 - difftool: replace system call with Git::command_noisy
 - difftool: eliminate setup_environment function
 - difftool: stop appending '.exe' to git
 - difftool: remove explicit change of PATH
 - difftool: exit(0) when usage is printed
 - difftool: add '--no-gui' option
 - difftool: parse options using Getopt::Long

Rolls the two-directory-diff logic from diffall script (in contrib/) in=
to
"git difftool" framework.=20

* jc/maint-clean-nested-worktree-in-subdir (2012-03-15) 2 commits
  (merged to 'next' on 2012-03-20 at fb5485e)
 + clean: preserve nested git worktree in subdirectories
 + remove_dir_recursively(): Add flag for skipping removal of toplevel =
dir
 (this branch is tangled with jh/notes-merge-in-git-dir-worktree.)

"git clean -d -f" (not "-d -f -f") is supposed to protect nested workin=
g
trees of independent git repositories that exist in the current project
working tree from getting removed, but the protection applied only to s=
uch
working trees that are at the top-level of the current project by mista=
ke.

Not urgent.

* ct/advise-push-default (2012-03-26) 2 commits
  (merged to 'next' on 2012-03-28 at 62764ae)
 + clean up struct ref's nonfastforward field
 + push: Provide situational hints for non-fast-forward errors

Breaks down the cases in which "git push" fails due to non-ff into thre=
e
categories, and gives separate advise messages.  This should be a good
change regardless of mm/push-default-switch-warning topic.

* nl/rebase-i-cheat-sheet (2012-03-20) 1 commit
  (merged to 'next' on 2012-03-20 at 3092a2b)
 + rebase -i: remind that the lines are top-to-bottom

Not urgent.

* da/difftool-test (2012-03-19) 1 commit
  (merged to 'next' on 2012-03-20 at 0ada7d4)
 + t7800: Test difftool passing arguments to diff

Makes sure "difftool" options can be given in any order.

* jh/notes-merge-in-git-dir-worktree (2012-03-15) 4 commits
  (merged to 'next' on 2012-03-20 at 0c1b1de)
 + notes-merge: Don't remove .git/NOTES_MERGE_WORKTREE; it may be the u=
ser's cwd
 + notes-merge: use opendir/readdir instead of using read_directory()
 + t3310: illustrate failure to "notes merge --commit" inside $GIT_DIR/
 + remove_dir_recursively(): Add flag for skipping removal of toplevel =
dir
 (this branch is tangled with jc/maint-clean-nested-worktree-in-subdir.=
)

Running "notes merge --commit" failed to perform correctly when run
from any directory inside $GIT_DIR/.  When "notes merge" stops with
conflicts, $GIT_DIR/NOTES_MERGE_WORKTREE is the place a user edits
to resolve it.

Not urgent.

* jn/diffstat-tests (2012-03-13) 7 commits
  (merged to 'next' on 2012-03-20 at 8791b2f)
 + diffstat summary line varies by locale: miscellany
 + test: use numstat instead of diffstat in binary-diff test
 + test: use --numstat instead of --stat in "git stash show" tests
 + test: test cherry-pick functionality and output separately
 + test: modernize funny-names test style
 + test: use numstat instead of diffstat in funny-names test
 + test: use test_i18ncmp when checking --stat output

Some tests checked the "diff --stat" output when they do not have to,
which unnecessarily made things harder to verify under GETTEXT_POISON.

Not urgent.

* tr/maint-word-diff-regex-sticky (2012-03-14) 3 commits
  (merged to 'next' on 2012-03-20 at b3f67cd)
 + diff: tweak a _copy_ of diff_options with word-diff
 + diff: refactor the word-diff setup from builtin_diff_cmd
 + t4034: diff.*.wordregex should not be "sticky" in --word-diff

The regexp configured with wordregex was incorrectly reused across
files.
Not urgent.

* zj/test-cred-helper-nicer-prove (2012-03-15) 2 commits
  (merged to 'next' on 2012-03-20 at b675ec1)
 + t0303: resurrect commit message as test documentation
 + t0303: immediately bail out w/o GIT_TEST_CREDENTIAL_HELPER

Minor improvement to t0303.
Not urgent.

* jc/commit-hook-authorship (2012-03-11) 3 commits
  (merged to 'next' on 2012-03-12 at 05ca7f8)
 + commit: pass author/committer info to hooks
 + t7503: does pre-commit-hook learn authorship?
 + ident.c: add split_ident_line() to parse formatted ident line
 (this branch is tangled with jc/run-hook-env-1.)

"git commit --author=3D$name" did not tell the name that was being
recorded in the resulting commit to hooks, even though it does do so
when the end user overrode the authorship via the "GIT_AUTHOR_NAME"
environment variable.  This is a simpler of the two approaches.

Will defer til 1.7.10.

* jc/run-hook-env-1 (2012-03-11) 3 commits
 - run_hook(): enhance the interface to pass arbitrary environment
 + t7503: does pre-commit-hook learn authorship?
 + ident.c: add split_ident_line() to parse formatted ident line
 (this branch is tangled with jc/commit-hook-authorship.)

Not urgent.

Updates run_hook() API to be much less specific to "commit".  It would
only be useful if people start doing more interesting things with hooks=
=2E

* jc/diff-algo-cleanup (2012-02-19) 2 commits
  (merged to 'next' on 2012-03-15 at cca0032)
 + xdiff: PATIENCE/HISTOGRAM are not independent option bits
 + xdiff: remove XDL_PATCH_* macros

Resurrects the preparatory clean-up patches from another topic that was
discarded, as this would give a saner foundation to build on diff.algo
configuration option series.

Not urgent.

* rs/unpack-trees-leakfix (2012-03-06) 1 commit
  (merged to 'next' on 2012-03-07 at 69a69cd)
 + unpack-trees: plug minor memory leak

Will defer til 1.7.10.

* mm/push-default-switch-warning (2012-03-09) 1 commit
  (merged to 'next' on 2012-03-28 at 074b16b)
 + push: start warning upcoming default change for push.default

Not urgent.

This resurrects an ancient patch I wrote during a discussion we had in =
the
1.6.3-1.6.4 era.  This should probably come after ct/advise-push-defaul=
t
topic and at that point the advise messages need to be rephrased, takin=
g
the future default change into account.

* jc/fmt-merge-msg-people (2012-03-13) 1 commit
 - fmt-merge-msg: show those involved in a merged series

The "fmt-merge-msg" command learns to list the primary contributors
involved in the side topic you are merging.

Will defer til 1.7.10.

* nl/http-proxy-more (2012-03-15) 5 commits
  (merged to 'next' on 2012-03-20 at c004001)
 + http: rename HTTP_REAUTH to HTTP_AUTH_RETRY
 + http: Avoid limit of retrying request only twice
 + http: handle proxy authentication failure (error 407)
 + http: handle proxy proactive authentication
 + http: try http_proxy env var when http.proxy config option is not se=
t

The code to talk to http proxies learn to use the same credential
API used to talk to the final http destinations.

Will defer til 1.7.10.

* nd/stream-more (2012-03-07) 7 commits
  (merged to 'next' on 2012-03-07 at 7325922)
 + update-server-info: respect core.bigfilethreshold
 + fsck: use streaming API for writing lost-found blobs
 + show: use streaming API for showing blobs
 + parse_object: avoid putting whole blob in core
 + cat-file: use streaming API to print blobs
 + Add more large blob test cases
 + streaming: make streaming-write-entry to be more reusable

Use API to read blob data in smaller chunks in more places to
reduce the memory footprint.  In general, looked fairly good.

Will defer til 1.7.10.

--------------------------------------------------
[Discarded]

* tb/maint-remove-irrelevant-i18n-test (2012-03-06) 1 commit
  (merged to 'next' on 2012-03-07 at 23f2dd1)
 + t0204: remove a test that checks undefined behaviour

I tentatively parked this in 'next' but later reverted the merge.

* dg/test-from-elsewhere (2012-03-04) 2 commits
 . Support out-of-tree Valgrind tests
 . Allow overriding GIT_BUILD_DIR

No immediate need; dropped.
