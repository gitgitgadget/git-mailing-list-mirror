Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C90ECAAA1
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 16:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiIOQLH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 12:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiIOQLF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 12:11:05 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4428C015
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 09:11:04 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B21A11B864F;
        Thu, 15 Sep 2022 12:07:24 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=w04yXk4c6rrb3sbv8pW602JG/
        xOqJOwkiCQvuWHOrbM=; b=pNyk360qh6tSV5LVvnapLJUQU5Utvlyalwsl70vsT
        AkPU0WYtYYlCbMFmqiyEdw7uEwrDNvusE0D+VXl2/F9rKFQjTsx5CRgMLUf6muLG
        NfSCvMzRWHg/KGwoxWSA2XUtINfW95LdG59f1MY8TUvq8mXbVhLkD+HRgJhmnOjG
        xc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 92D721B864E;
        Thu, 15 Sep 2022 12:07:24 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 176E61B864C;
        Thu, 15 Sep 2022 12:07:19 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 5/5] environ: GIT_INDEX_VERSION affects not just a new repository
Date:   Thu, 15 Sep 2022 09:06:59 -0700
Message-Id: <20220915160659.126441-6-gitster@pobox.com>
X-Mailer: git-send-email 2.37.3-780-gd940517dcb
In-Reply-To: <20220915160659.126441-1-gitster@pobox.com>
References: <xmqq8rmkpsit.fsf@gitster.g>
 <20220915160659.126441-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 796A0FD8-3510-11ED-9995-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The variable is consulted whenever we write the index file.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 535ff561c6..eb2a17d36b 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -477,8 +477,8 @@ Git so take care if using a foreign front-end.
 	is used.
=20
 `GIT_INDEX_VERSION`::
-	This environment variable allows the specification of an index
-	version for new repositories.  It won't affect existing index
+	This environment variable specifies what index version is used
+	when writing the index file out.  It won't affect existing index
 	files.  By default index file version 2 or 3 is used. See
 	linkgit:git-update-index[1] for more information.
=20
--=20
2.37.3-780-gd940517dcb

