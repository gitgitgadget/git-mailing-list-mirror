Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6977620A21
	for <e@80x24.org>; Sat, 16 Sep 2017 08:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751275AbdIPIH4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:07:56 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35865 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbdIPIHw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:07:52 -0400
Received: by mail-wm0-f67.google.com with SMTP id r136so4498378wmf.3
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fgliMGHHR0PqkXuNnsHfQf4/wRv0fynly1q1391k/TI=;
        b=TlSCcATyMujizkKz4gTv/ybCocxtrRRYA1F/OnkVGbkPTSCbP6hVlZ+T5ZbZI8+Za8
         r0TbBdPo7zrl+1vDhUryYSvIoaSu0YYL5Rs0knyrvgNjKPhqdy0Lk9KiMuEgawuqEr/B
         uZ3HyvGe8fm20wXlkF2iiOxdHQwAqMf2vCmqUSVAqlkov8dQ0UMAHhgk0v4GFweYfGLl
         B4atfnR3Ufg59xynLihj2vPTXRCUuLz8MSkaYxatleRrSSTdv1J5zBV3YeiyZC/01Mfv
         MLqiR1cSVMRLJDEerYyVYlyXHwP67DQU11quVHOVa+xNCf3LdNiLmBxbd9juR8+nNhpV
         YmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fgliMGHHR0PqkXuNnsHfQf4/wRv0fynly1q1391k/TI=;
        b=iw2JcIRstIzNaVQq84rY0dIuf3LZ7RufCrPJ/xzUwTEwFaFuXDsVvE9gzRuGESr4ZE
         8BXF7vi4hT7tuufnCvEhccHxgUaJ1ZYoHWl2FJsw8v5Mp/4FQi3LQy2mH5cjBzGxf3WP
         Ojt2nvgPyI50PbBRmN7yvC2Aj6iYIBRlwpMK6GFeAYp4tGQ4jkaV6UkIzdYW9QshnFp5
         7JoxJBAkv2+rLKzC6aba6uq+q/AUpxM/vhZ9vk0BSkv+DLs8APxk0q67BZbgghZZhb0c
         OEZ9inl+xEzWxt+/7Bup4itQLZd+Vz72gkVWlAZAV+EutdROQPh36DyFt01HedWxiXXG
         YeTA==
X-Gm-Message-State: AHPjjUgSddZHdQD0SxsAN0Nx/UOuqKu/WTqtmfH29VdBfSO9HIl98v2n
        eZdgsxuudKJlqIoF0x646uLSEA==
X-Google-Smtp-Source: AOwi7QCzeDgIl1HvDvU2cVRZBUSxZTdE5s1Hmf/AavgUKOSe1CCXJlP9h6Bw/mV6THroZoP7uORSHA==
X-Received: by 10.28.107.17 with SMTP id g17mr4925075wmc.58.1505549270577;
        Sat, 16 Sep 2017 01:07:50 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:07:49 -0700 (PDT)
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
Subject: [PATCH v6 06/40] t0021/rot13-filter: add capability functions
Date:   Sat, 16 Sep 2017 10:06:57 +0200
Message-Id: <20170916080731.13925-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
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
2.14.1.576.g3f707d88cd

