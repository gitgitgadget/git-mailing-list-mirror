Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F7A31F576
	for <e@80x24.org>; Sun, 28 Jan 2018 11:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751573AbeA1LTN (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 06:19:13 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51916 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751251AbeA1LTL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jan 2018 06:19:11 -0500
Received: by mail-wm0-f67.google.com with SMTP id r71so8925991wmd.1
        for <git@vger.kernel.org>; Sun, 28 Jan 2018 03:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T+z3XeW9SVHbITHbW7y1WkrH9EWv7fqIXTIVRQxNkIs=;
        b=Si17XdByP0gMFOEigSl61kSoj6FWIhlwpaykOH9hcdTVJhLILS4mrQffuu7qITvMVY
         oSWuOVpUBOKlABuv9lF1Tft7O7UclVRGin4caziZkFuvMirw4TmcgGEW2mvC3Ifl2T1p
         5U1lDXvPOS2qrGnAueuA0yoahakgBx3mYzee2XhakaRWQyxpPJvAH2z0dOhAy/cEtgLX
         lJ7mYItBIpV+LtpzmY+aQS8BUo9lM5a24bIJRnZzBJyhR3aTw0XFX0Fw0b9e7wMcMKRr
         3010Ta0ydkje6FaOSxlgi7f8sWAudtAI0VT7Xt/tjLH+PZ12hFGUyQiK8BRf8fyA1fon
         lc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T+z3XeW9SVHbITHbW7y1WkrH9EWv7fqIXTIVRQxNkIs=;
        b=Zp4B6Q3o036M75bhkMPrb9ymgEi8PULjqHKwZflusMFHBlDN+WU2pmqkOlhIfAcdVG
         pLXBnwVy/Ue0/SOH85JV7QSARHicQaJPuFKt++IJM9XVX/SxLBeSB9I9fnChYeX1/gCR
         IpWg9gB5VxlkCqhHBfhwX1/auKFnJ31bMnt+NWzKYM8TpPcLva7LQHduhqP3HI9jaZ3d
         41/QmQWgU9ZrR0QQXJO9AWvX/NMs+zL8U14YErEIo/U9aLGpS/bPoQtKs/XBAlX52oUn
         nPnrvFrTXBJ4L7JUh/xo59lifN5RN78/sd7NbiIj1rLjfHjIL5Fa0Jno35SvVLXB6+ty
         YzAg==
X-Gm-Message-State: AKwxytdvHmzhuK+aRrGtaeb1qtI106SnT2dXtrhps6GGbbyYeJK/FFVs
        YiDE00yLYFSis4pw70bWu9kH7uyO
X-Google-Smtp-Source: AH8x227TFPxbyi7fV0z/24noF7Ctjzw+9vVBd1Ng/ohC1jNrb6zXROULj5pDmyfewd9FMLMj2m0jrA==
X-Received: by 10.28.213.129 with SMTP id m123mr14009176wmg.91.1517138349618;
        Sun, 28 Jan 2018 03:19:09 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id 123sm8343306wmt.31.2018.01.28.03.19.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jan 2018 03:19:09 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 2/3] perf/aggregate: add --reponame option
Date:   Sun, 28 Jan 2018 12:18:42 +0100
Message-Id: <20180128111843.2690-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc2.45.g09a1bbd803
In-Reply-To: <20180128111843.2690-1-chriscool@tuxfamily.org>
References: <20180128111843.2690-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes it easier to use the aggregate script
on the command line when one wants to get the
"environment" fields set in the codespeed output.

Previously setting GIT_REPO_NAME was needed
for this purpose.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/aggregate.perl | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index bbf0f30898..d616d31ca8 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -37,7 +37,7 @@ sub format_times {
 }
 
 my (@dirs, %dirnames, %dirabbrevs, %prefixes, @tests,
-    $codespeed, $subsection);
+    $codespeed, $subsection, $reponame);
 while (scalar @ARGV) {
 	my $arg = $ARGV[0];
 	my $dir;
@@ -55,6 +55,15 @@ while (scalar @ARGV) {
 		}
 		next;
 	}
+	if ($arg eq "--reponame") {
+		shift @ARGV;
+		$reponame = $ARGV[0];
+		shift @ARGV;
+		if (! $reponame) {
+			die "empty reponame";
+		}
+		next;
+	}
 	last if -f $arg or $arg eq "--";
 	if (! -d $arg) {
 		my $rev = Git::command_oneline(qw(rev-parse --verify), $arg);
@@ -209,15 +218,17 @@ sub print_codespeed_results {
 		$executable .= ", " . $subsection;
 	}
 
-	my $environment;
-	if (exists $ENV{GIT_PERF_REPO_NAME} and $ENV{GIT_PERF_REPO_NAME} ne "") {
-		$environment = $ENV{GIT_PERF_REPO_NAME};
-	} elsif (exists $ENV{GIT_TEST_INSTALLED} and $ENV{GIT_TEST_INSTALLED} ne "") {
-		$environment = $ENV{GIT_TEST_INSTALLED};
-		$environment =~ s|/bin-wrappers$||;
-	} else {
-		$environment = `uname -r`;
-		chomp $environment;
+	my $environment = $reponame;
+	if (! $environment) {
+		if (exists $ENV{GIT_PERF_REPO_NAME} and $ENV{GIT_PERF_REPO_NAME} ne "") {
+			$environment = $ENV{GIT_PERF_REPO_NAME};
+		} elsif (exists $ENV{GIT_TEST_INSTALLED} and $ENV{GIT_TEST_INSTALLED} ne "") {
+			$environment = $ENV{GIT_TEST_INSTALLED};
+			$environment =~ s|/bin-wrappers$||;
+		} else {
+			$environment = `uname -r`;
+			chomp $environment;
+		}
 	}
 
 	my @data;
-- 
2.16.0.rc2.45.g09a1bbd803

