Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1055020248
	for <e@80x24.org>; Sun, 31 Mar 2019 13:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbfCaNrZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Mar 2019 09:47:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55679 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfCaNrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Mar 2019 09:47:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id o25so7376110wmf.5
        for <git@vger.kernel.org>; Sun, 31 Mar 2019 06:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mqpkrNR1P5CYNde3Z3grem5V4WT7WS4kIpFjg/5cxGc=;
        b=OFLyKYNdCZDRy/jTSOd5LR2UfZ1CXhf4cBwYQpS7Jw/ZjLZXnBpYZJjmPJmGD1v3On
         4nRJZYh6PXgRsDlZFcpkjzZq1kfbGkEO5s8lZWbsQgv71qLU6O9+0y8JpRbmsd6PXaKK
         HZNWSlnrCx4bqFxGz2JHXCkBBPNsZitzXpsgFIEjYdx/SCWlUDt3CWiie/J60jBS/cRz
         I662fnAZyS7RSR4L2tY/r5uenpsYdDjMHdl70rJU+5AunkQuScsQWvdV27sXhLiFkpDu
         8AR9IQKoXIiftv8bb/wuygR/9Y0e41ZVigVJIfsuxlBFS/6rq8b6bxEgQC+HswnZcVho
         VUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mqpkrNR1P5CYNde3Z3grem5V4WT7WS4kIpFjg/5cxGc=;
        b=I17Q2TQBKeWjra6zP1yB0mVjKx1t1fHZyMMDBcFK0hfhKJ8+onUvN2/TV+8GshA+r+
         9B0Pdi8f9m7J/n3crWSnir5ChZXFNgiJWD9hRNljbM4nKfosJX9raeaou6BIHB4u5ruV
         h2SjGkSYWw1gxSvMqqtMj0q2kXx75Xn3JrKZaZbWauQimxyt/KGY7VTSH5+DnSD5qsM0
         /XbNmWEHojGDSOJI1Rs7xAjQEFh/iY00eNloiGD7oT3wyVnClq53slpd2y5B22m9GPGG
         DOqUW+IR2zWyb7iBGNbHH9It6NXaCvjBS4HtYagoyopGroiywHI2+wrlTStOESFSn8yp
         hA6Q==
X-Gm-Message-State: APjAAAXNwqZEX15wFGSnVm9paMbrf2Edb2768za0lbySJPcWv2SmGdga
        llQFn3heC31URk0vy9Srwv4TitQ6
X-Google-Smtp-Source: APXvYqz+ou0gUizo5GytJteGf/mpxg32KeQcZq+0nWkLxH5f6p2WfYoxdHEhrOltqv6mCziw6NvoUw==
X-Received: by 2002:a1c:ac07:: with SMTP id v7mr2136952wme.49.1554040043507;
        Sun, 31 Mar 2019 06:47:23 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:10ce:4d96:49c5:28f4:744c:fa99])
        by smtp.gmail.com with ESMTPSA id o10sm10290490wru.54.2019.03.31.06.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 06:47:23 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andreas Schwab <schwab@suse.de>, Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/4] t6050: use test_line_count instead of wc -l
Date:   Sun, 31 Mar 2019 15:46:56 +0200
Message-Id: <20190331134659.28808-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.69.g2d86a08d09
In-Reply-To: <20190331134659.28808-1-chriscool@tuxfamily.org>
References: <20190331134659.28808-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This modernizes a test and makes it more portable.

Reviewed-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6050-replace.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index d638119750..41b177936e 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -393,9 +393,11 @@ test_expect_success 'replace ref cleanup' '
 '
 
 test_expect_success '--graft with and without already replaced object' '
-	test $(git log --oneline | wc -l) = 7 &&
+	git log --oneline >log &&
+	test_line_count = 7 log &&
 	git replace --graft $HASH5 &&
-	test $(git log --oneline | wc -l) = 3 &&
+	git log --oneline >log &&
+	test_line_count = 3 log &&
 	commit_has_parents $HASH5 &&
 	test_must_fail git replace --graft $HASH5 $HASH4 $HASH3 &&
 	git replace --force -g $HASH5 $HASH4 $HASH3 &&
-- 
2.21.0.69.g2d86a08d09

