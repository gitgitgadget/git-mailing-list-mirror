From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.4.3
Date: Wed, 18 Oct 2006 16:53:22 -0700
Message-ID: <7vejt5xjt9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 01:53:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaLE4-0000Xk-MQ
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 01:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945911AbWJRXx2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 18 Oct 2006 19:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423180AbWJRXx2
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 19:53:28 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:17898 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1423168AbWJRXxZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 19:53:25 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061018235323.GTYN6077.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Oct 2006 19:53:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id bztS1V0091kojtg0000000
	Wed, 18 Oct 2006 19:53:27 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29304>

The latest feature release GIT 1.4.3 is available at the usual
places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.3.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.3.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.3-1.$arch.rpm	(RPM)

Please holler if i386 RPMs are broken, since they are not cut on
the machine I am used to use (I ended up burning half a day
installing and futzing with FC5 on my older laptop resurrected
from the boneyard).

User visible changes, other than bugfixes, since v1.4.2.4 are:

 - upload-tar is deprecated but not removed; we now have
   upload-archive --format=3Dtar and --format=3Dzip instead.

 - ftp:// protocol is supported the same way as http:// and
   https://

 - git-diff paginates its output to the tty by default.  If this
   irritates you, using LESS=3DRF might help.

 - git-cherry-pick does not leave often useless "cherry-picked
   from" message.

 - git-merge-recursive was replaced by a rewritten implemention
   in C.  The original Python implementation is available as
   "recursive-old" strategy for now, but hopefully we can remove
   it in the next cycle.

 - git-daemon can do name based virtual hosting.

 - git-daemon can serve tar and zip snapshots.

 - many gitweb tweaks and cleanups.

 - git-apply --reverse, --reject.

 - git-diff --color highlights whitespace errors.

 - git-diff --stat can be taught to use non-default widths.

 - git-status can use colors.

 - many more commands are built-in.

----------------------------------------------------------------

 .gitignore                                         |   10 +-
 Documentation/Makefile                             |    4 +-
 Documentation/asciidoc.conf                        |    1 +
 Documentation/config.txt                           |   34 +
 Documentation/core-tutorial.txt                    |    2 +-
 Documentation/cvs-migration.txt                    |    2 +-
 Documentation/diff-options.txt                     |   10 +-
 Documentation/git-apply.txt                        |   69 +-
 .../{git-tar-tree.txt =3D> git-archive.txt}          |   93 +-
 Documentation/git-blame.txt                        |   29 +-
 Documentation/git-cherry-pick.txt                  |   23 +-
 Documentation/git-daemon.txt                       |  135 +-
 Documentation/git-grep.txt                         |   15 +-
 Documentation/git-http-push.txt                    |    2 +-
 Documentation/git-init-db.txt                      |    4 +
 Documentation/git-ls-remote.txt                    |   18 +-
 Documentation/git-pack-objects.txt                 |   26 +-
 Documentation/git-receive-pack.txt                 |    2 +
 Documentation/git-repack.txt                       |   13 +-
 Documentation/git-repo-config.txt                  |    3 +-
 Documentation/git-rev-list.txt                     |  428 ++-
 Documentation/git-rev-parse.txt                    |    2 +-
 Documentation/git-send-pack.txt                    |    2 +-
 Documentation/git-shortlog.txt                     |   17 +-
 Documentation/git-svn.txt                          |  399 ++-
 Documentation/git-tar-tree.txt                     |    3 +
 Documentation/git-unpack-objects.txt               |    8 +-
 Documentation/git-update-index.txt                 |    4 +-
 .../{git-upload-tar.txt =3D> git-upload-archive.txt} |   24 +-
 Documentation/git.txt                              |   37 +-
 Documentation/gitk.txt                             |  151 +-
 Documentation/glossary.txt                         |    4 +-
 Documentation/hooks.txt                            |   56 +-
 Documentation/technical/racy-git.txt               |  193 +
 Documentation/tutorial-2.txt                       |    2 +-
 GIT-VERSION-GEN                                    |    2 +-
 INSTALL                                            |   15 +-
 Makefile                                           |  297 +-
 builtin-tar-tree.c =3D> archive-tar.c                |  229 +-
 archive-zip.c                                      |  333 ++
 archive.h                                          |   47 +
 blame.c                                            |   19 +-
 builtin-apply.c                                    |  708 +++-
 builtin-archive.c                                  |  263 ++
 builtin-cat-file.c                                 |   40 +-
 checkout-index.c =3D> builtin-checkout-index.c       |   29 +-
 builtin-commit-tree.c                              |    2 +-
 builtin-count.c =3D> builtin-count-objects.c         |    2 +-
 builtin-diff-files.c                               |    7 -
 builtin-diff-stages.c                              |    2 +-
 builtin-diff.c                                     |   16 +-
 builtin-fmt-merge-msg.c                            |   39 +-
 builtin-grep.c                                     |  650 +---
 builtin-init-db.c                                  |    1 +
 builtin-log.c                                      |    7 +-
 builtin-ls-files.c                                 |   27 +-
 builtin-ls-tree.c                                  |    6 +-
 builtin-mailinfo.c                                 |   17 +-
 builtin-mv.c                                       |   12 +-
 name-rev.c =3D> builtin-name-rev.c                   |    8 +-
 pack-objects.c =3D> builtin-pack-objects.c           |  439 ++-
 builtin-prune-packed.c                             |    2 +-
 builtin-prune.c                                    |    4 +-
 builtin-push.c                                     |   32 +-
 builtin-read-tree.c                                |  865 +----
 builtin-repo-config.c                              |   34 +-
 builtin-rev-list.c                                 |  171 +-
 builtin-rev-parse.c                                |   10 +-
 builtin-rm.c                                       |    2 +-
 builtin-runstatus.c                                |   36 +
 builtin-show-branch.c                              |   18 +-
 symbolic-ref.c =3D> builtin-symbolic-ref.c           |    8 +-
 builtin-tar-tree.c                                 |  439 +--
 unpack-objects.c =3D> builtin-unpack-objects.c       |   78 +-
 builtin-update-index.c                             |   18 +-
 builtin-update-ref.c                               |    2 +-
 builtin-upload-archive.c                           |  175 +
 builtin-upload-tar.c                               |   74 -
 verify-pack.c =3D> builtin-verify-pack.c             |   15 +-
 builtin-write-tree.c                               |    4 +-
 builtin.h                                          |   86 +-
 cache-tree.c                                       |   14 +-
 cache.h                                            |   68 +-
 check-racy.c                                       |   28 +
 color.c                                            |  176 +
 color.h                                            |   12 +
 combine-diff.c                                     |   41 +-
 commit.c                                           |   51 +-
 commit.h                                           |    2 +-
 compat/inet_pton.c                                 |  220 +
 config.c                                           |   18 +-
 config.mak.in                                      |   18 +
 configure.ac                                       |  561 ++-
 connect.c                                          |   50 +-
 contrib/completion/git-completion.bash             |  324 ++
 contrib/emacs/git.el                               |    4 +-
 contrib/emacs/vc-git.el                            |    6 +-
 contrib/gitview/gitview.txt                        |   56 +-
 contrib/vim/README                                 |    8 +
 contrib/vim/syntax/gitcommit.vim                   |   18 +
 convert-objects.c                                  |    8 +-
 csum-file.c                                        |    6 +-
 daemon.c                                           |  431 ++-
 date.c                                             |  132 +-
 describe.c                                         |   14 +-
 diff-delta.c                                       |    4 +-
 diff-lib.c                                         |   32 +-
 diff.c                                             |  666 ++-
 diff.h                                             |   15 +-
 diffcore-break.c                                   |    2 +-
 diffcore-rename.c                                  |    2 +-
 dir.c                                              |   48 +-
 dir.h                                              |    1 +
 dump-cache-tree.c                                  |    2 +-
 entry.c                                            |    4 +-
 environment.c                                      |   20 +-
 exec_cmd.c                                         |   20 +-
 fetch-clone.c                                      |   33 +-
 fetch-pack.c                                       |   24 +-
 fetch.c                                            |    9 +-
 fsck-objects.c                                     |   44 +-
 generate-cmdlist.sh                                |    1 +
 git-branch.sh                                      |   10 +
 git-checkout.sh                                    |    9 +-
 git-cherry.sh                                      |    3 -
 git-clone.sh                                       |    8 +-
 git-commit.sh                                      |  582 +--
 git-compat-util.h                                  |   18 +-
 git-cvsexportcommit.perl                           |    2 +-
 git-cvsserver.perl                                 |   65 +-
 git-fetch.sh                                       |   26 +-
 git-ls-remote.sh                                   |    6 +-
 ...erge-recursive.py =3D> git-merge-recursive-old.py |    0=20
 git-merge.sh                                       |    5 +-
 git-parse-remote.sh                                |   43 +-
 git-pull.sh                                        |    2 +-
 git-rebase.sh                                      |    6 +-
 git-repack.sh                                      |   25 +-
 git-reset.sh                                       |    3 -
 git-resolve.sh                                     |    4 +
 git-revert.sh                                      |   14 +-
 git-send-email.perl                                |   42 +-
 git-shortlog.perl                                  |   44 +-
 git-svn.perl                                       |  122 +-
 git-svnimport.perl                                 |   35 +-
 git.c                                              |  131 +-
 git.spec.in                                        |   23 +-
 gitk                                               |  682 +++-
 gitweb/README                                      |   61 +-
 gitweb/git-favicon.png                             |  Bin
 gitweb/git-logo.png                                |  Bin
 gitweb/gitweb.css                                  |   80 +-
 gitweb/{gitweb.cgi =3D> gitweb.perl}                 | 4459 ++++++++++=
