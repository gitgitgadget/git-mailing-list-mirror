From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Apr 2012, #09; Mon, 23)
Date: Mon, 23 Apr 2012 15:04:39 -0700
Message-ID: <xmqq8vhmhzpk.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 00:04:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMRNK-0003CR-Eh
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 00:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754917Ab2DWWEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 18:04:45 -0400
Received: from mail-wi0-f202.google.com ([209.85.212.202]:42798 "EHLO
	mail-wi0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828Ab2DWWEm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 18:04:42 -0400
Received: by wibhj13 with SMTP id hj13so1026wib.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 15:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:subject:x-master-at:x-next-at:date:message-id:user-agent
         :mime-version:content-type:x-gm-message-state;
        bh=7cGv8el2j/ZUy9ZFPp8LBegawzWWSAzJqPfsbm2Wj9I=;
        b=G58fuT3TwbCxCOXfau/10up3XPXEJh3s37AAVTNl+qP/MwQCsgbCUTCefBDJ/eRYw6
         JRXdUcPKOI0E1WZTZsrQJf35u+ofbgGC6DCfqo0F3IEcnFF4qfnI+I9k2nKoyfbAaIf6
         bAp9M3wQJSvMEoQG1LsniulAVK0JIVI+IQw5sy2XfUrzeLuoTmIp+vQAQdK8vLCfcLEq
         UBhcoSat06jBKBaDFq4BC3u/hiFxweePv520T3P8Cmso2AKnDAr3Aiq12jRyuANXvWR4
         sV9bvy710kjnctzYZ/Lu5WZnI2w75a0/yX3brtJn6+NcOc0pQSgIL2Et5J5f+wYf1EuY
         3KWw==
Received: by 10.213.19.197 with SMTP id c5mr1372988ebb.20.1335218681454;
        Mon, 23 Apr 2012 15:04:41 -0700 (PDT)
Received: by 10.213.19.197 with SMTP id c5mr1372980ebb.20.1335218681319;
        Mon, 23 Apr 2012 15:04:41 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id s9si15826533eei.3.2012.04.23.15.04.41
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Mon, 23 Apr 2012 15:04:41 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id CBA0520004E;
	Mon, 23 Apr 2012 15:04:40 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 231D2E120A; Mon, 23 Apr 2012 15:04:40 -0700 (PDT)
X-master-at: aa39b858a35d99135e1403575a358b97d26ff466
X-next-at: 8de07476bf9d007657eaa0b87f26678540e92092
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQktzfQ2MMmfmhoxMNiRNhfGGRk7B9VFpVCJxEetN32fwlwMLoP5C+aKARVO2LW3hxI2FnAB9ISBb2MvnxY7Krch4rTf3LV/RHpK+hj9g6P1kOj4Up1IiwM445j8oNHycb4xY8kFZ+NUONjb+uVjWVIlMYJeju+ixhqCnb3WOKfiKuDpLeE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196168>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

The fourth batch of topics in this cycle is now in 'master'.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bw/test-fix-grep-gnuism (2012-04-19) 1 commit
  (merged to 'next' on 2012-04-20 at ee7eec4)
 + t9400: fix gnuism in grep

Fix two places that were the only place in the test suite that gave "a\+"
to platform grep and expected it to mean one or more "a", which is a
blatant GNUism.

* jc/maint-blame-minimal (2012-04-11) 1 commit
  (merged to 'next' on 2012-04-20 at 2213284)
 + blame: accept --need-minimal

"git blame" started missing quite a few changes from the origin since we
stopped using the diff minimalization by default in v1.7.2 era.

* jh/apply-free-patch (2012-04-11) 9 commits
  (merged to 'next' on 2012-04-15 at 8cccf57)
 + apply: document buffer ownership rules across functions
 + apply: tighten constness of line buffer
 + apply: drop unused macro
 + apply: free unused fragments for submodule patch
 + apply: free patch->result
 + apply: release memory for fn_table
 + apply: free patch->{def,old,new}_name fields
 + apply: rename free_patch() to free_patch_list()
 + apply: do not leak patches and fragments

Valgrind reports quite a lot of discarded memory inside apply.

* jk/rebase-i-submodule-conflict-only (2012-04-09) 1 commit
  (merged to 'next' on 2012-04-15 at 94367a8)
 + rebase -i continue: don't skip commits that only change submodules

Giving "--continue" to a conflicted "rebase -i" session skipped a commit
that only results in changes to submodules.

* jl/maint-submodule-recurse-fetch (2012-04-14) 1 commit
  (merged to 'next' on 2012-04-20 at 2769d39)
 + submodules: recursive fetch also checks new tags for submodule commits

* jn/debian-customizes-default-editor (2012-04-10) 2 commits
  (merged to 'next' on 2012-04-15 at 0fc85c3)
 + var doc: advertise current DEFAULT_PAGER and DEFAULT_EDITOR settings
 + var doc: default editor and pager are configurable at build time

* jn/fast-import-doc (2012-04-15) 1 commit
  (merged to 'next' on 2012-04-20 at b9a7250)
 + fast-import doc: cat-blob and ls responses need to be consumed quickly

* jn/more-i18ncmp (2012-04-14) 3 commits
  (merged to 'next' on 2012-04-20 at b5548a3)
 + test: am of empty patch should not succeed
 + test: use test_i18ncmp for "Patch format detection failed" message
 + test: do not rely on US English tracking-info messages

* lp/maint-diff-three-dash-with-graph (2012-03-20) 3 commits
  (merged to 'next' on 2012-04-20 at b6cf0ff)
 + t4202: add test for "log --graph --stat -p" separator lines
 + log --graph: fix break in graph lines
 + log --graph --stat: three-dash separator should come after graph lines

* ms/remote-usage-string (2012-04-09) 1 commit
  (merged to 'next' on 2012-04-15 at 704be8f)
 + remote: update builtin usage

As an independent follow-up, we may want to rethink how the overall usage
string and subcommand usage strings are maintained.

* pw/git-p4 (2012-04-09) 3 commits
  (merged to 'next' on 2012-04-15 at 81ea41a)
 + git p4: use "git p4" directly in tests
 + git p4: update name in script
 + git-p4: move to toplevel
 (this branch is used by ld/git-p4-tags-and-labels.)

* rj/mingw-isguid (2012-04-18) 1 commit
  (merged to 'next' on 2012-04-20 at 9dbebca)
 + compat/mingw.h: Set S_ISUID to prevent a fast-import test failure

* rj/sh-setup-mswin-pwd (2012-04-18) 1 commit
  (merged to 'next' on 2012-04-20 at 6125f8d)
 + git-sh-setup.sh: Add an pwd() function for MinGW

* rj/submodule-mswin-path (2012-04-18) 1 commit
  (merged to 'next' on 2012-04-20 at fd9f8b3)
 + git-submodule.sh: Don't use $path variable in eval_gettext string

* rl/show-empty-prefix (2012-04-10) 1 commit
  (merged to 'next' on 2012-04-15 at b2e5938)
 + rev-parse --show-prefix: add in trailing newline

* rs/commit-list-sort-in-batch (2012-04-17) 4 commits
  (merged to 'next' on 2012-04-17 at 21208e9)
 + mergesort: rename it to llist_mergesort()
  (merged to 'next' on 2012-04-15 at 39fe527)
 + revision: insert unsorted, then sort in prepare_revision_walk()
 + commit: use mergesort() in commit_list_sort_by_date()
 + add mergesort() for linked lists

* sl/test-wc-l-line-count (2012-04-11) 1 commit
  (merged to 'next' on 2012-04-15 at 40797d9)
 + tests: modernise style: more uses of test_line_count

--------------------------------------------------
[New Topics]

* cc/fix-missing-va-end-in-revert (2012-04-21) 1 commit
  (merged to 'next' on 2012-04-23 at b90eb70)
 + revert: add missing va_end

Will merge to 'master'.

* pw/t5800-import-race-fix (2012-04-22) 2 commits
 - fixup! git-remote-testgit: fix race when spawning fast-import
 - git-remote-testgit: fix race when spawning fast-import

Will merge to 'next' after squashing the fixup!

* nd/i18n (2012-04-23) 11 commits
 - i18n: bundle: mark strings for translation
 - i18n: index-pack: mark strings for translation
 - i18n: apply: update say_patch_name to give translators complete sentence
 - i18n: apply: mark strings for translation
 - i18n: remote: mark strings for translation
 - i18n: make warn_dangling_symref() automatically append \n
 - i18n: help: mark strings for translation
 - i18n: mark relative dates for translation
 - fixup! strbuf: convenience format functions with \n automatically appended
 - strbuf: convenience format functions with \n automatically appended
 - Makefile: feed all header files to xgettext

Will merge to 'next' after squashing the fixup!
We can address the pseudo-underline of section headers in "git help --all"
as a follow-up patch.

* rk/git-svn-ignore-sigpipe (2012-04-23) 3 commits
 - git-svn: drop redundant blocking of SIGPIPE
 - git-svn: ignore SIGPIPE
 - git-svn: use POSIX::sigprocmask to block signals

Waiting for an Ack from Eric.

--------------------------------------------------
[Stalled]

* jc/split-blob (2012-04-03) 7 commits
 - chunked-object: streaming checkout
 - chunked-object: fallback checkout codepaths
 - bulk-checkin: support chunked-object encoding
 - bulk-checkin: allow the same data to be multiply hashed
 - new representation types in the packstream
 - packfile: use varint functions
 + varint: make it available outside the context of pack
 (this branch is tangled with jc/index-v4.)

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

* nh/empty-rebase (2012-04-20) 7 commits
 - fixup! git-rebase: add keep_empty flag
 - git-rebase: add keep_empty flag
 - fixup! git-cherry-pick: Add test to validate new options
 - git-cherry-pick: Add test to validate new options
 - fixup! git-cherry-pick: Add keep-redundant-commits option
 - git-cherry-pick: Add keep-redundant-commits option
 - git-cherry-pick: add allow-empty option

Will merge to 'next' after squashing the fixup!

* rt/cherry-revert-conflict-summary (2012-04-19) 1 commit
  (merged to 'next' on 2012-04-23 at e7766c2)
 + sequencer: remove additional blank line

In the older days, the header "Conflicts:" in "cherry-pick" and
"merge" was separated by a blank line from the list of paths that
follow for readability, but when "merge" was rewritten in C, we lost
it by mistake. Remove the newline from "cherry-pick" to make them
match again.

Will merge to 'master'.

* js/fast-import-test-9300 (2012-04-20) 1 commit
  (merged to 'next' on 2012-04-23 at a9bd236)
 + t9300-fast-import: avoid 'exit' in test_expect_success snippets

Will merge to 'master'.

* jm/maint-strncpy-diff-no-index (2012-04-16) 1 commit
  (merged to 'next' on 2012-04-20 at 638ed9f)
 + diff: avoid stack-buffer-read-overrun for very long name

Will merge to 'master'.

* lp/diffstat-with-graph (2012-04-18) 6 commits
  (merged to 'next' on 2012-04-23 at 8de0747)
 + Prevent graph_width of stat width from falling below min
 + t4052: Test diff-stat output with minimum columns
 + t4052: Adjust --graph --stat output for prefixes
 + Adjust stat width calculations to take --graph output into account
 + Add output_prefix_length to diff_options
 + t4052: test --stat output with --graph

Looked reasonable.
Will merge to 'master'.

* jc/merge-reduce-parents-early (2012-04-18) 5 commits
  (merged to 'next' on 2012-04-23 at 16e7e53)
 + fmt-merge-msg: discard needless merge parents
 + builtin/merge.c: reduce parents early
 + builtin/merge.c: collect other parents early
 + builtin/merge.c: remove "remoteheads" global variable
 + merge tests: octopus with redundant parents

Will merge to 'master'.

* cb/cherry-pick-rev-path-confusion (2012-04-15) 1 commit
  (merged to 'next' on 2012-04-23 at f872ba5)
 + cherry-pick: do not expect file arguments

The command line parser choked "git cherry-pick $name" when $name can be
both revision name and a pathname, even though $name can never be a path
in the context of the command.

The issue the patch addresses is real, but the way it is implemented felt
unnecessarily invasive a bit.  It may be cleaner for this caller to add
the "--" to the end of the argv_array it passes to setup_revisions().

Will merge to 'master'.

* cb/daemon-test-race-fix (2012-04-19) 1 commit
 - git-daemon wrapper to wait until daemon is ready

Fix race condition between starting and waiting for git-daemon in the
test.

Will merge to 'next'.

* cb/maint-report-mount-point-correctly-in-setup (2012-04-15) 1 commit
  (merged to 'next' on 2012-04-23 at 9e0c8b4)
 + properly keep track of current working directory

The filesystem boundary was not correctly reported when .git directory
discovery stopped at a mount point.

Will merge to 'master'.

* rl/maint-stash-i18n-save-error (2012-04-14) 1 commit
  (merged to 'next' on 2012-04-23 at 3692fec)
 + stash: use eval_gettextln correctly

Will merge to 'master'.

* nd/columns (2012-04-20) 9 commits
 - tag: add --column
 - column: support piping stdout to external git-column process
 - status: add --column
 - branch: add --column
 - help: reuse print_columns() for help -a
 - column: add dense layout support
 - column: add columnar layout
 - Stop starting pager recursively
 - Add column layout skeleton and git-column

Will merge to 'next'.

* nl/http-proxy-more (2012-04-19) 7 commits
 - http: fix proxy password passing
 - http: fix proxy authentication
 - http: rename HTTP_REAUTH to HTTP_AUTH_RETRY
 - http: Avoid limit of retrying request only twice
 - http: handle proxy authentication failure (error 407)
 - http: handle proxy proactive authentication
 - http: try http_proxy env var when http.proxy config option is not set

The code to talk to http proxies learn to use the same credential
API used to talk to the final http destinations.  This still needs
to peek into $ENV{HTTPS_PROXY}.

* mb/fetch-call-a-non-branch-a-ref (2012-04-17) 2 commits
  (merged to 'next' on 2012-04-20 at df2c57e)
 + fetch: describe new refs based on where it came from
 + fetch: Give remote_ref to update_local_ref() as well

Will merge to 'master'.

* mh/ref-api (2012-04-10) 13 commits
  (merged to 'next' on 2012-04-20 at 94e9384)
 + do_for_each_ref(): only iterate over the subtree that was requested
 + refs: store references hierarchically
 + sort_ref_dir(): simplify logic
 + refs.c: rename ref_array -> ref_dir
 + struct ref_entry: nest the value part in a union
 + check_refname_component(): return 0 for zero-length components
 + free_ref_entry(): new function
 + names_conflict(): simplify implementation
 + repack_without_ref(): reimplement using do_for_each_ref_in_array()
 + do_for_each_ref_in_arrays(): new function
 + do_for_each_ref_in_array(): new function
 + refs: manage current_ref within do_one_ref()
 + refs.c: reorder definitions more logically

Allows walking only a sub-hierarchy in refs/*.

Will merge to 'master'.

* jk/repack-no-explode-objects-from-old-pack (2012-04-18) 4 commits
  (merged to 'next' on 2012-04-20 at 4eb2534)
 + gc: use argv-array for sub-commands
 + argv-array: add a new "pushl" method
 + argv-array: refactor empty_argv initialization
  (merged to 'next' on 2012-04-15 at 7586e50)
 + gc: do not explode objects which will be immediately pruned

* ld/git-p4-tags-and-labels (2012-04-11) 2 commits
  (merged to 'next' on 2012-04-15 at 1b1e9a1)
 + git p4: import/export of labels to/from p4
 + git p4: Fixing script editor checks

Waiting for a follow-up to address the review comments
by Pete Wyckoff Message-ID: <20120418113422.GB19994@padd.com>

* zj/upstream-error-message (2012-04-15) 5 commits
  (merged to 'next' on 2012-04-20 at 1ed9682)
 + i18n: mark @{upstream} error messages for translation
 + Be more specific if upstream branch is not tracked
 + Provide better message for barnhc_wiht_tpyo@{u}
 + Provide branch name in error message when using @{u}
 + t1507: add tests to document @{upstream} behaviour

Will merge to 'master'.

* fc/completion-tests (2012-04-21) 7 commits
  (merged to 'next' on 2012-04-23 at 9b42326)
 + completion: fix completion after 'git --option <TAB>'
 + completion: avoid trailing space for --exec-path
 + completion: add missing general options
 + completion: simplify by using $prev
 + completion: simplify __gitcomp_1
 + tests: add tests for the __gitcomp() completion helper function
 + tests: add initial bash completion tests

Will merge to 'master'.

* nd/threaded-index-pack (2012-04-19) 4 commits
 - index-pack: disable threading if NO_PREAD is defined
 - index-pack: support multithreaded delta resolving
 - index-pack: split second pass obj handling into own function
 - compat/win32/pthread.h: Add an pthread_key_delete() implementation

* cb/http-multi-curl-auth (2012-04-14) 4 commits
  (merged to 'next' on 2012-04-23 at b0259be)
 + http: use newer curl options for setting credentials
 + http: clean up leak in init_curl_http_auth
 + fix http auth with multiple curl handles
 + http auth fails with multiple curl handles

Fixes http authentication breakage when we keep multiple HTTP requests in
flight using curl-multi.

Will merge to 'master'.

* pw/fast-import-dataref-parsing (2012-04-10) 1 commit
  (merged to 'next' on 2012-04-20 at c299a63)
 + fast-import: tighten parsing of datarefs

Will merge to 'master'.

* tr/xdiff-fast-hash (2012-04-09) 1 commit
 - xdiff: load full words in the inner loop of xdl_hash_record

Will merge to 'next'.

* jc/index-v4 (2012-04-04) 10 commits
  (merged to 'next' on 2012-04-19 at 5e4b029)
 + update-index: upgrade/downgrade on-disk index version
 + read-cache.c: write prefix-compressed names in the index
 + read-cache.c: read prefix-compressed names in index on-disk version v4
 + read-cache.c: move code to copy incore to ondisk cache to a helper function
 + read-cache.c: move code to copy ondisk to incore cache to a helper function
 + read-cache.c: report the header version we do not understand
 + read-cache.c: make create_from_disk() report number of bytes it consumed
 + read-cache.c: allow unaligned mapping of the index file
 + cache.h: hide on-disk index details
 + varint: make it available outside the context of pack
 (this branch is tangled with jc/split-blob.)

Trivially shrinks the on-disk size of the index file to save both I/O and
checksum overhead.  The "v4" format represented here may not be what we
eventually want to have, but the preparatory refactoring steps and the way
how backward compatibility is retained should give plenty to learn to GSoC
student-hopefuls.

The bottom one makes use of "varint" encoding from the stalled
jc/split-blob topic.

* mk/gitweb-diff-hl (2012-04-11) 8 commits
  (merged to 'next' on 2012-04-20 at 54179a2)
 + gitweb: Refinement highlightning in combined diffs
 + gitweb: Highlight interesting parts of diff
 + gitweb: Push formatting diff lines to print_diff_chunk()
 + gitweb: Use print_diff_chunk() for both side-by-side and inline diffs
 + gitweb: Extract print_sidebyside_diff_lines()
 + gitweb: Pass esc_html_hl_regions() options to esc_html()
 + gitweb: esc_html_hl_regions(): Don't create empty <span> elements
 + gitweb: Use descriptive names in esc_html_hl_regions()

Will merge to 'master'.

* it/fetch-pack-many-refs (2012-04-10) 4 commits
  (merged to 'next' on 2012-04-20 at e2126d7)
 + remote-curl: main test case for the OS command line overflow
 + fetch-pack: test cases for the new --stdin option
 + remote-curl: send the refs to fetch-pack on stdin
 + fetch-pack: new --stdin option to read refs from stdin

Will merge to 'master'.

* hv/submodule-recurse-push (2012-03-30) 3 commits
  (merged to 'next' on 2012-04-20 at fe99e3d)
 + push: teach --recurse-submodules the on-demand option
 + Refactor submodule push check to use string list instead of integer
 + Teach revision walking machinery to walk multiple times sequencially

Will merge to 'master'.

* th/difftool-diffall (2012-04-23) 8 commits
 - difftool: print list of valid tools with '--tool-help'
 - difftool: teach difftool to handle directory diffs
 - difftool: eliminate setup_environment function
 - difftool: stop appending '.exe' to git
 - difftool: remove explicit change of PATH
 - difftool: exit(0) when usage is printed
 - difftool: add '--no-gui' option
 - difftool: parse options using Getopt::Long

Rolls the two-directory-diff logic from diffall script (in contrib/) into
"git difftool" framework. 

Still being reworked.

* jc/run-hook-env-1 (2012-03-11) 1 commit
 - run_hook(): enhance the interface to pass arbitrary environment

Not urgent.

Updates run_hook() API to be much less specific to "commit".  It would
only be useful if people start doing more interesting things with hooks.

* mm/push-default-switch-warning (2012-04-23) 10 commits
 - fixup! push: introduce new push.default mode "simple"
 - fixup! t5528-push-default.sh: add helper functions
 - push: suggested updates to push configuration documentation
 - push: start warning upcoming default change for push.default
 - push: document the future default change for push.default (matching -> simple)
 - t5570: use explicit push refspec
 - push: introduce new push.default mode "simple"
 - t5528-push-default.sh: add helper functions
 - Undocument deprecated alias 'push.default=tracking'
 - Documentation: explain push.default option a bit more

Introduces 'simple' mode to be used as the push.default in a future
version of git.  I think the series is almost there modulo some minor
nits.

This topic should be renamed to "mm/push-simple-method" and the last
step to start warning made into a separate topic that build on it, but
the review comments need to be addressed in a reroll before that
