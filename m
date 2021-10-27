Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B667C4332F
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 14:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E564660720
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 14:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238869AbhJ0Olx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 10:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237806AbhJ0Olv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 10:41:51 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720FBC061745
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 07:39:26 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 192so1307062wme.3
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 07:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ldyVwS09nc2OLJia/8NlZArMqqWxVI8EkShpKdO52GA=;
        b=WE11Y4Xm89Drt5ObByCAKBzNVGwg2Kndfg1InPxOHLbhm8+V5FygVGNLwIGU4/Wp04
         b40rv0izcjvnRALsE6oM/9c/MKvKJUMYJDhYVpG+hgVOrU+vkjx2umBatC1mrS4nECAu
         T+pwYjquHgMW2vlcBR2D2mCl31CcGgM9egqRCWrzYyYzlOzPe8b83ZBg66uiUvZ+zFgJ
         gQDPxZdOersp20VVEnGV1Ukhz9jUxrmvkmmr59wBdYMm6uhQZzb529I8BDfBRtiWxKTz
         hc+LpAfBL2d2mRFWSMdVM8Uw7cK+u3SMsq7T+wIK2bBU/+PY6R4DZ968jxVayq9w/WCh
         oekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ldyVwS09nc2OLJia/8NlZArMqqWxVI8EkShpKdO52GA=;
        b=uR8+SV1vGt+otMKNQDyWUniPEPw2C59cT5YIvLCeBNXqaOKOsU4+55lXcLIo31ZHmG
         envYg45vC8FCjj1BtHM1RfkE+CZ3XdeURPc907Zt7B3V5xZOFSUayCcsS6PibuuGGDfh
         d5l3KW5TdgBBjBI3weQeUdZ7ulrXCfG4DyxGAiERu1ZlQPAPbEh2lL709PLL4sk+4920
         cojFZb43GWOlCH7JXwK/9qLQgzSs9I2aMnbtG9M0fLqD8PVJ3ea2s8vqZMfp7wIs2m9A
         ee0FfpOTNUsZ1Y+fUDY4DpRk2BCFfIOGCY42U2lHiwiFY5MWHvwUfVwcWtwvr5at64X/
         XM3w==
X-Gm-Message-State: AOAM5310Y2YTaUKkH9E+/sUwvuqiqI+3JXzKqWkWd5tY6f9GCAU/Ok+3
        c3LxV3GjG7SFFcJrS8a8YmxJaYmRLII=
X-Google-Smtp-Source: ABdhPJxx8aqVKvIrPJKrJG15DnERYYD8QgNRF5r/JNX/wY52L/hJRqUWhl2uEzj9GgosGrcbaIAQXg==
X-Received: by 2002:a1c:2507:: with SMTP id l7mr6009571wml.186.1635345565031;
        Wed, 27 Oct 2021 07:39:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t6sm45249wrw.78.2021.10.27.07.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 07:39:24 -0700 (PDT)
Message-Id: <ad7013a31aa5688747c1606d8c38aa96365c3711.1635345563.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com>
References: <pull.1048.v4.git.1633984222.gitgitgadget@gmail.com>
        <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 14:39:16 +0000
Subject: [PATCH v5 1/8] reset: rename is_missing to !is_in_reset_tree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Rename and invert value of `is_missing` to `is_in_reset_tree` to make the
variable more descriptive of what it represents.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/reset.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 51c9e2f43ff..d3695ce43c4 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -131,10 +131,10 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filespec *one = q->queue[i]->one;
-		int is_missing = !(one->mode && !is_null_oid(&one->oid));
+		int is_in_reset_tree = one->mode && !is_null_oid(&one->oid);
 		struct cache_entry *ce;
 
-		if (is_missing && !intent_to_add) {
+		if (!is_in_reset_tree && !intent_to_add) {
 			remove_file_from_cache(one->path);
 			continue;
 		}
@@ -144,7 +144,7 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 		if (!ce)
 			die(_("make_cache_entry failed for path '%s'"),
 			    one->path);
-		if (is_missing) {
+		if (!is_in_reset_tree) {
 			ce->ce_flags |= CE_INTENT_TO_ADD;
 			set_object_name_for_intent_to_add_entry(ce);
 		}
-- 
gitgitgadget

