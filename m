Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7570A1F404
	for <e@80x24.org>; Mon, 22 Jan 2018 13:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751099AbeAVNct (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 08:32:49 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33850 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbeAVNcr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 08:32:47 -0500
Received: by mail-wr0-f193.google.com with SMTP id 36so8679471wrh.1
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 05:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8joM1Spc2CydEzs4k21LBkayHYBpTe8seovtfUTMSJ0=;
        b=GzStt2gt+mm/4c4rD1QhJ6iwbbjyXHVQO862FrJZASE6vwP6CJe+8kcA+SEcwVHpCC
         QTQE2AHIzLOved4YmLxJhskdtExUu/DVoodjRKaN5dmgQSNQwWJBme9EAqSfWymGX5zB
         y5vHwwJR5PcdF6YMEePTeFbNkAUCl8B0LJspPPAvYNrsxvGWSjSL/oKkhg4edqqsfMqy
         3Wl5+5NR7GqvFd/HPen6uv39ktVM3vDWpFQZfWgnh0rP/TsuB+N1PBabXxyZwqY+XtPx
         px4nENA1yL/fVlP6AvcISA0frn7CAdsdMwTf4u1cgy5xXWXhfhyf31fOCf8qMYzWxMtP
         hvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8joM1Spc2CydEzs4k21LBkayHYBpTe8seovtfUTMSJ0=;
        b=gZTkxbva3+nYucnNGLv5HPmmebmGynPfn93Efyx+jpUs0gyNkYdoMt+lmic3BGS8mZ
         dbyIZa29MV387VJ9laU+8N0xm/nrZ8UwN3sbcxpcsyuUh1+IZkycDzy8SmcDy2MvrmXU
         EJoqsXUF/A5KLypxc6LLUcbSIdLX4EEJxM7lXFuuBwz5HllJ7SqrXg4aUDdJwLKkIDro
         w33liO6x+5Fn555Yc6Kl2sdiFILAyqzo1rX/otNSYGWJeiILjK/naQRUQyogUnxvfCVV
         i/XbmUml5KFwIZ6demL+CP/u17I7BcPoQrXi3x++bFhUgOIaEKk6srEAo96Sd/011+Wu
         ix+w==
X-Gm-Message-State: AKwxytc/FDcQO1m6Dvgi074Ew3P8h3F6wywBB/kN+KvtwiJUqFVjTPGZ
        RmFFfZVkPL0t1mE2+Pn9lnI=
X-Google-Smtp-Source: AH8x226U5E3OHcUrzeB8YAAtWsuLdlUAZSgLwNYiQsV9lQ7B/Oe2oK/VAER5eM4w+WGTw/yxJ3BtLA==
X-Received: by 10.223.168.21 with SMTP id l21mr6955999wrc.118.1516627966703;
        Mon, 22 Jan 2018 05:32:46 -0800 (PST)
Received: from localhost.localdomain (x590e64ec.dyn.telefonica.de. [89.14.100.236])
        by smtp.gmail.com with ESMTPSA id c54sm24284520wrg.68.2018.01.22.05.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jan 2018 05:32:46 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 5/5] travis-ci: don't fail if user already exists on 32 bit Linux build job
Date:   Mon, 22 Jan 2018 14:32:20 +0100
Message-Id: <20180122133220.18587-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.80.gc0eec9753d
In-Reply-To: <20180122133220.18587-1-szeder.dev@gmail.com>
References: <CAM0VKjmAjw0a2JzsY1BaAwZcCp8ge+jQaGN6L_nKTLugHeWyvQ@mail.gmail.com>
 <20180122133220.18587-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 32 bit Linux build job runs in a Docker container, which lends
itself to running and debugging locally, too.  Especially during
debugging one usually doesn't want to start with a fresh container
every time, to save time spent on installing a bunch of dependencies.
However, that doesn't work quite smootly, because the script running
in the container always creates a new user, which then must be removed
every time before subsequent executions, or the build script fails.

Make this process more convenient and don't try to create that user if
it already exists and has the right user ID in the container, so
developers don't have to bother with running a 'userdel' each time
before they run the build script.

The build job on Travis CI always starts with a fresh Docker
container, so this change doesn't make a difference there.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/run-linux32-build.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
index e37e1d2d5f..13047adde3 100755
--- a/ci/run-linux32-build.sh
+++ b/ci/run-linux32-build.sh
@@ -33,7 +33,13 @@ then
 	CI_USER=root
 else
 	CI_USER=ci
-	useradd -u $HOST_UID $CI_USER
+	if test "$(id -u $CI_USER)" = $HOST_UID
+	then
+		: # user already exists with the right ID
+	else
+		useradd -u $HOST_UID $CI_USER
+	fi
+
 	# Due to a bug the test suite was run as root in the past, so
 	# a prove state file created back then is only accessible by
 	# root.  Now that bug is fixed, the test suite is run as a
-- 
2.16.1.80.gc0eec9753d

