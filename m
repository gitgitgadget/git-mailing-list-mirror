From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: [ANNOUNCE] Stacked GIT 0.13
Date: Thu, 26 Jul 2007 00:46:02 +0100
Message-ID: <b0943d9e0707251646m2d7050e9rb698679dfe300038@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "GIT list" <git@vger.kernel.org>,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 26 01:46:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDqYc-0006ZI-B3
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 01:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388AbXGYXqM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 25 Jul 2007 19:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752088AbXGYXqK
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 19:46:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:38385 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038AbXGYXqE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jul 2007 19:46:04 -0400
Received: by ug-out-1314.google.com with SMTP id j3so442305ugf
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 16:46:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KKkqkSe5SyqlzZMVhiq1vN7tf2IL2LIGXXl1hOCoKWJ9OTGIOx5luOmUpwe7rljUgG5U4J7VY1DHZux1na0sa3mb8hPCKqStila4pG84c+y1Of+S5CkMgx+44cvSiRinQNWiog964SV4JSCtVcX+bYC3fjfwzAr6LuQ7+OkP0Cc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Fvh6fYSb7vo6Uv2J3RcYCmmnBCssRCWDX/ztf6wM5PPAMhOd7B7hfmQ/VohIhcby/RAmSoQ9OLsakC8ToQIjVOsepjronN+eGasRQ6sIgRfF8DimB6lt7ye9D5QzQzs0LQDQGcSkvQwFbAD65zkEIrTNbTvVX5Ix+xJMqMCTIvA=
Received: by 10.67.88.17 with SMTP id q17mr1740192ugl.1185407162562;
        Wed, 25 Jul 2007 16:46:02 -0700 (PDT)
Received: by 10.66.255.6 with HTTP; Wed, 25 Jul 2007 16:46:02 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53742>

Stacked GIT 0.13 release is available from http://www.procode.org/stgit=
/.

StGIT is a Python application providing similar functionality to Quilt
(i.e. pushing/popping patches to/from a stack) on top of GIT. These
operations are performed using GIT commands and the patches are stored
as GIT commit objects, allowing easy merging of the StGIT patches into
other repositories using standard GIT functionality.

The main features in this release:

    * Documentation directory with man pages
    * Safety checks for the 'rebase' command
    * Various contrib scripts
    * 'cp' command to copy files
    * 'sink' command to complement 'float'
    * '--diff-opts' option to some commands for passing additional
arguments to 'git-diff-*'
    * 'stgit.mail.prefix' configuration option for the default 'mail
--prefix' value
    * Interractive 2-way merging via xxdiff or emacs (previously, only
3-way merging had this feature)
    * Slightly changed behaviour to the 'patches' command when no
argument is given to show the patches touching the locally modified
files
    * Correct importing of multipart e-mails
    * '--unrelated' option to 'mail' to send patches unthreaded and
without sequence numbering
    * '--update' option to 'refresh' to only check in the files
already modified by the current patch (similar to 'pick --update')
    * '--keep' option to 'goto' (though it only works for patch popping=
)
    * '--expose' option to 'pick' to append the picked commit id to
the log (similar to the 'git cherry-pick -x' command)
    * The 'new' command can automatically generate the patch name from
the given log
    * 'uncommit' can generate patches up to a given commit id
    * Bug fixes


Acknowledgements (special thanks to Yann Dirson who was the main
contributor to this release; many thanks to all the contributors
below):

Yann Dirson (88):
      Refuse to pull/rebase when rendered unsafe by (un)commits.
      Rework of the 'stg pull' policy.
      Correctly raise exception on unknown pull-policy.
      Add a testcase for the safety of pull-policy=3D'pull'.
      Factorize editor handling.
      Add a Documentation directory inspired by the git one.
      Merge doc/ and Documentation/ directories.
      Add missing files to stgit manifest.
      Add contrib/stg-whatchanged: look at what would be changed by ref=
reshing.
      Add contrib/stg-show-old: show old version of a patch.
      Add contrib/stg-fold-files-from: pick selected changes from a
patch above current one
      Add contrib/stg-swallow: completely merge an unapplied patch
into current one
      Add contrib/stg-cvs: helper script to manage a mixed cvs/stgit
working copy
      Add contrib/stg-gitk: helper script to run gitk
      Add contrib/stg-mdiff: display diffs of diffs.
      Add contrib/stg-sink: sink a patch to given location (mirrors flo=
at).
      Fix bash completion to not garble the screen with an error messag=
e.
      Add 'stg cp' command.
      Do not link to docs that will never be written.
      Some clarifications to the main doc.
      Make 'stg cp' 2nd form safe.
      Fixed t2102-pull-policy-rebase to really test 'rebase' policy.
      Fix stack deletion when orig-base is present.
      Fix diagnostic messages on patch deletion and simplify others.
      Make use exception raised by removedirs.
      Drop utils.remove_dirs() in favor of os.removedirs().
      Copy parentbranch setting on 'stg branch --clone'.
      Remove debugging output from contrib/stg-sink
      Add a script to quickly run an interactive test session.
      Add support for unsetting config vars.
      Cleanup parent information on stgit branch deletion.
      Fix typo in help string.
      Don't use section 7 for main manpage.
      Add doc for 'clone' and 'init'.
      Add doc for 'branch'.
      Fix doc cross-refs.
      Make the documentation of options more consistent.
      Stop advertising 'pull' as the only operation blocked on protecte=
d stacks.
      Add "stg bury" command, with the functionality of contrib/stg-sin=
