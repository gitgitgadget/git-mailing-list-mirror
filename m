Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8612820A21
	for <e@80x24.org>; Sat, 16 Sep 2017 08:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751494AbdIPIIo (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:08:44 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36395 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbdIPIIj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:08:39 -0400
Received: by mail-wr0-f195.google.com with SMTP id g50so2374624wra.3
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1LDSt2wcGSvrA+hFAvmajND1qwmaL5zJUzD6nL6Qbkc=;
        b=TwM4ITBi6K4MbvuHNNSoU98nym8eIMCqik43BnpzSF3Md6W+3oyFwNpuv9NXJ4n2x6
         EAqzMuOJ0v/tyEaw1OMulrUbtB73wHxW7/ebZPKylmR3QFytqBzwcoHboWhv3fwVPaDr
         SNPL11IEfCQc5BQ5AohRz1BimQJj7NKbFxtGLVuH/MbyTsVZtaJNtYVcX8rX+Awsi3iw
         gqnbnolZlc8X/xvmElJZ5oS0MTqaK/tZRiCH22zIO7RalkoROECDuA5pcfrTj6Dhi8V1
         65TZ8zxvZTCFov2CZJS7d+X0HU/ydinuFjhKOazCbye16H/jhSIZQN0dKlTtt5ySrzfO
         QECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1LDSt2wcGSvrA+hFAvmajND1qwmaL5zJUzD6nL6Qbkc=;
        b=cQt0w96r7Yks+H8SpsQiYa0NSNiI6Iv3ZM5sVBUa9fXPIJ9DfL2o+Gdvm1gA0863m2
         BdwDcegV8LUUc7k4SlWtGJfewPeqa99wNz1U65kjPulavfYN/i7JiO8A2kUtDR9rgkmy
         gBn2FPXRJeFPEhe/wzIGrruSpxdkXEcTDim3U7UxfjJNk2W5B0f0+x2fOdeHJPiyLEim
         ejRFRkBd4PLD0yozvA5W9zIP5LXd9fqJHG4zWGrW0I2vQGNv6uXs3u9530xRtk2uT611
         xv/XFCPbXPrepvXcy5Qbxl+Vq1gePT4D8j6IfxXA3tYNaRpRWHA64rG36GAFJfqqQxxp
         apUA==
X-Gm-Message-State: AHPjjUhYiaC6a9C8dPdaxvTheSfy5AOLRsYW2/UlBWChIgKtTdknEHqM
        mC3mKNDYErwy2BZN
X-Google-Smtp-Source: ADKCNb4c7lakvisz813B+Dj2CF/1XCC0TPzEyMunThpbM1vQcDgrtut9cX4iRmlKGxoW82IBSYJwVg==
X-Received: by 10.223.184.251 with SMTP id c56mr19858122wrg.145.1505549317508;
        Sat, 16 Sep 2017 01:08:37 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.08.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:08:36 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 38/40] Add tests for 'clone --initial-refspec'
Date:   Sat, 16 Sep 2017 10:07:29 +0200
Message-Id: <20170916080731.13925-39-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0420-transfer-http-e-odb.sh         |  7 +++++
 t/t0470-read-object-http-e-odb.sh      |  7 +++++
 t/t0480-read-object-have-http-e-odb.sh |  7 +++++
 t/t5616-clone-initial-refspec.sh       | 48 ++++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+)
 create mode 100755 t/t5616-clone-initial-refspec.sh

diff --git a/t/t0420-transfer-http-e-odb.sh b/t/t0420-transfer-http-e-odb.sh
index d307af0457..ed833850c3 100755
--- a/t/t0420-transfer-http-e-odb.sh
+++ b/t/t0420-transfer-http-e-odb.sh
@@ -140,6 +140,13 @@ test_expect_success 'no-local clone from the first repo with helper succeeds' '
 	rm -rf my-other-clone
 '
 
+test_expect_success 'no-local initial-refspec clone succeeds' '
+	mkdir my-other-clone &&
+	(cd my-other-clone &&
+	 git -c odb.magic.scriptCommand="$HELPER" \
+		clone --no-local --initial-refspec "refs/odbs/magic/*:refs/odbs/magic/*" .. .)
+'
+
 stop_httpd
 
 test_done
diff --git a/t/t0470-read-object-http-e-odb.sh b/t/t0470-read-object-http-e-odb.sh
index d814a43d59..7355ca4d51 100755
--- a/t/t0470-read-object-http-e-odb.sh
+++ b/t/t0470-read-object-http-e-odb.sh
@@ -107,6 +107,13 @@ test_expect_success 'no-local clone from the first repo with helper succeeds' '
 	rm -rf my-other-clone
 '
 
+test_expect_success 'no-local initial-refspec clone succeeds' '
+	mkdir my-other-clone &&
+	(cd my-other-clone &&
+	 git -c odb.magic.subprocessCommand="$HELPER" \
+		clone --no-local --initial-refspec "refs/odbs/magic/*:refs/odbs/magic/*" .. .)
+'
+
 stop_httpd
 
 test_done
diff --git a/t/t0480-read-object-have-http-e-odb.sh b/t/t0480-read-object-have-http-e-odb.sh
index fe1fac5ef3..c451d269a7 100755
--- a/t/t0480-read-object-have-http-e-odb.sh
+++ b/t/t0480-read-object-have-http-e-odb.sh
@@ -107,6 +107,13 @@ test_expect_success 'no-local clone from the first repo with helper succeeds' '
 	rm -rf my-other-clone
 '
 
+test_expect_success 'no-local initial-refspec clone succeeds' '
+	mkdir my-other-clone &&
+	(cd my-other-clone &&
+	 git -c odb.magic.subprocessCommand="$HELPER" \
+		clone --no-local --initial-refspec "refs/odbs/magic/*:refs/odbs/magic/*" .. .)
+'
+
 stop_httpd
 
 test_done
diff --git a/t/t5616-clone-initial-refspec.sh b/t/t5616-clone-initial-refspec.sh
new file mode 100755
index 0000000000..ccbc27f83f
--- /dev/null
+++ b/t/t5616-clone-initial-refspec.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+
+test_description='test clone with --initial-refspec option'
+. ./test-lib.sh
+
+
+test_expect_success 'setup regular repo' '
+	# Make two branches, "master" and "side"
+	echo one >file &&
+	git add file &&
+	git commit -m one &&
+	echo two >file &&
+	git commit -a -m two &&
+	git tag two &&
+	echo three >file &&
+	git commit -a -m three &&
+	git checkout -b side &&
+	echo four >file &&
+	git commit -a -m four &&
+	git checkout master
+'
+
+test_expect_success 'add a special ref pointing to a blob' '
+	hash=$(echo "Hello world!" | git hash-object -w -t blob --stdin) &&
+	git update-ref refs/special/hello "$hash"
+'
+
+test_expect_success 'no-local clone from the first repo' '
+	mkdir my-clone &&
+	(cd my-clone &&
+	 git clone --no-local .. . &&
+	 test_must_fail git cat-file blob "$hash") &&
+	rm -rf my-clone
+'
+
+test_expect_success 'no-local clone with --initial-refspec' '
+	mkdir my-clone &&
+	(cd my-clone &&
+	 git clone --no-local --initial-refspec "refs/special/*:refs/special/*" .. . &&
+	 git cat-file blob "$hash" &&
+	 git rev-parse refs/special/hello >actual &&
+	 echo "$hash" >expected &&
+	 test_cmp expected actual) &&
+	rm -rf my-clone
+'
+
+test_done
+
-- 
2.14.1.576.g3f707d88cd

