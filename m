Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64440C433FE
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 21:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 475E2610A5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 21:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbhJGVRi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 17:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbhJGVRg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 17:17:36 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE527C061755
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 14:15:42 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r7so23067271wrc.10
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 14:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ldyVwS09nc2OLJia/8NlZArMqqWxVI8EkShpKdO52GA=;
        b=RF81/+dYDiUUltsdKX6Amm90KelFSEfQp+aqh29kF4zyQW/sJsOuox9xnzN4NoKdKu
         cjI/XSKGNYTG7dttxhtZXmoeq8JvBGmZ9NIncOs+W3yaViz7x7Wfou6C++IYbWiQXYKP
         Kkwbs8XUReQpJEfQixxPbkQ6SONIrkQ0C98Vjrs+1zSLzgbdkwFngZbL5xfS0cYdwjQ7
         KPKxVbf8bocZYlYO1Mi1873gkIE3JCGRJgStovXLAr/ITxTZo9C+FLfR7yiSqAh55XXU
         fKi8gkgednkiGvQ4nuGN6wAyRiqFpcThBYm8UpScVnLrfgeAnvxd9xS4jjTaAqnjMk4F
         Blig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ldyVwS09nc2OLJia/8NlZArMqqWxVI8EkShpKdO52GA=;
        b=JbUjZ6YtIBOQEx/sU4y5HNaKQobJ++/OQitwAL1RnhqPdIqouXIfDrke3npXxX6ZzR
         LQLuUro8QkDCwQF3qtiFcl0rgZs9qwDqPUUfgNPmes+jyWWHv9cVtZIQIo/KdfFMu3nu
         A/gYWHRgNHFnKyAnAai4RX6QjVz4GlA8zQD0zbywDd3kcpJS2HgrKjgpoaLAGP0k8VFI
         rQI/WsApKwLbeznlCIAKFL4bP5Vd+x74ESlB4odhN9otdgJHm7AsOE6jvvHlwtHA5b9u
         WZkvA7BrY87HJn2cs6d04q+kwnHjFa7FUG0SF/XZeYS2k7Jdkvo3POlcsah+6EscaMB/
         PA8Q==
X-Gm-Message-State: AOAM533i2uKMZB24ZJ+TGA1R7VYpjX12UtHoy3zJ1mvHksNKgCa/5Sre
        yGXy9cbmd0kIum4hQymjcD7n8ZUDMFo=
X-Google-Smtp-Source: ABdhPJxR8u0ti1tpCc51jBu8plghcI+pmiFij/jR9KqVoyUwTHFEZ8IPGxzqj3L5o1wofdmhqlTktQ==
X-Received: by 2002:a05:600c:2193:: with SMTP id e19mr7150075wme.38.1633641341357;
        Thu, 07 Oct 2021 14:15:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z79sm501749wmc.17.2021.10.07.14.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 14:15:41 -0700 (PDT)
Message-Id: <ad7013a31aa5688747c1606d8c38aa96365c3711.1633641339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
References: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
        <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 21:15:31 +0000
Subject: [PATCH v3 1/8] reset: rename is_missing to !is_in_reset_tree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
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

