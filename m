From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.3.7
Date: Mon, 27 Apr 2015 13:01:35 -0700
Message-ID: <xmqqy4lduyqo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Mon Apr 27 22:02:00 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YmpDv-0005xz-PT
	for glk-linux-kernel-3@plane.gmane.org; Mon, 27 Apr 2015 22:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbbD0UBm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 27 Apr 2015 16:01:42 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63147 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965045AbbD0UBi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Apr 2015 16:01:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 400404CF76;
	Mon, 27 Apr 2015 16:01:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=Npdz9qCrmQ1oUwGjuyQBixufP
	RQ=; b=sP9XkLyrjMC8ZvBHjvednw/94WDjuDMfLBvFmHgR+NwC2FwQCWGUwyg9V
	JkejnwkN9SRhGGIEdecZA2DOviY8yrYhDI9q/nYphekVLqSrN4PKsYeXvLZyk3uf
	BaoOGp7jkKFGNvSqdu/gHDrBKK3QX9I/La+ZNDISWLrJLcPLdw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=X1t2KUicRi2RaEOqyw7
	CFiDK6iiZUTU0+WRJCGB3FjblFCPL6qqTI88oPtdXvxGToNncu5XNIsliEzS/S0m
	ywj1IUifW8X8lYXARRuRZmhSnlHj/3My2J+iEN/VGfLPFug6F0JrkOp2hq2TwrrZ
	Wa2NPqJ/+qymVUaohEG18Ql4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 391D64CF72;
	Mon, 27 Apr 2015 16:01:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9B7294CF6F;
	Mon, 27 Apr 2015 16:01:36 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 35DB6034-ED18-11E4-BAF9-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267880>

The latest maintenance release Git v2.3.7 is now available at
the usual places.  Hopefully this will be the last v2.3.x update
until the master front is tagged as v2.4 final.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.3.7'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git v2.3.7 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v2.3.6
------------------

 * An earlier update to the parser that disects a URL broke an
   address, followed by a colon, followed by an empty string (instead
   of the port number), e.g. ssh://example.com:/path/to/repo.

 * The completion script (in contrib/) contaminated global namespace
   and clobbered on a shell variable $x.

 * The "git push --signed" protocol extension did not limit what the
   "nonce" that is a server-chosen string can contain or how long it
   can be, which was unnecessarily lax.  Limit both the length and the
   alphabet to a reasonably small space that can still have enough
   entropy.

Also contains typofixes, documentation updates and trivial code
clean-ups.

----------------------------------------------------------------

Changes since v2.3.6 are as follows:

Junio C Hamano (2):
      push --signed: tighten what the receiving end can ask to sign
      Git 2.3.7

M=C3=A1rcio Almada (1):
      completion: fix global bash variable leak on __gitcompappend

Torsten B=C3=B6gershausen (1):
      connect.c: ignore extra colon after hostname
