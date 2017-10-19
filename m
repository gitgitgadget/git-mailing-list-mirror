Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 323CE202A2
	for <e@80x24.org>; Thu, 19 Oct 2017 12:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752098AbdJSMaq (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 08:30:46 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:57044 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752084AbdJSMan (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 08:30:43 -0400
Received: by mail-wr0-f196.google.com with SMTP id r79so8151960wrb.13
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 05:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j49XzM1fnpINo6BfBZWLoKaQUqq9lnKJd1G1ctfMXDU=;
        b=nL/DB6WBSteIPR9sw6k9XzBL1l1/m8tLJmeKjL3u0oIvExFsozgUSn/FL3Ad+qUJzj
         EsZHxnqmqKetM/GfyHgEDnDSfI5/26coKu3CrXe02ZkpypvPai8pkQFv+SjMaOiR/he8
         XLH2iaHLZlOqnPLUhW53s3WK+Tz1nYlDRQYK3uR7doNUarKSJzdwOpbGxbKec14Cuebi
         zdR8F/UxLLfcqeoklqqoH6TXaQx57nOyhf4zQUPYbzXRgnkgQSSO2JyT3Rsl9Cow+klz
         deKxOJ6oz0DardrqYqpwDJQvyAEp+Y7DkXgGNnaarH1Njmxm+vbRjg5NjKrcnbH0BMd8
         DcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j49XzM1fnpINo6BfBZWLoKaQUqq9lnKJd1G1ctfMXDU=;
        b=aUNQOO1eCwKG3/Jub5X6ykcKEtT9nO2kpaLA2wlRpTE/ww5xuPwHPIoMuTX/OGlS0l
         EMxr9NhRR7NKRC/Ruqh/twdo+vQQRq97sPSEt7krl4EBoqfExYoHGusGthIOJeE6B6WV
         L2G5tkjMKklrgNY48WrLkzJGu5RHl9e0O1RvgQo8mgWvrstqJvUIpKRqeCOTskGyuvZv
         lX1qDf4B7p0N8xkHu0ililxdAse3N/umd8WOk+DWcX1C2D0CHAlmrC+twO98VGTSikKu
         Yi4zUAU12Y1qh38guwuavvs4aCEE93CSwFb0peRfx5i5BjJaNh18H0q8e4rzpbmR9u3D
         D97w==
X-Gm-Message-State: AMCzsaV/GXKPAsh2VjZkqfcCJdh2ZAgTRKo1ftawzJxY6C8Cu6wgnZXR
        WlCpbOCHp/M63E4s48YnFq3EMQ==
X-Google-Smtp-Source: ABhQp+SNdtzCK4ya/SotWO13+3y9dBRvp1Vscn61QiZMfcupYMTdYb+8pTnBDkL4W78RKQ7MUTbY3g==
X-Received: by 10.223.186.66 with SMTP id t2mr1435141wrg.275.1508416241749;
        Thu, 19 Oct 2017 05:30:41 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id 25sm12820879wrv.8.2017.10.19.05.30.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Oct 2017 05:30:41 -0700 (PDT)
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
Subject: [PATCH 5/6] t0021/rot13-filter: add capability functions
Date:   Thu, 19 Oct 2017 14:30:29 +0200
Message-Id: <20171019123030.17338-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.0.rc1.106.g7e97f58a41
In-Reply-To: <20171019123030.17338-1-chriscool@tuxfamily.org>
References: <20171019123030.17338-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add functions to help read and write capabilities.
These functions will be reused in following patches.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0021/rot13-filter.pl | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index 278fc6f534..ba18b207c6 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -116,20 +116,44 @@ sub packet_initialize {
 	packet_flush();
 }
 
+sub packet_read_capabilities {
+	my @cap;
+	while (1) {
+		my ( $res, $buf ) = packet_bin_read();
+		return ( $res, @cap ) if ( $res != 0 );
+		unless ( $buf =~ s/\n$// ) {
+			die "A non-binary line MUST be terminated by an LF.\n"
+			    . "Received: '$buf'";
+		}
+		die "bad capability buf: '$buf'" unless ( $buf =~ s/capability=// );
+		push @cap, $buf;
+	}
+}
+
+sub packet_read_and_check_capabilities {
+	my @local_caps = @_;
+	my @remote_res_caps = packet_read_capabilities();
+	my $res = shift @remote_res_caps;
+	my %remote_caps = map { $_ => 1 } @remote_res_caps;
+	foreach (@local_caps) {
+        	die "'$_' capability not available" unless (exists($remote_caps{$_}));
+	}
+	return $res;
+}
+
+sub packet_write_capabilities {
+	packet_txt_write( "capability=" . $_ ) foreach (@_);
+	packet_flush();
+}
+
 print $debug "START\n";
 $debug->flush();
 
 packet_initialize("git-filter", 2);
 
-( packet_txt_read() eq ( 0, "capability=clean" ) )  || die "bad capability";
-( packet_txt_read() eq ( 0, "capability=smudge" ) ) || die "bad capability";
-( packet_txt_read() eq ( 0, "capability=delay" ) )  || die "bad capability";
-( packet_bin_read() eq ( 1, "" ) )                  || die "bad capability end";
+packet_read_and_check_capabilities("clean", "smudge", "delay");
+packet_write_capabilities(@capabilities);
 
-foreach (@capabilities) {
-	packet_txt_write( "capability=" . $_ );
-}
-packet_flush();
 print $debug "init handshake complete\n";
 $debug->flush();
 
-- 
2.15.0.rc1.106.g7e97f58a41

