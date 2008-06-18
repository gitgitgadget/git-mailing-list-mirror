From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.5.6
Date: Wed, 18 Jun 2008 16:24:22 -0700
Message-ID: <7vmylixr6h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 01:25:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K972E-0004OM-Ov
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 01:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754489AbYFRXYx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Jun 2008 19:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754324AbYFRXYx
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 19:24:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61457 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075AbYFRXYr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2008 19:24:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C6C8D249FF;
	Wed, 18 Jun 2008 19:24:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7ABEB249EF; Wed, 18 Jun 2008 19:24:28 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BA677A00-3D8D-11DD-B069-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85423>

The latest feature release GIT 1.5.6 is available at the usual
places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.6.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.6.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.6.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.6-1.$arch.rpm	(RPM)

As promised, this cycle was short and the release is with only relative=
ly
small impact changes.

----------------------------------------------------------------
GIT v1.5.6 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Updates since v1.5.5
--------------------

(subsystems)

* Comes with updated gitk and git-gui.

(portability)

* git will build on AIX better than before now.

* core.ignorecase configuration variable can be used to work better on
  filesystems that are not case sensitive.

* "git init" now autodetects the case sensitivity of the filesystem and
  sets core.ignorecase accordingly.

* cpio is no longer used; neither "curl" binary (libcurl is still used)=
=2E

(documentation)

* Many freestanding documentation pages have been converted and made
  available to "git help" (aka "man git<something>") as section 7 of
  the manual pages. This means bookmarks to some HTML documentation
  files may need to be updated (eg "tutorial.html" became
  "gittutorial.html").

(performance)

* "git clone" was rewritten in C.  This will hopefully help cloning a
  repository with insane number of refs.

* "git rebase --onto $there $from $branch" used to switch to the tip of
  $branch only to immediately reset back to $from, smudging work tree
  files unnecessarily.  This has been optimized.

* Object creation codepath in "git-svn" has been optimized by enhancing
  plumbing commands git-cat-file and git-hash-object.

(usability, bells and whistles)

* "git add -p" (and the "patch" subcommand of "git add -i") can choose =
to
  apply (or not apply) mode changes independently from contents changes=
=2E

* "git bisect help" gives longer and more helpful usage information.

* "git bisect" does not use a special branch "bisect" anymore; instead,=
 it
  does its work on a detached HEAD.

* "git branch" (and "git checkout -b") can be told to set up
  branch.<name>.rebase automatically, so that later you can say "git pu=
ll"
  and magically cause "git pull --rebase" to happen.

* "git branch --merged" and "git branch --no-merged" can be used to lis=
t
  branches that have already been merged (or not yet merged) to the
  current branch.

* "git cherry-pick" and "git revert" can add a sign-off.

* "git commit" mentions the author identity when you are committing
  somebody else's changes.

* "git diff/log --dirstat" output is consistent between binary and text=
ual
  changes.

* "git filter-branch" rewrites signed tags by demoting them to annotate=
d.

* "git format-patch --no-binary" can produce a patch that lack binary
  changes (i.e. cannot be used to propagate the whole changes) meant on=
ly
  for reviewing.

* "git init --bare" is a synonym for "git --bare init" now.

* "git gc --auto" honors a new pre-auto-gc hook to temporarily disable =
it.

* "git log --pretty=3Dtformat:<custom format>" gives a LF after each en=
try,
  instead of giving a LF between each pair of entries which is how
  "git log --pretty=3Dformat:<custom format>" works.

* "git log" and friends learned the "--graph" option to show the ancest=
ry
  graph at the left margin of the output.

* "git log" and friends can be told to use date format that is differen=
t
  from the default via 'log.date' configuration variable.

* "git send-email" now can send out messages outside a git repository.

* "git send-email --compose" was made aware of rfc2047 quoting.

* "git status" can optionally include output from "git submodule
  summary".

* "git svn" learned --add-author-from option to propagate the authorshi=
p
  by munging the commit log message.

* new object creation and looking up in "git svn" has been optimized.

* "gitweb" can read from a system-wide configuration file.

(internal)

* "git unpack-objects" and "git receive-pack" is now more strict about
  detecting breakage in the objects they receive over the wire.


=46ixes since v1.5.5
------------------

All of the fixes in v1.5.5 maintenance series are included in
this release, unless otherwise noted.

And there are too numerous small fixes to otherwise note here ;-)


----------------------------------------------------------------

Changes since v1.5.5 are as follows:

A Large Angry SCM (1):
      git-repack: re-enable parsing of -n command line option

