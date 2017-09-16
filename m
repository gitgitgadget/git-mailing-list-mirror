Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A3E320A25
	for <e@80x24.org>; Sat, 16 Sep 2017 08:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751288AbdIPIH6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:07:58 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33469 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbdIPIHu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:07:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id 187so4514310wmn.0
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e/KP0SD+tZsGz9ghIJty8xfa+0fQBe4ThFDm3//GArU=;
        b=AjOKipoo5KTDQivqMRPPstuE0pm5KI97uz1qKhOxfe5X2kggiLN8ZYWih2szfxisUt
         ZzVtif68547QpJO/hNsbPsXvfzDa0PfWppKhYRfzVmh4UdPS2rV9LDsJAt02JayCKJAW
         p2UeGceDI2B6eK47IFbg4qgEg9qxXdyHBdTFpoW7nP6JkD+LePRwFOmIRMkaeZJ3n6UB
         3WGXbKdKeAXNQs5vRYJ9VnpNtwZZhcYE7sWWs8Ak0qy0K0vuMvLQ6MJ7bhEozp0ne4AU
         yZxqRzQQ+cuSxpelQ4kqUOFtuOnQp52LpbDtAyf377/+i93u1wRdoTVuIh0AoHj+rp29
         XrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e/KP0SD+tZsGz9ghIJty8xfa+0fQBe4ThFDm3//GArU=;
        b=knXLOA0f8AQZxCjRwYIISaDyWTRMO+B111/TbKamESJUKeLNt1Bsuvsaj/enkCwvDZ
         yUfKV4MwI3eeoOHqvWiHIUlir6msKyMNIvhitu40emhJuD71XDjdpi8CdqdBOFVry3mb
         RyYGKLNmQ6fegtUgaC87pzldzXBhE0AKdzn2W+EEiODLXAKtNbvWE4Xa9gLBllNyPsab
         hUMPwNeZI+BA7ABdDDnh/eVcZpiJPlLqzmfklI02qv0ejwa3eA5Q2BZcROlBCxYCAmNN
         zfcKERjro/cK6a5FvftVm82akfbbRYaPckzRpZX0SXF4o2bL+RchZE0JcgfqnQP4RwYh
         MI7w==
X-Gm-Message-State: AHPjjUhfU2hG+IlEB0lE7Z6oIcQwmcex5JI+Mw7KexvUv6e0Aacv1WXL
        ccj/+Sj67N2KBsGkY9JWK5yr5w==
X-Google-Smtp-Source: AOwi7QAfZsc4iMz6HbN4m/lV+sslJT3URCgf+A2TKqyAgL+l918kyhbyYBA9UBCKI06eLMazfbXZbA==
X-Received: by 10.28.211.145 with SMTP id k139mr4946651wmg.85.1505549269260;
        Sat, 16 Sep 2017 01:07:49 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:07:48 -0700 (PDT)
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
Subject: [PATCH v6 05/40] t0021/rot13-filter: add packet_initialize()
Date:   Sat, 16 Sep 2017 10:06:56 +0200
Message-Id: <20170916080731.13925-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's refactor the code to initialize communication into its own
packet_initialize() function, so that we can reuse this
functionality in following patches.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0021/rot13-filter.pl | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index 3b3da8a03d..278fc6f534 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -104,16 +104,22 @@ sub packet_flush {
 	STDOUT->flush();
 }
 
+sub packet_initialize {
+	my ($name, $version) = @_;
+
+	( packet_txt_read() eq ( 0, $name . "-client" ) )       || die "bad initialize";
+	( packet_txt_read() eq ( 0, "version=" . $version ) )   || die "bad version";
+	( packet_bin_read() eq ( 1, "" ) )                      || die "bad version end";
+
+	packet_txt_write( $name . "-server" );
+	packet_txt_write( "version=" . $version );
+	packet_flush();
+}
+
 print $debug "START\n";
 $debug->flush();
 
-( packet_txt_read() eq ( 0, "git-filter-client" ) ) || die "bad initialize";
-( packet_txt_read() eq ( 0, "version=2" ) )         || die "bad version";
-( packet_bin_read() eq ( 1, "" ) )                  || die "bad version end";
-
-packet_txt_write("git-filter-server");
-packet_txt_write("version=2");
-packet_flush();
+packet_initialize("git-filter", 2);
 
 ( packet_txt_read() eq ( 0, "capability=clean" ) )  || die "bad capability";
 ( packet_txt_read() eq ( 0, "capability=smudge" ) ) || die "bad capability";
-- 
2.14.1.576.g3f707d88cd

