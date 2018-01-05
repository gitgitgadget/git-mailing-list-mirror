Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6EF41F406
	for <e@80x24.org>; Fri,  5 Jan 2018 09:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751354AbeAEJNE (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 04:13:04 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37872 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbeAEJM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 04:12:56 -0500
Received: by mail-wr0-f194.google.com with SMTP id f8so3794627wre.4
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 01:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tibdXcLRpg7qYJcS1pb36DjWENd2l7pIORW4mMzrTl0=;
        b=GkvHgfuB0Ejs6CT4tQA4535oXVLWiCuszdp8wNVmA7rgFvD/W16LI7HMUjXGzJGu3H
         FCfROobT7kgPm5LhrNMj9BSxdMFXZlBW7iSsK3/I/a3oE/Od/9yIqdJNYGqGbDsOwlTe
         WPWsgpXmPvQwUimJHGwY6/fnJJWfTcgYKUXux2T5XNDuBdPcbECvPLlcFokubQb+6W7R
         wu4+gkpZuyPPaEePqCSTovEOFWA+Y+J2O16oxKozQEBIcTG3s51v5e0zXIZxIam6sVzQ
         XtT2nKFs2eHGm6BdiKoLPWPLNZVUmNzCvCMmDAkq8ZmVvSa7TvOO089BFxf2V0f1Zqan
         6QFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tibdXcLRpg7qYJcS1pb36DjWENd2l7pIORW4mMzrTl0=;
        b=g6sMezp6PcsDmkxqEJT8fFTlKlI6k0WgPdNKMrqNCcML4ytrBO7VKu6Vr67+xZ85mh
         gzUJTLekYinuYs+jXmExBdUxTVviHIsm6Z5Nq9hCG/JJmaBL6xGDfUQ22bgkCRbZLMh5
         YkR8uGG2cJlePB2Uw7mhlPRosBsRMNyUhRryagLeDY1QTFVyDo/8PcscGX+bcViU+udJ
         TYY5DADEZWKV7ZUnX5vZ184enNwOQ23bRBiohThZfeabZL7ejmIg4SZbHnrVLmR/1FMu
         ogd6RCi6tfIUw++aYdnT1LewPB2FcdXoj+fXKCrMU/J16ev3K2TPLxgMd+T2/zQi3CEV
         DR8Q==
X-Gm-Message-State: AKGB3mLx8tHkFGyj1zEQnqmR+RhUj3WqqNpKwuvHCFggemJI5Rj6KSuR
        BoLOAYcL9Y712KjJkAEjfbLk2jSJ
X-Google-Smtp-Source: ACJfBovsxfZRo+XRyPuTG8ql2qy33iPU6gnYxIq+rHpLXCl/LwPf7j4Cg6XMd0IsEJBvQEw09S/A4Q==
X-Received: by 10.223.157.146 with SMTP id p18mr1938367wre.190.1515143575265;
        Fri, 05 Jan 2018 01:12:55 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id y42sm7903531wrc.96.2018.01.05.01.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jan 2018 01:12:54 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3 2/7] perf/aggregate: refactor printing results
