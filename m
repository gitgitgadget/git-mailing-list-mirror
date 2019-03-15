Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFFFB20248
	for <e@80x24.org>; Fri, 15 Mar 2019 16:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbfCOQAW (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 12:00:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34015 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729440AbfCOQAV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 12:00:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id k1so9633341wre.1
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 09:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iNDIe43hB1TkJe54aKqtbwinyUGuaYGoBTvx1wB0Lpo=;
        b=leOamYuok3w0pb83Dmr1xuIOXiC3O7E4otNel8U7UfQK0VpVlinRIDkl3y9H1f/mXq
         GYjaFsPVyT4Aq0QG2EiLtHvfzxk9x0Is9hoo2CgxibB8sd2cd4EHb6niNZY+5ig3YZaA
         rd1abMUcCuPtWb5KVzN3yswcV58Lwnlw2jR/lyn1rIA59Uwf35exD62mp2+CB0qwhmLw
         mxCLWPhEs9HyiLRnWXGMZLA7QjnCc4dvEwKb49rhpfkJIGyM7peWJRjn86aF+8huU8Fs
         8qmlfqwXvfG4vYc23W7jUPlzgO1mUyVjcBiVE69IiSRDjUXPcVpio2wl0vyVI1LyDQhc
         F99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iNDIe43hB1TkJe54aKqtbwinyUGuaYGoBTvx1wB0Lpo=;
        b=UMrFUvgnwaW/WwIdR/eLqT5L54j7TZoRH1HbrTPmOtma1dylIHU+1YONgaBKufU6tT
         hD648p575PTa6znStPyBMcMYx6E0UjEdti/7kO4OXGbm6tEAzYAmtzSGbxjhCN19vE1r
         eAIg0RMmX26wLeJKPVmzhSHsVEeCK3/ryc8dsgbwEjfQ+L884uilCJFZ+9MB6Ymz7utk
         T/mX9FNDAYR+gV2reNiVerjLSRpdpf8DXD9XLazz3iU4UKzSPAtDknq45ynTOOjoDO3s
         i7tntTbzr6B4sqm0561Q7tC0QjX/wGgTkY6UWFuojpuIQlzkHVegf/abFE0t4c+rdPbM
         aAow==
X-Gm-Message-State: APjAAAWfKl5PTt2mTL2+eG76mBqVkI7ikAeUn/i9onpnjqdTwz4tv1li
        88/s5BnJkpncKADokwv3pCDFyoOqi90=
X-Google-Smtp-Source: APXvYqxv7no4P1X8ZpypbAoKR9//rJVrgBUH+T9Bmb9JcMRazkl0LNsGB31V6TUsYv4gOB9sJxCrsQ==
X-Received: by 2002:adf:9cc3:: with SMTP id h3mr2867852wre.47.1552665619145;
        Fri, 15 Mar 2019 09:00:19 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a18sm467766wmm.14.2019.03.15.09.00.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 15 Mar 2019 09:00:17 -0700 (PDT)
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
Subject: [PATCH v3 6/8] reflog tests: assert lack of early exit with expiry="never"
Date:   Fri, 15 Mar 2019 16:59:57 +0100
Message-Id: <20190315155959.12390-7-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190314123439.4347-1-avarab@gmail.com>
References: <20190314123439.4347-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When gc.reflogExpire and gc.reflogExpireUnreachable are set to "never"
and --stale-fix isn't in effect (covered by the first part of the "if"
statement being modified here) we *could* exit early without
pointlessly looping over all the reflogs.

However, as an earlier change to add a test for the "points nowhere"
warning shows even in such a mode we might want to print out a
warning.

So while it's conceivable to implement this, I don't think it's worth
it. It's going to be too easy to inadvertently add some flag that'll
make the expiry happen anyway, and even with "never" we'd like to see
all the lines we're going to keep.

So let's assert that we're going to loop over all the references even
when this configuration is in effect.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1410-reflog.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index e8f8ac97856..79f731db37c 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -235,7 +235,9 @@ test_expect_success 'gc.reflogexpire=never' '
 	test_config gc.reflogexpire never &&
 	test_config gc.reflogexpireunreachable never &&
 
-	git reflog expire --verbose --all &&
+	git reflog expire --verbose --all >output &&
+	test_line_count = 9 output &&
+
 	git reflog refs/heads/master >output &&
 	test_line_count = 4 output
 '
-- 
2.21.0.360.g471c308f928

