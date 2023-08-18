Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D916EE49A0
	for <git@archiver.kernel.org>; Fri, 18 Aug 2023 23:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242803AbjHRXhz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Aug 2023 19:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242764AbjHRXhf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2023 19:37:35 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DE926AA
        for <git@vger.kernel.org>; Fri, 18 Aug 2023 16:37:34 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A78B1A1E57;
        Fri, 18 Aug 2023 19:37:31 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=BYTF75R6IpKjhluupZSGFhcnaSklWLxPr62xhF1U0Q0=; b=LLw2
        K+Fsh7oEEXebyaWAV0epss/K5BOq5jt1uyxn8bbZQw6i9LF7RDjNbojQZ5Lmb3We
        CzvdJo6fOi1XxkOQBTfpIkK+F0O7BQuasxR6oW4DeI+bDt1vwhaVbvoJPaNFvV1P
        BX0CQHwi/SzCugVJzfrPCGuzW/fIIPqOsTxsAc4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 71C5A1A1E56;
        Fri, 18 Aug 2023 19:37:31 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 96D9C1A1E55;
        Fri, 18 Aug 2023 19:37:30 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 0/3] "update-index --show-index-version"
Date:   Fri, 18 Aug 2023 16:37:26 -0700
Message-ID: <20230818233729.2766281-1-gitster@pobox.com>
X-Mailer: git-send-email 2.42.0-rc2-7-gf9972720e9
MIME-Version: 1.0
X-Pobox-Relay-ID: 32BF9BF6-3E20-11EE-869E-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even though there is "test-tool index-version", there wasn't an
officially supported way for end-users to inspect the index version
of an on-disk index.  Let's have one.

Junio C Hamano (3):
  update-index doc: v4 is OK with JGit and libgit2
  update-index: add --show-index-version
  test-tool: retire "index-version"

 Documentation/git-update-index.txt    | 14 ++++++++++----
 Makefile                              |  1 -
 builtin/update-index.c                | 19 +++++++++++++------
 t/helper/test-index-version.c         | 15 ---------------
 t/helper/test-tool.c                  |  1 -
 t/helper/test-tool.h                  |  1 -
 t/t1600-index.sh                      |  2 +-
 t/t1700-split-index.sh                |  2 +-
 t/t2104-update-index-skip-worktree.sh |  6 +++---
 t/t2107-update-index-basic.sh         | 16 ++++++++++++++++
 10 files changed, 44 insertions(+), 33 deletions(-)
 delete mode 100644 t/helper/test-index-version.c

--=20
2.42.0-rc2-7-gf9972720e9