++--------
 grep.c                                             |  498 +++
 grep.h                                             |   79 +
 builtin-help.c =3D> help.c                           |    4 +-
 http-fetch.c                                       |  303 +--
 http-push.c                                        |   95 +-
 http.c                                             |   12 +
 http.h                                             |    4 +
 imap-send.c                                        |   45 +-
 index-pack.c                                       |   16 +-
 interpolate.c                                      |  108 +
 interpolate.h                                      |   26 +
 builtin-prune.c =3D> list-objects.c                  |  255 +-
 list-objects.h                                     |   12 +
 local-fetch.c                                      |    8 +-
 log-tree.c                                         |   82 +-
 merge-base.c                                       |    2 +-
 merge-file.c                                       |    2 +-
 merge-index.c                                      |    5 +-
 merge-recursive.c                                  | 1351 ++++++
 merge-tree.c                                       |   10 +-
 mktag.c                                            |    2 +-
 mktree.c                                           |    5 +-
 object-refs.c                                      |   11 +-
 object.c                                           |    6 +-
 object.h                                           |   11 -
 pack-check.c                                       |   25 +-
 pack-redundant.c                                   |   18 +-
 pager.c                                            |    4 +-
 patch-id.c                                         |    2 +-
 path-list.c                                        |    5 +-
 path.c                                             |   10 +-
 peek-remote.c                                      |    5 +-
 perl/.gitignore                                    |    4 +
 perl/Git.pm                                        |  837 ++++
 perl/Makefile.PL                                   |   28 +
 perl/private-Error.pm                              |  827 ++++
 quote.c                                            |   61 +
 quote.h                                            |    7 +
 read-cache.c                                       |   77 +-
 receive-pack.c                                     |   28 +-
 refs.c                                             |   26 +-
 revision.c                                         |  258 +-
 revision.h                                         |   14 +-
 rsh.c                                              |   31 +-
 run-command.c                                      |    8 +-
 send-pack.c                                        |  126 +-
 server-info.c                                      |    2 +-
 setup.c                                            |    2 +
 sha1_file.c                                        |  596 ++--
 sha1_name.c                                        |   60 +-
 sideband.c                                         |   78 +
 sideband.h                                         |   13 +
 ssh-fetch.c                                        |   10 +-
 ssh-upload.c                                       |    4 +-
 t/t1200-tutorial.sh                                |    2 +-
 t/t1400-update-ref.sh                              |   86 +-
 t/t3200-branch.sh                                  |   12 +
 t/t3403-rebase-skip.sh                             |    4 +-
 t/t3700-add.sh                                     |   22 +
 t/t4015-diff-whitespace.sh                         |  122 +
 t/t4103-apply-binary.sh                            |    4 +-
 t/t4104-apply-boundary.sh                          |  115 +
 t/t4116-apply-reverse.sh                           |   85 +
 t/t4117-apply-reject.sh                            |  157 +
 t/t5400-send-pack.sh                               |   14 +
 t/t5510-fetch.sh                                   |   69 +
 t/t5600-clone-fail-cleanup.sh                      |    6 +
 t/t5710-info-alternate.sh                          |    2 +
 t/t6001-rev-list-graft.sh                          |  113 +
 t/t7002-grep.sh                                    |   31 +-
 t/t7201-co.sh                                      |    9 +
 t/test-lib.sh                                      |   17 +-
 trace.c                                            |  150 +
 tree-diff.c                                        |   15 +-
 tree-walk.c                                        |    4 +-
 tree.c                                             |    5 +-
 builtin-read-tree.c =3D> unpack-trees.c              |  474 +--
 unpack-trees.h                                     |   35 +
 upload-pack.c                                      |  190 +-
 write_or_die.c                                     |   45 +
 wt-status.c                                        |  276 ++
 wt-status.h                                        |   25 +
 xdiff-interface.c                                  |   12 +-
 xdiff/xutils.c                                     |   29 +-
 237 files changed, 16898 insertions(+), 8168 deletions(-)
 copy Documentation/{git-tar-tree.txt =3D> git-archive.txt} (29%)
 rewrite Documentation/git-rev-list.txt (61%)
 rename Documentation/{git-upload-tar.txt =3D> git-upload-archive.txt} =