Adam Roben (11):
      Add tests for git cat-file
      git-cat-file: Small refactor of cmd_cat_file
      git-cat-file: Make option parsing a little more flexible
      git-cat-file: Add --batch-check option
      git-cat-file: Add --batch option
      Move git-hash-object tests from t5303 to t1007
      Add more tests for git hash-object
      git-hash-object: Add --stdin-paths option
      Git.pm: Add command_bidi_pipe and command_close_bidi_pipe
      Git.pm: Add hash_and_insert_object and cat_blob
      git-svn: Speed up fetch

Adam Simpkins (15):
      Remove dead code: show_log() sep argument and diff_options.msg_se=
p
      log: print log entry terminator even if the message is empty
      revision API: split parent rewriting and parent printing options
      Add history graph API
      log and rev-list: add --graph option
      graph API: eliminate unnecessary indentation
      graph API: fix graph mis-alignment after uninteresting commits
      graph API: don't print branch lines for uninteresting merge paren=
ts
      log --graph --left-right: show left/right information in place of=
 '*'
      Fix output of "git log --graph --boundary"
      get_revision(): honor the topo_order flag for boundary commits
      graph API: improve display of merge commits
      graph API: avoid printing unnecessary padding before some octopus=
 merges
      graph API: fix "git log --graph --first-parent"
      git log --graph: print '*' for all commits, including merges

Alberto Bertogli (1):
      builtin-apply: Show a more descriptive error on failure when open=
ing a patch

Alejandro Mery (1):
      git-am: head -1 is obsolete and doesn't work on some new systems

Alex Riesen (13):
      Use "=3D" instead of "=3D=3D" in condition as it is more portable
      Fix use after free() in builtin-fetch
      Use the modern syntax of git-diff-files in t2002-checkout-cache-u=
=2Esh
      Improve reporting of errors in config file routines
      Make the exit code of add_file_to_index actually useful
      Extend interface of add_files_to_cache to allow ignore indexing e=
rrors
      Add --ignore-errors to git-add to allow it to skip files with rea=
d errors
      Add a test for git-add --ignore-errors
      Add a config option to ignore errors for git-add
      Ensure that a test is run in the trash directory
      Fix t6031 on filesystems without working exec bit
      Fix t3701 if core.filemode disabled
      Fix t5516 on cygwin: it does not like double slashes at the begin=
ning of a path

Anders Waldenborg (1):
      gitweb: Convert string to internal form before chopping in chop_s=
tr

Andy Parkins (1):
      post-receive-email: fix accidental removal of a trailing space in=
 signature line

Ariel Badichi (2):
      copy.c: copy_fd - correctly report write errors
      archive.c: format_subst - fixed bogus argument to memchr

Ask Bj=C3=B8rn Hansen (2):
      gitweb setup instruction: rewrite HEAD and root as well
      send-email: Allow the envelope sender to be set via configuration

Avery Pennarun (5):
      git-svn: add documentation for --use-log-author option.
      git-svn: Add --add-author-from option.
      git-svn: add documentation for --add-author-from option.
      git-svn: don't append extra newlines at the end of commit message=
s.
      git-svn: test that extra blank lines aren't inserted in commit me=
ssages.

Bart Trojanowski (1):
      make git-status use a pager

Bj=C3=B6rn Steinbrink (2):
      Fix section about backdating tags in the git-tag docs
      name-rev: Fix segmentation fault when using --all

Boyd Lynn Gerber (2):
      progress.c: avoid use of dynamic-sized array
      Port to 12 other Platforms.

Brandon Casey (8):
      filter-branch.sh: support nearly proper tag name filtering
      git-clone.txt: Adjust note to --shared for new pruning behavior o=
f git-gc
      compat/fopen.c: avoid clobbering the system defined fopen macro
      repack: modify behavior of -A option to leave unreferenced object=
s unpacked
      git-gc: always use -A when manually repacking
      builtin-gc.c: deprecate --prune, it now really has no effect
      builtin-clone.c: Need to closedir() in copy_or_link_directory()
      t/Makefile: "trash" directory was renamed recently

Bryan Donlan (10):
      git-rebase.sh: Fix --merge --abort failures when path contains wh=
itespace
      config.c: Escape backslashes in section names properly
      git-send-email.perl: Handle shell metacharacters in $EDITOR prope=
rly
      test-lib.sh: Add a test_set_editor function to safely set $VISUAL
      Use test_set_editor in t9001-send-email.sh
      test-lib.sh: Fix some missing path quoting
      lib-git-svn.sh: Fix quoting issues with paths containing shell me=
tacharacters
      Don't use the 'export NAME=3Dvalue' in the test scripts.
      Fix tests breaking when checkout path contains shell metacharacte=
rs
      Rename the test trash directory to contain spaces.

Caio Marcelo de Oliveira Filho (1):
      git-format-patch: add --no-binary to omit binary changes in the p=
atch.

Carlos Rica (2):
      Fix documentation syntax of optional arguments in short options.
      core-tutorial.txt: Fix showing the current behaviour.

