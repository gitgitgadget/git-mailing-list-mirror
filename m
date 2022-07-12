Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B3CC43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 17:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbiGLRJm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 13:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiGLRJk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 13:09:40 -0400
X-Greylist: delayed 158 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Jul 2022 10:09:38 PDT
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A310A26AF9;
        Tue, 12 Jul 2022 10:09:38 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B8DC13C9FE;
        Tue, 12 Jul 2022 13:06:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=w0UKyYdQ1A+V1udZfVAXLlWWc
        FkkGbvbz51v1rTX1/k=; b=RE3OnpXVoYq5NOlkZEVfSBiZlV93QbcG1Apn9xzvs
        CchKu5jUf5S2JHPNLp7MJpIdjTA7sPyZcDm/dXcOp9RiEtQevy6cx1iHkfZnHBFS
        z1Ba6MRhCkh9eVZfh/OX0a4b8FeywLSBfY7qqLqkFY5q63nYGRIbtZRfjgnyF9Dp
        uY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 521B313C9FD;
        Tue, 12 Jul 2022 13:06:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AED7B13C9FC;
        Tue, 12 Jul 2022 13:06:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.37.1 and others
Date:   Tue, 12 Jul 2022 10:06:57 -0700
Message-ID: <xmqqv8s2fefi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0A2F8064-0205-11ED-AA91-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git v2.37.1, together with v2.30.5, v2.31.4, v2.32.3, v2.33.4,
v2.34.4, v2.35.4, and v2.36.2 for older maintenance tracks, are now
available at the usual places.

These are to address CVE-2022-29187, where the fixes in v2.36.1 and
below to address CVE-2022-24765 released earlier may not have been
complete.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.37.1'
tag and other tags for older maintenance tracks.

  url =3D https://git.kernel.org/pub/scm/git/git
  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git 2.37.1 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This release merges up the fixes that appear in v2.30.5, v2.31.4,
v2.32.3, v2.33.4, v2.34.4, v2.35.4, and v2.36.2 to address the
security issue CVE-2022-29187; see the release notes for these
versions for details.

Fixes since Git 2.37
--------------------

 * Rewrite of "git add -i" in C that appeared in Git 2.25 didn't
   correctly record a removed file to the index, which is an old
   regression but has become widely known because the C version has
   become the default in the latest release.

 * Fix for CVE-2022-29187.

----------------------------------------------------------------

Git v2.30.5 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This release contains minor fix-ups for the changes that went into
Git 2.30.3 and 2.30.4, addressing CVE-2022-29187.

 * The safety check that verifies a safe ownership of the Git
   worktree is now extended to also cover the ownership of the Git
   directory (and the `.git` file, if there is any).

Carlo Marcelo Arenas Bel=C3=B3n (1):
      setup: tighten ownership checks post CVE-2022-24765
