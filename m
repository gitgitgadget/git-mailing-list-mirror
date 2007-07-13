From: Junio C Hamano <gitster@pobox.com>
Subject: Draft release notes for v1.5.3, as of -rc1
Date: Thu, 12 Jul 2007 23:40:39 -0700
Message-ID: <7vlkdkq00o.fsf_-_@assigned-by-dhcp.cox.net>
References: <7v4pmgqrut.fsf@assigned-by-dhcp.cox.net>
	<7vhcqccnbm.fsf@assigned-by-dhcp.cox.net>
	<7vveepz8pr.fsf@assigned-by-dhcp.cox.net>
	<7vmyzv1acz.fsf@assigned-by-dhcp.cox.net>
	<7vejl0546b.fsf@assigned-by-dhcp.cox.net>
	<7v4plqoyg5.fsf@assigned-by-dhcp.cox.net>
	<7v7iqgtt1j.fsf@assigned-by-dhcp.cox.net>
	<7vk5u7d38h.fsf@assigned-by-dhcp.pobox.com>
	<7vy7idydqa.fsf@assigned-by-dhcp.pobox.com>
	<7v7ipsz7vr.fsf@assigned-by-dhcp.pobox.com>
	<7vk5tj3bj1.fsf@assigned-by-dhcp.cox.net>
	<7vzm20q1l7.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 08:40:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9Epd-0007UE-8X
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 08:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516AbXGMGkm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 02:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753418AbXGMGkm
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 02:40:42 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:55278 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274AbXGMGkl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 02:40:41 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070713064041.MFIZ1358.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Fri, 13 Jul 2007 02:40:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Nugf1X00S1kojtg0000000; Fri, 13 Jul 2007 02:40:40 -0400
In-Reply-To: <7vzm20q1l7.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 12 Jul 2007 23:06:44 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52366>

GIT v1.5.3 Release Notes (draft)
========================

Updates since v1.5.2
--------------------

* The commit walkers other than http are officially deprecated,
  but still supported for now.

* The submodule support has Porcelain layer.

* There are a handful pack-objects changes to help you cope better
  with repositories with pathologically large blobs in them.

* For people who need to import from Perforce, a front-end for
  fast-import is in contrib/fast-import/.

* Comes with git-gui 0.8.0.

* Comes with updated gitk.

* New commands and options.

  - The hunk header output from "git diff" family can be customized
    with the attributes mechanism.  See gitattributes(5) for details.

  - "git stash" allows you to quickly save away your work in
    progress and replay it later on an updated state.

  - "git rebase" learned an "interactive" mode that let you
    pick and reorder which commits to rebuild.

  - "git fsck" can save its findings in $GIT_DIR/lost-found,
    without a separate invocation of "git lost-found" command.

  - $GIT_WORK_TREE environment variable can be used together with
    $GIT_DIR to work in a subdirectory of a working tree that is
    not located at "$GIT_DIR/..".

  - "git log" learned a new option "--follow", to follow
    renaming history of a single file.

  - "git-filter-branch" lets you rewrite the revision history of
    the current branch, creating a new branch. You can specify a
    number of filters to modify the commits, files and trees.

  - "git-cvsserver" learned new options (--base-path, --export-all,
    --strict-paths) inspired by git-daemon.

  - "git-submodule" command helps you manage the projects from
    the superproject that contain them.

  - In addition to core.compression configuration option,
    core.loosecompression and pack.compression options can
    independently tweak zlib compression levels used for loose
    and packed objects.

  - "git-ls-tree -l" shows size of blobs pointed at by the
    tree entries, similar to "/bin/ls -l".

  - "git-rev-list" learned --regexp-ignore-case and
    --extended-regexp options to tweak its matching logic used
    for --grep fitering.

  - "git-describe --contains" is a handier way to call more
    obscure command "git-name-rev --tags".

  - "git gc --aggressive" tells the command to spend more cycles
    to optimize the repository harder.

  - "git repack" can be told to split resulting packs to avoid
    exceeding limit specified with "--max-pack-size".

  - "git fsck" gained --verbose option.  This is really really
    verbose but it might help you identify exact commit that is
    corrupt in your repository.

  - "git format-patch" learned --numbered-files option.  This
    may be useful for MH users.

  - "git format-patch" learned format.subjectprefix configuration
    variable, which serves the same purpose as "--subject-prefix"
    option.

  - "git tag -n -l" shows tag annotations while listing tags.

  - "git cvsimport" can optionally use the separate-remote layout.

  - "git blame" can be told to see through commits that change
    whitespaces and indentation levels with "-w" option.

  - "git send-email" can be told not to thread the messages when
    sending out more than one patches.

  - "git config" learned NUL terminated output format via -z to
    help scripts.

  - "git init -q" makes the command quieter.