Chris Frey (2):
      Documentation/git-prune.txt: document unpacked logic
      Documentation/git-repack.txt: document new -A behaviour

Chris Parsons (1):
      Updated status to show 'Not currently on any branch' in red

Chris Ridd (1):
      Improve sed portability

Christian Couder (32):
      bisect: add "git bisect help" subcommand to get a long usage stri=
ng
      bisect: fix bad rev checking in "git bisect good"
      bisect: report bad rev better
      bisect: squelch "fatal: ref HEAD not a symref" misleading message
      git-bisect: make "start", "good" and "skip" succeed or fail atomi=
cally
      help: use man viewer path from "man.<tool>.path" config var
      documentation: help: add "man.<tool>.path" config variable
      help: use "man.<tool>.cmd" as custom man viewer command
      documentation: help: add info about "man.<tool>.cmd" config var
      documentation: web--browse: add a note about konqueror
      rev-parse: teach "--verify" to be quiet when using "-q" or "--qui=
et"
      rev-parse: fix --verify to error out when passed junk after a goo=
d rev
      Documentation: hooks: fix missing verb in pre-applypatch descript=
ion
      Documentation: rename "hooks.txt" to "githooks.txt" and make it a=
 man page
      Documentation: improve "add", "pull" and "format-patch" examples
      Documentation: bisect: add a few "git bisect run" examples
      bisect: print an error message when "git rev-list --bisect-vars" =
fails
      rev-parse: add test script for "--verify"
      rev-parse: fix using "--default" with "--verify"
      rev-parse --verify: do not output anything on error
      Documentation: rev-parse: add a few "--verify" and "--default" ex=
amples
      bisect: add test cases to check that "git bisect start" is atomic
      bisect: fix left over "BISECT_START" file when starting with junk=
 rev
      bisect: trap critical errors in "bisect_start"
      bisect: use a detached HEAD to bisect
      Documentation: convert tutorials to man pages
      bisect: use "$GIT_DIR/BISECT_START" to check if we are bisecting
      Documentation: convert "glossary" and "core-tutorial" to man page=
s
      documentation: convert "diffcore" and "repository-layout" to man =
pages
      documentation: move git(7) to git(1)
      documentation: bisect: remove bits talking about a bisection bran=
ch
      Documentation: RelNotes-1.5.6: talk about renamed HTML files

Christian Engwer (1):
      git-svn fails in prop_walk if $self->{path} is not empty

Christian Stimming (3):
      git-gui: Update German translation
      gitk: Update German translation
      gitk: German translation again updated

Clemens Buchacher (2):
      Reset the signal being handled
      http-push: remove remote locks on exit signals

Clifford Caoile (2):
      Docs gitk: Explicitly mention the files that gitk uses (~/.gitk)
      git.el: Set process-environment instead of invoking env

Dan McGee (4):
      completion: allow 'git remote' subcommand completion
      completion: remove use of dashed git commands
      Allow cherry-pick (and revert) to add signoff line
      Remove 'header' from --signoff option description

Daniel Barkalow (14):
      Fix config key miscount in url.*.insteadOf
      Make walker.fetch_ref() take a struct ref.
      Make ls-remote http://... list HEAD, like for git://...
      Mark the list of refs to fetch as const
      Add a lockfile function to append to a file
      Add a library function to add an alternate to the alternates file
      Have a constant extern refspec for "--tags"
      Allow for having for_each_ref() list extra refs
      Add a function to set a non-default work tree
      Provide API access to init_db()
      Build in clone
      clone: fall back to copying if hardlinking fails
      Test that --reference actually suppresses fetching referenced obj=
ects
      Use nonrelative paths instead of absolute paths for cloned reposi=
tories

Dirk Suesserott (2):
      Documentation/git-request-pull: Fixed a typo ("send" -> "end")
      Documentation/git-mailsplit: Enhanced description of -o option

Dmitry Potapov (2):
      git-gc --prune is deprecated
      git-init: autodetect core.ignorecase

Dmitry V. Levin (1):
      builtin-fetch.c (store_updated_refs): Honor update_local_ref() re=
turn value

Dustin Sallings (3):
      Documentation/config.txt: Mention branch.<name>.rebase applies to=
 "git pull"
      Allow tracking branches to set up rebase by default.
      Allow tracking branches to set up rebase by default.

Eric Wong (1):
      git-svn: fix cloning of HTTP URLs with '+' in their path

=46lavio Poletti (1):
      git-instaweb: improve auto-discovery of httpd and call convention=
s.

=46lorian Ragwitz (1):
      filter-branch: Documentation fix.

=46rank Lichtenheld (4):
      var: Don't require to be in a git repository.
      Git.pm: Don't require a repository instance for config
      Git.pm: Don't require repository instance for ident
      send-email: Don't require to be called in a repository

