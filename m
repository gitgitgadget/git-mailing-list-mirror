From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.1.3
Date: Wed, 29 Oct 2014 13:12:25 -0700
Message-ID: <xmqq8ujyy6s6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Wed Oct 29 21:12:34 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1XjZbd-00054i-UW
	for glk-linux-kernel-3@plane.gmane.org; Wed, 29 Oct 2014 21:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757125AbaJ2UMa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 29 Oct 2014 16:12:30 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59615 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756939AbaJ2UM2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2014 16:12:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F199D19ED3;
	Wed, 29 Oct 2014 16:12:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=qiTE1JrFG+ocMPvyI/ozQk0jD
	vY=; b=I1hSUn0koaWGiT/Yxjw3VneWB3jcUFkmEWvcbPMOGrkdk/fREGeRNGfCA
	j92o4Exe8wPw7wllLiAcPX/Jo6QXv+XB9XF+rdUJ393rlYTc96RKOnxoR1OJedzu
	pCmYWwOoqmt0ZXEKgsk/VAWbD3qkTEPM8JAbUDBsnZTwF/NPD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=G+5DhWVyO2EDx7L3Wkn
	PRuUejQ4ohdvHq5oGLpCQykgXDXGm76oXDs2GxTds/fHYN7w0n+Ma2qpw/jnTq7i
	UamTNiyODKDepwEDRBpw1Jer+2fJ+HwXNoDx13oBPLLfSFI47NUAbvfzfiDspAzC
	QMJSH2M33QiRPzqozNvCXCZc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E9E7C19ED1;
	Wed, 29 Oct 2014 16:12:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7DF9219ED0;
	Wed, 29 Oct 2014 16:12:26 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E6DBA366-5FA7-11E4-9AF7-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest maintenance release Git v2.1.3 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.1.3'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git v2.1.3 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 * Some MUAs mangled a line in a message that begins with "From " to
   ">From " when writing to a mailbox file and feeding such an input to
   "git am" used to lose such a line.

 * "git daemon" (with NO_IPV6 build configuration) used to incorrectly
   use the hostname even when gethostbyname() reported that the given
   hostname is not found.

 * Newer versions of 'meld' breaks the auto-detection we use to see if
   they are new enough to support the `--output` option.

 * "git pack-objects" forgot to disable the codepath to generate
   object recheability bitmap when it needs to split the resulting
   pack.

 * "gitweb" used deprecated CGI::startfrom, which was removed from
   CGI.pm as of 4.04; use CGI::start_from instead.

 * "git log" documentation had an example section marked up not
   quite correctly, which passed AsciiDoc but failed with
   AsciiDoctor.

Also contains some documentation updates.

----------------------------------------------------------------

Changes since v2.1.2 are as follows:

David Aguilar (1):
      mergetools/meld: make usage of `--output` configurable and more r=
obust

Eric Sunshine (1):
      mailinfo: work around -Wstring-plus-int warning

Jeff King (2):
      mailinfo: make ">From" in-body header check more robust
      pack-objects: turn off bitmaps when we split packs

Junio C Hamano (1):
      Git 2.1.3

Ren=C3=A9 Scharfe (3):
      daemon: handle gethostbyname() error
      daemon: fix error message after bind()
      daemon: remove write-only variable maxfd

Roland Mas (1):
      gitweb: use start_form, not startform that was removed in CGI.pm =
4.04

Wieland Hoffmann (1):
      git-tag.txt: Add a missing hyphen to `-s`

brian m. carlson (1):
      Documentation: fix misrender of pretty-formats in Asciidoctor
