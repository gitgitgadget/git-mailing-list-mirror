Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D65B01F406
	for <e@80x24.org>; Thu, 10 May 2018 12:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935497AbeEJMnZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 08:43:25 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41703 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935483AbeEJMnX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 08:43:23 -0400
Received: by mail-wr0-f195.google.com with SMTP id g21-v6so1873612wrb.8
        for <git@vger.kernel.org>; Thu, 10 May 2018 05:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=xY0wMtvymvrYDGNeSZP+9M88vK/C/JP2LoF+s3heky4=;
        b=ZCP6nw9IajJHklsgjQC0W4HmbxujF4d5cmL3GDvipMEkfqlTcjqEP+TifGaV2SK8CS
         Aq9KA68dXGVaeEW8amCTACytdIq8ZZ3sSoKqDKuWiNVBRUMrYZdrvjlr1ydMOiclnHsV
         1GwWczA0KGzVH4l0BvXaVjbWlw8MNsKX7j6oTxbFpK/n2o76ljkC7sr9QjUxX3cjBOY7
         5uBXgaub5K3MUYwIebMnPpBs996cuniEZ8J3XSnCzPhMJOiPSQ7qJzlpqxNZN1HQo29x
         BexJ2RIxPWZGUWyDk8b73i+IFCd/uZAPz2eN3J6d0H+tx9lGZHCdlRQgu6b3kaasc7si
         oDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xY0wMtvymvrYDGNeSZP+9M88vK/C/JP2LoF+s3heky4=;
        b=SQ+FtICkJQjKjtQuoJz3KgraMyy7+axVhzXXkNBYWOYU5xxyPACJYqq95vwT+/odB2
         KpCRHRkvNakjhxF9tP1UNGwWAOQfArAnkLxG0VDZ3HgBlnqs0VMicbFPkFohcYlBW07B
         p8hFfh7tOGDh+nxQVBN9Bix73qr3XVE16A46gtzXJaU6fpX3KUQhT1S+X7Z870RmfsTR
         sdKddEGz4xisGeuBT6jaoG1aQpjj23Bc9kGosMqjw3oDONYogvCrPpdFy+VFPEzBtZke
         znzvvGShGu5hQL6OFZ607dTa7ITEZcACcJf8GAUuCikk1UVIht/429hE+q9bcAK2FvlF
         Ws5g==
X-Gm-Message-State: ALKqPwfh4OGyST0RTYry9PYLPIhMDjS928sPTjwvbWkcbHx3SskSQmhL
        AGobfNE3o2tnokjuPL56+DlC9JNw
X-Google-Smtp-Source: AB8JxZr8QVelPitaiDWaOSoqQwR43FEFqlbYbHE6beZJS6g6PeGKR08SA1aQeJ/5e1/dY+Qssmfv9g==
X-Received: by 2002:adf:8212:: with SMTP id 18-v6mr1205648wrb.144.1525956201997;
        Thu, 10 May 2018 05:43:21 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q7-v6sm1203303wrf.49.2018.05.10.05.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 05:43:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/6] sha1-array.h: align function arguments
Date:   Thu, 10 May 2018 12:42:59 +0000
Message-Id: <20180510124303.6020-3-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.410.g4ac3413cc8
In-Reply-To: <20180510124303.6020-1-avarab@gmail.com>
References: <20180510124303.6020-1-avarab@gmail.com>
In-Reply-To: <20180501184016.15061-10-avarab@gmail.com>
References: <20180501184016.15061-10-avarab@gmail.com>
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
2.17.0.410.g4ac3413cc8

