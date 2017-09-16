Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA0AC20A21
	for <e@80x24.org>; Sat, 16 Sep 2017 08:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbdIPIKa (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:10:30 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34046 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbdIPIHq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:07:46 -0400
Received: by mail-wr0-f194.google.com with SMTP id k20so2369952wre.1
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rbe0lrds+41bOQDnFgqM0k5RHLt+Ti/fXB25hHBoIH4=;
        b=Qf+hDoM354S1UNvmW8sz9yXC2UVAidwrcUWZV7w9fad6X4XZPCZZXla5LTl8phMQ9q
         i/XY+ydeyamVtpzUbiXdfZ5oQOxZebf38p/iyCTAq6JRBpLRcP+ec/PwrmZqbKwg24J9
         VAa3awQo7MLSMMVSDJvg0BpQ6BORIdXG6WKuoIsKVzSE6kGkS0ycva5yi/kOb3Ef4wNr
         d45ysIRreNyoC6IuKoUkrFDeEB/CQA4bNrZAQDV2bZDS9gRkMYiM/N7wO/2G2w4HM5wj
         eRcjf3qtScwhB2QkRQlUFcugfFW1b4B48w43N8PjkBKzalt7NvFcWVTQCvvgFdJnZ6JP
         46vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rbe0lrds+41bOQDnFgqM0k5RHLt+Ti/fXB25hHBoIH4=;
        b=BpQfLzAulwUaNcv57FaZiGRrWiYh7YnfYc3dPoNJp3eMOgqFy4H/NALmmSa01ZK9nO
         eoDUe+bHM1awIw7h/ePfXIbhIlvkNbF09LwdYKnYhbwzqAZG6id8fvfiYANHZ8M2OWUj
         fFIMl0tcU1HR6J1rGTZIjK5VGws1kPkg5I8U7U3BAmS1+4nhiNZXdkROLuJVwiYvx5sL
         gBpJiSp/fxeL9QQ2fWPTBMBMkmWEAiCZlNcr8/LkPMvgYeEP9RwIGYlyCqTuegTUmJla
         6gFuO5rcHWS32H0wX6YD7/WcBE2FXhqrLAtcPjRgx0kqulUgoSeUFvhqfDD5Bso8F+/A
         O8/w==
X-Gm-Message-State: AHPjjUhVJ74L2OAcqINo02zlCzyaUfDQ13ssoCHdKlOnaArHoDZjFDpE
        cprElhGT0HsIH1cH
X-Google-Smtp-Source: ADKCNb55Kt6e9RuYV8MjM39TeoNZm0qZpaxpkYd7SbOEdEN9ZLs3dz6m3yuKba01Rq7Aasslzjy/zw==
X-Received: by 10.223.159.6 with SMTP id l6mr25606381wrf.156.1505549265245;
        Sat, 16 Sep 2017 01:07:45 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.07.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:07:44 -0700 (PDT)
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
Subject: [PATCH v6 02/40] t0021/rot13-filter: refactor packet reading functions
Date:   Sat, 16 Sep 2017 10:06:53 +0200
Message-Id: <20170916080731.13925-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
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
2.14.1.576.g3f707d88cd

