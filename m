From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.2.3
Date: Sun, 12 Apr 2009 19:50:26 -0700
Message-ID: <7v1vrxxo5p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 04:52:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtCHG-0002BD-AX
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 04:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754251AbZDMCuh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Apr 2009 22:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754124AbZDMCug
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 22:50:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60927 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754010AbZDMCuf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Apr 2009 22:50:35 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 38998A9409;
	Sun, 12 Apr 2009 22:50:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 58B33A9404; Sun,
 12 Apr 2009 22:50:28 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DC1CC3FC-27D5-11DE-B773-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116403>

The latest maintenance release GIT 1.6.2.3 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.2.3.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.2.3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.2.3.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.6.2.3-1.fc9.$arch.rpm	(RPM)

----------------------------------------------------------------

GIT v1.6.2.3 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.6.2.2
--------------------

* Setting an octal mode value to core.sharedrepository configuration to
  restrict access to the repository to group members did not work as
  advertised.

* A fairly large and trivial memory leak while rev-list shows list of
  reachable objects has been identified and plugged.

* "git-commit --interactive" did not abort when underlying "git-add -i"
  signaled a failure.

* git-repack (invoked from git-gc) did not work as nicely as it should =
in
  a repository that borrows objects from neighbours via alternates
  mechanism especially when some packs are marked with the ".keep" flag
  to prevent them from being repacked.

Many small documentation updates are included as well.

----------------------------------------------------------------

Changes since v1.6.2.2 are as follows:

Bj=C3=B6rn Steinbrink (1):
      process_{tree,blob}: Remove useless xstrdup calls

Brandon Casey (6):
      t7700-repack: add two new tests demonstrating repacking flaws
      git-repack.sh: don't use --kept-pack-only option to pack-objects
      pack-objects: only repack or loosen objects residing in "local" p=
acks
      Remove --kept-pack-only option and associated infrastructure
      t7700: demonstrate repack flaw which may loosen objects unnecessa=
rily
      pack-objects: don't loosen objects available in alternate or kept=
 packs

Dan McGee (1):
      git-repack: use non-dashed update-server-info

Daniel Cheng (aka SDiZ) (1):
      State the effect of filter-branch on graft explicitly

Jari Aalto (1):
      Change double quotes to single quotes in message

Jason Merrill (1):
      Documentation: clarify .gitattributes search

Jeff King (2):
      t1301: loosen test for forced modes
      commit: abort commit if interactive add failed

Johan Herland (1):
      Move chmod(foo, 0444) into move_temp_to_file()

Julien Danjou (1):
      git submodule: fix usage line

Junio C Hamano (12):
      git-repack: resist stray environment variable
      has_sha1_pack(): refactor "pretend these packs do not exist" inte=
rface
      has_sha1_kept_pack(): take "struct rev_info"
      Consolidate ignore_packed logic more
      Simplify is_kept_pack()
      is_kept_pack(): final clean-up
      diff --cached: do not borrow from a work tree when a path is mark=
ed as assume-unchanged
      "core.sharedrepository =3D 0mode" should set, not loosen
      move_temp_to_file(): do not forget to chmod() in "Coda hack" code=
path
      set_shared_perm(): sometimes we know what the final mode bits sho=
uld look like
      Start 1.6.2.3 preparation
      GIT 1.6.2.3

Linus Torvalds (1):
      process_{tree,blob}: Remove useless xstrdup calls

Markus Heidelberg (1):
      doc/git-pack-refs: fix two grammar issues

Matthieu Moy (3):
      git-checkout.txt: fix incorrect statement about HEAD and index
      git-checkout.txt: clarify that <branch> applies when no path is g=
iven.
      git-pull.sh: better warning message for "git pull" on detached he=
ad.
