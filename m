Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97AEE1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 14:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752871AbeCWOAf (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 10:00:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55790 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752361AbeCWOAd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 10:00:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id t7so3754639wmh.5
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 07:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1rk9hwfF4VGJMNxIMYwcfnpZiDPlZuax6hPYyA5nMmU=;
        b=gypgKFuz6AcoVM14TLWC3tS3Q6aMOqzDDiTevfTAJCcJYIoogCWRXvpMeujwq6IYGG
         TlV5s59vTi5OlbWmjRo+sWqPjOx0v8QzAgd6Xi8IShJZeVhhf7p7+Z2NJCt8YCl9IuHB
         hKERjgvAFsmaVjCPuxWwA8OjyHRhcHsZzDHWepZ5cHMDXL/7UfoLt30HJW6tlJOI1axW
         OfPMmem+x3m0wVk/B1HXyM+UQJu6gSlDu43I7PA/LWXR77nRPxtH78tY4qP4ycQISOqM
         gi3CnF7+Dbkn+TGwOcyhQIfjbtAzJ7VrK7j8Kl2I9GJUJkl+isjFM0BIlOFRiY+1Ix5b
         QQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1rk9hwfF4VGJMNxIMYwcfnpZiDPlZuax6hPYyA5nMmU=;
        b=QluIiLibA+Xzf4X/Wk3dBwsOrMNwC5KuG6BxG+tc8nBgItbWdqHJT5z81TFzRNWl2s
         EQYuKgpO8UwjMyRp4G/BLcDqwLDMwRJLSMRKI5wEyEW/wzhzxvV/f/EOZvr7m7XL4BHQ
         BntmB7cv9k+aKxGcsEOz1WiFPUZcwiTINFpwkXzThDUyIAVc8e9wV0SBz6z8JI1R/UkB
         tc/e6ad11QbRIJCU3Z67c6BDbP48qJGTmtt6LWZzBuMDPijmVf9J1ZLRTCgluOX9xOZF
         UrQWo5CnRVjNgQWCRVGpf7VGDJklHkOK293Ss4BVkMuJGs0vjXi40cZy4Ge+zUjrftIj
         90Gw==
X-Gm-Message-State: AElRT7HqLmZ0PQbmK35SSPlQBzBXTu7NEgl+7d6JNbd9UgY7sbHD5hbD
        aQGIJJbFMC1rfm+ShRmue326m7gn
X-Google-Smtp-Source: AG47ELv2y+g1N3lD9Z/YJVL9xYKnZop706Q+GMRCmHs6yYVBkaBAYV1pXxqKiM0G1t+gLnVme4X3Lw==
X-Received: by 10.80.153.14 with SMTP id k14mr18823676edb.298.1521813630654;
        Fri, 23 Mar 2018 07:00:30 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com ([185.24.142.26])
        by smtp.gmail.com with ESMTPSA id d89sm6245930edc.75.2018.03.23.07.00.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 07:00:29 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v1 2/2] perf/aggregate: add --sortbyregression option
Date:   Fri, 23 Mar 2018 15:00:07 +0100
Message-Id: <20180323140007.12096-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180323140007.12096-1-chriscool@tuxfamily.org>
References: <20180323140007.12096-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the most interesting thing one can be interested
in when looking at performance test results is possible
performance regressions.

This new option makes it easy to spot such possible
regressions.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/aggregate.perl | 48 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index b9c0e3243d..9d032b286e 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -37,7 +37,7 @@ sub format_times {
 }
 
 my (@dirs, %dirnames, %dirabbrevs, %prefixes, @tests,
-    $codespeed, $subsection, $reponame);
+    $codespeed, $sortbyregression, $subsection, $reponame);
 while (scalar @ARGV) {
 	my $arg = $ARGV[0];
 	my $dir;
@@ -46,6 +46,11 @@ while (scalar @ARGV) {
 		shift @ARGV;
 		next;
 	}
+	if ($arg eq "--sortbyregression") {
+		$sortbyregression = 1;
+		shift @ARGV;
+		next;
+	}
 	if ($arg eq "--subsection") {
 		shift @ARGV;
 		$subsection = $ARGV[0];
@@ -209,6 +214,45 @@ sub print_default_results {
 	}
 }
 
+sub print_sortbyregression_results {
+	my ($subsection) = @_;
+
+	my @evolutions;
+	for my $t (@subtests) {
+		my ($prevr, $prevu, $prevs, $prevrev);
+		for my $i (0..$#dirs) {
+			my $d = $dirs[$i];
+			my ($r, $u, $s) = get_times("$resultsdir/$prefixes{$d}$t.times");
+			if ($i > 0 and defined $r and defined $prevr and $prevr > 0) {
+			    my $percent = 100.0 * ($r - $prevr) / $prevr;
+			    push @evolutions, { "percent"  => $percent,
+						"test"     => $t,
+						"prevrev"  => $prevrev,
+						"rev"      => $d,
+						"prevr"    => $prevr,
+						"r"        => $r,
+						"prevu"    => $prevu,
+						"u"        => $u,
+						"prevs"    => $prevs,
+						"s"        => $s};
+			}
+			($prevr, $prevu, $prevs, $prevrev) = ($r, $u, $s, $d);
+		}
+	}
+
+	my @sorted_evolutions = sort { $b->{percent} <=> $a->{percent} } @evolutions;
+
+	for my $e (@sorted_evolutions) {
+	    printf "%+.1f%%", $e->{percent};
+	    print " " . $e->{test};
+	    print " " . format_times($e->{prevr}, $e->{prevu}, $e->{prevs});
+	    print " " . format_times($e->{r}, $e->{u}, $e->{s});
+	    print " " . display_dir($e->{prevrev});
+	    print " " . display_dir($e->{rev});
+	    print "\n";
+	}
+}
+
 sub print_codespeed_results {
 	my ($subsection) = @_;
 
@@ -263,6 +307,8 @@ binmode STDOUT, ":utf8" or die "PANIC on binmode: $!";
 
 if ($codespeed) {
 	print_codespeed_results($subsection);
+} elsif ($sortbyregression) {
+	print_sortbyregression_results($subsection);
 } else {
 	print_default_results();
 }
-- 
2.17.0.rc0.37.g8f476fabe9

