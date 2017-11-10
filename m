Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F31A11F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 13:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752938AbdKJNWl (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 08:22:41 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54102 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752411AbdKJNWk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 08:22:40 -0500
Received: by mail-wm0-f65.google.com with SMTP id g141so2702556wmg.2
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 05:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1TxuHYkcAfTrMA/SsK9Snnl5gpGzfhpESbTUrQGLt2k=;
        b=iIWVRjBSW8T50hyHeZ5KGx/+dh/Y/vWgocSCWvK2wWihDyOZFJE2D/jYooOtEzNcid
         rfo20MrLb4hThX3C57wNP6YHVNDT7JscBruioWuV7BQRCS2HU25KHANWDNvLgC03iBgq
         mqa3BiaiT6ONsD3bx+2NgpWicHRQyaG4SI4g/jAf5Mgj0kGJLHPa5pn0T/lqJpqQAoE4
         hRWICDr/O36f8wPc71oZdCEfmpBrb5/lsum09pNErDq8g31tpTh5iU+duggz4VVj4LwE
         I6kc3Py2nEiXAaAjBoO3Nq/Ts4iLg2m19SY6HZyqJ8hTVFGfhdLJNXIjam3SNb2ZtytQ
         KxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1TxuHYkcAfTrMA/SsK9Snnl5gpGzfhpESbTUrQGLt2k=;
        b=gmAg2qRZSGu0yndUQObkUmvEjOunhsg6kzWKEFFIfMwHyQiky1fYYG7iKfevKctkK/
         za1HdnTBjthSuaQfK+mGanysaGIoaBwnOHddhYluq7sPEYCKHJNlrNI9Fle5HBs5Yrbb
         ir3htKhnTU8pdcqs26mjJbVfyFObWmPKlKV5WmEC0De9Xs9DmDRLKeRCGz0XABm2WOhA
         2SGDaHSZEEeTcekR76NLPb53bsqfnBf2QIHpNKtHwKrTc3hrz5Oqf64sszLh4UDn3VLL
         vZV0stxiD7cRPpimgdWd4S812K8iRTGBGB8kmlK/z89K+10Lkw7vtxMR/oMuU0Im4sAS
         kJeQ==
X-Gm-Message-State: AJaThX56sp3SXoJmC8l2hReFBwh9PxRi85ZrfnR6D8+B3A/+bCI/JP1m
        WY9Y+4DbYhk3K1u18pMt1zLXurRE
X-Google-Smtp-Source: AGs4zMb1wAeSzt5pT/2NJKdgizRjDbPmhX7dDbMV2ckx7y336ZeyvcJNMdlkke2UydsKI9VtYZ0Crw==
X-Received: by 10.28.52.193 with SMTP id b184mr247002wma.13.1510320158550;
        Fri, 10 Nov 2017 05:22:38 -0800 (PST)
Received: from christian-Latitude-E6330.register.onboard.eurostar.com ([82.113.183.179])
        by smtp.gmail.com with ESMTPSA id 19sm2232731wmn.15.2017.11.10.05.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Nov 2017 05:22:37 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 3/8] t0021/rot13-filter: improve 'if .. elsif .. else' style
Date:   Fri, 10 Nov 2017 14:21:55 +0100
Message-Id: <20171110132200.7871-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.0.132.g7ad97d78be
In-Reply-To: <20171110132200.7871-1-chriscool@tuxfamily.org>
References: <20171110132200.7871-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before further refactoring the "t0021/rot13-filter.pl" script,
let's modernize the style of its 'if .. elsif .. else' clauses
to improve its readability by making it more similar to our
other perl scripts.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0021/rot13-filter.pl | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index b1909699f4..8bba97af1a 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -75,23 +75,20 @@ sub packet_bin_read {
 	if ( $bytes_read == 0 ) {
 		# EOF - Git stopped talking to us!
 		return ( -1, "" );
-	}
-	elsif ( $bytes_read != 4 ) {
+	} elsif ( $bytes_read != 4 ) {
 		die "invalid packet: '$buffer'";
 	}
 	my $pkt_size = hex($buffer);
 	if ( $pkt_size == 0 ) {
 		return ( 1, "" );
-	}
-	elsif ( $pkt_size > 4 ) {
+	} elsif ( $pkt_size > 4 ) {
 		my $content_size = $pkt_size - 4;
 		$bytes_read = read STDIN, $buffer, $content_size;
 		if ( $bytes_read != $content_size ) {
 			die "invalid packet ($content_size bytes expected; $bytes_read bytes read)";
 		}
 		return ( 0, $buffer );
-	}
-	else {
+	} else {
 		die "invalid packet size: $pkt_size";
 	}
 }
@@ -196,8 +193,7 @@ while (1) {
 		$debug->flush();
 		packet_txt_write("status=success");
 		packet_flush();
-	}
-	else {
+	} else {
 		my ( $res, $pathname ) = packet_key_val_read("pathname");
 		if ( $res == -1 ) {
 			die "unexpected EOF while expecting pathname";
@@ -241,17 +237,13 @@ while (1) {
 		my $output;
 		if ( exists $DELAY{$pathname} and exists $DELAY{$pathname}{"output"} ) {
 			$output = $DELAY{$pathname}{"output"}
-		}
-		elsif ( $pathname eq "error.r" or $pathname eq "abort.r" ) {
+		} elsif ( $pathname eq "error.r" or $pathname eq "abort.r" ) {
 			$output = "";
-		}
-		elsif ( $command eq "clean" and grep( /^clean$/, @capabilities ) ) {
+		} elsif ( $command eq "clean" and grep( /^clean$/, @capabilities ) ) {
 			$output = rot13($input);
-		}
-		elsif ( $command eq "smudge" and grep( /^smudge$/, @capabilities ) ) {
+		} elsif ( $command eq "smudge" and grep( /^smudge$/, @capabilities ) ) {
 			$output = rot13($input);
-		}
-		else {
+		} else {
 			die "bad command '$command'";
 		}
 
@@ -260,25 +252,21 @@ while (1) {
 			$debug->flush();
 			packet_txt_write("status=error");
 			packet_flush();
-		}
-		elsif ( $pathname eq "abort.r" ) {
+		} elsif ( $pathname eq "abort.r" ) {
 			print $debug "[ABORT]\n";
 			$debug->flush();
 			packet_txt_write("status=abort");
 			packet_flush();
-		}
-		elsif ( $command eq "smudge" and
+		} elsif ( $command eq "smudge" and
 			exists $DELAY{$pathname} and
-			$DELAY{$pathname}{"requested"} == 1
-		) {
+			$DELAY{$pathname}{"requested"} == 1 ) {
 			print $debug "[DELAYED]\n";
 			$debug->flush();
 			packet_txt_write("status=delayed");
 			packet_flush();
 			$DELAY{$pathname}{"requested"} = 2;
 			$DELAY{$pathname}{"output"} = $output;
-		}
-		else {
+		} else {
 			packet_txt_write("status=success");
 			packet_flush();
 
@@ -298,8 +286,7 @@ while (1) {
 				print $debug ".";
 				if ( length($output) > $MAX_PACKET_CONTENT_SIZE ) {
 					$output = substr( $output, $MAX_PACKET_CONTENT_SIZE );
-				}
-				else {
+				} else {
 					$output = "";
 				}
 			}
-- 
2.15.0.132.g7ad97d78be

