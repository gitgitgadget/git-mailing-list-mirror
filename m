Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A853620248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbfC3LWJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:22:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42743 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730696AbfC3LWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:22:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id r15so2248718pfn.9
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IHO0+//mUhxK1MPr5Z2K783mNYx8bk2aaztVe1lrmyQ=;
        b=qhIkUKY4TFbjP23Y2FCRV+xT4L3xd2tJXd5XO4SzZWoygJ4gTQDuaRu5a8vdWpVTEB
         3lbShkUZYJdV8raq3CZMfGKzfbBS3wedyKJzVLSqoLkr1NExjx3S052U5CU2Y9BJUegj
         EPcCLnNpWHcFuS4Nvjcyt9vvnTLsb/NypS10bpRc4X9YnJodJ28obv171OP2/DsskFKs
         NcffnH2flkwzEtqjuLVYLpntQiHASZFa2YwXfKgQtbomW3A9fofUZMo0AF6L+ey4qCfh
         nxPFOn8xWv8DwthrKpz1cBogLHmwCYu/hxchtSgBWwra21ZyRFJLoPRMdpsm66wy3+O2
         mrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IHO0+//mUhxK1MPr5Z2K783mNYx8bk2aaztVe1lrmyQ=;
        b=B6fQZLoXqjUAZq487lRmxY1UWUwbMx2k8WPuWCAtFG0S4AjuGd4zxcaMoSDsjUZX6h
         BbJD5la0CqIFlrS9X+P7HXHuJx9BNJvDW356smjtE35RODy3saOl57VnsWJnMwSoNFdj
         yP5+s/nXy8JC3S8M1xUSblDs+z/UNn2qMcHu/L+lgxsajh1rk/Z6rzleQlIgbSW1T5Ng
         orffIL1vGf154HxZQOUkjno5iJYarh1Wu2IQon2N5YkIQG0GXlG+ouGKEkAyE51HKBf/
         57/12tTcmTk3rdvTfTd5kkfM2rN7FYcUKUZSKcUqmIfbz1w2Nd7r62pxIysEBjGHpOOb
         3fUg==
X-Gm-Message-State: APjAAAVml0NWkzsM3WQ0jHaoLqSDPn2/Cx2KTy7KagYdUKAzOeEtE/q7
        2QbQqx6a+e5cmTLRz+wa65lT/Rca
X-Google-Smtp-Source: APXvYqzz+pavLeKwyZsLtCqAp4KePXUlb0zIur8PztY/l62AnzjegEmzm/wi4H1aUKQ6UO4KgNqzTQ==
X-Received: by 2002:a63:2c4c:: with SMTP id s73mr51671153pgs.113.1553944928327;
        Sat, 30 Mar 2019 04:22:08 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id t64sm11197490pfa.86.2019.03.30.04.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:22:07 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:22:03 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 20/31] sha1-name.c: remove the_repo from get_describe_name()
Date:   Sat, 30 Mar 2019 18:19:16 +0700
Message-Id: <20190330111927.18645-21-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190330111927.18645-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index fb80306f1a..1cda854f02 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1097,7 +1097,9 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 	return 0;
 }
 
-static int get_describe_name(const char *name, int len, struct object_id *oid)
+static int get_describe_name(struct repository *r,
+			     const char *name, int len,
+			     struct object_id *oid)
 {
 	const char *cp;
 	unsigned flags = GET_OID_QUIETLY | GET_OID_COMMIT;
@@ -1111,7 +1113,7 @@ static int get_describe_name(const char *name, int len, struct object_id *oid)
 			if (ch == 'g' && cp[-1] == '-') {
 				cp++;
 				len -= cp - name;
-				return get_short_oid(the_repository,
+				return get_short_oid(r,
 						     cp, len, oid, flags);
 			}
 		}
@@ -1162,7 +1164,7 @@ static enum get_oid_result get_oid_1(const char *name, int len,
 		return FOUND;
 
 	/* It could be describe output that is "SOMETHING-gXXXX" */
-	ret = get_describe_name(name, len, oid);
+	ret = get_describe_name(the_repository, name, len, oid);
 	if (!ret)
 		return FOUND;
 
-- 
2.21.0.479.g47ac719cd3