(30%)
 rewrite Documentation/gitk.txt (37%)
 create mode 100644 Documentation/technical/racy-git.txt
 copy builtin-tar-tree.c =3D> archive-tar.c (59%)
 create mode 100644 archive-zip.c
 create mode 100644 archive.h
 create mode 100644 builtin-archive.c
 rename builtin-cat-file.c =3D> builtin-cat-file.c (0%)
 rename checkout-index.c =3D> builtin-checkout-index.c (92%)
 rename builtin-count.c =3D> builtin-count-objects.c (99%)
 rename name-rev.c =3D> builtin-name-rev.c (97%)
 rename pack-objects.c =3D> builtin-pack-objects.c (81%)
 create mode 100644 builtin-runstatus.c
 rename symbolic-ref.c =3D> builtin-symbolic-ref.c (75%)
 rename unpack-objects.c =3D> builtin-unpack-objects.c (82%)
 create mode 100644 builtin-upload-archive.c
 delete mode 100644 builtin-upload-tar.c
 rename verify-pack.c =3D> builtin-verify-pack.c (83%)
 create mode 100644 check-racy.c
 create mode 100644 color.c
 create mode 100644 color.h
 create mode 100644 compat/inet_pton.c
 rewrite configure.ac (21%)
 create mode 100755 contrib/completion/git-completion.bash
 rename contrib/gitview/{gitview.txt =3D> gitview.txt} (74%)
 create mode 100644 contrib/vim/README
 create mode 100644 contrib/vim/syntax/gitcommit.vim
 rename git-merge-recursive.py =3D> git-merge-recursive-old.py (100%)
 create mode 100644 gitweb/git-favicon.png
 create mode 100644 gitweb/git-logo.png
 rename gitweb/{gitweb.cgi =3D> gitweb.perl} (30%)
 create mode 100644 grep.c
 create mode 100644 grep.h
 rename builtin-help.c =3D> help.c (99%)
 create mode 100644 interpolate.c
 create mode 100644 interpolate.h
 copy builtin-prune.c =3D> list-objects.c (24%)
 create mode 100644 list-objects.h
 create mode 100644 merge-recursive.c
 create mode 100644 perl/.gitignore
 create mode 100644 perl/Git.pm
 create mode 100644 perl/Makefile.PL
 create mode 100644 perl/private-Error.pm
 create mode 100644 sideband.c
 create mode 100644 sideband.h
 create mode 100755 t/t4015-diff-whitespace.sh
 create mode 100755 t/t4104-apply-boundary.sh
 create mode 100755 t/t4116-apply-reverse.sh
 create mode 100755 t/t4117-apply-reject.sh
 create mode 100755 t/t5510-fetch.sh
 create mode 100755 t/t6001-rev-list-graft.sh
 create mode 100644 trace.c
 copy builtin-read-tree.c =3D> unpack-trees.c (62%)
 create mode 100644 unpack-trees.h
 create mode 100644 write_or_die.c
 create mode 100644 wt-status.c
 create mode 100644 wt-status.h

Alan Chandler (2):
      Update the gitweb/README file to include setting the GITWEB_CONFI=
G environment
      Fix usage string to match that given in the man page

Alex Riesen (3):
      Use const for interpolate arguments
      fix daemon.c compilation for NO_IPV6=3D1
      do not discard constness in interp_set_entry value argument

Alexandre Julliard (2):
      git.el: Fixed inverted "renamed from/to" message.
      vc-git.el: Switch to using git-blame instead of git-annotate.

Andy Whitcroft (4):
      send-pack: remove remote reference limit
      send-pack: switch to using git-rev-list --stdin
      svnimport: add support for parsing From: lines for author
      add proper dependancies on the xdiff source

Aneesh Kumar K.V (4):
      gitweb: Support for snapshot
      gitweb: fix snapshot support
      gitweb: Make blame and snapshot a feature.
      gitweb: Fix git_blame

Art Haas (1):
      Patch for http-fetch.c and older curl releases

Christian Couder (9):
      Trace into open fd and refactor tracing code.
      Trace into a file or an open fd and refactor tracing code.
      Update GIT_TRACE documentation.
      Fix memory leak in prepend_to_path (git.c).
      Move add_to_string to "quote.c" and make it extern.
      Fix a memory leak in "connect.c" and die if command too long.
      Fix space in string " false" problem in "trace.c".
      Remove empty ref directories that prevent creating a ref.
      Fix tracing when GIT_TRACE is set to an empty string.

David Rientjes (18):
      blame.c return cleanup
      builtin-grep.c cleanup
      builtin-push.c cleanup
      diff.c cleanup
      http-push.c cleanup
      read-cache.c cleanup
      Make pprint_tag void and cleans up call in cmd_cat_file.
      Make show_entry void
      Make checkout_all void.
      Make fsck_dir void.
      Make pack_objects void.
      Make track_tree_refs void.
      Make upload_pack void and remove conditional return.
      Make sha1flush void and remove conditional return.
      make inline is_null_sha1 global
      use appropriate typedefs
      remove unnecessary initializations
      Do not use memcmp(sha1_1, sha1_2, 20) with hardcoded length.

Dennis Stosberg (12):
      "test" in Solaris' /bin/sh does not support -e
      Makefile fix for Solaris
      Add possibility to pass CFLAGS and LDFLAGS specific to the perl s=
