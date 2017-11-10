Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFE281F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 13:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753025AbdKJNXA (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 08:23:00 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:53051 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752985AbdKJNW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 08:22:59 -0500
Received: by mail-wr0-f195.google.com with SMTP id j23so8588024wra.9
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 05:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vEFVr/IW0QUbyGOA6URcpG6deXT8La9hxWbiC2oB5U4=;
        b=gtYWXGnaXYhg77brHwrujL9hl+GdhS4Og+UWBIGQsONJjb0WaPkEGnG4AbBDghobp4
         rOjjXt3Tv5SWpd7uC1r6O0jCjr+XCnU2u98Myu/7PAP/nDwzGSvKOfTKJB1Dg3OY4QZY
         dh2ej4CtzlvlDVtZKeEQ/dzc3pKDL37ssSc421Y2DSz1tqT2YLemRJp/HVK5terKWiHn
         ZnvwM5R7ZcoEporYp4yyIyupwSpveNYu/e/vymnNAsXgSiqmfyZHFRBJxkol1WgxOVLA
         jefuF7WmehMjxieMyZ49tD+/fqT0c2KQOFBdkATJa5AopkK61ZN/DGlnM/mScXNZfhdw
         QA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vEFVr/IW0QUbyGOA6URcpG6deXT8La9hxWbiC2oB5U4=;
        b=X3nSRWEN6xRAc3ES/GhUwnmWUj8pC/sfBY7pqCBYtHwwKpTHyCdJ0ygy7nSdFg1P2P
         GXNHHaJICfCzPRVBIauH/f+xSAqH5TOcGmhGnZkSupiNJb727kwpChpTgGoj0j571RJE
         jc6+0YCQwcL27g4brYd/XS3uNmpAIOwuDNgXkiqSQ3TCoQjHs3ErRTKNILqWCvquxBzZ
         z5IR8VKKPKlb3I5afnXFvmJKhAb192Jeq2In4rtBpcI0sG2+4MTj3YMPJcdWO7DaWw6E
         jAmMFwaSUciz8YqC6q5+2VNuSkXE08h1Lf7nkW3q0SYASY9pBRxOQrsnCU7SFDptFXDL
         WfSg==
X-Gm-Message-State: AJaThX65S9jLoIOhnnSm5htldpY4Pk0x1Mf/mZj0Fjkbr1DOXatETsJL
        dKqV+WT0tHaSHqzOAPEn5D2atnyM
X-Google-Smtp-Source: AGs4zMb0zDiBSTfAipndSKGUU73zOfx/20BelG08TuX0I0fS0QoyOk3tak1EtJQQI5Hd4V4BS3Hmqw==
X-Received: by 10.223.184.125 with SMTP id u58mr321225wrf.33.1510320177723;
        Fri, 10 Nov 2017 05:22:57 -0800 (PST)
Received: from christian-Latitude-E6330.register.onboard.eurostar.com ([82.113.183.179])
        by smtp.gmail.com with ESMTPSA id 19sm2232731wmn.15.2017.11.10.05.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Nov 2017 05:22:56 -0800 (PST)
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
Subject: [PATCH v3 5/8] t0021/rot13-filter: add packet_initialize()
Date:   Fri, 10 Nov 2017 14:21:57 +0100
Message-Id: <20171110132200.7871-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.0.132.g7ad97d78be
In-Reply-To: <20171110132200.7871-1-chriscool@tuxfamily.org>
References: <20171110132200.7871-1-chriscool@tuxfamily.org>
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
index 55b6e17034..9e18be66b6 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -128,19 +128,25 @@ sub packet_flush {
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
2.15.0.132.g7ad97d78be

