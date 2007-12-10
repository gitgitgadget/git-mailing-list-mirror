From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: [ANNOUNCE] Stacked GIT 0.14
Date: Mon, 10 Dec 2007 11:40:41 +0000
Message-ID: <b0943d9e0712100340p78326b4avf2b7e64008bba6d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "Git Mailing List" <git@vger.kernel.org>,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 10 12:42:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1h1M-0005Eg-GP
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 12:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756532AbXLJLkr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Dec 2007 06:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756473AbXLJLkq
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 06:40:46 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:54743 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756408AbXLJLkn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Dec 2007 06:40:43 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1598335rvb
        for <git@vger.kernel.org>; Mon, 10 Dec 2007 03:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=c4mbs5JZ89t9kHcdpe7yYQSRpPhTOuVuQxNtZqOTZ0I=;
        b=uBLJ/ydeL79sAf2xxjbhOD/Rr+CxT9YDemO8MOB4Z6pm0Xzl+5WMigRYOeeyt8OC2XOpygy9uqKr3pXDUqP9UPVQWDduZhRCTXS4WQ34XfF3iTZNV7hCRTgjXcTiypqyM6zVdF0cW6N+r69aEyhDT/IwyosUjMgD8C9l7N8zI7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Zg++Q/tpYZpR/rMOXJiscorz/yFC4YzJGG2gOEYJgWcvTIo6ksFHf9KKUj1PWs8akkwpC6bt/tc7x7uw3/aGWeXMnQ/mU7DQmZj19sLwRr2NEQBD6Fj7vmbfP9yIMBOqbH0NSXYtV25+NF0Yw/x3urzEL09yGitywkj0P7j0h/4=
Received: by 10.141.20.7 with SMTP id x7mr4166171rvi.1197286841071;
        Mon, 10 Dec 2007 03:40:41 -0800 (PST)
Received: by 10.141.186.5 with HTTP; Mon, 10 Dec 2007 03:40:41 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67703>

Stacked GIT 0.14 release is available from http://www.procode.org/stgit=
/.

StGIT is a Python application providing similar functionality to Quilt
(i.e. pushing/popping patches to/from a stack) on top of GIT. These
operations are performed using GIT commands and the patches are stored
as GIT commit objects, allowing easy merging of the StGIT patches into
other repositories using standard GIT functionality.

This release requires at least Python 2.4 and GIT 1.5.2.

The main features in this release:

    * Support for correctly running StGIT in subdirectories
    * 'repair' command for fixing an StGIT repository modified by GIT
commands such as 'commit', 'pull', 'merge' or 'rebase'
    * 'edit' command for editing both the patch description and diff
    * Support for SMTP over TLS
    * Support for MIME multipart e-mail templates
    * '--attach' option to the 'mail' command to send a patch attached
rather than inline
    * Diff statistics and shortlog added to the cover e-mail template
    * '--sign/ack' options to the 'import' and 'new' commands
    * '--number' to the 'log' command for limiting the output
    * Support for binary files in patches
    * Support for detached HEAD
    * Refactoring of some modules with better support for debugging
    * Many bug-fixes

Acknowledgements (many thanks to all the people who contributed code,
reported bugs or made suggestions):

Karl Hasselstr=F6m (73):
      Teach StGIT about core.excludesfile
      New test: make sure that popping doesn't change patch order
      Verify patch status during the test
      Add an --smtp-server commandline option to "stg mail"
      Test that all branch config information is renamed
      Rename all config sections of a branch
      New test: make sure that StGIT can 	handle packed refs
      Make use of the get_patch() utility function
      Don't touch ref files manually
      Don't use test_expect_failure when more than one thing could fail
      Don't write None to the conf file
      Replace "git repo-config" with "git config" in help texts
      Compile regexp just once
      Refactor output handling to break circular dependency
      Refactor subprocess creation
      Assert that the argument to Run is a sequence of strings
      Add optional logging of subprocess execution
      Write warnings and errors to stderr if not on a terminal
      Don't fail just because a subprocess wrote stuff to stderr
      Let "stg status" ignore empty directories
      Allow "stg add" when we have no stack
      Test "stg status" more thoroughly
      Use subprocess.Popen to call git executables
      Use the builtin set() instead of sets.Set()
      Discard stderr when determining if a patch is already applied
      Add the any() and all() utility functions from Python 2.5
      Add --sign and --ack options to "stg import"
      Add diffstat of whole patch series to cover mail
      Add shortlog of patch series to cover mail
      Include summary of added/deleted files in diffstat
      It doesn't make sense to sink below an unapplied patch
      Don't special-case the "master" branch during branch delete
      Don't try to delete the branch twice
      Properly remove all config for a deleted branch
      Add simple test for "stg branch --delete"
      New test: make sure tha we can run "stg help"
      Make sure that the output of "stg status" is sorted
      New policy: Only use test_expect_failure for broken tests
      Make Run available in stack.py
      Teach "stg assimilate" to repair patch reachability
      Test the new powers of "stg assimilate"
      Let "stg assimilate" handle missing patches
      Add --ack/--sign options to "stg new"
      New test: "stg pop --keep"
      Fix up the help text for "stg edit"
      Don't split long and short description in "stg edit"
      Make a common superclass for all StGit exceptions
      Simplify debug level error checking
      Discard stderr output from git-rev-parse
      Remove the --force flag to "stg rebase" and "stg pull"
      Infrastructure for current directory handling
      New test: Try "stg push" in a subdirectory
      Make "stg push" subdirectory safe
      New test: try "stg refresh" in a subdirectory
      Make "stg refresh" subdirectory safe
      Allow caller to customize title of error/warning message
      Use our nice message printout wrapping system
      Properly detect that HEAD is detached
      Refactor crt_series creation
      Don't have a global crt_series in stgit.commans.common
      Fix error message generation
      New test: "stg diff"
      Simple test for "stg clean"
      Cogito is deprecated, so don't point to it
      Let some commands work with detached HEAD
      Rename "stg assimilate" to "stg repair"
      stg repair: Patchify non-patch commits between patches
      Push and pop don't have --to flags anymore
      Add missing switch to "stg uncommit" usage line
      Make "stg repair" help text more helpful
      Fix bashism
      Discard exitcode of subprocess in a better way
      Don't use test_expect_failure for tests that are supposed to work

