From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: [ANNOUNCE] Stacked GIT 0.12
Date: Tue, 6 Feb 2007 23:51:12 +0000
Message-ID: <b0943d9e0702061551n1da2c665na6184b09b64f92e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "GIT list" <git@vger.kernel.org>,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965038AbXBFXvS@vger.kernel.org Wed Feb 07 00:52:23 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965038AbXBFXvS@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEa6n-0001UV-3i
	for glk-linux-kernel-3@gmane.org; Wed, 07 Feb 2007 00:52:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbXBFXvS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 6 Feb 2007 18:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030612AbXBFXvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Feb 2007 18:51:17 -0500
Received: from an-out-0708.google.com ([209.85.132.247]:13730 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030608AbXBFXvN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Feb 2007 18:51:13 -0500
Received: by an-out-0708.google.com with SMTP id b33so33364ana
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2007 15:51:13 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hrOtTGnC92ytDuzQ87RyHOOeWX5TI1BTRrciD4NIzmE2tMbWOPfl3iP6pmsUb3gqJcO8Azxv655Fd/Lt+ppTDOYiyNHIBrGBc2ap23p59RqJq+2K48uA7RZcIBHYe6/Hh1W2zTvvdlQzrMEuXgwtVtpbeh4RceF5IKk1eTSMI+k=
Received: by 10.114.137.2 with SMTP id k2mr915023wad.1170805872611;
        Tue, 06 Feb 2007 15:51:12 -0800 (PST)
Received: by 10.115.110.12 with HTTP; Tue, 6 Feb 2007 15:51:12 -0800 (PST)
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38879>

Stacked GIT 0.12 release is available from http://www.procode.org/stgit=
/.

StGIT is a Python application providing similar functionality to Quilt
(i.e. pushing/popping patches to/from a stack) on top of GIT. These
operations are performed using GIT commands and the patches are stored
as GIT commit objects, allowing easy merging of the StGIT patches into
other repositories using standard GIT functionality.

The main features in this release:

    * New 'rebase' command to change the base of an StGIT stack
    * New 'hide' and 'unhide' commands to act on the patches in a
series. Additional options were added to 'series' for displaying the
hidden patches
    * New 'sync' command to synchronise same patches in different branc=
hes
    * New 'assimilate' command to transform GIT (accidental) commits
at the top of the stack in StGIT patches
    * Re-worked pulling logic to use the branch information stored in
the .git/config file
    * Abbreviation for StGIT commands
    * Correct encoding of the e-mail headers and body
    * Support for importing multipart e-mails and mbox files
    * Configuration read from the GIT config files rather than stgitrc
    * Patch ranges can be specified for 'export'
    * '--missing' option for 'series' to list the patches on a branch
which are missing in current
    * StGIT bash completion script
    * Bug fixes

Acknowledgements (generated with 'git shortlog'):

Catalin Marinas (58):
      Add the 'autobcc' config option
      Clean-up the number of imports in main.py
      Slightly change the multiple patches delete function
      Properly encode the e-mail headers and body
      Properly import qp-encoded e-mail headers
      Add support for multipart messages to import
      Add a trash directory with deleted patches
      Add mbox support to "import"
      Add file renaming support
      Fix the mail import regex to remove the [...PATCH...] text
      Reduce the imports in stgit/main.py
      Update the bash-completion script
      Edit the cover or patch message before e-mail encoding
      Only create a 'From: author' line if needed
      Add a 'sender' configuration option
      Only read the config files when running a command
      Fix a bug in gitmergeonefile.py introduced recently
      Allow 'show' to display many patches
      Add a boundary to parse_patches()
      Complete patch names after a patch (range) option
      Use gitconfig rather than stgirc
      Only print the progress message if on a TTY
      Allow the cloning of branches not under StGIT control
      Fix "series -d" when the patch description is empty
      Flush the stdout in the commit command
      Fix the 'clean' command not to pop all the patches
      Allow ranges for the 'export' command
      Allow patch ranges for the 'pop' command
      Pipe the 'stg help <command>' output through the pager
      Print 'refresh done' before pushing other patches
      Fix a merge case with files added in both heads but different
      Make 'push --undo' safer
      Add the 'sync' command
      Don't always use git-merge-recursive because of speed
      Allow the abbreviation of StGIT commands
      Add the --unapplied option to pick
      Allow the mail command to send unapplied patches as well
      Fix the bash completion when there is no patch applied
      Add '--missing' option to 'series'
      Fix the branch renaming to also rename the reflogs
      Pipe the 'patches --diff' output through the pager
      Indent the example gitconfig file
      Allow e-mail aliases for the "mail" command
      Add option to automatically invoke the interactive merger
      Track the files conflict history
      Fix the displaying of unknown files for 'stg status'
      Synchronise the current patch if none specified for 'sync'
      Hide the test_create_repo output
      Allow a patch range to be specified for 'series'
      '--showbranch' and '--noprefix' options for 'series'
      Add support to hide and unhide patches
      Make the 'series --short' length configurable
      set() is not a builtin function in Python 2.3
      Check for invalid patch names before acting
      Stop the e-mail sending if editor fails
      Escape the quotes in example/gitconfig
      Add extra files to MANIFEST.in
      Release 0.12

Yann Dirson (23):
      Make Series::patch_applied public.
      Optimize stg goto in the pop case.
      Bomb out when --ack and --sign are both passed to "refresh".
      Allows to refresh a non-top applied patch.
      More config examples.
      Create a StgitObject class to factorise code for property handlin=
g.
      Document some current bugs and add to the TODO list.
      Add new 'rebase' command.
      Make stgit.config use git-repo-config.
      Add caching to the new config class.
      Move identification of parent branch's remote def up into stack c=
lass.
      Allows extraction of information about remotes.
      Basic support for keeping a ref to the parent branch.
      Have 'stg branch --create' record parent information.
      Make 'stg pull' use git-fetch and not git-pull.
      Fixes to doc strings.
      The user does not want to mess with the refspecs.
      Rebase to parent branch after git-fetch in "stg pull".
      Do not return 'origin' as parent remote when there is no such rem=
ote.
      Correctly check the pull-does-rebase parameter in 'stg pull'.
      Warn the user when there is no parent information in the config.
      Use FETCH_HEAD to know where to rebase to after pull.
      Use branch.*.stgit.parentbranch for authoritative parent informat=
ion.

Karl Hasselstr=F6m (15):
      Let "stg help" be like "stg --help"
      When no command was given, print usage message
      Disregard extraneous arguments when providing help
      New stg command: assimilate
      Regression test for "stg assimilate"
      Allow hand-editing of patches before sending
      Allow deletion of several patches at once
      Generate shorter patch names
      Generate unique patch names
      Print progress message to stderr, not stdout
      Don't mention deprecated template variables
      Regression test for "stg import"
      Regression test for "stg mail"
      StGIT bash completion
      Ask git for author and committer name

Pavel Roskin (9):
      Set HOME to the test directory to avoid reading ~/.stgitrc
      The author's address is incorrect in setyp.py
      Check git pull remote before defaulting to 'origin'
      Allow .git/branches and .git/remotes to be missing
      Rename branch section in config when the branch is renamed
      Copy remote and merge settings when cloning a branch
      Don't print "rebasing" if the head doesn't change
      Assorted typos
      Add missing spaces in warnings about default remote

Chuck Lever (3):
      Print a message while checking for changes in the working directo=
ry.
      Add a new option to "stg applied" and "stg unapplied" that
provides a count
      Optionally repack the object repository after every pull

Robin Rosenberg (2):
      Add an optional prefix to the PATCH subject when mailing.
      Bash snippet to show branch and patch in bash prompt

Ilpo J=E4rvinen (1):
      Fixes "stg goto `stg top`" to no-op & adds test

Paolo 'Blaisorblade' Giarrusso (1):
      Stgit: allow importing series files where patch names include sla=
shes

--=20
Catalin
