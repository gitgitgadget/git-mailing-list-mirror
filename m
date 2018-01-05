Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DA251F406
	for <e@80x24.org>; Fri,  5 Jan 2018 09:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751366AbeAEJNI (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 04:13:08 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43992 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751322AbeAEJM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 04:12:58 -0500
Received: by mail-wr0-f195.google.com with SMTP id s13so1381865wra.10
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 01:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ln2suc6061Eu6XkAUGxf57+H3W2TO7IhvER0o/YAwlQ=;
        b=kljRTIRr1X9TccFBhqJZWxlo8AZqxLkaRwLoV9RQg9A8MbD0Wrw4ZlnruGaACCSBTk
         uUnHQERaz+g6OKeuEA7WfEzfJi41BZwqXSEQlw3XAi8UoT70/FAW0CvGMoX9QxfMTFb1
         04TWA7yfYgnDgSUL7JJKMwiVGBmgMmwyhBCsj1DUMS3VPbwDXv7Nel8xDCIaBZwbdeaU
         k+kxj+nthy4nY1Ag4XV7VbCpVlyYPtm1KI+T7vPqhXEGzb8QAuLF7P9Xdg8+hB2PyDIN
         uEGuAju2NR98fMXsD2uyNjLcNzk5HD/xvmyDE4K21XRvZEjLOfmU3aZW0erHACkK4RrZ
         rNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ln2suc6061Eu6XkAUGxf57+H3W2TO7IhvER0o/YAwlQ=;
        b=YiCTmOM0kzTc0HS9mDERjFrL1NNIdZOsilq8OckYeVIIjwUkQuR04bcdVdPzGhsd+H
         lvWtggrDxukQU7LYRrehRJLzhhmpVm9nWhXyZQ5HG5SGY09L2wNKbKmFnhU7xFOorWBZ
         tsJW+RHNyJFAjO2uKK6oTsHDQNuiPMYl2krhgq56jyzZ/z6YPaUfhhyQblT5buZjj+tP
         VxU6o52axAejrr9HNJ9L9PH48qGf9v8xHACKCoeU3Q94N9O5v9aeCV8lOxxkDFyMFADU
         DfxyKzz4hVogyr47RspWiBFzi+d0Uqf1CZ1el0ETuTEPTyfzvrHU+q0ZztdcRpG3HnRO
         +dpQ==
X-Gm-Message-State: AKGB3mKPZeHHREL7EISuzCw/T03mzoHLvtdbYns+t3IQI6+VjERD/r06
        Dr9ZMAvFgjzB3dUt41r+IZ6+BGvc
X-Google-Smtp-Source: ACJfBouUDTHhXP2ExoOXkSQ8t3Oz0yp4Nl1/1MHFLmmQytFbfnza28snPNpUplgshhS+vw3DZcnjjQ==
X-Received: by 10.223.147.197 with SMTP id 63mr2204816wrp.156.1515143576950;
        Fri, 05 Jan 2018 01:12:56 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id y42sm7903531wrc.96.2018.01.05.01.12.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jan 2018 01:12:56 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3 3/7] perf/aggregate: implement codespeed JSON output
Date:   Fri,  5 Jan 2018 10:12:22 +0100
Message-Id: <20180105091226.16083-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.40.gbe5e688583
In-Reply-To: <20180105091226.16083-1-chriscool@tuxfamily.org>
References: <20180105091226.16083-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Codespeed (https://github.com/tobami/codespeed/) is an open source
project that can be used to track how some software performs over
time. It stores performance test results in a database and can show
nice graphs and charts on a web interface.

As it can be interesting to use Codespeed to see how Git performance
evolves over time and releases, let's implement a Codespeed output
in "perf/aggregate.perl".

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/aggregate.perl | 64 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 3609cb5dc3..5c439f6bc2 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -3,6 +3,7 @@
 use lib '../../perl/blib/lib';
 use strict;
 use warnings;
+use JSON;
 use Git;
 
 sub get_times {
@@ -35,10 +36,15 @@ sub format_times {
 	return $out;
 }
 
-my (@dirs, %dirnames, %dirabbrevs, %prefixes, @tests);
+my (@dirs, %dirnames, %dirabbrevs, %prefixes, @tests, $codespeed);
 while (scalar @ARGV) {
 	my $arg = $ARGV[0];
 	my $dir;
+	if ($arg eq "--codespeed") {
+		$codespeed = 1;
+		shift @ARGV;
+		next;
+	}
 	last if -f $arg or $arg eq "--";
 	if (! -d $arg) {
 		my $rev = Git::command_oneline(qw(rev-parse --verify), $arg);
@@ -70,8 +76,10 @@ if (not @tests) {
 }
 
 my $resultsdir = "test-results";
+my $results_section = "";
 if (exists $ENV{GIT_PERF_SUBSECTION} and $ENV{GIT_PERF_SUBSECTION} ne "") {
 	$resultsdir .= "/" . $ENV{GIT_PERF_SUBSECTION};
+	$results_section = $ENV{GIT_PERF_SUBSECTION};
 }
 
 my @subtests;
@@ -174,6 +182,58 @@ sub print_default_results {
 	}
 }
 
+sub print_codespeed_results {
+	my ($results_section) = @_;
+
+	my $project = "Git";
+
+	my $executable = `uname -s -m`;
+	chomp $executable;
+
+	if ($results_section ne "") {
+		$executable .= ", " . $results_section;
+	}
+
+	my $environment;
+	if (exists $ENV{GIT_PERF_REPO_NAME} and $ENV{GIT_PERF_REPO_NAME} ne "") {
+		$environment = $ENV{GIT_PERF_REPO_NAME};
+	} elsif (exists $ENV{GIT_TEST_INSTALLED} and $ENV{GIT_TEST_INSTALLED} ne "") {
+		$environment = $ENV{GIT_TEST_INSTALLED};
+		$environment =~ s|/bin-wrappers$||;
+	} else {
+		$environment = `uname -r`;
+		chomp $environment;
+	}
+
+	my @data;
+
+	for my $t (@subtests) {
+		for my $d (@dirs) {
+			my $commitid = $prefixes{$d};
+			$commitid =~ s/^build_//;
+			$commitid =~ s/\.$//;
+			my ($result_value, $u, $s) = get_times("$resultsdir/$prefixes{$d}$t.times");
+
+			my %vals = (
+				"commitid" => $commitid,
+				"project" => $project,
+				"branch" => $dirnames{$d},
+				"executable" => $executable,
+				"benchmark" => $shorttests{$t} . " " . read_descr("$resultsdir/$t.descr"),
+				"environment" => $environment,
+				"result_value" => $result_value,
+			    );
+			push @data, \%vals;
+		}
+	}
+
+	print to_json(\@data, {utf8 => 1, pretty => 1}), "\n";
+}
+
 binmode STDOUT, ":utf8" or die "PANIC on binmode: $!";
 
-print_default_results();
+if ($codespeed) {
+	print_codespeed_results($results_section);
+} else {
+	print_default_results();
+}
-- 
2.16.0.rc0.40.gbe5e688583

