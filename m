From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.5.2.2
Date: Sat, 16 Jun 2007 18:57:26 -0700
Message-ID: <7vodjf1gxl.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 17 03:57:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hzk1G-000398-Ay
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 03:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758157AbXFQB53 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 21:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758055AbXFQB53
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 21:57:29 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:43836 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756092AbXFQB51 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 21:57:27 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070617015728.NHZL6565.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sat, 16 Jun 2007 21:57:28 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id CRxS1X00S1kojtg0000000; Sat, 16 Jun 2007 21:57:27 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50329>

The latest maintenance release GIT 1.5.2.2 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.2.2.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.2.2.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.2.2.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.2.2-1.$arch.rpm	(RPM)

GIT v1.5.2.2 Release Notes
==========================

Fixes since v1.5.2.1
--------------------

* Usability fix

  - git-gui is shipped with its updated blame interface.  It is
    rumored that the older one was not just unusable but was
    active health hazard, but this one is actually pretty.
    Please see for yourself.

* Bugfixes

  - "git checkout fubar" was utterly confused when there is a
    branch fubar and a tag fubar at the same time.  It correctly
    checks out the branch fubar now.

  - "git clone /path/foo" to clone a local /path/foo.git
    repository left an incorrect configuration.

  - "git send-email" correctly unquotes RFC 2047 quoted names in
    the patch-email before using their values.

  - We did not accept number of seconds since epoch older than
    year 2000 as a valid timestamp.  We now interpret positive
    integers more than 8 digits as such, which allows us to
    express timestamps more recent than March 1973.

  - git-cvsimport did not work when you have GIT_DIR to point
    your repository at a nonstandard location.

  - Some systems (notably, Solaris) lack hstrerror() to make
    h_errno human readable; prepare a replacement
    implementation.

  - .gitignore file listed git-core.spec but what we generate is
    git.spec, and nobody noticed for a long time.

  - "git-merge-recursive" does not try to run file level merge
    on binary files.

  - "git-branch --track" did not create tracking configuration
    correctly when the branch name had slash in it.

  - The email address of the user specified with user.email
    configuration was overriden by EMAIL environment variable.

  - The tree parser did not warn about tree entries with
    nonsense file modes, and assumed they must be blobs.

  - "git log -z" without any other request to generate diff still
    invoked the diff machinery, wasting cycles.

* Documentation

  - Many updates to fix stale or missing documentation.

  - Although our documentation was primarily meant to be formatted
    with AsciiDoc7, formatting with AsciiDoc8 is supported better.


----------------------------------------------------------------

Changes since v1.5.2.1 are as follows:

Alex Riesen (3):
      Make the installation target of git-gui a little less chatty
      Fix clone to setup the origin if its name ends with .git
      Add a local implementation of hstrerror for the system which do not have it

Gerrit Pape (1):
      Fix typo in remote branch example in git user manual

J. Bruce Fields (4):
      user-manual: quick-start updates
      user-manual: add a missing section ID
      Documentation: user-manual todo
      tutorial: use "project history" instead of "changelog" in header

Jakub Narebski (1):
      Generated spec file to be ignored is named git.spec and not git-core.spec

Johannes Schindelin (2):
      Move buffer_is_binary() to xdiff-interface.h
      merge-recursive: refuse to merge binary files

Johannes Sixt (1):
      Accept dates before 2000/01/01 when specified as seconds since the epoch

Junio C Hamano (6):
      checkout: do not get confused with ambiguous tag/branch names
      $EMAIL is a last resort fallback, as it's system-wide.
      git-branch --track: fix tracking branch computation.
      Avoid diff cost on "git log -z"
      Documentation: adjust to AsciiDoc 8
      GIT 1.5.2.2

Kristian H淡gsberg (1):
      Unquote From line from patch before comparing with given from address.

Luiz Fernando N. Capitulino (1):
      git-cherry: Document 'limit' command-line option

Matthijs Melchior (1):
      New selection indication and softer colors

Michael Milligan (1):
      git-cvsimport: Make sure to use $git_dir always instead of .git sometimes

Sam Vilain (2):
      fix documentation of unpack-objects -n
      Don't assume tree entries that are not dirs are blobs

Shawn O. Pearce (47):
      git-gui: Allow creating a branch when none exists
      git-gui: Allow as few as 0 lines of diff context
      git-gui: Don't quit when we destroy a child widget
      git-gui: Attach font_ui to all spinbox widgets
      git-gui: Verify Tcl/Tk is new enough for our needs
      Revert "Make the installation target of git-gui a little less chatty"
      git-gui: Add a 4 digit commit abbreviation to the blame viewer
      git-gui: Cleanup blame::new widget initialization
      git-gui: Remove empty blank line at end of blame
      git-gui: Improve the coloring in blame viewer
      git-gui: Simplify consecutive lines that come from the same commit
      git-gui: Use arror cursor in blame viewer file data
      git-gui: Display tooltips in blame viewer
      git-gui: Highlight the blame commit header from everything else
      git-gui: Remove unnecessary reshow of blamed commit
      git-gui: Cleanup minor style nit
      git-gui: Space the commit group continuation out in blame view
      git-gui: Show author initials in blame groups
      git-gui: Allow the user to control the blame/commit split point
      git-gui: Display a progress bar during blame annotation gathering
      git-gui: Allow digging through history in blame viewer
      git-gui: Combine blame groups only if commit and filename match
      git-gui: Show original filename in blame tooltip
      git-gui: Use a label instead of a button for the back button
      git-gui: Clip the commit summaries in the blame history menu
      git-gui: Remove the loaded column from the blame viewer
      git-gui: Remove unnecessary space between columns in blame viewer
      git-gui: Use lighter colors in blame view
      git-gui: Make the line number column slightly wider in blame
      git-gui: Automatically expand the line number column as needed
      git-gui: Remove unused commit_list from blame viewer
      git-gui: Better document our blame variables
      git-gui: Cleanup redundant column management in blame viewer
      git-gui: Switch internal blame structure to Tcl lists
      git-gui: Label the uncommitted blame history entry
      git-gui: Rename fields in blame viewer to better descriptions
      git-gui: Display the "Loading annotation..." message in italic
      git-gui: Run blame twice on the same file and display both outputs
      git-gui: Display both commits in our tooltips
      git-gui: Jump to original line in blame viewer
      git-gui: Use three colors for the blame viewer background
      git-gui: Improve our labeling of blame annotation types
      git-gui: Favor the original annotations over the recent ones
      git-gui: Changed blame header bar background to match main window
      git-gui: Include 'war on whitespace' fixes from git.git
      git-gui: Give amend precedence to HEAD over MERGE_MSG
      git-gui: Save geometry before the window layout is damaged

william pursell (1):
      Make command description imperative statement, not third-person present.
