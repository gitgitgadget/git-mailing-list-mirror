Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B61842036D
	for <e@80x24.org>; Tue, 21 Nov 2017 16:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751438AbdKUQJv (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 11:09:51 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33322 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751327AbdKUQJu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 11:09:50 -0500
Received: by mail-wr0-f194.google.com with SMTP id 4so11802109wrt.0
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 08:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4g+EgS/ZXxPhnfVifDT9xC/uP5AkUkluCpBT8j77mDs=;
        b=dl2TwqZ7TDORIAWpPyCVwj7brkw0o2p6CzmhXcBryiHYcjcytkC7a0VEAan4Yjij5i
         1ypEjuFhrfuTC3TMNrPjyzXGi9uf8LrrnBm1EADyBDxReX57Q+WG/uJXIqxQGppTj+M0
         4F5n1tb5rmVThIKi3Bu0qnopYnIjhhMzMt22kx8gVIJA9Z80/Bd8JFNGetWWeypppOKD
         BDlL6FLZ22mGGRNfxnRm09AeJp7GsGsSahWxD90pfv3RdbQJLY05FQ4e9pHS2xqd60YK
         UV5rLQgL/zCbxdD51GXO93NKFXSDtEh5+AkqW7xeS3Bmzz67VNaRaHmPQ8+9R+8AyBCl
         kgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4g+EgS/ZXxPhnfVifDT9xC/uP5AkUkluCpBT8j77mDs=;
        b=ec+xKWUPCB5iV8SDKcJjkQ8Ngg4c2Zs6q+PtK3QaCRHUzDsHem0xVFSHszEikgdsgV
         BT2S1JuCwO5OKlOyB23T7fnd9M368lpGXFxyxKoKRuFt88ojj+HkCALH6mbscrVs7DoO
         8T2r+tyscID+9sJGg7h7IUKPEf1nNAEtpiwiNax4FgEkdwp4TyHaA3wTA4udoTqhFkoD
         26kCQhtaWXT0qLatLKhNEZsyFdh2KrpTP8bxIO/dSgb8n48kNrPTgAMOhbnIykQXrv3H
         KEimftqh8FfKxBmlcBYlQhE9rn40/OnLGnVsKR77mw9f1eJhmjM8xF5FYxymIzYztBzL
         B5Wg==
X-Gm-Message-State: AJaThX7OEhglhET6UyhvFAbcqSE6AolbcLrL0ZzDGKcLNRxlD7qWsG/l
        qdB53ig/gfRGt4IreksGeLxwjuRE
X-Google-Smtp-Source: AGs4zMY9wTDRyqMj2+ZHo6xwgIoTkPSZtqyERS+Zn2wX5qdoPhQxj9BaOfE1Qn5R7AT9/w2eMgBDCA==
X-Received: by 10.223.165.67 with SMTP id j3mr15851615wrb.181.1511280588951;
        Tue, 21 Nov 2017 08:09:48 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id m11sm11129219wrf.56.2017.11.21.08.09.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Nov 2017 08:09:47 -0800 (PST)
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
Subject: [PATCH 1/2] Git/Packet.pm: rename packet_required_key_val_read()
Date:   Tue, 21 Nov 2017 17:09:38 +0100
Message-Id: <20171121160939.22962-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.0.318.g4f69657937
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function calls itself "required", but it does not die when it
sees an unexpected EOF.
Let's rename it to "packet_key_val_read()".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---

These 2 patches are a late follow up from:

https://public-inbox.org/git/CAP8UFD2vk4jV7jEBx3Axd-dhfcsGSJVFFt+pumdT1j8GD_oM_w@mail.gmail.com/

 perl/Git/Packet.pm      | 5 +++--
 t/t0021/rot13-filter.pl | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/perl/Git/Packet.pm b/perl/Git/Packet.pm
index 255b28c098..82da0cf0db 100644
--- a/perl/Git/Packet.pm
+++ b/perl/Git/Packet.pm
@@ -17,7 +17,7 @@ our @EXPORT = qw(
 			packet_compare_lists
 			packet_bin_read
 			packet_txt_read
-			packet_required_key_val_read
+			packet_key_val_read
 			packet_bin_write
 			packet_txt_write
 			packet_flush
@@ -83,7 +83,8 @@ sub packet_txt_read {
 	return ( $res, $buf );
 }
 
-sub packet_required_key_val_read {
+# Read a text line and check that it is in the form "key=value"
+sub packet_key_val_read {
 	my ( $key ) = @_;
 	my ( $res, $buf ) = packet_txt_read();
 	unless ( $res == -1 or ( $buf =~ s/^$key=// and $buf ne '' ) ) {
diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index 6fd7fa476b..f1678851de 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -70,7 +70,7 @@ print $debug "init handshake complete\n";
 $debug->flush();
 
 while (1) {
-	my ( $res, $command ) = packet_required_key_val_read("command");
+	my ( $res, $command ) = packet_key_val_read("command");
 	if ( $res == -1 ) {
 		print $debug "STOP\n";
 		exit();
@@ -106,7 +106,7 @@ while (1) {
 		packet_txt_write("status=success");
 		packet_flush();
 	} else {
-		my ( $res, $pathname ) = packet_required_key_val_read("pathname");
+		my ( $res, $pathname ) = packet_key_val_read("pathname");
 		if ( $res == -1 ) {
 			die "unexpected EOF while expecting pathname";
 		}
-- 
2.15.0.318.g4f69657937