* Updated behavior of existing commands.

  - "git svn dcommit" retains local merge information.

  - "git config" to set values also honors type flags like --bool
    and --int.

  - core.quotepath configuration can be used to make textual git
    output to emit most of the characters in the path literally.

  - "git mergetool" chooses its backend more wisely, taking
    notice of its environment such as use of X, Gnome/KDE, etc.

  - "gitweb" shows merge commits a lot nicer than before.  The
    default view uses more compact --cc format, while the UI
    allows to choose normal diff with any parent.

  - snapshot files "gitweb" creates from a repository at
    $path/$project/.git are more useful.  We use $project part
    in the filename, which we used to discard.

  - "git cvsimport" creates lightweight tags; there is no
    interesting information we can record in an annotated tag,
    and the handcrafted ones the old code created was not
    properly formed anyway.

  - "git-push" pretends that you immediately fetched back from
    the remote by updating corresponding remote tracking
    branches if you have any.

  - The diffstat given after a merge (or a pull) honors the
    color.diff configuration.

  - "git-apply --whitespace=strip" removes blank lines added at
    the end of the file.

  - "git-fetch" over git native protocols with "-v" option shows
    connection status, and the IP address of the other end, to
    help diagnosing problems.

  - We used to have core.legacyheaders configuration, when
    set to false, allowed git to write loose objects in a format
    that mimicks the format used by objects stored in packs.  It
    turns out that this was not so useful.  Although we will
    continue to read objects written in that format, we do not
    honor that configuration anymore and create loose objects in
    the legacy/traditional format.

  - "--find-copies-harder" option to diff family can now be
    spelled as "-C -C" for brevity.

  - "git-mailsplit" (hence "git-am") can read from Maildir
    formatted mailboxes.

  - "git-cvsserver" does not barf upon seeing "cvs login"
    request.

  - "pack-objects" honors "delta" attribute set in
    .gitattributes.  It does not attempt to deltify blobs that
    come from paths with delta attribute set to false.

  - "new-workdir" script (in contrib) can now be used with a
    bare repository.

  - "git-mergetool" learned to use gvimdiff.

  - "gitview" (in contrib) has a better blame interface.

  - "git log" and friends did not handle a commit log message
    that is larger than 16kB; they do now.

  - "--pretty=oneline" output format for "git log" and friends
    deals with "malformed" commit log messages that have more
    than one lines in the first paragraph better.  We used to
    show the first line, cutting the title at mid-sentence; we
    concatenate them into a single line and treat the result as
    "oneline".

* Builds

  - old-style function definitions (most notably, a function
    without parameter defined with "func()", not "func(void)")
    have been eradicated.

* Performance Tweaks

  - git-pack-objects avoids re-deltification cost by caching
    small enough delta results it creates while looking for the
    best delta candidates.

  - git-pack-objects learned a new heuristcs to prefer delta
    that is shallower in depth over the smallest delta
    possible.  This improves both overall packfile access
    performance and packfile density.

  - diff-delta code that is used for packing has been improved
    to work better on big files.

  - when there are more than one pack files in the repository,
    the runtime used to try finding an object always from the
    newest packfile; it now tries the same packfile as we found
    the object requested the last time, which exploits the
    locality of references.

  - verifying pack contents done by "git fsck --full" got boost
    by carefully choosing the order to verify objects in them.


Fixes since v1.5.2
------------------

All of the fixes in v1.5.2 maintenance series are included in
this release, unless otherwise noted.

* Bugfixes

  - "gitweb" had trouble handling non UTF-8 text with older
    Encode.pm Perl module.
