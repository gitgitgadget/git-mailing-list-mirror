From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.5.4.2
Date: Sun, 17 Feb 2008 01:14:54 -0800
Message-ID: <7vfxvs2bch.fsf@gitster.siamese.dyndns.org>
References: <7vodapgk9s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 10:15:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQfcl-0005zl-2s
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 10:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364AbYBQJPQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Feb 2008 04:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753987AbYBQJPP
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 04:15:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33791 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793AbYBQJPK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Feb 2008 04:15:10 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A3684E6E;
	Sun, 17 Feb 2008 04:15:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 337944E6D; Sun, 17 Feb 2008 04:15:02 -0500 (EST)
In-Reply-To: <7vodapgk9s.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 10 Feb 2008 02:47:59 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74107>

The latest maintenance release GIT 1.5.4.2 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.4.2.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.4.2.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.4.2.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.4.2-1.$arch.rpm	(RPM)

----------------------------------------------------------------

GIT v1.5.4.2 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.5.4
------------------

 * The configuration parser was not prepared to see string
   valued variables misspelled as boolean and segfaulted.

 * Temporary files left behind due to interrupted object
   transfers were not cleaned up with "git prune".

 * "git config --unset" was confused when the unset variables
   were spelled with continuation lines in the config file.

 * The merge message detection in "git cvsimport" did not catch
   a message that began with "Merge...".

 * "git status" suggests "git rm --cached" for unstaging the
   earlier "git add" before the initial commit.

 * "git status" output was incorrect during a partial commit.

 * "git bisect" refused to start when the HEAD was detached.

 * "git bisect" allowed a wildcard character in the commit
   message expanded while writing its log file.

 * Manual pages were not formatted correctly with docbook xsl
   1.72; added a workaround.

 * "git-commit -C $tag" used to work but rewrite in C done in
   1.5.4 broke it.  This was fixed in 1.5.4.1.

 * An entry in the .gitattributes file that names a pattern in a
   subdirectory of the directory it is in did not match
   correctly (e.g. pattern "b/*.c" in "a/.gitattributes" should
   match "a/b/foo.c" but it didn't).  This was fixed in 1.5.4.1.

 * Customized color specification was parsed incorrectly when
   numeric color values are used.  This was fixed in 1.5.4.1.

 * http transport misbehaved when linked with curl-gnutls.

----------------------------------------------------------------

Changes since v1.5.4.1 are as follows:

Christian Couder (8):
      config: add test cases for empty value and no value config variab=
les.
      diff.c: replace a 'strdup' with 'xstrdup'.
      diff.c: remove useless check for value !=3D NULL
      config: add 'git_config_string' to refactor string config variabl=
es.
      Add "const" qualifier to "char *pager_program".
      Add "const" qualifier to "char *editor_program".
      Add "const" qualifier to "char *excludes_file".
      diff.c: add "const" qualifier to "char *cmd" member of "struct ll=
_diff_driver"

Daniel Barkalow (1):
      Validate nicknames of remote branches to prohibit confusing ones

David Steven Tweed (1):
      Make git prune remove temporary packs that look like write failur=
es

=46rank Lichtenheld (1):
      config: Fix --unset for continuation lines

Gerrit Pape (2):
      builtin-commit: remove .git/SQUASH_MSG upon successful commit
      cvsimport: have default merge regex also match beginning of commi=
t message

James Bowes (1):
      Add a BuildRequires for gettext in the spec file.

Jay Soffian (1):
      mailinfo: feed only one line to handle_filter() for QP input

Jeff King (2):
      status: suggest "git rm --cached" to unstage for initial commit
      commit: discard index after setting up partial commit

Johannes Schindelin (3):
      bisect: allow starting with a detached HEAD
      Document that the default of branch.autosetupmerge is true
      bisect: use verbatim commit subject in the bisect log

Johannes Sixt (1):
      upload-pack: Initialize the exec-path.

Jonas Fonseca (1):
      man pages are littered with .ft C and others

Junio C Hamano (31):
      git-pull documentation: fix markup
      archive-tar.c: guard config parser from value=3DNULL
      Add config_error_nonbool() helper function
      builtin-apply.c: guard config parser from value=3DNULL
      builtin-branch.c: guard config parser from value=3DNULL
      builtin-commit.c: guard config parser from value=3DNULL
      builtin-config.c: guard config parser from value=3DNULL
      builtin-log.c: guard config parser from value=3DNULL
      builtin-reflog.c: guard config parser from value=3DNULL
      builtin-show-branch.c: guard config parser from value=3DNULL
      builtin-tag.c: guard config parser from value=3DNULL
      connect.c: guard config parser from value=3DNULL
      convert.c: guard config parser from value=3DNULL
      diff.c: guard config parser from value=3DNULL
      git.c: guard config parser from value=3DNULL
      help.c: guard config parser from value=3DNULL
      http.c: guard config parser from value=3DNULL
      merge-recursive.c: guard config parser from value=3DNULL
      remote.c: guard config parser from value=3DNULL
      setup.c: guard config parser from value=3DNULL
      wt-status.c: guard config parser from value=3DNULL
      imap-send.c: guard config parser from value=3DNULL
      builtin-log.c: guard config parser from value=3DNULL
      config.c: guard config parser from value=3DNULL
      Revert "pack-objects: only throw away data during memory pressure=
"
      Protect get_author_ident_from_commit() from filenames in work tre=
e
      diff.c: fixup garding of config parser from value=3DNULL
      diff: Fix miscounting of --check output
      filter-branch: handle filenames that need quoting
      Documentation/git-reset:
      GIT 1.5.4.2

Martin Koegler (1):
      pack-objects: only throw away data during memory pressure

Mike Hommey (1):
      Work around curl-gnutls not liking to be reinitialized

Miklos Vajna (2):
      builtin-gc.c: guard config parser from value=3DNULL
      git clone -s documentation: force a new paragraph for the NOTE

Pieter de Bie (2):
      Documentation/git-reset: don't mention --mixed for selected-paths=
 reset
      Documentation/git-reset: Add an example of resetting selected pat=
hs

Sergei Organov (1):
      git-cvsimport.txt: fix '-M' description.

Shawn O. Pearce (1):
      fast-import: check return value from unpack_entry()

Stelian Pop (1):
      hg-to-git: fix parent analysis

Uwe Kleine-K=E6=97=A6nig (1):
      rebase -i: accept -m as advertised in the man page
