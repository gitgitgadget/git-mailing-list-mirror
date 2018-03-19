Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3167F1FAE4
	for <e@80x24.org>; Mon, 19 Mar 2018 13:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933374AbeCSNc7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:32:59 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34463 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933328AbeCSNcj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:39 -0400
Received: by mail-wr0-f195.google.com with SMTP id o8so18665657wra.1
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gFIotIN/TFG92Z2q02E34gQrQpZiZJWipazLMiu2aT4=;
        b=NT/uujDS6XWPC5lrKVInTdg6MW6/aE3iQrfgrq5+FF5DUtC++vcu81FzjF1IBOSgUy
         +dhZK1KM1LlocU/9M0LTz20BIKB4nd3/KD1M5k+WDNV6g0SkRYVdnITRYmLuFGjsPqug
         LmxywoGUZbIMUJbCTEnw+R7OrZFXRHP/boZO331XzrFF7a/iAZcGxNkRnSu9/unTqpRt
         rfP2gHgPZJ1mdO9vTIeNglJevgsQ4SoyXjwoNGazGGyuZVblJj7s57XH384bUD8HNSlW
         QDdkwdAESDqi+cS5QYdZebBBo3kr0CaktvBsPuZCqE3D2lLjmj5v6sK69SBBtARBqHw+
         oIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gFIotIN/TFG92Z2q02E34gQrQpZiZJWipazLMiu2aT4=;
        b=k2X/FH54xQ7wZqzp7nurjLgZxWa5Nfz9vsrjTGw0DzigT/w6NR0il6AFFWWU6XjScN
         cnMbZhquHpXpQinXf5Lm+y7z6990MIFogTv4/qphEEVy57ZoMLElDLHydA3ei9QZwV+Q
         y13tErZQFqW5/iQ8H2TrlW7+3PfI035CJbsL4D6xxhIXXj0Q1tEL1dd50TpcNtkOl9NE
         oqfD+MNRG3+nY8LY0h1y5JUahQk80hSjN3c7t8jWsRtZbjEpeUVVdyYLQxxePreSPAmS
         c0a861nhKCACnucB2ltIhbf4k3Vx7z2GD844c7vV5wB5B9gU/GIbtdRIAPc5XxT2nl9/
         snkw==
X-Gm-Message-State: AElRT7FEJWuhs/gd6d+vUOeYhMtqjjKd3z4psd49h9Puj67GE8z3vfMm
        I4UnOcwLGq403KvPvG7ZRZixVjBR
X-Google-Smtp-Source: AG47ELscBrux8Ugzu4Biu3pAEQpw0MWRBhL/jq22+Mo+eAqRH41vF01nU3DMh4OMgRoX1wsvIR6Rjg==
X-Received: by 10.223.163.25 with SMTP id c25mr6420639wrb.58.1521466357342;
        Mon, 19 Mar 2018 06:32:37 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:36 -0700 (PDT)
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
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 21/36] lib-httpd: pass config file to start_httpd()
Date:   Mon, 19 Mar 2018 14:31:32 +0100
Message-Id: <20180319133147.15413-22-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
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
2.17.0.rc0.37.g8f476fabe9

