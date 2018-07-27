Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F5FA1F597
	for <e@80x24.org>; Fri, 27 Jul 2018 14:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388536AbeG0QAE (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 12:00:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37303 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388467AbeG0QAE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 12:00:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11-v6so5692898wmc.2
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gC/dkLx9s5XshqM1RcbfJRIgVaDsLCT2VRDtGZrRex4=;
        b=dV7gL/kHbOhwEjGej8934mJiWDxJXexl3MFgQV8443+GcsJRE/8GFPR14vc4bvAePL
         6JPA6IfgHEiHl28C6UQ8iLqQPlEgUhd6GvdsHGHxhjmRgN8/aaCXE58/EzaxCYLQ0NwB
         nWzSP8MDcsHY7tutGYwZWyMKaUPl1S5KWWti0mXFe9g1a4f4rKdctaADQQ6oax1Jq2UR
         0v7QqW/KJoiz2J8lhYDD0bVW2enrFDYMCWsFNeD0kqzrz71CdsvNrBV6+NTgnq7kIa/T
         yaLhFzwUinbAXj8vhKudvi2SAethnVqV8V0IoNRF5q0ElxyRYggAX3s5FmT4Pyox5vav
         QR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gC/dkLx9s5XshqM1RcbfJRIgVaDsLCT2VRDtGZrRex4=;
        b=A2oH0l4j1nyHY0/wxmNrs9FZN9dnmQoGuaumMLmfMOSsTH4PPQOOpPjZVF/u47tx1V
         Bx42RmUEvRpaFRlc0g3i8LksZeH1ZCbTn7/3WGG4mlhle95PVwGoSqLVEvx0IoW7QtjW
         M2fcJxuJwez578ENpCgrRMrP4cuWBydpxj+1jhuYtXV04ZFdJ3ZEOz4P2w6hdEvZze/5
         MUObgtsHKvXqwewjd2w+pGDnbSvAqiv7Ha0b3mQORKqbVaPqBkVkNr3uPsyB194qSKdO
         5bhWyTVyLpMXV7g7lfIo8ROGNrmaZey+VegBoPef8wgLExtPZ3P4Zo1mK7ZV8zt7wr3K
         PJGw==
X-Gm-Message-State: AOUpUlEu8V7kaZWi/i5hMspO6++7TbFuPndtqmDJfJMGStRZOF/zm4zh
        Lj+ag7Nr8zc4HW+uTzjVOzLJnm/UlBw=
X-Google-Smtp-Source: AAOMgpe2+Tu47yZKJW9KbkBUrVNDYx51CvBdKsnPcJlDzt/9sKAlPGOAVJ9HfH0wjWUQPW+SJyWYWg==
X-Received: by 2002:a1c:aa8f:: with SMTP id t137-v6mr4332481wme.54.1532702270508;
        Fri, 27 Jul 2018 07:37:50 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j16-v6sm3005479wme.8.2018.07.27.07.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 07:37:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 09/10] fsck: add stress tests for fsck.skipList
Date:   Fri, 27 Jul 2018 14:37:19 +0000
Message-Id: <20180727143720.14948-10-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180525192811.25680-1-avarab@gmail.com>
References: <20180525192811.25680-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stress test the parsing logic shared by fsck.skipList and
{fetch,receive}.fsck.skipList added in cd94c6f91e ("fsck: git
receive-pack: support excluding objects from fsck'ing",
2015-06-22). There were no tests for the work done by the
init_skiplist() routine, e.g. how it dies on invalid input.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5504-fetch-receive-strict.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 771a94b4b6..7f06b537d3 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -133,6 +133,14 @@ committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
 This commit object intentionally broken
 EOF
 
+test_expect_success 'fsck with invalid or bogus skipList input' '
+	git -c fsck.skipList=/dev/null -c fsck.missingEmail=ignore fsck &&
+	test_must_fail git -c fsck.skipList=does-not-exist -c fsck.missingEmail=ignore fsck 2>err &&
+	test_i18ngrep "Could not open skip list: does-not-exist" err &&
+	test_must_fail git -c fsck.skipList=.git/config -c fsck.missingEmail=ignore fsck 2>err &&
+	test_i18ngrep "Invalid SHA-1: \[core\]" err
+'
+
 test_expect_success 'push with receive.fsck.skipList' '
 	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
 	git push . $commit:refs/heads/bogus &&
@@ -146,6 +154,16 @@ test_expect_success 'push with receive.fsck.skipList' '
 	git --git-dir=dst/.git config fsck.skipList SKIP &&
 	test_must_fail git push --porcelain dst bogus &&
 
+	# Invalid and/or bogus skipList input
+	git --git-dir=dst/.git config receive.fsck.skipList /dev/null &&
+	test_must_fail git push --porcelain dst bogus &&
+	git --git-dir=dst/.git config receive.fsck.skipList does-not-exist &&
+	test_must_fail git push --porcelain dst bogus 2>err &&
+	test_i18ngrep "Could not open skip list: does-not-exist" err &&
+	git --git-dir=dst/.git config receive.fsck.skipList config &&
+	test_must_fail git push --porcelain dst bogus 2>err &&
+	test_i18ngrep "Invalid SHA-1: \[core\]" err &&
+
 	git --git-dir=dst/.git config receive.fsck.skipList SKIP &&
 	git push --porcelain dst bogus
 '
@@ -166,6 +184,16 @@ test_expect_success 'fetch with fetch.fsck.skipList' '
 	git --git-dir=dst/.git config fsck.skipList dst/.git/SKIP &&
 	test_must_fail git --git-dir=dst/.git fetch "file://$(pwd)" $refspec &&
 
+	# Invalid and/or bogus skipList input
+	git --git-dir=dst/.git config fetch.fsck.skipList /dev/null &&
+	test_must_fail git --git-dir=dst/.git fetch "file://$(pwd)" $refspec &&
+	git --git-dir=dst/.git config fetch.fsck.skipList does-not-exist &&
+	test_must_fail git --git-dir=dst/.git fetch "file://$(pwd)" $refspec 2>err &&
+	test_i18ngrep "Could not open skip list: does-not-exist" err &&
+	git --git-dir=dst/.git config fetch.fsck.skipList dst/.git/config &&
+	test_must_fail git --git-dir=dst/.git fetch "file://$(pwd)" $refspec 2>err &&
+	test_i18ngrep "Invalid SHA-1: \[core\]" err &&
+
 	git --git-dir=dst/.git config fetch.fsck.skipList dst/.git/SKIP &&
 	git --git-dir=dst/.git fetch "file://$(pwd)" $refspec
 '
-- 
2.18.0.345.g5c9ce644c3

