Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59C2F1F462
	for <e@80x24.org>; Tue, 11 Jun 2019 08:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404550AbfFKIX7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 04:23:59 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:52905 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388847AbfFKIX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 04:23:59 -0400
Received: by mail-wm1-f42.google.com with SMTP id s3so1897544wms.2
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 01:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wj/H/JLtAmuFNEObov9qOAGln5NhYEuqgtx1TN7UKM4=;
        b=O04mbglo/ZO+d6jALWoTeijH+E2IUeFrGGG+89oUPe+LVC+79awzdU7V+EaGY8GCJc
         vyvHzO3dE/ezzzI21FpsykxHfjkIHZNDGl2DHqjKo35/efls32k9a0zaAFyuO3eEUvs7
         traDwdCQHqRNdw1OeAufRgqVvIE2ZkdNnZpwjexhf8lAmwRWzmOORlpC0eeS45SLNh7J
         8Nv2S9cfymCXvlO4w9stQ55ObvipgxeP+tKkxB+gqRmFsxr5EquIbD50bv+tVnnnTzMZ
         k3uKpfYadwxryhBbjZXZMJCaag1zZARy5OlsR32vuRCdI1M59q7n6HT9ElODY4aL79Vu
         Kw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wj/H/JLtAmuFNEObov9qOAGln5NhYEuqgtx1TN7UKM4=;
        b=cjcM/zUClZ3bKEmZTQSjwIDLHlZ42ID/SyRA/C3kZOto039PadjlwhGgNx5ym9G9Yt
         ItyMCVeEMKGocCyX83NQlmrMffHIl2xLQ2YX8MtT3tp+2v0w2zoYGjRe3OOwEeHb14i0
         m8VkAxgUpeo5ujOGcGo/sVc+b2pumsIncWddqHmCTjSDGvy6wTvnyi/lR/BvRPxr4wbM
         KMgSf0Xz1+atr+xzjf0gQy50r9Y01vCuHEEl+8MNU01pzJTgY6a7ejQHSX321NfTpkVp
         CxFTJJx2ihOR5Bugt6emopuKdXTWLu3XQPAC5E52Nan5aiYgBTXdTjuomZNVB3BCEZX5
         sNcg==
X-Gm-Message-State: APjAAAXBZKlJRWIV8GCTHHPWbm3BzzMCF/WthbiufoUXyNpOhpoY7Wax
        0uLt9srhaNBGWcfeJsJLXnVsclY3
X-Google-Smtp-Source: APXvYqyUExNDY4hBy6d5sE6CENmiRJ7Eh5Gurbg+PaZ9mZydwP/p+jNMWnSiIF7HI0Q/drMN1RUjDQ==
X-Received: by 2002:a1c:a783:: with SMTP id q125mr17496782wme.94.1560241436844;
        Tue, 11 Jun 2019 01:23:56 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:10dc:b342:2143:78cf:c452:5744])
        by smtp.gmail.com with ESMTPSA id o126sm2837350wmo.31.2019.06.11.01.23.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 01:23:56 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 2/3] t: add t0016-oidmap.sh
Date:   Tue, 11 Jun 2019 10:23:24 +0200
Message-Id: <20190611082325.28878-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.6.gde8b105b43
In-Reply-To: <20190611082325.28878-1-chriscool@tuxfamily.org>
References: <20190611082325.28878-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

Add actual tests for operations using `struct oidmap` from oidmap.{c,h}.

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0016-oidmap.sh | 100 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100755 t/t0016-oidmap.sh

diff --git a/t/t0016-oidmap.sh b/t/t0016-oidmap.sh
new file mode 100755
index 0000000000..cbd2cb71d6
--- /dev/null
+++ b/t/t0016-oidmap.sh
@@ -0,0 +1,100 @@
+#!/bin/sh
+
+test_description='test oidmap'
+. ./test-lib.sh
+
+# This purposefully is very similar to t0011-hashmap.sh
+
+test_oidmap() {
+	echo "$1" | test-tool oidmap $3 > actual &&
+	echo "$2" >expect &&
+	test_cmp expect actual
+}
+
+
+test_expect_success 'setup' '
+
+	test_commit one &&
+	test_commit two &&
+	test_commit three &&
+	test_commit four
+
+'
+
+test_oidhash() {
+	git rev-parse "$1" | cut -c1-8
+}
+
+test_expect_success 'hash' '
+
+test_oidmap "hash one
+hash two
+hash invalidOid
+hash three" "$(test_oidhash one)
+$(test_oidhash two)
+Unknown oid: invalidOid
+$(test_oidhash three)"
+
+'
+
+test_expect_success 'put' '
+
+test_oidmap "put one 1
+put two 2
+put invalidOid 4
+put three 3" "NULL
+NULL
+Unknown oid: invalidOid
+NULL"
+
+'
+
+test_expect_success 'replace' '
+
+test_oidmap "put one 1
+put two 2
+put three 3
+put invalidOid 4
+put two deux
+put one un" "NULL
+NULL
+NULL
+Unknown oid: invalidOid
+2
+1"
+
+'
+
+test_expect_success 'get' '
+
+test_oidmap "put one 1
+put two 2
+put three 3
+get two
+get four
+get invalidOid
+get one" "NULL
+NULL
+NULL
+2
+NULL
+Unknown oid: invalidOid
+1"
+
+'
+
+test_expect_success 'iterate' '
+
+test_oidmap "put one 1
+put two 2
+put three 3
+iterate" "NULL
+NULL
+NULL
+$(git rev-parse two) 2
+$(git rev-parse one) 1
+$(git rev-parse three) 3"
+
+'
+
+test_done
-- 
2.22.0.6.gde8b105b43

