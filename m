Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E35F1F406
	for <e@80x24.org>; Fri,  5 Jan 2018 09:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751372AbeAEJNK (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 04:13:10 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44000 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbeAEJNB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 04:13:01 -0500
Received: by mail-wr0-f195.google.com with SMTP id s13so1382013wra.10
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 01:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lDc6HxqukWvjhNcohQc/yEVkr0y5DkYnEsRi0YtqeI4=;
        b=W+CHXHsGQSuDBip4Dmf2r3u/3bA5vyjXvvegdrbr/8VlS81ra7T0BcdZObDZQB9/eo
         n05rGmmZmXbshb0Nlu4J8PVIrPM1rX9gVtve8HqcAd0rOB4Umrj9RPSd0KBs7tiAkJ+i
         tmlIQlDD2yweVeszbW3gDiSVQiIpzH4iPfHEPFwoESWPnYxzderqLIx5BSEYg6lTH6gv
         gr2nK7aqtSreHlxlewqrvgwUOrwOcWBzf3joqMy9ERp3Esrndzfx4DuZ0k8G2lJolb7P
         0cx0Iai5437ZghLnMKWEwqCO/ud6Z1MM7xhlyhGPsy3X/BJ6shC4qNdFrW/P1xwFSVmU
         OXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lDc6HxqukWvjhNcohQc/yEVkr0y5DkYnEsRi0YtqeI4=;
        b=sAKmBbOF2K7Ix5vSHiOoRfIvox+r7Yb/+E34GB79V+vj5ubuLITABjp3zwEj9yJeWX
         mYJrOagMiFQ4E0PKk0usKNfU6/B6cRX1U3ZhQYwIlu18FPzBtpKmRXF2PGsdgqEKPbz4
         JSoUFG52RkVxvTegDB6Hu+8NWIGhyIOI/I2gN6dNcCVWElzyvSVQ3GVC8K+B6vIWi2lT
         5BVR4b4S35nCDMJXwpb4jpXAWYhX2DvyYOxR/kPoaZUzhPYRIrvypWNdhksTCx/tvZhZ
         9BMjZ1+/7MjohcJyNcFykr6R8TSsv0XVKfAaThS6dznAwg/GaMcL3FDcG9pQaGAtV13/
         g4fw==
X-Gm-Message-State: AKGB3mKGSiRuxUtxQAf03dPQSk4Y5/MPE1q3BEjrT6BC3w8PcHFp0NF8
        bi4aqEGE/TDyTFtnV8vf93BqkAf7
X-Google-Smtp-Source: ACJfBouAPIfFn2rFgMhn0jAljezMR+pIFju6A5KjGxd2WXmWtFKvqL9IywUSM2H5MM1+x80MoFRGHQ==
X-Received: by 10.223.198.69 with SMTP id u5mr2074294wrg.157.1515143579827;
        Fri, 05 Jan 2018 01:12:59 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id y42sm7903531wrc.96.2018.01.05.01.12.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jan 2018 01:12:59 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3 5/7] perf/run: learn about perf.codespeedOutput
Date:   Fri,  5 Jan 2018 10:12:24 +0100
Message-Id: <20180105091226.16083-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.40.gbe5e688583
In-Reply-To: <20180105091226.16083-1-chriscool@tuxfamily.org>
References: <20180105091226.16083-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's make it possible to set in a config file the output
format (regular or codespeed) of the perf tests.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/run | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/perf/run b/t/perf/run
index 214d658172..4e62d6bb3f 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -144,10 +144,15 @@ run_subsection () {
 		set -- . "$@"
 	fi
 
+	codespeed_opt=
+	test "$GIT_PERF_CODESPEED_OUTPUT" = "true" && codespeed_opt="--codespeed"
+
 	run_dirs "$@"
-	./aggregate.perl "$@"
+	./aggregate.perl $codespeed_opt "$@"
 }
 
+get_var_from_env_or_config "GIT_PERF_CODESPEED_OUTPUT" "perf" "codespeedOutput" "--bool"
+
 cd "$(dirname $0)"
 . ../../GIT-BUILD-OPTIONS
 
-- 
2.16.0.rc0.40.gbe5e688583

