From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [ANNOUNCE] Stacked Git 0.15-rc1
Date: Sun, 12 Jul 2009 23:40:05 +0100
Message-ID: <b0943d9e0907121540n4b9199e2re3152e71d84a0f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 13 00:41:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQ7jf-0002Sm-Ei
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 00:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbZGLWk0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jul 2009 18:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752070AbZGLWkZ
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 18:40:25 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:64922 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753757AbZGLWkI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Jul 2009 18:40:08 -0400
Received: by fxm18 with SMTP id 18so1886789fxm.37
        for <git@vger.kernel.org>; Sun, 12 Jul 2009 15:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=wT37cOUdGeofg5oIzjVKjY1j3rfzhwV5xjb+EL5/kiI=;
        b=CkdthFCLTQkkm3/crHhtzEgnQ3YlbF0iqIPNCq1Z1a/Y/3O69/fZF7E3ULDTDxmfJa
         UvRQTSk79QXI7UN55WAr20QV2aDDhONxmUGSXp/zApL+MX/hlxmX43Qk6X/JwXQSdK6W
         66tRGXOZeG7sRJWh+p9pP6Bk/acKmlEJ19tUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=FsvACpeN3wtFfmsNmR7HMDbTvz4IS7cBGLLqcF5QCidytcweV6Ij23QBysert7sAhY
         VyGWXtrWuYVgrqTJRmEN+vrq1UKT3bOFXuAJ5HOg+hTVAaruVGsncrQqAOV2giaB2egH
         SACvQ2ZQ6Fy5Uf6xd2oFo22dlF5tvxqMepDiQ=
Received: by 10.223.122.204 with SMTP id m12mr1795825far.73.1247438405897; 
	Sun, 12 Jul 2009 15:40:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123167>