ubdir
      Solaris has strlcpy() at least since version 8
      Look for sockaddr_storage in sys/socket.h
      Fix detection of ipv6 on Solaris
      Fix compilation with Sun CC
      gitweb: Use --git-dir parameter instead of setting $ENV{'GIT_DIR'=
}
      gitweb: Remove forgotten call to git_to_hash
      use do() instead of require() to include configuration
      lock_ref_sha1_basic does not remove empty directories on BSD
      Add default values for --window and --depth to the docs

Dmitry V. Levin (3):
      Make count-objects, describe and merge-tree work in subdirectory
      Documentation: Fix broken links
      Handle invalid argc gently

Eric Wong (13):
      pass DESTDIR to the generated perl/Makefile
      git-svn: establish new connections on commit after fork
      git-svn: recommend rebase for syncing against an SVN repo
      git-svn: add the 'dcommit' command
      git-svn: stop repeatedly reusing the first commit message with dc=
ommit
      git-svn: multi-init saves and reuses --tags and --branches argume=
nts
      git-svn: log command fixes
      Documentation/git-svn: document some of the newer features
      git-svn: -h(elp) message formatting fixes
      commit: fix a segfault when displaying a commit with unreachable =
parents
      git-svn: add a message encouraging use of SVN::* libraries
      git-svn: fix commits over svn+ssh://
      git-svn: reduce memory usage for large commits

=46ranck Bui-Huu (11):
      Add a newline before appending "Signed-off-by: " line
      log-tree.c: cleanup a bit append_signoff()
      Add git-archive
      git-archive: wire up TAR format.
      git-archive: wire up ZIP format.
      Add git-upload-archive
      connect.c: finish_connect(): allow null pid parameter
      Test return value of finish_connect()
      upload-archive: monitor child communication even more carefully.
      git-archive: update documentation
      Add git-upload-archive to the main git man page

Haavard Skinnemoen (1):
      git-send-email: Don't set author_not_sender from Cc: lines

Jakub Narebski (139):
      gitweb: whitespace cleanup
      gitweb: Use list for of open for running git commands, thorougly.
      gitweb: simplify git_get_hash_by_path
      gitweb: More explicit error messages for open "-|"
      gitweb: Cleanup - chomp $line in consistent style
      gitweb: Cleanup - chomp @lines in consistent style
      gitweb: Add git_page_nav for later use
      gitweb: Navbar refactoring - use git_page_nav to generate navigat=
ion bar
      gitweb: Replace form-feed character by ^L
      gitweb: Show project descriptions with utf-8 characters in projec=
t list correctly
      gitweb: Add "\n" after <br/> in git_page_nav
      gitweb: Pager refactoring - use git_get_paging_nav for pagination
      gitweb: Remove $project from git_get_paging_nav arguments
      gitweb: Headers refactoring - use git_header_div for header divs
      gitweb: Remove characters entities entirely when shortening strin=
g
      gitweb: Ref refactoring - use git_get_referencing for marking tag=
ged/head commits
      gitweb: Refactor generation of shortlog, tags and heads body
      gitweb: do not quote path for list version of open "-|"
      gitweb: Remove characters entities entirely when shortening strin=
g -- correction
      gitweb: Reordering code and dividing it into categories
      gitweb: Refactoring git_project_list
      autoconf: Add support for setting SHELL_PATH and PERL_PATH
      autoconf: Move site configuration section earlier in configure.ac
      autoconf: Add support for setting PYTHON_PATH or NO_PYTHON
      autoconf: Check for ll hh j z t size specifiers introduced by C99
      autoconf: Typo cleanup, reordering etc.
      Copy description of new build configuration variables to configur=
e.ac
      autoconf: Set NEEDS_LIBICONV unconditionally if there is no iconv=
 in libc
      gitweb: Separate input validation and dispatch, add comment about=
 opml action
      gitweb: die_error first (optional) parameter is HTTP status
      gitweb: Use undef for die_error to use default first (status) par=
ameter value
      gitweb: Don't undefine query parameter related variables before d=
ie_error
      gitweb: Cleanup and uniquify error messages
      gitweb: No periods for error messages
      gitweb: No error messages with unescaped/unprotected user input
      gitweb: PATH_INFO=3D/ means no project
      gitweb: Inline $rss_link
      gitweb: Refactor untabifying - converting tabs to spaces
      gitweb: fix commitdiff for root commits
      gitweb: Skip nonmatching lines in difftree output, consistently
      autoconf: Unset NO_STH and NEED_STH when it is detected not neede=
d
      gitweb: Remove unused variables in git_shortlog_body and git_head=
s
      autoconf: Add configure target to main Makefile
      autoconf: Error out on --without-shell and --without-perl
      autoconf: Improvements in NO_PYTHON/PYTHON_PATH handling
      autoconf: Move variables which we always set to config.mak.in
      autoconf: It is --without-python, not --no-python
      autoconf: Add support for setting CURLDIR, OPENSSLDIR, EXPATDIR
      gitweb: Whitespace cleanup - tabs are for indent, spaces are for =
align
      gitweb: Great subroutines renaming
      gitweb: Separate ref parsing in git_get_refs_list into parse_ref
      gitweb: Refactor printing shortened title in git_shortlog_body an=
d git_tags_body
      gitweb: Separate main part of git_history into git_history_body
      gitweb: Separate finding project owner into git_get_project_owner
      gitweb: Change appereance of marker of refs pointing to given obj=
ect
      gitweb: Skip comments in mime.types like file
      gitweb: True fix: Support for the standard mime.types map in gitw=
eb
      gitweb: Separate printing difftree in git_commit into git_difftre=
e_body
      gitweb: Show project's git URL on summary page
      gitweb: Add support for per project git URLs
      gitweb: Uniquify version info output, add meta generator in page =
header
      gitweb: Refactor printing commit message
      gitweb: Added parse_difftree_raw_line function for later use
      gitweb: Use parse_difftree_raw_line in git_difftree_body
      gitweb: bugfix: a.list formatting regression
      gitweb: Replace some presentational HTML by CSS
      gitweb: Whitespace cleanup: realign, reindent
      gitweb: Use underscore instead of hyphen to separate words in HTT=
