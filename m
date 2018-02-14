Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D19041F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162529AbeBNTBV (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:01:21 -0500
Received: from mail-yw0-f202.google.com ([209.85.161.202]:37223 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162516AbeBNTBP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:01:15 -0500
Received: by mail-yw0-f202.google.com with SMTP id e129so2871612ywb.4
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=82xlf5P5n7axzPfS9Z9oNiG2AakgeFTv23JkymXF7/k=;
        b=AigU9i7IFsrjVRxiHfjHdzOb4Keme6SLiTbp3TceYJsB1VwoES1Ltnfitwl/zV/XeU
         KUWL85+L9VEcZWB7HJQQXTZ+oDa2/FGSGb6ADyzH5jDKG2RSrloHAb5SWi6xuw6SCWFD
         EtYMFA048P7v1oSuMH+aGiO0DFY78OFF+AsJz5v6P3ludODSdfDp8sUIbGIfdqXnXH0M
         pTEp0SViSx/KNYU/5hEEtENROIhz2in7P2ArdKf64spm0emJz+LPy0y1MhkOOlUb0cwY
         lZw/tdPB9dXnFjLQcjaC+aaclNOIIRfZ9r6B7opzWxbKoODbD11B8/H6zYrezZLpckZ3
         JzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=82xlf5P5n7axzPfS9Z9oNiG2AakgeFTv23JkymXF7/k=;
        b=GSva9L6+MwtbmUj1GdOn8NzMrbRxseHRk7pfa57qlBJkjPkI24+DFrYMUDt8QZxt7z
         GzohGhBatLojOMY0LrAC0D4vYBmTJxLHUGxxVCIBvqOQZT3Ik9dNYiVeb7cnfpMMBheF
         sRNMK9FzvcdIEb+qboSVBejMHc7TQTjvx8/sqDHL9f7KcowMN0i+aOsmfEfYPzNzGcq4
         uXZeQPc/Xf8OoFfDfCsUdAGHAmz2fgULEa6ih9dNZhiehCGeq62XkTprEqK6qMf3y5b/
         7Rf2TvkkxDkmwe5gu7jbULHi+rZzybGFZDhDkcZyJutuw9kzxw0dtHTOzO84j2j+URM+
         10bA==
X-Gm-Message-State: APf1xPDrXjzOWoH/hLG1AfHYNgdMDkxeBds7aTOtnLCFPat/CgapqhkS
        J6L5APZyYoJI7gW5dyKfLeTbWOVcPuf3ZxRV3Rv8lauZCB2bHe+AXTidcM56z2GUclUYxSNKVoz
        YTkih+IICTYi7Xldk6cFjm4zDysQeuk52ibm73PVqzdt0Urq6DeDzudn2KA==
X-Google-Smtp-Source: AH8x225F5TaE0MmQrhBsVQhmIGkWtyJhb4jKKf6FhHsgsB7F+cpk5CQm5krzFfxD/YeFFX0+zGF6rRGoei0=
MIME-Version: 1.0
X-Received: by 10.37.214.210 with SMTP id n201mr1249807ybg.23.1518634874690;
 Wed, 14 Feb 2018 11:01:14 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:34 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-13-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 12/37] reflog: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, avarab@gmail.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/reflog.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 223372531..ac3dcd7a5 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -289,20 +289,20 @@ static int should_expire_reflog_ent(struct object_id *ooid, struct object_id *no
 				    const char *message, void *cb_data)
 {
 	struct expire_reflog_policy_cb *cb = cb_data;
-	struct commit *old, *new;
+	struct commit *old_commit, *new_commit;
 
 	if (timestamp < cb->cmd.expire_total)
 		return 1;
 
-	old = new = NULL;
+	old_commit = new_commit = NULL;
 	if (cb->cmd.stalefix &&
-	    (!keep_entry(&old, ooid) || !keep_entry(&new, noid)))
+	    (!keep_entry(&old_commit, ooid) || !keep_entry(&new_commit, noid)))
 		return 1;
 
 	if (timestamp < cb->cmd.expire_unreachable) {
 		if (cb->unreachable_expire_kind == UE_ALWAYS)
 			return 1;
-		if (unreachable(cb, old, ooid) || unreachable(cb, new, noid))
+		if (unreachable(cb, old_commit, ooid) || unreachable(cb, new_commit, noid))
 			return 1;
 	}
 
-- 
2.16.1.291.g4437f3f132-goog

