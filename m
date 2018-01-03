Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADCA91F42E
	for <e@80x24.org>; Wed,  3 Jan 2018 16:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751322AbeACQe6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:34:58 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37610 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751299AbeACQey (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:34:54 -0500
Received: by mail-wr0-f196.google.com with SMTP id f8so2152385wre.4
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YoOdNLesG39NysNRPSmkrB87rYnjtc5f00RVB7Tqo08=;
        b=u4SHR+vf9muNL2ZbS3kBNUvNCdFt2CYgUhmghVsEFMTZw7vo6i5BuTpVYfNUSI0Sjk
         ugE7h+wgMmzOW9uf3bX6lwg0SaW5uMkYhRocGGae9qLQaofqXW0spiwlA2xxF7ucyV+6
         Ma18hVUmIq1CTTevgZGtxJiaTyPFaSRxWbOavjboAGtgY6PL9JROhcBGVU24M7Nvw48b
         KS/EqO4tBBpisMhZFJStWrcb6SH4hk4IlqlR6eok+SaAVtpqIIQAehwOpl6KDHsSm4Mm
         xI+/6iqDPRqxSVuMA9WVKRrJkuSXIefoVanzl9puMv9dHq2n1mAGleIidlAPo30KmjZX
         HSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YoOdNLesG39NysNRPSmkrB87rYnjtc5f00RVB7Tqo08=;
        b=sHG9G0CN2o7Mb3T5Cl5OxNtIzM1NN2DaodB4otpftvNQifF65t/M2bf30ZIG6UddX1
         kLdXNpYKhtflFVTD5V9JwCUwbbyQP/7W32QjduDdJGLA8UTb/HRG3Z8wqUpqDXAsapPI
         TXHGhOUmySLAZ7CP02gNd06WMawfsKcXd1/hU1U6SpDkG5xWzGKds0Iaw5yLlb9xpJ9W
         FRwAjiyM7+tobxYlOvm3oru/tnKDUTHxDD+gX0cM4JmKrpBUTWmCErgMBWDH2VVCDzKQ
         zYtAs1xaOAZir3h3HV0BXCjyegJBYfUSOhaZk/MeGNEBi+pcSmhbAfye0aEzxh8eiY+W
         WzGg==
X-Gm-Message-State: AKGB3mKaL7e4KjV/P7VQdM+RldFyjsL4wexZqC3neD9WfqfRrNhYhlNn
        o+6fboPzKC6y6kwB/AEvkH3Ci+s/
X-Google-Smtp-Source: ACJfBotJFp+wkh1/jzBWknjyvXME4RWlpvEMOYlpFd+jeJDHZ5u5K88NhcVbdgTl/34Klakm5CKD0A==
X-Received: by 10.223.150.61 with SMTP id b58mr1924952wra.185.1514997291714;
        Wed, 03 Jan 2018 08:34:51 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:34:51 -0800 (PST)
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
Subject: [PATCH 23/40] lib-httpd: pass config file to start_httpd()
Date:   Wed,  3 Jan 2018 17:33:46 +0100
Message-Id: <20180103163403.11303-24-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
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
2.16.0.rc0.16.g82191dbc6c.dirty

