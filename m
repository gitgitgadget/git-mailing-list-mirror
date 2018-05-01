Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2434A215F4
	for <e@80x24.org>; Tue,  1 May 2018 18:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756373AbeEASkk (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 14:40:40 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52993 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756315AbeEASki (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 14:40:38 -0400
Received: by mail-wm0-f67.google.com with SMTP id m70so18585280wma.2
        for <git@vger.kernel.org>; Tue, 01 May 2018 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=NmOkyOJ1hyFfE43F7+O630ifIkV7OzDvSr/Z9Swed+4=;
        b=JharvAMsSMZShbcN4zpGzQ4iZa2OvfdK1tRkDtb2NQszCVBch6lnANzlLUNzqtK3T7
         ssThkUOb9clyArmddbIAbcyKbE5Io+QcfN+RjbbpS4ZtFU2DyZjyodL4UAZqdyq8mX3m
         mURZjZ+s0sLN2HHnM7Ag5YX2pX9iAa02dEnzfbKAJZ3W48ifmsWCNOKEXXhU7A19ED/q
         BfryO61RnrdRnqS9v3hlK+7jE2rvddFE39wxUg4yWsSv+R4NycAeVMuIWKQE+MRzsbX+
         qG/Ps1qD6j2R/VLOkWNrWM+JpzlBEBj2dCH4n7LPrxWh25prhSesWhqDM/hVNtHQ4qMR
         Arow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NmOkyOJ1hyFfE43F7+O630ifIkV7OzDvSr/Z9Swed+4=;
        b=uRBRpM8wX2n/vwZTsIJu1Tdz/rp+eGyFjOmVTnsXV3eHq+xDwWsGAD4wTCo9zLj3ym
         8+QuPsL2NPd5RILW3FeAGnjowHM1dP2YUJkN4FtIO0Xl9OQSLvEe9mXVMXPGwHaaYusd
         J0rYU6NAM6vgeeZxEmFSYyNUki7qq3myCz74nqz7rbOBdanlqYsexw4nva+xIV2IK8Ts
         IhP6vC/uowxeGOMPAOlewyyp7VqZN067iiBUvJQAkiDrrGjmo7cWCr8gX6UbwsTIQ/ZN
         0RpIyKRiC1CO8Dd6TQqKHF9WOzW/kz2Mew9QK19+x8Q5kPGvaoJypF6s1+tBRfFvxF6T
         lOHA==
X-Gm-Message-State: ALQs6tAXt2uhDHRMNIruSkJWSMlWWgOkCvJwGvlT7UTA4MCPdOHuOdaT
        ei7I+ctVnBth8KCvqOCUgNnsW6KS
X-Google-Smtp-Source: AB8JxZpEcuSmeCL3RqqkdqWyPE8y3g+S4cejJV3XzvL04ntdhzxP6BHDaWqOi25Bnj2cH+2thiXQkg==
X-Received: by 10.28.150.211 with SMTP id y202mr9679388wmd.106.1525200036894;
        Tue, 01 May 2018 11:40:36 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b57-v6sm15366920wra.9.2018.05.01.11.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 11:40:36 -0700 (PDT)
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
Subject: [PATCH v3 02/12] sha1-array.h: align function arguments
Date:   Tue,  1 May 2018 18:40:06 +0000
Message-Id: <20180501184016.15061-3-avarab@gmail.com>
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

The arguments weren't lined up with the opening parenthesis. Fixes up
code added in aae0caf19e ("sha1-array.h: align function arguments",
2018-04-30).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sha1-array.c | 4 ++--
 sha1-array.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sha1-array.c b/sha1-array.c
index 838b3bf847..466a926aa3 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -42,8 +42,8 @@ void oid_array_clear(struct oid_array *array)
 }
 
 int oid_array_for_each_unique(struct oid_array *array,
-				for_each_oid_fn fn,
-				void *data)
+			      for_each_oid_fn fn,
+			      void *data)
 {
 	int i;
 
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

