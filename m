Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE1C81F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 16:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfJOQoJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 12:44:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42502 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbfJOQoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 12:44:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id f14so7365502pgi.9
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 09:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5TuZx4A7Y7/dyKYPRb+DDLdDJdv324EXmTQdv5FXnzs=;
        b=c6ZrVq8ufbZ4+UYtdhxZa5L3wXSo1sV2Db4OjLl7Y9NqAR5EsfC84FzTpNHI7FOMVg
         CXSnz0tK/zODDJgRwEqywvSQXz0KWfI7A8KCY9vyTiUSy8dMkjKvsldphm94RRidT5i1
         SUr5yLDL4IeEpZSAlJYcbul0Rg63x8Hveyw2DWC9DrrYr5HCbuQcyxupk08lKWyo/Smi
         nFMLNLoYhgvHkewcM3hM6wzjekY+uXmMbHymMvwpZEgG39SCvS26uMKk7+vSEIHTJ7gS
         9x9qQ94WJFcAzPxL9ByLLThb9dS0VSdubSWDU7In2LjtsJZIZZ7buk2Wn+SaAYine3ES
         cA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5TuZx4A7Y7/dyKYPRb+DDLdDJdv324EXmTQdv5FXnzs=;
        b=Ecc17HUx1A0MOp6oROSAhId+MvgLxA9Fb73/1cikRaYH1wdNwu4wU5VOCpIQbhOLmF
         bbusv2d5OWwcPvwY5i+YviveaICZVFq0B3EMWqg7S/SlLXyPvgvgB8PiJg+QTvCuhMZd
         0MR4F1CUNxL83i0bi7kyGbZ/nwKetOXRMvNtDKxL11ILaysWIEYd/5ma6JfL2bttRUas
         RoqmxjKIbHEHYujbEuqomgEVNJYvSVx2hsPBXehPrJSbkkUikT/hfiWydhjHh+HzGJI7
         IkNQAr3/RaUwRf42pO5MoNV3VajtxZBdZLIpePdW0+R+NrjJ3L1mtKDqRxzNZSGCFaWF
         mESQ==
X-Gm-Message-State: APjAAAWs4nzDbJ7fBDye2v+vHjzraco9jEyBC5UbcndhzpQP6K25tjof
        u3+5lbzqe1I0p5AKuPCnK487egJl
X-Google-Smtp-Source: APXvYqypo4sSdjuvBw9Ho/9+vc/7efWJ/vYP2F7bdi/B4OxZYGubcz4Lblc6wNSTZqF9QQaT0hqQjw==
X-Received: by 2002:a62:fc12:: with SMTP id e18mr21874033pfh.111.1571157422481;
        Tue, 15 Oct 2019 09:37:02 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:2b61:f51c:7233:c8a4:1e74])
        by smtp.gmail.com with ESMTPSA id c8sm9347151pjo.1.2019.10.15.09.37.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 09:37:01 -0700 (PDT)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH 0/1] Allow default value for target of git-notes copy
Date:   Tue, 15 Oct 2019 23:36:30 +0700
Message-Id: <20191015163631.21808-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As an alternate for the incoming patch,
this snippet could be used to eliminate some dead code in builtin/notes.c
Since `argc' will always be 2 in the removed condition.

Also:


Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---

 builtin/notes.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 02e97f55c5..641ae66f75 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -488,7 +488,6 @@ static int copy(int argc, const char **argv, const char *prefix)
 {
 	int retval = 0, force = 0, from_stdin = 0;
 	const struct object_id *from_note, *note;
-	const char *object_ref;
 	struct object_id object, from_obj;
 	struct notes_tree *t;
 	const char *rewrite_cmd = NULL;
@@ -525,10 +524,8 @@ static int copy(int argc, const char **argv, const char *prefix)
 	if (get_oid(argv[0], &from_obj))
 		die(_("failed to resolve '%s' as a valid ref."), argv[0]);
 
-	object_ref = 1 < argc ? argv[1] : "HEAD";
-
-	if (get_oid(object_ref, &object))
-		die(_("failed to resolve '%s' as a valid ref."), object_ref);
+	if (get_oid(argv[1], &object))
+		die(_("failed to resolve '%s' as a valid ref."), argv[1]);
 
 	t = init_notes_check("copy", NOTES_INIT_WRITABLE);
 	note = get_note(t, &object);
-- 
2.23.0

