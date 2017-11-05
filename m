Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F5AD20281
	for <e@80x24.org>; Sun,  5 Nov 2017 21:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751206AbdKEVix (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 16:38:53 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46001 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751139AbdKEVit (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 16:38:49 -0500
Received: by mail-wr0-f196.google.com with SMTP id y9so6871562wrb.2
        for <git@vger.kernel.org>; Sun, 05 Nov 2017 13:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=km0S0W4K1H1fNpKu2fF30kidxuhb1XVfCEnMY1zAvvw=;
        b=Rcljf1Y0Ix2Z1PgvkjuxSrJukaILFpp6Jp/ovO6qSxN63OJhEyy+z/5lW5w6UX7Pzs
         SQp9QBeiMr56A8WdhyKFVzVL0HK9y36tLw6RudurTAt1KFQqcRKTpkNzY2p7XRc8OGSb
         V6Np1d3scVYY/noinn+Ub3U9YwoMNFwSX0NPbQl1uz5YjN1ElbtI4dtnc+JkXw0bQAXg
         uNIG4kgOj0nYgpmzDR5oVLONtxdv15yGpt2u31cmQOo5o8Q2GbNsAb8e98Q9aou4uPPc
         iiGxc6yWErnkh/X1w7Pb6wY3eus0o9Sww+p/nBEQgJmYEcuoDktxQ1x01rEsgAp8zZD4
         kerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=km0S0W4K1H1fNpKu2fF30kidxuhb1XVfCEnMY1zAvvw=;
        b=aCaGe0ICLVSgcAlX1fHWY9vgPBFqBx1Gc4c4dhx3u8elh5Ft9RnSR8DW03RDqtIXRe
         rPqZN9e4g3NEluNxKMhLweP4ATalPpVmabzKA/8JntgYP9Y0kMJJcMJSSDRmb8dfJByf
         ck2GX/JR/HWwgfUqOns/hDegQ6RKqzh0ToHv8kIjrmHuWQ1DkUVa2IRvaeMuGk0vmM+4
         bKIIzPMfo9KhopY3hI7nupKGb51c6E5YkmLzafARSItJNYM5SYbPZ+VydvkOaX9q8X4x
         Xw5jHZ1Qwhc9piqQmOFCIPcUYSI/qUlX2CPpB0+PYXQ10qxx/ZCG8L+4CFlxxnJ2xI1h
         tt5w==
X-Gm-Message-State: AMCzsaWAtRw0COoI04cLcav91Z3lBrn3lE/LHo/Dv8NEXonjvIGYMBB9
        sHr4/+9tRYgYiANEcpY9r7NjK8tF
X-Google-Smtp-Source: ABhQp+T9tVJZZQa0XcgtnSo6+9L0gU9y9QYAkelDlLaSb+KktvsaCxVpInwgtJ72oQDg4E2/HiezEA==
X-Received: by 10.223.161.210 with SMTP id v18mr11488642wrv.76.1509917928355;
        Sun, 05 Nov 2017 13:38:48 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id h2sm5147323wrf.47.2017.11.05.13.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Nov 2017 13:38:47 -0800 (PST)
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
Subject: [PATCH v2 5/8] t0021/rot13-filter: add packet_initialize()
Date:   Sun,  5 Nov 2017 22:38:33 +0100
Message-Id: <20171105213836.11717-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.0.8.g15d566f848
In-Reply-To: <20171105213836.11717-1-chriscool@tuxfamily.org>
References: <20171105213836.11717-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's refactor the code to initialize communication into its own
packet_initialize() function, so that we can reuse this
functionality in following patches.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0021/rot13-filter.pl | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index f31ff595fe..2f74ab2e45 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -127,19 +127,25 @@ sub packet_flush {
 	STDOUT->flush();
 }
 
+sub packet_initialize {
+	my ($name, $version) = @_;
+
+	packet_compare_lists([0, $name . "-client"], packet_txt_read()) ||
+		die "bad initialize";
+	packet_compare_lists([0, "version=" . $version], packet_txt_read()) ||
+		die "bad version";
+	packet_compare_lists([1, ""], packet_bin_read()) ||
+		die "bad version end";
+
+	packet_txt_write( $name . "-server" );
+	packet_txt_write( "version=" . $version );
+	packet_flush();
+}
+
 print $debug "START\n";
 $debug->flush();
 
-packet_compare_lists([0, "git-filter-client"], packet_txt_read()) ||
-	die "bad initialize";
-packet_compare_lists([0, "version=2"], packet_txt_read()) ||
-	die "bad version";
-packet_compare_lists([1, ""], packet_bin_read()) ||
-	die "bad version end";
-
-packet_txt_write("git-filter-server");
-packet_txt_write("version=2");
-packet_flush();
+packet_initialize("git-filter", 2);
 
 packet_compare_lists([0, "capability=clean"], packet_txt_read()) ||
 	die "bad capability";
-- 
2.15.0.7.ga9ff306ed9.dirty

