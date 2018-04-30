Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F24AE215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 22:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753636AbeD3WHx (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 18:07:53 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38153 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752193AbeD3WHw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 18:07:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id i3so16518123wmf.3
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 15:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oD/yQIKEPHO6sC/z/WLfExbMajfxTU4lrQ5Ts2mGSig=;
        b=pLoPSJZsl3OK7DoSJeLmGFXmeEDokMuGATh+udXP3+9ASvPoqPMbyyksYvLRLZagkD
         G5EaZEMUWxwKQFYqyCO3aoBFlZ5b1O9K42r3OJBH0V7fUaNxXKBC2RLd76101WnfyNkn
         rW9cfz/kUF2hdWPmalS+v1J8NepcRbd5g2YdjqWmg6H/MA0viuclcMbETFKzOrydaDu5
         MIxzRbXXZNdo8GnbRpxWJimuHVL4y9EV1nWTY1Sn7A8xavFFQ7D4nz/yqLm9/LhRIxcl
         30rgTvvQ9hTh5aNJXU6/W2PIZzpbRw0DzibvcXb1/gKFkJrKCuLUKspFe8rcMjaNY3hZ
         FC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oD/yQIKEPHO6sC/z/WLfExbMajfxTU4lrQ5Ts2mGSig=;
        b=Aprqgy7zny9BxUGlwLgkS7kUftEO4y9x019zepofuN+nkyySg+Ync6JHH3vAA3PDcn
         YH3ihMKtaLLTSKboTbJsNXzg2mDPWup/89AcyNdbjHcuD3BOkKZwtAhJk2SjgteAFdaN
         xl5OZxWSL6+U8arclnt8pjHueKZZPnes/uN5DRGrtfOdrsey2NfsQzfv2AqQR66gjyOV
         IZ0M1wKoJXc17XaesCxKmSi2cQ/O0yh2ZhCLOHM9pxO/+78u2ugRYADTUrut3t+ZEACW
         g0d18vFsVZrg5cgXw31LtLvrvvruLV3VxbxE1XbJ8UT6EFxqYfQCKEXv8Jtn28eJC9im
         i/0g==
X-Gm-Message-State: ALQs6tAHTcpyo8uVTypp/ZrswnnQDwLipIOvH0AZiNmp8Mypclh4zmNI
        eoTc0U1CwTK/trUYeo5qM+0TfqVw
X-Google-Smtp-Source: AB8JxZp6P3R/uV1WkhXYfb8w5FEqjBnmKucWmlFBp2ROg6wALWER6KikCedElzF0Z+D53RctDRkUDA==
X-Received: by 10.28.3.85 with SMTP id 82mr3838604wmd.96.1525126070604;
        Mon, 30 Apr 2018 15:07:50 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l53-v6sm24014633wrc.80.2018.04.30.15.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Apr 2018 15:07:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/9] sha1-array.h: align function arguments
Date:   Mon, 30 Apr 2018 22:07:27 +0000
Message-Id: <20180430220734.30133-3-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180430220734.30133-1-avarab@gmail.com>
References: <20180430220734.30133-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The arguments weren't lined up with the opening parenthesis. Fixes up
code added in cff38a5e11 ("receive-pack: eliminate duplicate .have
refs", 2011-05-19).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sha1-array.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sha1-array.h b/sha1-array.h
index 04b0756334..1e1d24b009 100644
--- a/sha1-array.h
+++ b/sha1-array.h
@@ -17,7 +17,7 @@ void oid_array_clear(struct oid_array *array);
 typedef int (*for_each_oid_fn)(const struct object_id *oid,
 			       void *data);
 int oid_array_for_each_unique(struct oid_array *array,
-			       for_each_oid_fn fn,
-			       void *data);
+			      for_each_oid_fn fn,
+			      void *data);
 
 #endif /* SHA1_ARRAY_H */
-- 
2.17.0.290.gded63e768a

