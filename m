Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3AD41F404
	for <e@80x24.org>; Mon, 22 Jan 2018 13:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751259AbeAVNcp (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 08:32:45 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40265 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbeAVNcm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 08:32:42 -0500
Received: by mail-wr0-f193.google.com with SMTP id 100so8663304wrb.7
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 05:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mRkAoMV4W6A46l6AIKn7IjEpugxHolsx5nyRQrLxNIk=;
        b=muPmbhG2YBfE+Qvu/uoy+IvbymTyiTe3PsbXOXa1MbcbBeSiA6WqeNqvdXGDGdkerc
         u/sI9raugyaxHLT0CD/ZwWN5czii2LmS05/3pjBpvobNmwa8nIi2YJczi11pgA3w2orj
         UQzzZyb7toIWoDi5CPedLLzdsGf0V3fw453gavu9+CPCw8JX1df8vD6lT+V+nwvkE9ga
         t5KjkThU1ro4N/e2SK2ZbhTUEQv2+5oQ4d4F+3lY0bWgMqdwr2amVOjUze+RdIvlH1KA
         tru40eaYw4c8d5InmevRXw4mVPHlz1aTufySCj+ITV6SdQPIZLmAl4LHifeBfCVpZ57b
         GSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mRkAoMV4W6A46l6AIKn7IjEpugxHolsx5nyRQrLxNIk=;
        b=izKW0RGzFYqrIDCIp6VhhjTyhVa61e464fRWjdas5MH0YjkwekvDZWqO0Tg4Ty3SCI
         AJn8V76pNTEjqvXz0yLy9trZhTPtQ1IIGFBiYrU2q3pFXysg5Mjfze4gco2+Wza1voNr
         NwgVdzcDj8HRAjYwQChYKgo/auxaFWyGQv3cs4D+Ui7oXidbkhbS1/6zJhKURCt8ff1M
         HkwWseB/kd0WRMMRUWoLB9TgXpcWexq6qxHuPUiPSfYSqP+yXUAxr5sCRanBmcxYRRsW
         jRsOAJLtiCjaqTUXPbAE1x5bFcAWnx5VmXB2tS2SoCAOS3pugKenMJnHDeWrRgfUhyGI
         6XTQ==
X-Gm-Message-State: AKwxytf+U7p2vfJpi3wLBoG5OVM5Lgto3514nryV/as62mK16DTByRCn
        FdlcqBBLjIip328vlDqSIto=
X-Google-Smtp-Source: AH8x226knH7t0mOuSfp+PbZR2KGvHmxCAbXb3Lyp4l59omFSazwpapKJWnf8Ck8LW51yDs1+GGrV2A==
X-Received: by 10.223.196.228 with SMTP id o33mr6879833wrf.101.1516627961876;
        Mon, 22 Jan 2018 05:32:41 -0800 (PST)
Received: from localhost.localdomain (x590e64ec.dyn.telefonica.de. [89.14.100.236])
        by smtp.gmail.com with ESMTPSA id c54sm24284520wrg.68.2018.01.22.05.32.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jan 2018 05:32:41 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/5] travis-ci: use 'set -x' for the commands under 'su' in the 32 bit Linux build
Date:   Mon, 22 Jan 2018 14:32:16 +0100
Message-Id: <20180122133220.18587-2-szeder.dev@gmail.com>
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

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/run-linux32-build.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
index c19c50c1c9..5a36a8d7c0 100755
--- a/ci/run-linux32-build.sh
+++ b/ci/run-linux32-build.sh
@@ -26,6 +26,7 @@ test -z $HOST_UID || (CI_USER="ci" && useradd -u $HOST_UID $CI_USER) &&
 
 # Build and test
 linux32 --32bit i386 su -m -l $CI_USER -c '
+    set -x &&
     cd /usr/src/git &&
     ln -s /tmp/travis-cache/.prove t/.prove &&
     make --jobs=2 &&
-- 
2.16.1.80.gc0eec9753d

