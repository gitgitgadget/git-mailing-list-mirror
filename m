Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31EEB20248
	for <e@80x24.org>; Thu, 28 Mar 2019 16:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfC1QOz (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 12:14:55 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:44636 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbfC1QOx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 12:14:53 -0400
Received: by mail-wr1-f42.google.com with SMTP id y7so19492876wrn.11
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 09:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0OrYW0SN8tkBewlpvNwKRkXnGPnUDO/Qv15OMaVKJBM=;
        b=l6a0RZ3rH96gh+NtM9Kop0zHDEg7oMBL7JUDoLCZeyWqzD3XsEPFQZVctSEidKV7U/
         W01EPyewBf62Vb/OIqbk+cQL0eAtzHgGBwrTirD7NIzODAJMq9vdlw2B1qK2Y0CTP9Mv
         bAPDvk6UMnfzxnPajQAJdPDhrfenGldhgwvVmtXFFr7T32OFvWUfwdcKq8g/o56zHnKJ
         LWGutAhnv0bTqVHc/ONnAPbAMBiSUJGyFHOAX7v0e0x38UsQfKdlNuy4ZbzWeJS8PH7/
         fAgNvkVGeATG8UPgWOf2uR8NgKBwIPAqyP8azh2M6thtzSdNwlmbxbrOuT7oNDV8lCqB
         au/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0OrYW0SN8tkBewlpvNwKRkXnGPnUDO/Qv15OMaVKJBM=;
        b=L4olQl8ep7eMEAOEmCOJRx9f20HRvWxsfRV6eqiV6GN3aYCvmEKjoCRl1LBbp0yy4D
         8L/H/l8oqpGDk0ZklM9tvnnt41ovHdTT1LJ2H1SpYXvc6/LSB8r/H54G6vyRrfMjA2dS
         WcsN/siANgPhGPzpkd/7MVl3AiFNFs8F7CHy25aCywL9htXNVzlb+xFjDWpuFIHOaZXQ
         /GifDp/EKV0pCM5QHAxxQp6QtTF2TpZFkR3ygKXG0yugEMuQ1KghL8XowWmWPLJqZYBA
         35CLlNo8m4zrP/AYHALB0g9KMVRJsnGoy01pfJOIfKxlSWxSsANhEbflIRDjxtRq8k3G
         Cw6w==
X-Gm-Message-State: APjAAAWU2SqJrESawFM7GtPZdD4ggg+F/H1l0+F51I6EIaU8OT875ROD
        rpXoUI25xYbkWOJY7xbMcbtzRYHn
X-Google-Smtp-Source: APXvYqzcg79+8RO+VTBh+8HyYuw5IoAh9DRGaag2Gl34rMvvQf6r0Yi9aIQ9zniVhUlbrl2PJQMHAw==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr7923616wro.232.1553789690961;
        Thu, 28 Mar 2019 09:14:50 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d14sm25519089wro.79.2019.03.28.09.14.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 28 Mar 2019 09:14:49 -0700 (PDT)
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
Subject: [PATCH v4 4/7] reflog tests: make use of "test_config" idiom
Date:   Thu, 28 Mar 2019 17:14:31 +0100
Message-Id: <20190328161434.19200-5-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e
In-Reply-To: <20190315155959.12390-1-avarab@gmail.com>
References: <20190315155959.12390-1-avarab@gmail.com>
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
2.21.0.392.gf8f6787159e

