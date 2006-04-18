From: Junio C Hamano <junkio@cox.net>
Subject: [Announce] GIT 1.3.0
Date: Tue, 18 Apr 2006 14:55:53 -0700
Message-ID: <7v4q0qeefq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 18 23:56:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVyAy-0007LL-Eb
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 23:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWDRVz5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 18 Apr 2006 17:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWDRVz4
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 17:55:56 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:53399 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750725AbWDRVzz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Apr 2006 17:55:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060418215554.IUMH16517.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 18 Apr 2006 17:55:54 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18883>

The latest feature release GIT 1.3.0 is available at the usual places:

	http://www.kernel.org/pub/software/scm/git/

	git-1.3.0.tar.{gz,bz2}			(tarball)
	RPMS/$arch/git-*-1.3.0-1.$arch.rpm	(RPM)


There are many fixes and enhancements all over the place, and here is
only a list of notable user-visible changes in 1.3.0 since 1.2.6:

 - git-cvsserver (Martin Langhoff).

   This allows you to make your git repo accessible from CVS clients.

 - Annotate/blame (Ryan Anderson and Fredrik Kuivinen).

   These are alternate implementations of cvs annotate
   equivalent.  One of them probably needs to be eventually
   retired, but for now they are kept while both of them
   still have room for improvements.

 - builtin diff generation is now truly built-in.  We do not
   rely on GNU diff anymore (Linus and Davide Libenzi).

   This unfortunately makes GIT_DIFF_OPTS less useful; it can
   only take -u<n> or --unified=3D<n> and nothing else.

 - diff family acquired --stat, --patch-with-stat and --patch-with-raw
   output formats (Johannes Schindelin, Petr Baudis).

 - git-log command now takes diff options to act as a
   replacement for git-whatchanged.

 - rename detector was simplified and got faster (Linus and me).

 - clone --use-separate-remote; a repository cloned with this
   flag will copy the upstream branch heads under .git/remotes/origin/,
   not .git/heads/.  You will get the default "master" branch
   that starts out as a copy of the upstream HEAD.

 - A lot lower start-up latency for git-log, even when limiting
   by paths (Linus).

 - "git-commit --amend" can be used to amend the tip commit of the
   current branch.

 - Human date parsing is a bit friendlier to our European friends by
   preferring dd.mm.yy format over mm.dd.yy.

 - contrib/ hierarchy.  Things that are not purely git proper
   but are "around git" are shipped with git.  Current
   piggybackers are:

   - Two Emacs interfaces (Alexandre Julliard)
   - Alternative SVN interface (Eric Wong)
   - Alternative repository viewer (Aneesh Kumar)

----------------------------------------------------------------
(Shortlog since v1.2.6)

A Large Angry SCM:
      Makefile fixups.

Alex Riesen:
      PATCH: simplify calls to git programs in git-fmt-merge-msg
      workaround fat/ntfs deficiencies for t3600-rm.sh (git-rm)

Alexandre Julliard:
      Add an Emacs interface in contrib.
      git-format-patch: Always add a blank line between headers and bod=
y.
      contrib/emacs: Add an Emacs VC backend.
      git.el: Portability fixes for XEmacs and Emacs CVS.
      git.el: Set default directory before running the status mode setu=
p hooks.
      git.el: Automatically update .gitignore status.
      git.el: Added support for Signed-off-by.
      git.el: Added customize support for all parameters.
      ls-files: Don't require exclude files to end with a newline.
      git.el: More robust handling of subprocess errors when returning =
strings.
      git.el: Get the default user name and email from the repository c=
onfig.
      git.el: Added a function to diff against the other heads in a mer=
ge.

Anand Kumria:
      git-svnimport: if a limit is specified, respect it

