From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.0.3
Date: Thu, 24 Jul 2014 10:57:33 -0700
Message-ID: <xmqqa97yabci.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Thu Jul 24 19:58:02 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1XANHF-0005zR-7S
	for glk-linux-kernel-3@plane.gmane.org; Thu, 24 Jul 2014 19:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759606AbaGXR5u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 24 Jul 2014 13:57:50 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51456 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759505AbaGXR5s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2014 13:57:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A09CB2BCC5;
	Thu, 24 Jul 2014 13:57:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=WLLz7wQGtu+Vje8Dw1kymhUiK
	tE=; b=OSAxZYr05jtZcxlNNZGSFQIouSZDuF3OVTRoEm8VrPf6YLDLCxuZZxlLB
	mUEpWWJJljUB1lkoZilu6uwqjbXACZPiLFkNsKjgOymScgeb6SJhNBOqtO/BW3vF
	sRBCZOODlzLLYl3EgSLGHm1McPop1TBOww8eyFGvvX3LXQJZww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=LfOrkIeRsKTJXFoxo/p
	L9u8TrwWnSLtA3nqjVXRAZTttOhqKxiRLbf3P23ZXvTy4RH+PMOztcAijQLABTgV
	YYKtvqcSRCOexjT3e/lDD5+h0csqfQT9y6Xi1ifl0SZauxBjLuH4YJFzI+gehavX
	vj8yA3vuSMJb3Ko5HxJzKwUc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 972DE2BCC4;
	Thu, 24 Jul 2014 13:57:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 80C442BCBB;
	Thu, 24 Jul 2014 13:57:35 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FE2E9F66-135B-11E4-93FA-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254171>

The latest maintenance release Git v2.0.3 is now available at
the usual places.  Hopefully it would be the final maintenance
release for the v2.0 series.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.0.3'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git v2.0.3 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 * An ancient rewrite passed a wrong pointer to a curl library
   function in a rarely used code path.

 * "filter-branch" left an empty single-parent commit that results when
   all parents of a merge commit gets mapped to the same commit, even
   under "--prune-empty".

 * "log --show-signature" incorrectly decided the color to paint a
   mergetag that was and was not correctly validated.

 * "log --show-signature" did not pay attention to "--graph" option.

Also a lot of fixes to the tests and some updates to the docs are
included.

----------------------------------------------------------------

Changes since v2.0.2 are as follows:

Abbaad Haider (1):
      http-push.c: make CURLOPT_IOCTLDATA a usable pointer

Ben Walton (1):
      compat/bswap.h: fix endianness detection

Brian Gesiak (12):
      builtin/ls-remote.c: rearrange xcalloc arguments
      builtin/remote.c: rearrange xcalloc arguments
      commit.c: rearrange xcalloc arguments
      config.c: rearrange xcalloc arguments
      diff.c: rearrange xcalloc arguments
      http-push.c: rearrange xcalloc arguments
      imap-send.c: rearrange xcalloc arguments
      notes.c: rearrange xcalloc arguments
      pack-revindex.c: rearrange xcalloc arguments
      reflog-walk.c: rearrange xcalloc arguments
      remote.c: rearrange xcalloc arguments
      transport-helper.c: rearrange xcalloc arguments

Charles Bailey (2):
      compat/bswap.h: detect endianness on more platforms that don't us=
e BYTE_ORDER
      filter-branch: eliminate duplicate mapped parents

Elia Pinto (1):
      scripts: "export VAR=3DVALUE" construct is not portable

Jeremiah Mahler (3):
      Documentation: wording fixes in the user manual and glossary
      t/t7810-grep.sh: remove duplicate test_config()
      api-strbuf.txt minor typos

Johannes Sixt (1):
      fix brown paper bag breakage in t5150-request-pull.sh

Jonathan McCrohan (1):
      git-instaweb: add support for Apache 2.4

Junio C Hamano (3):
      compat/bswap.h: restore preference __BIG_ENDIAN over BIG_ENDIAN
      scripts: more "export VAR=3DVALUE" fixes
      Git 2.0.3

Michael J Gruber (1):
      log: correctly identify mergetag signature verification status

Philip Oakley (1):
      doc: give some guidelines for error messages

Ren=C3=A9 Scharfe (2):
      use xcalloc() to allocate zero-initialized memory
      use xmemdupz() to allocate copies of strings given by start and l=
ength

Stefan Beller (2):
      git.1: switch homepage for stats
      .mailmap: combine Stefan Beller's emails

Stepan Kasal (1):
      t5000, t5003: do not use test_cmp to compare binary files

Yi EungJun (1):
      http-protocol.txt: Basic Auth is defined in RFC 2617, not RFC 261=
6

Zoltan Klinger (1):
      log: fix indentation for --graph --show-signature

brian m. carlson (1):
      Documentation: fix missing text for rev-parse --verify
