Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C613CC433EF
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 00:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbiDNAl2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 20:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiDNAl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 20:41:26 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73DF1C911
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 17:38:45 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8988312932F;
        Wed, 13 Apr 2022 20:38:43 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=hsodpa3s/BIZ7jeeEdJKCkvmb
        L7TbOhWc68dV5jGQpI=; b=vMaJOZg4mUuwy9FhND94yIBPnPigajEjG3XlxgomY
        B3q8ba1XOo2RKuTs96X9lTX4+K/q/TUkbNsUtHIWxyC7o5FxpcyAYOKNEi+h1gpK
        KFNuy7PFrMQcKVkxBhJISq1lr7zjDtzlxAuISKdoqtLlM3BTzfNiI9w3AGuxaWCT
        OE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 828D312932E;
        Wed, 13 Apr 2022 20:38:43 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E56F412932D;
        Wed, 13 Apr 2022 20:38:42 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>
Subject: [PATCH 2/2] RelNotes: mention safe.directory
Date:   Wed, 13 Apr 2022 17:38:39 -0700
Message-Id: <20220414003839.1616296-2-gitster@pobox.com>
X-Mailer: git-send-email 2.36.0-rc2-128-g50f43b47b9
In-Reply-To: <20220414003839.1616296-1-gitster@pobox.com>
References: <20220414003839.1616296-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 3C61FF6E-BB8B-11EC-A436-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Helped-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/RelNotes/2.36.0.txt | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/RelNotes/2.36.0.txt b/Documentation/RelNotes/2=
.36.0.txt
index 9f6dd3d868..f4c5e691bb 100644
--- a/Documentation/RelNotes/2.36.0.txt
+++ b/Documentation/RelNotes/2.36.0.txt
@@ -13,6 +13,15 @@ Backward compatibility warts
    top-level a partial clone, while submodules are fully cloned.  This
    behaviour is changed to pass the same filter down to the submodules.
=20
+ * With the fixes for CVE-2022-24765 that are common with versions of
+   Git 2.30.4, 2.31.3, 2.32.2, 2.33.3, 2.34.3, and 2.35.3, Git has
+   been taught not to recognise repositories owned by other users, in
+   order to avoid getting affected by their config files and hooks.
+   You can list the path to the safe/trusted repositories that may be
+   owned by others on a multi-valued configuration variable
+   `safe.directory` to override this behaviour, or use '*' to declare
+   that you trust anything.
+
=20
 Note to those who build from the source
=20
@@ -397,8 +406,6 @@ Fixes since v2.35
    entry it moved.
    (merge b7f9130a06 vd/mv-refresh-stat later to maint).
=20
- * Fix for CVE-2022-24765 has been merged up from 2.35.2 and others.
-
  * Other code cleanup, docfix, build fix, etc.
    (merge cfc5cf428b jc/find-header later to maint).
    (merge 40e7cfdd46 jh/p4-fix-use-of-process-error-exception later to m=
aint).
--=20
2.36.0-rc2-128-g50f43b47b9