Date:   Fri,  5 Jan 2018 10:12:21 +0100
Message-Id: <20180105091226.16083-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.40.gbe5e688583
In-Reply-To: <20180105091226.16083-1-chriscool@tuxfamily.org>
References: <20180105091226.16083-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we want to implement another kind of output than
the current output for the perf test results, let's
refactor the existing code that outputs the results
in its own print_default_results() function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/aggregate.perl | 96 +++++++++++++++++++++++++++------------------------
 1 file changed, 50 insertions(+), 46 deletions(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 769d418708..3609cb5dc3 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -100,13 +100,6 @@ sub read_descr {
 	return $line;
 }
 
-my %descrs;
-my $descrlen = 4; # "Test"
-for my $t (@subtests) {
-	$descrs{$t} = $shorttests{$t}.": ".read_descr("$resultsdir/$t.descr");
-	$descrlen = length $descrs{$t} if length $descrs{$t}>$descrlen;
-}
-
 sub have_duplicate {
 	my %seen;
 	for (@_) {
@@ -122,54 +115,65 @@ sub have_slash {
 	return 0;
 }
 
-my %newdirabbrevs = %dirabbrevs;
-while (!have_duplicate(values %newdirabbrevs)) {
-	%dirabbrevs = %newdirabbrevs;
-	last if !have_slash(values %dirabbrevs);
-	%newdirabbrevs = %dirabbrevs;
-	for (values %newdirabbrevs) {
-		s{^[^/]*/}{};
+sub print_default_results {
+	my %descrs;
+	my $descrlen = 4; # "Test"
+	for my $t (@subtests) {
+		$descrs{$t} = $shorttests{$t}.": ".read_descr("$resultsdir/$t.descr");
+		$descrlen = length $descrs{$t} if length $descrs{$t}>$descrlen;
 	}
-}
 
-my %times;
-my @colwidth = ((0)x@dirs);
-for my $i (0..$#dirs) {
-	my $d = $dirs[$i];
-	my $w = length (exists $dirabbrevs{$d} ? $dirabbrevs{$d} : $dirnames{$d});
-	$colwidth[$i] = $w if $w > $colwidth[$i];
-}
-for my $t (@subtests) {
-	my $firstr;
+	my %newdirabbrevs = %dirabbrevs;
+	while (!have_duplicate(values %newdirabbrevs)) {
+		%dirabbrevs = %newdirabbrevs;
+		last if !have_slash(values %dirabbrevs);
+		%newdirabbrevs = %dirabbrevs;
+		for (values %newdirabbrevs) {
+			s{^[^/]*/}{};
+		}
+	}
+
+	my %times;
+	my @colwidth = ((0)x@dirs);
 	for my $i (0..$#dirs) {
 		my $d = $dirs[$i];
-		$times{$prefixes{$d}.$t} = [get_times("$resultsdir/$prefixes{$d}$t.times")];
-		my ($r,$u,$s) = @{$times{$prefixes{$d}.$t}};
-		my $w = length format_times($r,$u,$s,$firstr);
+		my $w = length (exists $dirabbrevs{$d} ? $dirabbrevs{$d} : $dirnames{$d});
 		$colwidth[$i] = $w if $w > $colwidth[$i];
-		$firstr = $r unless defined $firstr;
 	}
-}
-my $totalwidth = 3*@dirs+$descrlen;
-$totalwidth += $_ for (@colwidth);
-
-binmode STDOUT, ":utf8" or die "PANIC on binmode: $!";
+	for my $t (@subtests) {
+		my $firstr;
+		for my $i (0..$#dirs) {
+			my $d = $dirs[$i];
+			$times{$prefixes{$d}.$t} = [get_times("$resultsdir/$prefixes{$d}$t.times")];
+			my ($r,$u,$s) = @{$times{$prefixes{$d}.$t}};
+			my $w = length format_times($r,$u,$s,$firstr);
+			$colwidth[$i] = $w if $w > $colwidth[$i];
+			$firstr = $r unless defined $firstr;
+		}
+	}
+	my $totalwidth = 3*@dirs+$descrlen;
+	$totalwidth += $_ for (@colwidth);
 
-printf "%-${descrlen}s", "Test";
-for my $i (0..$#dirs) {
-	my $d = $dirs[$i];
-	printf "   %-$colwidth[$i]s", (exists $dirabbrevs{$d} ? $dirabbrevs{$d} : $dirnames{$d});
-}
-print "\n";
-print "-"x$totalwidth, "\n";
-for my $t (@subtests) {
-	printf "%-${descrlen}s", $descrs{$t};
-	my $firstr;
+	printf "%-${descrlen}s", "Test";
 	for my $i (0..$#dirs) {
 		my $d = $dirs[$i];
-		my ($r,$u,$s) = @{$times{$prefixes{$d}.$t}};
-		printf "   %-$colwidth[$i]s", format_times($r,$u,$s,$firstr);
-		$firstr = $r unless defined $firstr;
+		printf "   %-$colwidth[$i]s", (exists $dirabbrevs{$d} ? $dirabbrevs{$d} : $dirnames{$d});
 	}
 	print "\n";
+	print "-"x$totalwidth, "\n";
+	for my $t (@subtests) {
+		printf "%-${descrlen}s", $descrs{$t};
+		my $firstr;
+		for my $i (0..$#dirs) {
+			my $d = $dirs[$i];
+			my ($r,$u,$s) = @{$times{$prefixes{$d}.$t}};
+			printf "   %-$colwidth[$i]s", format_times($r,$u,$s,$firstr);
+			$firstr = $r unless defined $firstr;
+		}
+		print "\n";
+	}
 }
+
+binmode STDOUT, ":utf8" or die "PANIC on binmode: $!";
+
+print_default_results();
-- 
2.16.0.rc0.40.gbe5e688583

