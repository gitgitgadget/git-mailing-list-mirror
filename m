From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.1.1
Date: Tue, 29 Jun 2010 16:48:57 -0700
Message-ID: <7vk4ph8knq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Wed Jun 30 01:49:39 2010
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1OTkYa-00005I-OW
	for glk-linux-kernel-3@lo.gmane.org; Wed, 30 Jun 2010 01:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755447Ab0F2XtL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 29 Jun 2010 19:49:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62634 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960Ab0F2XtI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2010 19:49:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B93CC0B71;
	Tue, 29 Jun 2010 19:49:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=oHper7fT3fse/Z+X0tfGr8mLk
	wU=; b=jqd1Wt19ba50y0TAoCi9E3bKOD0oWJocL9CtPq/zdSk03gFhyeZrha1Vs
	x6pe52sePIQD2RMbAj3R1PVJU2NfOmzQcJrZBlylZHIlHSJYp9crv0ljdjqR9O/+
	NVp4iJJvFatLOr4dO6sabq5QuzsxObo4o1Z4ML+X8hf0DpCOYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=I0dilx+NzDytFw4oxlV
	20wrPr92ZSSbq8aCVoy9s/X0rCCiTyaEymN6kfJV/B1xw8TniAaqqhsiDWXtVdhO
	48Bt6cAz5ncVfDM9HAC+R/TEGU42ivLzOhlQL/u9lkxJXIRw2FfyiqhxmwrFR55K
	8lN+n4lDgl9OlByqBITsyfmE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D5DAAC0B70;
	Tue, 29 Jun 2010 19:49:03 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B0EBC0B6C; Tue, 29 Jun
 2010 19:48:59 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E5F2C83A-83D8-11DF-ABE9-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149932>

The latest maintenance release Git 1.7.1.1 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.1.1.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.1.1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.1.1.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.7.1.1-1.fc11.$arch.rpm	(RPM)

Git v1.7.1.1 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.7.1
------------------

 * Authentication over http transport can now be made lazily, in that t=
he
   request can first go to a URL without username, get a 401 response a=
nd
   then the client will ask for the username to use.

 * We used to mistakenly think "../work" is a subdirectory of the curre=
nt
   directory when we are in "../work-xyz".

 * The attribute mechanism now allows an entry that uses an attribute
   macro that set/unset one attribute, immediately followed by an
   overriding setting; this makes attribute macros much easier to use.

 * We didn't recognize timezone "Z" as a synonym for "UTC" (75b37e70).

 * In 1.7.0, read-tree and user commands that use the mechanism such as
   checkout and merge were fixed to handle switching between branches o=
ne
   of which has a file while the other has a directory at the same path
   correctly even when there are some "confusing" pathnames in them.  B=
ut
   the algorithm used for this fix was suboptimal and had a terrible
   performance degradation especially in larger trees.

 * "git am -3" did not show diagnosis when the patch in the message was=
 corrupt.

 * After "git apply --whitespace=3Dfix" removed trailing blank lines in=
 an
   patch in a patch series, it failed to apply later patches that depen=
d
   on the presence of such blank lines.

 * "git bundle --stdin" segfaulted.

 * "git checkout" and "git rebase" overwrote paths that are marked "ass=
ume
   unchanged".

 * "git commit --amend" on a commit with an invalid author-name line th=
at
   lacks the display name didn't work.

 * "git describe" did not tie-break tags that point at the same commit
   correctly; newer ones are preferred by paying attention to the
   tagger date now.

 * "git diff" used to tell underlying xdiff machinery to work very hard=
 to
   minimize the output, but this often was spending too many extra cycl=
