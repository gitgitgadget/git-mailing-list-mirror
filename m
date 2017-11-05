Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6812F20281
	for <e@80x24.org>; Sun,  5 Nov 2017 21:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751186AbdKEViv (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 16:38:51 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56415 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751073AbdKEVir (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 16:38:47 -0500
Received: by mail-wm0-f65.google.com with SMTP id z3so10585998wme.5
        for <git@vger.kernel.org>; Sun, 05 Nov 2017 13:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aGCi+z6F8H6GC8FmLT54koF17X2MyWTGRi2ZuIGoIiE=;
        b=G/6b52Xm5Pm2vyv+lfvC6zSiOTM93r9udAWRnr2961fGrGPe2C2DFC9l8hMzKQPXvz
         o5PXREQj0wibojJxDBiwI9ZGAam9+uWpG2J4ZD8TJnxquiLWHfHvb+i/jykPKLMY/91A
         /6VLRjtA2Gqs0m7zrTqfFRYT3aSzOK5aLK4RJyPA8FMERiZf/qrY6vxCfEq29JBKNM/q
         B83TD0wJsN8G6vY3ALpzS4Cqi/8l0ZxLkeg24fJQ66XH77d026iCHQxd1lAy3b/SBPJ3
         b5zJrprhoeGgm7rzAs4vXL4ZYjwgH6cHhfgxnLGnDJ6YfOqccpxwLAsz3G/HDwdzyHrL
         34BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aGCi+z6F8H6GC8FmLT54koF17X2MyWTGRi2ZuIGoIiE=;
        b=pV7uV+gXmJ2UmTUBufVctAyGII0ibza49n3F6obd/T65TK322apXhrap8hJH/30BeG
         U2LqGv+hakP9UPkRB4UGb+rBAhnUFcvqZ4UanrGXmhY6DjvG8nCZcug3P5O4jOtBWDWb
         ntGORL60a2om4jY5j6+BTcwGJhHgNdK4yVmnBIOf4KTl8/KpBEgDSJgnP25EfMy3tNeP
         AQ6czYjwh7fdgb+74A8RjjFWoTIeetLDFqZQkIKLAFw+410fG9gkWDSv/mLqz+KoNJx9
         bdTMdlmoohXD3eTmEj34WxyuMLhWXU2GPg83jUbrCgpj91/jfmZcq8kJ4CDb8UhmKeFi
         kUxw==
X-Gm-Message-State: AJaThX6P8P8r+/52aD53mV5ZjAJRJSgs50CtKjXhix3L6MLeZm6+UwQB
        R+ijbVAevhx+gcOlG0ZJUsJIss2n
X-Google-Smtp-Source: ABhQp+S72BI5cA3R2ntivkp7WXDDZglJhGmoMTdccNYCmNV/RmI0fGE7aGmBuZxh0k/gAqxiuYCAKA==
X-Received: by 10.28.207.200 with SMTP id f191mr3300168wmg.99.1509917925688;
        Sun, 05 Nov 2017 13:38:45 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id h2sm5147323wrf.47.2017.11.05.13.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Nov 2017 13:38:45 -0800 (PST)
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
Subject: [PATCH v2 3/8] t0021/rot13-filter: improve 'if .. elsif .. else' style
Date:   Sun,  5 Nov 2017 22:38:31 +0100
Message-Id: <20171105213836.11717-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.0.8.g15d566f848
In-Reply-To: <20171105213836.11717-1-chriscool@tuxfamily.org>
References: <20171105213836.11717-1-chriscool@tuxfamily.org>
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
index c025518c0a..37cecd8654 100644
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
@@ -195,8 +192,7 @@ while (1) {
 		$debug->flush();
 		packet_txt_write("status=success");
 		packet_flush();
-	}
-	else {
+	} else {
 		my ( $res, $pathname ) = packet_required_key_val_read("pathname");
 		if ( $res == -1 ) {
 			die "unexpected EOF while expecting pathname";
@@ -240,17 +236,13 @@ while (1) {
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
 
@@ -259,25 +251,21 @@ while (1) {
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
 
@@ -297,8 +285,7 @@ while (1) {
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
2.15.0.7.ga9ff306ed9.dirty