P headers names
      gitweb: Route rest of action subroutines through %actions
      gitweb: Use here-doc
      gitweb: Drop the href() params which keys are not in %mapping
      gitweb: Sort CGI parameters returned by href()
      gitweb: Use git-diff-tree patch output for commitdiff
      gitweb: Show information about incomplete lines in commitdiff
      gitweb: Remove invalid comment in format_diff_line
      gitweb: Streamify patch output in git_commitdiff
      gitweb: Add git_get_{following,preceding}_references functions
      gitweb: Faster return from git_get_preceding_references if possib=
le
      gitweb: Add git_get_rev_name_tags function
      gitweb: Use git_get_name_rev_tags for commitdiff_plain X-Git-Tag:=
 header
      gitweb: Add support for hash_parent_base parameter for blobdiffs
      gitweb: Allow for pre-parsed difftree info in git_patchset_body
      gitweb: Parse two-line from-file/to-file diff header in git_patch=
set_body
      gitweb: Add invisible hyperlink to from-file/to-file diff header
      gitweb: Always display link to blobdiff_plain in git_blobdiff
      gitweb: Change here-doc back for style consistency in git_blobdif=
f
      gitweb: Use git-diff-tree or git-diff patch output for blobdiff
      gitweb: git_blobdiff_plain is git_blobdiff('plain')
      gitweb: Remove git_diff_print subroutine
      gitweb: Remove creating directory for temporary files
      gitweb: git_annotate didn't expect negative numeric timezone
      gitweb: Remove workaround for git-diff bug fixed in f82cd3c
      gitweb: Improve comments about gitweb features configuration
      gitweb: blobs defined by non-textual hash ids can be cached
      gitweb: Fix typo in git_difftree_body
      gitweb: Fix typo in git_patchset_body
      gitweb: Remove unused git_get_{preceding,following}_references
      gitweb: Remove git_to_hash function
      gitweb: Use @diff_opts, default ('M'), as git-diff and git-diff-t=
ree paramete
      gitweb: Make git_print_log generic; git_print_simplified_log uses=
 it
      gitweb: Do not remove signoff lines in git_print_simplified_log
      gitweb: Add author information to commitdiff view
      gitweb: git_print_log: signoff line is non-empty line
      gitweb: Add diff tree, with links to patches, to commitdiff view
      gitweb: Add local time and timezone to git_print_authorship
      gitweb: Move git-ls-tree output parsing to parse_ls_tree_line
      gitweb: Separate printing of git_tree row into git_print_tree_ent=
ry
      gitweb: Extend parse_difftree_raw_line to save commit info
      gitweb: Change the name of diff to parent link in "commit" view t=
o "diff
      gitweb: Add GIT favicon, assuming image/png type
      gitweb: Correct typo: '=3D=3D' instead of 'eq' in git_difftree_bo=
dy
      gitweb: Divide page path into directories -- path's "breadcrumbs"
      autoconf: Add -liconv to LIBS when NEEDS_LIBICONV
      autoconf: Check for subprocess.py
      autoconf: Quote AC_CACHE_CHECK arguments
      autoconf: Fix copy'n'paste error
      autoconf: Set NO_ICONV if iconv is found neither in libc, nor in =
libiconv
      autoconf: Add support for setting NO_ICONV and ICONVDIR
      autoconf: Add config.cache to .gitignore
      gitweb: Make pickaxe search a feature
      gitweb: Paginate history output
      gitweb: Use File::Find::find in git_get_projects_list
      gitweb: Do not parse refs by hand, use git-peek-remote instead
      gitweb: Add git_project_index for generating index.aux
      gitweb: Allow for href() to be used for links without project par=
am
      gitweb: Add link to "project_index" view to "project_list" page
      gitweb: Fix mimetype_guess_file for files with multiple extension=
s
      gitweb: Even more support for PATH_INFO based URLs
      gitweb: Require project for almost all actions
      gitweb: Always use git-peek-remote in git_get_references
      gitweb: Make git_get_refs_list do work of git_get_references
      gitweb: Fix thinko in git_tags and git_heads
      gitweb: Make git_get_hash_by_path check type if provided
      gitweb: Strip trailing slashes from $path in git_get_hash_by_path
      gitweb: Use "return" instead of "return undef" for some subs
      gitweb: Split validate_input into validate_pathname and validate_=
refname
      gitweb: Add git_url subroutine, and use it to quote full URLs
      gitweb: Quote filename in HTTP Content-Disposition: header
      gitweb: Cleanup Git logo and Git logo target generation

Jeff King (9):
      gitweb: optionally read config from GITWEB_CONFIG
      diff: support custom callbacks for output
      Move color option parsing out of diff.c and into color.[ch]
      git-commit.sh: convert run_status to a C builtin
      git-status: document colorization config options
      contrib/vim: add syntax highlighting file for commits
      wt-status: remove extraneous newline from 'deleted:' output
      rev-list: fix segfault with --{author,committer,grep}
      git-repack: allow git-repack to run in subdirectory

Johannes Schindelin (38):
      Git.xs: older perl do not know const char *
      Status update on merge-recursive in C
      Cumulative update of merge-recursive in C
      merge-recur: Convert variable names to lower_case
      merge-recur: Get rid of debug code
      merge-recur: Remove dead code
      merge-recur: Fix compiler warning with -pedantic
      merge-recur: Cleanup last mixedCase variables...
      merge-recur: Explain why sha_eq() and struct stage_data cannot go
      merge-recur: fix thinko in unique_path()
      read-trees: refactor the unpack_trees() part
      read-tree: move merge functions to the library
      merge-recur: use the unpack_trees() interface instead of exec()in=
g read-tree
      merge-recur: virtual commits shall never be parsed
      merge-recursive: fix rename handling
      http-push: avoid fork() by calling merge_bases() directly
      merge-recur: do not call git-write-tree
      merge-recur: do not setenv("GIT_INDEX_FILE")
      merge-recur: if there is no common ancestor, fake empty one
      merge-recur: try to merge older merge bases first
      merge-recur: do not die unnecessarily
      discard_cache(): discard index, even if no file was mmap()ed
      Add the --color-words option to the diff options family
      builtin-mv: readability patch
      unpack-objects: remove unused variable "eof"
      Makefile: fix typo
      Remove uneeded #include
      fmt-merge-msg: fix off-by-one bug
      Teach runstatus about --untracked
      add receive.denyNonFastforwards config variable
      receive-pack: plug memory leak in fast-forward checking code.
      Document receive.denyNonFastforwards
      runstatus: do not recurse into subdirectories if not needed
      daemon: default to 256 for HOST_NAME_MAX if it is not defined
      diff --stat: ensure at least one '-' for deletions, and one '+' f=
