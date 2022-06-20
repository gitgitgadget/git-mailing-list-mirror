Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0084BC43334
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 12:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240227AbiFTMd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 08:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242766AbiFTMdY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 08:33:24 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6612D13CE4
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 05:33:23 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id j5-20020a05600c1c0500b0039c5dbbfa48so7693568wms.5
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 05:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=f3k/zoH0LfINS3pkX23UdFehADMYmGQwxuchnEd6NIY=;
        b=hdRDuNdtLvnbju9dEDETskhui3SqKgJEL34ejE+ZT5loI5ia4RwutZ0ik3JhQbth1Q
         oLwu/34TpiK2K4dcdmkLDMvPDxc9tSd7P1WVaWlTj5THXXdkq1Xp+uCBooT8rz4Alkxv
         9y4QgO3yHpKAfLQVUuphEFpbsMtGfcFR+/rVNOFpQrBHxz9Y6DX+uz4Tc/SBTYMSeFXX
         bJ5TO4J9yAXwy7BsNpLiiuCfcP+WxmezQVhfEYa1nEGGOCh+NIcfNHpLJESAFLPLDign
         J/4emhyK9TNdB75rSKPUJdpXsfIzrJxzsCupGcxaEWhSQ76dXhp/2+z1+md2xB0DNiIm
         Uhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=f3k/zoH0LfINS3pkX23UdFehADMYmGQwxuchnEd6NIY=;
        b=X9HL8wSba5RPXOXU9fvYPlRWBu7D8/omlUaGhi8Jn8jC053IddfLbpQNbAWmr03s8u
         yGLcIFBuadd5KaF+NzXEgdP+CPMlT3WqYiKvOglSJwO1eJJilVps16dwVu8xqV1+V4BP
         GDL1m9u0IV+gM1ih+iVAd9nVE3d19R0qEVOcuZYc3FWn8qfomEWHoOKj2MjHaLwNtnop
         h4dZiiTZV8pM37mgj7JsEe56igw8yMlW1XM2bqxcM1EQEspGqn+KhoWjg/q5cVwQnGV2
         j017LDV9piXb6hu9qiq7MDQEEEsPCLqY+ODEYhwA5F/b3954FHARKIoIHZ/hozl77+F8
         4ioQ==
X-Gm-Message-State: AJIora/lORBQtCuYPkZ4H/pocnfz4qpsRPU7ZGuB8MSYX4zC5X2HHbum
        fCcFnGieZYBAxfQCz2rTOD3w3Di6zKeUGA==
X-Google-Smtp-Source: AGRyM1t/cLeh1P4LCZAUhhmW/cZbfuf23P2vogwl+hr+ibP3/YjzYZ7BEuKpQC6W2SXNcFQ4iy80Cg==
X-Received: by 2002:a05:600c:228e:b0:39c:47a8:a870 with SMTP id 14-20020a05600c228e00b0039c47a8a870mr24718722wmf.136.1655728401520;
        Mon, 20 Jun 2022 05:33:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b0039751bb8c62sm19366009wmq.24.2022.06.20.05.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 05:33:20 -0700 (PDT)
Message-Id: <661c1137e1c918619f6624d2e331bafd9c3281dc.1655728395.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
From:   "Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Jun 2022 12:33:12 +0000
Subject: [PATCH 4/6] builtin/pack-objects.c: learn pack.writeBitmapLookupTable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Taylor Blau <ttaylorr@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Taylor Blau <ttaylorr@github.com>

Teach git to provide a way for users to enable/disable bitmap lookup
table extension by providing a config option named 'writeBitmapLookupTable'.

Signed-off-by: Taylor Blau <ttaylorr@github.com>
Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 Documentation/config/pack.txt | 7 +++++++
 builtin/pack-objects.c        | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index ad7f73a1ead..e12008d2415 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -164,6 +164,13 @@ When writing a multi-pack reachability bitmap, no new namehashes are
 computed; instead, any namehashes stored in an existing bitmap are
 permuted into their appropriate location when writing a new bitmap.
 
+pack.writeBitmapLookupTable::
+	When true, git will include a "lookup table" section in the
+	bitmap index (if one is written). This table is used to defer
+	loading individual bitmaps as late as possible. This can be
+	beneficial in repositories which have relatively large bitmap
+	indexes. Defaults to false.
+
 pack.writeReverseIndex::
 	When true, git will write a corresponding .rev file (see:
 	link:../technical/pack-format.html[Documentation/technical/pack-format.txt])
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index cc5f41086da..3ba20301980 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3148,6 +3148,14 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		else
 			write_bitmap_options &= ~BITMAP_OPT_HASH_CACHE;
 	}
+
+	if (!strcmp(k, "pack.writebitmaplookuptable")) {
+		if (git_config_bool(k, v))
+			write_bitmap_options |= BITMAP_OPT_LOOKUP_TABLE;
+		else
+			write_bitmap_options &= ~BITMAP_OPT_LOOKUP_TABLE;
+	}
+
 	if (!strcmp(k, "pack.usebitmaps")) {
 		use_bitmap_index_default = git_config_bool(k, v);
 		return 0;
-- 
gitgitgadget

