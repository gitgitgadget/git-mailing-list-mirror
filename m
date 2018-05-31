Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A6331F42D
	for <e@80x24.org>; Thu, 31 May 2018 19:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754198AbeEaTxj (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 15:53:39 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38961 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754163AbeEaTxd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 15:53:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id f8-v6so56086014wmc.4
        for <git@vger.kernel.org>; Thu, 31 May 2018 12:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KIFagjEiFMGH33MM2TQ24/+7bBnXsH6Y1YXxKQgDhl4=;
        b=vgST8XS6uG/tdN6/k3gxNTwd2bIfMIMOsxLtkOVDzalUMIXg95fOh45EBzoeidZmn6
         MjOlctPpfv5RRwToQApeO9vsh+hnp0KPz83aF3i5uxrk0fJrnd0sTxGtLPtl+Zj26KIG
         AHnamExJj8IQxgV81vp4Qwzwhm/cZNhZx4c3wfbN85Bf5+A38mSlw1twyUMljWGfhwsn
         qyUSCEWPNBXfgYb6lEf1EGjij7DwbPBVFB+yrnvPfKen1u8PziX2TEnfosJiBNHrgyGE
         Ez0vuFrtITi+ZiQyvWfNd50Z2O/PsubBuAG8iCbW3qHMdZxzh91o8jeMnssJ2RD4y4zh
         m3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KIFagjEiFMGH33MM2TQ24/+7bBnXsH6Y1YXxKQgDhl4=;
        b=pqkRJNV24ojGQxxjnvCaSrOvLm+9cvWDwg9qFZPlRiyBqqXj5vVusCsd70rWYCVs2T
         kWJsIWIK3lZnSq8W+2xlGFK9QJ2EuXsdZz/V7xrU9tjNZozUoPGBvnqd/fRCu1dg1Yx6
         k8L6W9Ko2/OO9EYkD2RSTAckF82ydLn5/bUtHqMbJqLCQV82YRmjKvcmN5nB746OafSp
         42eXB7GrG72oV4k39u2mUjLgZ3oKyIBxMf+klUPmRQiC0Z8JE/bys82/xdkFzRlWO8g9
         tUYPSHpysOcThnHOLFq6CgCiMWVYXtuF2b5oOHuWAaeni/6oU+1MC7Yh7eH9moFKu7Gm
         z6Fw==
X-Gm-Message-State: APt69E1ii9wrUk753oLnELLwbo+ORnZUIkoneOuENFt7D2kXqneUkNMn
        qCcjgI3NH4Ls23IOlkfSRK63DcNB
X-Google-Smtp-Source: ADUXVKJCO9zEZwHGVkX+pNwYUFh74PgAdEguhTOHhCQoBNWykgwHf6nVEb7T1WV8LVMleVOBlRXVZw==
X-Received: by 2002:a1c:4108:: with SMTP id o8-v6mr837734wma.50.1527796411536;
        Thu, 31 May 2018 12:53:31 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l10-v6sm19809118wrm.29.2018.05.31.12.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 May 2018 12:53:30 -0700 (PDT)
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
Subject: [PATCH v4 5/9] checkout.[ch]: change "unique" member to "num_matches"
Date:   Thu, 31 May 2018 19:52:48 +0000
Message-Id: <20180531195252.29173-6-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180531195252.29173-1-avarab@gmail.com>
References: <20180531195252.29173-1-avarab@gmail.com>
In-Reply-To: <87a7sg9sjz.fsf@evledraar.gmail.com>
References: <87a7sg9sjz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Internally track how many matches we find in the check_tracking_name()
callback. Nothing uses this now, but it will be made use of in a later
change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 checkout.c | 4 ++--
 checkout.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/checkout.c b/checkout.c
index 629fc1d5c4..7ce5306bc7 100644
--- a/checkout.c
+++ b/checkout.c
@@ -14,9 +14,9 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
 		free(query.dst);
 		return 0;
 	}
+	cb->num_matches++;
 	if (cb->dst_ref) {
 		free(query.dst);
-		cb->unique = 0;
 		return 0;
 	}
 	cb->dst_ref = query.dst;
@@ -30,7 +30,7 @@ const char *unique_tracking_name(const char *name, struct object_id *oid)
 	cb_data.dst_oid = oid;
 	for_each_remote(check_tracking_name, &cb_data);
 	free(cb_data.src_ref);
-	if (cb_data.unique)
+	if (cb_data.num_matches == 1)
 		return cb_data.dst_ref;
 	free(cb_data.dst_ref);
 	return NULL;
diff --git a/checkout.h b/checkout.h
index a61ec93e65..2decb9b820 100644
--- a/checkout.h
+++ b/checkout.h
@@ -7,10 +7,10 @@ struct tracking_name_data {
 	/* const */ char *src_ref;
 	char *dst_ref;
 	struct object_id *dst_oid;
-	int unique;
+	int num_matches;
 };
 
-#define TRACKING_NAME_DATA_INIT { NULL, NULL, NULL, 1 }
+#define TRACKING_NAME_DATA_INIT { NULL, NULL, NULL, 0 }
 
 /*
  * Check if the branch name uniquely matches a branch name on a remote
-- 
2.17.0.290.gded63e768a