es
   for very little gain.

 * "git diff --color" did not paint extended diff headers per line
   (i.e. the coloring escape sequence didn't end at the end of line),
   which confused "less -R".

 * "git fetch" over HTTP verifies the downloaded packfiles more robustl=
y.

 * The memory usage by "git index-pack" (run during "git fetch" and "gi=
t
   push") got leaner.

 * "GIT_DIR=3Dfoo.git git init --bare bar.git" created foo.git instead =
of bar.git.

 * "git log --abbrev=3D$num --format=3D'%h' ignored --abbrev=3D$num.

 * "git ls-files ../out/side/cwd" refused to work.

 * "git merge --log" used to replace the custom message given by "-m" w=
ith
   the shortlog, instead of appending to it.

 * "git notes copy" without any other argument segfaulted.

 * "git pull" accepted "--dry-run", gave it to underlying "git fetch" b=
ut
   ignored the option itself, resulting in a bogus attempt to merge
   unrelated commit.

 * "git rebase" did not faithfully reproduce a malformed author ident, =
that
   is often seen in a repository converted from foreign SCMs.

 * "git reset --hard" started from a wrong directory and a working tree=
 in
   a nonstandard location is in use got confused.

 * "git send-email" lacked a way to specify the domainname used in the
   EHLO/HELO exchange, causing rejected connection from picky servers.
   It learned --smtp-domain option to solve this issue.

 * "git send-email" did not declare a content-transfer-encoding and
   content-type even when its payload needs to be sent in 8-bit.

 * "git show -C -C" and other corner cases lost diff metainfo output
   in 1.7.0.

 * "git stash" incorrectly lost paths in the working tree that were
   previously removed from the index.

 * "git status" stopped refreshing the index by mistake in 1.7.1.

 * "git status" showed excess "hints" even when advice.statusHints is s=
et to false.

And other minor fixes and documentation updates.

----------------------------------------------------------------

Changes since v1.7.1 are as follows:

Alexey Mahotkin (1):
      xdiff/xmerge.c: use memset() instead of explicit for-loop

Bert Wesarg (1):
      diff: fix coloring of extended diff headers

Bj=C3=B6rn Gustavsson (1):
      apply: Allow blank *trailing* context lines to match beyond EOF

Bj=C3=B6rn Steinbrink (1):
      diff: Support visibility modifiers in the PHP hunk header regexp

Bo Yang (1):
      blame-options.txt: Add default value for `-M/-C` options.

Brandon Casey (1):
      t/t9001: use egrep when regular expressions are involved

Brian Downing (1):
      unpack-trees: Make index lookahead less pessimal

Brian Gernhardt (4):
      send-email: Cleanup { style
      send-email: Don't use FQDNs without a '.'
      Document send-email --smtp-domain
      send-email: Cleanup smtp-domain and add config

Charles Bailey (2):
      stash: Don't overwrite files that have gone from the index
      stash tests: stash can lose data in a file removed from the index

Chris Webb (1):
      exec_cmd.c: replace hard-coded path list with one from <paths.h>

Christian Couder (3):
      diff: fix "git show -C -C" output when renaming a binary file
      commit: use value of GIT_REFLOG_ACTION env variable as reflog mes=
sage
      Documentation: grep: fix asciidoc problem with --

Clemens Buchacher (7):
      do not overwrite files marked "assume unchanged"
      Documentation: git-add does not update files marked "assume uncha=
nged"
      test get_git_work_tree() return value for NULL
      get_cwd_relative(): do not misinterpret suffix as subdirectory
      setup: document prefix
      quote.c: separate quoting and relative path generation
      ls-files: allow relative pathspec

Dmitry Potapov (1):
      hash_object: correction for zero length file

Gary V. Vaughan (1):
      git-compat-util.h: use apparently more common __sgi macro to dete=
ct SGI IRIX

Gerrit Pape (1):
      git-submodule.sh: properly initialize shell variables

Henrik Grubbstr=C3=B6m (3):
      attr: Fixed debug output for macro expansion.
      attr: Allow multiple changes to an attribute on the same line.
      attr: Expand macros immediately when encountered.

Ian McLean (1):
      Fix "Out of memory? mmap failed" for files larger than 4GB on Win=
dows

Ian Ward Comfort (1):
      rebase -i: Abort cleanly if new base cannot be checked out

Jakub Narebski (1):
      autoconf: Check if <paths.h> exists and set HAVE_PATHS_H

Jay Soffian (3):
      commit.txt: clarify how --author argument is used
      am: use get_author_ident_from_commit instead of mailinfo when reb=
asing
      gitweb/Makefile: fix typo in gitweb.min.css rule

Jeff King (7):
      handle "git --bare init <dir>" properly
      docs: clarify meaning of -M for git-log
      remove over-eager caching in sha1_file_name
      pull: do nothing on --dry-run
      commit: give advice on empty amend
      Makefile: default pager on AIX to "more"
      notes: check number of parameters to "git notes copy"

Johannes Sixt (1):
      Thread-safe xmalloc and xrealloc needs a recursive mutex

Jonathan Nieder (25):
      t7006: guard cleanup with test_expect_success
      t5704 (bundle): add tests for bundle --stdin
      fix "bundle --stdin" segfault
      test-lib: Let tests specify commands to be run at end of test
      commit --amend: cope with missing display name
      Documentation/shortlog: scripted users should not rely on implici=
t HEAD
      t4201 (shortlog): guard setup with test_expect_success
      t4201 (shortlog): Test output format with multiple authors
      shortlog: Document and test --format option
      test-lib: some shells do not let $? propagate into an eval
      cherry-pick: do not dump core when iconv fails
      Documentation/notes: document format of notes trees
      Documentation/notes: describe content of notes blobs
      Documentation/notes: add configuration section
      Documentation/notes: simplify treatment of default notes ref
      Documentation/log: add a CONFIGURATION section
      Documentation/notes: simplify treatment of default display refs
      Documentation/notes: clean up description of rewriting configurat=
ion
      Documentation/notes: nitpicks
      post-receive-email: document command-line mode
      Documentation/checkout: clarify description
      gitignore.5: Clarify matching rules
      rebase -i -p: document shortcomings
      Documentation/checkout: clarify description
      add-interactive: Clarify =E2=80=9Cremaining hunks in the file=E2=80=
=9D

Junio C Hamano (10):
      am -3: recover the diagnostic messages for corrupt patches
      clone: quell the progress report from init and report on clone
      t9129: fix UTF-8 locale detection
      common_prefix: simplify and fix scanning for prefixes
      Prepare draft release notes to 1.7.1.1
      Update draft release notes to 1.7.1.1
      tests: remove unnecessary '^' from 'expr' regular expression
      Update draft release notes to 1.7.1.1
      Update draft release notes to 1.7.1.1
      Git 1.7.1.1

Leif Arne Storset (1):
      Documentation/config.txt: GIT_NOTES_REWRITE_REF overrides notes.r=
ewriteRef

Marcus Comstedt (1):
      Add "Z" as an alias for the timezone "UTC"

Markus Heidelberg (4):
      t7508: add test for "git status" refreshing the index
      git status: refresh the index if possible
      t7508: add a test for "git status" in a read-only repository
      Documentation: rebase -i ignores options passed to "git am"

Michael J Gruber (10):
      index-pack: fix trivial typo in usage string
      t7508: test advice.statusHints
      wt-status: take advice.statusHints seriously
      Documentation: fix minor inconsistency
      Documentation/gitdiffcore: fix order in pickaxe description
      Documentation/SubmittingPatches: clarify GMail section and SMTP
      completion: --set-upstream option for git-branch
      Makefile: reenable install with NO_CURL
      Documentation/config: describe status.submodulesummary
      Documentation: A...B shortcut for checkout and rebase

Michal Sojka (1):
      test-lib.sh: Add explicit license detail, with change from GPLv2 =
to GPLv2+.

Nazri Ramliy (1):
      Documentation/pretty-{formats,options}: better reference for "for=
mat:<string>"

Nicolas Pitre (4):
      Make xmalloc and xrealloc thread-safe
      index-pack: smarter memory usage when resolving deltas
      index-pack: rationalize unpack_entry_data()
      index-pack: smarter memory usage when appending objects

Pete Harlan (1):
      clone: reword messages to match the end-user perception

Peter Collingbourne (4):
      Generalise the unlink_or_warn function
      Implement the rmdir_or_warn function
      Introduce remove_or_warn function
      Remove a redundant errno test in a usage of remove_path

Philippe Bruhat (1):
      Git.pm: better error message

Ping Yin (1):
      Documentation/git-send-email: Add "Use gmail as the smtp server"

Ramkumar Ramachandra (1):
      SubmittingPatches: Add new section about what to base work on

Ramsay Allan Jones (4):
      Makefile: Fix 'clean' target to remove all gitweb build files
      msvc: Fix some "expr evaluates to function" compiler warnings
      msvc: Fix some compiler warnings
      notes: Initialise variable to appease gcc

Ren=C3=A9 Scharfe (3):
      git diff too slow for a file
      remove ecb parameter from xdi_diff_outf()
      Fix checkout of large files to network shares on Windows XP

Scott Chacon (1):
      Prompt for a username when an HTTP request 401s

Shawn O. Pearce (16):
      tag.c: Correct indentation
      tag.h: Remove unused signature field
      tag.c: Refactor parse_tag_buffer to be saner to program
      tag.c: Parse tagger date (if present)
      describe: Break annotated tag ties by tagger date
      http.c: Remove bad free of static block
      t5550-http-fetch: Use subshell for repository operations
      http.c: Tiny refactoring of finish_http_pack_request
      http.c: Drop useless !=3D NULL test in finish_http_pack_request
      http.c: Don't store destination name in request structures
      http.c: Remove unnecessary strdup of sha1_to_hex result
      Introduce close_pack_index to permit replacement
      Extract verify_pack_index for reuse from verify_pack
      Allow parse_pack_index on temporary files
      http-fetch: Use index-pack rather than verify-pack to check packs
      http-fetch: Use temporary files for pack-*.idx until verified

Sverre Rabbelier (1):
      Gitweb: ignore built file

Tay Ray Chuan (18):
      t5541-http-push: add test for URLs with trailing slash
      http: make end_url_with_slash() public
      remote-curl: ensure that URLs have a trailing slash
      http.c::new_http_pack_request: do away with the temp variable fil=
ename
      t7604-merge-custom-message: shift expected output creation
      t7604-merge-custom-message: show that --log doesn't append to -m
      merge: update comment
      merge: rename variable
      fmt-merge-msg: minor refactor of fmt_merge_msg()
      fmt-merge-msg: refactor merge title formatting
      fmt-merge-msg: add function to append shortlog only
      merge: --log appends shortlog to message if specified
      GIT-VERSION-GEN: restrict tags used
      t7502-commit: fix spelling
      show-branch: use DEFAULT_ABBREV instead of 7
      t7502-commit: add tests for summary output
      t7502-commit: add summary output tests for empty and merge commit=
s
      commit::print_summary(): don't use format_commit_message()

Thomas Rast (2):
      t/README: document --root option
      send-email: ask about and declare 8bit mails

Tim Henigan (1):
      Documentation/SubmittingPatches: Fix typo in GMail section

Tor Arntsen (1):
      Change C99 comments to old-style C comments

Will Palmer (1):
      pretty: Respect --abbrev option

Zhang Le (1):
      git-mailinfo documentation: clarify -u/--encoding

bert Dvornik (1):
      start_command: close cmd->err descriptor when fork/spawn fails

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
      Move t6000lib.sh to lib-*
      Turn setup code in t2007-checkout-symlink.sh into a test
      notes: Initialize variable to appease Sun Studio
