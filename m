X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	SUBJ_ALL_CAPS shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.4.3.4
Date: Sun, 05 Nov 2006 01:01:45 -0800
Message-ID: <7v1woiuv0m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 09:02:06 +0000 (UTC)
Cc: linux-kernel@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30959>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ggdt0-0005MW-OS for gcvg-git@gmane.org; Sun, 05 Nov
 2006 10:01:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965868AbWKEJBr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 04:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965866AbWKEJBr
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 04:01:47 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:32966 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S965864AbWKEJBq
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 04:01:46 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061105090145.GCNP6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Sun, 5
 Nov 2006 04:01:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id ix1q1V00F1kojtg0000000 Sun, 05 Nov 2006
 04:01:50 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

The latest maintenance release GIT 1.4.3.4 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.3.4.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.3.4.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.3.4.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.3.4-1.$arch.rpm	(RPM)

Among many minor fixes and documentation updates, this contains these
fixes:

 - revision traversal now treats --unpacked as commit filter,
   not traversal limiter.  If you have unpacked commits that are
   parents of packed ones which are in turn parents of commits
   that are unpacked, running rev-list starting at the latest
   unpacked commits used to _stop_ at the first packed commit
   and older unpacked commits were not shown.  With this update,
   the traversal does not stop at packed commits, and shows the
   older unpacked commits.  The updated semantics is easier to
   use with git-repack --unpacked.

 - In a repository configured for shared access, if the
   permission bits of existing directories are misconfigured
   (e.g. running repository commands as root by mistake), a
   codepath to create a new object failed with incorrect error
   message.  Fixed.

 - An earlier fix to cope with traditional-style patches that
   were generated with --unified=0 broke handling of creation
   and deletion diffs in git-apply.  Fixed.

----------------------------------------------------------------

Andy Parkins (2):
      Minor grammar fixes for git-diff-index.txt
      git-clone documentation didn't mention --origin as equivalent of -o

Christian Couder (3):
      Remove --syslog in git-daemon inetd documentation examples.
      Documentation: add upload-archive service to git-daemon.
      Documentation: add git in /etc/services.

Edgar Toernig (1):
      Use memmove instead of memcpy for overlapping areas

J. Bruce Fields (1):
      Documentation: updates to "Everyday GIT"

Jakub Narebski (3):
      diff-format.txt: Combined diff format documentation supplement
      diff-format.txt: Correct information about pathnames quoting in patch format
      gitweb: Check git base URLs before generating URL from it

Jan Harkes (1):
      Continue traversal when rev-list --unpacked finds a packed commit.

Johannes Schindelin (1):
      link_temp_to_file: call adjust_shared_perm() only when we created the directory

Junio C Hamano (9):
      Documentation: clarify refname disambiguation rules.
      combine-diff: a few more finishing touches.
      combine-diff: fix hunk_comment_line logic.
      combine-diff: honour --no-commit-id
      Surround "#define DEBUG 0" with "#ifndef DEBUG..#endif"
      quote.c: ensure the same quoting across platforms.
      revision traversal: --unpacked does not limit commit list anymore.
      link_temp_to_file: don't leave the path truncated on adjust_shared_perm failure
      apply: handle "traditional" creation/deletion diff correctly.

Nicolas Pitre (1):
      pack-objects doesn't create random pack names

Rene Scharfe (1):
      git-cherry: document limit and add diagram

Shawn O. Pearce (3):
      Use ULONG_MAX rather than implicit cast of -1.
      Remove SIMPLE_PROGRAMS and make git-daemon a normal program.
      Remove unsupported C99 style struct initializers in git-archive.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFTaP6wMbZpPMRm5oRAvmYAJ9a58U9N7PaM7l7jyzw4MS4YiwjZACghgAO
LnuuiDIqaGGKJbkPJlS0Fto=
=9LbZ
-----END PGP SIGNATURE-----
