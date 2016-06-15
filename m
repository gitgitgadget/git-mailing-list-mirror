From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Apr 2009, #04; Wed, 29)
Date: Wed, 29 Apr 2009 22:33:29 -0700
Message-ID: <7vy6tivh7a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 30 07:33:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzOu2-0005tK-AU
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 07:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbZD3Fdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 01:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbZD3Fdf
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 01:33:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36470 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbZD3Fde (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 01:33:34 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 04FAFAF689;
	Thu, 30 Apr 2009 01:33:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D504DAF688; Thu,
 30 Apr 2009 01:33:31 -0400 (EDT)
X-master-at: 6ffd567bec439e7809ee0966556bd5e72fb78de4
X-next-at: 8c6980a6544dcc03e45b1d63d624544f3bfa1b94
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7257BE6A-3548-11DE-ADB9-CABC03BA4B0C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117990>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the branches, but I am still
holding onto them.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

----------------------------------------------------------------
[New Topics]

* cc/bisect (Fri Apr 24 08:29:01 2009 +0200) 10 commits
 - am: simplify "sq" function by using "git rev-parse --sq-quote"
 - bisect: use "git rev-parse --sq-quote" instead of a custom "sq"
   function
 - rev-parse: add --sq-quote to shell quote arguments
 - rev-list: remove stringed output flag from "show_bisect_vars"
 - bisect--helper: remove "--next-vars" option as it is now useless
 - bisect: use "git bisect--helper --next-exit" in "git-bisect.sh"
 - bisect--helper: add "--next-exit" to output bisect results
 - bisect: move common bisect functionality to "bisect_common"
 - rev-list: refactor printing bisect vars
 - rev-list: make "estimate_bisect_steps" non static

* mh/show-branch-color (Sat Apr 25 13:46:14 2009 +0200) 2 commits
 + bash completion: show-branch color support
 + show-branch: color the commit status signs

* ac/graph-horizontal-line (Tue Apr 21 08:47:01 2009 -0400) 1 commit
 + graph API: Use horizontal lines for more compact graphs

* ar/merge-one-file-diag (Wed Apr 29 23:40:50 2009 +0200) 1 commit
 - Clarify kind of conflict in merge-one-file helper

* mh/diff-stat-color (Sat Apr 25 00:06:47 2009 +0200) 1 commit
 - diff: do not color --stat output like patch context

* rc/http-push (Sat Apr 25 00:35:57 2009 +0800) 3 commits
 . http-push: send out fetch requests on queue
 . t5540-http-push: test fetching of packed objects
 . t5540-http-push: test fetching of loose objects

Breaks build in a trivial way; which I haven't got around fixing it up.

* ae/anon-fetch-info (Fri Apr 17 10:20:11 2009 +0200) 1 commit
 + fetch: Strip usernames from url's before storing them

* ar/unlink-err (Wed Apr 29 23:24:52 2009 +0200) 3 commits
 - print unlink(2) errno in copy_or_link_directory
 - replace direct calls to unlink(2) with unlink_or_warn
 - Introduce an unlink(2) wrapper which gives warning if unlink
   failed

* ph/submodule-rebase (Fri Apr 24 09:06:38 2009 +1000) 1 commit
 - git-submodule: add support for --rebase.

----------------------------------------------------------------
[Graduated to "master"]

It's been a while since I sent "What's cooking" out, and some of the
topics below have fixes on top directly applied since they graduated.

* ac/color-graph (Mon Apr 13 15:53:41 2009 -0400) 1 commit
 + graph API: Added logic for colored edges

* jk/cobdoc (Mon Apr 13 07:21:04 2009 -0400) 5 commits
 + docs/checkout: clarify what "non-branch" means
 + doc/checkout: split checkout and branch creation in synopsis
 + doc/checkout: refer to git-branch(1) as appropriate
 + doc: refer to tracking configuration as "upstream"
 + doc: clarify --no-track option

* mk/apply-swap (Sat Apr 11 21:31:00 2009 +0200) 2 commits
 + builtin-apply: keep information about files to be deleted
 + tests: test applying criss-cross rename patch

Perhaps needs to be cherry-picked to 1.6.2.X series as well.

* mm/add-p-quit (Fri Apr 10 16:57:01 2009 +0200) 1 commit
 + git add -p: new "quit" command at the prompt.

* eb/upload-archive-from-git-shell (Thu Apr 9 21:58:52 2009 +0200) 1 commit
 + git-shell: Add 'git-upload-archive' to allowed commands.

* jc/shared-literally (Sun Apr 12 17:55:18 2009 -0700) 2 commits
 + Mark t1301 permission test to depend on POSIXPERM
 + t1301-shared-repo: fix forced modes test

* jc/maint-shared-literally (Sun Apr 12 21:22:02 2009 +0200) 1 commit
 + t1301-shared-repo: fix forced modes test

* ns/am-to-empty (Fri Apr 10 09:34:42 2009 +0900) 1 commit
 + git-am: teach git-am to apply a patch to an unborn branch

* bw/short-ref-strict (Mon Apr 13 13:20:26 2009 +0200) 3 commits
 + rev-parse: --abbrev-ref option to shorten ref name
 + for-each-ref: utilize core.warnAmbiguousRefs for :short-format
 + shorten_unambiguous_ref(): add strict mode

* da/difftool (Sat Apr 11 20:41:56 2009 -0700) 16 commits
 + mergetool--lib: simplify API usage by removing more global
   variables
 + Fix misspelled mergetool.keepBackup
 + difftool/mergetool: refactor commands to use git-mergetool--lib
 + mergetool: use $( ... ) instead of `backticks`
 + bash completion: add git-difftool
 + difftool: add support for a difftool.prompt config variable
 + difftool: add various git-difftool tests
 + difftool: move 'git-difftool' out of contrib
 + difftool/mergetool: add diffuse as merge and diff tool
 + difftool: add a -y shortcut for --no-prompt
 + difftool: use perl built-ins when testing for msys
 + difftool: remove the backup file feature
 + difftool: remove merge options for opendiff, tkdiff, kdiff3 and
   xxdiff
 + git-mergetool: add new merge tool TortoiseMerge
 + git-mergetool/difftool: make (g)vimdiff workable under Windows
 + doc/merge-config: list ecmerge as a built-in merge tool

* lt/bool-on-off (Thu Apr 9 12:40:39 2009 -0700) 1 commit
 + Allow users to un-configure rename detection

* lt/pack-object-memuse (Fri Apr 10 18:15:26 2009 -0700) 2 commits
 + show_object(): push path_name() call further down
 + process_{tree,blob}: show objects without buffering

* nd/archive-attribute (Mon Apr 13 14:18:39 2009 +0200) 5 commits
 + archive test: test new --fix-attributes feature
 + archive: do not read .gitattributes in working directory
 + unpack-trees: do not muck with attributes when we are not checking
   out
 + attr: add GIT_ATTR_INDEX "direction"
 + archive tests: do not use .gitattributes in working directory

----------------------------------------------------------------
[Stalled and may need help and prodding to go forward]

* ps/blame (Thu Mar 12 21:30:03 2009 +1100) 1 commit
 - blame.c: start libifying the blame infrastructure

A few minor point remains in this initial one.  I hate to do these minor
fix-ups myself, but I may end up doing so...

* jc/log-tz (Tue Mar 3 00:45:37 2009 -0800) 1 commit
 - Allow --date=local --date=other-format to work as expected

The one I posted had a few corner-case bugs that was caught with the test
suite; this one has them fixed.  People did not like the UI so it is kept
out of 'next'

* jc/merge-convert (Mon Jan 26 16:45:01 2009 -0800) 1 commit
 - git-merge-file: allow converting the results for the work tree

This is a feature waiting for a user.

We did not give scripted Porcelains a way to say "this temporary file I am
using for merging is for this path, so use the core.autocrlf and attributes
rules for that final path".  Instead, merge-file simply wrote out the
data in the canonical repository representation.

rerere has the same issue, but it is a lot worse.  It reads the three
files (preimage, postimage and thisimage) from the work tree in the work
tree representation, merges them without converting them to the canonical
representation first but inserts the conflict markers with the canonical
representation and writes the resulting mess out.  It needs to be fixed to
read with convert_to_git(), merge them while they are still in the
canonical representation and possibly add conflict markers, and then write
the results out after convert_to_working_tree().  It also needs to write
in binary mode as well.

* db/foreign-scm (Tue Mar 24 23:04:12 2009 -0400) 3 commits
 - Add option for using a foreign VCS
 - Document details of transport function APIs
 - Allow late reporting of fetched hashes

* js/notes (Tue Apr 14 00:03:36 2009 +0200) 15 commits
 - Documentation: fix 'linkgit' macro in "git-notes.txt"
 - tests: fix "export var=val"
 - notes: refuse to edit notes outside refs/notes/
 - t3301: use test_must_fail instead of !
 - t3301: fix confusing quoting in test for valid notes ref
 - notes: use GIT_EDITOR and core.editor over VISUAL/EDITOR
 - notes: only clean up message file when editing
 - handle empty notes gracefully
 - git notes show: test empty notes
 - git-notes: fix printing of multi-line notes
 - notes: fix core.notesRef documentation
 - Add an expensive test for git-notes
 - Speed up git notes lookup
 - Add a script to edit/inspect notes
 - Introduce commit notes

* hv/cvsps-tests (Sun Apr 5 01:40:50 2009 -0700) 8 commits
 - t/t9600: remove exit after test_done
 - cvsimport: extend testcase about patchset order to contain
   branches
 - cvsimport: add test illustrating a bug in cvsps
 + Add a test of "git cvsimport"'s handling of tags and branches
 + Add some tests of git-cvsimport's handling of vendor branches
 + Test contents of entire cvsimported "master" tree contents
 + Use CVS's -f option if available (ignore user's ~/.cvsrc file)
 + Start a library for cvsimport-related tests

