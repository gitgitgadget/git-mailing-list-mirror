From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [ANNOUNCE] git-gui 0.8.0 now available
Date: Mon, 30 Jul 2007 01:38:00 -0400
Message-ID: <20070730053800.GR20052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 07:38:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFNxV-0008Qv-9k
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 07:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757651AbXG3FiJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 01:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756505AbXG3FiI
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 01:38:08 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33918 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757478AbXG3FiH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 01:38:07 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IFNxE-0004PF-J9
	for git@vger.kernel.org; Mon, 30 Jul 2007 01:38:04 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9F39620FBAE; Mon, 30 Jul 2007 01:38:00 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54188>

I've finally released git-gui 0.8.0.  Junio has already promised
to include this version in git 1.5.3 when it gets released, but
you can also acquire it directly from my repo.or.cz repository:

  gitweb:  http://repo.or.cz/w/git-gui.git/
  fetch:   git://repo.or.cz/git-gui.git
           http://repo.or.cz/r/git-gui.git


Changes between 0.7.0 and 0.7.5:

  Most of these changes have already been seen by a lot of users,
  as they have been shipping with the maint releases of git 1.5.2
  and the release candidates of 1.5.3.

  * Completely rewritten blame viewer

    The blame viewer was completely overhauled, with almost none of
    the code from pre-0.7.0 surviving the rewrite.  The end result
    is a viewer that actually offers a fast overview of how code
    has moved around, and makes use of tooltips to display detailed
    information quickly.

  * new: Keybinding of Cmd-P/Ctrl-P for push action
  * new: Push action button on left side toolbar

  * bugfix: Prefer HEAD's message over MERGE_MSG when amending
  * bugfix: Ensure Windows git-gui "icons" always end in .bat
  * bugfix: ls-tree buffering error in tree browser
  * bugfix: Work around ^{tree} shell error on MSYS
  * bugfix: Avoid 'nice.exe' on MSYS


Changes between 0.7.5 and 0.8.0:

  Most of these new features haven't been merged into git.git yet,
  but will be before 1.5.3 is released.

  * Overhauled 'Starting Revision' UI for branch creation

    The 'Starting Revision' part of the branch create dialog has
    been rebuilt to better handle a large number of local and remote
    tracking branches.  A glob-style filter can be applied to narrow
    the list of choices.  Tooltips show the tip revision of each
    branch, and also the last time the branch was last updated.

    The new UI is much better suited to dealing with 200+ branches.

  * Overhauled revision selection UI for checkout

    The improved UI used for branch creation is also now used for
    checkout, including local branches, remote tracking branches,
    tags and arbitrary SHA-1 revision expressions.

  * Overhauled revision selection UI for merge

    Like checkout, merge uses the improved revision selection UI.
    This allows users to merge arbitrary commits and not just
    branches or tags.  It also avoids problems with long branch
    names being clipped and not fully visible.

  * Branch reset (aka git-branch -f) support

    Local branches can be reset through Branch->Create.  This avoids
    needing to delete the branch first, thereby saving the associated
    reflog history.

  * Automatically refetch tracking branches when needed

    Before creating a new local branch or checking out a tracking
    branch git-gui can first update the local tracking branch by
    fetching it from the associated remote repository.

    This feature helps users trying to work in a "bound branch"
    workflow by making sure that they are always working with the
    latest revision.

  * Better detached HEAD support

    git-gui now always works properly on detached HEAD and can switch
    between local branches and detached HEAD.  The Branch->Checkout
    menu option offers support for switching to a detached HEAD.

    HEAD's reflog is now also updated similar to how core Git's
    command line tools would update it.

  * Browse any branch/revision and not just the current branch

    The browser (and thus blame viewer) can now be opened for any
    commit, not just the current branch.  The commit can be selected
    using the improved revision selection UI already discussed above.

  * Delete branches from remote repositories

    If the remote repository is running git 1.5 or later you can
    now delete remote branches through the Push->Delete menu.

  * Prune local tracking branches via `git remote prune`

    Pruning automatically deletes any tracking branches whose
    corresponding remote branch has already been removed from the
    remote repository.  A configuration option accessible in the
    options dialog can enable this feature to run after each fetch.

  * Blame/browser now works in bare repositories

    The `git gui blame` and `git gui browser` command line
    subcommands now work properly in a bare Git repository.
    This makes it easier to use git-gui's blame viewer.

  * More consistent blame/browser command line interface

    Revision and path argument parsing for the blame and browser
    subcommands is more consistent with each other and now behave
    like the core git-blame argument parsing.

  * Progress meter during checkout/reset operations

    git-gui now scrapes the output of `git-read-tree -v` during a
    branch checkout or reset and shows the progress meter in the
    main window's status bar.  This lets users know how much work is
    (roughly) remaining to complete the operation.

  * Tracking branch merges are now formatted as pulls

    When merging a tracking branch git-gui now generates the
    commit message as though the branch was fetched+merged from the
    remote using git-pull.  This makes for a cleaner merge commit
    message, but does not incur the network IO that would normally
    be associated with git-pull.

  * Automatic commit message backup

    The Edit->Undo action appears to cause Tk to crash on some
    platforms.  To prevent users from losing the commit message
    they were drafting git-gui now backs up the buffer to a file
    every 2 seconds, if it has changed since the last backup.

  * Removed 'octopus' merge support

    It was decided recently on #git that octopus merge support is
    not used often, and is probably not something users should be
    commonly using.  It has been removed from git-gui entirely.

  * Language change: "to stage" instead of "to add"

    This improvement came from Christian Stimming as part of the
    i18n work.  Although the command line uses git-add to stage
    changes into the index we do tend to refer to this action as
    "staging" and not "adding".  Christian's changes really clarify
    the UI for English users and should help i18n translators to
    find better translations in their target language.

  * Misc. bug fixes and UI tweaks

    A number of other bugs were fixed and some minor UI nits were
    corrected.  For complete details please review the actual
    commit history.


0.8.0 testing history:

  Just to give folks a little warm-n-fuzzy feeling about merging
  so much new functionality into git 1.5.3 right before release,
  I offer up this little tidbit:

  I have a local git-gui user's group at my day-job made up of about
  20 users, ranging in skill from "novice computer user" to "expert
  developer".  They have been using version 0.8.0 on Cygwin for their
  daily work for quite a while now and are reasonably happy with it.

  Of course they also want even more features implemented.
  Who doesn't.  ;-)

-- 
Shawn.
