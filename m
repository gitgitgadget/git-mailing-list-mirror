Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B0AD1F406
	for <e@80x24.org>; Fri,  5 Jan 2018 09:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751376AbeAEJNN (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 04:13:13 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:42972 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751357AbeAEJNF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 04:13:05 -0500
Received: by mail-wm0-f68.google.com with SMTP id b141so1214635wme.1
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 01:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ovRUdLnRm5YFZzJD5E45idwHZRdX1saVHrhkPt3eb0c=;
        b=Zmc3m2OUoel+03KiBFwuHjkJXsePQIbRSn6VeSUKlXutCttllu5Ie2sl9sdX2bB3+T
         tHVSr8dEVSTCvzJRrQLELAEsKa6mot3VbsgrHZrCC+UPW7sQZNUCyqciGIxSy+l6dD/z
         Ttponxy/jLubL9/QTm6Jweo70lfbt26ftQN2JE+52iP5WnG6+dJvh81G9LB0+XWOWlPC
         HZOviWoWfj1yRbiOUdmp7WaaJ3O5tWd0Xfej5HxjpFG2MN1wZzrv4MZk/rwwdUyxoApw
         sEvNEZD0IhPMuw0iwGqt068z/gt1rmIWJKTW+qohruI/CrwIZDXDmq/L0LfaGBarLWYj
         xQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ovRUdLnRm5YFZzJD5E45idwHZRdX1saVHrhkPt3eb0c=;
        b=oRCFG3yxZaR0MxfOxBLsruPjjdPwQMnhChzsxNokQKghe7LzVnj7Z5bq8Kvik+1ZPg
         3DSb0IXW262d/VR3kHlBIMoeKdBjpzMmsXvNKgANA981wZRKiF9slDLXc7G6LpFqJdLu
         Bgzuggna7CujH+oCzkR5oqaQehZ3HhQp5P2PDdAS4/gxPiolOFr/KyaUlx1Ud6l40+nE
         ZKzi8oIDtcLGStdNmhRDXPX8zAU1LAJesaIOylgxKBraW0X172Gz5ZUPwUh85HNSxLJi
         ljXJNcARKIpqEZB99Qo+Nxrbx1Aqf1akY2bGrzozMUxYX5371zs5Zzkl0c0QTuW9gA59
         vKrw==
X-Gm-Message-State: AKGB3mLG8tW1+PnHykdJGyob5LarPPw41cZ1M5suKL+bQoJmdpFdrC+Q
        f5XEV+DCisTuLrfIf9jwOutdSmeJ
X-Google-Smtp-Source: ACJfBouwU4+PviEtvLM/1y+QH5VTfVmaTB++LFpoCViqn57L5BXrY7MTHRqlvSMt4cNup53RuZXD9w==
X-Received: by 10.28.45.69 with SMTP id t66mr1767117wmt.120.1515143583347;
        Fri, 05 Jan 2018 01:13:03 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id y42sm7903531wrc.96.2018.01.05.01.13.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jan 2018 01:13:02 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3 7/7] perf/run: read GIT_PERF_REPO_NAME from perf.repoName
Date:   Fri,  5 Jan 2018 10:12:26 +0100
Message-Id: <20180105091226.16083-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.40.gbe5e688583
In-Reply-To: <20180105091226.16083-1-chriscool@tuxfamily.org>
References: <20180105091226.16083-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The GIT_PERF_REPO_NAME env variable is used in
the `aggregate.perl` script to set the 'environment'
field in the JSON Codespeed output.

Let's make it easy to set this variable by setting it
in a config file.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/run | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/perf/run b/t/perf/run
index ef56396546..1a100d6134 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -137,6 +137,9 @@ run_subsection () {
 	get_var_from_env_or_config "GIT_PERF_MAKE_COMMAND" "perf" "makeCommand"
 	get_var_from_env_or_config "GIT_PERF_MAKE_OPTS" "perf" "makeOpts"
 
+	get_var_from_env_or_config "GIT_PERF_REPO_NAME" "perf" "repoName"
+	export GIT_PERF_REPO_NAME
+
 	GIT_PERF_AGGREGATING_LATER=t
 	export GIT_PERF_AGGREGATING_LATER
 
-- 
2.16.0.rc0.40.gbe5e688583

