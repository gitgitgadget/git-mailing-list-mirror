Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 125501F453
	for <e@80x24.org>; Fri, 22 Feb 2019 10:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfBVK5J (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 05:57:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33861 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfBVK5I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 05:57:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id f14so1899812wrg.1
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 02:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tbEDA3BZsa3m1I0g5+8EXFpvmAcncdPSTIqzhg1qxVA=;
        b=HVFTyBYXo6akWi64997Y6WmMDPCa7XYp+AhVKXCGaXNezKlwupEwg+0Yt8wgefBdig
         L1PjpDJxvfUtJ076IkPq4sQisHIDEHvGRTjID4/JHGfX21QOwGKP0I+ZyYvvl/njDBz1
         fCeE9BEJATs/uI/VqkohPcHGsZqFeIZMK8VQ8hkHPwGEA04nBUK66LjlRH/fMr4nMpyj
         6rrqrNmIZO99hJ+l6j5z/htTZa6sz33+O1hC8di+6/Y+4313ogUH4mE//DFOEFRUbH6U
         qXfU0hPONdwdsUEdw+mN3XuKEgWgwL6nPI4GhjK5fJBiBgHDvPcnjepM8WEsaq1wasrj
         Ms3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tbEDA3BZsa3m1I0g5+8EXFpvmAcncdPSTIqzhg1qxVA=;
        b=gKxlHgl2dkPMA+0uXeEHh2nO9WCIRexMuazRTu1pRpNdVlrpYVepXZFk/Dr2N7wzK0
         WvBfG+9XXSAOilCUD4RPITdPN7nny5juYFwxuwWTGntXdufMi5YIzx1SJ/9OqIZLQmzG
         5xvc86Q6e/xtWAdLF7K3PWNphUI3UMJf3xhBBtMDHTXN/jgeiLLL2ropCtLJSuJYDpgz
         oZ+zjmEdW6vBXACA/bLSMLBvNSWiQMldQ4OQyTWbBamTMnCxJAyVsw7m5eGRVMJ2cGWQ
         Ec4Hzb5m+1bYH3Fv311ht86w8+Z5oz8et+mYPTY+OSK3OYsSNwW49phsbGLSJvO2eER7
         2lNA==
X-Gm-Message-State: AHQUAuaHdwFRiAA2weWDzw3EyhHf8EELgHeRNa9etUV2s0alhmTXJAJZ
        7TlZwidgVAv7Upaqi49ahWY/cbZLaRk=
X-Google-Smtp-Source: AHgI3IY0QQAzpwHx72B1TVRFSzH9/rFwFzQY8MHkCDk54rZFynHp+KZSxBOZOU+zqO0N4LspJcRXpQ==
X-Received: by 2002:adf:eb84:: with SMTP id t4mr2626753wrn.100.1550833026750;
        Fri, 22 Feb 2019 02:57:06 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a24sm2481032wmm.1.2019.02.22.02.57.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Feb 2019 02:57:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] Makefile: remove an out-of-date comment
Date:   Fri, 22 Feb 2019 11:56:58 +0100
Message-Id: <20190222105658.26831-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove a comment referring to a caveat that hasn't been applicable
since 18b0fc1ce1 ("Git.pm: Kill Git.xs for now", 2006-09-23).

At the time of 8d7f586f13 ("Git.pm: Support for perl/ being built by a
different compiler", 2006-06-25) some of the code in perl would be
built by a C compiler, but support for that went away a few months
later in 18b0fc1ce1 discussed above.

Since my 20d2a30f8f ("Makefile: replace perl/Makefile.PL with simple
make rules", 2017-12-10) the perl/ directory doesn't even have its own
build process.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Makefile b/Makefile
index c5240942f2..97e922cc41 100644
--- a/Makefile
+++ b/Makefile
@@ -591,9 +591,6 @@ SPATCH_FLAGS = --all-includes --patch .
 
 ### --- END CONFIGURATION SECTION ---
 
-# Those must not be GNU-specific; they are shared with perl/ which may
-# be built by a different compiler. (Note that this is an artifact now
-# but it still might be nice to keep that distinction.)
 BASIC_CFLAGS = -I.
 BASIC_LDFLAGS =
 
-- 
2.21.0.rc2.261.ga7da99ff1b