Aneesh Kumar K.V:
      Add contrib/gitview from Aneesh.
      Add a README for gitview
      gitview: typofix
      gitview: Read tag and branch information using git ls-remote
      gitview: Use monospace font to draw the branch and tag name
      gitview: Display the lines joining commit nodes clearly.
      gitview: Fix DeprecationWarning
      gitview: Bump the rev
      gitview: Code cleanup
      gitview: Fix the graph display .
      gitview: Fix the encoding related bug
      gitview: Remove trailing white space
      gitview: Some window layout changes.
      gitview: Set the default width of graph cell
      gitview: Use horizontal scroll bar in the tree view
      gitview: pass the missing argument _show_clicked_cb.

Carl Worth:
      git-rebase: Clarify usage statement and copy it into the actual d=
ocumentation.
      New test to verify that when git-clone fails it cleans up the new=
 directory.
      git-ls-files: Fix, document, and add test for --error-unmatch opt=
ion.
      Add new git-rm command with documentation
      git-rm: Fix to properly handle files with spaces, tabs, newlines,=
 etc.

Davide Libenzi:
      Clean-up trivially redundant diff.
      xdiff: post-process hunks to make them consistent.

Dennis Stosberg:
      Solaris 9 also wants our own unsetenv/setenv.
      Replace index() with strchr().

Dmitry V. Levin:
      git/Documentation: fix SYNOPSIS style bugs

Eric W. Biederman:
      Implement limited context matching in git-apply.

Eric Wong:
      Introducing contrib/git-svn.
      git-svn: fix revision order when XML::Simple is not loaded
      git-svn: ensure fetch always works chronologically.
      git-svn: remove files from the index before adding/updating
      git-svn: fix a typo in defining the --no-stop-on-copy option
      git-svn: allow --find-copies-harder and -l<num> to be passed on c=
ommit
      git-svn: Allow for more argument types for commit (from..to)
      git-svn: remove any need for the XML::Simple dependency
      git-svn: change ; to && in addremove()
      contrib/git-svn.txt: add a note about renamed/copied directory su=
pport
      git-svn: fix several corner-case and rare bugs with 'commit'
      contrib/git-svn: add Makefile, test, and associated ignores
      git-svn: 0.9.1: add --version and copyright/license (GPL v2+) inf=
ormation
      contrib/git-svn: add show-ignore command
      contrib/git-svn: optimize sequential commits to svn
      contrib/git-svn: version 0.10.0
      contrib/git-svn: tell the user to not modify git-svn-HEAD directl=