Catalin Marinas (36):
      Allow 'import' to apply empty patches
      Make the maximum patch name length configurable
      Add the '--exclusive' option to 'uncommit'
      Add patch editing command
      Add 'edit' to the patchcommands list
      Print 'updating patch' earlier in 'edit'
      Allow the rebase command to be defined
      Fix the rebasing with an external command
      Fix assertion in patch creation
      "stg pop --keep" fails because of git-apply --index (bug #8972)
      Do not raise an exception if no FETCH_HEAD
      Allow StGIT commands to run correctly in subdirectories
      Allow "branch --create" to be given a tag id
      Fix more commands to run correctly in subdirectories
      Allow the diff showing in the log command if patch modified by ed=
it
      'stg pop --keep' doesn't update the index
      Execute the 'git ...' rather than 'git-...'
      Keep the patch log when import --replace deletes patches
      Improve the t1205 test for push
      Make Series.refresh_patch automatically save the undo information
      Check for disappeared newborn files in git.tree_status (bug #8516=
)
      Correctly identify the parent branch (bug #10014)
      Clean-up if the branch creation fails (bug #10015)
      Allow multipart templates for patch e-mails (bug #10237)
      Add a test for the 'mail --attach' command
      Check the minimum required versions of GIT and Python (bug #10218=
)
      git.pretty_commit() re-implemented with "git show" (bug #10018)
      Allow 'show' and 'id' to work on non-StGIT branches (bug #10011)
      Change the file timestamp in 'resolved --reset' (bug #10017)
      Add the 'log --number' option to limit the output
      Ignore the gitk exit code in 'stg log -g' (bug #10010)
      Some clean-up of the branch manipulation commands
      Make sure the refid given to 'mail' has the angle brackets
      Allow only certain gitk exit codes as valid
      Better handling of binary files (bug #8495)
      Release 0.14

David K=E5gedal (15):
      Don't print unnecessary backtraces when testing
      Fixed indeterminism in t2102-pull-policy-rebase
      Add basic test for stg status
      Cleanup tree_status and use -z
      Add some more tests of "stg status" output
      Clear up semantics of tree_status
      Moved that status function to the status command file
      Split Series.push_patch in two
      Remove dead code from push_empty_patch
      Refactor Series.push_patch
      Clean up Series.refresh_patch
      Add a 'bottom' parameter to Series.refresh_patch and use it
      Clear up the semantics of Series.new_patch
      Refactor Series.new_patch
      Added test case for stg refresh

Yann Dirson (9):
      Improve stg-fold-files-from doc.
      New contrib scripts: stg-dispatch and stg-show.
      Add -O flag to stg-fold-files-from.
      Add a no-act flag to stg-dispatch and stg-fold-file-from.
      Provide file completion for add/resolved/refresh based on status.
      Fixed completion function hardcoding .git/.
      Include contrib scripts in the release tarball.
      Better diagnostic for wrong branch configuration.
      stg-gitk: allow passing args to gitk; add --help.

Pavel Roskin (7):
      Add support for SMTP over Transport Layer Security (TLS)
      Ask for SMTP password if it's not provided
      Use --force to overwrite python files
      Fix refresh -es
      git.__remotes_from_dir() should only return lists
      Set GIT_TEMPLATE_DIR in the testsuite, like it's done in git
      Support tags in uncommit - use git_id instead of rev_parse

--=20
Catalin
