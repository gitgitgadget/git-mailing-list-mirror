Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F87620A21
	for <e@80x24.org>; Sat, 16 Sep 2017 08:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751294AbdIPIJz (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:09:55 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33199 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbdIPIII (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:08:08 -0400
Received: by mail-wr0-f196.google.com with SMTP id b9so2383469wra.0
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W020BDRMl9R4t49CH2iGs/fQLLNUUXwWsZCOFl4HBK8=;
        b=H2RXpQrYEctC9XKEQI2GazTNyainTYqJp9lLYeCblORqVHwEmaE1ttpqrNFqcB2OnE
         zwUH0i5LkixxLV2LfLX+prePTloqCIT1at56FVeXVPXq5jUDViJPBmF3K866pBBJ7pJe
         tKoJuctHqUXme8DrAkwD7D4WsgoHWTn42CYbfE6oDuIDwLUo1cC5DPt3ocMRda1lGOV6
         /+1pwipeGOueFpz32SMgPG80NduyG4jYzpoQBf5q6U34o24PVWX+eT31QoOgIaNIj1ab
         bNpUnwTPUWZFmWI34rctIkUYIn1K+LhkHc0Rieqmczfwxef9NcpsNhjYoX5I9wCJwnEM
         lAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W020BDRMl9R4t49CH2iGs/fQLLNUUXwWsZCOFl4HBK8=;
        b=olpA/JG/9yIN71yBLzp66+4h8XeWWI4nOSm4It21qRY1dHZg+5wJXIPQTphzI5dAVP
         3ngUWG1mkLZfJzZ3Mczkuivty2X629R2sF2zhw+eltI3yIxKczBvWOGvayhzsdHQsalj
         na+tWbqSWBl96ogTfhUIfD/DvID6hdI4yizLKqYVzjsawOzLqh4YkozBNa17ogLSDDZT
         zIrk8YRN+9toP4oSJAZlVc3gi7vPUBXfO8I8nYIVlI4pCKmttrxZWTJyvq1K3+KBqBLD
         VBDZ76rN9ZoWV6DTH+ic1BWw4DQ/caPs5nDsFp72Y4SYWcGtfvNYVERzUeak2JBJR7YJ
         neUg==
X-Gm-Message-State: AHPjjUjVc/Dn/pcuAnUjldPC2mE07tTwIbVAkwRa/tqwB4GyB6KvgnPx
        rfIUG13zKz3V1NTO
X-Google-Smtp-Source: ADKCNb4c1pxUkh5Pu/7jdNASR202d6yQaQnnaio3plr4Lc8QHUn+E9GlTuOUzsxe1fkACsPnRwIvDg==
X-Received: by 10.223.161.212 with SMTP id v20mr25416035wrv.195.1505549287139;
        Sat, 16 Sep 2017 01:08:07 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.08.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:08:06 -0700 (PDT)
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
Subject: [PATCH v6 17/40] lib-httpd: pass config file to start_httpd()
Date:   Sat, 16 Sep 2017 10:07:08 +0200
Message-Id: <20170916080731.13925-18-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes it possible to start an apache web server with different
config files.

This will be used in a later patch to pass a config file that makes
apache store external objects.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/lib-httpd.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 435a37465a..2e659a8ee2 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -171,12 +171,14 @@ prepare_httpd() {
 }
 
 start_httpd() {
+	APACHE_CONF_FILE=${1-apache.conf}
+
 	prepare_httpd >&3 2>&4
 
 	trap 'code=$?; stop_httpd; (exit $code); die' EXIT
 
 	"$LIB_HTTPD_PATH" -d "$HTTPD_ROOT_PATH" \
-		-f "$TEST_PATH/apache.conf" $HTTPD_PARA \
+		-f "$TEST_PATH/$APACHE_CONF_FILE" $HTTPD_PARA \
 		-c "Listen 127.0.0.1:$LIB_HTTPD_PORT" -k start \
 		>&3 2>&4
 	if test $? -ne 0
@@ -191,7 +193,7 @@ stop_httpd() {
 	trap 'die' EXIT
 
 	"$LIB_HTTPD_PATH" -d "$HTTPD_ROOT_PATH" \
-		-f "$TEST_PATH/apache.conf" $HTTPD_PARA -k stop
+		-f "$TEST_PATH/$APACHE_CONF_FILE" $HTTPD_PARA -k stop
 }
 
 test_http_push_nonff () {
-- 
2.14.1.576.g3f707d88cd

