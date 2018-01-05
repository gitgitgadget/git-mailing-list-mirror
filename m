Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2C601F406
	for <e@80x24.org>; Fri,  5 Jan 2018 09:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751402AbeAEJNP (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 04:13:15 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37707 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbeAEJNE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 04:13:04 -0500
Received: by mail-wm0-f47.google.com with SMTP id f140so1201794wmd.2
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 01:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nO7lqokalyArBQhzSfjxEU9B5GQEntcWaPPsQ34/w5s=;
        b=uK3oel/J7Tue6qgi4ifrkRsjNbIn9fCdO0kVcc4ySE3qHLmwiwyMKILOqxe9rDXzmG
         oxJkVWVGjdU+QYfkgRb1Kw1hbLXVx8RnfMUp/2ZiRt3xy8YHTTlxLysCLV9qfGRg6uEW
         YNnARuql3DFk6fWYcCBt6q6SDYiHgJfwceQOshJf41NCM2YBejosvRdZVZTjOJtIu2MO
         YR7w86rb+FMqie29tgbQiiq4jEbJ3OzasVpHDMuz6uL9GhMUQ1+ASYtr1LxntcIbPw2z
         pz6ljd6O/yxdjYwtFz+mtrWKGw13qiBAa3NZO1Fze06ha2XEorb99J4XRX9y1asIBCrE
         wMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nO7lqokalyArBQhzSfjxEU9B5GQEntcWaPPsQ34/w5s=;
        b=tLq91ERloDhkoei0GaVMbPCWxqv9VgOtMJs3QfSL+Nyyp/OX5EvKVRHJVaXijxUrWz
         fPKBIgGQHnrP6Fbkepfu0lPboeahmwmSGcESR12fXHfYgSWMqbY//w0hbmbY2cM3tEJw
         Bmnor7ARw6/ASG7cdLd+6lMqllnnIpWMijWjGnknKWLQvZnh7GZZ/bpDpwN1HHvNo17G
         bCJ3KO1C2gQkstOamZemUnwsBiAv7QBkMXN71T5Od0+7JXj2o2crvLwmXVChxitgDA/U
         5kWx8b8C9D7PbOsIzZGVX8wrZbyLBKO/74KQYvGfTfNmHANJCZnaFojMA2jLjwbraK0m
         iZMA==
X-Gm-Message-State: AKGB3mL6qe37PlRSiSxB03bUGgNH4tGyiaOhAq8W3m0UBZUw0Lp/IGYZ
        GHsYkD81ID/bzWBGMbsLJ0V+By6u
X-Google-Smtp-Source: ACJfBosg0dAun2dp0L1N2u2k/9xv3E4Dh29Ert3Pp7Q9obeb+GQ3MIhWdzEzcZ4xs0vkRh8FA49Y5A==
X-Received: by 10.28.111.90 with SMTP id k87mr1585405wmc.108.1515143582051;
        Fri, 05 Jan 2018 01:13:02 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id y42sm7903531wrc.96.2018.01.05.01.12.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jan 2018 01:13:00 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3 6/7] perf/run: learn to send output to codespeed server
Date:   Fri,  5 Jan 2018 10:12:25 +0100
Message-Id: <20180105091226.16083-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.40.gbe5e688583
In-Reply-To: <20180105091226.16083-1-chriscool@tuxfamily.org>
References: <20180105091226.16083-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's make it possible to set in a config file the URL of
a codespeed server. And then let's make the `run` script
send the perf test results to this URL at the end of the
tests.

This should make is possible to easily automate the process
of running perf tests and having their results available in
Codespeed.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/run | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/t/perf/run b/t/perf/run
index 4e62d6bb3f..ef56396546 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -148,10 +148,20 @@ run_subsection () {
 	test "$GIT_PERF_CODESPEED_OUTPUT" = "true" && codespeed_opt="--codespeed"
 
 	run_dirs "$@"
-	./aggregate.perl $codespeed_opt "$@"
+
+	if test -z "$GIT_PERF_SEND_TO_CODESPEED"
+	then
+		./aggregate.perl $codespeed_opt "$@"
+	else
+		json_res_file="test-results/$GIT_PERF_SUBSECTION/aggregate.json"
+		./aggregate.perl --codespeed "$@" | tee "$json_res_file"
+		send_data_url="$GIT_PERF_SEND_TO_CODESPEED/result/add/json/"
+		curl -v --request POST --data-urlencode "json=$(cat "$json_res_file")" "$send_data_url"
+	fi
 }
 
 get_var_from_env_or_config "GIT_PERF_CODESPEED_OUTPUT" "perf" "codespeedOutput" "--bool"
+get_var_from_env_or_config "GIT_PERF_SEND_TO_CODESPEED" "perf" "sendToCodespeed"
 
 cd "$(dirname $0)"
 . ../../GIT-BUILD-OPTIONS
-- 
2.16.0.rc0.40.gbe5e688583