=46red Maranh=C3=A3o (1):
      fix typo in tutorial

Geoffrey Irving (1):
      doc: adding gitman.info and *.texi to .gitignore

Gerrit Pape (7):
      gitweb: fallback to system-wide config file if default config doe=
s not exist
      gitweb: fallback to system-wide config file (fixup)
      diff-options.txt: document the new "--dirstat" option
      gitk: Makefile/install: force permissions when installing files a=
nd dirs
      git-bisect.sh: don't accidentally override existing branch "bisec=
t"
      Documentation/git-bundle.txt: fix synopsis
      commit --interactive: properly update the index before commiting

Govind Salinas (1):
      pretty.c: add %x00 format specifier.

Gustaf Hendeby (6):
      git-svn: Make create-ignore use git add -f
      Documentation: Add create-ignore to git svn manual
      Documentation/config.txt: Add git-gui options
      Documentation: Add missing git svn commands
      Documentation: Fix skipped section level
      Make git add -n and git -u -n output consistent

Heikki Orsila (8):
      Make core.sharedRepository more generic
      Document functions xmemdupz(), xread() and xwrite()
      Die for an early EOF in a file reading loop
      Make read_in_full() and write_in_full() consistent with xread() a=
nd xwrite()
      Cleanup xread() loops to use read_in_full()
      Add missing "short" alternative to --date in rev-list-options.txt
      Add log.date config variable
      Remove redundant code, eliminate one static variable

Horst H. von Brand (1):
      Fix recipient santitization

Ian Hilt (1):
      Documentation/git-describe.txt: make description more readable

Imran M Yousuf (1):
      Use '-f' option to point to the .gitmodules file

Jakub Narebski (7):
      gitweb: Fix 'history' view for deleted files with history
      gitweb: Use feed link according to current view
      gitweb: Remove gitweb/test/ directory
      gitweb: Fix "next" link on bottom of page
      gitweb: Add charset info to "raw" output of 'text/plain' blobs
      gitweb: Make it work with $GIT containing spaces
      Use 'trash directory' thoroughly in t/test-lib.sh

Jamis Buck (1):
      git-reset: honor -q and do not show progress message

Jeff King (30):
      add--interactive: ignore mode change in 'p'atch command
      add--interactive: allow user to choose mode update
      git-fetch: fix status output when not storing tracking ref
      git-fetch: always show status of non-tracking-ref fetches
      git-remote: show all remotes with "git remote show"
      Don't force imap.host to be set when imap.tunnel is set
      t5516: remove ambiguity test (1)
      doc/git-gc: add a note about what is collected
      push: allow unqualified dest refspecs to DWIM
      remote: create fetch config lines with '+'
      fix reflog approxidate parsing bug
      cvsimport: always pass user data to "system" as a list
      Documentation: point git-prune users to git-gc
      add merge.renamelimit config option
      bump rename limit defaults
      diff: make "too many files" rename warning optional
      checkout: don't rfc2047-encode oneline on detached HEAD
      doc: clarify definition of "update" for git-add -u
      fix bsd shell negation
      t5000: tar portability fix
      clone: bsd shell portability fix
      filter-branch: fix variable export logic
      doc/git-daemon: s/uploadarchive/uploadarch/
      git-am: fix typo in usage message
      send-email: specify content-type of --compose body
      send-email: rfc2047-quote subject lines with non-ascii characters
      clone: make sure we support the transport type
      Fix "git clone http://$URL" to check out the worktree when asked
      document --pretty=3Dtformat: option
      clean up error conventions of remote.c:match_explicit

Johan Herland (5):
      Add a test for another combination of --reference
      Add test for cloning with "--reference" repo being a subset of so=
urce repo
      cpio is no longer used by git-clone
      Consistency: Use "libcurl" instead of "cURL library" and "curl"
      The "curl" executable is no longer required

Johannes Schindelin (12):
      Provide git_config with a callback-data parameter
      builtin-clone: fix initial checkout
      cvsexportcommit: chomp only removes trailing whitespace
      diff options: Introduce --ignore-submodules
      Teach update-index about --ignore-submodules
      Ignore dirty submodule states during rebase and stash
      cvsexportcommit: introduce -W for shared working trees (between G=
it and CVS)
      submodule update: add convenience option --init
      pull --rebase: exit early when the working directory is dirty
      mailsplit and mailinfo: gracefully handle NUL characters
      hg-to-git: add --verbose option
      merge-recursive: respect core.autocrlf when writing out the resul=
t

Johannes Sixt (11):
      Document option --only of git commit
      builtin-commit.c: Remove a redundant assignment.
      git-gui: Report less precise object estimates for database compre=
