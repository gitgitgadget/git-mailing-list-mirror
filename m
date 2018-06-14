Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 766211F403
	for <e@80x24.org>; Thu, 14 Jun 2018 12:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755163AbeFNMbd (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 08:31:33 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:45595 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755033AbeFNMbc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 08:31:32 -0400
Received: by mail-wr0-f174.google.com with SMTP id o12-v6so6227022wrm.12
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 05:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M0ADFe0KXZlBoHBNa/HCOAvEpJMf6Zgx05KkGEQjAsg=;
        b=c0d8iz6RGwdzIvaJCv7voi1xRft9h9lRayf3oCWakyvN61pZpuDXG8ELkXMEWAkA7v
         undMvtWr8bmUpwkraT1zjwSQvfRWnL9z10z/du2gGjPKZz8z6ExrXwWZtfS0QIP3LoZK
         ySm6Ikzpb7bjMZ09YAMOhEQXRQTuM2rxQsbQCtCdrU4zmcP5sJlJPdZZCjBK9m2HBUD4
         gFvdo2LizS5zcTNfD7Dh5iWqdd4rEYktBhfh2nAEmgW+q3Xp1WTyrnkAd4XDtbVwUwQ0
         plTvxZYWRm+B6EJQ6EfCTvYMFpamk/GxOg4+bBWj1MFgO7DxnnbV4ReexgZqv10zG1X5
         hW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M0ADFe0KXZlBoHBNa/HCOAvEpJMf6Zgx05KkGEQjAsg=;
        b=dPCbd48HfdFBh2UHx7V6gm4MSZdwpvhmVzAcDfrsHlYekOqSLMI+cn63UWpnWv96zI
         iVjYWN3tYLAkl5TH7uoHszOd3Gj+/qXV1zKv1WFXxiji3axQCWyaJ4uPWCKjoRphX9Kh
         kjhqrX8IQmv0EOXYQba0WkZVaixVU/HIqW9db+NcCrlEzahv5Ns7qdZzCIkiR5kCu8j7
         nnM03JgNQuE3toR8FZXx/cdgY+4Xal803YWcjlZwxWXZW7UYgHfbBYkYuaMYGE/IUY6f
         iSdh+0kLzmJLz6oO8/X7OCJ7bDCMWE5jobZvuzk7ujStU7fgYD5P/3ziefBMckgc85/O
         yUwg==
X-Gm-Message-State: APt69E20d9v3ZpK3Ff4a3wqoJu2UmmtZLm1Yy8dM7m2/ef4S1evGIn3y
        +BclvBvt+a+H1vImTlWabBfQCSQ0
X-Google-Smtp-Source: ADUXVKKxLGyEXEzEpn5WjdY5eUJWatxto1kmFDr7Osb3Hjxoi3dQaYOJUSDFUrBTeCWGJtwR1FMvEA==
X-Received: by 2002:adf:9724:: with SMTP id r33-v6mr2224865wrb.79.1528979491603;
        Thu, 14 Jun 2018 05:31:31 -0700 (PDT)
Received: from localhost.localdomain (x4db06284.dyn.telefonica.de. [77.176.98.132])
        by smtp.gmail.com with ESMTPSA id w67-v6sm6281497wmw.0.2018.06.14.05.31.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jun 2018 05:31:31 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/4] t/lib-httpd: add minor and patch version to $HTTPD_VERSION
Date:   Thu, 14 Jun 2018 14:31:06 +0200
Message-Id: <20180614123107.11608-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.207.ga6211da864
In-Reply-To: <20180614123107.11608-1-szeder.dev@gmail.com>
References: <20180614123107.11608-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To fix an occasional test failure, the next patch will rely on an
Apache log format specifier that was introduced in version 2.2.30.
Consequently, 't/lib-httpd.sh' must be able to decide whether the
Apache version used for testing is equal or newer than that version to
be able to act accordingly when processing the webserver's access log.

$HTTPD_VERSION currently only contains Apache's major version, so
change how Apache's version string is parsed to store the minor and
patch versions as well.  Furthermore, update the only condition
looking at $HTTPD_VERSION to deal with the full version.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/lib-httpd.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index b6788fea57..5915625631 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -99,13 +99,13 @@ then
 fi
 
 HTTPD_VERSION=$($LIB_HTTPD_PATH -v | \
-	sed -n 's/^Server version: Apache\/\([0-9]*\)\..*$/\1/p; q')
+	sed -n 's/^Server version: Apache\/\([0-9]*\.[0-9]*\.[0-9]*\).*$/\1/p; q')
 
 if test -n "$HTTPD_VERSION"
 then
 	if test -z "$LIB_HTTPD_MODULE_PATH"
 	then
-		if ! test $HTTPD_VERSION -ge 2
+		if ! test ${HTTPD_VERSION%%.*} -ge 2
 		then
 			test_skip_or_die $GIT_TEST_HTTPD \
 				"at least Apache version 2 is required"
-- 
2.18.0.rc0.207.ga6211da864

