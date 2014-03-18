From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.9.1
Date: Tue, 18 Mar 2014 15:14:14 -0700
Message-ID: <xmqq38if6top.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Tue Mar 18 23:14:39 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1WQ2HO-0000jJ-40
	for glk-linux-kernel-3@plane.gmane.org; Tue, 18 Mar 2014 23:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757652AbaCRWOV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 18 Mar 2014 18:14:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55269 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751575AbaCRWOT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Mar 2014 18:14:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5361F72412;
	Tue, 18 Mar 2014 18:14:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=xO5wUbzGXKbLtCoyK5U2drIDU
	AI=; b=MUuCi26CE1ukIRz/iY1RHGFIsWTVzVykgzgx1Plgjtkj1O743RiiGluOG
	ZX/DdJQBMClTZsQzj4RQOeuTH2Ql7YFlur0UgoY/wbLnUGMo6dGAWlABWydBXEdg
	CUfulrchReOLv3gE/f2cxQwcuumeavdjr2m+bp3OhxR5sA2nhE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=CyrqqapGOsJWuHOo4ag
	PXZRk2NInb24nSKp02gyQ8LYOmxr1Amodax3Hez3dpuBJAqD12/7sUx5i2tROF1C
	GORmS3pCIViAm/S7ongED7n9BPBz7tco8sYo99VQRBQDfHHevqqQdSNjarPVY17o
	ccUt+rS6cEiD2jN5gF6OxC5o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D3D772411;
	Tue, 18 Mar 2014 18:14:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7BE5F7240E;
	Tue, 18 Mar 2014 18:14:17 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A59A52A8-AEEA-11E3-9686-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244386>

The latest maintenance release Git v1.9.1 is now available at
the usual places.

The release tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the v1.9.1
tag and the maint branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git


Git v1.9.1 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v1.9.0
------------------

 * "git clean -d pathspec" did not use the given pathspec correctly
   and ended up cleaning too much.

 * "git difftool" misbehaved when the repository is bound to the
   working tree with the ".git file" mechanism, where a textual file
   ".git" tells us where it is.

 * "git push" did not pay attention to branch.*.pushremote if it is
   defined earlier than remote.pushdefault; the order of these two
   variables in the configuration file should not matter, but it did
   by mistake.

 * Codepaths that parse timestamps in commit objects have been
   tightened.

 * "git diff --external-diff" incorrectly fed the submodule directory
   in the working tree to the external diff driver when it knew it is
   the same as one of the versions being compared.

 * "git reset" needs to refresh the index when working in a working
   tree (it can also be used to match the index to the HEAD in an
   otherwise bare repository), but it failed to set up the working
   tree properly, causing GIT_WORK_TREE to be ignored.

 * "git check-attr" when working on a repository with a working tree
   did not work well when the working tree was specified via the
   --work-tree (and obviously with --git-dir) option.

 * "merge-recursive" was broken in 1.7.7 era and stopped working in
   an empty (temporary) working tree, when there are renames
   involved.  This has been corrected.

 * "git rev-parse" was loose in rejecting command line arguments
   that do not make sense, e.g. "--default" without the required
   value for that option.

 * include.path variable (or any variable that expects a path that
   can use ~username expansion) in the configuration file is not a
   boolean, but the code failed to check it.

 * "git diff --quiet -- pathspec1 pathspec2" sometimes did not return
   correct status value.

 * Attempting to deepen a shallow repository by fetching over smart
   HTTP transport failed in the protocol exchange, when no-done
   extension was used.  The fetching side waited for the list of
   shallow boundary commits after the sending end stopped talking to
   it.

 * Allow "git cmd path/", when the 'path' is where a submodule is
   bound to the top-level working tree, to match 'path', despite the
   extra and unnecessary trailing slash (such a slash is often
   given by command line completion).

----------------------------------------------------------------

Changes since v1.9.0 are as follows:

Brad King (4):
      t3030-merge-recursive: test known breakage with empty work tree
      read-cache.c: refactor --ignore-missing implementation
      read-cache.c: extend make_cache_entry refresh flag with options
      merge-recursive.c: tolerate missing files while refreshing index

David Aguilar (1):
      difftool: support repositories with .git-files

David Sharp (1):
      rev-parse: check i before using argv[i] against argc

Jeff King (12):
      expand_user_path: do not look at NULL path
      handle_path_include: don't look at NULL value
      tests: auto-set LIB_HTTPD_PORT from test name
      t4212: test bogus timestamps with git-log
      fsck: report integer overflow in author timestamps
      date: check date overflow against time_t
      log: handle integer overflow in timestamps
      log: do not segfault on gmtime errors
      remote: handle pushremote config in any order
      show_ident_date: fix tz range check
      clean: respect pathspecs with "-d"
      clean: simplify dir/not-dir logic

Junio C Hamano (4):
      t0003: do not chdir the whole test process
      check-attr: move to the top of working tree when in non-bare repo=
sitory
      t7800: add a difftool test for .git-files
      Git 1.9.1

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (17):
      test: rename http fetch and push test files
      pack-protocol.txt: clarify 'obj-id' in the last ACK after 'done'
      protocol-capabilities.txt: refer multi_ack_detailed back to pack-=
protocol.txt
      protocol-capabilities.txt: document no-done
      fetch-pack: fix deepen shallow over smart http with no-done cap
      t5537: move http tests out to t5539
      reset: optionally setup worktree and refresh index on --mixed
      pathspec: convert some match_pathspec_depth() to ce_path_match()
      pathspec: convert some match_pathspec_depth() to dir_path_match()
      pathspec: rename match_pathspec_depth() to match_pathspec()
      dir.c: prepare match_pathspec_item for taking more flags
      match_pathspec: match pathspec "foo/" against directory "foo"
      pathspec: pass directory indicator to match_pathspec_item()
      clean: replace match_pathspec() with dir_path_match()
      clean: use cache_name_is_other()
      diff.c: move diffcore_skip_stat_unmatch core logic out for reuse =
later
      diff: do not quit early on stat-dirty files

Sandy Carter (1):
      i18n: proposed command missing leading dash

Thomas Rast (1):
      diff: do not reuse_worktree_file for submodules
