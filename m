Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9C70215F4
	for <e@80x24.org>; Tue,  1 May 2018 18:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756402AbeEASkp (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 14:40:45 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53591 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756381AbeEASkm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 14:40:42 -0400
Received: by mail-wm0-f65.google.com with SMTP id a67so11370205wmf.3
        for <git@vger.kernel.org>; Tue, 01 May 2018 11:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FN9BKVWqj8wYaZuxRlvAaknOLwyVd79Ui7JuaZ5Baqc=;
        b=b32FvdkpKZQXEkXTSz0MFjkrhfXNwcAO+ZxTgbHFZTiyWbXWVU/WUngZTftzzkIEOY
         2vORtpTSU6B7AXFB2DEJLs3duBbtVmxz5wWVgWVFqrg1btcFRBGHakVUb/oOMV0vkdEe
         FSkOg4QycuYjgTac4j41m4OpmhXZoVnjeFzg+MeNG0BbLi5VxlKRgQp5VyHjs6K2ktam
         i1004eJPFKLp8Jn/2K1SfzTzbenbgjYAXs4gBu5THcb8mz0cNRqHmCvCbWY5pYA3nzAl
         0FmWVA2NBrTjONcsRPO+qLWg3NkAOaWRib+VAKLQXxnVUVyM7AvofZW3z3XI4ofXl7lo
         0tLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FN9BKVWqj8wYaZuxRlvAaknOLwyVd79Ui7JuaZ5Baqc=;
        b=G2P9VxU+yEPgvJTgxEA6qx4fLi7f+cyekR68RBrRF05SbXdQOnHSYI1CbThNZilJRY
         Z/N5Ua97aCZz76UfkXDD7AmHDhS00/gcV1CVadeG0irEnO9rOeGshEbsmjY5lcZdjaWG
         kq4AvKx9w6zfL18HBigGM0j0kb2oJBY2VJBQGXcvSyUFcOLq0Dar0CsYS679nzRkNhDu
         oXYoM0g3C2+QZs3zplOWMJoduo+zawEXdOEa1PW7EIfbbxScVCs86VOtKp8s44Nmfyxi
         Ow78xlRK8z/kjlOEtVDz08n6UzoFoK+kvM2hJcj94wM83mopENAEiWhOJOR5nItqP0Ry
         Skdg==
X-Gm-Message-State: ALQs6tDG/0mst7hXHh0aafA+j08lagDAl44rc2WcE3ZQFrBdjHMi/p75
        KK1iPGovY5Yx2NVlanpwSsKsk/gR
X-Google-Smtp-Source: AB8JxZpxeEG/bQuI1MtFjy7pbsfoHz7q0XGVMyRGFM+yTTh1ZOCpMaOzeZFn8+Ds6ED7b958ngmXxQ==
X-Received: by 10.28.166.23 with SMTP id p23mr9598231wme.152.1525200041219;
        Tue, 01 May 2018 11:40:41 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b57-v6sm15366920wra.9.2018.05.01.11.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 11:40:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 04/12] cache.h: add comment explaining the order in object_type
Date:   Tue,  1 May 2018 18:40:08 +0000
Message-Id: <20180501184016.15061-5-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180501184016.15061-1-avarab@gmail.com>
References: <20180501184016.15061-1-avarab@gmail.com>
In-Reply-To: <20180501120651.15886-1-avarab@gmail.com>
References: <20180501120651.15886-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The order in the enum might seem arbitrary, and isn't explained by
72518e9c26 ("more lightweight revalidation while reusing deflated
stream in packing", 2006-09-03) which added it.

Derrick Stolee suggested that it's ordered topologically in
5f8b1ec1-258d-1acc-133e-a7c248b4083e@gmail.com. Makes sense to me, add
that as a comment.

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/cache.h b/cache.h
index 77b7acebb6..354903c3ea 100644
--- a/cache.h
+++ b/cache.h
@@ -376,6 +376,14 @@ extern void free_name_hash(struct index_state *istate);
 enum object_type {
 	OBJ_BAD = -1,
 	OBJ_NONE = 0,
+	/*
+	 * Why have our our "real" object types in this order? They're
+	 * ordered topologically:
+	 *
+	 * tag(4)    -> commit(1), tree(2), blob(3)
+	 * commit(1) -> tree(2)
+	 * tree(2)   -> blob(3)
+	 */
 	OBJ_COMMIT = 1,
 	OBJ_TREE = 2,
 	OBJ_BLOB = 3,
-- 
2.17.0.290.gded63e768a

