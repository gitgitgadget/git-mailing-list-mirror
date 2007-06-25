From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Mon, 25 Jun 2007 02:43:52 -0700
Message-ID: <7v7ipsz7vr.fsf@assigned-by-dhcp.pobox.com>
References: <7v4pmgqrut.fsf@assigned-by-dhcp.cox.net>
	<7vhcqccnbm.fsf@assigned-by-dhcp.cox.net>
	<7vveepz8pr.fsf@assigned-by-dhcp.cox.net>
	<7vmyzv1acz.fsf@assigned-by-dhcp.cox.net>
	<7vejl0546b.fsf@assigned-by-dhcp.cox.net>
	<7v4plqoyg5.fsf@assigned-by-dhcp.cox.net>
	<7v7iqgtt1j.fsf@assigned-by-dhcp.cox.net>
	<7vk5u7d38h.fsf@assigned-by-dhcp.pobox.com>
	<7vy7idydqa.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 11:43:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2l6y-0008Ja-To
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 11:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbXFYJnz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 05:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbXFYJnz
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 05:43:55 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:44831 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbXFYJny (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 05:43:54 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070625094352.XESA17635.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 25 Jun 2007 05:43:52 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Fljt1X0011kojtg0000000; Mon, 25 Jun 2007 05:43:53 -0400
X-maint-at: c7c84859ad586ae5670224e1abc4f846f7c3a9ae
X-master-at: aeb59328453cd4f438345ea79ff04c96bccbbbb8
In-Reply-To: <7vy7idydqa.fsf@assigned-by-dhcp.pobox.com> (Junio C. Hamano's
	message of "Thu, 21 Jun 2007 00:21:33 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50884>

Among many small fixes and some code churns, there are a few
notable topics from 'next'.

 - git-filter-branch to rewrite history;

 - git-add "Huh?" factor fix when attempting to add an empty directory;

 - git-log and friends do not have the 16kB size limit for
   commit log messages anymore;

 - git-log and friends' --pretty=oneline treats the first
   paragraph of a commit log message as the title line;

 - "git-log --follow -- single-file";

Simon Hausmann and Shawn Pearce have shepherded a fast-import
based Perforce importer into contrib/fast-import area.

* The 'master' branch has these since the last announcement

Dave O'Neill (1):
  Generate tags with correct timestamp (git-svnimport)

Gerrit Pape (1):
  git-svn: trailing slash in prefix is mandatory with --branches/-b

Jeff King (4):
  dir_struct: add collect_ignored option
  builtin-add: simplify (and increase accuracy of) exclude handling
  Fix ALLOC_GROW off-by-one
  Fix ALLOC_GROW calls with obsolete semantics

Johannes Schindelin (7):
  Add git-filter-branch
  filter-branch: use $(($i+1)) instead of $((i+1))
  filter-branch: fix behaviour of '-k'
  Teach filter-branch about subdirectory filtering
  pp_header(): work around possible memory corruption
  diffcore-rename: favour identical basenames
  filter-branch: add example to move everything into a subdirectory

Johannes Sixt (4):
  filter-branch: Use rev-list arguments to specify revision ranges.
  filter-branch: also don't fail in map() if a commit cannot be
      mapped
  filter-branch: Simplify parent computation.
  filter-branch: subdirectory filter needs --full-history

Julian Phillips (1):
  new-workdir: handle rev-parse --git-dir not always giving full path

Junio C Hamano (5):
  t7003: make test repeatable
  Lift 16kB limit of log message output
  Extend --pretty=oneline to cover the first paragraph,
  Two trivial -Wcast-qual fixes
  git-send-email: Do not make @-less message ID

Linus Torvalds (2):
  Finally implement "git log --follow"
  Fix up "git log --follow" a bit..

Matthias Lederhofer (3):
  filter-branch: prevent filters from reading from stdin
  chmod +x git-filter-branch.sh
  make dist: include configure script in tarball

Nanako Shiraishi (1):
  Cloning from a repo without "current branch"

Shawn O. Pearce (2):
  Avoid src:dst syntax as default bash completion for git push
  Document git-gui, git-citool as mainporcelain manual pages

Sven Verdoolaege (1):
  t9500: skip gitweb tests if perl version is too old

-- p4 --

Benjamin Sergeant (1):
  git-p4 fails when cloning a p4 depo.

Han-Wen Nienhuys (28):
  Cleanups
  reformatting: break long lines.
  rename apply() to applyCommit(); apply is a python builtin
  add .dotest to .gitignore
  Robustness fixes for pipes
  cleanup
  minor cleanups
  clone and sync --keep-path to keep perforce path to module.
  use string.strip() iso. slicing.
  use strip() iso. slicing for removing \n
  add --verbose to all commands.
  Extract multiple paths concurrently.
  Diverse cleanups
  remove global .gitdir
  Read p4 files in one batch.
  Thinko, fix buglet.
  store p4 user cache in home directory.
  thinko.
  read files before creating the commit.
  don't p4 print deleted files.
  only run p4 print if necessary
  use p4CmdList() to get file contents in Python dicts. This is more
      robust.
  Cleanups & import into p4/master for local import
  remove debug print
  thinko: really ignore deleted files.
  look for 'text' and 'binary' files.
  print error message when p4 print fails (eg. due to permission
      problems)
  also strip p4/ from local imports.

Kevin Green (1):
  git-p4: check for existence of repo dir before trying to create

Marius Storm-Olsen (7):
  Make the command call silent
  Replace \r\n with \n when importing from p4 on Windows
  Ensure that the commit message is Windows formated (CRLF) before
      invoking the editor.
  Fix git-p4 clone (defaultDestination)
  Fix single branch import into remotes
  Exclude the HEAD symbolic ref from the list of known branches
  Only use double quotes on Windows

Simon Hausmann (222):
  Initial import of a python script to import changesets from
      Perforce into git.
  Added basic support for specifying the depot path to import from as
      well as the range of perforce changes.
  Slightly improved help usage output and made specifying the
      trailing slash for the depot path optional.
  Implemented basic support for converting the date of the perforce
      change to the git format. The timezone isn't correctly set up
      yet though.
  Some fixes to the timezone conversion between the date of a
      perforce change and the git commit.
  Speed up the import of individual files from Perforce into git by
      passing the output of "p4 print" directly to git fast-import.
      Also try to set the mode of the file in git correctly based on
      file type heuristics.
  Removed unused p4cat function and added helper function for the
      perforce python interface (p4Cmd).
  Changed the import mechanism to write to git fast-import through a
      pipe instead of having p4-fast-export write to stdout and let
      the caller connect it to git fast-import.
  Minor code cleanups and ported some p4 interfacing code over to the
      p4 python mode.
  Instead of parsing the output of "p4 users" use the python objects
      of "p4 -G users".
  Ported the remaining functions that parsed p4 shell output over to
      the p4 python interface.
  Avoid calling fstat for every imported file (slow!) and instead
      read the file data first into the python process and use the
      length of the bytes read for the size field of git fast-import.
  Permit calling p4-fast-export with a depot path that has the
      typical ... wildcard at the end.
  Fixed displaying import progress by calling flush on stdout.
  Create a git tag for every changeset imported from perforce.
  Fix file permissions of p4-fast-export.py to be executable.
  Started working on incremental imports from Perforce.
  Simplify the incremental import by elimination the need for a
      temporary import branch.
  Code cleanups, move the code to create a commit with fast-import
      into a separate function out of the main loop.
  Initial support for importing a directory from Perforce at a
      specified revision.
  Minor cleanups and print an error message of git fast-import if it
      fails.
  Fixed incremental imports by using the correct "from" command
      instead of "merge" with git fast-import.
  Make incremental imports easier to use by storing the p4 depot path
      after an import in .git/config and re-using it when we're
      invoked again later.
  Make specifying the revision ranges more convenient.
  Fix calculation of the newest imported revision for #head imports.
  Catch io exceptions from git fast-import again and print the error
      message.
  Made the name of the git branch used for the perforce import
      configurable through a new --branch=<name> commandline option.
  Added a little helper script to debug the output of the p4 python
      interface.
  Minor code cleanups.
  Avoid the excessive use of git tags for every perforce change and
      instead just create one git tag for the last imported change.
  Changed the default git import branch from "p4" to "master".
  Added a little helper script to remove unused tags from the
      perforce import.
  Create lightweight git tags (using the "reset" trick) for the
      incremental import instead of full-blown ones. Also fix parsing
      the output of git name-rev for figuring out the last imported
      p4 change number.
  Cleanups, remove unused variable.
  Code cleanups.
  Started work on p4 branch detection (experimental!).
  More fixes in heuristic p4 branch detection based on common path
      components.
  After marking a p4 branch as merged don't ever merge it in git
      again.
  Set git fast-import marks for every imported change for future use.
  When trying to map p4 integrations to git merges just record it as
      a single merge with the newest p4 change as secondary parent.
  Make it possible to specify the p4 changes to import through a text
      file (for debugging) and made various improvements to the
      branch/merge heuristic detection.
  Use sets.Set() instead of set() to run also with older versions of
      Python.
  Fix single-branch imports by skipping the branch/merge detection
      correctly.
  Added p4 delete behavioural emulation as todo item.
  Added support for --silent so that p4-fast-export can be called
      from cronjobs.
  More work in --silent support.
  Don't print a plain newline at the end of the execution (avoids
      bogus cron error mails).
  Adjust the output parsing of git name-rev to handle the output of
      the latest git version.
  Work in progress on detecting branches.
  Changed --known-branches to take a file as argument instead of a
      comma separated list.
  Fixed p4-debug file extension.
  Make the p4 data/command cache configurable through the
      --cache-debug commandline option.
  Minor code cleanups.
  More code cleanups and preparations for more branch detection
      heuristics.
  More work on branch detection by implementing
      changeIsBranchMerge().
  Reduce the number of false "merges" by skipping "branch from"
      entries in the integrated output as well as by ignoring
      integrations of future (newer) changes.
  Split up the cache commandline options into (command) cache and
      data cache.
  First version of a new script to submit changes back to perforce
      from git repositories.
  Fix git-dir option and allow reading log substitutions from a file
  Lots of bugfixes to p4-git-sync.
  Automatically operate on a temporary branch, needed for cherry-pick
      to work when applying changes to
  Be nice and use /usr/bin/env python for the git-p4 scripts
  Ignore Apple resource files when importing from perforce to git.
  Auto-detect the current git branch before submitting back to
      perforce.
  Use p4 revert ... instead of revert -a ... after submitting, to
      make sure the p4 checkout is clean.
  Default to interactive syncing
  Improved the git dir detection.
  Pass the right number of arguments to commit, fixes single-branch
      imports.
  Start moving the git-p4 tools into one single script.
  Provide a little bit of help description for the git-p4 "tools".
  First (untested) attempt at migrating p4-git-sync into the final
      git-p4 script
  Part of the code is copyright by Trolltech ASA.
  sync-to-perforce is now called submit and fixed the gitdir check a
      little bit
  Completely untested "merge" of p4-fast-export.py into git-p4.py
  Added missing "self"s to make the script evaluate correctly.
  Fixed the initial version import by getting the file index correct
      by correctly skipping deleted files.
  Removed p4-fast-export and p4-git-sync as they've been integrated
      into git-p4 now.
  Start of the git-p4 documentation.
  Documentation enhancements.
  Added experimental but super-fast --apply-as-patch option to git-p4
      submit
  Fix support for deletions in git-p4 submit when using
      --apply-as-patch by filtering out deletions in the diff-tree
      output.
  Made --apply-as-patch the default for git-p4 submit as it's
      significantly faster.
  Make it possible to invoke git-p4 from within subdirectories of a
      git working tree.
  Don't show the submit template and the diff first in less but show
      it in $editor right away
  Removed the .py extension from git-p4 as it's annoying to type
      every time.
  Changed the format of the imported log message slightly, so that
      it's easier to parse again.
  Changed the default branch for imports from "master" to "p4"
  Added some helper function(s) to parse the depot path and change
      number from the log message
  Helper function to check the existance of a revision
  Set the default branch in run, not in the constructor
  Brand new smart incremental import that doesn't need tags or git
      repo-config :)
  Make it possible to run git-p4 submit from within the git
      repository
  Use the new incremental import style by default
  Different versions of p4 have different output for the where
      command ;(
  Minor cosmetic fixlet for the git-p4 submit sync question.
  Prefer git command over git-command.
  Don't try to parse any options with git-p4 debug but pass it
      straight on to p4
  git-p4 debug doesn't need a git repository
  Added support for mapping p4 labels to git tags
  Fix variable usage in tag import
  Fix the docs for git-p4 submit and turn git-p4 submit --master=foo
      into
  Fix "compilation" :)
  Clean up python class names.
  Added git-p4 rebase convenience
  Provide a tree summary after git-p4 rebase
  Turn off potentially slow label detection by default
  Honor --silent for labels
  Added git-p4 clone convenience command
  Fix file determination for #head imports
  fix variable usage (oops)
  Added a simple example of usage to the "documentation" :)
  Allow for convenient rebasing after git-p4 submit
  Print an error message of some sort if git fast-import fails.
  Fix the timezone formatting. Now qgit also displays (parses) it
      correctly.
  Removed the old patch apply code from git-p4 submit.
  Slightly improved formatting of the raw_input questions.
  A new attempt at fixing the child-fast-import-process-not-finished
      race condition
  Handle patch errors in git-p4 submit better.
  Doc cleanups.
  Micro cleanup
  cleanup, renamed self.globalPrefix to self.depotPath
  Cleanup, removed the old tagging code
  Document some implementation details, for the curious... :)
  Use the subprocess module instead of popen2 to make it work on
      Windows.
  Added a little .bat wrapper from Marius
  Make sure all popen calls use binary mode (for Windows) and
  Make submitting work on Windows.
  Converted to unix newlines
  Fix git-p4 clone //depot/project (head import)
  Make git-p4 work with bare repositories.
  Added the possibility of skipping patches during git-p4 submit
  Give a better hint if git-p4 submit fails
  Fix calling git-p4 rebase from within a subdirectory (git rebase
      wants to be in toplevel)
  A little todo note before I forget it :), based on a suggestion
      from Lars.
  Fixing syncing (gitdir discovery / cd) for bare repositories
  Always pass a sha1 for the initial parent so that git-fast-import
      doesn't think
  Clean up code duplication for revision parsing and fix previous
      commit to not
  Removed cleantags command. It doesn't have any meaning anymore.
  Removed ancient and unused code to find the last imported revision
      from previous imports
  Create the origin based import branch using git update-ref instead
      of git branch
  Changed the default p4 import branch to be
      refs/remotes/p4/{HEAD,master}
  Bite the bullet and automatically convert old style refs/heads/p4
      repositories
  Added support for git-p4 sync/rebase --with-origin. See git-p4.txt
      for details :)
  Removed todo item that is implemented :)
  Fix branch setup after initial clone.
  Removed unused cache variables.
  Started rewriting the branch detection, based on "p4 branches" and
      "p4 branch -o foo".
  Give branches a nice project prefix and don't bail out on clone if
      we failed
  More work on the incremental importing of multiple branches.
  Cleanup/speed up the branch<> file split and removed change range
      limitation that I added
  More cleanups and speedups for labels and branches
  Removed unused variable, more cleanups
  Cache the output of "p4 users" for faster syncs on high latency
      links.
  Fix gitdir not being set when cloning. Needed for writing the p4
      users cache.
  Oops, not only /set/ gitdir on clone, also set it /correctly/ :)
  Use git format-patch and git apply --apply when extracting patches
      from git and
  Added support for git-p4 submit --direct (experimental)
  Specifying --detect-branches is now only needed for the initial
      clone/sync.
  Had an idea for debugging, record it :)
  Another (potentially life-saving) idea for submit --direct
  Improved output for multi branch imports and noted another little
      todo item
  Fix conversion from old style heads/p4 to remotes/p4/master
  Fix error detection with git-p4 submit when the requested depot
      path is not in the client view.
  Fix git symbolic-ref warning on initial clone
  Detect with git-p4 submit --direct when there are no changes in the
      working directory
  Make git-p4 submit --direct safer by also creating a git commit
  Added a rollback command for debugging. It sets back the heads of
      the p4 branches to the specified p4 change number or earlier.
  Fix branch detection in multi-branch imports
  Fixes for rollback, delete branches that did not exist at the
      specified p4 change
  Added support for importing multiple branches into refs/heads
      instead of just refs/remotes
  Added support for --max-changes=<count> to ease import debugging
  Use refs/heads/* instead of refs/heads/p4/* for local imports
  Doc updates
  Avoid calling git symbolic-ref refs/heads/p4//HEAD (double slash)
  Make rollback work with locally imported branches
  Don't make len(p4Cmd("p4 changes -m 1 //foo/...")) == 0 succeed
      when the p4 command itself failed.
  Oops, fill the /list/ correct with the p4 exit code.
  Catch p4 errors in rollback early enough (before deleting refs!)
  Fix p4 execution in git-p4 rollback.
  Fix multi-branch import with --silent.
  Load the user map from p4 only once at run-time.
  Fix creating the remotes/p4 branches based on origin/* for the
      multi-branch import
  Forgot to remove this return statement from debugging
  Added support for --with-origin with multi-branch imports
  Oops, fix --with-origin to /really/ also call git fetch :)
  Avoid creating non-p4 branches in remotes/p4 off of remotes/origin
  Make git-p4 work with packed refs (don't use os.path.exists to
      check for the
  Make --with-origin also work without origin :)
  Make --with-origin the default for syncing.
  Shortcut the case where we have no origin branch
  Forgot to remove this TODO item when I made --with-origin the
      default :)
  Added git-p4 submit --trust-me-like-a-fool for the adventurous
      users :)
  Fix creation of refs/remotes/p4/HEAD symbolic ref
  Fix my email address, this isn't really KDE related :)
  In *_pipe print the command that failed if it fails.
  Fix typo in listExistingP4Branches that broke sync.
  Fix support for "depot-path" in older git-p4 imports
  Fix common path "calculation" from logs of multiple branches.
  Don't attempt to set the initialParent on multi-branch imports
      (useless).
  Hack to make the multi-branch import work again with
      self.depotPaths now that
  Fix git-p4 rebase
  Fix git-p4 submit
  Fix depot-path determination for git-p4 submit
  Make clone behave like git clone by default again.
  Make git-p4 submit detect the correct reference (origin) branch
      when
  Only get the expensive branch mapping from the p4 server when not
  Fixed the check to make sure to exclude the HEAD symbolic refs when
      updating
  Fix updating/creating remotes/p4/* heads from origin/p4/*
  Fix project name guessing
  Fix depot-paths encoding for multi-path imports (don't split up
      //depot/path/foo)
  Fix support for explicit disabling of syncing with the origin
  Write out the options tag in the log message of imports only if we
      actually have
  Provide some information for single branch imports where the
      commits go
  Mention remotes/p4/master also in the documentation.
  git-p4 submit: Fix missing quotes around p4 commands to make them
      work with spaces in filenames
  Moved the code from git-p4 submit to figure out the upstream branch
      point
  Fix git-p4 rebase to detect the correct upstream branch instead of
      unconditionally
  Fix initial multi-branch import.
  Fix the branch mapping detection to be independent from the order
      of the "p4 branches" output.
  Warn about conflicting p4 branch mappings and use the first one
      found.
  Added git-p4 branches command that shows the mapping of perforce
      depot paths to imported git branches.
  Make it possible to specify the HEAD for the internal
      findUpstreamBranchPoint function.
