Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E421E1F597
	for <e@80x24.org>; Fri, 27 Jul 2018 14:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388556AbeG0QAG (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 12:00:06 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38815 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388467AbeG0QAG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 12:00:06 -0400
Received: by mail-wm0-f65.google.com with SMTP id t25-v6so5685173wmi.3
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 07:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nq3bVtJIOtwReaGBdPjhfQMpF1ZK5RIQ2tCiNNGVt/o=;
        b=jdmngEZSxCiXG6/ASXaJ951mDvo65piYZF43xt3Ls5LnBIZVgN/8wSIfILbPdOxfrh
         KR8vahFdHmKUCzRe/RAYxxBFCe4jIHo0yaUoCTTTHTiECCxLJMgva0riXSHQd1pa6Y8g
         Hxse2786hHT8DgJwVR9TDegAkT4Rhy0vpcpE9dh1bytmVdcQQWPkulDqRPzPjGKLkX87
         +ZnhoYZTPEriMBHCsl8Kl0Tv3sq/YklqmWSG2tNSV7LKhOpEwlAuOuNPwy8VlY4XDO74
         /fjHlmFx2qLl2dqJbgNrHf0XxhY4bX1cgr1Egtavs/3BwfcpGh4O6alG0OYbb4tge1Xc
         ka/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nq3bVtJIOtwReaGBdPjhfQMpF1ZK5RIQ2tCiNNGVt/o=;
        b=SmZsm3KjO+GTt+nKXdqingbpbXpak+Fj+1WPWWw5VsRhoZtdf9g8H9PdPUeLmHGNYs
         tco1zhFCojl6vS52kQBue1k0nYWwwf155q4FhsD6j71UEhEuYGhx2T7LG1rAgBoq5gyW
         ZjnQOGap1Tf9i+I9MjUomwjzRhSswbqxs0JvfEqr6QgKIn7v1AGg4hXipEkTxYuI+hUh
         GoSXquVOz/sAzCLlC4IfEsByZeZNif1dMXqpsNPSsbQliH9a9GEmWMXVtwn9/RDIgoij
         u1U/1JuXR+lwKg+ojLb/90qEIDYOA5nWN3yv79O+GAWJIipIkjBkT7feUqEqQENI/7Z7
         1YAQ==
X-Gm-Message-State: AOUpUlGiNHqn7FXgcBkmVTnpS4BLsfZ5N2j/mKK5EkOZ8eTvXuMdoCv3
        psdTLyrWzGlnBfPUZCxPVRPPllk+HFc=
X-Google-Smtp-Source: AAOMgpfRKwQwZcRdHdWzM3/f4Ylfkdm0xZQwN3cs4Y5qebf1WCndOcxUxAd0FeUGAgsZtogESjODZw==
X-Received: by 2002:a1c:87ca:: with SMTP id j193-v6mr4205095wmd.76.1532702271870;
        Fri, 27 Jul 2018 07:37:51 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j16-v6sm3005479wme.8.2018.07.27.07.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 07:37:51 -0700 (PDT)
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
Subject: [PATCH v3 10/10] fsck: test and document unknown fsck.<msg-id> values
Date:   Fri, 27 Jul 2018 14:37:20 +0000
Message-Id: <20180727143720.14948-11-avarab@gmail.com>
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

When fsck.<msg-id> is set to an unknown value it'll cause "fsck" to
die, but the same is not rue of the "fetch" and "receive"
variants. Document this and test for it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt        |  4 ++++
 t/t5504-fetch-receive-strict.sh | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 57c463c6e2..4cead6119a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1637,6 +1637,10 @@ In general, it is better to enumerate existing objects with problems
 with `fsck.skipList`, instead of listing the kind of breakages these
 problematic objects share to be ignored, as doing the latter will
 allow new instances of the same breakages go unnoticed.
++
+Setting an unknown `fsck.<msg-id>` value will cause fsck to die, but
+doing the same for `receive.fsck.<msg-id>` and `fetch.fsck.<msg-id>`
+will only cause git to warn.
 
 fsck.skipList::
 	The path to a sorted list of object names (i.e. one SHA-1 per
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 7f06b537d3..62f3569891 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -198,6 +198,10 @@ test_expect_success 'fetch with fetch.fsck.skipList' '
 	git --git-dir=dst/.git fetch "file://$(pwd)" $refspec
 '
 
+test_expect_success 'fsck.<unknownmsg-id> dies' '
+	test_must_fail git -c fsck.whatEver=ignore fsck 2>err &&
+	test_i18ngrep "Unhandled message id: whatever" err
+'
 
 test_expect_success 'push with receive.fsck.missingEmail=warn' '
 	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
@@ -211,10 +215,15 @@ test_expect_success 'push with receive.fsck.missingEmail=warn' '
 	git --git-dir=dst/.git config fsck.missingEmail warn &&
 	test_must_fail git push --porcelain dst bogus &&
 
+	# receive.fsck.<unknownmsg-id> warns
+	git --git-dir=dst/.git config \
+		receive.fsck.whatEver error &&
+
 	git --git-dir=dst/.git config \
 		receive.fsck.missingEmail warn &&
 	git push --porcelain dst bogus >act 2>&1 &&
 	grep "missingEmail" act &&
+	test_i18ngrep "Skipping unknown msg id.*whatever" act &&
 	git --git-dir=dst/.git branch -D bogus &&
 	git --git-dir=dst/.git config --add \
 		receive.fsck.missingEmail ignore &&
@@ -235,10 +244,15 @@ test_expect_success 'fetch with fetch.fsck.missingEmail=warn' '
 	git --git-dir=dst/.git config fsck.missingEmail warn &&
 	test_must_fail git --git-dir=dst/.git fetch "file://$(pwd)" $refspec &&
 
+	# receive.fsck.<unknownmsg-id> warns
+	git --git-dir=dst/.git config \
+		fetch.fsck.whatEver error &&
+
 	git --git-dir=dst/.git config \
 		fetch.fsck.missingEmail warn &&
 	git --git-dir=dst/.git fetch "file://$(pwd)" $refspec >act 2>&1 &&
 	grep "missingEmail" act &&
+	test_i18ngrep "Skipping unknown msg id.*whatever" act &&
 	rm -rf dst &&
 	git init dst &&
 	git --git-dir=dst/.git config fetch.fsckobjects true &&
-- 
2.18.0.345.g5c9ce644c3

