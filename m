Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26A011F42D
	for <e@80x24.org>; Mon, 26 Mar 2018 07:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751127AbeCZHZC (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 03:25:02 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34288 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751107AbeCZHZA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 03:25:00 -0400
Received: by mail-wr0-f196.google.com with SMTP id o8so17757692wra.1
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 00:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0HKDOrpL8xZiWnxkX1/XFAFRjF2dxZ7GlVjz2gxN6Wg=;
        b=bbL1QCP/HO5yv1sLdfOf4AhPly/PziXDD9jqGnk4JBV2fH+ns+DXbjDpGi+wyq9Bd1
         gU1BsR6oKBs7LNgLRKMBoArC+cwF8SI0Ve5tGWCuj5DE64Uv+PR3N/E+QcfideQAjIJj
         7mtiIuQcnAtXIBe9LFr7ms3hc1FfguUl+ut1mh7CrXMbLLdcHZiqv8kcrVl/sFQqIWkz
         PqU7SoMmy7txf23EWEDblZGAL2394p8h0HOm0qczGE1bX2D/8WURa1+AePj+q+UHMGcj
         NJyM7s+wVvo7zb0zlUi7Cm0ruD/CvgVOAnEjbeybkrJYSTB1pD3WM2rRnWSss0qLWCWT
         o9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0HKDOrpL8xZiWnxkX1/XFAFRjF2dxZ7GlVjz2gxN6Wg=;
        b=KzGXX7nFgdr8u4RdPGlpU8bFLtLkDsMJmlPXcJi337JpZKZJyZDC0Wu6pfKaBZc7i9
         aVUXGE1Cc2k1mWizWUOURsI37GY4S0AY0DlhEp3D4oR77L2XA/pJfyRr9dTNsQ87IIzW
         dXc58B3AergM7nfjWHWeEan74dK3xf/S6x7XjHGsYjlPqxNuvSeKbi8M8LTKfT19UepQ
         hvog+l5F1gr5ICDOxSitdG8wPrvDau1qZqXRl5HHMDvhR9QpGvIArCYl+KDi0WOJc2XN
         SOFS9xycp8LtFv1CTjFzET7Xl8fqyxKr9DewlnEXIxgsCd6SExdEADdQ5flCSQN6HOgb
         w4zg==
X-Gm-Message-State: AElRT7F3e9XGNiTKi+DkoAEmljh3EnQHNMVce2cuS1igf66YaU8Bp9gX
        snFDO+B1NGwdzZ3/BdcsrlkOQCh0
X-Google-Smtp-Source: AIpwx4/9m8abfdP635bFhSTJAsRUBUsF6phxXiYe2X71RlU0nehmF30SdcbkQZmWmQvjTibQiR4iYg==
X-Received: by 10.223.226.205 with SMTP id d13mr2996327wrj.152.1522049098209;
        Mon, 26 Mar 2018 00:24:58 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id u8sm2820922wmf.2.2018.03.26.00.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Mar 2018 00:24:57 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 2/2] perf/aggregate: add --sort-by=regression option
Date:   Mon, 26 Mar 2018 09:24:31 +0200
Message-Id: <20180326072431.30771-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc1.36.g098d832c9.dirty
In-Reply-To: <20180326072431.30771-1-chriscool@tuxfamily.org>
References: <20180326072431.30771-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the most interesting thing one can be interested in when
looking at performance test results is possible performance
regressions.

This new option makes it easy to spot such possible regressions.

This new option is named '--sort-by=regression' to make it
possible and easy to add other ways to sort the results, like for
example '--sort-by=utime'.

If we would like to sort according to how much the stime regressed
we could also add a new option called '--sort-by=regression:stime'.
Then '--sort-by=regression' could become a synonym for
'--sort-by=regression:rtime'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/aggregate.perl | 59 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 890d85fa7b..48637ef64b 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -37,7 +37,7 @@ sub format_times {
 }
 
 my (@dirs, %dirnames, %dirabbrevs, %prefixes, @tests,
-    $codespeed, $subsection, $reponame);
+    $codespeed, $sortby, $subsection, $reponame);
 while (scalar @ARGV) {
 	my $arg = $ARGV[0];
 	my $dir;
@@ -46,6 +46,18 @@ while (scalar @ARGV) {
 		shift @ARGV;
 		next;
 	}
+	if ($arg =~ /--sort-by(?:=(.*))?/) {
+		shift @ARGV;
+		if (defined $1) {
+			$sortby = $1;
+		} else {
+			$sortby = shift @ARGV;
+			if (! defined $sortby) {
+				die "'--sort-by' requires an argument";
+			}
+		}
+		next;
+	}
 	if ($arg eq "--subsection") {
 		shift @ARGV;
 		$subsection = $ARGV[0];
@@ -209,6 +221,49 @@ sub print_default_results {
 	}
 }
 
+sub print_sorted_results {
+	my ($sortby) = @_;
+
+	if ($sortby ne "regression") {
+		die "only 'regression' is supported as '--sort-by' argument";
+	}
+
+	my @evolutions;
+	for my $t (@subtests) {
+		my ($prevr, $prevu, $prevs, $prevrev);
+		for my $i (0..$#dirs) {
+			my $d = $dirs[$i];
+			my ($r, $u, $s) = get_times("$resultsdir/$prefixes{$d}$t.times");
+			if ($i > 0 and defined $r and defined $prevr and $prevr > 0) {
+				my $percent = 100.0 * ($r - $prevr) / $prevr;
+				push @evolutions, { "percent"  => $percent,
+						    "test"     => $t,
+						    "prevrev"  => $prevrev,
+						    "rev"      => $d,
+						    "prevr"    => $prevr,
+						    "r"        => $r,
+						    "prevu"    => $prevu,
+						    "u"        => $u,
+						    "prevs"    => $prevs,
+						    "s"        => $s};
+			}
+			($prevr, $prevu, $prevs, $prevrev) = ($r, $u, $s, $d);
+		}
+	}
+
+	my @sorted_evolutions = sort { $b->{percent} <=> $a->{percent} } @evolutions;
+
+	for my $e (@sorted_evolutions) {
+		printf "%+.1f%%", $e->{percent};
+		print " " . $e->{test};
+		print " " . format_times($e->{prevr}, $e->{prevu}, $e->{prevs});
+		print " " . format_times($e->{r}, $e->{u}, $e->{s});
+		print " " . display_dir($e->{prevrev});
+		print " " . display_dir($e->{rev});
+		print "\n";
+	}
+}
+
 sub print_codespeed_results {
 	my ($subsection) = @_;
 
@@ -263,6 +318,8 @@ binmode STDOUT, ":utf8" or die "PANIC on binmode: $!";
 
 if ($codespeed) {
 	print_codespeed_results($subsection);
+} elsif (defined $sortby) {
+	print_sorted_results($sortby);
 } else {
 	print_default_results();
 }
-- 
2.17.0.rc1.36.g098d832c9.dirty

