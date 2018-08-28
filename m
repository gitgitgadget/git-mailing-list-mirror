Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80E191F404
	for <e@80x24.org>; Tue, 28 Aug 2018 09:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeH1Nn2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 09:43:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38832 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbeH1Nn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 09:43:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id w11-v6so957887wrc.5
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 02:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1v5DmCm/GQCa9MSuy8uss6Vj0H6pVdILDOzoaSvjMc0=;
        b=agYoM+c0jzw2JQJ3pzAUQDQCSJDspD/CzXI0MWpB1v5+xRpy5mnm+YJO6y1cBvKfdH
         R1lH9qQCic3qLwEadtRGRnsk0HM8kX3ytw0Dgv0K7+ZqjG4hlETDrY3mMDbgAGnVp+nu
         /ZcYEAjQx70Tdocg5iGrSpgjpxGC8guugWk1tPV30wI87yzrQ7rBDVDaA4RDbL2baeK0
         Bmk14OaJf86BWEmV7y6Qy5Zpmw0KrtYN+ap4T1lyRtpiFxMGHHFG5QoRWnbNveChCiqR
         jXjgQAG0ONtkgOSaIXGK1q7kaqVGCPO0bJi+P4D2Y4HoVKCHCV5feJAh8YU8jySxIuUa
         wGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1v5DmCm/GQCa9MSuy8uss6Vj0H6pVdILDOzoaSvjMc0=;
        b=DCu8ZywVqb2X8K3fIYetb6r7nV7ym48PzIzvAtVyOWlJvQa5DLR7UsJC6Q0p2SDdS7
         LoxSvi2IBYQQC7hW9XP7EjPAb69lLZ1uoeOq1ufpQlXX66BojwhfvIDjq443QP9JW4Ql
         6bGQ6KWOiftmA+UQKQRbk9DEn45AZXg6d6FWUVm+NgOWN2tMWaRfDg3k/mTTcnf6lQWy
         vfvG0vFt4nPAhod+pDMoPavEOHlcSNvbGrDbydEVbb3OIg1Qt+QM8vBzKlnqmJ4Y7gZQ
         C8PwIvdQFBoG4j+q8ymFIT09vbQBiYDWLo6LM7+KEJnX31o0GjLinHBOn1xM68ts8IGo
         OcNA==
X-Gm-Message-State: APzg51DY99wB+480U7vPq8/VFWmOGQ3oCCAQWZsrKipuc/hTs1GoAa60
        6WiWtsgTMFjtGNl52A0UXHrCyUfczPc=
X-Google-Smtp-Source: ANB0VdYi9X+sPr+3eqmf7wN5S6Pls8nU0GpC19Tz5WRYgD8X9elE6R7HBi1qK/VLk15EuUDo/Ds9jQ==
X-Received: by 2002:adf:f5c9:: with SMTP id k9-v6mr595048wrp.59.1535449954928;
        Tue, 28 Aug 2018 02:52:34 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a37-v6sm1572238wrc.21.2018.08.28.02.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 02:52:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/8] fsck tests: add a test for no skipList input
Date:   Tue, 28 Aug 2018 09:52:13 +0000
Message-Id: <20180828095219.23296-3-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <87lg8refcr.fsf@evledraar.gmail.com>
References: <87lg8refcr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The recent 65a836fa6b ("fsck: add stress tests for fsck.skipList",
2018-07-27) added various stress tests for odd invocations of
fsck.skipList, but didn't tests for some very simple ones, such as
asserting that providing to skipList with a bad commit causes fsck to
exit with a non-zero exit code. Add such a test.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5504-fetch-receive-strict.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 6d268f3327..cbae31f330 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -137,6 +137,11 @@ test_expect_success 'setup bogus commit' '
 	commit="$(git hash-object -t commit -w --stdin <bogus-commit)"
 '
 
+test_expect_success 'fsck with no skipList input' '
+	test_must_fail git fsck 2>err &&
+	test_i18ngrep "missingEmail" err
+'
+
 test_expect_success 'fsck with invalid or bogus skipList input' '
 	git -c fsck.skipList=/dev/null -c fsck.missingEmail=ignore fsck &&
 	test_must_fail git -c fsck.skipList=does-not-exist -c fsck.missingEmail=ignore fsck 2>err &&
-- 
2.19.0.rc0.228.g281dcd1b4d0

