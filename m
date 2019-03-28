Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69A8620248
	for <e@80x24.org>; Thu, 28 Mar 2019 16:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfC1QOz (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 12:14:55 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:53169 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfC1QOy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 12:14:54 -0400
Received: by mail-wm1-f53.google.com with SMTP id a184so4198967wma.2
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 09:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=luL8kTgjIVASvqVkUPhlJxRfwjVsqTYlqLdiKMpuQ2Y=;
        b=KY7GJ6DMIEtUc1HU3R8crhX6c4QaS/NJ1u5pGtlVFalLX7PtCGq4bApR6uRix0Hp3c
         5ymz85IMH38ITb9d6jfsxl2HLBEA5z3fRcwy653kiORZAw3BW/YXJrR0VnheYObeHe09
         dE7PnKJBBNaBtHNY8oyzLIQggYo7LI8PuFlZT/7qRVWvkoIr3rYSl77yGeCdNq6eekvs
         NtTRqr3+j9eksLDh082g4oNB/pzrIbYvo5h9/X+h76lCOUfr7x3MIR/+Ps7YodnqBDcR
         EnELB2LoUBk/rbmoXuPjDo+3y8JvsY3YTb5qf2nYL43Zn6kpdUEuznBya9E9D4xiKO5c
         +LNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=luL8kTgjIVASvqVkUPhlJxRfwjVsqTYlqLdiKMpuQ2Y=;
        b=PbaBuTXbKPEyCINJ4Tau4kigVjrZ/2pW7rA9AvNlUmsUSz8zM1Dbg0SWcXaTSs74BB
         1MQdNcW+j80uKqOg6d/NAd2vnWxxqwojltGE2sTfVz3iPePtEtQwCtLdrQvYLL+5MyiS
         Uitu4L0RVyHs2eoRbbv9u4vFPWQVDqjskokDrmNv17nWNTEL5ig3lsnHICz6eDdpNnq0
         wAcHX/2F9HN8oQEP08GvmtDuMpeXe9pzNh5TcMFgh6ahLoM0iw5CA8VDG8gjFfn5OUeK
         mHMREjOqNTDc7Zd+fZWw9HCRGyv0E4dZiqqwfsFS6Ho7G/PDhQO5CaL6De6nssDmlV8W
         3xAw==
X-Gm-Message-State: APjAAAUgaNvnRayCB4UJqiJUKGD9EDNQHIxF1l2juoPuj9A85cfOHN8a
        t8R53fpdbwDxrudbD9mtDHbfX2/oTzY=
X-Google-Smtp-Source: APXvYqyCVEiP1x/E0AK4bxI/hgF3D/qVZLaUJQM3X8t5HvjPcQdZsHsdy7tSq9z+MFHcFh4rT1LGbw==
X-Received: by 2002:a7b:c767:: with SMTP id x7mr591731wmk.6.1553789692429;
        Thu, 28 Mar 2019 09:14:52 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d14sm25519089wro.79.2019.03.28.09.14.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 28 Mar 2019 09:14:51 -0700 (PDT)
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
Subject: [PATCH v4 5/7] reflog tests: test for the "points nowhere" warning
Date:   Thu, 28 Mar 2019 17:14:32 +0100
Message-Id: <20190328161434.19200-6-avarab@gmail.com>
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

The "git reflog expire" command when given an unknown reference has
since 4264dc15e1 ("git reflog expire", 2006-12-19) when this command
was implemented emit an error, but this has never been tested for.

Let's test for it, also under gc.reflogExpire{Unreachable,}=never in
case a future change is tempted to take shortcuts in the presence of
such config.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1410-reflog.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 42f5ac9ed9..e8f8ac9785 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -250,6 +250,16 @@ test_expect_success 'gc.reflogexpire=false' '
 
 '
 
+test_expect_success 'git reflog expire unknown reference' '
+	test_config gc.reflogexpire never &&
+	test_config gc.reflogexpireunreachable never &&
+
+	test_must_fail git reflog expire master@{123} 2>stderr &&
+	test_i18ngrep "points nowhere" stderr &&
+	test_must_fail git reflog expire does-not-exist 2>stderr &&
+	test_i18ngrep "points nowhere" stderr
+'
+
 test_expect_success 'checkout should not delete log for packed ref' '
 	test $(git reflog master | wc -l) = 4 &&
 	git branch foo &&
-- 
2.21.0.392.gf8f6787159e

