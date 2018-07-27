Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 078721F597
	for <e@80x24.org>; Fri, 27 Jul 2018 14:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388503AbeG0QAD (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 12:00:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37304 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732267AbeG0QAD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 12:00:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so5692824wmc.2
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 07:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HR0kFBAg1QVK/FKRNMYwgMNIOiePV79FUASdireK3jc=;
        b=B6YS9jaC5UcKAoKaeLs0tCLNx4kfupFoTW/1BcGy+3MJFk/rTWjtwsDJES1CvB+x8g
         6gLW5CdDXIB+H/a5MlOLgVG6FnJqvg7WIu/ZniYxxOXkXR1xCkrQrR/l5d8kXVqt2/P2
         TCvbLAnkb8IrBMN3nV1F3AkXNvMEaUt52Ev5faKsxjOGw4GnqZRzU+oRIoQ8w57IRHMX
         tZ6oNEfZ0nuGHQK6bJNjn+WqM+vOOScI4t8nI4DBN2V2cHXs782upVA+cO/dxsohmzWc
         nEq+4rapl2CDkP5RUuqcBPA1vp1yzzBkE/+rsAl12V8bxHVtq6M6UARmtsZJ2xyp/WNJ
         jj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HR0kFBAg1QVK/FKRNMYwgMNIOiePV79FUASdireK3jc=;
        b=HHosjMLnSBjNaOVIjsSzrm5YfwzQMkQXbSGSL+/q9Ne8fIPoqDfpTfQVRzAx2FXlQF
         dIOBnqnksNnChczMg+/YbGlVtTzhnXbWwx4G2882rSIzviis9EC6rxY6TOqXj+OakT6n
         Ca0NFp6kOT9PuBS6ZNo818K1SXzdrrMc7/oXUOO745RZvKKBqwq+lyZXo+Jc2P5WkSnI
         jicQ94FGdFVR3VXj7da/mi8fRFTtiHhIZR/JejA8xt5W1LRq7m5R+uRDJaiD9NSKz412
         M2UwwSyfaXt7eZZIT3NBYiuJJ5GWDJdNoLpgbxiGAVm2p9k9SBo9ZvLxM8NmxP9eFUgV
         ujAg==
X-Gm-Message-State: AOUpUlGfWmv2vXmECk2aLHq9jblKtqjSbOdU5w5LZZifF8IawEv9kLxD
        SkbIel3+dlG3ey7REegJpS31eiqtEsA=
X-Google-Smtp-Source: AAOMgpeeZyDORXcvD+E14OAir3hjIBb2scmWiwMHNc5PfIgvITecVE4yqmZDGdF1Zt5u2TM3VYqEiw==
X-Received: by 2002:a1c:8406:: with SMTP id g6-v6mr4238147wmd.18.1532702269099;
        Fri, 27 Jul 2018 07:37:49 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j16-v6sm3005479wme.8.2018.07.27.07.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 07:37:48 -0700 (PDT)
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
Subject: [PATCH v3 08/10] fsck: test & document {fetch,receive}.fsck.* config fallback
Date:   Fri, 27 Jul 2018 14:37:18 +0000
Message-Id: <20180727143720.14948-9-avarab@gmail.com>
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

Test and document that the {fetch,receive}.fsck.* family of variables
doesn't fall back on the corresponding .fsck.* variables.

This was alluded to in the existing documentation by saying that
"receive" looks at receive.fsck.* and "fsck" looks at fsck.* etc., but
it wasn't explicitly stated that there was no fallback, and if you'd
e.g. like to configure the skipList you need to do that for all three.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt        | 12 ++++++++++++
 t/t5504-fetch-receive-strict.sh | 26 ++++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8dace49daa..57c463c6e2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1619,6 +1619,12 @@ The rest of the documentation discusses `fsck.*` for brevity, but the
 same applies for the corresponding `receive.fsck.*` and
 `fetch.<msg-id>.*`. variables.
 +
+Unlike variables like `color.ui` and `core.editor` the
+`receive.fsck.<msg-id>` and `fetch.fsck.<msg-id>` variables will not
+fall back on the `fsck.<msg-id>` configuration if they aren't set. To
+uniformly configure the same fsck settings in different circumstances
+all three of them they must all set to the same values.
++
 When `fsck.<msg-id>` is set, errors can be switched to warnings and
 vice versa by configuring the `fsck.<msg-id>` setting where the
 `<msg-id>` is the fsck message ID and the value is one of `error`,
@@ -1642,6 +1648,12 @@ fsck.skipList::
 +
 Like `fsck.<msg-id>` this variable has corresponding
 `receive.fsck.skipList` and `fetch.fsck.skipList` variants.
++
+Unlike variables like `color.ui` and `core.editor` the
+`receive.fsck.skipList` and `fetch.fsck.skipList` variables will not
+fall back on the `fsck.skipList` configuration if they aren't set. To
+uniformly configure the same fsck settings in different circumstances
+all three of them they must all set to the same values.
 
 gc.aggressiveDepth::
 	The depth parameter used in the delta compression
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 004bfebe98..771a94b4b6 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -140,8 +140,13 @@ test_expect_success 'push with receive.fsck.skipList' '
 	git init dst &&
 	git --git-dir=dst/.git config receive.fsckObjects true &&
 	test_must_fail git push --porcelain dst bogus &&
-	git --git-dir=dst/.git config receive.fsck.skipList SKIP &&
 	echo $commit >dst/.git/SKIP &&
+
+	# receive.fsck.* does not fall back on fsck.*
+	git --git-dir=dst/.git config fsck.skipList SKIP &&
+	test_must_fail git push --porcelain dst bogus &&
+
+	git --git-dir=dst/.git config receive.fsck.skipList SKIP &&
 	git push --porcelain dst bogus
 '
 
@@ -153,8 +158,15 @@ test_expect_success 'fetch with fetch.fsck.skipList' '
 	git init dst &&
 	git --git-dir=dst/.git config fetch.fsckObjects true &&
 	test_must_fail git --git-dir=dst/.git fetch "file://$(pwd)" $refspec &&
-	git --git-dir=dst/.git config fetch.fsck.skipList dst/.git/SKIP &&
+	git --git-dir=dst/.git config fetch.fsck.skipList /dev/null &&
+	test_must_fail git --git-dir=dst/.git fetch "file://$(pwd)" $refspec &&
 	echo $commit >dst/.git/SKIP &&
+
+	# fetch.fsck.* does not fall back on fsck.*
+	git --git-dir=dst/.git config fsck.skipList dst/.git/SKIP &&
+	test_must_fail git --git-dir=dst/.git fetch "file://$(pwd)" $refspec &&
+
+	git --git-dir=dst/.git config fetch.fsck.skipList dst/.git/SKIP &&
 	git --git-dir=dst/.git fetch "file://$(pwd)" $refspec
 '
 
@@ -166,6 +178,11 @@ test_expect_success 'push with receive.fsck.missingEmail=warn' '
 	git init dst &&
 	git --git-dir=dst/.git config receive.fsckobjects true &&
 	test_must_fail git push --porcelain dst bogus &&
+
+	# receive.fsck.<msg-id> does not fall back on fsck.<msg-id>
+	git --git-dir=dst/.git config fsck.missingEmail warn &&
+	test_must_fail git push --porcelain dst bogus &&
+
 	git --git-dir=dst/.git config \
 		receive.fsck.missingEmail warn &&
 	git push --porcelain dst bogus >act 2>&1 &&
@@ -185,6 +202,11 @@ test_expect_success 'fetch with fetch.fsck.missingEmail=warn' '
 	git init dst &&
 	git --git-dir=dst/.git config fetch.fsckobjects true &&
 	test_must_fail git --git-dir=dst/.git fetch "file://$(pwd)" $refspec &&
+
+	# fetch.fsck.<msg-id> does not fall back on fsck.<msg-id>
+	git --git-dir=dst/.git config fsck.missingEmail warn &&
+	test_must_fail git --git-dir=dst/.git fetch "file://$(pwd)" $refspec &&
+
 	git --git-dir=dst/.git config \
 		fetch.fsck.missingEmail warn &&
 	git --git-dir=dst/.git fetch "file://$(pwd)" $refspec >act 2>&1 &&
-- 
2.18.0.345.g5c9ce644c3

