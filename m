Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27D5C1F404
	for <e@80x24.org>; Tue, 26 Dec 2017 21:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbdLZV71 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 16:59:27 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:36863 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbdLZV7T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 16:59:19 -0500
Received: by mail-wr0-f174.google.com with SMTP id u19so29030660wrc.3
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 13:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/9kE1cf7MMHYhGQr3XBJ85X7gVwsuT8bjfZZ4+diySQ=;
        b=jgaZRMD2K/eriz55SNM1prSodINP+DxVhqNgE+V/CCNac7wq62O/rKn2EAJ87Yj8iI
         H5uqWR2wbFEbOBcRP88f+/c9BxO593mbg36wRti2RkRtyZu4Km3Eo1iobmPHBS5hR/Rx
         cN8gA853DoLN8I5SxogACLceqlZt+yUw6CeoYtfBo6D1mqXEatRYVV8LfywpZfmIoPZF
         UlKeMu1jsRPvSD9Jw88AkUkAq02qcUsN/AGiytJB8aZh2SGNRACYVSeuWmQAmw4BU0KE
         oP/Ugi9iHjJ901b1cP0tAf4F1B33q/qpUHIftMRJtTuWVYWh8wtnKFadRNOVFmW/3+Ms
         sZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/9kE1cf7MMHYhGQr3XBJ85X7gVwsuT8bjfZZ4+diySQ=;
        b=QbShdyLOvAuIaD2Pkb8O7a+RLDTJdaBFeQhM61adqKPHsaktwVQPSAMTOHj/Dx8lg8
         HpsNLwha0LIq0eex/nIOcpDxcfZf0tbomPLI3oPzY79oTgTDBUBTzpzW7Z5NNc68SYAh
         smjIYeBTPDb9m+sUAuGmbgCpCcQNyBLxwmiwMx4DUlttfKt0p4WyDKqr1hoLWcjmPv4b
         DVljnxUSOOv0ylDHcffSBF96IxT9YHipyHRoREKzTk1HBZwVy++vamTM/7YmumF8z5ao
         IQ8MkVOvJ7kOSEV3c1YK6aoYYeoSQtLT/FeqUcQedHmrUBzF58e1l9UjsdU7rjyykzlR
         5ccQ==
X-Gm-Message-State: AKGB3mL9iPmLWRDbPlb+SIjWcgzWqrLAAtd+hgZdlp9lmP5s01NYpYUB
        QjAh44G55jL6LGY40g+dxJaDYDSi
X-Google-Smtp-Source: ACJfBotf+gimnilBDDgtWcmcV034kk8B9t3voP9ujROg2UMxpzvO4aKDp6D3pDvz9vjYjH4cIap5Kg==
X-Received: by 10.223.135.104 with SMTP id 37mr18662815wrz.182.1514325558263;
        Tue, 26 Dec 2017 13:59:18 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id d71sm24516204wma.7.2017.12.26.13.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Dec 2017 13:59:17 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 6/7] perf/run: learn to send output to codespeed server
Date:   Tue, 26 Dec 2017 22:59:07 +0100
Message-Id: <20171226215908.425-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.361.g8b07d831d0
In-Reply-To: <20171226215908.425-1-chriscool@tuxfamily.org>
References: <20171226215908.425-1-chriscool@tuxfamily.org>
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
2.15.1.361.g8b07d831d0

