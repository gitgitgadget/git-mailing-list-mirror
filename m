From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.5.3
Date: Thu, 26 May 2011 16:35:36 -0700
Message-ID: <7vvcwxt4qf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Fri May 27 01:35:58 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1QPk5t-0006gT-Iq
	for glk-linux-kernel-3@lo.gmane.org; Fri, 27 May 2011 01:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758600Ab1EZXfr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 26 May 2011 19:35:47 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52363 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758352Ab1EZXfq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2011 19:35:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7E91F45CB;
	Thu, 26 May 2011 19:37:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=5wb2KO3UuZOsbrYkPGF0sY028
	VY=; b=r6pnCIkSPQHZNO3qljWXstryh41lcTGuMdcqvZ/v30gRiVG1EH+5yxVC9
	4+GW3pMFLB5ovr35qhC7IKOi+0EjfaUPl053N9T4yqqiUIFGgwquhPm9MBNtGRS5
	KyAa39xjEbUMTUlypQpHdHhlPou+TBfEqm4XsAHAgmrfIitcAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=P/Buo5bsNWCqPULnkPE
	LMgG08LxPtdAtfAjSKfR7KylkOzFjdJRvq6bgsvibtlkJ/9tbYDc7t+5VcbtB5D2
	VRyVFVGbZfTqQJYTSuAidICCuThpg4cQ4xQz5Met37yBq60681/olUKBNE/eUpGo
	k9ev2rHEpqYC4wyW+4Z6ngJ8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4835545C7;
	Thu, 26 May 2011 19:37:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B2D9B45C4; Thu, 26 May 2011
 19:37:44 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2A9016BA-87F1-11E0-BF64-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174593>

The latest maintenance release Git 1.7.5.3 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.5.3.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.5.3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.5.3.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.7.5.3-1.fc13.$arch.rpm	(RPM)

Git v1.7.5.3 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.7.5.2
--------------------

 * The bash completion scripts should correctly work using zsh's bash
   completion emulation layer now.

 * Setting $(prefix) in config.mak did not affect where etc/gitconfig
   file is read from, even though passing it from the command line of
   $(MAKE) did.

 * The logic to handle "&" (expand to UNIX username) in GECOS field
   miscounted the length of the name it formatted.

 * "git cherry-pick -s resolve" failed to cherry-pick a root commit.

 * "git diff --word-diff" misbehaved when diff.suppress-blank-empty was
   in effect.

 * "git log --stdin path" with an input that has additional pathspec
   used to corrupt memory.

 * "git send-pack" (hence "git push") over smalt-HTTP protocol could
   deadlock when the client side pack-object died early.

 * Compressed tarball gitweb generates used to be made with the timesta=
mp
   of the tarball generation; this was bad because snapshot from the sa=
me
   tree should result in a same tarball.

And other minor fixes and documentation updates.

----------------------------------------------------------------

Changes since v1.7.5.2 are as follows:

=46elipe Contreras (1):
      git-completion: fix regression in zsh support

=46raser Tweedale (1):
      gitweb: supply '-n' to gzip for identical output

Jeff King (8):
      send-pack: unbreak push over stateless rpc
      cherry-pick: handle root commits with external strategies
      revert: allow reverting a root commit
      t3503: test cherry picking and reverting root commits
      connect: treat generic proxy processes like ssh processes
      connect: let callers know if connection is a socket
      send-pack: avoid deadlock on git:// push with failed pack-objects
      test core.gitproxy configuration

Jim Meyering (1):
      do not read beyond end of malloc'd buffer

Johannes Sixt (3):
      Documentation/format-patch: suggest Toggle Word Wrap add-on for T=
hunderbird
      send-pack: avoid deadlock when pack-object dies early
      Honor $(prefix) set in config.mak* when defining ETC_GIT*

Jonathan Nieder (5):
      Revert "t0081 (line-buffer): add buffering tests"
      Documentation: explain how to check for patch corruption
      Documentation: hints for sending patches inline with Thunderbird
      Documentation: publicize KMail hints for sending patches inline
      Documentation: publicize hints for sending patches with GMail

Junio C Hamano (4):
      Revert "Honor $(prefix) set in config.mak* when defining ETC_GIT*=
 and sysconfdir"
      setup_revisions(): take pathspec from command line and --stdin co=
rrectly
      sideband_demux(): fix decl-after-stmt
      Git 1.7.5.3

Kacper Kornet (1):
      Honor $(prefix) set in config.mak* when defining ETC_GIT* and sys=
confdir

Michael J Gruber (2):
      config.txt,diff-options.txt: porcelain vs. plumbing for color.dif=
f
      git-svn: Fix git svn log --show-commit

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      init/clone: remove short option -L and document --separate-git-di=
r

Rafael Gieschke (1):
      copy_gecos: fix not adding nlen to len when processing "&"

Stefan Sperling (1):
      remove noise and inaccuracies from git-svn docs