ssion
      compat-util: avoid macro redefinition warning
      wt-status.h: declare global variables as extern
      rev-parse --symbolic-full-name: don't print '^' if SHA1 is not a =
ref
      t5700-clone-reference: Quote $U
      Revert "filter-branch: subdirectory filter needs --full-history"
      rebase --interactive: Compute upstream SHA1 before switching bran=
ches
      make_nonrelative_path: Use is_absolute_path()
      Remove exec bit from builtin-fast-export.c

John J. Franey (1):
      Clarify description of <repository> argument to pull/fetch for na=
ming remotes.

Jon Loeliger (4):
      Clarify and fix English in "git-rm" documentation
      Add otherwise missing --strict option to unpack-objects summary.
      git-filter-branch: Clarify file removal example.
      git-show.txt: Not very stubby these days.

Jonas Fonseca (1):
      git-remote: reject adding remotes with invalid names

Junio C Hamano (80):
      Optimize rename detection for a huge diff
      t5300: add test for "unpack-objects --strict"
      unpack-objects: fix --strict handling
      rebase [--onto O] A B: omit needless checkout
      sha1-lookup: more memory efficient search in sorted list of SHA-1
      diff: make --dirstat binary-file safe
      sha1-lookup: make selection of 'middle' less aggressive
      log: teach "terminator" vs "separator" mode to "--pretty=3Dformat=
"
      Document -w option to shortlog
      Documentation/git-submodule: typofix
      git_config_bool_or_int()
      t7401: squelch garbage output
      write_index(): optimize ce_smudge_racily_clean_entry() calls with=
 CE_UPTODATE
      diff-files: mark an index entry we know is up-to-date as such
      Fix git_config_bool_or_int
      rebase: do not munge commit log message
      git-am: minor cleanup
      am: POSIX portability fix
      GIT 1.5.5.1
      First batch of post 1.5.5 updates
      write-tree: properly detect failure to write tree objects
      clone: detect and fail on excess parameters
      fetch-pack: brown paper bag fix
      diff: a submodule not checked out is not modified
      diff-lib.c: rename check_work_tree_entity()
      is_racy_timestamp(): do not check timestamp for gitlinks
      git-svn: add test for --add-author-from and --use-log-author
      builtin-apply: typofix
      builtin-apply: accept patch to an empty file
      builtin-apply: do not declare patch is creation when we do not kn=
ow it
      unpack-trees: allow Porcelain to give different error messages
      "git-add -n -u" should not add but just report
      tests: do not use implicit "git diff --no-index"
      diff-files: do not play --no-index games
      "git diff": do not ignore index without --no-index
      mailinfo: apply the same fix not to lose NULs in BASE64 and QP co=
depaths
      mailsplit: minor clean-up in read_line_with_nul()
      Update draft release notes for 1.5.6
      log --graph: do not accept log --graphbogus
      log --pretty: do not accept bogus "--prettyshort"
      Release Notes for 1.5.5.2
      Documentation/git.txt: link to 1.5.5.2 documentation.
      Makefile: fix dependency on wt-status.h
      show-branch --current: do not barf on detached HEAD
      git-diff: allow  --no-index semantics a bit more
      git diff --no-index: default to page like other diff frontends
      GIT 1.5.5.3
      t5100: Avoid filename "nul"
      Git::cat_blob: allow using an empty blob to fix git-svn breakage
      fix sha1_pack_index_name()
      Manual subsection to refer to other pages is SEE ALSO
      Documentation: git-cherry uses git-patch-id
      "git checkout -- paths..." should error out when paths cannot be =
written
      checkout: make reset_clean_to_new() not die by itself
      checkout: consolidate reset_{to_new,clean_to_new}()
      unpack_trees(): allow callers to differentiate worktree errors fr=
om merge errors
      checkout: "best effort" checkout
      commit: drop duplicated parents
      GIT v1.5.6-rc1
      t7502: do not globally unset GIT_COMMITTER_* environment variable=
s
      t7502: tighten loosely written test sequence
      Documentation: git-log cannot use rev-list specific options
      t7502: honor SHELL_PATH
      GIT 1.5.5.4
      GIT 1.5.6-rc2
      http-push.c: remove duplicated code
      "remote prune": be quiet when there is nothing to prune
      Documentation/git-pull.txt: Use more standard [NOTE] markup
      Documentation: exclude @pxref{[REMOTES]} from texinfo intermediat=
e output
      user-manual: describe how higher stages are set during a merge
      t4126: fix test that happened to work due to timing
      sha1_file.c: dead code removal
      GIT 1.5.6-rc3
      Makefile: update check-docs target
      Update RPM spec to drop curl executable requirement
      diff.c: fix emit_line() again not to add extra line
      create_tempfile: make sure that leading directories can be access=
