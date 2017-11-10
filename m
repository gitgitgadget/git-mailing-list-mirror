Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13D161F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 13:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752794AbdKJNWe (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 08:22:34 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55981 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752411AbdKJNWd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 08:22:33 -0500
Received: by mail-wm0-f67.google.com with SMTP id b189so2697536wmd.4
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 05:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T3aNZT9kYUESgKHyJM3uN5l/DzTxzbSo84nH4+wkWXI=;
        b=BujoXhGjh1ECrdgCs+M3Z6MUdZhckCTmvf7uYyEOpwJbydCb4ld4o15vfWxsKub0yJ
         JCOBcFqWWvDbIWapJyEaZ2LbcZ3LmpU52Hb38xhR2SjTVspfHeCRhnFdxNDJB1rd26FD
         hSxhEuUbmSf7ijArNABsfIcUFf8YuZrumuj6NWmLKBd5OPu78a6JKA/PnV6Vm9fc2fDe
         ORzjad6aONJzgPDjX0LfD8Gtt+Vqaw57evKri1BIYzx84S49W/rKZFjt4ua8E5679Mh+
         gXl66RGColkf5DSh0VyUO1D0AXINit8IYgS/IB43N8Ojl2CPJWilVV7m0YlHCTcSFIcx
         f4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T3aNZT9kYUESgKHyJM3uN5l/DzTxzbSo84nH4+wkWXI=;
        b=qNVP3/yrZJixbZKFNX7zqhYGFOv3gBiyzexcgAbYhqruVbBrDGFcz6GGfkDoKvN1ye
         1IuM6YT580Oi6IgZxORk4KDr1o8+yOVIzpTXuQ37Le0phHzjFRWj4iUV7ti7QX2egAMx
         PFDU+rPUJym+PhsqBU2Aatr7u6VUMLaOvoitbO1VmDCRiJMOcxraIoDjF/fFX8gJ7cd+
         2mfmpCdjnRn6PGHoeIp8pVbN2I5RXCHokNjN3ApxG1bzKJlvm/ucGLUC9Fty7DefbUu8
         CaarFbA4DEilEyCbYes+Spuo3xVjlGWwzYZDyQjT+Fy3GD7EQYrLp/oZVAYFrf7ttc4R
         7TNQ==
X-Gm-Message-State: AJaThX5beb8A5wrnpgqNmxZQLvmO+Kx4KystKtOPOTaU6vxfTyBBv5qK
        HP3diw19IwoVq9XrUOqle4SWx+Un
X-Google-Smtp-Source: AGs4zMaAffdJv7k+kn4JRhyVvXCrwrCdoUV68r6qhSVFkMqbYs7uJ7rAQxx04E/1mVFq9vnGhRyxnQ==
X-Received: by 10.28.131.200 with SMTP id f191mr235696wmd.39.1510320151556;
        Fri, 10 Nov 2017 05:22:31 -0800 (PST)
Received: from christian-Latitude-E6330.register.onboard.eurostar.com ([82.113.183.179])
        by smtp.gmail.com with ESMTPSA id 19sm2232731wmn.15.2017.11.10.05.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Nov 2017 05:22:30 -0800 (PST)
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
Subject: [PATCH v3 2/8] t0021/rot13-filter: refactor packet reading functions
Date:   Fri, 10 Nov 2017 14:21:54 +0100
Message-Id: <20171110132200.7871-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.0.132.g7ad97d78be
In-Reply-To: <20171110132200.7871-1-chriscool@tuxfamily.org>
References: <20171110132200.7871-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To make it possible in a following commit to move packet
reading and writing functions into a Packet.pm module,
let's refactor these functions, so they don't handle
printing debug output and exiting.

While at it let's create packet_key_val_read()
to still handle erroring out in a common case.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0021/rot13-filter.pl | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index 4b2d9087d4..b1909699f4 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -74,8 +74,7 @@ sub packet_bin_read {
 	my $bytes_read = read STDIN, $buffer, 4;
 	if ( $bytes_read == 0 ) {
 		# EOF - Git stopped talking to us!
-		print $debug "STOP\n";
-		exit();
+		return ( -1, "" );
 	}
 	elsif ( $bytes_read != 4 ) {
 		die "invalid packet: '$buffer'";
@@ -99,10 +98,20 @@ sub packet_bin_read {
 
 sub packet_txt_read {
 	my ( $res, $buf ) = packet_bin_read();
-	unless ( $buf eq '' or $buf =~ s/\n$// ) {
-		die "A non-binary line MUST be terminated by an LF.";
+	if ( $res == -1 or $buf eq '' or $buf =~ s/\n$// ) {
+		return ( $res, $buf );
+	}
+	die "A non-binary line MUST be terminated by an LF.";
+}
+
+# Read a text line and check that it is in the form "key=value"
+sub packet_key_val_read {
+	my ( $key ) = @_;
+	my ( $res, $buf ) = packet_txt_read();
+	if ( $res == -1 or ( $buf =~ s/^$key=// and $buf ne '' ) ) {
+		return ( $res, $buf );
 	}
-	return ( $res, $buf );
+	die "bad $key: '$buf'";
 }
 
 sub packet_bin_write {
@@ -152,13 +161,18 @@ print $debug "init handshake complete\n";
 $debug->flush();
 
 while (1) {
-	my ( $command ) = packet_txt_read() =~ /^command=(.+)$/;
+	my ( $res, $command ) = packet_key_val_read("command");
+	if ( $res == -1 ) {
+		print $debug "STOP\n";
+		exit();
+	}
 	print $debug "IN: $command";
 	$debug->flush();
 
 	if ( $command eq "list_available_blobs" ) {
 		# Flush
-		packet_bin_read();
+		packet_compare_lists([1, ""], packet_bin_read()) ||
+			die "bad list_available_blobs end";
 
 		foreach my $pathname ( sort keys %DELAY ) {
 			if ( $DELAY{$pathname}{"requested"} >= 1 ) {
@@ -184,14 +198,13 @@ while (1) {
 		packet_flush();
 	}
 	else {
-		my ( $pathname ) = packet_txt_read() =~ /^pathname=(.+)$/;
+		my ( $res, $pathname ) = packet_key_val_read("pathname");
+		if ( $res == -1 ) {
+			die "unexpected EOF while expecting pathname";
+		}
 		print $debug " $pathname";
 		$debug->flush();
 
-		if ( $pathname eq "" ) {
-			die "bad pathname '$pathname'";
-		}
-
 		# Read until flush
 		my ( $done, $buffer ) = packet_txt_read();
 		while ( $buffer ne '' ) {
@@ -205,6 +218,9 @@ while (1) {
 
 			( $done, $buffer ) = packet_txt_read();
 		}
+		if ( $done == -1 ) {
+			die "unexpected EOF after pathname '$pathname'";
+		}
 
 		my $input = "";
 		{
@@ -215,6 +231,9 @@ while (1) {
 				( $done, $buffer ) = packet_bin_read();
 				$input .= $buffer;
 			}
+			if ( $done == -1 ) {
+				die "unexpected EOF while reading input for '$pathname'";
+			}			
 			print $debug " " . length($input) . " [OK] -- ";
 			$debug->flush();
 		}
-- 
2.15.0.132.g7ad97d78be

