From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.5.4
Date: Wed, 01 Jun 2011 15:55:44 -0700
Message-ID: <7v8vtlf9fz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Thu Jun 02 00:56:07 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1QRuKc-0004ml-Bt
	for glk-linux-kernel-3@lo.gmane.org; Thu, 02 Jun 2011 00:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612Ab1FAWz4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 1 Jun 2011 18:55:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46774 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755855Ab1FAWzy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2011 18:55:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 04D954B03;
	Wed,  1 Jun 2011 18:58:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=4d2W8qIJxtSvD0P6y7fyYIDDJ
	/4=; b=ps6ZV6ZQMWu6C2CfGuvQ0IIHDRH3Fn7gXdl8J5Bqd+0ZnDQXG+ndXOpkX
	FwbdPDC7DdIkmb0b0Q3fSTcdbWcbOEEAqaLId4rypyT6qBkc5sgP1LXUllX3uRE0
	on3Q55nMnNEF2kw4VlPRVoRHStRYo+MYwmz2C5+8eyxvRcMT+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=AJ/Uspt5D2AVPtsYJOI
	qyfQMVV35+8AAOhmT3eNaQZGiqnlCx4YiXaQ5S4dXFI6xGuB29X+abMf5mjq12jk
	z3byN14QbvtPY5DupGMp3/RBr0F97K87Umh7pZRmq+RBqsV1kNBeKvY4hAO/EVSy
	Qf9REbGQX1xc+7N5pOQtYcTo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BB7384B02;
	Wed,  1 Jun 2011 18:57:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A49684B01; Wed,  1 Jun 2011
 18:57:54 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 982E986C-8CA2-11E0-8346-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174917>

The latest maintenance release Git 1.7.5.4 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.5.4.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.5.4.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.5.4.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.7.5.4-1.fc13.$arch.rpm	(RPM)

Git v1.7.5.4 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.7.5.3
--------------------

 * The single-key mode of "git add -p" was easily fooled into thinking
   that it was told to add everthing ('a') when up-arrow was pressed by
   mistake.

 * Setting a git command that uses custom configuration via "-c var=3Dv=
al"
   as an alias caused a crash due to a realloc(3) failure.

 * "git diff -C -C" used to disable the rename detection entirely when
   there are too many copy candidate paths in the tree; now it falls
   back to "-C" when doing so would keep the copy candidate paths
   under the rename detection limit.

 * "git rerere" did not diagnose a corrupt MERGE_RR file in some cases.

And other minor fixes and documentation updates.

----------------------------------------------------------------

Changes since v1.7.5.3 are as follows:

Brandon Casey (2):
      Documentation/technical/api-diff.txt: correct name of diff_unmerg=
e()
      git-submodule.sh: separate parens by a space to avoid confusing s=
ome shells

Jeff King (8):
      config: make environment parsing routines static
      git_config: don't peek at global config_parameters
      config: always parse GIT_CONFIG_PARAMETERS during git_config
      read_gitfile_gently: use ssize_t to hold read result
      docs: minor grammar fixes to git-status
      docs: update status --porcelain format
      docs: make sure literal "->" isn't converted to arrow
      docs: fix some antique example output

Jim Meyering (3):
      rerere.c: diagnose a corrupt MERGE_RR when hitting EOF between TA=
B and '\0'
      remove tests of always-false condition
      diffcore-rename.c: avoid set-but-not-used warning

Jonathan Nieder (3):
      tests: check error message from run_command
      run-command: handle short writes and EINTR in die_child
      Documentation: do not misinterpret refspecs as bold text

Junio C Hamano (26):
      builtin/diff.c: remove duplicated call to diff_result_code()
      diffcore-rename: refactor "too many candidates" logic
      diffcore-rename: record filepair for rename src
      diffcore-rename: fall back to -C when -C -C busts the rename limi=
t
      i18n: do not overuse C_LOCALE_OUTPUT
      i18n: .git file is not a human readable message (t5601)
      i18n: use test_i18ncmp in t1200 and t2200
      i18n: do not overuse C_LOCALE_OUTPUT (grep)
      i18n: use test_i18ngrep in lib-httpd and t2019
      i18n: use test_i18ngrep in t2020, t2204, t3030, and t3200
      i18n: use test_i18ncmp and test_i18ngrep in t3203, t3501 and t350=
7
      i18n: use test_i18ncmp and test_i18ngrep in t3700, t4001 and t401=
4
      i18n: use test_i18ncmp and test_i18ngrep in t5541, t6040, t6120, =
t7004, t7012 and t7060
      i18n: use test_i18ncmp and test_i18ngrep in t7102 and t7110
      i18n: use test_i18ngrep in t7201
      i18n: use test_i18ncmp in t7500
      i18n: use test_i18ngrep in t7501
      i18n: use test_i18ngrep and test_i18ncmp in t7502
      i18n: use test_i18ngrep in t7506
      i18n: use test_i18n{grep,cmp} in t7508
      i18n: use test_i18n{cmp,grep} in t7600, t7607, t7611 and t7811
      handle_options(): do not miscount how many arguments were used
      userformat_find_requirements(): find requirement for the correct =
format
      config.mak.in: allow "configure --sysconfdir=3D/else/where"
      Start 1.7.5.4 draft release notes
      Git 1.7.5.4

Mathias Lafeldt (1):
      t/README: unify documentation of test function args

Ramkumar Ramachandra (4):
      Documentation: Add filter.<driver>.* to config
      Documentation: Move diff.<driver>.* from config.txt to diff-confi=
g.txt
      Documentation: Add diff.<driver>.* to config
      Documentation: Allow custom diff tools to be specified in 'diff.t=
ool'

Thomas Rast (1):
      add -i: ignore terminal escape sequences

Valentin Haenel (5):
      config.txt: 'interactive.singlekey; is used by...
      git-add.txt: document 'interactive.singlekey'
      git-stash.txt: better docs for '--patch'
      git-checkout.txt: better docs for '--patch'
      git-reset.txt: better docs for '--patch'

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (7):
      i18n: mark merge "Could not read from" message for translation
      i18n: mark merge "upstream" messages for translation
      i18n: mark merge CHERRY_PICK_HEAD messages for translation
      i18n: mark clone nonexistent repository message for translation
      i18n: mark checkout --detach messages for translation
      i18n: mark checkout plural warning for translation
      i18n: mark init-db messages for translation
