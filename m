Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55B8520248
	for <e@80x24.org>; Thu, 14 Mar 2019 12:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfCNMfC (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 08:35:02 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:46216 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfCNMfB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 08:35:01 -0400
Received: by mail-wr1-f46.google.com with SMTP id 33so5664127wrb.13
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 05:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BfnimDtqv5SD6Iwu+dBH75qyhMYDPZ+Aoknb+G+x564=;
        b=VXUTVl0KbEj4fdbGVQY5HEY6SHOQ/x8Zn2F1wuow6H86aV9PPaFpbA6+q7U8iIFjah
         e8YvdZZBqaQPsHgs12K8m7rIKZT4E02s67SLhz70lqcpZ+EhHvyghPko+DsbKUBczbMm
         LvV6/u2W9W/5NfLdmwp7yBqwking/62ZNd0VBvrZ5WmQW6l0QmTsoLh7Mnc2UBoketUF
         OENIoTE5vOPNhF15XlWsaXdFARH2g2Aigb3GDwV1xdjVCDj3A5ZEyqt8gT/GRTbAyeEN
         48p0W5aXOiqJdgGtdf/ljPTEX9UvJX1p2gvicM64uSHLE7m+gU1l/VF89+puLPWii7cK
         vBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BfnimDtqv5SD6Iwu+dBH75qyhMYDPZ+Aoknb+G+x564=;
        b=TGhkpFmEy6INswqlL0oJnb0PhFt9yb1yYCFlyVXBt/4CGR3t3nLFyCEAtgNkCeAKgP
         gj4cxFYfnUiLZkiSZSseRKfcuVFHbKc/2Z0JQu+61Jdl2XyujDRifqh2LyjGGypkGQ0K
         7kdYpggYmRNXOY7kUg1fUmbfZjjelBHFoyL2Ykmiz9z2rJWqN9Q7eV+ibeGCz6t04AR1
         pLOUCvuxkKntvzrcZw/QRA5jbRV7AVJmJv99ty8QsL5uxEKef/hPEbJHpEiUxEKezSN+
         /oXMWNwxW1ct494HJ3ca5v2xs+oZdSfdGailuK1czIzjlvO8n1p9cifYnUuQFbWHoz3l
         vENQ==
X-Gm-Message-State: APjAAAUEgc+HnnoG6DaFd+//XEMMaQiUIfq4rwbxo5qoMDchYiO+hHJ7
        ZLalTSxxX/6AauqWfJErxh+pZC7dH70=
X-Google-Smtp-Source: APXvYqzjTVpDmeaFLR0/SoyvxmXOC78r2jVAr0ooCtFkHwrLfXxYv9a3ZCd1/SO2uv9Kwq64SO6Haw==
X-Received: by 2002:adf:fa8c:: with SMTP id h12mr1234312wrr.75.1552566898149;
        Thu, 14 Mar 2019 05:34:58 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p6sm42374095wre.63.2019.03.14.05.34.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 14 Mar 2019 05:34:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/7] reflog tests: make use of "test_config" idiom
Date:   Thu, 14 Mar 2019 13:34:36 +0100
Message-Id: <20190314123439.4347-5-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190313235439.30439-1-avarab@gmail.com>
References: <20190313235439.30439-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a couple of tests that weren't using the helper to use it. This
makes the trailing "--unset" unnecessary.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1410-reflog.sh | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index ae8a448e34..42f5ac9ed9 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -232,24 +232,21 @@ test_expect_success '--expire=never' '
 '
 
 test_expect_success 'gc.reflogexpire=never' '
+	test_config gc.reflogexpire never &&
+	test_config gc.reflogexpireunreachable never &&
 
-	git config gc.reflogexpire never &&
-	git config gc.reflogexpireunreachable never &&
 	git reflog expire --verbose --all &&
 	git reflog refs/heads/master >output &&
 	test_line_count = 4 output
 '
 
 test_expect_success 'gc.reflogexpire=false' '
+	test_config gc.reflogexpire false &&
+	test_config gc.reflogexpireunreachable false &&
 
-	git config gc.reflogexpire false &&
-	git config gc.reflogexpireunreachable false &&
 	git reflog expire --verbose --all &&
 	git reflog refs/heads/master >output &&
-	test_line_count = 4 output &&
-
-	git config --unset gc.reflogexpire &&
-	git config --unset gc.reflogexpireunreachable
+	test_line_count = 4 output
 
 '
 
-- 
2.21.0.360.g471c308f928