y
      contrib/git-svn: correct commit example in manpage
      contrib/git-svn: use refs/remotes/git-svn instead of git-svn-HEAD
      git-branch: add -r switch to list refs/remotes/*
      contrib/git-svn: add -b/--branch switch for branch detection
      contrib/git-svn: several small bug fixes and changes
      contrib/git-svn: strip 'git-svn-id:' when commiting to SVN
      contrib/git-svn: allow --authors-file to be specified
      contrib/git-svn: cleanup option parsing
      contrib/git-svn: create a more recent master if one does not exis=
t
      contrib/git-svn: avoid re-reading the repository uuid, it never c=
hanges
      contrib/git-svn: add --id/-i=3D$GIT_SVN_ID command-line switch
      contrib/git-svn: better documenting of CLI switches
      send-email: accept --no-signed-off-by-cc as the documentation sta=
tes
      contrib/git-svn: fix a copied-tree bug in an overzealous assertio=
n
      contrib/git-svn: fix svn compat and fetch args
      contrib/git-svn: remove the --no-stop-on-copy flag
      contrib/git-svn: fix a harmless warning on rebuild (with old repo=
s)
      fetch,parse-remote,fmt-merge-msg: refs/remotes/* support
      ls-tree: add --abbrev[=3D<n>] option
      ls-files: add --abbrev[=3D<n>] option
      contrib/git-svn: allow rebuild to work on non-linear remote heads
      send-email: use built-in time() instead of /bin/date '+%s'
      send-email: Change from Mail::Sendmail to Net::SMTP
      send-email: try to order messages in email clients more correctly
      send-email: lazy-load Email::Valid and make it optional
      contrib/git-svn: stabilize memory usage for big fetches
      contrib/git-svn: force GIT_DIR to an absolute path
      contrib/git-svn: accept configuration via repo-config
      contrib/git-svn: documentation updates
      contrib/git-svn: ensure repo-config returns a value before using =
it
      contrib/git-svn: make sure our git-svn is up-to-date for test
      contrib/git-svn: handle array values correctly

=46ernando J. Pereda:
      Allow building Git in systems without iconv

=46rancis Daly:
      AsciiDoc fix for tutorial
      Tweak asciidoc output to work with broken docbook-xsl
      Fix multi-paragraph list items in OPTIONS section
      Format tweaks for asciidoc.
      Tweaks to make asciidoc play nice.

=46redrik Kuivinen:
      Add git-blame, a tool for assigning blame.
      git-blame, take 2
      git-blame: Make the output human readable
      git-blame: Use the same tests for git-blame as for git-annotate
      Fix some inconsistencies in the docs
      Remove trailing dot after short description
      Nicer output from 'git'
      Make it possible to not clobber object.util in sort_in_topologica=
l_order (take 2)
      rev-lib: Make it easy to do rename tracking (take 2)
      blame: Rename detection (take 2)
      blame: Nicer output
      blame: Fix git-blame <directory>
      Makefile: Add TAGS and tags targets

Herbert Valerio Riedel:
      git-svnimport symlink support

J. Bruce Fields:
      Document git-rebase behavior on conflicts.
      Documentation: revise top of git man page

Jason Riedy:
      Fix typo in git-rebase.sh.
      Add ALL_LDFLAGS to the git target.

Jeff Muizelaar:
      cosmetics: change from 'See-Also' to 'See Also'
      documentation: add 'see also' sections to git-rm and git-add

Jim Radford:
      fix repacking with lots of tags

Johannes Schindelin:
      Fix cpio call
      Optionally support old diffs
      Support Irix
      Optionally work without python
      Fixes for ancient versions of GNU make
      avoid makefile override warning
      Really honour NO_PYTHON
      Fix "gmake -j"
      Use Ryan's git-annotate instead of jsannotate
      Warn about invalid refs
      Fix test case for some sed
      imap-send: Add missing #include for macosx
      Remove dependency on a file named "-lz"
      cvsimport: use git-update-ref when updating
      On some platforms, certain headers need to be included before reg=
ex.h
      Fix compile with expat, but an old curl version
      diff-options: add --stat (take 2)
      diff-options: add --stat (take 2)
      diff-options: add --patch-with-stat
      pager: do not fork a pager if PAGER is set to empty.

Jon Loeliger:
      Add git-show reference
      Call out the two different uses of git-branch and fix a typo.
      Document the default source of template files.
      Clarify git-rebase example commands.
      Reference git-commit-tree for env vars.
      Fix minor typo.
      Rewrite synopsis to clarify the two primary uses of git-checkout.
      Clarify and expand some hook documentation.
      Removed bogus "<snap>" identifier.
      Added Packing Heursitics IRC writeup.

Jonas Fonseca:
      manpages: insert two missing [verse] markers for multi-line SYNOP=
SIS
      repo-config: give value_ a sane default so regexec won't segfault
      Add git-annotate(1) and git-blame(1)

Josef Weidendorfer:
      git-mv: fix moves into a subdir from outside

Junio C Hamano:
      "Assume unchanged" git
      "Assume unchanged" git: do not set CE_VALID with --refresh
      ls-files: debugging aid for CE_VALID changes.
      "Assume unchanged" git: --really-refresh fix.
      ls-files: split "show-valid-bit" into a different option.
      "assume unchanged" git: documentation.
      cache_name_compare() compares name and stage, nothing else.
      git-commit: Now --only semantics is the default.
      rebase: allow a hook to refuse rebasing.
      commit: detect misspelled pathspec while making a partial commit.
      rebase: allow rebasing onto different base.
      ls-files --error-unmatch pathspec error reporting fix.
      Detect misspelled pathspec to git-add
      packed objects: minor cleanup
      topo-order: make --date-order optional.
      pack-objects: reuse data from existing packs.
      pack-objects: finishing touches.
      git-repack: allow passing a couple of flags to pack-objects.
      git-tag: -l to list tags (usability).
      Add contrib/README.
      SubmittingPatches: note on whitespaces
      pack-objects: avoid delta chains that are too long.
      Make "empty ident" error message a bit more helpful.
      Delay "empty ident" errors until they really matter.
      Keep Porcelainish from failing by broken ident after making chang=
es.
      fmt-merge-msg: say which branch things were merged into unless 'm=
aster'
      Allow git-mv to accept ./ in paths.
      Documentation: fix typo in rev-parse --short option description.
      fmt-merge-msg: do not add excess newline at the end.
      rev-list --objects-edge
      Thin pack - create packfile with missing delta base.
      send-pack --thin: use "thin pack" delta transfer.
      Add git-push --thin.
      Use thin pack transfer in "git fetch".
      fmt-merge-msg: avoid open "-|" list form for Perl 5.6
      rerere: avoid open "-|" list form for Perl 5.6
      send-email: avoid open "-|" list form for Perl 5.6
      svnimport: avoid open "-|" list form for Perl 5.6
      cvsimport: avoid open "-|" list form for Perl 5.6
      Fix fmt-merge-msg counting.
      cherry-pick/revert: error-help message rewording.
      git-mktree: reverse of git-ls-tree.
      rev-list.c: fix non-grammatical comments.
      send-pack: do not give up when remote has insanely large number o=
f refs.
      gitview: ls-remote invocation shellquote safety.
      pack-objects: thin pack micro-optimization.
      pack-objects: use full pathname to help hashing with "thin" pack.
      count-delta: tweak counting of copied source material.
      count-delta: fix counting of copied source.
      Tweak break/merge score to adjust to the new delta generation cod=
e.
      pack-objects: allow "thin" packs to exceed depth limits
      rev-list --objects-edge: remove duplicated edge commit output.
      rev-list --objects: use full pathname to help hashing.
      pack-objects: hash basename and direname a bit differently.
      Revert "diff-delta: produce optimal pack data"
      Build and install git-mailinfo.
      rev-list split: minimum fixup.
      apply --whitespace fixes and enhancements.
      apply: squelch excessive errors and --whitespace=3Derror-all
      apply --whitespace: configuration option.
      git-apply --whitespace=3Dnowarn
      Revert "Revert "diff-delta: produce optimal pack data""
      git-apply: war on whitespace -- finishing touches.
      diffcore-break: micro-optimize by avoiding delta between identica=
l files.
      diffcore-rename: split out the delta counting code.
      diffcore-delta: stop using deltifier for packing.
      git-am: --whitespace=3Dx option.
      diff-delta: cull collided hash bucket more aggressively.
      git-log (internal): add approxidate.
      git-log (internal): more options.
      Pretty-print tagger dates.
      war on whitespaces: documentation.
      Documentation: read-tree --aggressive
      Documentation: rev-list --objects-edge
      annotate: resurrect raw timestamps.
      setup_revisions(): handle -n<n> and -<n> internally.
      GIT-VERSION-GEN: squelch unneeded error from "cat version"
      show-branch --topics
      git-commit --amend
      git-commit: make sure we protect against races.
      diffcore-rename: similarity estimator fix.
      show-branch --topics: omit more uninteresting commits.
      count-delta: no need for this anymore.
      diffcore-break: similarity estimator fix.
      diffcore-delta: make change counter to byte oriented again.
      git-commit --amend: allow empty commit.
      Const tightening.
      verify-pack -v: show delta-chain histogram.
      blame: avoid -lm by not using log().
      blame and annotate: show localtime with timezone.
      blame: avoid "diff -u0".
      annotate/blame tests updates.
      annotate-blame test: don't "source", but say "."
      annotate-blame test: add evil merge.
      blame: unbreak "diff -U 0".
      annotate-blame: tests incomplete lines.
      pack-objects: simplify "thin" pack.
      Use #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
      refs.c::do_for_each_ref(): Finish error message lines with "\n"
      fsck-objects: Remove --standalone
      Fix t1200 test for breakage caused by removal of full-stop at the=
 end of fast-forward message.
      try_to_simplify_commit(): do not skip inspecting tree change at b=
oundary.
      repack: prune loose objects when -d is given
      git-diff: -p disables rename detection.
      diffcore-rename: somewhat optimized.
      revision traversal: --remove-empty fix.
      revision traversal: --remove-empty fix (take #2).
      diffcore-delta: make the hash a bit denser.
      diffcore-delta: tweak hashbase value.
      cvsimport: honor -i and non -i upon subsequent imports
      fetch: exit non-zero when fast-forward check fails.
      cvsimport: fix reading from rev-parse
      git-pull: run repo-config with dash form.
      unpack_delta_entry(): reduce memory footprint.
      generate-cmdlist: style cleanups.
      revamp git-clone.
      git-merge knows some strategies want to skip trivial merges
      http-fetch: nicer warning for a server with unreliable 404 status
      core.warnambiguousrefs: warns when "name" is used and both "name"=
 branch and tag exists.
      revamp git-clone (take #2).
      get_sha1_basic(): try refs/... and finally refs/remotes/$foo/HEAD
      clone: record the remote primary branch with remotes/$origin/HEAD
      http-push.c: squelch C90 warnings.
      git-apply: do not barf when updating an originally empty file.
      rev-list --timestamp
      git-clone: typofix.
      git-pull: further safety while on tracking branch.
      git-pull: reword "impossible to fast-forward" message.
      sha1_name: warning ambiguous refs.
      sha1_name: make core.warnambiguousrefs the default.
      send-email: Identify author at the top when sending e-mail
      commit-tree: check return value from write_sha1_file()
      built-in diff: minimum tweaks
      true built-in diff: run everything in-core.
      git-push: make --thin pack transfer the default.
      add clean and ignore rules for xdiff/
      GIT 1.3.0 rc1
      rev-list --no-merges: argument parsing fix.
      rev-list: memory usage reduction.
      rev-list --boundary
      revision arguments: ..B means HEAD..B, just like A.. means A..HEA=
D
      revision.c "..B" syntax: constness fix
      assume unchanged git: diff-index fix.
      tree/diff header cleanup.
      rev-list --boundary: fix re-injecting boundary commits.
      Makefile: many programs now depend on xdiff/lib.a having been bui=
lt.
      revision: --topo-order and --unpacked
      revision: simplify argument parsing.
      revision: --max-age alone does not need limit_list() anymore.
      git-clone: fix handling of upsteram whose HEAD does not point at =
master.
      GIT 1.3.0-rc2
      combine-diff: use built-in xdiff.
      combine-diff: refactor built-in xdiff interface.
      combine-diff: move the code to parse hunk-header into common libr=
ary.
      blame: use built-in xdiff
      date parsing: be friendlier to our European friends.
      blame.c: fix completely broken ancestry traversal.
      Match ofs/cnt types in diff interface.
      blame -S <ancestry-file>
      Add Documentation/technical/pack-format.txt
      Thin pack generation: optimization.
      rev-list --abbrev-commit
      count-delta: match get_delta_hdr_size() changes.
      GIT 1.3.0-rc3
      git-log: match rev-list --abbrev and --abbrev-commit
      diff: fix output of total-rewrite diff.
      diffcore-rename: fix merging back a broken pair.
      log-tree: separate major part of diff-tree.
      git log [diff-tree options]...
      Retire diffcore-pathspec.
      tree-diff: do not assume we use only one pathspec
      git log --full-diff
      Retire git-log.sh
      blame and friends: adjust to multiple pathspec change.
      Retire git-log.sh (take#2)
      diff-* --patch-with-raw
      Retire git-log.sh (take #3)
      combine-diff: do not lose hunks with only deletion at end.
      combine-diff: fix hunks at the end (take #2).
      Retire t5501-old-fetch-and-upload test.
      git-commit: do not muck with commit message when no_edit is set.
      stripspace: make sure not to leave an incomplete line.
      combine-diff: type fix.
      Documentation: add a couple of missing docs.
      Makefile: $(MAKE) check-docs
      git-log: do not output excess blank line between commits
      t3600-rm: skip failed-remove test when we cannot make an unremova=
ble file.
      Fix-up previous expr changes.
      diff --stat: no need to ask funcnames nor context.
      t5500: test fix
      stripspace: incomplete line fix (take #2)
      Retire git-log.sh (take #4)
      git-log <diff-options> <paths> documentation
      "git cmd -h" for shell scripts.
      rev-list --bisect: limit list before bisecting.
      GIT v1.3.0-rc4
      diff-tree: typefix.
      diff --stat: do not do its own three-dashes.
      diff-files --stat: do not dump core with unmerged index.
      reading $GIT_DIR/info/graft - skip comments correctly.
      rev-list --boundary: show boundary commits even when limited othe=
rwise.
      packed_object_info_detail(): check for corrupt packfile.
      diff --stat: make sure to set recursive.
      GIT 1.3.0

Karl Hasselstr=F6m:
      git-svnimport: -r adds svn revision number to commit messages
      svnimport: Mention -r in usage summary
      svnimport: Convert executable flag
      svnimport: Convert the svn:ignore property
      svnimport: Read author names and emails from a file
      Let git-svnimport's author file use same syntax as git-cvsimport'=
s
      Save username -> Full Name <email@addr.es> map file
      git-svnimport: Don't assume that copied files haven't changed

Keith Packard:
      Provide configurable UI font for gitk

Linus Torvalds:
      Handling large files with GIT
      Handling large files with GIT
      git-merge-tree: generalize the "traverse <n> trees in sync" funct=
ionality
      Teach the "git" command to handle some commands internally
      First cut at libifying revlist generation
      Make git diff-generation use a simpler spawn-like interface
      The war on trailing whitespace
      Splitting rev-list into revisions lib, end of beginning.
      git-rev-list libification: rev-list walking
      Introduce trivial new pager.c helper infrastructure
      Tie it all together: "git log"
      Rip out merge-order and make "git log <paths>..." work again.
      get_revision(): do not dig deeper when we know we are at the end.
      git-fmt-merge-msg cleanup
      Fix up diffcore-rename scoring
      diffcore-delta: 64-byte-or-EOL ultrafast replacement.
      diffcore-delta: 64-byte-or-EOL ultrafast replacement (hash fix).
      git-apply: safety fixes
      Use a *real* built-in diff generator
      builtin-diff: \No newline at end of file.
      Fix error handling for nonexistent names
      Move "--parent" parsing into generic revision.c library code
      Make path-limiting be incremental when possible.
      revision: Fix --topo-order and --max-age with reachability limiti=
ng.
      Make "--parents" logs also be incremental
      When showing a commit message, do not lose an incomplete line.
      Use less memory in "git log"
      Clean up trailing whitespace when pretty-printing commits
      Support "git cmd --help" syntax

Lukas Sandstr=F6m:
      git-fetch: print the new and old ref when fast-forwarding

Marco Costalba:
      Add a Documentation/git-tools.txt

Marco Roeland:
      imap-send: cleanup execl() call to use NULL sentinel instead of 0
      git-commit: document --amend
      xdiff/xdiffi.c: fix warnings about possibly uninitialized variabl=
es

Mark Hollomon:
      Let merge set the default strategy.

Mark Wooding:
      combine-diff: Honour --full-index.
      combine-diff: Honour -z option correctly.
      Documentation/Makefile: Some `git-*.txt' files aren't manpages.
      gitignore: Ignore some more boring things.
      contrib/emacs/Makefile: Provide tool for byte-compiling files.
      annotate-tests: override VISUAL when running tests.
      xdiff: Show function names in hunk headers.
      gitk: Use git wrapper to run git-ls-remote.
      Shell utilities: Guard against expr' magic tokens.

Martin Langhoff:
      Introducing git-cvsserver -- a CVS emulator for git.
      cvsserver: add notes on how to get a checkout under Eclipse
      cvsserver: Eclipse compat fixes - implement Questionable, alias r=
log, add a space after the U
      cvsserver: Eclipse compat - browsing 'modules' (heads in our case=
) works
      cvsserver: add notes on how to get a checkout under Eclipse
      cvsserver: Eclipse compat fixes - implement Questionable, alias r=
log, add a space after the U
      cvsserver: Eclipse compat - browsing 'modules' (heads in our case=
) works
      cvsserver: Checkout correctly on Eclipse
      annotate: fix -S parameter to take a string
      cvsserver: Eclipse compat -- now "compare with latest from HEAD" =
works
      cvsserver: checkout faster by sending files in a sensible order
      cvsserver: fix checkouts with -d <somedir>
      cvsserver: checkout faster by sending files in a sensible order
      cvsserver: fix checkouts with -d <somedir>
      cvsserver: nested directory creation fixups for Eclipse clients
      cvsserver: better error messages
      cvsserver: anonymous cvs via pserver support
      cvsserver: updated documentation

Martin Mares:
      gitk: Make error_popup react to Return

Matthias Urlichs:
      cvsimport: Remove master-updating code
      Don't recurse into parents marked uninteresting.

Mike McCormack:
      Allow adding arbitary lines in the mail header generated by forma=
t-patch.
      Allow format-patch to attach patches
      Document the --attach flag.
      Describe how to add extra mail header lines in mail generated by =
git-format-patch.
      Add git-imap-send, derived from isync 1.0.1.
      Avoid a divide by zero if there's no messages to send.
      Avoid a crash if realloc returns a different pointer.
      Add documentation for git-imap-send.

Nick Hengeveld:
      Update http-push functionality
      http-push: fix revision walk
      HTTP slot reuse fixes
      http-push: refactor remote file/directory processing
      http-push: improve remote lock management
      http-push: support for updating remote info/refs
      http-push: cleanup
      Fix broken slot reuse when fetching alternates
      http-push: add support for deleting remote branches
      http-push: don't assume char is signed
      git-ls-remote: send no-cache header when fetching info/refs
      Set HTTP user agent to git/GIT_VERSION
      http-fetch: add optional DAV-based pack list

Nicolas Pitre:
      relax delta selection filtering in pack-objects
      diff-delta: fold two special tests into one plus cleanups
      diff-delta: produce optimal pack data
      diff-delta: big code simplification
      diff-delta: bound hash list length to avoid O(m*n) behavior
      diff-delta: produce optimal pack data
      diff-delta: bound hash list length to avoid O(m*n) behavior
      diff-delta: allow reusing of the reference buffer index
      test-delta needs zlib to compile
      diff-delta: bound hash list length to avoid O(m*n) behavior
      3% tighter packs for free

Olaf Hering:
      allow double click on current HEAD id after git-pull

Paul Jakma:
      Makefile tweaks: Solaris 9+ dont need iconv / move up uname varia=
bles

Paul Mackerras:
      gitk: Make "find" on "Files" work again.
      gitk: New improved gitk
      gitk: Fix clicks on arrows on line ends
      gitk: Fix Update menu item
      gitk: Various speed improvements
      gitk: Further speedups
      gitk: Fix a bug in drawing the selected line as a thick line
      gitk: Fix display of diff lines beginning with --- or +++
      gitk: Make commitdata an array rather than a list
      gitk: Don't change cursor at end of layout if find in progress
      gitk: Make downward-pointing arrows end in vertical line segment
      gitk: Improve appearance of first child links
      gitk: Fix two bugs reported by users
      gitk: Use the new --boundary flag to git-rev-list
      gitk: Show diffs for boundary commits
      gitk: Prevent parent link from overwriting commit headline
      gitk: Allow top panes to scroll horizontally with mouse button 2
      gitk: Better workaround for arrows on diagonal line segments
      gitk: replace parent and children arrays with lists
      gitk: Add a help menu item to display key bindings
      gitk: Fix incorrect invocation of getmergediffline
      gitk: Fix bug caused by missing commitlisted elements

Pavel Roskin:
      gitview: Select the text color based on whether the entry in high=
lighted. Use standard font.
      Add git-clean command
      gitk: Fix searching for filenames in gitk

Peter Eriksen:
      Use blob_, commit_, tag_, and tree_type throughout.
      Replace xmalloc+memset(0) with xcalloc.

Petr Baudis:
      Properly git-bisect reset after bisecting from non-master head
      Optionally do not list empty directories in git-ls-files --others
      Support for pickaxe matching regular expressions
      Improve the git-diff-tree -c/-cc documentation
      Document --patch-with-raw
      Separate the raw diff and patch with a newline

Randal L. Schwartz:
      fix imap-send for OSX

Rene Scharfe:
      tar-tree: Use SHA1 of root tree for the basedir
      tar-tree: Introduce write_entry()
      tar-tree: Use write_entry() to write the archive contents
      tar-tree: Remove obsolete code
      tar-tree: Use the prefix field of a tar header
      Remove useless pointer update
      Fix sparse warnings about usage of 0 instead of NULL
      Fix sparse warnings about non-ANSI function prototypes

Rutger Nijlunsing:
      gitk: add key bindings for selecting first and last commit

Ryan Anderson:
      send-email: Add some options for controlling how addresses are au=
tomatically added to the cc: list.
      send-email: Add --cc
      Add git-annotate, a tool for assigning blame.
      annotate: Handle dirty state and arbitrary revisions.
      annotate: Convert all -| calls to use a helper open_pipe().
      annotate: Use qx{} for pipes on activestate.
      annotate: handle \No newline at end of file.
      annotate: Add a basic set of test cases.
      annotate: Support annotation of files on other revisions.

Sean Estabrooks:
      annotate.perl triggers rpm bug

Serge E. Hallyn:
      cleanups: Fix potential bugs in connect.c
      cleanups: Remove unused vars from combine-diff.c
      cleanups: Remove impossible case in quote.c
      cleanups: prevent leak of two strduped strings in config.c
      cleanups: remove unused variable from exec_cmd.c

Shawn Pearce:
      git ls files recursively show ignored files
      Add missing programs to ignore list
      Darwin: Ignore missing /sw/lib
      Teach git-checkout-index to read filenames from stdin.
      Prevent --index-info from ignoring -z.
      Add --temp and --stage=3Dall options to checkout-index.
      Add missing semicolon to sed command.

Stephen Rothwell:
      gitk: allow goto heads

Timo Hirvonen:
      Use setenv(), fix warnings

Tony Luck:
      fix warning from pack-objects.c
      Re-fix compilation warnings.
      annotate should number lines starting with 1
      fix field width/precision warnings in blame.c

Yann Dirson:
      Allow empty lines in info/grafts

Yasushi SHOJI:
      Be verbose when !initial commit
      Make git-clone to take long double-dashed origin option (--origin=
)
      git-clone: exit early if repo isn't specified
