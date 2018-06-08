Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D579F1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 22:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753249AbeFHWmI (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 18:42:08 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52442 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753215AbeFHWmE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 18:42:04 -0400
Received: by mail-wm0-f67.google.com with SMTP id p126-v6so5738157wmb.2
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 15:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gGlbexiUV1WiF5bRoU4i1vv42/+5dEoH/w3Fq/UW8cw=;
        b=pQbIf1PjBPYTPWIJUDrLDDh5Z2EGOq2XmA1H2j0DhzYEtHlLaJxn1rrWEoinp+4ZWz
         /Cjv8Nxye8SXA8tMIis1Vqy5/TUog9KEjPhrRtHxbZrGRdXCHUBa93bY+KZgOlToNtqi
         bIbsZNJSc03HDg/WmwIiR8YhfqdspYVqqvQRoaEzfgj0GPplYSiPWAS8WJrLDZAE+7XZ
         iEMViHFmb6B9i6MS5sCqSLCrjETV+csy5lI4KSbhOidPK1dV/p2IdEL+7yBAQQfT4KTW
         SFbIfOC9ixCiqodof4WYxCmZbQrwMznfzfruYz8Z02IE3sRgxVpHgZaTwd/jBn6mMHpB
         UW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gGlbexiUV1WiF5bRoU4i1vv42/+5dEoH/w3Fq/UW8cw=;
        b=n5gjmcc3q7mNCQ8M+ufD1ESepqplze7Wz19pXNmoL7PQt22R2sJRnuZpRPXxoF8W9G
         QT8Sen37mWrSEzyXoUxhSyBulFbJEXA8GMT17Y73r75KFZj/NsqyEO8BRYntn09uhme4
         GRL0HhvIx0EQen57Vknz+dERKATEIyJCbZng2I72zWkFMLXjChpr7pAQQRhAQxIboM5V
         GJj8rw1LDT+T+UTVYOOxG/EsuDN2GjRSbxmNBSB7ULxGaDvhjyrLZapJ12M3uxYOZF6Y
         uuOjIGv80//ljLR4TIi07pIEp6C0RCLw+e68AMVcuVH5ADkpRl2ePspT4Tjry1nTMps1
         pH1Q==
X-Gm-Message-State: APt69E0MzGD1oPV0RG0dDH4/dp3o1jKrKkw0Ul+5TtYfSQmCFwyDH1r3
        EEMlH9fBItVyAHEI3G8CVcE+xEaa
X-Google-Smtp-Source: ADUXVKKJlyk7w9y7UPFg29aqUiCyhLbwJBf4uxJ69Or+gUB1gnKDNWt3MeDz/CTRPshdZUdt3el96Q==
X-Received: by 2002:a1c:6545:: with SMTP id z66-v6mr2427941wmb.86.1528497723111;
        Fri, 08 Jun 2018 15:42:03 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w15-v6sm36350010wro.52.2018.06.08.15.42.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 15:42:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com,
        git@jeffhostetler.com, peff@peff.net, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/20] abbrev tests: test for "git-diff" behavior
Date:   Fri,  8 Jun 2018 22:41:26 +0000
Message-Id: <20180608224136.20220-11-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180608224136.20220-1-avarab@gmail.com>
References: <20180608224136.20220-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "diff" family of commands does its own parsing for --abbrev in
diff.c, so having dedicated tests for it makes sense.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0014-abbrev.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/t/t0014-abbrev.sh b/t/t0014-abbrev.sh
index a66051c040..783807475f 100755
--- a/t/t0014-abbrev.sh
+++ b/t/t0014-abbrev.sh
@@ -213,4 +213,35 @@ do
 	"
 done
 
+for i in $(test_seq 4 40)
+do
+	test_expect_success "diff --no-index --raw core.abbrev=$i and --abbrev=$i" "
+		test_must_fail git -c core.abbrev=$i diff --no-index --raw X Y >diff &&
+		cut_tr_d_n_field_n 3 <diff >diff.3 &&
+		test_byte_count = $i diff.3 &&
+		cut_tr_d_n_field_n 4 <diff >diff.4 &&
+		test_byte_count = $i diff.4 &&
+
+		test_must_fail git diff --no-index --raw --abbrev=$i X Y >diff &&
+		cut_tr_d_n_field_n 3 <diff >diff.3 &&
+		test_byte_count = $i diff.3 &&
+		cut_tr_d_n_field_n 4 <diff >diff.4 &&
+		test_byte_count = $i diff.4
+	"
+
+	test_expect_success "diff --raw core.abbrev=$i and --abbrev=$i" "
+		git -c core.abbrev=$i diff --raw HEAD~ >diff &&
+		cut_tr_d_n_field_n 3 <diff >diff.3 &&
+		test_byte_count = $i diff.3 &&
+		cut_tr_d_n_field_n 4 <diff >diff.4 &&
+		test_byte_count = $i diff.4 &&
+
+		git diff --raw --abbrev=$i HEAD~ >diff &&
+		cut_tr_d_n_field_n 3 <diff >diff.3 &&
+		test_byte_count = $i diff.3 &&
+		cut_tr_d_n_field_n 4 <diff >diff.4 &&
+		test_byte_count = $i diff.4
+	"
+done
+
 test_done
-- 
2.17.0.290.gded63e768a