ible by peers
      sha1_file.c: simplify parse_pack_index()
      builtin-rerere: fix a small leak
      GIT 1.5.6

J=C3=B6rg Sommer (1):
      post-merge: Add it's not executed if merge failed.

Karl Hasselstr=C3=B6m (3):
      Add some tests for git update-ref -d
      Fix path duplication in git svn commit-diff
      Revert "git.el: Set process-environment instead of invoking env"

Kevin Ballard (1):
      Documentation/git-filter-branch.txt: Fix description of --commit-=
filter

Krzysztof Kowalczyk (1):
      alloc_ref_from_str(): factor out a common pattern of alloc_ref fr=
om string

Lars Hjemli (8):
      Add platform-independent .git "symlink"
      Teach resolve_gitlink_ref() about the .git file
      Teach git-submodule.sh about the .git file
      Teach GIT-VERSION-GEN about the .git file
      git-branch: add support for --merged and --no-merged
      git-branch.txt: compare --contains, --merged and --no-merged
      Add tests for `branch --[no-]merged`
      revision.c: really honor --first-parent

Lea Wiemann (13):
      gitweb: only display "next" links in logs if there is a next page
      t/test-lib.sh: resolve symlinks in working directory, for pathnam=
e comparisons
      Git.pm: fix documentation of hash_object
      glossary: improve a few links
      Git.pm: fix return value of config method
      cat-file --batch: flush stdout also when objects are missing
      git-for-each-ref.txt: minor improvements
      t1006-cat-file.sh: typo
      cat-file --batch / --batch-check: do not exit if hashes are missi=
ng
      Documentation/git-cat-file.txt: add missing line break
      t/.gitattributes: only ignore whitespace errors in test files
      gitweb: quote commands properly when calling the shell
      gitweb: remove unused parse_ref method

Linus Torvalds (22):
      Make unpack_trees_options bit flags actual bitfields
      Move name hashing functions into a file of its own
      Make "index_name_exists()" return the cache_entry it found
      Make hash_name_lookup able to do case-independent lookups
      Add 'core.ignorecase' option
      Make branch merging aware of underlying case-insensitive filsyste=
ms
      Make unpack-tree update removed files before any updated files
      When adding files to the index, add support for case-independent =
matches
      Make git-add behave more sensibly in a case-insensitive environme=
nt
      Ignore leading empty lines while summarizing merges
      git-am: cope better with an empty Subject: line
      Optimize match_pathspec() to avoid fnmatch()
      fetch-pack: do not stop traversing an already parsed commit
      Avoid some unnecessary lstat() calls
      Optimize symlink/directory detection
      Make pack creation always fsync() the result
      Remove now unnecessary 'sync()' calls
      Consolidate SHA1 object file close
      Avoid cross-directory renames and linking on object creation
      Make loose object file reading more careful
      Simplify and rename find_sha1_file()
      write_loose_object: don't bother trying to read an old object

Liu Yubao (1):
      Documentation on --git-dir and --work-tree

Luciano Rocha (1):
      git-init: accept --bare option

Marcel Koeppen (2):
      Replace in-place sed in t7502-commit
      Fix prepare-commit-msg hook and replace in-place sed

Marius Storm-Olsen (3):
      Clearify the documentation for core.ignoreStat
      Add shortcut in refresh_cache_ent() for marked entries.
      Add testcase for merging in a CRLF repo

Mark Hills (1):
      Be more careful with objects directory permissions on clone

Mark Levedahl (2):
      git-submodule - possibly use branch name to describe a module
      git-submodule - Fix errors regarding resolve_relative_url

Martin Koegler (3):
      unpack-objects: prevent writing of inconsistent objects
      receive-pack: allow using --strict mode for unpacking objects
      t5300: add test for "index-pack --strict"

Matt Graham (1):
      Linked glossary from cvs-migration page

Matthew Ogilvie (4):
      gitattributes: Fix subdirectory attributes specified from root di=
rectory
      git-cvsserver: add mechanism for managing working tree and curren=
t directory
      implement gitcvs.usecrlfattr
      git-cvsserver: add ability to guess -kb from contents

Matthias Kestenholz (1):
      Use color.ui variable in scripts too

Matthieu Moy (2):
      Document that WebDAV doesn't need git on the server, and works ov=
er SSL
      git-svn: detect and fail gracefully when dcommitting to a void

Michael Dressel (1):
      describe: match pattern for lightweight tags too

Michael Weber (1):
      svn-git: Use binmode for reading/writing binary rev maps

Michele Ballabio (6):
      revision.c: make --date-order overriddable
      gitk: Disable "Reset %s branch to here" when on a detached head
      gitk: Move es.po where it belongs
      builtin-cat-file.c: use parse_options()
      change quoting in test t1006-cat-file.sh
      Documentation: fix graph in git-rev-parse.txt

