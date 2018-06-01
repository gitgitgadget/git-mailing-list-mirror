Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F7E51F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 21:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751053AbeFAVKl (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 17:10:41 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:32932 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbeFAVKh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 17:10:37 -0400
Received: by mail-wr0-f194.google.com with SMTP id k16-v6so10267272wro.0
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 14:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Iw2YiB/ZkIh4oCVAMKTf2c/oj+UFgHHJJM7iLMD06Cw=;
        b=mhaBeA21FVWwEWLOZaHOBl1Ph56tQDJXkUgLItu0gFlzCcxKfpBvtbmxTJ53Pk5ylY
         m31f4gxhpfWGtFIXe1V7BqKDvp1mlVSI8J2nfi4ZwkYW9OcJAwsqddb9gGu0yxfVDF2B
         8fn/s1NkrF+BW+uKll5RuZqXX2K/tRIcYzAsMe40Oev7tCnIFarvFiTb9PfzH7P8d+xV
         LiFvBPaJj5wYKrUYnco2yxL9S07+bDsoRKaaK7P9HLEjJM2z+nhKzvgkDuCmE3oJU1kc
         u27aTFThKpJewm9BAZ2gkWrUUVgKLLAylu/qTORwNaPtHw87/TwSxiDMJaBHkgBvGleI
         2f1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Iw2YiB/ZkIh4oCVAMKTf2c/oj+UFgHHJJM7iLMD06Cw=;
        b=TK+FCv6coC0dc5k9VMuvvdiwMtxN86qRq3zIgurfTO0Jib+duryFCGQGnCeXAKVPNw
         OuykkA88xAYP/Ciz9AHy96Mzmh/i5lsTfpg9WxdYnkBvGe2t5bvqY7LhBmUxywkzDh1S
         E5KMaawApN4LK07Z0c9EYMdG+mmNaTwmpBiiMiZe8Y9HpM+pQ78Dtz43QdsSgstMZfPz
         h7hV3dbyD4XcLPJ5cDfUCM+aYNZ5zUnal+fDj0/lPPaQ4/WSPwfjxKDSsfvuWpNjd1NJ
         oWOVhcnbkgPlPwxPU0K8W/6HHBenWgam36BMTPsiv+tLwrylUUPFxst1LpFrXNzk9B8R
         0oQg==
X-Gm-Message-State: ALKqPwdBWKYDa55Hcw6FOnnYLyP6hjJByu6slNtAFTFQqXY9Cl8sbS1A
        1u2dYt/gLL2qIn+teWfHIscFrFI6
X-Google-Smtp-Source: ADUXVKIkNpsqkzS0D9AhWKQCph+L4AP0vQeAh7M6yre1nGq4Vhmvy5kFl3vL2pPis7VBK989H2x8Yw==
X-Received: by 2002:adf:e644:: with SMTP id b4-v6mr10679070wrn.254.1527887435959;
        Fri, 01 Jun 2018 14:10:35 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k126-v6sm3516235wmd.45.2018.06.01.14.10.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 14:10:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 3/8] checkout.[ch]: introduce an *_INIT macro
Date:   Fri,  1 Jun 2018 21:10:10 +0000
Message-Id: <20180601211015.11919-4-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180601211015.11919-1-avarab@gmail.com>
References: <20180601211015.11919-1-avarab@gmail.com>
In-Reply-To: <20180531195252.29173-1-avarab@gmail.com>
References: <20180531195252.29173-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an *_INIT macro for the tracking_name_data similar to what exists
elsewhere in the codebase, e.g. OID_ARRAY_INIT in sha1-array.h. This
will make it more idiomatic in later changes to add more fields to the
struct & its initialization macro.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 checkout.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/checkout.c b/checkout.c
index bdefc888ba..80e430cda8 100644
--- a/checkout.c
+++ b/checkout.c
@@ -10,6 +10,8 @@ struct tracking_name_data {
 	int unique;
 };
 
+#define TRACKING_NAME_DATA_INIT { NULL, NULL, NULL, 1 }
+
 static int check_tracking_name(struct remote *remote, void *cb_data)
 {
 	struct tracking_name_data *cb = cb_data;
@@ -32,7 +34,7 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
 
 const char *unique_tracking_name(const char *name, struct object_id *oid)
 {
-	struct tracking_name_data cb_data = { NULL, NULL, NULL, 1 };
+	struct tracking_name_data cb_data = TRACKING_NAME_DATA_INIT;
 	cb_data.src_ref = xstrfmt("refs/heads/%s", name);
 	cb_data.dst_oid = oid;
 	for_each_remote(check_tracking_name, &cb_data);
-- 
2.17.0.290.gded63e768a

