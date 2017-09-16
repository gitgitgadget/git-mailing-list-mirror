Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 134CB20A21
	for <e@80x24.org>; Sat, 16 Sep 2017 08:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751597AbdIPIKU (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:10:20 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34052 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751218AbdIPIHt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:07:49 -0400
Received: by mail-wr0-f193.google.com with SMTP id k20so2369999wre.1
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eg5IWXt4G/b0OD6emKGQVi9r9a66hhZAxREhgCYajmY=;
        b=O6a8QFaj4JzGSwrAYvh00w9hRPprBRH4NuYop0X2IgivxjFPLSMVj/I7sD6AGBaGXT
         44XZqMwGKKp15XcTxstjJxxw4FzkYsijY/HZ2L8BIp9pFbjw2H7SfbAP0mK+BK9L0jNK
         mDOcTF/TLK8bz9LscV1zCcqTQgMEIluyrA/PEKsQRNm6xQZj/EAnfhRqZXlgHNFsPAr/
         fJBjuj7VkEOG5AZTghV0swU/56j32K1YHomWfma0tEEEdR9KIDjhXajEic1kMZcx+CXm
         rChGdj9H9QCRn9YDqd0uhkM9yo+HEdSwLmNgcuN8u3QJgFtyqpNgpfgj1UeD7Mh022r3
         +ENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eg5IWXt4G/b0OD6emKGQVi9r9a66hhZAxREhgCYajmY=;
        b=sxu79x250TWuTS3S9w2bzD8j1T7bneEkuC1/mM1lgdNjMMoZgGq+k61sWbgJD7M+ku
         BhCOtHZ4egzoLwelXFGQ8xYFKnO5LwUNOUD05+SGF4PPuCsmhqUHSmVsZoROB93nm2Q8
         EttPO/OL7dsyN71otbs7FH6x2pTYj8e5Z6S8SBQHWG1wg+FUHz97zIQOuhFh8ScOMPSa
         ac3ExwXsYM0dmW7PAZZat77vq8TjHOmLGBTyvfcamTHpsk+s/K+keLNceCI5za3bOJXv
         hcvrTQ5FLQPxirYDcOi9uU7Wy8przqU5UPfqm0sD9qIyE9oC+QvOTEC/X4ofRkMfaAP7
         uyfg==
X-Gm-Message-State: AHPjjUiee3iy5GY1R6xX2TKqNaR0+u5ujLRRnqbX5YmS3Ul0qKRcgian
        u8OEJtVrguDN7m/l
X-Google-Smtp-Source: ADKCNb7iVwCE2x6J3NaLZnghChFofqepB2UryZBQvGe02vvYtoRhAR1ZkndiJLlkDU5ovJEF4KXOJw==
X-Received: by 10.223.175.217 with SMTP id y25mr25890882wrd.255.1505549266677;
        Sat, 16 Sep 2017 01:07:46 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.07.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:07:45 -0700 (PDT)
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
Subject: [PATCH v6 03/40] t0021/rot13-filter: improve 'if .. elsif .. else' style
Date:   Sat, 16 Sep 2017 10:06:54 +0200
Message-Id: <20170916080731.13925-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
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
index e4495a52f3..82882392ae 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -61,23 +61,20 @@ sub packet_bin_read {
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
@@ -165,8 +162,7 @@ while (1) {
 		$debug->flush();
 		packet_txt_write("status=success");
 		packet_flush();
-	}
-	else {
+	} else {
 		my ( $pathname ) = packet_txt_read() =~ /^pathname=(.+)$/;
 		print $debug " $pathname";
 		$debug->flush();
@@ -205,17 +201,13 @@ while (1) {
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
 
@@ -224,25 +216,21 @@ while (1) {
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
 
@@ -262,8 +250,7 @@ while (1) {
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
2.14.1.576.g3f707d88cd