Mikael Magnusson (1):
      Typo in RelNotes.

Mike Hommey (1):
      Don't allocate too much memory in quote_ref_url

Mike Ralphson (1):
      Makefile: update the default build options for AIX

Miklos Vajna (19):
      git-gc --auto: add pre-auto-gc hook
      Documentation/hooks: add pre-auto-gc hook
      contrib/hooks: add an example pre-auto-gc hook
      diff options documentation: refer to --diff-filter in --name-stat=
us
      git checkout: add -t alias for --track
      git-format-patch: add a new format.cc configuration variable
      git-send-email: add a new sendemail.cc configuration variable
      Add tests for sendemail.cc configuration variable
      INSTALL: add a note about GNU interactive tools has been renamed
      git-fast-import: rename cmd_*() functions to parse_*()
      git-merge: exclude unnecessary options from OPTIONS_SPEC
      CodingGuidelines: Add a note to avoid assignments inside if()
      Revision walking documentation: document most important functions
      Strbuf documentation: document most functions
      Remove unused code in parse_commit_buffer()
      git-rebase -i: mention the short command aliases in the todo list
      git-read-tree: document -v option.
      run-command documentation: fix "memset()" parameter
      path-list documentation: document all functions and data structur=
es

Nicolas Pitre (10):
      pack-objects: small cleanup
      pack-objects: remove some double negative logic
      pack-objects: simplify the condition associated with --all-progre=
ss
      pack-objects: clean up write_object() a bit
      pack-objects: move compression code in a separate function
      pack-objects: allow for early delta deflating
      pack-objects: fix early eviction for max depth delta objects
      add a force_object_loose() function
      let pack-objects do the writing of unreachable objects as loose o=
bjects
      make verify-pack a bit more useful with bad packs

Olivier Marin (5):
      remote show: fix the -n option
      builtin-remote: split show_or_prune() in two separate functions
      remote prune: print the list of pruned branches
      remote show: list tracked remote branches with -n
      Fix approxidate("never") to always return 0

Paolo Bonzini (3):
      Add a remote.*.mirror configuration option
      add special "matching refs" refspec
      rollback lock files on more signals than just SIGINT

Paul Mackerras (41):
      gitk: Use git log without --topo-order and reorganize the commits=
 ourselves
      gitk: Fix bug in assigning row numbers to arcs
      gitk: Fix bug in parsing multiple revision arguments
      gitk: Compute row numbers and order tokens lazily
      gitk: Fix a couple of bugs
      gitk: Fix more bugs resulting in Tcl "no such element in array" e=
rrors
      gitk: More bug fixes and cleanups
      gitk: Implement date mode in the new framework
      gitk: Fix another collection of bugs
      gitk: Don't try to show local changes from a head that isn't show=
n
      gitk: Keep the same commits visible as other commits come in
      gitk: Fix some corner cases in the targetid/targetrow stuff
      gitk: Fix a couple of bugs in the find function
      gitk: Fix potential bug with fake commit IDs in renumbervarc
      gitk: Index [fnvr]highlights by id rather than row
      gitk: Fix handling of flag arguments
      gitk: Fix a bug in make_disporder
      gitk: Select head of current branch by default
      gitk: Select something appropriate on cherry-pick, branch reset a=
nd checkout
      gitk: Fix bug where editing an existing view would cause an infin=
ite loop
      gitk: Fix bug causing Tcl error when no commits are selected
      gitk: Fix cherry-picking to insert a real row not a fake row
      gitk: Cope better with getting commits that we have already seen
      gitk: Fix bug where arcs could get lost
      gitk: Handle updating with path limiting better
      gitk: Fix problems with target row stuff
      gitk: Don't filter view arguments through git rev-parse
      gitk: Correct a few strings and comments to say "git log"
      gitk: Fix some corner cases in computing vrowmod and displayorder
      gitk: Avoid a crash in selectline if commitinfo($id) isn't set
      gitk: Fix problem with target row not being in scroll region
      gitk: Reorganize processing of arguments for git log
      gitk: Fix handling of tree file list with special chars in names
      gitk: Make updates go faster
      gitk: Synchronize highlighting in file view for 'f' and 'b' comma=
nds
      gitk: Show current row number and total number of rows
      gitk: Add a progress bar for checking out a head
      gitk: Fix "wrong # coordinates" error on reload
      gitk: Fix bug where current row number display stops working
      gitk: Fix bug introduced by "gitk: Fix "wrong # coordinates" erro=
r on reload"
      gitk: Handle detached heads better

