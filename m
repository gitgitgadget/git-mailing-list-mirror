From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2012, #09; Mon, 26)
Date: Mon, 26 Mar 2012 16:16:24 -0700
Message-ID: <7vzkb3kl6f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 27 01:16:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCJ9O-0006Vs-UR
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 01:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757513Ab2CZXQ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Mar 2012 19:16:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51807 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753003Ab2CZXQ1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2012 19:16:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D31A77220;
	Mon, 26 Mar 2012 19:16:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=cz5ddD//NMMZXk/Uh4qHx+TaN
	zs=; b=Sl8Xdpj39jiJRSERANBNFxsHlTSS+2l6z9XAFuUlT+X8Kp9u52ai70l6+
	V/MT9phdmrXkBCW8YSYtLBEoQYTdFf2tZLDodN08UKEqGFsb+SQS4fQYhiYELP/s
	xyHDTse+mm4WEC7o3uFERHBTwUNippiJPmU3CrOPIfvdMfIV1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=KUZyDjdKBTXFHAUkqqQ
	sZLuzfcPDoThzI2D9jfyj5/8vp53TnoVwRFOJb0sErVMcuZw9UO2UhT8aFOrxvTn
	xKBdqyH5usED3bdXAZlXg6HkQX9pP2sRyxTsCTKsEnFQbhh7K/7vjRxNpgwHxUhM
	Irg2eKkAy+pTyZ8Ov6fbJ7+8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1662721F;
	Mon, 26 Mar 2012 19:16:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DDC0D7215; Mon, 26 Mar 2012
 19:16:25 -0400 (EDT)
X-master-at: fae9d761c78cba1039854b51df6c2f7360e59cba
X-next-at: 74cd462aafcd177c1507741065d5836c6f8424aa
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B5A7A144-7799-11E1-BED3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193985>

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' (proposed updates) while commits prefixed with '+' are in =
'next'.

The updates for "gitk" part is now ready for 1.7.10.

You can find the changes described here in the integration branches of =
the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

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

* jh/apply-free-patch (2012-03-21) 4 commits
 - apply.c: WIP ownership audit
 - apply: free patch->result
 - apply: free patch->{def,old,new}_name fields
 - apply: do not leak patches and fragments

Valgrind reports quite a lot of discarded memory inside apply. I have a
slight suspicion that we should first clarify the ownership rules of
pieces of memory in this standalone program that was designed to be "ru=
n
once and let exit take care of the memory" before proceeding further.

Will defer til 1.7.10.

* dg/test-from-elsewhere (2012-03-04) 2 commits
 - Support out-of-tree Valgrind tests
 - Allow overriding GIT_BUILD_DIR

Better support for out-of-tree test scripts, but it appears that the
approach needs to be rethought.  By repointing TEST_DIRECTORY to a
directory other than $(pwd)/.., an out of place test script can reach
test helpers and freshly built Git relative to it (GIT_BUILD_DIR is
a mere short-hand for $TEST_DIRECTORY/..).

Discussion stalled.

* hv/submodule-recurse-push (2012-02-13) 3 commits
 - push: teach --recurse-submodules the on-demand option
 - Refactor submodule push check to use string list instead of integer
 - Teach revision walking machinery to walk multiple times sequencially

The bottom one was not clearly explained and needs a reroll.

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

* wk/gitweb-snapshot-use-if-modified-since (2012-03-26) 3 commits
 - gitweb: add If-Modified-Since handling to git_snapshot().
 - gitweb: refactor If-Modified-Since handling
 - gitweb: add `status` headers to git_feed() responses.

Makes 'snapshot' request to "gitweb" honor If-Modified-Since: header,
based on the commit date.

* jc/maint-merge-autoedit (2012-03-20) 1 commit
 - merge: backport GIT_MERGE_AUTOEDIT support

In 1.7.10, we added GIT_MERGE_AUTOEDIT=3Dno environment variable to hel=
p
older scripts to let them refuse giving users a chance to explain the
merge, but forgot that 1.7.9 automatically opens an editor when merging=
 an
annotated tag, and there is no equivalent escape hatch.  A merge of thi=
s
topic to 1.7.10 track becomes a no-op, but we may want to apply this to
the 1.7.9.x series.

* jk/diff-no-rename-empty (2012-03-23) 4 commits
 - merge-recursive: don't detect renames of empty files
 - teach diffcore-rename to optionally ignore empty content
 - make is_empty_blob_sha1 available everywhere
 - drop casts from users EMPTY_TREE_SHA1_BIN

=46orbids rename detection logic from matching two empty files as renam=
es
during merge-recursive to prevent mismerges.

* th/difftool-diffall (2012-03-26) 9 commits
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
 - clean up struct ref's nonfastforward field
 - push: Provide situational hints for non-fast-forward errors

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
 - push: start warning upcoming default change for push.default

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
