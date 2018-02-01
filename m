Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C1FA1F576
	for <e@80x24.org>; Thu,  1 Feb 2018 10:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbeBAKPL (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 05:15:11 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34732 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752088AbeBAKPD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 05:15:03 -0500
Received: by mail-wm0-f68.google.com with SMTP id j21so2066800wmh.1
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 02:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Sdcl2XqRkl+W0bLCWxXOgGfOjtP2ZdSyoKAe6u401cs=;
        b=mB+buOgBI1Mw8pQeD61JZHbzqfWqA9l7WiNUk9UURhjnzIGhAPZoXD86kVXpleJezW
         YgNNzgZ7DyFbVe4R0tclu9Uge2fP0a7zDjhHH2aNAvH0okpFTmeMsWcUbeUtzKPclNEL
         esjlPm5qhAUVc0OMK1dc6CfNPMiVR7DDzHWFZgcuD0NQwIoOnza48ESn5GLgMrZVomlj
         9h7C+0jkU4tLIUOhD1AtkK0Aq1iO4hDapMQ91gmSBIkD14CmfdCcHw9u7A6svvZz8+s9
         tG6772Wn8ihJG4BAf2mRVG0h9dchl1Lm14j4y38K0Sk1RouyGry7DMmLj11QzVOoO+4/
         Imog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Sdcl2XqRkl+W0bLCWxXOgGfOjtP2ZdSyoKAe6u401cs=;
        b=P9Svq8irEx66UeXGP3NphpVxhb/q5Q3skbk1l1VCss0Mz3LamtrDPQ3QfVYdAh32X+
         UCipgP1LBQ22S1LwJDa8hXHfdH1Kpe8zdYraIpgrUWkgAjI8Yu0tr6Q9Y95HE10tivqg
         +i4nMGO5MRAjLVM2gxhG2viIK0MqgWOM+v5QR9OFw1mAf6btAV9iF4a5ZQtd+QqMRII6
         yQjfi/hoOucJejdNcPMAOaC2apJez+z/jL+1W/He8v0wf9+dFdiPtEqdkc2PHPkrzGCt
         7w/gJVz/IcDrnmrQXhGHJ1RC4Yxa6IdUCFYZhhEU4XL9kg/NiKDbY1YLoBEiPMdsSHRJ
         s93g==
X-Gm-Message-State: AKwxyteMgBJjt5ZZmMeBisoYIIXaWbMsCo8b3LPQrC8PvS9gz7IPFzhI
        N0eMyW19/b2qvUwj4RVL8bfhrfPu
X-Google-Smtp-Source: AH8x224YEZzOJkOjAlBRk+DME9mldA39oLXdmBng9RuCjeANdonhhcvgK6cCIouCDyNeHOpqSdRGlg==
X-Received: by 10.28.158.208 with SMTP id h199mr25903632wme.17.1517480101407;
        Thu, 01 Feb 2018 02:15:01 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id e16sm21203466wre.5.2018.02.01.02.14.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Feb 2018 02:14:59 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 1/3] perf/aggregate: add --subsection option
Date:   Thu,  1 Feb 2018 11:14:32 +0100
Message-Id: <20180201101434.5383-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc2.45.g09a1bbd803
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes it easier to use the aggregate script
on the command line, to get results from
subsections.

Previously setting GIT_PERF_SUBSECTION was needed
for this purpose.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/aggregate.perl | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

This small patch series contains a few small Codespeed related
usability improvements of the perf/aggregate.perl script on top the
cc/codespeed patch series that was recently merged into master.

Changes compared to v1 are described in each patch if any.

The discussion thread about v1 is there:  

https://public-inbox.org/git/20180128111843.2690-1-chriscool@tuxfamily.org/T/#u

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 5c439f6bc2..bbf0f30898 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -36,7 +36,8 @@ sub format_times {
 	return $out;
 }
 
-my (@dirs, %dirnames, %dirabbrevs, %prefixes, @tests, $codespeed);
+my (@dirs, %dirnames, %dirabbrevs, %prefixes, @tests,
+    $codespeed, $subsection);
 while (scalar @ARGV) {
 	my $arg = $ARGV[0];
 	my $dir;
@@ -45,6 +46,15 @@ while (scalar @ARGV) {
 		shift @ARGV;
 		next;
 	}
+	if ($arg eq "--subsection") {
+		shift @ARGV;
+		$subsection = $ARGV[0];
+		shift @ARGV;
+		if (! $subsection) {
+			die "empty subsection";
+		}
+		next;
+	}
 	last if -f $arg or $arg eq "--";
 	if (! -d $arg) {
 		my $rev = Git::command_oneline(qw(rev-parse --verify), $arg);
@@ -76,10 +86,15 @@ if (not @tests) {
 }
 
 my $resultsdir = "test-results";
-my $results_section = "";
-if (exists $ENV{GIT_PERF_SUBSECTION} and $ENV{GIT_PERF_SUBSECTION} ne "") {
-	$resultsdir .= "/" . $ENV{GIT_PERF_SUBSECTION};
-	$results_section = $ENV{GIT_PERF_SUBSECTION};
+
+if (! $subsection and
+    exists $ENV{GIT_PERF_SUBSECTION} and
+    $ENV{GIT_PERF_SUBSECTION} ne "") {
+	$subsection = $ENV{GIT_PERF_SUBSECTION};
+}
+
+if ($subsection) {
+	$resultsdir .= "/" . $subsection;
 }
 
 my @subtests;
@@ -183,15 +198,15 @@ sub print_default_results {
 }
 
 sub print_codespeed_results {
-	my ($results_section) = @_;
+	my ($subsection) = @_;
 
 	my $project = "Git";
 
 	my $executable = `uname -s -m`;
 	chomp $executable;
 
-	if ($results_section ne "") {
-		$executable .= ", " . $results_section;
+	if ($subsection) {
+		$executable .= ", " . $subsection;
 	}
 
 	my $environment;
@@ -233,7 +248,7 @@ sub print_codespeed_results {
 binmode STDOUT, ":utf8" or die "PANIC on binmode: $!";
 
 if ($codespeed) {
-	print_codespeed_results($results_section);
+	print_codespeed_results($subsection);
 } else {
 	print_default_results();
 }
-- 
2.16.0.rc2.45.g09a1bbd803