Two cvsimport test topics were rewound from 'next' and merged into this
one.  I'll keep this in 'pu' so that people can polish their cvsps skilz
to resolve issues these tests identify.

----------------------------------------------------------------
[Actively cooking]

* mw/send-email (Mon Apr 13 13:23:52 2009 -0500) 6 commits
 - send-email: Remove superfluous `my $editor = ...'
 - send-email: 'References:' should only reference what is sent
 - send-email: Handle "GIT:" rather than "GIT: " during --compose
 - Docs: send-email: --smtp-server-port can take symbolic ports
 - Docs: send-email: Refer to CONFIGURATION section for
   sendemail.multiedit
 - Docs: send-email: Put options back into alphabetical order

Only partially queued, but this is not 1.6.3 material and we are not in a
hurry.

* js/add-edit (Mon Apr 27 19:51:42 2009 +0200) 2 commits
 + t3702: fix reliance on SHELL_PATH being '/bin/sh'
 + git-add: introduce --edit (to edit the diff vs. the index)

* cc/replace (Tue Apr 14 00:36:59 2009 +0200) 13 commits
 - Documentation: add documentation for "git replace"
 - Add git-replace to .gitignore
 - builtin-replace: use "usage_msg_opt" to give better error messages
 - parse-options: add new function "usage_msg_opt"
 - builtin-replace: teach "git replace" to actually replace
 - Add new "git replace" command
 - environment: add global variable to disable replacement
 - mktag: call "check_sha1_signature" with the replacement sha1
 - replace_object: add a test case
 - object: call "check_sha1_signature" with the replacement sha1
 - sha1_file: add a "read_sha1_file_repl" function
 - replace_object: add mechanism to replace objects found in
   "refs/replace/"
 - refs: add a "for_each_replace_ref" function

I suspect an attempt to replace an object that is directly listed on the
command line would not work very well with this series.

----------------------------------------------------------------
[Reverted]

* mh/cvsimport-tests (Mon Feb 23 06:08:14 2009 +0100) 5 commits
 + Add a test of "git cvsimport"'s handling of tags and branches
 + Add some tests of git-cvsimport's handling of vendor branches
 + Test contents of entire cvsimported "master" tree contents
 + Use CVS's -f option if available (ignore user's ~/.cvsrc file)
 + Start a library for cvsimport-related tests

This has been reverted out of 'next' for some time now.

----------------------------------------------------------------
[On Hold]

* jc/deny-delete-current-1.7.0 (Mon Feb 9 00:19:46 2009 -0800) 1 commit
 - receive-pack: default receive.denyDeleteCurrent to refuse

* jc/refuse-push-to-current-1.7.0 (Wed Feb 11 02:28:03 2009 -0800) 1 commit
 - Refuse updating the current branch in a non-bare repository via
   push

These are for 1.7.0, but the messages when they trigger together may need
to be rethought.
