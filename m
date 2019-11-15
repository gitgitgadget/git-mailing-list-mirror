Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A5B41F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 14:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfKOOQD (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 09:16:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42091 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfKOOQD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 09:16:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id a15so11136245wrf.9
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 06:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9jtPV+sCn/emRq7GWYLrHWbMxGrAYFh/6kTAYGDHCUY=;
        b=cSrtY0YiqCWLqhu/DeOgtNHn87diN7tfHlTt4MZTXWltxZj8Nm8S4dmMaLJdrHf4a4
         O624yijItPwmRstuUin/phJuyX3mHRjcwf+/3uJiXG7cdbAiJpLcZThJsTjTZLBqo0jw
         P9qAP5ixZjq/ea/BF1gY/+29eBSyk2h0efbA00URV2D/UJOZcWiHIR3IPeKbhO/MbTPk
         XMtsHxbP6QvUaMuKdxe/BmNE6b/cMq4diLAGFZvFKRp/FD1FakemwQpJKANDCpb/hy17
         fM/FZvctdb7kHlm2O2YwdOkdE5pCrCdlaoBWm6/gYRLNhYJu+8FlP/cCWd/iCe5LC7Gh
         zGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9jtPV+sCn/emRq7GWYLrHWbMxGrAYFh/6kTAYGDHCUY=;
        b=Tcv8PxmuTZWceZGj06UQKFrsC1ZgVzPDWyfVNOCMKkExzbl9BxkpryDgbyjLCmBX9b
         oW9vmv9krY4YEGU3ZueBa+NEv0jJKAxn0LOVBeitpkVNQJp1X+OMCoWeu9MoP0u6c3MB
         NEO+DSNzgQKPGtIGtEwZmqkFVGVNJkW8ef/lkJkQ+ry2YJXqcHh8RUigPyA+RW3f7DTH
         WT3tBDGYL2VCVJbHx2Ni0Op4Veg2Q28iN0MAt2itiyL3ZNCGMsS1elAHVwMrqANU7rnm
         h9pkk8MiZSdavV6oZf3qONFtCm3q3daIga5Zjc7PKSC0L7Xgz1VCrCkBhIe3Hqchwn9r
         l5tw==
X-Gm-Message-State: APjAAAU+8fUyHuIjafkgs3iAV/HXjZlrfiZr6o1GTahcyyWLHmCfV/va
        ehUuGkLFzkfQtQE/uCoJ8bR7dn9C
X-Google-Smtp-Source: APXvYqzUVUUODiba7wozoG8o/Ww3tUxixv5tYjXamAhJro0XA8W4Cy5ec+LlQLtOvHm6+N/ZMbN9kA==
X-Received: by 2002:a05:6000:18e:: with SMTP id p14mr15441667wrx.98.1573827360962;
        Fri, 15 Nov 2019 06:16:00 -0800 (PST)
Received: from localhost.localdomain ([2a04:cec0:1050:ac52:b4cd:f6a2:ba59:f1d4])
        by smtp.gmail.com with ESMTPSA id a2sm7907874wrt.79.2019.11.15.06.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 06:16:00 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v3 2/9] packfile: expose get_delta_base()
Date:   Fri, 15 Nov 2019 15:15:34 +0100
Message-Id: <20191115141541.11149-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.24.0-rc1
In-Reply-To: <20191115141541.11149-1-chriscool@tuxfamily.org>
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

In a following commit get_delta_base() will be used outside
packfile.c, so let's make it non static and declare it in
packfile.h.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 packfile.c | 10 +++++-----
 packfile.h |  3 +++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/packfile.c b/packfile.c
index 355066de17..81e66847bf 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1173,11 +1173,11 @@ const struct packed_git *has_packed_and_bad(struct repository *r,
 	return NULL;
 }
 
-static off_t get_delta_base(struct packed_git *p,
-				    struct pack_window **w_curs,
-				    off_t *curpos,
-				    enum object_type type,
-				    off_t delta_obj_offset)
+off_t get_delta_base(struct packed_git *p,
+		     struct pack_window **w_curs,
+		     off_t *curpos,
+		     enum object_type type,
+		     off_t delta_obj_offset)
 {
 	unsigned char *base_info = use_pack(p, w_curs, *curpos, NULL);
 	off_t base_offset;
diff --git a/packfile.h b/packfile.h
index fc7904ec81..ec536a4ae5 100644
--- a/packfile.h
+++ b/packfile.h
@@ -151,6 +151,9 @@ void *unpack_entry(struct repository *r, struct packed_git *, off_t, enum object
 unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
+off_t get_delta_base(struct packed_git *p, struct pack_window **w_curs,
+		     off_t *curpos, enum object_type type,
+		     off_t delta_obj_offset);
 
 void release_pack_memory(size_t);
 
-- 
2.24.0-rc1

