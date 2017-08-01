Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB1132047F
	for <e@80x24.org>; Tue,  1 Aug 2017 19:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbdHATos (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 15:44:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53602 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752090AbdHATor (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 15:44:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A2D5AA9B1;
        Tue,  1 Aug 2017 15:44:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=jwe/6Km2jjLjf+nMQISS6nvCW
        pc=; b=HKx/a+WEMrlQbYkcoHaDBzZIuW9FpQKWvVRtxb/dd7I17GL+bDXlP731O
        6f9MSZbEcOLWa3GXtLOFVY2sDLXlL4ud/vxzUZkBWVuMibXFWoaV3PvKngtpq4rZ
        /u3RE9q+jJZGAPHn0GpPnANibvhEuZguYD+HzYS1EJsfntpw3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=vY23WFlqah/uwyJBTJ0
        S5t4Ctm9QmzkUTtJVgNH5X1bZ8wzj7tlDoy56kdeDqpVlV82kaROFWYbUbjXfeUL
        KbTxNGsVNq3MFLKMZobFwrImHcQ5K5rr9VqnlhBb0fNUvoL6dexZ6E2jsdkpImMp
        ktWN1+oe1gV04diBpPFHq7FM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 61AC6AA9B0;
        Tue,  1 Aug 2017 15:44:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BCD52AA9AF;
        Tue,  1 Aug 2017 15:44:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Git v2.13.4
Date:   Tue, 01 Aug 2017 12:44:44 -0700
Message-ID: <xmqqk22nf4yb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DEF4D4B0-76F1-11E7-B06D-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.13.4 is now available at
the usual places.

There is no update that is particulary important or controversial in
this release; it is primarily to flush the safer fixes that have
already been in the 'master' branch in preparation for the v2.14.0
release down to the maintenance track.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.13.4'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git v2.13.4 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Fixes since v2.13.3
-------------------

 * Update the character width tables.

 * A recent update broke an alias that contained an uppercase letter,
   which has been fixed.

 * On Cygwin, similar to Windows, "git push //server/share/repository"
   ought to mean a repository on a network share that can be accessed
   locally, but this did not work correctly due to stripping the double
   slashes at the beginning.

 * The progress meter did not give a useful output when we haven't had
   0.5 seconds to measure the throughput during the interval.  Instead
   show the overall throughput rate at the end, which is a much more
   useful number.

 * We run an early part of "git gc" that deals with refs before
   daemonising (and not under lock) even when running a background
   auto-gc, which caused multiple gc processes attempting to run the
   early part at the same time.  This is now prevented by running the
   early part also under the GC lock.

Also contains a handful of small code and documentation clean-ups.

----------------------------------------------------------------

Changes since v2.13.3 are as follows:

Beat Bolli (1):
      unicode: update the width tables to Unicode 10

Eric Wong (1):
      set FD_CLOEXEC properly when O_CLOEXEC is not supported

Jeff King (2):
      gc: run pre-detach operations under lock
      t: handle EOF in test_copy_bytes()

Johannes Schindelin (2):
      t1300: demonstrate that CamelCased aliases regressed
      alias: compare alias name *case-insensitively*

Jonathan Nieder (1):
      pre-rebase hook: capture documentation in a <<here document

Junio C Hamano (3):
      fixes from 'master' for 2.13.4
      Preparation for 2.13.4 continues
      Git 2.13.4

Kaartic Sivaraam (3):
      doc: correct a mistake in an illustration
      doc: camelCase the i18n config variables to improve readability
      doc: reformat the paragraph containing the 'cut-line'

Phillip Wood (4):
      add -i: move unquote_path() to Git.pm
      Git::unquote_path(): handle '\a'
      Git::unquote_path(): throw an exception on bad path
      t9700: add tests for Git::unquote_path()

Ren=C3=A9 Scharfe (3):
      apply: use starts_with() in gitdiff_verify_name()
      apply: use strcmp(3) for comparing strings in gitdiff_verify_name()
      progress: show overall rate in last update

Torsten B=C3=B6gershausen (1):
      cygwin: allow pushing to UNC paths

