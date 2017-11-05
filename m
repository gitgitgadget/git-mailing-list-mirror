Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0324520281
	for <e@80x24.org>; Sun,  5 Nov 2017 21:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751138AbdKEVit (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 16:38:49 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:54707 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbdKEViq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 16:38:46 -0500
Received: by mail-wr0-f193.google.com with SMTP id o44so6853475wrf.11
        for <git@vger.kernel.org>; Sun, 05 Nov 2017 13:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RwgIJoFbMKq/Yzl6lfLiK5NpovsnViTa1Cy2bEXBZbY=;
        b=Qs+JC6crf7sM6aKPMnOPpyoqbcrkpGID9d/rXwRNYKIBgHDg0AhF6aV/UQ5cuIHnqv
         H/xBxMXV+6NSUVmYtp/RayHOty7h0RxPEzomZZsUFsUuXVIEJJBbEWFENUTz+Ju0mOXq
         yqVfJlj5TRZ0e+D3EFA6eZWo0sWj7WxdQGqk/ocCTMhMZaUNhKMrAOGuXCHYNYJqLqUy
         Rzjlj1hBUhhNzFOtUG+bdsv7xKrRSs1Uuvskm9tmXzO09ZzkJX8gsq1YBsbyTvrvUc9m
         nTkPiobtv6xy3JB0bIR1yOztK3Lu2l2AKKP8lZ4cexu4pi0PdbnOK95WzmlwI7aNzNkP
         l+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RwgIJoFbMKq/Yzl6lfLiK5NpovsnViTa1Cy2bEXBZbY=;
        b=NXxZU8oUhPWKLPCExfve9jHTyEpORd8jksvInkqjRjWGjQyxWQu/pivOIDjDF+Di/E
         vP220NGudirh7Y3Hgj1/X3cV8tU0Q1JS82MN58TU9mbTKcH2yuVBd/XtTITY8CmOfvbD
         OqQZ7s2gq1Di/81M9BKkvE0wtpDT6rjec8n8X98apx+gdJ1gSX7WvVufo/9MzNQk6teU
         GnmS/NmHt2DB6DraI4WBnc6LpjO+Kp4AHGqQkG5xWwDWo0VeIM2Hg5HqcLrirVMLAyBW
         fD53cG5HsV6xYz5u5x11PSPzfUmrYM72YUTjG2zH9mVC9mhcPsksSYjrXkWqsSlwpHGs
         jvnQ==
X-Gm-Message-State: AMCzsaUh5mq1wiSJiuduyPot2Yy34pga+zmc85+mGRgpByAndXLibHgo
        j5hJC9d9MN2YEMA0zFBVdzeLoYE5
X-Google-Smtp-Source: ABhQp+SxBDZ9hYxjs6URuqlHK4wuUYP6m8h/TsYVwePR8eMC5h2PFMozJmSPEzO0WKChK8IVUnqNYA==
X-Received: by 10.223.186.20 with SMTP id o20mr12485481wrg.3.1509917924355;
        Sun, 05 Nov 2017 13:38:44 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id h2sm5147323wrf.47.2017.11.05.13.38.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Nov 2017 13:38:43 -0800 (PST)
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
Subject: [PATCH v2 2/8] t0021/rot13-filter: refactor packet reading functions
Date:   Sun,  5 Nov 2017 22:38:30 +0100
Message-Id: <20171105213836.11717-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.0.8.g15d566f848
In-Reply-To: <20171105213836.11717-1-chriscool@tuxfamily.org>
References: <20171105213836.11717-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To make it possible in a following commit to move packet
reading and writing functions into a Packet.pm module,
let's refactor these functions, so they don't handle
printing debug output and exiting.

While at it let's create packet_required_key_val_read()
to still handle erroring out in a common case.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0021/rot13-filter.pl | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index 4b2d9087d4..c025518c0a 100644
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
@@ -99,12 +98,21 @@ sub packet_bin_read {
 
 sub packet_txt_read {
 	my ( $res, $buf ) = packet_bin_read();
-	unless ( $buf eq '' or $buf =~ s/\n$// ) {
+	unless ( $res == -1 or $buf eq '' or $buf =~ s/\n$// ) {
 		die "A non-binary line MUST be terminated by an LF.";
 	}
 	return ( $res, $buf );
 }
 
+sub packet_required_key_val_read {
+	my ( $key ) = @_;
+	my ( $res, $buf ) = packet_txt_read();
+	unless ( $res == -1 or ( $buf =~ s/^$key=// and $buf ne '' ) ) {
+		die "bad $key: '$buf'";
+	}
+	return ( $res, $buf );
+}
+
 sub packet_bin_write {
 	my $buf = shift;
 	print STDOUT sprintf( "%04x", length($buf) + 4 );
@@ -152,13 +160,18 @@ print $debug "init handshake complete\n";
 $debug->flush();
 
 while (1) {
-	my ( $command ) = packet_txt_read() =~ /^command=(.+)$/;
+	my ( $res, $command ) = packet_required_key_val_read("command");
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
@@ -184,14 +197,13 @@ while (1) {
 		packet_flush();
 	}
 	else {
-		my ( $pathname ) = packet_txt_read() =~ /^pathname=(.+)$/;
+		my ( $res, $pathname ) = packet_required_key_val_read("pathname");
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
@@ -205,6 +217,9 @@ while (1) {
 
 			( $done, $buffer ) = packet_txt_read();
 		}
+		if ( $done == -1 ) {
+			die "unexpected EOF after pathname '$pathname'";
+		}
 
 		my $input = "";
 		{
@@ -215,6 +230,9 @@ while (1) {
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
2.15.0.7.ga9ff306ed9.dirty

