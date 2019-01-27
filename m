Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 731D11F453
	for <e@80x24.org>; Sun, 27 Jan 2019 00:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfA0Agw (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 19:36:52 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40691 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfA0Agw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 19:36:52 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so6362342pfo.7
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 16:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xrfdfKGDWIEkJ+syWQznXDqW3LBPzTMgtG17CCJwMh0=;
        b=dqMkdvdRQigpyvbizhc5Iw+kiEqNIj+SfkcUYprzS33qUTJ3rNCihV3DEz49iUbVIX
         70j9649XBc6mfSDbZenrymWPL95QKMlFE8+cGFMvN+qt2HO8CtKmORtKxxZKkDjPL/Cs
         7gAGFy5p196Y+YLT1H4gVuf01+3Llasd1+XR6nPCytaAyEUaJ9Q/be1YfjvHxnhzCc9Z
         wP+lQUr9x8GyH6A6M6wK0KLiqtRTuJpm9yJbnq/766aKWyBv3Ex6BaeVAbR8jNGFszTH
         czDoWJYT7wg1kuWmMAzdojwG7FJXKY8jI98nmY1PqXSnjt3i0zl9DINh7T+a9F58we1H
         uK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xrfdfKGDWIEkJ+syWQznXDqW3LBPzTMgtG17CCJwMh0=;
        b=FIQJP8grA6BZ/ZOoy+sZKxA6mCOGLoTdE7yAfsmj2QITZN8yxQ+Og5kP1pYzCZzQPw
         g8P9pbQPnZ+M8o17qkMHiE7wyFtWW0GNHq3dT9xMIaO2oOezF4hOwpuwKPCMCSTrxA0P
         vGnNe0MYwZqK5CHxUxFL4Ry/rSHpjWbk2NsEFm0GKhtPqDzZLCq2ktHeq5YUh2YOmIbz
         j+dMJi86uLwhdC/DIFdyI1DYZONxmkqQJ+BsbLtYfe/xVP4/J70WWZTV9EbCFq3pKRzu
         pxV5nOmVaNg4O2mg6Ifbc82Pv5oLskpug6d8KzkLusIMCn7RmzO/qyyFEg2QYpPKupJH
         IReA==
X-Gm-Message-State: AJcUukekME1eCrsXKRypNLPVCtvCgQ2rGjskjs96YnZPHDh/gW2rw1yo
        vD9FVQsa4bAzMzrigaKZFt46l3tn
X-Google-Smtp-Source: ALg8bN7/Q0CLWbRyESirFNH6GT0/HKC9Gf2NTI4qtVP2Z3AqCVleefvGwX77gi//xbucHkJ4qTwVkw==
X-Received: by 2002:a63:9c1a:: with SMTP id f26mr15052005pge.381.1548549411320;
        Sat, 26 Jan 2019 16:36:51 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id u123sm40728870pfb.1.2019.01.26.16.36.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 16:36:50 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 27 Jan 2019 07:36:46 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/14] diff.h: avoid bit fields in struct diff_flags
Date:   Sun, 27 Jan 2019 07:35:30 +0700
Message-Id: <20190127003535.28341-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
In-Reply-To: <20190127003535.28341-1-pclouds@gmail.com>
References: <20190127003535.28341-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bitfield addresses cannot be passed around in a pointer. This makes it
hard to use parse-options to set/unset them. Turn this struct to
normal integers. This of course increases the size of this struct
multiple times, but since we only have a handful of diff_options
variables around, memory consumption is not at all a concern.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.h | 66 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/diff.h b/diff.h
index c872a41344..8abe1649d0 100644
--- a/diff.h
+++ b/diff.h
@@ -64,39 +64,39 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 
 #define DIFF_FLAGS_INIT { 0 }
 struct diff_flags {
-	unsigned recursive:1;
-	unsigned tree_in_recursive:1;
-	unsigned binary:1;
-	unsigned text:1;
-	unsigned full_index:1;
-	unsigned silent_on_remove:1;
-	unsigned find_copies_harder:1;
-	unsigned follow_renames:1;
-	unsigned rename_empty:1;
-	unsigned has_changes:1;
-	unsigned quick:1;
-	unsigned no_index:1;
-	unsigned allow_external:1;
-	unsigned exit_with_status:1;
-	unsigned reverse_diff:1;
-	unsigned check_failed:1;
-	unsigned relative_name:1;
-	unsigned ignore_submodules:1;
-	unsigned dirstat_cumulative:1;
-	unsigned dirstat_by_file:1;
-	unsigned allow_textconv:1;
-	unsigned textconv_set_via_cmdline:1;
-	unsigned diff_from_contents:1;
-	unsigned dirty_submodules:1;
-	unsigned ignore_untracked_in_submodules:1;
-	unsigned ignore_dirty_submodules:1;
-	unsigned override_submodule_config:1;
-	unsigned dirstat_by_line:1;
-	unsigned funccontext:1;
-	unsigned default_follow_renames:1;
-	unsigned stat_with_summary:1;
-	unsigned suppress_diff_headers:1;
-	unsigned dual_color_diffed_diffs:1;
+	unsigned recursive;
+	unsigned tree_in_recursive;
+	unsigned binary;
+	unsigned text;
+	unsigned full_index;
+	unsigned silent_on_remove;
+	unsigned find_copies_harder;
+	unsigned follow_renames;
+	unsigned rename_empty;
+	unsigned has_changes;
+	unsigned quick;
+	unsigned no_index;
+	unsigned allow_external;
+	unsigned exit_with_status;
+	unsigned reverse_diff;
+	unsigned check_failed;
+	unsigned relative_name;
+	unsigned ignore_submodules;
+	unsigned dirstat_cumulative;
+	unsigned dirstat_by_file;
+	unsigned allow_textconv;
+	unsigned textconv_set_via_cmdline;
+	unsigned diff_from_contents;
+	unsigned dirty_submodules;
+	unsigned ignore_untracked_in_submodules;
+	unsigned ignore_dirty_submodules;
+	unsigned override_submodule_config;
+	unsigned dirstat_by_line;
+	unsigned funccontext;
+	unsigned default_follow_renames;
+	unsigned stat_with_summary;
+	unsigned suppress_diff_headers;
+	unsigned dual_color_diffed_diffs;
 };
 
 static inline void diff_flags_or(struct diff_flags *a,
-- 
2.20.1.560.g70ca8b83ee

