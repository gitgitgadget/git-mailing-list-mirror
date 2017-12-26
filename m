Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B48C1F404
	for <e@80x24.org>; Tue, 26 Dec 2017 21:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbdLZV72 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 16:59:28 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:44702 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbdLZV7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 16:59:16 -0500
Received: by mail-wm0-f67.google.com with SMTP id t8so36720086wmc.3
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 13:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ug0LQA4g+o0vg2ws/NZ0QwWQ+sQwBxEO9j6jXyrB6Pw=;
        b=GNG2dvp22GPuLnuhsviHikUTM/Z1uPBrI3+MpPgH3GwBSuwtqzVtQ5kVch/G6mC4on
         6L9vObzmS7RhsSLveXvV0XCrlBwoZ0woTvuz/9dI7BgTQfc27rtSKTrHiymS7pMksoM4
         rt/cMMbNDOc83+AqEZ7IehLHfKuzDAkIzhN9RiC0FR94fvduxnSkMbofjIYRlBKq+UXY
         oksRz7QJ4f5VPjthp7rgGAnUvKbVViMHKwqIA+82n3nEieGQPqRpIP2yyB69LUoKJfV1
         xneYymp9fVnJQ/64y/lsiWba2G5F78ZH34gzLUGjFt4knq1GeEsfwo69Vx2KwXCNtGdK
         ADng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ug0LQA4g+o0vg2ws/NZ0QwWQ+sQwBxEO9j6jXyrB6Pw=;
        b=hlbEsT06BEv8ToSlgK4R2jyPQUzXGsSkiM4gaw6Sjcyjj2ZbuzlIu11u+U7ZJM4F6e
         Tdp9Q7fQKVjijCDEljPfHCPKT3Faxri6VDO2WNAiAkf+n7V4mQU787610nM+0g47SVzY
         kMAGcddtL39CtjoIKFCoEGFaGaqxFfoJJCnfMaHTGayPPxOefc5xxK14JYFh6fsrHN7C
         ebhiO9tVHsVXYjjg5vvcU/AJXBdBq9yite0blSDgmotB7yiWTtpeBScHDj4HQsY14efS
         uuPseJ43YHDlKpCZ+XPcH53UmKVmKQUM6pJ5o0KHT3ihwThSL5IqcLg+Us+9oYc9zymj
         XMwA==
X-Gm-Message-State: AKGB3mLWLzoHqjQjetkHwraSdHCA6qt9veLJtaOhj4Ro6cLOko1aaWbp
        bcw4FSnYSImKC758N79yXp7mjQIc
X-Google-Smtp-Source: ACJfBotizRG6dgMP/ovjGUVAs1YEjkZBBdoplGW1ZqEX7Q4zxc+A8wxZld+D21uf2w+PlqegLv4ulw==
X-Received: by 10.28.46.67 with SMTP id u64mr21633388wmu.64.1514325554640;
        Tue, 26 Dec 2017 13:59:14 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id d71sm24516204wma.7.2017.12.26.13.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Dec 2017 13:59:13 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 3/7] perf/aggregate: implement codespeed JSON output
Date:   Tue, 26 Dec 2017 22:59:04 +0100
Message-Id: <20171226215908.425-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.361.g8b07d831d0
In-Reply-To: <20171226215908.425-1-chriscool@tuxfamily.org>
References: <20171226215908.425-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Codespeed (https://github.com/tobami/codespeed/) is an open source
project that can be used to track how some software performs over
time. It stores performance test results in a database and can show
nice graphs and charts on a web interface.

As it can be interesting to Codespeed to see how Git performance
evolves over time and releases, let's implement a Codespeed output
in "perf/aggregate.perl".

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/aggregate.perl | 67 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 3609cb5dc3..34d74fc015 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -35,10 +35,15 @@ sub format_times {
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
@@ -70,8 +75,10 @@ if (not @tests) {
 }
 
 my $resultsdir = "test-results";
+my $results_section = "";
 if (exists $ENV{GIT_PERF_SUBSECTION} and $ENV{GIT_PERF_SUBSECTION} ne "") {
 	$resultsdir .= "/" . $ENV{GIT_PERF_SUBSECTION};
+	$results_section = $ENV{GIT_PERF_SUBSECTION};
 }
 
 my @subtests;
@@ -174,6 +181,62 @@ sub print_default_results {
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
+	#use Data::Dumper qw/ Dumper /;
+	#print Dumper(\@data);
+
+	use JSON;
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
2.15.1.361.g8b07d831d0

