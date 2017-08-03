Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C47B208B5
	for <e@80x24.org>; Thu,  3 Aug 2017 09:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbdHCJTr (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:19:47 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37915 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751750AbdHCJTn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:19:43 -0400
Received: by mail-wm0-f67.google.com with SMTP id y206so1406423wmd.5
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/ooUG+RBNF2PzfTQfDhDcmjNB656gYtJGtQ26H47tkE=;
        b=DvG6Kx6CPik3Suo8p584VfAZ1vs0YI7tMJk4wbhP9PjyYSE75zLywjzIHBYQ8MMFO0
         f250RBnzsyB4E9TxqoYsDagjvlOdODHv2ICmdFChvYM6RADSQCX5/RCueUF3pBIAD3d/
         Ug2uX8S7BvjwgDFa0zVzE/kja6U0cNd803nmV+s6NCZ9fQ60bokQs4GSJbdDprXIpf4F
         co/6ugE4SmqlyiWfYMUvORhUt7uxc74YQdkUoXWhv5YFRzpKvkyYFL0Tq4UmLDuddMIY
         wREueTTaeDFd3v6ZYahsG6OONNM7GUl274G1GCtHrJ++RymZu2DsQUoKg4sTLzMtfARy
         o5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/ooUG+RBNF2PzfTQfDhDcmjNB656gYtJGtQ26H47tkE=;
        b=DEZRBi4xLXUqxdOPvIsBRkWGzgQNUGXE07rUUxOS51nj4t9cT9GdUzr+DyCribjADb
         Bd/MfURh5FZs6EetVSRSDzggEYSBR/+1M8rg20uq+i9Z07ddoaObNun1s3jouQEMvRZX
         dEMRyu4S+ZudIvleE2n4VzBoWeQ62sxMTrARJziDHMoiaebTl2le3KanNJ6j4QXyLM71
         91vHIgh9USW2tptP2wxz8GUHGs60nDhkV6Gxj8o3x3KKbN7Kp1129jcc9KzcoPhG4/vE
         IqJVaTugjXza4IkWx2fP/+iVWrYC1h/soJoOOKEJXlkHqBaKRIFxwjFTZe9xxbMc9Hxm
         Uvvg==
X-Gm-Message-State: AIVw112aE6WrbDwe7L9nAcKx35hlXUiENbKUiwsjhV6QPYMa1nxpIQuM
        ave5OPeNIcThnXoC
X-Received: by 10.28.68.138 with SMTP id r132mr694148wma.26.1501751981519;
        Thu, 03 Aug 2017 02:19:41 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.19.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:19:40 -0700 (PDT)
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
Subject: [PATCH v5 03/40] t0021/rot13-filter: improve 'if .. elsif .. else' style
Date:   Thu,  3 Aug 2017 11:18:49 +0200
Message-Id: <20170803091926.1755-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
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
 t/t0021/rot13-filter.pl | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index d6411ca523..1fc581c814 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -40,23 +40,20 @@ sub packet_bin_read {
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
@@ -144,14 +141,11 @@ while (1) {
 	my $output;
 	if ( $pathname eq "error.r" or $pathname eq "abort.r" ) {
 		$output = "";
-	}
-	elsif ( $command eq "clean" and grep( /^clean$/, @capabilities ) ) {
+	} elsif ( $command eq "clean" and grep( /^clean$/, @capabilities ) ) {
 		$output = rot13($input);
-	}
-	elsif ( $command eq "smudge" and grep( /^smudge$/, @capabilities ) ) {
+	} elsif ( $command eq "smudge" and grep( /^smudge$/, @capabilities ) ) {
 		$output = rot13($input);
-	}
-	else {
+	} else {
 		die "bad command '$command'";
 	}
 
@@ -163,14 +157,12 @@ while (1) {
 		$debug->flush();
 		packet_txt_write("status=error");
 		packet_flush();
-	}
-	elsif ( $pathname eq "abort.r" ) {
+	} elsif ( $pathname eq "abort.r" ) {
 		print $debug "[ABORT]\n";
 		$debug->flush();
 		packet_txt_write("status=abort");
 		packet_flush();
-	}
-	else {
+	} else {
 		packet_txt_write("status=success");
 		packet_flush();
 
@@ -187,8 +179,7 @@ while (1) {
 			print $debug ".";
 			if ( length($output) > $MAX_PACKET_CONTENT_SIZE ) {
 				$output = substr( $output, $MAX_PACKET_CONTENT_SIZE );
-			}
-			else {
+			} else {
 				$output = "";
 			}
 		}
-- 
2.14.0.rc1.52.gf02fb0ddac.dirty

