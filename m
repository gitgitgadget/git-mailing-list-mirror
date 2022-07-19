Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965CCC43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 15:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbiGSP0N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 11:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238137AbiGSP0M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 11:26:12 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482EA3ED53
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 08:26:11 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id ay11-20020a05600c1e0b00b003a3013da120so10225788wmb.5
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 08:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eMLk2V4CZBPxi6dPNvFs+ddn7odhnQlHhOIZJbHJcbc=;
        b=ToOTixhXTzCLgofBedAeWLHH8ugdXeJTt6TCpwIRtlD9srfgAIXfy1r1Y9YQikzds3
         t4yQLCBw0Roo1a92jfeS5vsHbI3HgOD+B/smWS6z1KnQKs6P7S8TuDruXxsjbeJ3i0gD
         GXUvTFWIjHJZ2Q6qP33SoOSCx58oeLF0HIURvrGoWoHSG4jQHRXAMrVlFeCjOprYf8Wf
         omCfSF9ooCAtYWggosJdFYg5aoxkHK/4EXeMaOR5614oRnA7ctpj0vLU/IaWieys/67/
         McWxsgbec0eH4qvNt94//mjyrOHPrJ7qB8aIpMRozlcUbrB5XDh6YmXSE80HBGBJqDJq
         Nfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eMLk2V4CZBPxi6dPNvFs+ddn7odhnQlHhOIZJbHJcbc=;
        b=3rDwanRytfZpDgrv9tNJZNnGQG7IFlOmmEKiY3kQLa+gM76S+9IZ2V8ayP9DyTNAtZ
         fTS4A68xxxdDxZ32oyWOKLhR6Lv0EC8bwb9PiE9+9j8aLhiCLqUeOqrrOtbXjICcuEMp
         EwIDfGe2Mtk73oVAO+8lep6ZcghZTlG/T2nV2lYDkmWi/Cs76WIpW9DSAv3Gvc1B4bjJ
         hO0SKvQ62bmYwH2NUOdvCLwBH76rrSk9kqWoQQYQ6AR6gHLoeKdgTh1KRxSbvEGX3HqZ
         tu68TCREsJ3LSrd1lxwgSWaV06XG14DFuv5O852Emw/Ktv8vcfnsoOE5rpCrNitcFI6w
         cshw==
X-Gm-Message-State: AJIora/4it/Zoe91RExbgvyGlz9Kyh1OetpWq5OIECmp2ctt7XBRWb7I
        QI3gQmUrGT4vgv+XmrvcDfNlzT95yiI=
X-Google-Smtp-Source: AGRyM1shWrE0ytSlm5Av2k4/HcMtOMxVQVVYQKBKITEZmOZPHKfKz5CXCBGTibshwQrDdAMOLWL4gA==
X-Received: by 2002:a05:600c:2194:b0:3a3:bea:1017 with SMTP id e20-20020a05600c219400b003a30bea1017mr20189156wme.44.1658244369181;
        Tue, 19 Jul 2022 08:26:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y18-20020a05600c365200b003a2c67aa6c0sm21886748wmq.23.2022.07.19.08.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 08:26:08 -0700 (PDT)
Message-Id: <a09fdbb8f3e42ff657cc6a0e66fde420afbe2af1.1658244366.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1292.v2.git.1658244366.gitgitgadget@gmail.com>
References: <pull.1292.git.1658176565751.gitgitgadget@gmail.com>
        <pull.1292.v2.git.1658244366.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 15:26:04 +0000
Subject: [PATCH v2 1/3] pack-bitmap-write: use const for hashes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        chakrabortyabhradeep79@gmail.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The next change will use a const array when calling this method. There
is no need for the non-const version, so let's do this cleanup quickly.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 pack-bitmap-write.c | 2 +-
 pack-bitmap.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index c43375bd344..4fcfaed428f 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -683,7 +683,7 @@ static void write_hash_cache(struct hashfile *f,
 	}
 }
 
-void bitmap_writer_set_checksum(unsigned char *sha1)
+void bitmap_writer_set_checksum(const unsigned char *sha1)
 {
 	hashcpy(writer.pack_checksum, sha1);
 }
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 3d3ddd77345..f3a57ca065f 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -75,7 +75,7 @@ int bitmap_has_oid_in_uninteresting(struct bitmap_index *, const struct object_i
 off_t get_disk_usage_from_bitmap(struct bitmap_index *, struct rev_info *);
 
 void bitmap_writer_show_progress(int show);
-void bitmap_writer_set_checksum(unsigned char *sha1);
+void bitmap_writer_set_checksum(const unsigned char *sha1);
 void bitmap_writer_build_type_index(struct packing_data *to_pack,
 				    struct pack_idx_entry **index,
 				    uint32_t index_nr);
-- 
gitgitgadget

