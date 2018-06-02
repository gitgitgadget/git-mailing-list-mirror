Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AA001F491
	for <e@80x24.org>; Sat,  2 Jun 2018 11:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751553AbeFBLvH (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 07:51:07 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33903 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbeFBLu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 07:50:59 -0400
Received: by mail-wm0-f68.google.com with SMTP id q4-v6so9363756wmq.1
        for <git@vger.kernel.org>; Sat, 02 Jun 2018 04:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=b4kqkIWu7jnlbGjduBQ1ykNY896p5Rm+wG/zMyO7kZE=;
        b=kNbg2jmfcHwp1MmNPP0Ukbv15YpJabL2qly2vO79ZCu2SJ2+fB7t5mGFSEACDq5U8P
         wr+x9D2t63TAF6xvWClYk5L/+Z0Wf+yi1W4Qh1uNKlDfufMcelqrT555sdoSnmiuPZ8K
         H1ICYieQLwf3dKfzI/WwUWoHEYMM4lfpgsJuNZcwPyZFpqL3Espsm9yolad1LdiJgAkn
         auWN034yTFuE1OObFSDewGdV1ABBPNeEs/qnMpqJt5YYFQCtaiVntCbi4gNUTjtGJMop
         5VeF+WW7ZlB0Bwzx/M6mrBrrsWWcR+G816hy/vZinqPKWcCFaYKJRVfhOm9dKpmOPeKw
         b0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=b4kqkIWu7jnlbGjduBQ1ykNY896p5Rm+wG/zMyO7kZE=;
        b=JScwMUPnVtBN2JWeV3QasE4BrDdzq57SVGD/Jmgw+x5lwO7o5owffWkO7wrACZlKox
         61fyJesn+3PikfeBu7ZCV/e7mQn56JoqnlZ8BlxcUCKbhTcvzi5fkPQrhQsq8PVTsd4o
         Lx4cJQminsqL3VPxJ+YnZvASiYhmmwfJpPPnvNO4YIhrQh4VTxgqaS1Izsos7h6Dsr9p
         tD5Wa92Zpm95Vm8YELO0wW63IHKxpDDYCwjraboECoU8spaSR8RshF2IPTozrY32PPp/
         g/PTdNxnsm2/45IvOlj/XsNh7bbTTrxXcWSX7LSijlWljh/H43A164nJLE1djS9YE9Ku
         jBXg==
X-Gm-Message-State: ALKqPwdFn/lDksExeYuin39ZSwHrdaJRfge9E2I3VUUVUEKMtR0sHOby
        Z7n1FwV2kyyhrZgU4vcrqyDmbSpb
X-Google-Smtp-Source: ADUXVKIDNNj1TNoCz5BihVzdOlo3alJ1GE8CgZAyWagi/ZpcoIf3sXoZyDpr/1sIzq8UfSlwKsolSA==
X-Received: by 2002:a1c:1f13:: with SMTP id f19-v6mr4526413wmf.73.1527940258290;
        Sat, 02 Jun 2018 04:50:58 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v31-v6sm58977794wrc.80.2018.06.02.04.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Jun 2018 04:50:57 -0700 (PDT)
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
Subject: [PATCH v6 4/8] checkout.c]: change "unique" member to "num_matches"
Date:   Sat,  2 Jun 2018 11:50:38 +0000
Message-Id: <20180602115042.18167-5-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180602115042.18167-1-avarab@gmail.com>
References: <20180602115042.18167-1-avarab@gmail.com>
In-Reply-To: <20180601211015.11919-1-avarab@gmail.com>
References: <20180601211015.11919-1-avarab@gmail.com>
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
 checkout.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/checkout.c b/checkout.c
index 80e430cda8..7662a39a62 100644
--- a/checkout.c
+++ b/checkout.c
@@ -7,10 +7,10 @@ struct tracking_name_data {
 	/* const */ char *src_ref;
 	char *dst_ref;
 	struct object_id *dst_oid;
-	int unique;
+	int num_matches;
 };
 
-#define TRACKING_NAME_DATA_INIT { NULL, NULL, NULL, 1 }
+#define TRACKING_NAME_DATA_INIT { NULL, NULL, NULL, 0 }
 
 static int check_tracking_name(struct remote *remote, void *cb_data)
 {
@@ -23,9 +23,9 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
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
@@ -39,7 +39,7 @@ const char *unique_tracking_name(const char *name, struct object_id *oid)
 	cb_data.dst_oid = oid;
 	for_each_remote(check_tracking_name, &cb_data);
 	free(cb_data.src_ref);
-	if (cb_data.unique)
+	if (cb_data.num_matches == 1)
 		return cb_data.dst_ref;
 	free(cb_data.dst_ref);
 	return NULL;
-- 
2.17.0.290.gded63e768a

