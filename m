Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A28F020248
	for <e@80x24.org>; Mon, 25 Mar 2019 12:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbfCYMIu (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 08:08:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55923 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731098AbfCYMIu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 08:08:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id o25so8611109wmf.5
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 05:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PYkMdXApGE4aYrKM81d6b9cOCU0BUZFifHyy+rtD0CI=;
        b=iFYZUQTx2x/2zRezN1j0t/+K1GmWalr8ipjDb8ZLXHhfO6q7z69sB4/+lVNiiW/Cw+
         Fixsu1mqa29Au62q1PiyPlEjbQy5rRU/De5lUqAi7g/b/5SRyBmoarx7odr75J+cwLAG
         q8cIkr8/MELa3VXCrQwspJ2lHjJ1YZp5vaNC3Gsds8EvaQ7LX4OSY94Xjei2o6INFYT7
         ns4yMNAyb7SpT/26VPoMVSVpbZFew5NkVx+MjKl8RrHyLHzzDICU5V8LGlpBM2YfXDhk
         9iX9tANwXep27UvNJEo8pbV9Vt7dsM+1c2NnjtfbRfCdOmjhhWpz/gTu2BiHFmiXq/vL
         9Fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PYkMdXApGE4aYrKM81d6b9cOCU0BUZFifHyy+rtD0CI=;
        b=EP2FufkNBPTp8Qo2UJolphUXhxxR1xGYYHZHHrEjGolzWwk8eRBB2g88VrCpTKMBeF
         dLQyFZzXNwrGjc01tQx2BUsPKVtSXa0R83OQKimKjDQz44SwZ5JKASO9S4d/2FjYQHY2
         DGG6Gz5IzqrEPIoK735T3aIlcxoH4Th963LDkRYo/iA59HLPvCF8QnG2oTXORPllhUhC
         MonbhspIjoIi4XTVu0KcU0BTdBuMWL51QEy+hdW0REIltfbAUkhCv0TCc6AAhr0ug6pH
         IBfe+iZ5T+vba+SgyfpJcX66+0gUWRi+LiEuqxqB34vqLoBxPzgpTyRTt311S40xGWNs
         PAyw==
X-Gm-Message-State: APjAAAUiaObEe0+x+Vwb3dJHFNPy5FsAQlzEbIFTgTyxZpkqDRQnT4Rm
        RhdijsfN22jopeb5Lg6ZElac6GuJ
X-Google-Smtp-Source: APXvYqwSW3dOgoeVmcsMLbaGm6BZ/6Gpa7Up5Es/03dPSdkgN4MfyXWlf+ey/74ndi5RLi7qAqegdg==
X-Received: by 2002:a05:600c:2309:: with SMTP id 9mr11709008wmo.52.1553515728090;
        Mon, 25 Mar 2019 05:08:48 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n188sm15339464wme.13.2019.03.25.05.08.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Mar 2019 05:08:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/8] commit-graph tests: test a graph that's too small
Date:   Mon, 25 Mar 2019 13:08:28 +0100
Message-Id: <20190325120834.15529-3-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190314214740.23360-1-avarab@gmail.com>
References: <20190314214740.23360-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the recently split-up components of the corrupt_graph_and_verify()
function to assert that we error on graphs that are too small. The
error was added in 2a2e32bdc5 ("commit-graph: implement git
commit-graph read", 2018-04-10), but there was no test for it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5318-commit-graph.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 56a616831e..ce3459a6f5 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -399,6 +399,12 @@ corrupt_graph_and_verify() {
 
 }
 
+test_expect_success 'detect too small' '
+	corrupt_graph_setup &&
+	echo "a small graph" >$objdir/info/commit-graph &&
+	corrupt_graph_verify "too small"
+'
+
 test_expect_success 'detect bad signature' '
 	corrupt_graph_and_verify 0 "\0" \
 		"graph signature"
-- 
2.21.0.360.g471c308f928

