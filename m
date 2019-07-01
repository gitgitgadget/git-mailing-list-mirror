Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEFB91F461
	for <e@80x24.org>; Mon,  1 Jul 2019 20:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfGAUU4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 16:20:56 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:42411 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfGAUUz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 16:20:55 -0400
Received: by mail-pf1-f202.google.com with SMTP id y7so9442852pfy.9
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 13:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Pp0OkZW/FgkuU6MiSbk6EZpEpgnCMkWIlsh0VlMIusk=;
        b=Tj3+tv+4giqrTHNSkH/DgANQm0r/3P9slff4GkYHfcInV5R3R0xsCcP5Qe+iHW/Xwv
         DWkWCtoyWh3W1ldgAdQIvAcCe6IY4TqXAGJ4ejYQneFDH9zXAjZ0nh3D32A7xFHG06gz
         IiINT6d1hZ8ZyF764jvaUw4nHMbzVTvYkR5bJobvARcCHPtbWTlRxEAcr3tvi9s5d4Bc
         jEdv2SQVkSn8RaMgVSfT7DJLiovgnzqMGhCRrqByq7CY2eYcmsNIbt9xqyak+tJuew7a
         G4qKurvutyayW/V4kk4p2oIa/c3yZZcYOoecCLBpkMg2mxXcR7MUB9p8KFEWWvPEzKOV
         U6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Pp0OkZW/FgkuU6MiSbk6EZpEpgnCMkWIlsh0VlMIusk=;
        b=CIsKKgfMePg2eYB/nXNIwkEj1WPgxbrGBrXwiugRuS6xOFqUy684zqz5ZYMCKPKI7R
         RkYWMYHbx8uDj3VCrn1Xq7l7k2q7J9xBx+xzL4RGclAeB35+6e5DZU1WSWwjiF1xzqsR
         8JnOkwgm0hgIi3h6hAf71tFxi78FiN2T7kACM+cG+3p20Z2VRqfsOBG7aVzhdJqqm0vS
         xfZdoJWv/Lbyt1+fppleFdH1lSQE3DEERAwKO5X6AUljLNab+ZKRPJJNgfJ8G6hYpxs0
         dcSD9C4LZnZ3/ZJh9LQV8AubFTCgYWvoZTVMPgLhxXMu+aAT5IrzkpajkjHn2XDlg4BA
         R6HQ==
X-Gm-Message-State: APjAAAU3KnOAAfvMrZrm3JBv6nOSIVxlL6Rl1Y3nOWhOyv3XSqCfjpBn
        3+Q+I4bv6ypcC6EEqAJlDalxzns8oGGhccc7YEyKeulBTgKDrDLiPMA8SOkZ51a4FxgncJW+c5O
        nVU3YLxt8mf9V0uv8eKw7QSGZZmEagsMVgvTAR6LfZcY32Df5hfW7NVbeoWO8/fOFdVD1D8lH+w
        ==
X-Google-Smtp-Source: APXvYqxav2W9gm9cqfdaCDjIwfga0lAM2wsvqZaL0ECVPBuiwUOnDhSc17nkhKnU1OUOMtB0Pacf9drkMara7BZZuIs=
X-Received: by 2002:a63:e317:: with SMTP id f23mr26143784pgh.39.1562012454769;
 Mon, 01 Jul 2019 13:20:54 -0700 (PDT)
Date:   Mon,  1 Jul 2019 13:20:14 -0700
In-Reply-To: <20190701202014.34480-1-emilyshaffer@google.com>
Message-Id: <20190701202014.34480-14-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190701201934.30321-1-emilyshaffer@google.com> <20190701202014.34480-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH v3 13/13] walken: reverse the object walk order
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Demonstrate that just like commit walks, object walks can have their
order reversed. Additionally, add verbose logging of objects encountered
in order to let contributors prove to themselves that the walk has
actually been reversed. With this commit, `git walken` becomes extremely
chatty - it's recommended to pipe the output through `head` or `tail` or
to redirect it into a file.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Change-Id: I91883b209a61ae4d87855878291e487fe36220c4
---
 builtin/walken.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/walken.c b/builtin/walken.c
index 1638f679f2..2eb12f92ed 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -104,11 +104,13 @@ static int git_walken_config(const char *var, const char *value, void *cb)
 
 static void walken_show_commit(struct commit *cmt, void *buf)
 {
+	printf("commit: %s\n", oid_to_hex(&cmt->object.oid));
 	commit_count++;
 }
 
 static void walken_show_object(struct object *obj, const char *str, void *buf)
 {
+	printf("%s: %s\n", type_name(obj->type), oid_to_hex(&obj->oid));
 	switch (obj->type) {
 	case OBJ_TREE:
 		tree_count++;
@@ -157,6 +159,7 @@ static void walken_object_walk(struct rev_info *rev)
 	rev->tag_objects = 1;
 	rev->tree_blobs_in_commit_order = 1;
 	rev->exclude_promisor_objects = 1;
+	rev->reverse = 1;
 
 	if (prepare_revision_walk(rev))
 		die(_("revision walk setup failed"));
-- 
2.22.0.410.gd8fdbe21b5-goog

