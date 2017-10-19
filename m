Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB59E202A2
	for <e@80x24.org>; Thu, 19 Oct 2017 12:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbdJSMak (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 08:30:40 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:49409 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751930AbdJSMai (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 08:30:38 -0400
Received: by mail-wr0-f196.google.com with SMTP id g90so8142266wrd.6
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 05:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sXKlYhaZC3+xqa6CmiWEj9jaXhwGnQ802l8XEfpnbzc=;
        b=tf5T+Yd09dHFjkPX+hhs6nmitdQpvoj1eHh1s8mIwqc4OnbAno31rvTUeG9gRja6Ts
         YN4EPkLEgWwmwdhGZhriDbrgTOnnJsVozaol32ttV0kxzKDfJ1bZB8iM+t76WFnyO1z9
         zlUAxwlmdY+ep3K5vMWB6I4iLD9JI7nkti2xYwcCVcVA5OpWNndLy6iz+QYe5b7F7KAp
         IihRN/q2o1vwlnXVBWF/teT/LyJ3Ui02eZeXk1nhBF1JWc0eb/jCE3hlKijWHR5gdwZR
         Vy28l8zYDHDC0yr1ekmTwD6D/3vosFYkRtD0ze7SP/XqyoZGaBEDPoKzd1G/FMtkiW05
         /K8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sXKlYhaZC3+xqa6CmiWEj9jaXhwGnQ802l8XEfpnbzc=;
        b=Ld2czshlh3EH8WUr90xT87X+oMS0a9Wc0409fh/pJIksiKicN7ZGE+olKyKYSJnfdk
         ND06lmeeE9Pvjp4OpiyAqPotSOrKKUG1LFha1lQLN8tsRVpDhniCQmP/XUWl4w1gfWj8
         knf8ue1GBpFiq2X9ikGLqHb+q1B+8doCm28nJR3KZRjJyKXmdPN/Ord6rNiTs1vQmFlb
         dvchPvA5ooWstKnJ3O6ZOcxAEVqKLKAvZbyPSRY3DB15EGrKCs5+DekxL3Hr2hsKtzHR
         LS9SaR8R2ls3aAM1fTwiNyUMWChAFJrSK4+k+BQGHYkE3bM8MtLheb/QUPaCrAY0sPnV
         eobA==
X-Gm-Message-State: AMCzsaVIllvJb/S4XzABIYpsNsteKZuorcVMM12V5ileJy2Dvwk/Q4Vf
        LZTptcOBbXnU1NxmW9hVEXofwA==
X-Google-Smtp-Source: ABhQp+TBanDp4T1qH6LAw59CRfA84hPX9pzx+6GOkJXCFPTkG2fleOZA7GT7nHQ7u0jqoXmyMZoKFQ==
X-Received: by 10.223.147.68 with SMTP id 62mr1377314wro.261.1508416236803;
        Thu, 19 Oct 2017 05:30:36 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id 25sm12820879wrv.8.2017.10.19.05.30.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Oct 2017 05:30:36 -0700 (PDT)
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
Subject: [PATCH 1/6] t0021/rot13-filter: refactor packet reading functions
Date:   Thu, 19 Oct 2017 14:30:25 +0200
Message-Id: <20171019123030.17338-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.0.rc1.106.g7e97f58a41
In-Reply-To: <20171019123030.17338-1-chriscool@tuxfamily.org>
References: <20171019123030.17338-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To make it possible in a following commit to move packet
reading and writing functions into a Packet.pm module,
let's refactor these functions, so they don't handle
printing debug output and exiting.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0021/rot13-filter.pl | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index ad685d92f8..e4495a52f3 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -60,8 +60,7 @@ sub packet_bin_read {
 	my $bytes_read = read STDIN, $buffer, 4;
 	if ( $bytes_read == 0 ) {
 		# EOF - Git stopped talking to us!
-		print $debug "STOP\n";
-		exit();
+		return ( -1, "" );
 	}
 	elsif ( $bytes_read != 4 ) {
 		die "invalid packet: '$buffer'";
@@ -85,7 +84,7 @@ sub packet_bin_read {
 
 sub packet_txt_read {
 	my ( $res, $buf ) = packet_bin_read();
-	unless ( $buf eq '' or $buf =~ s/\n$// ) {
+	unless ( $res == -1 or $buf eq '' or $buf =~ s/\n$// ) {
 		die "A non-binary line MUST be terminated by an LF.";
 	}
 	return ( $res, $buf );
@@ -131,7 +130,12 @@ print $debug "init handshake complete\n";
 $debug->flush();
 
 while (1) {
-	my ( $command ) = packet_txt_read() =~ /^command=(.+)$/;
+	my ( $res, $command ) = packet_txt_read();
+	if ( $res == -1 ) {
+		print $debug "STOP\n";
+		exit();
+	}
+	$command =~ s/^command=//;
 	print $debug "IN: $command";
 	$debug->flush();
 
-- 
2.15.0.rc1.106.g7e97f58a41