k.
      Document the new 'stg branch --description' features.
      Avoid contrib/stg-swallow deleting unrelated empty patches.
      Cleanup variable names in pick.
      Copy patchlogs when cloning a stack or picking a patch.
      Teach bash to complete branch names in some places.
      Document patch syntax.
      Stop recording branch.*.remote to '.' for local parents.
      Rename "bury" back to "sink".
      Add 2 new contrib scripts.
      Call external commands without a shell where possible.
      Make diff flags handling more modular.
      Add new --diff-opts/-O flag to diff- and status-related commands.
      Fix deletion and move of a hidden patch (gna bug #9244).
      Fix removal of series with non-existant trash dir.
      Fix removal of series to nuke the formatversion config item.
      Robustify rebase test: check patches are reapplied.
      Catch early trying rebasing to unknown ref, and add testcase.
      Fixed typo in contrib/stg-whatchanged.
      Changed rebasing safety check to look for reachability of stack
base (gna bug #9181).
      Test "stg rebase" after "stg commit"
      Have series show empty hidden patches as hidden rather than empty=
=2E
      Have mail take the default for --prefix from stgit.mail.prefix.
      Use get/set_name for a stack's name.
      Abstract a PatchSet object out of Series.
      Move stack format-version checks into Stack class.
      Rename branch.*.stgitformatversion to branch.*.stgit.stackformatv=
ersion.
      Revert 'Test "stg rebase" after "stg commit"'
      Revert 'Changed rebasing safety check to look for reachability of
      Update test-lib.sh from current git.
      Fix contrib/stg-whatchanged way of identifying a conflict.
      stg-cvs: update doc, and use correct setting for parent branch.
      Revert part of the reverted commit that we want to keep.
      Fixed thinko in error message.
      Changed sync not to use -b which has other semantics.
      Fix t1200 to catch intermediate errors.
      If available, use gitk --argscmd in contrib/stg-gitk.
      Allow "git show --branch".
      Disallow non-patch args to "stg show" (gna #8453).
      Make hidden patches visible to various commands (notably log, sho=
w, pick).
      Forbid the "series --all --short" combination.
      Recognize refs under remotes/ as parent branch on stack creation.
      Document shortcoming of stg-k and stg-unnew.
      Add a constructor to PatchSet.
      Revert 'Disallow non-patch args to "stg show" (gna #8453).'
      Display a message when the server refused some recipients.
      Fix stg-whatchanged to deal with conflicts already solved.
      Add range comparison support to stg-mdiff.
      Add to stg-mdiff the ability to pass options to underlying diff o=
pts.
      Port stg-whatchanged improvements to stg-mdiff and have the
former use the latter.

Catalin Marinas (34):
      Add --branch option to 'patches'
      Add an interractive 2-way merge option
      Add EditorException to stgit/utils.py
      Use and..or as a ternary operator rather than a dictionary
      [Revert] Make 'push --undo' safer
      Only check for upstream merges if not fast-forwarding
      Add --description option to branch
      Move man page stg(1) to stg(7)
      Fix the 'bury' command completion to include all patches
      Revert commit "Move man page stg(1) to stg(7)"
      Failed recursive merging can silently lose date in StGIT
      Fix typo in the patchlogs copying code
      Use list comprehension in uncommit.py for Python 2.3
      Add a "make tags" target
      Fix the automatic patch name generation for the pick command
      Fix bug #9284 - error messages include abbreviated command
      Fix the hidden patches functionality (bug #9077)
      Factor out common functionality into the utils.py file
      Add my release scripts to the contrib directory
      Show a joined string rather than list when reporting GIT failures
      Pass a string rather than an exception object in gitmergeonefile
      Modify the 'patches' command to use the locally modified files
      Fix the importing of multipart emails
      'sync' code comments clean-up after commit 6b79a09c
      Add the --unrelated option to mail
      Add '--update' option to 'refresh'
      Add --keep option to goto
      Allow 'refresh' to annotate the patch log entries
      Do not call 'refresh' when creating a patch (bug #8872)
      Add the '--expose' option to 'pick'
      Allow refresh --annotate to replace the top log entry
      Modify the assertion in Series.new_patch
      Add .mailmap file
      Release 0.13

Karl Hasselstr=F6m (23):
      String comparison is done with "=3D", not "=3D=3D"
      dash doesn't do curly brace expansion, so avoid that
      Don't use refs/bases/<branchname>
      Don't use patches/<branch>/current
      Fix popping on non-active branches
      Make the "name" argument to "stg new" optional
      Make patch deletion test more specific
      Test patch order, not just number of patches
      Use "stg applied" instead of reading the applied file directly
      Store branch description in the config file
      Make the "name" argument to "stg new" optional
      Generate patch names of more uniform length
      Remove an unnecessary parameter to make_patch_name
      If any uncommit would fail, don't uncommit anything
      Uncommit to a named commit
      Store branch description in the config file
      Remove obsolete files when deleting a branch
      Fix config caching so that get, set, get works
      Have only a single command in each test_expect_failure
      Upgrade old StGIT branches to new-format metadata
      Test the format version upgrade code
      Add --binary flag to commands that generate diffs
      Refactor message printing

Robin Rosenberg (3):
      Add an empty line before signed-off-by
      Update the bash prompt from 'applied' instead of the obsolete 'cu=
rrent'
      Don't use / as separatar since it is common i branch names

Petr Baudis (1):
      StGIT: Support Cc: fields in stg mail --auto

Roland Dreier (1):
      Fix deleting series trash directory

Sam Vilain (1):
      Some minor debian packaging fixes


--=20
Catalin
