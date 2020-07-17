Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A9DC433E0
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 20:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DC652070E
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 20:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uzhkXdM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgGQUvh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 16:51:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53197 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgGQUvg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 16:51:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E80B62385;
        Fri, 17 Jul 2020 16:51:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=O
        +Go5h5e9qisv2JHvjflAAcyvYA=; b=uzhkXdM+ebkVISCx6qE6OQAnMmQ5hVnS+
        aGtvg3N5BIUXVJnRoGMuS9eiqyLNgTL3bIQuoQtLR46w+feXBVoj7X1FQ/8v0yMm
        dj0Vq0m1pKABAdxNZBGyhOhjGn3zgPROls+2PQmJjbiHvDZJZ6IXDBJ0qzx+o5lq
        WI7FHJy2FQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=Vkc
        kQxMlj8PXU93edGYpGI6XPlZ5q7HmlkNECZYuKpeEUBaOOsdCEUuQ4E/awiYyxmZ
        ptZnaX0vucPlgDU95pSgMsXnRyI/5BAVJSZF5l5rel2bbpMy/2zk9uNpNQ6ItmQR
        iDaOWNDMAgHA1rLNzbja5HbTibnfnKvGtZO5rBo4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 976C662384;
        Fri, 17 Jul 2020 16:51:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F59962382;
        Fri, 17 Jul 2020 16:51:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] RelNotes: update the v0 with extension situation
Date:   Fri, 17 Jul 2020 13:51:33 -0700
Message-ID: <xmqqk0z1dfvu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4CAB5D18-C86F-11EA-8E96-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the two-patch series for regression fix, to the users from 2.27
days, there is no visible behaviour change---we do not warn and fail
use of v0 repositories with newer extensions yet, so there is nothing
to note in the backward compatibility section.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I noticed that this was needed but unfortunately not before
   tagging and tarballing.

 Documentation/RelNotes/2.28.0.txt | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/Documentation/RelNotes/2.28.0.txt b/Documentation/RelNotes/2.28.0.txt
index 934f5e652b..da9cafb788 100644
--- a/Documentation/RelNotes/2.28.0.txt
+++ b/Documentation/RelNotes/2.28.0.txt
@@ -9,15 +9,6 @@ Backward compatibility notes
  * "fetch.writeCommitGraph" is deemed to be still a bit too risky and
    is no longer part of the "feature.experimental" set.
 
- * It used to be that setting extensions.* configuration variables
-   alone, while leaving core.repositoryFormatVersion=0, made these
-   settings effective, which was a wrong thing to do.  In version 0,
-   there was no special meaning in extensions.* configuration
-   variables.  This has been corrected.  If you need these repository
-   extensions to be effective, the core.repositoryFormatVersion
-   variable needs to be updated to 1 after vetting these extensions.*
-   variables are set correctly.
-
 
 UI, Workflows & Features
 
-- 
2.28.0-rc1

