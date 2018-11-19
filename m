Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E13A1F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 10:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeKSUiu (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 15:38:50 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:45285 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbeKSUiu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 15:38:50 -0500
Received: by mail-pg1-f170.google.com with SMTP id y4so13628607pgc.12
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 02:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HR+ALa5q9KEWi8KJixClXItkG/LEKFChqbI1NVi+EkY=;
        b=pjb+Fll3iwWUyAh1kz3BV49v+yxwEvwjuT0lsbVK8Iiv+y8iN+zvlgbGhZxu6/J+dm
         hZ1VyZWd+18BZzxocP/1oantO1e0/IFDiN1lt2fmgMRfP23OeE0rUiPTYBE8gXN0d6+Z
         z1S3cUXomfjEvJ9jwGyqYsdmxwjU9SfyNLYKE3buHJvgrYLrQiS9+vQKkga2KZxvlDTa
         uzhyqz7suOuuJJarh9TW50z/7fIoYQEFKlPm9IZCaR5NMtXZ7vYALSgDucEl9oFdV7Jf
         mIoDLONDY0sELfAhZrZEZxIz4JDm5oK26FCM2AvT+FSSkLAbfTE0FXWjMx/2DUqKNq0P
         wKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HR+ALa5q9KEWi8KJixClXItkG/LEKFChqbI1NVi+EkY=;
        b=PNt2lpU7rNkYTC406MesSy0bRXhk23j+FZlxnyyffEoL98KVuv0wlRsXomjpOSEipn
         AQikuHDiI6k6LZlsyR8Mn/3FJuyQ9MChnAS/DUcGjWQoiJX3s5z2I3iIkmyitYMJlD8X
         8cjn37I6C7xGqIE1rlAWC3cNhkS+w+2OxRZYvEO1v+7csjZoi0nP82JBXH5m0TsCJX/n
         0XBcnbASlhRvw2RMcjj3LwwwVcyDV9dS8ncUIzytJal14s9HgfCFbazXkg5XNq+g/YzX
         w+zwkvXxhlwWLKZAPINVan7aM/0uLX9GDJoOVuuoCSHo6yJ9UgPsuV8CXxllsj3Kl54I
         PHfA==
X-Gm-Message-State: AGRZ1gIRRbKPzyB18Qc/OomQcDKw0cWgXzgobKH2dk0HHcHAiDVfySBr
        m29npdCMsLjv0MygLBz37heUf71M
X-Google-Smtp-Source: AJdET5dpfTnuLqa1oCQnz3FCiTPLE8jo9VZ3V3O2R8sj20a/lHsC6iyUEWBnTIlzrwn+bwxGyRPDaw==
X-Received: by 2002:a63:fa46:: with SMTP id g6mr19630353pgk.18.1542622539170;
        Mon, 19 Nov 2018 02:15:39 -0800 (PST)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id n7sm4666349pff.36.2018.11.19.02.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Nov 2018 02:15:38 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     max@max630.net
Subject: [PATCH] t5562: skip if NO_CURL is enabled
Date:   Mon, 19 Nov 2018 02:15:35 -0800
Message-Id: <20181119101535.16538-1-carenas@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

6c213e863a ("http-backend: respect CONTENT_LENGTH for receive-pack", 2018-07-27)
introduced all tests but without a check for CURL support from git.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/t5562-http-backend-content-length.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index b24d8b05a4..7594899471 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -3,6 +3,12 @@
 test_description='test git-http-backend respects CONTENT_LENGTH'
 . ./test-lib.sh
 
+if test -n "$NO_CURL"
+then
+	skip_all='skipping test, git built without http support'
+	test_done
+fi
+
 test_lazy_prereq GZIP 'gzip --version'
 
 verify_http_result() {
-- 
2.20.0.rc0

