Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB4DC433EF
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2CE860F21
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbhJKUc1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 16:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbhJKUc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 16:32:26 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6A6C06161C
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 13:30:26 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e3so26293718wrc.11
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 13:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ldyVwS09nc2OLJia/8NlZArMqqWxVI8EkShpKdO52GA=;
        b=OlXK9T0ach0KytFLX22aieHJPrTj+qJk93CXmgdk3suueaeSwlthgZKZOuuzn6yhl4
         LA1bGAeKVLHhHNtd4ecyhoLlxr58Urq29LWd38O8hBB/NFLaQEBEv35xSEAcZfyfqnYA
         6NKS20NXpr6qTAT4oaAqvh1djjiYnm8lImRkd4u+bFHkmYzqN2xxzjQlD7ASw7SzsfVt
         Oos718wdLB7w6zrO92+eTTjRZutCKG6JKIupu7bNyt2zT744wsRZ7VG/RMn3X3YeUlnS
         me83pi9WmLCFJN/9i3/GVffdfmdVu4WuH3MOyi/VuijxiP0uu4iBodbKmC/aIK6JCf4E
         YnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ldyVwS09nc2OLJia/8NlZArMqqWxVI8EkShpKdO52GA=;
        b=4dqb5g08M8hlrWDeuInXzg+oOeToQiOSgJAj1J/gExdF5pzEmPMnjQekm2VJC70Qhn
         lP+BmBpYO1hMwDKopEH9xX4GjzvtdTzBrgOINyhX2utpOp3c6XQPCSyTXoChWHhWwyYq
         vCY1rteGwybh6W/tYHcvxd/y+NeoEOneVUgwk9DpBFcf7E3+zhT9Oli2o6plQWWmqXgf
         00inBYnPXp0QZKMc5jvcq1QdjHNPuewi0Z3Y7TEKPp1m8GjQF+jykB5dMoUT8XXCiMGa
         xzpgGyU0YTv6HHSbEzlYlq4qFuEkPs+yoh20lpywNz6FBVjh6qzxHY9hu9+Vyve4VaCK
         CYuw==
X-Gm-Message-State: AOAM532j3nBTx/Goo+5eYOZYw7qsaw0SJwk3dRc3y57fz6y4UzlzYUcQ
        aft5R5/ph1TiBHD0XpQCJJRGxHVzG5o=
X-Google-Smtp-Source: ABdhPJzbgnoDSvV63yoZnmyRlZTeM5uIG4JMQ0TAUWM8W4bxxlyjJ7pYJXftv7wsUBaoIyE8GGKiAw==
X-Received: by 2002:adf:a496:: with SMTP id g22mr28191934wrb.13.1633984224808;
        Mon, 11 Oct 2021 13:30:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2sm8515718wrr.35.2021.10.11.13.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 13:30:24 -0700 (PDT)
Message-Id: <ad7013a31aa5688747c1606d8c38aa96365c3711.1633984222.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v4.git.1633984222.gitgitgadget@gmail.com>
References: <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
        <pull.1048.v4.git.1633984222.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 Oct 2021 20:30:15 +0000
Subject: [PATCH v4 1/8] reset: rename is_missing to !is_in_reset_tree
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

