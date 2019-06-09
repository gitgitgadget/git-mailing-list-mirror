Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 700FA1F462
	for <e@80x24.org>; Sun,  9 Jun 2019 04:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfFIEtf (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jun 2019 00:49:35 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:52966 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfFIEtf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jun 2019 00:49:35 -0400
Received: by mail-wm1-f43.google.com with SMTP id s3so5514753wms.2
        for <git@vger.kernel.org>; Sat, 08 Jun 2019 21:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c6nBiDODMszO5Mzwz3NH9Uy8z6QjASLf3fPwTu1D78U=;
        b=uVcYaEltCSW24nuRjVu3YtukQXeuxjvx3bplKkTdVYc+gNHd/gafhkamBI6WWflGLc
         Kn9m5crTIEEFSb6nUvCtYMNgOlpgd9j44rfIISonDmiUNAl3j5/Joy3zatVIQKS1inTm
         1G5a2OlN9+diEQJNKEFHa3FDAoBgHHzl0onJwR1NxevoCd3Ormz2eomigyo6fSHqVG2f
         mbqCcMEC7x4O8y+mKo+CJAa+zFnXF0Blf7DdOdOc1pL/4084iOMnGWX1atZjs1BcDC3I
         70/ibHzomclQSBsGhTqtmgIGl4xF3dWDna2b1uQByisEmRjYjh/FLsMqjUq7/2eeUDbh
         2FOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c6nBiDODMszO5Mzwz3NH9Uy8z6QjASLf3fPwTu1D78U=;
        b=OHrheE9PCX5KjuJI8Rwuf53t2bgLXXdtTGsq2/oFHoEMHEOkGgP5BaxC7ghZv7x/Qx
         aHQ+1iWfb6f4lsW0Y2uDz1SCp+KaxBG7CrF2QJR8avsBovib8MkKFrFdoMb43bIjE/UC
         58MS86qeoJNzUhU0ZxeSuYPkrpbizEM4c2xzWaaENZmHi3bSljA/AxfhkOPym01cV2gd
         0PsR1TNJjcDrFpINGNLBv+JbB67OG4f6Y0gGoFwxSm5H+pDADmnw63tiR3sNo9WD3d38
         6xoTLAl6EFw9xsOdsm4T62Abm0Yrewls761htE0MzofpztN8x9xecrj+aG/t2DaMuVto
         wVVg==
X-Gm-Message-State: APjAAAUgS1u+Va5PEoCnAiSodRRI+7RtdtWCh3QJoqRSxcylC25CrcLu
        H/nnYy8PfJlWA47fp9a+GT3qpwNc3lg=
X-Google-Smtp-Source: APXvYqy7uMnfXd8p7lIWuy8LEq/2JHWiZ5nSR0PmsyzALEgo7y7c7BhsovEeo0pGF9RWFwhBvnnHdw==
X-Received: by 2002:a1c:2004:: with SMTP id g4mr8289714wmg.173.1560055773064;
        Sat, 08 Jun 2019 21:49:33 -0700 (PDT)
Received: from localhost.localdomain (160.10.112.78.rev.sfr.net. [78.112.10.160])
        by smtp.gmail.com with ESMTPSA id y2sm6461116wra.58.2019.06.08.21.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 21:49:32 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 2/3] t: add t0016-oidmap.sh
Date:   Sun,  9 Jun 2019 06:49:06 +0200
Message-Id: <20190609044907.32477-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.14.g9023ccb50a
In-Reply-To: <20190609044907.32477-1-chriscool@tuxfamily.org>
References: <20190609044907.32477-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

Add actual tests for operations using `struct oidmap` from oidmap.{c,h}.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0016-oidmap.sh | 100 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100755 t/t0016-oidmap.sh

diff --git a/t/t0016-oidmap.sh b/t/t0016-oidmap.sh
new file mode 100755
index 0000000000..3a8e8bdb3d
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
+	echo "$2" > expect &&
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
+	git rev-parse "$1" | perl -ne 'print hex("$4$3$2$1") . "\n" if m/^(..)(..)(..)(..).*/;'
+}
+
+test_expect_success PERL 'hash' '
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
2.22.0.14.g9023ccb50a

