Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B34541F4C1
	for <e@80x24.org>; Thu, 10 Oct 2019 18:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfJJS2u (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 14:28:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38699 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfJJS2u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 14:28:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id h195so4428471pfe.5
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 11:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HpkOS2jUr3XgDuLmyoLOvcQKAu4Wwx6NqXcGZ5wHtAA=;
        b=aE9W5kxyLebTPHdpI8rhuGTHzEulFfA5BA+n1Bxleha5t3sUQ/e8PPoP6h71+HtDF5
         l4uTsKrUqaowK21x8PGxQ7WKDiPJJLGv4smuGrk2elZzsgmiStE471dA4xYCiSZr5mig
         s3C/s0WwlcuZ8MbB1VAiUa65JcBeccqWvhpblM4LmNslat65tgT0zw+BG5cBFofbv/MS
         fvOkRyUTwUUJ69Sr8ANea470r0Ynu1Cn+ZGAPvVSaiWINyzC2DIhhDMIkhjF7fhDFmK3
         l3ciFCKVQziNl2/hRJyXQuVJcsy3kWFT+9zUcdmUConAkr5/ONwneaJuLMhhpupdBp0R
         9l2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HpkOS2jUr3XgDuLmyoLOvcQKAu4Wwx6NqXcGZ5wHtAA=;
        b=rwZEsIx/Ce7WQaSMOJ+/WXV44uDvGxhUbTv9WiXtX7SaUncHI0lM0ydGgUJ3qHaJkW
         SUpEf9nCZMmHHvDS9wSAZGzTPLLeKJRwqV9QplNhfvBZGWTynO8IeNDgQjKsILRrE/Qd
         Ubb95oNIPPvQa775KCNTteva6KJjzoSmbkDd+BtkCT7lqtpWtVJALF5kCaI8CVdar8ju
         mHNcVXVyCY2BM2D0FYB3li7F9bN7LsdGyGJ7yKilzEKryLum1ecCYYT9bj/YnB2+VHZ+
         LKgV09JGC8cPfV/hF7iDi2Rb6N7W5J2DJyhonjqFD98AMN75zRlgaCDIJCqdApfNds4z
         MbNw==
X-Gm-Message-State: APjAAAVgXCHJyFXlI77ZWm0afoZyoGJRSUlLG/MGllAWM/dNYUpBsTdD
        NLCY6bUbPnsgqcvchRTgEMo=
X-Google-Smtp-Source: APXvYqx5i4fxQvJS6nZBQISBIkizye69iH8urFvBTIvokj8v5x71ycNcCDWu3/Sx8PnWM9KmkfXq4A==
X-Received: by 2002:a63:f810:: with SMTP id n16mr12492142pgh.176.1570732129396;
        Thu, 10 Oct 2019 11:28:49 -0700 (PDT)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id x9sm6164931pje.27.2019.10.10.11.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 11:28:48 -0700 (PDT)
Date:   Thu, 10 Oct 2019 11:28:47 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     James Coglan via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        James Coglan <jcoglan@gmail.com>
Subject: Re: [PATCH 11/11] graph: fix coloring of octopus dashes
Message-ID: <20191010182847.GA1463@generichostname>
References: <pull.383.git.gitgitgadget@gmail.com>
 <ea0df1d94aa6c42eb00d59b268a90a8724322452.1570724021.git.gitgitgadget@gmail.com>
 <20191010181624.GA97861@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010181624.GA97861@generichostname>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 10, 2019 at 11:16:24AM -0700, Denton Liu wrote:
> You can see the results of this by doing:
> 
> 	$ git fetch https://github.com/Denton-L/git.git testing/graph-output
> 	$ git diff FETCH_HEAD^2 t/t4214-log-graph-octopus.sh
> 
> and the resulting diff is very pleasing imo.

I guess it'd probably be nice if the result of that diff were viewable
without the extra work of fetching everything, so here it is:

diff --git a/t/t4214-log-graph-octopus.sh b/t/t4214-log-graph-octopus.sh
index 3ae8e51e50..40d27db674 100755
--- a/t/t4214-log-graph-octopus.sh
+++ b/t/t4214-log-graph-octopus.sh
@@ -26,15 +26,14 @@ test_expect_success 'set up merge history' '
 test_expect_success 'log --graph with tricky octopus merge, no color' '
 	cat >expect.uncolored <<-\EOF &&
 	* left
-	| *---.   octopus-merge
-	| |\ \ \
-	|/ / / /
+	| *-.   octopus-merge
+	|/|\ \
 	| | | * 4
 	| | * | 3
 	| | |/
-	| * | 2
+	| * / 2
 	| |/
-	* | 1
+	* / 1
 	|/
 	* initial
 	EOF
@@ -47,15 +46,14 @@ test_expect_success 'log --graph with tricky octopus merge with colors' '
 	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
 	cat >expect.colors <<-\EOF &&
 	* left
-	<RED>|<RESET> *<BLUE>-<RESET><BLUE>-<RESET><MAGENTA>-<RESET><MAGENTA>.<RESET>   octopus-merge
-	<RED>|<RESET> <RED>|<RESET><YELLOW>\<RESET> <BLUE>\<RESET> <MAGENTA>\<RESET>
-	<RED>|<RESET><RED>/<RESET> <YELLOW>/<RESET> <BLUE>/<RESET> <MAGENTA>/<RESET>
+	<RED>|<RESET> *<MAGENTA>-<RESET><MAGENTA>.<RESET>   octopus-merge
+	<RED>|<RESET><RED>/<RESET><YELLOW>|<RESET><BLUE>\<RESET> <MAGENTA>\<RESET>
 	<RED>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET> * 4
 	<RED>|<RESET> <YELLOW>|<RESET> * <MAGENTA>|<RESET> 3
 	<RED>|<RESET> <YELLOW>|<RESET> <MAGENTA>|<RESET><MAGENTA>/<RESET>
-	<RED>|<RESET> * <MAGENTA>|<RESET> 2
+	<RED>|<RESET> * <MAGENTA>/<RESET> 2
 	<RED>|<RESET> <MAGENTA>|<RESET><MAGENTA>/<RESET>
-	* <MAGENTA>|<RESET> 1
+	* <MAGENTA>/<RESET> 1
 	<MAGENTA>|<RESET><MAGENTA>/<RESET>
 	* initial
 	EOF
@@ -74,9 +72,9 @@ test_expect_success 'log --graph with normal octopus merge, no color' '
 	| | | * 4
 	| | * | 3
 	| | |/
-	| * | 2
+	| * / 2
 	| |/
-	* | 1
+	* / 1
 	|/
 	* initial
 	EOF
@@ -92,9 +90,9 @@ test_expect_success 'log --graph with normal octopus merge with colors' '
 	<RED>|<RESET> <GREEN>|<RESET> <YELLOW>|<RESET> * 4
 	<RED>|<RESET> <GREEN>|<RESET> * <BLUE>|<RESET> 3
 	<RED>|<RESET> <GREEN>|<RESET> <BLUE>|<RESET><BLUE>/<RESET>
-	<RED>|<RESET> * <BLUE>|<RESET> 2
+	<RED>|<RESET> * <BLUE>/<RESET> 2
 	<RED>|<RESET> <BLUE>|<RESET><BLUE>/<RESET>
-	* <BLUE>|<RESET> 1
+	* <BLUE>/<RESET> 1
 	<BLUE>|<RESET><BLUE>/<RESET>
 	* initial
 	EOF
@@ -112,9 +110,9 @@ test_expect_success 'log --graph with normal octopus merge and child, no color'
 	| | | * 4
 	| | * | 3
 	| | |/
-	| * | 2
+	| * / 2
 	| |/
-	* | 1
+	* / 1
 	|/
 	* initial
 	EOF
@@ -123,7 +121,7 @@ test_expect_success 'log --graph with normal octopus merge and child, no color'
 	test_cmp expect.uncolored actual
 '
 
-test_expect_failure 'log --graph with normal octopus and child merge with colors' '
+test_expect_success 'log --graph with normal octopus and child merge with colors' '
 	cat >expect.colors <<-\EOF &&
 	* after-merge
 	*<BLUE>-<RESET><BLUE>-<RESET><MAGENTA>-<RESET><MAGENTA>.<RESET>   octopus-merge
@@ -131,9 +129,9 @@ test_expect_failure 'log --graph with normal octopus and child merge with colors
 	<GREEN>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET> * 4
 	<GREEN>|<RESET> <YELLOW>|<RESET> * <MAGENTA>|<RESET> 3
 	<GREEN>|<RESET> <YELLOW>|<RESET> <MAGENTA>|<RESET><MAGENTA>/<RESET>
-	<GREEN>|<RESET> * <MAGENTA>|<RESET> 2
+	<GREEN>|<RESET> * <MAGENTA>/<RESET> 2
 	<GREEN>|<RESET> <MAGENTA>|<RESET><MAGENTA>/<RESET>
-	* <MAGENTA>|<RESET> 1
+	* <MAGENTA>/<RESET> 1
 	<MAGENTA>|<RESET><MAGENTA>/<RESET>
 	* initial
 	EOF
@@ -147,15 +145,14 @@ test_expect_success 'log --graph with tricky octopus merge and its child, no col
 	cat >expect.uncolored <<-\EOF &&
 	* left
 	| * after-merge
-	| *---.   octopus-merge
-	| |\ \ \
-	|/ / / /
+	| *-.   octopus-merge
+	|/|\ \
 	| | | * 4
 	| | * | 3
 	| | |/
-	| * | 2
+	| * / 2
 	| |/
-	* | 1
+	* / 1
 	|/
 	* initial
 	EOF
@@ -164,20 +161,19 @@ test_expect_success 'log --graph with tricky octopus merge and its child, no col
 	test_cmp expect.uncolored actual
 '
 
-test_expect_failure 'log --graph with tricky octopus merge and its child with colors' '
+test_expect_success 'log --graph with tricky octopus merge and its child with colors' '
 	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
 	cat >expect.colors <<-\EOF &&
 	* left
 	<RED>|<RESET> * after-merge
-	<RED>|<RESET> *<MAGENTA>-<RESET><MAGENTA>-<RESET><CYAN>-<RESET><CYAN>.<RESET>   octopus-merge
-	<RED>|<RESET> <RED>|<RESET><BLUE>\<RESET> <MAGENTA>\<RESET> <CYAN>\<RESET>
-	<RED>|<RESET><RED>/<RESET> <BLUE>/<RESET> <MAGENTA>/<RESET> <CYAN>/<RESET>
+	<RED>|<RESET> *<CYAN>-<RESET><CYAN>.<RESET>   octopus-merge
+	<RED>|<RESET><RED>/<RESET><BLUE>|<RESET><MAGENTA>\<RESET> <CYAN>\<RESET>
 	<RED>|<RESET> <BLUE>|<RESET> <MAGENTA>|<RESET> * 4
 	<RED>|<RESET> <BLUE>|<RESET> * <CYAN>|<RESET> 3
 	<RED>|<RESET> <BLUE>|<RESET> <CYAN>|<RESET><CYAN>/<RESET>
-	<RED>|<RESET> * <CYAN>|<RESET> 2
+	<RED>|<RESET> * <CYAN>/<RESET> 2
 	<RED>|<RESET> <CYAN>|<RESET><CYAN>/<RESET>
-	* <CYAN>|<RESET> 1
+	* <CYAN>/<RESET> 1
 	<CYAN>|<RESET><CYAN>/<RESET>
 	* initial
 	EOF
@@ -209,7 +205,7 @@ test_expect_success 'log --graph with crossover in octopus merge, no color' '
 	test_cmp expect.uncolored actual
 '
 
-test_expect_failure 'log --graph with crossover in octopus merge with colors' '
+test_expect_success 'log --graph with crossover in octopus merge with colors' '
 	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
 	cat >expect.colors <<-\EOF &&
 	* after-4
@@ -257,7 +253,7 @@ test_expect_success 'log --graph with crossover in octopus merge and its child,
 	test_cmp expect.uncolored actual
 '
 
-test_expect_failure 'log --graph with crossover in octopus merge and its child with colors' '
+test_expect_success 'log --graph with crossover in octopus merge and its child with colors' '
 	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
 	cat >expect.colors <<-\EOF &&
 	* after-4
@@ -353,7 +349,7 @@ test_expect_success 'log --graph with unrelated commit and octopus child, no col
 	test_cmp expect.uncolored actual
 '
 
-test_expect_failure 'log --graph with unrelated commit and octopus child with colors' '
+test_expect_success 'log --graph with unrelated commit and octopus child with colors' '
 	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
 	cat >expect.colors <<-\EOF &&
 	* after-initial
