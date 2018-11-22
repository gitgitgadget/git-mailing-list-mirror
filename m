Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 794CF1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 15:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437787AbeKWCTd (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 21:19:33 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42425 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391765AbeKWCTc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 21:19:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so9666873wrx.9
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 07:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sW0q4dxvjWqTu5oModp82GaBkhs4Vx9uSJ36sGQO/bc=;
        b=KblFC5hsPqt+EuLSopCQWHpcZDTSrJ5mQVnC/RCiwJFW/aDe3AwWtKjacH00WKmGqX
         /10dpKYlVaL/FXoIO1AgjVRG3cLngHpRtxDKOW4/Sn6hfNyGForuJFzBK8sNGlXFiBSJ
         Pji2bIQdcU93BebVKYVWou4R8XzXfLpqAdK3Zk/EKdfYQwEgwAX0KKE/mmZZtYN98Km7
         2dFx2nl29Six0O83CxyWKWbp/UO8ETXNxcudkbHTKlRo+8LlGq5DPuQz96Z4XpOkfO8C
         Kvf2uA6tDuxkP6hNVS/nb5xspRsz6uk2g9IJo4XIdp1S+L7vctgQ1yY8UcX5XJ00vLe6
         PC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sW0q4dxvjWqTu5oModp82GaBkhs4Vx9uSJ36sGQO/bc=;
        b=gf+wArJccgvSQBz80/efSss0u/+EP3L7RCFKgDS+jsVC2CEnNSZeEBmJ4NHuPYhJ0g
         TxVd2o4emsRQumKWdocu6Rzp9Dlry5IRfVbjSCNh5S34R4PBHo1fhL9M/zLcqYItco9C
         F1hHyI0bCNf4YAsTXkuUNqV3LhMCtHeKAm/3qKN7IyH/USAN1/yR89DKtGWPI311wbhA
         3gXuewPM3BOa3a7N4k0C805+jxfxE56k7fx09JzNlTd1sz0o3khwwm/n5SptokIHjQMR
         2CF9QJbMDg33/0RpgRMJH2D6AKIfa4/bSLGM0MucnLR4fVCFAgK1kGseIdfRyzOelggp
         5Mow==
X-Gm-Message-State: AA+aEWZGTQw+rtiXPbn452NeDYaeYbQyO0nPeOhKDQ5NucfQSVtCCk92
        rjHO6D4aAyfPEPYcZIj1ubNZVGeSaBA=
X-Google-Smtp-Source: AFSGD/XXyBaMPKdvnci+8WzUpDiB3xkjwRkI20Q34ogc5w7/aJktjDy1qBjW5BiuPjwcaVQc6pPddw==
X-Received: by 2002:adf:9b11:: with SMTP id b17mr9886264wrc.168.1542901178368;
        Thu, 22 Nov 2018 07:39:38 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a17sm7329389wrs.58.2018.11.22.07.39.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 07:39:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 03/10] commit-graph write: rephrase confusing progress output
Date:   Thu, 22 Nov 2018 15:39:15 +0000
Message-Id: <20181122153922.16912-4-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c
In-Reply-To: <20181122132823.9883-1-avarab@gmail.com>
References: <20181122132823.9883-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rephrase the title shown for the progress output emitted by
close_reachable(). The message I added in 7b0f229222 ("commit-graph
write: add progress output", 2018-09-17) gave the impression that it
would count up to the number of commit objects.

But that's not what the number means. It just represents the work
we're doing in several for-loops to do various work before the graph
is written out. So let's just say "Annotating commit graph", that
title makes no such promises, and we can add other loops here in the
future and still consistently show progress output.

See [1] for the initial bug report & subsequent discussion about other
approaching to solving this.

1. https://public-inbox.org/git/20181015165447.GH19800@szeder.dev/

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 965eb23a7b..d11370a2b3 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -648,7 +648,7 @@ static void close_reachable(struct packed_oid_list *oids, int report_progress)
 
 	if (report_progress)
 		progress = start_delayed_progress(
-			_("Annotating commits in commit graph"), 0);
+			_("Annotating commit graph"), 0);
 	for (i = 0; i < oids->nr; i++) {
 		display_progress(progress, ++j);
 		commit = lookup_commit(the_repository, &oids->list[i]);
-- 
2.20.0.rc0.387.gc7a69e6b6c