or additions
      diff: fix 2 whitespace issues
      cvsserver: Show correct letters for modified, removed and added f=
iles
      cvsserver: fix "cvs diff" in a subdirectory

Jon Loeliger (3):
      Add virtualization support to git-daemon
      Cleaned up git-daemon virtual hosting support.
      Removed memory leaks from interpolation table uses.

Jonas Fonseca (21):
      git-apply(1): document missing options and improve existing ones
      git-ls-remote(1): document --upload-pack
      git-blame(1): mention options in the synopsis and advertise picka=
xe
      gitk(1): expand the manpage to look less like a template
      git(7): put the synopsis in a verse style paragraph
      gitview.txt: improve asciidoc markup
      git-svn(1): improve asciidoc markup
      describe: fix off-by-one error in --abbrev=3D40 handling
      Use PATH_MAX instead of MAXPATHLEN
      Use xrealloc instead of realloc
      Use fstat instead of fseek
      Use xcalloc instead of calloc
      Add --relative-date option to the revision interface
      git(7): move gitk(1) to the list of porcelain commands
      Use xmalloc instead of malloc
      Include config.mak.autogen in the doc Makefile
      git-rev-list(1): group options; reformat; document more options
      git-apply(1): document --unidiff-zero
      git-repack(1): document --window and --depth
      Fix trivial typos and inconsistencies in hooks documentation
      gitk(1): mention --all

Junio C Hamano (139):
      Perl interface: add build-time configuration to allow building wi=
th -fPIC
      Perl interface: make testsuite work again.
      perl: fix make clean
      Git.pm: tentative fix to test the freshly built Git.pm
      Perly Git: arrange include path settings properly.
      Makefile: Set USE_PIC on x86-64
      Perly git: work around buggy make implementations.
      Git.pm: clean generated files.
      Perly Git: make sure we do test the freshly built one.
      INSTALL: a tip for running after building but without installing.
      Work around sed and make interactions on the backslash at the end=
 of line.
      upload-pack: use object pointer not copy of sha1 to keep track of=
 has/needs.
      upload-pack: lift MAX_NEEDS and MAX_HAS limitation
      recur vs recursive: help testing without touching too many stuff.
      sha1_file.c: expose map_sha1_file() interface.
      pack-objects: reuse deflated data from new-style loose objects.
      unpack-objects: read configuration data upon startup.
      Makefile: git-merge-recur depends on xdiff libraries.
      gitweb: There can be more than two levels of subdirectories
      gitweb: an obvious cut and paste error.
      gitweb: fix use of uninitialized value.
      gitweb: when showing history of a tree, show tree link not blob
      gitweb: avoid undefined value warning in print_page_path
      gitweb/README: do not bug Kay with gitweb questions anymore
      Makefile: gitweb/gitweb.cgi is now generated.
      gitweb: do not use @@FOO@@ for replaced tokens
      .gitignore: git-merge-recur is a built file.
      Make git-checkout-index a builtin
      builtins: Makefile clean-up
      git.c: Rename NEEDS_PREFIX to RUN_SETUP
      autoconf: fix NEEDS_SSL_WITH_CRYPTO
      autoconf: NO_IPV6
      Racy git: avoid having to be always too careful
      read-cache: tweak racy-git delay logic
      autoconf: clean temporary file mak.append
      git-grep: show pathnames relative to the current directory
      upload-pack: minor clean-up in multi-ack logic
      Fix type of combine-diff.c::show_patch_diff()
      Remove combine-diff.c::uninteresting()
      t4116 apply --reverse test
      git-apply --reverse: simplify reverse option.
      git-apply --binary: clean up and prepare for --reverse
      avoid nanosleep(2)
      Documentation/technical/racy-git.txt
      Add check program "git-check-racy"
      Remove the "delay writing to avoid runtime penalty of racy-git av=
oidance"
      builtin-grep: remove unused debugging cruft.
      builtin-apply --reverse: two bugfixes.
      diff.c: make binary patch reversible.
      apply --reverse: tie it all together.
      git-apply --reject
      git-apply --reject: send rejects to .rej files.
      git-apply --verbose
      apply --reject: count hunks starting from 1, not 0
      Convert memset(hash,0,20) to hashclr(hash).
      hashcpy/hashcmp remaining bits.
      builtin-grep.c: remove unused debugging piece.
      update-index -g
      git-apply --reject: finishing touches.
      free(NULL) is perfectly valid.
      daemon: prepare for multiple services.
      daemon: add upload-tar service.
      multi-service daemon: documentation
      t5710: fix two thinkos.
      Constness tightening for move/link_temp_to_file()
      consolidate two copies of new style object header parsing code.
      pack-objects: re-validate data we copy from elsewhere.
      Revert "Convert git-annotate to use Git.pm"
      Revert "Git.pm: Introduce fast get_object() method"
      Revert "Make it possible to set up libgit directly (instead of fr=
om the environment)"
      pack-objects: fix thinko in revalidate code
      more lightweight revalidation while reusing deflated stream in pa=
cking
      unpack-objects desperately salvages objects from a corrupt pack
      revision.c: allow injecting revision parameters after setup_revis=
ions().
      Teach rev-list an option to read revs from the standard input.
      Revert "daemon: add upload-tar service."
      Make apply --binary a no-op.
      diff --binary generates full index on binary files.
      Separate object listing routines out of rev-list
      pack-objects: run rev-list equivalent internally.
      pack-objects: further work on internal rev-list logic.
      pack-objects --unpacked=3D<existing pack> option.
      get_sha1_hex() micro-optimization
      archive: allow remote to have more formats than we understand.
      Move sideband client side support into reusable form.
      Move sideband server side support into reusable form.
      archive: force line buffered output to stderr
      Add --verbose to git-archive
      Teach --exec to git-archive --remote
      Prepare larger packet buffer for upload-pack protocol.
      Add sideband status report to git-archive protocol
      upload-archive: monitor child communication more carefully.
      builtin-archive.c: rename remote_request() to extract_remote_arg(=
)
      pack-objects: document --revs, --unpacked and --all.
      http-fetch: fix alternates handling.
      unpack-objects -r: call it "recover".
      Document git-grep -[Hh]
      Define fallback PATH_MAX on systems that do not define one in <li=
mits.h>
      Fix git-am safety checks
      http-fetch.c: consolidate code to detect missing fetch target
      Add ftp:// protocol support for git-http-fetch
      t1400: make test debuggable.
      apply --unidiff-zero: loosen sanity checks for --unidiff=3D0 patc=