The first release candidate for StGit 0.15 is available from the
git://repo.or.cz/stgit.git or http://download.gna.org/stgit/. Bugs can
be reported on the Git mailing list or via the project bugs page
(https://gna.org/bugs/?group=3Dstgit).

StGit is a Python application providing similar functionality to Quilt
(i.e. pushing/popping patches to/from a stack) on top of Git. These
operations are performed using Git commands and the patches are stored
as Git commit objects, allowing easy merging of the StGit patches into
other repositories using standard Git functionality.

The main changes since release 0.14.3 (I may miss some important
features but they can be found in the log):

- New core infrastructure for repository operations
- Infinite undo/redo operations and corresponding commands
- Automatic reverting of changes following a failed operation (using
  transactions)
- New 'squash' command for combining two or more patches into one
- New 'publish' command for maintaining merge-friendly branches (which
  are not rebased)
- New patch identification format - <branch>:<patch> (see 'id' command)
- UI improvements and removal of the 'add', 'rm' and 'resolved' command=
s
  since there are corresponding Git equivalents
- Emacs mode improvements
- Man pages and improved tutorial

Special thanks go to Karl Hasselstr=F6m for the hard work done on the
new StGit features.

Acknowledgements:

Karl Hasselstr=F6m (182):
      Let parse_patch take a string instead of a file parameter
      Make generic --message/--file/--save-template flags
      Name the exit codes to improve legibility
      Emacs mode: Show keybindings when user presses "h" or "?"
      Emacs mode: Add an explanatory header
      Emacs mode: Makefile for building stgit.el
      Emacs mode: push/pop next patch, not patch at point
      Emacs mode: Let "P" push or pop patch at point
      Emacs mode: Bind "G" to "stg goto"
      Emacs mode: show patches' short description
      Write removed fields for backwards compatibility
      Nicer conflict markers
      Better error message if merge fails
      Fix "stg resolved" to work with new conflict representation
      Refactoring: pass more than one file to resolved()
      We keep the different stages of a conflict in the index now
      Remove "stg add"
      Remove "stg rm"
      Remove "stg cp"
      New StGit core infrastructure: repository operations
      Write metadata files used by the old infrastructure
      Upgrade older stacks to newest version
      Let "stg clean" use the new infrastructure
      Add "stg coalesce"
      Let "stg applied" and "stg unapplied" use the new infrastructure
      Teach the new infrastructure about the index and worktree
      Let "stg clean" use the new transaction primitives
      Let "stg goto" use the new infrastructure
      Convert "stg uncommit" to the new infrastructure
      New infrastructure: Make sure that the branch is initialized
      Expose transaction abort function
      stg coalesce: Support --file and --save-template
      Set exit code to 3 on merge conflict
      Convert "stg commit" to new infrastructure
      Make "stg commit" fancier
      Test that "stg goto" can be called from a subdirectory
      Make "stg goto" subdirectory safe
      Don't keep old committer when rewriting a commit
      Homogenize buffer names
      Remove unused default values
      Refactor --diff-opts handling
      Create index and worktree objects just once
      Wrap excessively long line
      Eliminate temp variable that's used just once
      Simplify editor selection logic
      Let the caller supply the diff text to diffstat()
      Don't clean away patches with conflicts
      Don't check out files if we don't have index+workdir
      Make documentation less confusing
      Reduce number of backslashes by using raw strings
      Let "stg show" use the unified --diff-opts handling
      Read default diff options from the user's config
      Teach new infrastructure about the default author and committer
      Teach new infrastructure to apply patches
      Teach new infrastructure to diff two trees
      Parse the date instead of treating it as an opaque string
      Convert "stg edit" to the new infrastructure
      Emacs mode: It's possible to edit unapplied patches now
      Remove unused data field
      Emacs mode: change "stg repair" binding
      Use a special exit code for bugs
      Make sure patches with no parents have an empty list of parents
      Try uncommitting a commit with not exactly one parent
      Make sure that we only uncommit commits with exactly one parent
      New test: conflicting push in dirty worktree
      Handle failed pushes differently depending on cause
      Merge branch 'stable' into stable-master-merge
      Don't both change directory and set GIT_WORK_TREE
      Log environment and cwd as well as the actual command
      emacs mode: handle "stg status" output with #
      If a patch is not changed when pushing, reuse the same commit obj=
ect
      Handle commandline parsing errors gracefully
      Use hardcoded author and committer names in tests
      Steal more test-lib.sh updates from git
      Get rid of backticks in test-lib.sh
      Use test_cmp instead of diff -u in the test suite
      Remove "stg" from start of log messages
      Import version to a separate namespace
      Better StGit version tracking
      Emacs mode: automatically cd up to root of worktree
      Try the built-in version string before git-describe
      Disable patchlog test for "stg new"
      Convert "stg new" to the new infrastructure
      Refactor --author/--committer options
      Let "stg new" support more message options
      Emacs mode: use "stg new --file"
      Convert "stg delete" to the new infrastructure
      Emacs mode: delete patches
      Prevent most commands from running when there are conflicts
      Add property with a list of all patch names
      Merge branch 'stable' into stable-master-merge
      Wrap the text of error messages
      Some API documentation for the new infrastructure
      Fix typo
      Try "stg sink" without applied patches
      Fix "stg sink" with no applied patches (bug 11887)
      Merge branch 'stable' into stable-master-merge
      Test "stg status" with renames
      Don't allow extra diff options with "stg status"
      Merge branch 'stable'
      Test "stg status" with -M in stgit.diff-opts
      Test for specific exit code
      Test for "stg edit"
      Test that we can add a new file to a non-topmost patch with refre=
sh -p
      Merge branch 'stable'
      Test for exit code with command_error()
      stg uncommit should never touch the branch head
      Make sure that stg uncommit doesn't touch the branch head
      Fix uncommit status message
      Discard stderr output from git apply if the caller wants
      Do simple in-index merge with diff+apply instead of read-tree
      Reuse the same temp index in a transaction
      Library functions for tree and blob manipulation
      Teach stgit.lib.transaction about hidden patches
      Test operations on hidden patches
      stg goto: Handle hidden patches more gracefully
      Add utility function for reordering patches
      Add some performance testing scripts
      Log subprocess activity to a file
      Show full command in subprocess profiling
      Log subprocess calls during performance testing
      Global performance logging
      Add some tests of refreshing removed files
      Fix some remaining old-style stg id calls
      Don't use the dashed for of git commands
      Merge branch 'stable'
      Remove unneeded import
      Refactoring: move shared options to their own module
      Auto-generate man pages for all StGit commands
      asciidoc.conf: Steal updates from git
      Generate command lists automatically
      Write to a stack log when stack is modified
      New command: stg reset
      Log conflicts separately
      Log conflicts separately for all commands
      Add a --hard flag to stg reset
      Don't write a log entry if there were no changes
      Move stack reset function to a shared location
      New command: stg undo
      New command: stg redo
      Log and undo external modifications
      Test that stg coalesce handles head !=3D top gracefully
      Check for top =3D=3D head at the start of every transaction
      Make "stg log" show stack log instead of patch log
      Convert "stg refresh" to the new infrastructure
      New refresh tests
      Remove --undo flags from stg commands and docs
      Refactor stgit.commands.edit
      Invoke the correct interactive editor
      Implement "stg refresh --edit" again
      Automatic bash completion
      Untabify
      Add myself to the AUTHORS file
      Remove misleading "stg delete" documentation
      Add a new flag, --spill, to stg delete
      Test the new stg delete --spill flag
      Fix typo
      Merge branch 'stable'
      Remove unused variable
      Remove TODO items that have already been addressed
      We're half-way there with the separate indexes
      Add 1.0 TODO items from recent discussion by private mail
      Refresh the main stg man page
      Refresh and expand the tutorial (not finished)
      Tutorial: Talk about conflicts when introducing StGit
      Tutorial: Explain diffs a little bit better
      Tutorial: Cover "stg mail"
      Tutorial: Write about rebasing
      Tutorial: Importing patches
      stg series: Explain the list format better
      stg files: Don't write just an empty line
      Steal Documentation/SubmittingPatches from Git
      SubmittingPatches: adapt to StGit
      Return None instead of crashing on undefined integer config items
      Merge branch 'stable'
      Rename "stg coalesce" to "stg squash"
      stg squash: Improve documentation
      Documentation: Ignore generated .xml files
      Documentation: Rename link macros
      Newer gits return 128 when git config --{rename,remove}-section f=
ails
      Transaction.push_patch(): Set self.head only when we have a merge=
 conflict
      Pass "git config" flags in the right order

Catalin Marinas (98):
      Re-add the interactive merge
      Don't assume there is always a stage 2 in git.get_conflicts
      Remove multiple stages returned by git.ls_files
      Remove unused git functions like add, rm, copy
      Remove a newline from the e-mail template
      Don't set the default authdate if none specified
      Allow pick to import multiple patches
      Check for unnecessary push/pop in 'float'
      Allow the synchronisation of the unapplied patches
      Modify 'series' to use '#' instead of '|'
      Set umask to 0022 during the setup.py execution
      Refuse to send empty patches
      Add a boundary to parse_patches in pick.py
      Fix sync to push the popped patches back after sync'ing
      Remove the reordering side-effect of the latter sync changes
      Allow picking of one commit id
      Merge branch 'stable'
      Merge branch 'stable'
      Merge branch 'stable'
      Merge branch 'stable'
      Refactor the Commitdata class to CommitData
      Rewrite the "series" command for the new infrastructure
      Allow the Repository.get_stack() to get a default argument
      Fix error in status.py when calling git.resolved
      Convert "top" to the new infrastructure
      Convert "export" to the new infrastructure
      Merge branch 'stable'
      Merge commit 'kha/safe'
      Fix the parse_patches() function to work with tuples
      Allow stack.patchorder.all to return hidden patches
      Rename Repository.head to Repository.head_ref
      Create a git.Branch class as ancestor of stack.Stack
      Add stack creation and initialisation support to lib.Stack
      Convert "init" to the new StGIT infrastructure
      Add test_patches target to Makefile
      Merge branch 'stable'
      Fix export error introduced by recent convertion
      Allow e-mails to be sent with the Unix sendmail tool
      Implement a new patch identification scheme and id command
      Convert git_id() to the new id format
      Remove the applied/unapplied commands
      Remove the duplicate utils.strip_leading function
      Fix the importing of config in series.py
      Fix import to work properly in subdirectories
      Merge branch 'stable'
      Do not crash if a patch log ref is missing
      Autosign newly created patches
      Fix the sink command for various test cases
      Merge branch 'stable'
      Use --diff rather than --patch in log.py
      Fix "show" to allow multiple branch:patch arguments
      Change e-mail user agent header to StGit
      Add parse_patches boundary in the delete.py file
      Remove the --committer options
      Remove e-mail address duplicates
      Refresh of remove-e-mail-address-duplicat
      Allow pick --fold to work without applied patches
      Generate a different patch name if it already exists
      Add 'pick' test script
      Merge branch 'proposed'
      Display (empty) when appropriate for the goto command
      Fix the HEAD updating during a conflicting push (bug #12609)
      s/GIT/Git/ in the README
      Add "tags" target to Makefile
      Do not append a new line to the backwards compat files (bug #1265=
6)
      Print conflict details with the new infrastructure (bug #11181)
      Merge branch 'proposed'
      Fix the patch argument parsing for the "show" command
      Pass the diff flags when statistics are required
      Merge branch 'stable'
      Add --file option to pick
      Check for local changes with "goto"
      Add mergetool support to the classic StGit infrastructure
      Add automatic git-mergetool invocation to the new infrastructure
      Convert "sink" to the new infrastructure
      Convert "float" to the lib infrastructure
      Use a default "hidden" argument in StackTransaction.reorder_patch=
es
      Add the --merged option to goto
      Convert "pop" to the lib infrastructure
      Convert "push" to the lib infrastructure
      Show "Pushing <patch>...done" when pushing a patch
      Show some progress information when checking for upstream merges.
      Do not sleep after the last patch sent by e-mail
      Convert 'clone' to the use stgit.lib
      Convert 'hide' to the lib infrastructure
      Convert 'unhide' to the lib infrastructure
      Reinstate the --annotate option for refresh
      Add the log --clear option
      Add support for merge-friendly branches
      Add "stg id" support for "{public}" ref
      Use the default git colouring scheme rather than specific scripts
      Remove the resolved command
      Improve the "publish" merge message to give slightly more informa=
tion
      Only allow publishing to refs/heads/*
      Rename out.start() to out.inf() in the publish command
      Add --reject option to import
      Add --stat option to show
      Do not replace '-' with '.' in the version string

Gustav H=E5llberg (39):
      stgit.el: Compact code for populating stgit-mode-map
      stgit.el: Add 'q' for stgit-quit
      stgit.el: Add 'm' as alias for stgit-mark
      stgit.el: Add stgit-unmark-down
      stgit.el: Fix some indentation
      stgit.el: Add stgit-git-status
      stgit.el: Fix working directory bug in stgit-new
      stgit.el: Unify help text formatting
      stgit.el: Add flag to signal errors in stgit-patch-at-point
      stgit.el: Automatically update git-status buffer when necessary
      stgit.el: Add support for showing which files are affected by a p=
atch
      stgit.el: Add an stgit customization group
      stgit.el: Use 'git diff-stat' to show files in a patch
      Add '--help' to tab completion for all commands
      stg mail: Improve error message for unknown sender identity
      stgit.el: Also show mode and type changes of files in patches
      man pages: Bugfixed man pages for --sign and --ack flags; e.g.,
for stg-new
      stgit.el: Make prefix argument to stgit-new add a Signed-off-by: =
line
      stgit.el: Bugfix stgit-unmark-down on the last patch
      stgit.el: Fix some too wide lines
      stgit.el: Add some missing help texts
      stgit.el: Canonicalize some error messages
      stgit.el: Consistently use symbols rather than strings for patch =
names
      stgit.el: Make single file diff buffer read-only
      stgit.el: Include stat summary in patch diff
      stgit.el: Add message when there are no patches in the series
      stgit.el: Indicate empty patches
      stgit.el: Minor beautification
      stgit.el: Add optional count argument to stgit-commit
      stgit.el: make stgit-delete with prefix argument spill patch
contents to index
      stgit.el: Add "B" for stgit-branch
      stgit.el: Manually draw/erase the mark in stgit-{add,remove}-mark
      stgit.el: Clarify documentation of stgit-capture-output
      stgit.el: Add "M" for stgit-move-patches
      stgit.el: Run 'git show' with -M to detect renames when showing
entire patch
      stgit.el: Break out stgit-sort-patches to a separate function
for future reuse
      stgit.el: Sort patches correctly before merging them in stgit-squ=
ash
      stgit.el: Handle errors in first phase of stgit squash
      stgit.el: Bind line movement keys in a sane way

David K=E5gedal (33):
      Added --save-template flag to edit command
      Treat filename '-' as stdin/stdout in edit
      Add an StGit mode for emacs
      Emacs mode: Improve the output buffer state
      Emacs mode: Bind n and p
      Emacs mode: add stgit-repair
      Emacs mode: added stgit-commit and stgit-uncommit
      Emacs mode: Add stgit-edit command
      Emacs mode: added fontification
      Emacs mode: Added stgit-new
      Check bottom and invariants
      Remove the 'bottom' field
      Remove the 'top' field
      Split git.merge into two functions
      Leave working dir and index alone after failed (conflicting) push
      Added a test case to check what happens when push finds a conflic=
t
      Simplify merge_recursive
      Use the output from merge-recursive to list conflicts
      Ask git about unmerged files
      Emacs mode: Add mark command
      Emacs mode: coalesce command
      Add support for initializing a branch for stgit from Emacs.
      stgit.el: Add numeric prefix argument to push and pop commands.
      stgit.el: Adapt to new output from stg series.
      stgit.el: Add undo command
      stgit.el: Try to make the point stay on the coalesced patch
      stgit.el: Rename stgit-refresh to stgit-reload
      stgit.el: Move stgit-rename to C-c C-r
      stgit.el: Add the stgit-refresh command
      stgit.el: Show running commands
      Use separate column for zero in output of stg series -e
      stgit.el: Expand or collapse only the patch at point, instead of
rerunning stg-reload.
      Add a --set-tree flag to stg push

Daniel White (11):
      Fixed default install location
      Fix Makefile to correctly pass prefix option
      Remove variables regarding section 7 man pages
      Fix default install location for manpages
      Add install-doc target to makefile
      Add install-html target to makefile
      Remove installation of documentation from setup.py
      Updated INSTALL with documentation of Makefile
      debian/rules: take advantage of new build targets
      Remove dashed form of git command still in comment
      Fixes for auto-generation of man pages

Samuel Tardieu (4):
      Find CmdException in common
      Do not insert an empty line before the diffstat info
      Do not mess-up with commit message formatting when sending email
      Load the whole config at once and cache it for future use

Clark Williams (3):
      Patch to allow import from compressed files (gzip and bzip2)
      Ignore compiled elisp files
      Teach "stg import" to import patch series from tar archives

Peter Oberndorfer (3):
      Don't mention removed "stg refresh" options
      replace "git repo-config" usage by "git config"
      Add an --index option to "stg refresh"

Alex Chiang (2):
      Better "stg rebase" help text
      fix stg mail %(shortlog)s order

Dan Williams (2):
      mail: add some commonly used tags to --auto
      fix export -s

Miklos Vajna (2):
      setup.py: don't try to import stgit.run before the python version=
 check
      setup.py: fix error message when running with python-2.3

Onno Kortmann (2):
      Simple rename of top-most patch
      Test the 'stg rename' command

Pavel Roskin (2):
      Fix "stg edit --sign"
      Add test to ensure that "stg clean" preserves conflicting patches

Shinya Kuribayashi (2):
      diffcol.sh: Use /bin/bash explicitly
      stgit-completion.bash: Remove add/applied/cp/rm/unapplied

Ted Pavlic (2):
      Modify bash completion to support help, version, and copyright.
      Make bash completion fail to bashdefault before default completio=
n.

Angus Salkeld (1):
      stg mail crashes when there is no patch description

Jason Green (1):
      Patch to clarify the "unsolved conflicts" message in Stacked Git

Pete Wyckoff (1):
      stgit.namelength is an integer

Toby Allsopp (1):
      Fix "stg branch --delete" on a nonexistent branch

--=20
Catalin
