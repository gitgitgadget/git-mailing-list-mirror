Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A040E1F407
	for <e@80x24.org>; Wed, 13 Dec 2017 15:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbdLMPOE (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 10:14:04 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37861 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753208AbdLMPOA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 10:14:00 -0500
Received: by mail-wm0-f65.google.com with SMTP id f140so5784216wmd.2
        for <git@vger.kernel.org>; Wed, 13 Dec 2017 07:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k2xHBoPpQAdIOo8yxUDv2DOZivjKFSDZHdrPIkkuHns=;
        b=AD72IaZuSLT4SXBlFZeWYndCyfOdsBhfTsjITpp6sSQPovY74ym0sO5Le1/4AugNVv
         jjci/SWYA6vN88tF8TMq2AXNISFuqy64j/n10/MAB1miqRCOlGkl45Xq/+ee+FiPO6LD
         /5rgGgg2ZOZZ1t3ovhcjE6SDOmxZtl9qVQ+Vg8LXnKvOIw8k/feGPIhDLcX+lH8sFXbr
         cVKxkYvPndqzn1tXfMTk/NKdfl86Rx/gZci4ONUC/y4Hle6aGdg/CLWl3LBQr5Sukn6H
         k08d19QG4Xmt+FoYRl1BLLwIPgYKYEjje6wM7tn/PCdZblz2mzoKh1u7zmi/2m7r91vO
         CIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k2xHBoPpQAdIOo8yxUDv2DOZivjKFSDZHdrPIkkuHns=;
        b=j2ykX7GX8Z06wqWxteJYlgx9DF4t66L62SZxP4+ZrBxoS3j0Ne9hUh7rnLzRTDXrAc
         q3HK5huTkuYqJuqcA8Afq9QYadYlOP6Na4J6cGg2Uy7cYEeUvNDs96y9RHBgxn83YtXs
         Je0LHYOPRL5ByIZnFZ1GJUlwwso2V9Mzvx5qmUM7Hw9BrbmokpOKLcXtpB5lcUD0+H4U
         EW1tqGrQMDOnN3+eE6hTptq2bB7KSiIoW9JdPmZkNfIJjHjHAdD8nPeDe8TNRmgIT4fs
         MVvskwoltEX8eXFfd/RTd57nHrcCj2KTiU2HsL84icwAHbdy+QNsEa/ROPasaedDyJiT
         aXzg==
X-Gm-Message-State: AKGB3mI8nhCyXB4GL2rCIo20K8MawADM74g22ximw3q9fr0sFFPbe3FE
        l4suyoGmRY5AQey0RLlTQ7M1NdEO
X-Google-Smtp-Source: ACJfBosWKTZ4XYlynMTPwK7wNgSg0PBOAZOEmDSvz/lnLZaE/ZRK8atevLWclph6Exx2Qim5v4XJ4w==
X-Received: by 10.80.245.26 with SMTP id t26mr7972418edm.301.1513178037922;
        Wed, 13 Dec 2017 07:13:57 -0800 (PST)
Received: from christian-Latitude-E6330.booking.pcln.com ([185.24.142.26])
        by smtp.gmail.com with ESMTPSA id z56sm1552690edb.72.2017.12.13.07.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Dec 2017 07:13:56 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/8] perf/run: use $default_value instead of $4
Date:   Wed, 13 Dec 2017 16:13:40 +0100
Message-Id: <20171213151344.2138-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.361.g8b07d831d0
In-Reply-To: <20171213151344.2138-1-chriscool@tuxfamily.org>
References: <20171213151344.2138-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/run | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/perf/run b/t/perf/run
index 43e4de49ef..bbd703dc4f 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -105,7 +105,7 @@ get_var_from_env_or_config () {
 	env_var="$1"
 	conf_sec="$2"
 	conf_var="$3"
-	# $4 can be set to a default value
+	default_value="$4" # optional
 
 	# Do nothing if the env variable is already set
 	eval "test -z \"\${$env_var+x}\"" || return
@@ -123,7 +123,7 @@ get_var_from_env_or_config () {
 	conf_value=$(git config -f "$GIT_PERF_CONFIG_FILE" "$var") &&
 	eval "$env_var=\"$conf_value\"" && return
 
-	test -n "${4+x}" && eval "$env_var=\"$4\""
+	test -n "${default_value+x}" && eval "$env_var=\"$default_value\""
 }
 
 run_subsection () {
-- 
2.15.1.361.g8b07d831d0

