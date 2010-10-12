From: Miles Bader <miles@gnu.org>
Subject: weird git error
Date: Tue, 12 Oct 2010 23:28:36 +0900
Message-ID: <87bp6z8oyz.fsf@catnip.gol.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 12 16:28:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5fqT-00011H-IK
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 16:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757253Ab0JLO2n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Oct 2010 10:28:43 -0400
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:51966 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500Ab0JLO2m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Oct 2010 10:28:42 -0400
Received: from 218.231.154.125.eo.eaccess.ne.jp ([218.231.154.125] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	id 1P5fqI-0007i1-QK; Tue, 12 Oct 2010 23:28:39 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id ACD39DF8E; Tue, 12 Oct 2010 23:28:37 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158849>

I did a "git pull" from the Emacs git mirror on repo.or.cz, and got a
funny error after it did an auto-gc.  The resulting repo _seems_ fine,
and a subsequent "git fsck" gives no output, so I guess it thinks thing=
s
are fine too...  still... it's disconcerting.

I've attached a log that shows the error.

The complained-about sha1 (803d75e233c8cee53e1a92251999abaa9de67ccc)
actually does seem to be there -- "git show 803d75e233c8cee" outputs a
normal-looking source-file.

This is git version "1.7.1" (from debian testing/unstable).

Thanks,

-Miles


---- Error log (the error is right before the diffstat output) ----

$ git pull
remote: Counting objects: 1070, done.
remote: Compressing objects: 100% (303/303), done.
remote: Total 761 (delta 648), reused 545 (delta 457)
Receiving objects: 100% (761/761), 5.29 MiB | 254 KiB/s, done.
Resolving deltas: 100% (648/648), completed with 110 local objects.
=46rom git://repo.or.cz/emacs
   e7a38db..9825679  emacs-23   -> cz/emacs-23
   9691da3..a0f863f  master     -> cz/master
Updating 9691da3..a0f863f
=46ast-forward
Auto packing the repository for optimum performance. You may also
run "git gc" manually. See "git help gc" for more information.
Counting objects: 876986, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (171111/171111), done.
Writing objects: 100% (876986/876986), done.
Total 876986 (delta 710783), reused 871045 (delta 705262)
Removing duplicate objects: 100% (256/256), done.
error: packfile .git/objects/pack/pack-b396592f312710251577eae8e43eb6d2=
5d5e5e87.pack cannot be accessed
error: unable to find 803d75e233c8cee53e1a92251999abaa9de67ccc
 ChangeLog                                  |   20 +
 INSTALL                                    |   10 +-
 Makefile.in                                |    2 +-
 admin/ChangeLog                            |   10 +
 admin/admin.el                             |   22 +-
 admin/quick-install-emacs                  |    4 +-
 configure                                  |   16 +-
 configure.in                               |   39 +--
 doc/emacs/ChangeLog                        |   50 +++
 doc/emacs/Makefile.in                      |   63 ++--
 doc/emacs/ack.texi                         |    8 -
 doc/emacs/emacs.texi                       |    7 +-
 doc/emacs/emacsver.texi                    |    4 +
 doc/emacs/makefile.w32-in                  |    1 +
 doc/lispintro/ChangeLog                    |   30 ++
 doc/lispintro/Makefile.in                  |   38 +-
 doc/lispref/ChangeLog                      |   54 +++
 doc/lispref/Makefile.in                    |   51 ++-
 doc/lispref/book-spine.texinfo             |    8 +-
 doc/lispref/elisp.texi                     |    6 +-
 doc/lispref/makefile.w32-in                |   10 +-
 doc/lispref/vol1.texi                      |    6 +-
 doc/lispref/vol2.texi                      |    6 +-
 doc/man/ChangeLog                          |    4 +
 doc/man/b2m.1                              |   64 ---
 doc/misc/ChangeLog                         |   60 +++
 doc/misc/Makefile.in                       |  645 +++++++++++++++-----=
--------
 doc/misc/auth.texi                         |   61 +++-
 doc/misc/cl.texi                           |   54 +--
 doc/misc/eudc.texi                         |   36 +--
 doc/misc/faq.texi                          |   11 +-
 doc/misc/gnus.texi                         |   66 +++-
 doc/misc/makefile.w32-in                   |   12 +-
 etc/NEWS                                   |    2 +-
 lib-src/ChangeLog                          |   15 +
 lib-src/Makefile.in                        |   12 +-
 lib-src/b2m.c                              |  318 --------------
 lib-src/b2m.pl                             |  158 -------
 lib-src/emacsclient.c                      |   13 +-
 lib-src/makefile.w32-in                    |    6 -
 lisp/ChangeLog                             |  221 ++++++++++-
 lisp/array.el                              |   46 +-
 lisp/calendar/cal-hebrew.el                |  168 ++++----
 lisp/cedet/ChangeLog                       |   34 ++-
 lisp/cedet/semantic/bovine/c-by.el         |  115 +++---
 lisp/cedet/semantic/bovine/el.el           |    2 +-
 lisp/cedet/semantic/db-typecache.el        |    2 +-
 lisp/cedet/semantic/fw.el                  |    2 +-
 lisp/cedet/semantic/grammar.el             |    2 +-
 lisp/cedet/semantic/imenu.el               |    2 +-
 lisp/cedet/semantic/lex-spp.el             |   33 ++
 lisp/cedet/semantic/mru-bookmark.el        |   12 +
 lisp/cedet/semantic/tag.el                 |    3 +-
 lisp/cus-edit.el                           |  518 ++++++++++++--------=
--
 lisp/cus-theme.el                          |  259 +++++++-----
 lisp/custom.el                             |  166 +++++---
 lisp/dired.el                              |    2 +-
 lisp/dnd.el                                |    9 +-
 lisp/edmacro.el                            |   10 +-
 lisp/emacs-lisp/authors.el                 |    2 +-
 lisp/emacs-lisp/chart.el                   |    6 +-
 lisp/emacs-lisp/edebug.el                  |   22 +-
 lisp/emacs-lisp/shadow.el                  |   15 +-
 lisp/emulation/ws-mode.el                  |  300 +++++++-------
 lisp/epa-file.el                           |    5 +-
 lisp/epa.el                                |    9 +-
 lisp/erc/ChangeLog                         |    4 +
 lisp/erc/erc-list.el                       |   21 +-
 lisp/gnus/ChangeLog                        |  167 +++++++
 lisp/gnus/auth-source.el                   |    5 +-
 lisp/gnus/gnus-art.el                      |    4 +-
 lisp/gnus/gnus-demon.el                    |    2 +-
 lisp/gnus/gnus-gravatar.el                 |   21 +-
 lisp/gnus/gnus-group.el                    |    5 +-
 lisp/gnus/gnus-int.el                      |    1 +
 lisp/gnus/gnus-msg.el                      |    2 +-
 lisp/gnus/gnus-registry.el                 |   22 +-
 lisp/gnus/gnus-start.el                    |    1 +
 lisp/gnus/gnus-sum.el                      |   30 +-
 lisp/gnus/gnus-topic.el                    |    2 +
 lisp/gnus/gnus-util.el                     |    5 +-
 lisp/gnus/gnus.el                          |   42 ++-
 lisp/gnus/mm-decode.el                     |   10 +-
 lisp/gnus/nndoc.el                         |    2 +-
 lisp/gnus/nnimap.el                        |  450 +++++++++++++-------
 lisp/gnus/nnir.el                          |   89 +++--
 lisp/gnus/nnmail.el                        |    2 +-
 lisp/gnus/nnregistry.el                    |    3 +-
 lisp/gnus/nnweb.el                         |    2 +-
 lisp/gnus/shr.el                           |  131 ++++--
 lisp/gnus/spam.el                          |    3 +-
 lisp/hexl.el                               |  188 ++++----
 lisp/hilit-chg.el                          |   25 +-
 lisp/htmlfontify.el                        |    8 +-
 lisp/ibuffer.el                            |    7 +-
 lisp/image.el                              |   15 +-
 lisp/mail/mspools.el                       |   26 +-
 lisp/minibuffer.el                         |  129 ++++---
 lisp/net/browse-url.el                     |   21 +-
 lisp/net/dig.el                            |   11 +-
 lisp/net/eudc-hotlist.el                   |   21 +-
 lisp/net/mairix.el                         |   32 +-
 lisp/net/quickurl.el                       |   30 +-
 lisp/net/telnet.el                         |   20 +-
 lisp/{emacs-lisp =3D> obsolete}/cl-compat.el |    9 +-
 lisp/{emacs-lisp =3D> obsolete}/lmenu.el     |    8 +-
 lisp/play/5x5.el                           |   10 +-
 lisp/play/decipher.el                      |   61 ++--
 lisp/play/landmark.el                      |   88 ++--
 lisp/play/mpuz.el                          |   51 ++--
 lisp/progmodes/cc-engine.el                |  128 ++++--
 lisp/progmodes/cc-fonts.el                 |  299 +++++++++-----
 lisp/progmodes/cc-langs.el                 |   15 +
 lisp/progmodes/inf-lisp.el                 |   24 +-
 lisp/progmodes/modula2.el                  |    8 +-
 lisp/server.el                             |    2 +-
 lisp/shell.el                              |   39 +-
 lisp/startup.el                            |   32 +-
 lisp/vc/ediff-diff.el                      |   16 +-
 lisp/vc/ediff-ptch.el                      |    8 +-
 lisp/vc/ediff-wind.el                      |   17 +-
 lisp/vc/log-view.el                        |    1 +
 lisp/vc/vc-svn.el                          |    2 +-
 lisp/wid-edit.el                           |   61 ++--
 make-dist                                  |    4 +-
 msdos/ChangeLog                            |   17 +-
 msdos/mainmake.v2                          |    3 +-
 msdos/sed1v2.inp                           |    1 -
 msdos/sed3v2.inp                           |    1 -
 src/ChangeLog                              |  101 +++++
 src/Makefile.in                            |  343 ++++++++--------
 src/buffer.c                               |   10 +-
 src/callproc.c                             |   21 +-
 src/coding.c                               |   48 ++-
 src/coding.h                               |    1 +
 src/config.in                              |   14 +-
 src/dbusbind.c                             |   10 +-
 src/gnutls.c                               |   26 +-
 src/process.c                              |   36 ++-
 src/sysdep.c                               |    9 +-
 src/termcap.c                              |   25 --
 src/unexaix.c                              |   12 -
 src/unexelf.c                              |   12 +-
 src/unexhp9k800.c                          |    5 -
 src/vm-limit.c                             |    3 -
 src/xfont.c                                |    2 +-
 src/xterm.c                                |   68 +++-
 147 files changed, 4040 insertions(+), 3137 deletions(-)
 create mode 100644 doc/emacs/emacsver.texi
 delete mode 100644 doc/man/b2m.1
 delete mode 100644 lib-src/b2m.c
 delete mode 100644 lib-src/b2m.pl
 rename lisp/{emacs-lisp =3D> obsolete}/cl-compat.el (97%)
 rename lisp/{emacs-lisp =3D> obsolete}/lmenu.el (99%)
$ ls -l .git/objects/pack/pack-b396592f312710251577eae8e43eb6d25d5e5e87=
=2Epack
ls: cannot access .git/objects/pack/pack-b396592f312710251577eae8e43eb6=
d25d5e5e87.pack: =E3=81=9D=E3=81=AE=E3=82=88=E3=81=86=E3=81=AA=E3=83=95=
=E3=82=A1=E3=82=A4=E3=83=AB=E3=82=84=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=
=E3=83=88=E3=83=AA=E3=81=AF=E3=81=82=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93
$ ls -l .git/objects/pack/
=E5=90=88=E8=A8=88 342816
-r--r--r-- 1 miles staff  24556680 2010-10-12 22:31 pack-13ddf27a64f8dc=
0237787f463d603e13d7a8deb5.idx
-r--r--r-- 1 miles staff 326131222 2010-10-12 22:31 pack-13ddf27a64f8dc=
0237787f463d603e13d7a8deb5.pack
$ git fsck
$ git show 803d75e233c8cee53e1a92251999abaa9de67ccc
/*
 * b2m - a filter for Babyl -> Unix mail files
 * The copyright on this file has been disclaimed.
 *
 * usage:       b2m < babyl > mailbox
 *
 * I find this useful whenever I have to use a
=2E..


--=20
"Don't just question authority,
Don't forget to question me."
-- Jello Biafra
