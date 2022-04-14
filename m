Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBABC433EF
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 00:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbiDNAlX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 20:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiDNAlW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 20:41:22 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6DE1C909
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 17:38:42 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E432C12DC0F;
        Wed, 13 Apr 2022 20:38:41 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=y2yk3UR+FPf0jykrN58DECOsVc094GC0l7Pa7b4k4rk=; b=SKJM
        ldTM4ECwLLyIC95cX3vdnwm0FCSM6E00IAROqKU4TlpFGdY0tev4NPdECRcyaXiS
        SkAzIITVh8Mdg8zx1PeglwD9Px7ZD5pdiJhsGKFEfhsMrZ6BLLouyPzXBQDI/2QX
        gLohI6A6m1TLAsj659Blwo5YYlXcgG2JefTt/Lw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DCB4012DC0E;
        Wed, 13 Apr 2022 20:38:41 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3BAC912DC0D;
        Wed, 13 Apr 2022 20:38:41 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 1/2] RelNotes: clarify "bisect run unexecutable" tweak
Date:   Wed, 13 Apr 2022 17:38:38 -0700
Message-Id: <20220414003839.1616296-1-gitster@pobox.com>
X-Mailer: git-send-email 2.36.0-rc2-128-g50f43b47b9
MIME-Version: 1.0
X-Pobox-Relay-ID: 3B5FCC4A-BB8B-11EC-9A99-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We do not have to guess how common the mistake the change targets is
when describing it.  Such an argument may be good while proposing a
change, but does not quite belong in the record of what has already
happened, i.e. a release note.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/RelNotes/2.36.0.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/RelNotes/2.36.0.txt b/Documentation/RelNotes/2=
.36.0.txt
index d61ade21e2..9f6dd3d868 100644
--- a/Documentation/RelNotes/2.36.0.txt
+++ b/Documentation/RelNotes/2.36.0.txt
@@ -46,10 +46,10 @@ UI, Workflows & Features
=20
  * "git branch" learned the "--recurse-submodules" option.
=20
- * A not-so-common mistake is to write a script to feed "git bisect
-   run" without making it executable, in which case all tests will
-   exit with 126 or 127 error codes, even on revisions that are marked
-   as good.  Try to recognize this situation and stop iteration early.
+ * A user can forget to make a script file executable before giving
+   it to "git bisect run".  In such a case, all tests will exit with
+   126 or 127 error codes, even on revisions that are marked as good.
+   Try to recognize this situation and stop iteration early.
=20
  * When "index-pack" dies due to incoming data exceeding the maximum
    allowed input size, include the value of the limit in the error
--=20
2.36.0-rc2-128-g50f43b47b9

