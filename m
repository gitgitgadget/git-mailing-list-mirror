Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E984F20284
	for <e@80x24.org>; Thu, 25 May 2017 19:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1036686AbdEYTqj (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 15:46:39 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32771 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763872AbdEYTqi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 15:46:38 -0400
Received: by mail-wm0-f66.google.com with SMTP id b84so39671095wmh.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 12:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mZxtcEJpE8sWZw8Dm8Q1sUZWhnp7L0W818+G5Q9MLXI=;
        b=cB28xR7W6h9Dgc5INKHkdu6PclubQ6dLOO3q7oWkVYDy0e9VKt30dm13A12Vy7OUov
         RPps6CjZJOxYhyPX58NKzHC1G5uPjwM/sdtRNT08yYU2diME/lEAbvZ2CjTzqMcUyUYv
         tBwGvfM+YjTPMbWH/SDktgcRQZkfgCq2imHSBFaxY8WI6A2pRN5mEGW2+cfs9QzSqn12
         VEzN87ypPYayKEcR5u+pWLpnB07NibeCC/Gdjaz5be8LGf1B82Y+UUAoW5kodVF0Qh8J
         dozapTE6OcZkLC7cHs2DeEQjDURji42Y3cdnVLxXPbMrusOLpVEb3N8WCQrx0sLmWVB0
         U2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mZxtcEJpE8sWZw8Dm8Q1sUZWhnp7L0W818+G5Q9MLXI=;
        b=gvHl5mCJu0rCVc4KPji9Bcb92NiAclgJ0Yq36ZVc0gdJATAHkcrcngLJWQFaaQId55
         A/nfL0wrI0cTkIIo9+1RAD/elx3PNWJ80NjdliRcQk1tZQOHSglxt9MmC2n7XI8vdKKM
         mAOnPr1uUcAymUpKO+0723d+iSv453zy2YQ11wWCQaASxablUjbSq1MxOeFPWrosOWAf
         zXksvc27ZEan9MI76YBTWb4Imw0f9pBorXTpBb5KB+u14uLK/1qCDnM/9jaFvKSY6YBV
         Saet6GtF+GggczdCS46c/U5h0ULpEhKepz2hi8Q6VFomcmRD+Ye7SIwMKsL7yMXfhTHR
         Wx4A==
X-Gm-Message-State: AODbwcCMz2HQMimF1ro+wJRsrN3Yp/IB8f9amFLEAm4RD4N0IG4x2xlJ
        VBtlDMQNkP4vUg==
X-Received: by 10.223.176.163 with SMTP id i32mr29185605wra.32.1495741591571;
        Thu, 25 May 2017 12:46:31 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q203sm8387273wme.0.2017.05.25.12.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 12:46:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 11/31] grep: add tests for grep pattern types being passed to submodules
Date:   Thu, 25 May 2017 19:45:15 +0000
Message-Id: <20170525194535.9324-12-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170525194535.9324-1-avarab@gmail.com>
References: <20170525194535.9324-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add testing for grep pattern types being correctly passed to
submodules. The pattern "(.|.)[\d]" matches differently under
fixed (not at all), and then matches different lines under
basic/extended & perl regular expressions, so this change asserts that
the pattern type is passed along correctly.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7814-grep-recurse-submodules.sh | 49 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 1472855e1d..3a58197f47 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -313,4 +313,53 @@ test_incompatible_with_recurse_submodules ()
 test_incompatible_with_recurse_submodules --untracked
 test_incompatible_with_recurse_submodules --no-index
 
+test_expect_success 'grep --recurse-submodules should pass the pattern type along' '
+	# Fixed
+	test_must_fail git grep -F --recurse-submodules -e "(.|.)[\d]" &&
+	test_must_fail git -c grep.patternType=fixed grep --recurse-submodules -e "(.|.)[\d]" &&
+
+	# Basic
+	git grep -G --recurse-submodules -e "(.|.)[\d]" >actual &&
+	cat >expect <<-\EOF &&
+	a:(1|2)d(3|4)
+	submodule/a:(1|2)d(3|4)
+	submodule/sub/a:(1|2)d(3|4)
+	EOF
+	test_cmp expect actual &&
+	git -c grep.patternType=basic grep --recurse-submodules -e "(.|.)[\d]" >actual &&
+	test_cmp expect actual &&
+
+	# Extended
+	git grep -E --recurse-submodules -e "(.|.)[\d]" >actual &&
+	cat >expect <<-\EOF &&
+	.gitmodules:[submodule "submodule"]
+	.gitmodules:	path = submodule
+	.gitmodules:	url = ./submodule
+	a:(1|2)d(3|4)
+	submodule/.gitmodules:[submodule "sub"]
+	submodule/a:(1|2)d(3|4)
+	submodule/sub/a:(1|2)d(3|4)
+	EOF
+	test_cmp expect actual &&
+	git -c grep.patternType=extended grep --recurse-submodules -e "(.|.)[\d]" >actual &&
+	test_cmp expect actual &&
+	git -c grep.extendedRegexp=true grep --recurse-submodules -e "(.|.)[\d]" >actual &&
+	test_cmp expect actual &&
+
+	# Perl
+	if test_have_prereq PCRE
+	then
+		git grep -P --recurse-submodules -e "(.|.)[\d]" >actual &&
+		cat >expect <<-\EOF &&
+		a:(1|2)d(3|4)
+		b/b:(3|4)
+		submodule/a:(1|2)d(3|4)
+		submodule/sub/a:(1|2)d(3|4)
+		EOF
+		test_cmp expect actual &&
+		git -c grep.patternType=perl grep --recurse-submodules -e "(.|.)[\d]" >actual &&
+		test_cmp expect actual
+	fi
+'
+
 test_done
-- 
2.13.0.303.g4ebf302169