hes
      builtin-grep: make pieces of it available as library.
      revision traversal: prepare for commit log match.
      revision traversal: --author, --committer, and --grep.
      repack: use only pack-objects, not rev-list.
      Update grep internal for grepping only in head/body
      git log: Unify header_filter and message_filter into one.
      Make hexval() available to others.
      sha1_name.c: understand "describe" output as a valid object name
      diff.c: second war on whitespace.
      git-apply: second war on whitespace.
      Add t5510 to test per branch configuration affecting git-fetch.
      Remove upload-tar and make git-tar-tree a thin wrapper to git-arc=
hive
      Deprecate merge-recursive.py
      diff --stat: allow custom diffstat output width.
      diff --stat: color output.
      An illustration of rev-list --parents --pretty=3Draw
      grep: free expressions and patterns when done.
      grep: fix --fixed-strings combined with expression.
      Contributed bash completion support for core Git tools.
      git-diff -B output fix.
      Remove -fPIC which was only needed for Git.xs
      GIT 1.4.3-rc1
      Makefile: install and clean merge-recur, still.
      escape tilde in Documentation/git-rev-parse.txt
      tar-tree deprecation: we eat our own dog food.
      gitweb: Make the Git logo link target to point to the homepage
      git-send-email: avoid uninitialized variable warning.
      cherry-pick: make -r the default
      Add WEBDAV timeout to http-fetch.
      Fix git-revert
      git-fetch --update-head-ok typofix
      git-pull: we say commit X, not X commit.
      git.spec.in: perl subpackage is installed in perl_vendorlib not v=
endorarch
      apply --numstat -z: line termination fix.
      t4015: work-around here document problem on Cygwin.
      Revert "move pack creation to version 3"

Linus Torvalds (10):
      Relative timestamps in git log
      git-fsck-objects: lacking default references should not be fatal
      Fix git-fsck-objects SIGSEGV/divide-by-zero
      Add "-h/-H" parsing to "git grep"
      Allow multiple "git_path()" uses
      git-log --author and --committer are not left-anchored by default
      Clean up approxidate() in preparation for fixes
      Fix approxidate() to understand more extended numbers
      diff --stat=3Dwidth[,name-width]: allow custom diffstat output wi=
dth.
      Fix approxidate() to understand 12:34 AM/PM are 00:34 and 12:34

Liu Yubao (1):
      Fix duplicate xmalloc in builtin-add

Luben Tuikov (22):
      gitweb: git_tree displays blame based on repository config
      gitweb: bugfix: git_commit and git_commitdiff parents
      gitweb: blame table row no highlight fix
      gitweb: bugfix: commitdiff regression
      gitweb: bugfix: git_print_page_path() needs the hash base
      gitweb: tree view: eliminate redundant "blob"
      gitweb: Remove redundant "tree" link
      gitweb: extend blame to show links to diff and previous
      Revert "gitweb: extend blame to show links to diff and previous"
      gitweb: Remove excessively redundant entries from git_difftree_bo=
dy
      gitweb: Add history and blame to git_difftree_body()
      gitweb: "alternate" starts with shade (i.e. 1)
      gitweb: Remove redundant "commit" link from shortlog
      gitweb: Factor out gitweb_have_snapshot()
      gitweb: Add snapshot to shortlog
      gitweb: Don't use quotemeta on internally generated strings
      gitweb: Remove redundant "commit" from history
      gitweb: History: blob and tree are first, then commitdiff, etc
      gitweb: tree view: hash_base and hash are now context sensitive
      gitweb: Escape ESCAPE (\e) character
      gitweb: Do not print "log" and "shortlog" redundantly in commit v=
iew
      gitweb: blame: Minimize vertical table row padding

Markus Amsler (1):
      git-imap-send: Strip smtp From_ header from imap message.

Martin Langhoff (1):
      git-repack: create new packs inside $GIT_DIR, not cwd

Martin Waitz (16):
      gitweb: fill in gitweb configuration by Makefile
      gitweb: use out-of-line GIT logo.
      gitweb: provide function to format the URL for an action link.
      gitweb: consolidate action URL generation.
      gitweb: continue consolidation of URL generation.
      gitweb: support for "fp" parameter.
      gitweb: support for / as home_link.
      gitweb: fix project list if PATH_INFO=3D=3D"/".
      gitweb: more support for PATH_INFO based URLs
      gitweb: fix uninitialized variable warning.
      gitweb: fix display of trees via PATH_INFO.
      gitweb: document webserver configuration for common gitweb/repo U=
RLs.
      git-commit: cleanup unused function.
      git-commit: fix coding style.
      test-lib: separate individual test better in verbose mode.
      paginate git-diff by default

Matthias Kestenholz (6):
      Make git-name-rev a builtin
      Make git-pack-objects a builtin
      Make git-unpack-objects a builtin
      Make git-symbolic-ref a builtin
      Add gitweb.cgi to .gitignore
      Check if pack directory exists prior to descending into it

Matthias Lederhofer (12):
      pager: environment variable GIT_PAGER to override PAGER
      gitweb: use a hash to lookup the sub for an action
      gitweb: require $ENV{'GITWEB_CONFIG'}
      gitweb: check if HTTP_ACCEPT is really set
      gitweb: fix commitdiff_plain for root commits
      gitweb: fix $project usage
      gitweb: do not use 'No such directory' error message
      gitweb: export options
      gitweb: fix warnings in PATH_INFO code and add export_ok/strict_e=
xport
      gitweb fix validating pg (page) parameter
      format-patch: use cwd as default output directory
      git-format-patch: fix bug using -o in subdirectories

Nicolas Pitre (4):
      move pack creation to version 3
      many cleanups to sha1_file.c
      add commit count options to git-shortlog
      atomic write for sideband remote messages

Paul Mackerras (10):
      gitk: Minor cleanups
      gitk: Recompute ancestor/descendent heads/tags when rereading ref=
s
      gitk: Add a row context-menu item for creating a new branch
      gitk: Add a context menu for heads
      gitk: Fix a couple of buglets in the branch head menu items
      gitk: Add a menu item for cherry-picking commits
      gitk: Update preceding/following tag info when creating a tag
      gitk: Improve responsiveness while reading and layout out the gra=
ph
      gitk: Fix some bugs in the new cherry-picking code
      diff-index --cc shows a 3-way diff between HEAD, index and workin=
