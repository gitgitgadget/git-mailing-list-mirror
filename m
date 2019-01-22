Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A56CE1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 21:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfAVVW1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 16:22:27 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43445 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfAVVWY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 16:22:24 -0500
Received: by mail-ed1-f68.google.com with SMTP id f9so20516499eds.10
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 13:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=717c7OdR6NBnQK3hRwJXlAkwGkauYy96P0xUlww47Sk=;
        b=Ei0cOa6ArjRRMvCi4nBqcvSPOCYkZ2cCdI0Ll8iYtjAZUkaMWRooC+xaiesAOldYDx
         CL8BkT7JQczUechxW91xsYiMhK8YmVfVaxOUJY2/jzViAmsDfrKeSpWu1uPEWnSAaXx2
         LkA+Ih4pS/R7SjoTRUwnvVAlIxOJ3zxzSE+zUhP9LvBADlij+kmpSakgO9dU+n+TA3+a
         6L3TBS+JxExSk1iHEjUybt0UOl2pux9wYbN60qS0zfAM7Bu2NrYt6qbOjZdFB8z6yh74
         AfIRnIRHWHWJguQTU+9AGAuL9K4YwLCl8ue9e1mMhRQlPxWpAJlxssJJWm0P/rqawub9
         OnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=717c7OdR6NBnQK3hRwJXlAkwGkauYy96P0xUlww47Sk=;
        b=M6QwfVH5337/aFMWIW2BJpTE5QJOL7mQRHhk2atYx8LySAczXAxNGxFEoRyWZcgWtY
         Ayjqj7XjTC0CdNPQdwMXFHBxQnJwfYAtiIqPPoaMs0uXVa8C3nNSL4uJS02yKtXBIIob
         CdgtH87lD1YVX9iklatccwSnXbOv2qaX7rOSNysIEHJEHD2+Ab9TQ8x33cmO62oXBWvm
         AL6n3NknxXwbsE9PM233yUShEQUZyUD3GT5sqftrChQggZ7aQJr44AsAqbrbs5i8aEvn
         prvTEuHMSXeWH+p47Yzo/TQ46XS2OENgAO9rthc8fAvtSRQrsvT0MmLcMnEJm9K4Xz2h
         buUQ==
X-Gm-Message-State: AJcUukemVxLVvNsw3DZdrrj/YgDY0uN4rn7M7PT2MblBdRJYLohi9b99
        dWHYr0bJnggLAeDCRey6K/nNNxeu
X-Google-Smtp-Source: ALg8bN7LE05BxNXn2xe0CovLaoAP6RUX+2QalRvFatW3iO1kYHO5buOfjCv8h/EOk/Q3U91lDHSfNQ==
X-Received: by 2002:a05:6402:1286:: with SMTP id w6mr127500edv.53.1548192142276;
        Tue, 22 Jan 2019 13:22:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d15sm9711409edv.20.2019.01.22.13.22.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 13:22:21 -0800 (PST)
Date:   Tue, 22 Jan 2019 13:22:21 -0800 (PST)
X-Google-Original-Date: Tue, 22 Jan 2019 21:22:08 GMT
Message-Id: <8446f69b5757c2193cefddfdea6fdfea355f30ff.1548192131.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.git.gitgitgadget@gmail.com>
References: <pull.108.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 11/14] trace2:data: add subverb to checkout command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/checkout.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6fadf412e8..8939ae99ed 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -262,6 +262,8 @@ static int checkout_paths(const struct checkout_opts *opts,
 	struct lock_file lock_file = LOCK_INIT;
 	int nr_checkouts = 0;
 
+	trace2_cmd_subverb(opts->patch_mode ? "patch" : "path");
+
 	if (opts->track != BRANCH_TRACK_UNSPECIFIED)
 		die(_("'%s' cannot be used with updating paths"), "--track");
 
@@ -952,6 +954,9 @@ static int switch_branches(const struct checkout_opts *opts,
 	void *path_to_free;
 	struct object_id rev;
 	int flag, writeout_error = 0;
+
+	trace2_cmd_subverb("branch");
+
 	memset(&old_branch_info, 0, sizeof(old_branch_info));
 	old_branch_info.path = path_to_free = resolve_refdup("HEAD", 0, &rev, &flag);
 	if (old_branch_info.path)
@@ -1189,6 +1194,8 @@ static int switch_unborn_to_new_branch(const struct checkout_opts *opts)
 	int status;
 	struct strbuf branch_ref = STRBUF_INIT;
 
+	trace2_cmd_subverb("unborn");
+
 	if (!opts->new_branch)
 		die(_("You are on a branch yet to be born"));
 	strbuf_addf(&branch_ref, "refs/heads/%s", opts->new_branch);
-- 
gitgitgadget

