Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3C7C19F2B
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 21:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbiHCVBI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 17:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiHCVBG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 17:01:06 -0400
X-Greylist: delayed 103 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 03 Aug 2022 14:01:03 PDT
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D37530F45
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 14:01:03 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 52A501AA25B;
        Wed,  3 Aug 2022 16:59:20 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=b/XCQ1mhos3U6CjnyKMncrSxO
        iTg2B6L21fe8VwCKRE=; b=jB3AshQHzairdRLO6CEZRWi5iVZHfJfBdntn9nnDF
        ZDqwTpGzpyPFeXzUyWJiZcNfvR1Ww69EGzHJ16hmn9DKvZLRM5YBWHfcfh2McT8S
        NXp3ErA/uolDsAK5x/eSZTaOLCXw/IYbum/H0Lk/QmIB8hIFKSsiVBW0gZh50Jp4
        l8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3EF931AA259;
        Wed,  3 Aug 2022 16:59:20 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C1EC41AA258;
        Wed,  3 Aug 2022 16:59:16 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] doc: clarify rerere-autoupdate
Date:   Wed,  3 Aug 2022 13:59:15 -0700
Message-Id: <20220803205915.1550797-1-gitster@pobox.com>
X-Mailer: git-send-email 2.37.1-482-g94c4bae67b
In-Reply-To: <xmqq35f2ysd9.fsf@gitster.g>
References: <xmqq35f2ysd9.fsf@gitster.g>
MIME-Version: 1.0
X-Pobox-Relay-ID: 2303F1D0-136F-11ED-A5FA-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "--[no-]rerere-autoupdate" option controls what happens _after_
the rerere mechanism kicks in to reuse recorded resolutions and does
not prevent from the rerere mechanism to trigger in the first place.

It is unclear in the current text if "--no-rerere-autoupdate" stops
the auto-resolution.  Rewrite the sentence to clarify.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/rerere-options.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/rerere-options.txt b/Documentation/rerere-opti=
ons.txt
index 8f4849e272..c3321ddea2 100644
--- a/Documentation/rerere-options.txt
+++ b/Documentation/rerere-options.txt
@@ -1,4 +1,9 @@
 --rerere-autoupdate::
 --no-rerere-autoupdate::
-	Allow the rerere mechanism to update the index with the
-	result of auto-conflict resolution if possible.
+	After the rerere mechanism reuses a recorded resolution on
+	the current conflict to update the files in the working
+	tree, allow it to also update the index with the result of
+	resolution.  `--no-rerere-autoupdate` is a good way to
+	double-check what `rerere` did and catch potential
+	mismerges, before committing the result to the index with a
+	separate `git add`.
--=20
2.37.1-482-g94c4bae67b

