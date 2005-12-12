From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 0.99.9m aka 1.0rc5
Date: Sun, 11 Dec 2005 18:34:20 -0800
Message-ID: <7vbqznm4b7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Dec 12 03:34:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EldWH-00078B-JS
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 03:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbVLLCeY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Dec 2005 21:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbVLLCeY
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Dec 2005 21:34:24 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:23806 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751040AbVLLCeX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Dec 2005 21:34:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051212023328.CMIG20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 11 Dec 2005 21:33:28 -0500
To: git@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13514>

GIT 0.99.9m aka 1.0rc5 is found at usual places:

	RPM
		http://kernel.org:/pub/software/scm/git/RPMS/

	Debian
		http://kernel.org:/pub/software/scm/git/debian/

Notable changes since 1.0rc4 are:

 - archimport updates.
 - gitk updates to work around Tcl/Tk i18n issues.
 - better portability to Solaris and AIX.
 - slimmed down update-server-info.
 - conflicting merge leaves higher stages in index around.
 - http-fetch does not fail to write refs in subdirectories.
 - git-prune cannot be made to lose referened objects by mistake anymore.
 - a lot of documentation fixes.

We are now feature complete and I am hoping that I can push the
same out sometime in the coming week tagged as v1.0, after
giving it some time to shake out any possible last-minute bugs.

Right now, proposed updates branch has sample patches for the
usage string clean-up from Fredrik Kuivinen for people to
comment on; it is not a complete series yet and makes some tests
fail.  I personally feel this series can and probably should
wait post 1.0.

-- >8 --

Alex Riesen:
      use "git init-db" in tests

Daniel Barkalow:
      Warn when send-pack does nothing
      Clean up file descriptors when calling hooks.
      Allow saving an object from a pipe

Eric Wong:
      archimport: first, make sure it still compiles
      archimport: remove String::ShellQuote dependency.
      archimport: fix -t tmpdir switch
      archimport: remove git wrapper dependency
      archimport: add -D <depth> and -a switch
      archimport: safer log file parsing
      archimport: Add the accurate changeset applyer
      archimport: Fix a bug I introduced in the new log parser
      archimport: fix a in new changeset applyer addition

Jason Riedy:
      Document config.mak in INSTALL.
      Initial AIX portability fixes.
      Use printf rather than echo -n.

Jon Loeliger:
      Added documentation for few missing options.

Junio C Hamano:
      compat/setenv: do not free what we fed putenv(3).
      git.c: two fixes, gitsetenv type and off-by-one error.
      show-branch: allow glob pattern to name branches to show.
      Documentation: rebase does not use cherry-pick anymore.
      struct tree: remove unused field "parent"
      git.c: remove excess output for debugging when command is too long.
      sha1_file.c: make sure packs in an alternate odb is named properly.
      server-info.c: drop unused D lines.
      server-info: stop sorting packs by latest date.
      server-info: throw away T computation as well.
      Documentation: talk about pathspec in bisect.
      Documentation: git-mv manpage workaround.
      Documentation: git-diff asciidoc table workaround.
      Documentation: push/receive hook references.
      Documentation: shared repository management in tutorial.
      server-info.c: use pack_local like everybody else.
      server-info.c: and two functions are not used anymore.
      config.c: remove unnecessary header in minimum configuration file.
      Clean up compatibility definitions.
      Fix 5501 test
      git-mv to work with Perl 5.6
      hash-object: -- and --help
      init-db: check extra arguments and complain.
      write-tree: check extra arguments and die but be a bit more helpful.
      Documentation: hash-object.
      Documentaiton (read-tree): update description of 3-way
      git-merge-one-file: resurrect leading path creation.
      qsort() ptrdiff_t may be larger than int
      checkout-index: allow checking out from higher stages.
      git-merge-one: new merge world order.
      update-index: allow --index-info to add higher stages.
      Documentation: git.html/git.7
      Documentation(glossary): minor formatting clean-ups.
      Documentation(cvs-migration): minor cleanups.
      Documentation(tutorial): adjust merge example to the new merge world order.
      refs.c: make sure leading directories exist before writing a ref.
      Make sure we use compat/subprocess.py with Python 2.3 while running tests.
      Documentation: recursive is the default strategy these days.
      show-branch: comment typo
      Documentation: git-prune
      qsort(): ptrdiff_t may be larger than int
      git-prune: never lose objects reachable from our refs.
      Use GIT_EXEC_PATH explicitly for initial git-init-db in tests.
      Everyday GIT with 20 commands
      Link Everyday GIT to main documentation tree.
      t3300: funny name test
      t0000: catch trivial pilot errors.
      format-patch: use same number of digits in numbers
      merge-recursive: leave unmerged entries in the index.
      merge-recursive: cleanup setIndexStages
      t/t6022: a new test for renaming merge.

Nikolai Weibull:
      Document the --non-empty command-line option to git-pack-objects.
      Fix the description of --utf8 and --keep to git-am.
      Use uniform description for the '--' option.
      Documentation/git-commit.txt: Add long options and -- to documentation.
      Documentation/git-verify-pack.txt: added documentation for --.
      Documentation/git-cvsimport.txt: Fix a slight glitch in description heading.
      Documentation/git-cherry-pick: Add --replay and --no-commit.
      Add documentation for git-revert and git-cherry-pick.
      Add documentation for the --topo-order option to git-show-branch.
      Documentation/git-format-patch.txt: Add --signoff, --check, and long option-names.
      Documentation/git-ls-remote.txt: Add -h and -t.
      Documentation/git-repack.txt: Add -l and -n.
      Documentation/git-http-fetch.txt: Document the commit-id argument.
      Documentation/git-update-server-info.txt: Add -f alias for --force to documentation.
      Documentation/git-tag.txt: Fix the order of sections (DESCRIPTION should come before OPTIONS).
      Documentation/git-read-tree.txt: Add --reset to SYNOPSIS.

Paul Mackerras:
      gitk: Factored out some common code into a new start_rev_list procedure
      gitk: Some improvements for the code for updating the display
      gitk: Work around Tcl's non-standard names for encodings

Petr Baudis:
      Update the git-ls-tree documentation
      Document the --(no-)edit switch of git-revert and git-cherry-pick

Sven Verdoolaege:
      gitk: add Update menu item.