Paul Oliver (1):
      Make git-cvsimport remove ['s from tags, as bad_ref_char doesn't =
allow them.

Pedro Melo (1):
      Force the medium pretty format on calls to git log

Peter Karlsson (1):
      gitk: Initial Swedish translation.

Philippe Bruhat (BooK) (1):
      git-cvsimport: do not fail when CVSROOT is /

Pierre Habouzit (1):
      Make git reflog expire honour core.sharedRepository.

Pieter de Bie (2):
      builtin-fast-export: Only output a single parent per line
      git-send-email: allow whitespace in addressee list

Ping Yin (6):
      git-submodule: Avoid 'fatal: cannot describe' message
      git-submodule summary: --for-status option
      builtin-status: submodule summary support
      builtin-status: Add tests for submodule summary
      t4027: test diff for submodule with empty directory
      Add t7506 to test submodule related functions for git-status

Rafael Garcia-Suarez (1):
      Spelling fixes in the gitweb documentation

Ren=C3=A9 Scharfe (2):
      git-archive: ignore prefix when checking file attribute
      Ignore .gitattributes in bare repositories

Richard Quirk (2):
      bash: Add completion for gitk --merge
      Documentation gitk: Describe what --merge does

SZEDER G=C3=A1bor (8):
      doc: moved merge.* config variables into separate merge-config.tx=
t
      merge, pull: introduce '--(no-)stat' option
      add 'merge.stat' config variable
      fmt-merge-msg: add '--(no-)log' options and 'merge.log' config va=
riable
      merge, pull: add '--(no-)log' command line option
      git add: add long equivalents of '-u' and '-f' options
      completion: add more 'git add' options
      diff: reset color before printing newline

Sam Vilain (1):
      Amend git-push refspec documentation

Santi B=C3=A9jar (3):
      Preparation to call determine_author_info from prepare_to_commit
      commit: Show author if different from committer
      commit: Show committer if automatic

Santiago Gala (1):
      gitk: Spanish translation of gitk

Scott Collins (1):
      Clarify documentation of git-cvsserver, particularly in relation =
to git-shell

Sebastian Schuberth (1):
      mergetool: Make ECMerge use the settings as specified by the user=
 in the GUI

Seth Falcon (1):
      Add a --dry-run option to git-svn rebase

Shawn Bohrer (2):
      git clean: Don't automatically remove directories when run within=
 subdirectory
      git clean: Add test to verify directories aren't removed with a p=
refix

Shawn O. Pearce (13):
      git-gui: Don't use '$$cr master' with aspell earlier than 0.60
      git-gui: Setup branch.remote,merge for shorthand git-pull
      git-gui: Delete branches with 'git branch -D' to clear config
      git-gui: Add a --trace command line option
      git-gui: Handle workdir detection when CYGWIN=3Dnowinsymlinks
      Clarify repack -n documentation
      Don't diff empty tree on branch creation in paranoid update hook
      Don't load missing ACL files in paranoid update hook
      Ignore no-op changes in paranoid update hook
      Remove unused remote_prefix member in builtin-remote
      Make "git-remote prune" delete refs according to fetch specs
      Make "git-remote rm" delete refs acccording to fetch specs
      fast-export: Correctly generate initial commits with no parents

Sitaram Chamarty (1):
      builtin-commit.c: add -u as short name for --untracked-files

Steffen Prohaska (4):
      t0050: Test autodetect core.ignorecase
      t0050: Set core.ignorecase case to activate case insensitivity
      t0050: Add test for case insensitive add
      t0050: Fix merge test on case sensitive file systems

Stephan Beyer (9):
      builtin-apply.c: use git_config_string() to get apply_default_whi=
tespace
      Add test cases for git-am
      Merge t4150-am-subdir.sh and t4151-am.sh into t4150-am.sh
      git-commit.txt: Correct option alternatives
      git-commit.txt: Add missing long/short options
      Docs: Use "-l::\n--long\n" format in OPTIONS sections
      Docs: add some long/short options
      git-describe.txt: document --always
      git-name-rev.txt: document --no-undefined and --always

Stephen R. van den Berg (2):
      Simplify and fix --first-parent implementation
      git-svn: Same default as cvsimport when using --use-log-author

Steven Grimm (1):
      Add svn-compatible "blame" output format to git-svn

Teemu Likonen (3):
      bash: Add completion for git diff --base --ours --theirs
      Documentation/git-web--browse.txt: fix small typo
      Print info about "git help COMMAND" on git's main usage pages

Thomas Arcila (1):
      gitk: Allow users to view diffs in external diff viewer

Thomas Guyot-Sionnest (1):
      git-svn bug with blank commits and author file

Trent Piepho (1):
      cvsexportcommit: Create config option for CVS dir

Twiinz (1):
      git-gui: Vertically align textboxes with labels

martin f. krafft (2):
      Escape project name in regexp
      Escape project names before creating pathinfo URLs
