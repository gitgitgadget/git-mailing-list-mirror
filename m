Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30EFC433EF
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 20:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbhKXUcG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 15:32:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62761 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbhKXUcG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 15:32:06 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 03B8B106116;
        Wed, 24 Nov 2021 15:28:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=u
        c2SfAtGTNh7j2XztLK3cxqMIiDe4Iqy4RgMt7JO/Uk=; b=NIVfKW75hMl06Ld6Z
        XOxg8tUreJvjdaeomDj3uDXAXdFWO7P7Xsl8xFYeArvqlaSa0ZBbVtCfzAoHMvHS
        Vgy8dnPVvL4Uw9DlfRpmHBmolLNaJ/tKFN4yM+xjNhYf1L3vNH0qky5NVAGWLurY
        7e7Kf7Dd/xRPvLPB3DREqPArKk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EFAC5106115;
        Wed, 24 Nov 2021 15:28:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 67A6A106114;
        Wed, 24 Nov 2021 15:28:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.34.1
Date:   Wed, 24 Nov 2021 12:28:54 -0800
Message-ID: <xmqq7dcx1ent.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 254CBCE0-4D65-11EC-A8D0-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.34.1 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.34.1'
tag and the 'maint' branch that the tag points at:

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git v2.34.1 Release Notes
=========================

This release is primarily to fix a handful of regressions in Git 2.34.

Fixes since v2.34
-----------------

 * "git grep" looking in a blob that has non-UTF8 payload was
   completely broken when linked with certain versions of PCREv2
   library in the latest release.

 * "git pull" with any strategy when the other side is behind us
   should succeed as it is a no-op, but doesn't.

 * An earlier change in 2.34.0 caused JGit application (that abused
   GIT_EDITOR mechanism when invoking "git config") to get stuck with
   a SIGTTOU signal; it has been reverted.

 * An earlier change that broke .gitignore matching has been reverted.

 * SubmittingPatches document gained a syntactically incorrect mark-up,
   which has been corrected.

----------------------------------------------------------------

Changes since v2.34.0 are as follows:

Derrick Stolee (1):
      dir: revert "dir: select directories correctly"

Erwin Villejo (1):
      pull: should be noop when already-up-to-date

Junio C Hamano (3):
      Revert "grep/pcre2: fix an edge case concerning ascii patterns and UTF-8 data"
      Revert "editor: save and reset terminal after calling EDITOR"
      Git 2.34.1

Philippe Blain (1):
      SubmittingPatches: fix Asciidoc syntax in "GitHub CI" section

