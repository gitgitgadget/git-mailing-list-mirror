Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 508FF202A2
	for <e@80x24.org>; Thu, 19 Oct 2017 12:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752127AbdJSMa4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 08:30:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53208 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbdJSMaj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 08:30:39 -0400
Received: by mail-wm0-f65.google.com with SMTP id k4so16079162wmc.1
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 05:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uJ2boZk8PVWFfVXPS0tiT9mK89pnL4WPMKOpvlCASQI=;
        b=K3qwJbLzqM56mguAU+UGkSIHnfdsGpH9SVZKhMXxXOMFaODMLvVkZ5nFBPs7Qke3v/
         eUV+YT9KBTGld1h/AAt8/RdHSBplTuFRpmQRiaQcGadmJ2R8+1OHMq3OB8d+bXAq4WtV
         V6Eka92NIk6DtDHZUjxkbjHbzh4KElolX55jMqZkUqP/1TuPVTw8mpmIRALQAjk1vKno
         FeFbzlzNb7Cc/Ui+BfBmdB6NOHVZrRAj1shzHQaftoq6K9+2x3BXw+UTAEap2CseZK3j
         +PPLp5PZwOPZBckpfdkf3xMcfd/YzIKNIZQgONr1tThSsTkOZuVsgXeaNlHKpyzYcZT+
         PgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uJ2boZk8PVWFfVXPS0tiT9mK89pnL4WPMKOpvlCASQI=;
        b=Nsdhm7GsqaPBMFU1Csi1k98ANVUN8iRD5cJlc2CjQIOFXamPDFS5wslUYVKSn+UOu5
         8ke7aAP2kY2B5J9D+PO0pqfh+yTQ+4/Albn3s0MUoR3a1sUEt/9A3RIfW3mlGwF0jC3W
         ahMLrDWH+rH94UoN/ydQB7eK5ZuIqOnyxggskh6gOQt+nXIzpAUGimamVyLa/GjgEOD+
         68oQb1F5XQpxtTXmcVx+lwp4uvAWFGfHYcV9wP1e3RMQsCXl+iZJK3UlRMMl0ZajGwyZ
         q57ovHmD+jRxu8Tif4S9+KFYZlEvs6S72nG7Uj2SU8XRcLdbcP6lNjQqNQKmmRhxA61p
         CywA==
X-Gm-Message-State: AMCzsaXIrZdcOveTK+Y61M7/nAI0m/omB7HYZ53iEl7Z1UfZTLn/bkhy
        kMVTXxyOYoRawCWlf0eZm+yCEg==
X-Google-Smtp-Source: ABhQp+Q8peKcU2HGXSvP+wWm667yyrokH/0If6+RbO9+Fs1unRjuxuITiO1dfMnfwkXq6JPRn64nTw==
X-Received: by 10.28.153.85 with SMTP id b82mr1400258wme.121.1508416238113;
        Thu, 19 Oct 2017 05:30:38 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id 25sm12820879wrv.8.2017.10.19.05.30.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Oct 2017 05:30:37 -0700 (PDT)
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
Subject: [PATCH 2/6] t0021/rot13-filter: improve 'if .. elsif .. else' style
Date:   Thu, 19 Oct 2017 14:30:26 +0200
Message-Id: <20171019123030.17338-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.0.rc1.106.g7e97f58a41
In-Reply-To: <20171019123030.17338-1-chriscool@tuxfamily.org>
References: <20171019123030.17338-1-chriscool@tuxfamily.org>
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
2.15.0.rc1.106.g7e97f58a41

