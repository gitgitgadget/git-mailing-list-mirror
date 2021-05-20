Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49782C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 07:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BE9E60FE6
	for <git@archiver.kernel.org>; Thu, 20 May 2021 07:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhETHnv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 03:43:51 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:45680 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhETHnv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 03:43:51 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:d1:f360:d787:42d5:3b3a:1b26])
        by smtp5-g21.free.fr (Postfix) with ESMTP id 6E90B5FFC5;
        Thu, 20 May 2021 09:42:28 +0200 (CEST)
From:   =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH] help: fix small typo in error message
Date:   Thu, 20 May 2021 09:42:14 +0200
Message-Id: <20210520074214.40903-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.31.0.rc2.1.gaceb20851f.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Classic string concatenation while forgetting a space character.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 list-objects-filter-options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 96a605c8ad..fd8d59f653 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -102,7 +102,7 @@ static int gently_parse_list_objects_filter(
 	} else if (skip_prefix(arg, "object:type=", &v0)) {
 		int type = type_from_string_gently(v0, strlen(v0), 1);
 		if (type < 0) {
-			strbuf_addf(errbuf, _("'%s' for 'object:type=<type>' is"
+			strbuf_addf(errbuf, _("'%s' for 'object:type=<type>' is "
 					      "not a valid object type"), v0);
 			return 1;
 		}
-- 
2.31.0.rc2.1.gaceb20851f.dirty