g tree.

Pavel Roskin (3):
      Fix probing for already installed Error.pm
      Delete manuals if compiling without docs
      Make perl interface a separate package

Petr Baudis (48):
      Introduce Git.pm (v4)
      Git.pm: Implement Git::exec_path()
      Git.pm: Call external commands using execv_git_cmd()
      Git.pm: Implement Git::version()
      Add Error.pm to the distribution
      Git.pm: Better error handling
      Git.pm: Handle failed commands' output
      Git.pm: Enhance the command_pipe() mechanism
      Git.pm: Implement options for the command interface
      Git.pm: Add support for subdirectories inside of working copies
      Convert git-mv to use Git.pm
      Git.pm: assorted build related fixes.
      Git.pm: Try to support ActiveState output pipe
      Git.pm: Swap hash_object() parameters
      Git.pm: Fix Git->repository("/somewhere/totally/elsewhere")
      Git.pm: Support for perl/ being built by a different compiler
      Git.pm: Remove PerlIO usage from Git.xs
      Git.pm: Avoid ppport.h
      Git.pm: Don't #define around die
      Use $GITPERLLIB instead of $RUNNING_GIT_TESTS and centralize @INC=
 munging
      Git.pm: Add config() method
      Convert git-send-email to use Git.pm
      Git.pm: Introduce ident() and ident_person() methods
      Make it possible to set up libgit directly (instead of from the e=
nvironment)
      Git.pm: Introduce fast get_object() method
      Convert git-annotate to use Git.pm
      Eliminate Scalar::Util usage from private-Error.pm
      Fix showing of path in tree view
      gitweb: Link (HEAD) tree for each project from projects list
      gitweb: More per-view navigation bar links
      gitweb: Link to tree instead of snapshot in shortlog
      gitweb: Link to latest tree from the head line in heads list
      gitweb: Link to associated tree from a particular log item in ful=
l log view
      gitweb: Rename "plain" labels to "raw"
      gitweb: Relabel "head" as "HEAD"
      Make path in tree view look nicer
      gitweb: Fix tree link associated with each commit log entry.
      gitweb: Fix @git_base_url_list usage
      Fix snapshot link in tree view
      Git.pm: Kill Git.xs for now
      Deprecate git-resolve.sh
      gitweb: Consolidate escaping/validation of query string
      gitweb: fix over-eager application of esc_html().
      Show snapshot link in shortlog only if have_snapsho
      gitweb: Separate (new) and (deleted) in commitdiff by a space
      gitweb: Handle commits with empty commit messages more reasonably
      gitweb: [commit view] Do not suppress commitdiff link in root com=
mit
      svnimport: Fix broken tags being generated

Pierre Habouzit (7):
      Fix a comparison bug in diff-delta.c
      avoid to use error that shadows the function name, use err instea=
d.
      git_dir holds pointers to local strings, hence MUST be const.
      missing 'static' keywords
      remove ugly shadowing of loop indexes in subloops.
      use name[len] in switch directly, instead of creating a shadowed =
variable.
      n is in fact unused, and is later shadowed.

Randal L. Schwartz (1):
      builtin-upload-archive.c broken on openbsd

Rene Scharfe (21):
      git-verify-pack: make builtin
      Axe the last ent
      Add write_or_die(), a helper function
      Add git-zip-tree
      git-cherry: remove unused variable
      git-reset: remove unused variable
      Add git-zip-tree to .gitignore
      git-archive: make compression level of ZIP archives configurable
      Use xstrdup instead of strdup in builtin-{tar,zip}-tree.c
      git-archive: inline default_parse_extra()
      git-tar-tree: devolve git-tar-tree into a wrapper for git-archive
      Remove git-zip-tree
      Rename builtin-zip-tree.c to archive-zip.c
      git-tar-tree: Remove duplicate git_config() call
      git-tar-tree: Move code for git-archive --format=3Dtar to archive=
-tar.c
      git-tar-tree: don't RUN_SETUP
      Documentation: add missing second colons and remove a typo
      Add hash_sha1_file()
      Make write_sha1_file_prepare() static
      Make write_sha1_file_prepare() void
      Replace open-coded version of hash_sha1_file()

Robin Rosenberg (3):
      Quote arguments to tr in test-lib
      Make cvsexportcommit remove files.
      Error in test description of t1200-tutorial

Santi B=E9jar (4):
      Fetch: default remote repository from branch properties
      fetch: get the remote branches to merge from the branch propertie=
s
      Add test for the default merges in fetch.
      fetch: Reset remote refs list each time fetch_main is called

Sasha Khapyorsky (3):
      Trivial support for cloning and fetching via ftp://.
      git-svnimport: Parse log message for Signed-off-by: lines
      http/ftp: optionally ask curl to not use EPSV command

Sergey Vlasov (2):
      Documentation: Fix howto/revert-branch-rebase.html generation
      git-svn: Fix fetch --no-ignore-externals with GIT_SVN_NO_LIB=3D1

Shawn Pearce (15):
      Verify we know how to read a pack before trying to using it.
      Remove unnecessary forward declaration of unpack_entry.
      Convert memcpy(a,b,20) to hashcpy(a,b).
      Convert memcpy(a,b,20) to hashcpy(a,b).
      Reorganize/rename unpack_non_delta_entry to unpack_compressed_ent=
ry.
      Reuse compression code in unpack_compressed_entry.
      Cleanup unpack_entry_gently and friends to use type_name array.
      Cleanup unpack_object_header to use only offsets.
      Convert unpack_entry_gently and friends to use offsets.
      Replace uses of strdup with xstrdup.
      Allow 'svn fetch' on '(no date)' revisions in Subversion.
      Allow '(no author)' in git-svn's authors file.
      Ignore executable bit when adding files if filemode=3D0.
      Allow git-checkout when on a non-existant branch.
      Corrected copy-and-paste thinko in ignore executable bit test cas=
e.

Tilman Sauerbeck (2):
      Indentation fix.
      Added support for dropping privileges to git-daemon.

Timo Hirvonen (2):
      --name-only, --name-status, --check and -s are mutually exclusive
      Remove awkward compatibility warts

Ville Skytt=E4 (1):
      Be nicer if git executable is not installed

Yasushi SHOJI (4):
      gitweb: configurable home link string
      gitweb: Decode long title for link tooltips
      gitweb: refactor decode() for utf8 conversion
      clone: the given repository dir should be relative to $PWD
