Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48BD31F42B
	for <e@80x24.org>; Tue, 26 Dec 2017 21:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751381AbdLZV7R (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 16:59:17 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:45552 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbdLZV7O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 16:59:14 -0500
Received: by mail-wm0-f65.google.com with SMTP id 9so36725919wme.4
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 13:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YNyrj1jGo2QMOkiewHejU2HADl+I0NYtv2vVD63ZsH4=;
        b=MDO+wIW+70OiyzEGhCkuCjvJ5XjfBve+u/80yuDmywi6CrYsFnoZ1kSZDdm/Tcmsl8
         fMrfzwsRdw2is6rIEHjaxFt9XbLu/KX4Va0hQ2RYFwiIGdtqOORA4U79w12FG+bYLgJI
         a/wRhTJUpfNwXzmswfULnJLDLc/gpl3w1RwTQLLpmygpVH6VHSzBasgFjHhUpLIXlrON
         ATbk0N+7O/YWdPJZrLz4rgHNRSaf6frTIlV5W9g2zNkSH7tBlUKEOtk1kHVIcACHPKpd
         RnwfIy0AgPqy2gcQq7/4GgApK1ha4o7/+DOwrk84+6qrcgPgYm0qWphIHJCZUF8HUFtv
         BWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YNyrj1jGo2QMOkiewHejU2HADl+I0NYtv2vVD63ZsH4=;
        b=J1wM0d7HE4cw12dJVBEZ1gpkwNwfhbfFdy3hWtqpdzjHMC+bQHSjfmG/E6f/wHrFFA
         3H+f6jhyzy65PUqgK4F74K8mf+h+ILnI/nXW+H7ThSUdbue7Pa9T9QVWwOWok/q6g3XJ
         KMdtK10z2ecVksfTaoHZ4sm/SXUVB+5RZX1axk4hNa1A0UyMt0mCJou2u+Y7eIXCdNZS
         uG2RVEm7QC395HW0E2mCUfElQr0N8hgr3OrH/hyvcz+r+3Hzxy1Uylmr7l1hMauIAurz
         4bVYUzIMW2KQC3iXr4hl7+u8AtS8vSf+leq5UAnZfcV19qAJ0TubIGjsuFObFEf6Vihs
         TJpQ==
X-Gm-Message-State: AKGB3mLcbrJqxuRcVHvjCn9lQGZTkDUd5PGtbNuZsOjyOuIjQvUUfv/U
        jaRn3GJ3LUdKubGghcFdIGuYNnUr
X-Google-Smtp-Source: ACJfBov64r1dhZjLXuWowNwQgbpWeC6qAGTdkzHZ7a4ZN4eNV57dHuFNfYP7Ol+MBCUQHO86GRzjFQ==
X-Received: by 10.28.217.75 with SMTP id q72mr21114174wmg.9.1514325553286;
        Tue, 26 Dec 2017 13:59:13 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id d71sm24516204wma.7.2017.12.26.13.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Dec 2017 13:59:12 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 2/7] perf/aggregate: refactor printing results
Date:   Tue, 26 Dec 2017 22:59:03 +0100
Message-Id: <20171226215908.425-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.361.g8b07d831d0
In-Reply-To: <20171226215908.425-1-chriscool@tuxfamily.org>
References: <20171226215908.425-1-chriscool@tuxfamily.org>
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
2.15.1.361.g8b07d831d0

