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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B4361F462
	for <e@80x24.org>; Thu, 13 Jun 2019 17:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfFMRBx (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 13:01:53 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:54101 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729551AbfFLXYy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 19:24:54 -0400
Received: by mail-wm1-f44.google.com with SMTP id x15so8200827wmj.3
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 16:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DjVPIMf+xSlw8VRxJOPb8SnirDuQ2XY9HUor0KgqFv0=;
        b=MowxwC7xZ86LJ4paWGVWzVTQPsVotq9j3DerxQ8q9kxF7PbANqeHFRHcXHCmEYvMBk
         /9sF5QbPE4GEdYuWgFJUUMSsDbQFdg0LAVmDcWetjtBaFznavk/xaLeU+sI3anM1uCBT
         WL3IStftovjWv4UkKA1BwcxtUSw3sNipzl+M4QY8Gb9rMWoL+iu6LLwSf/RPttoRGMzD
         ttkFjAmKxVQrlPdOkEGa7BUa/5ItkQHXzHOfKm1rsr6GfEDUg8REJ0+N4UNul3PY7038
         RhnavVLwR6TrtUtgxVtOt+5ScaJfF87shnfUsqbvTCyD0DTqW84NdFBoeZ34XMWLle/6
         bn9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DjVPIMf+xSlw8VRxJOPb8SnirDuQ2XY9HUor0KgqFv0=;
        b=cmLpq6OjDqvFVtMHs4ZU8dPm2SjAhtdiZgb3khwZn2c1PemaNfDnTETXgAuWQ9y6/u
         LNYrtCfEW2tSUJwJHWnf5Vih76uwj343h9u0iVlQht/c4GFl1/nQPCclwowzACmuXXRT
         QUf2oUMiJ1rranKHsbDNhAMs0GmkqqrkXhXPBoCwLQzds1Is6bVbsWMy/CllUezCuYky
         Uq6c/tBhqAU2ji2eeUB2w/TLKYSJzvl0ctsFSyQPon2M4ZpQFrNdscdnbEmV7Xx5aJR/
         e43exQN3UzZ4GyaAGs/FN6djYhC30goMn1Ri5S42wk8499hyh+e32qV467D826fqaTxc
         NrFQ==
X-Gm-Message-State: APjAAAUdsbAGvXw7pdUJzgic9rN9kanINsIdNXQBTEmJbcu/UECUepRf
        o8N50DTV+MsUG0JLZ5BpMDItu2hG
X-Google-Smtp-Source: APXvYqyrn/LpbRB9najqRYS5CtsTXGtmM+DVBoDewLnJs6LKYgERlZ+Pem4o0/9t52X6P7gZBOe58w==
X-Received: by 2002:a1c:6c08:: with SMTP id h8mr1138835wmc.62.1560381892104;
        Wed, 12 Jun 2019 16:24:52 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:1018:b2dd:2143:78cf:c452:5744])
        by smtp.gmail.com with ESMTPSA id o126sm1414803wmo.31.2019.06.12.16.24.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 16:24:51 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 2/3] t: add t0016-oidmap.sh
Date:   Thu, 13 Jun 2019 01:24:24 +0200
Message-Id: <20190612232425.12149-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.6.gde8b105b43
In-Reply-To: <20190612232425.12149-1-chriscool@tuxfamily.org>
References: <20190612232425.12149-1-chriscool@tuxfamily.org>
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
index 0000000000..f5315f42b8
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
+test_oidmap () {
+	echo "$1" | test-tool oidmap $3 >actual &&
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
+test_oidhash () {
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

