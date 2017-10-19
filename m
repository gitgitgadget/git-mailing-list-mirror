Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 088F4202A2
	for <e@80x24.org>; Thu, 19 Oct 2017 12:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752112AbdJSMaz (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 08:30:55 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:51656 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751930AbdJSMan (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 08:30:43 -0400
Received: by mail-wr0-f193.google.com with SMTP id j14so8154902wre.8
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 05:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iHXykKTc904Jee+NPCfRC+e1OhjkHHfzx7WDiV5oHwI=;
        b=gvMI1OGOmLIvtVXRIBkbRwc9a931KUIRmhtfdeDQ7FstCRCl0nKA93kLnVKpALgfiD
         ktG17f1wEKyF7jJaurznqiOnkYYGZkExFnjALz/WWWa3caWm1w5ktRpNL5Z6F1WLewIk
         jMIAtrH9efQOjvJpse8pa//JWH6vk2Z12xp2KM+XPgHhekdVzJSiCqq8H0MZbhTONbqk
         G8zXxQxpsoRQ4GWw2SoQFmBGANNXOq6XMDqrxPdoFFGYPqOPSclIcoKEuCNBj9VlivmW
         4hfZDMBlDqe0pkIwa9Jf+1s+ZxTUce0Mm8EZxmZaa/lwMj7sGdcdRFhQqapaQCeFU0Z5
         D69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iHXykKTc904Jee+NPCfRC+e1OhjkHHfzx7WDiV5oHwI=;
        b=eA63zArfnhtbJkc1p71vmI5RHBHel2wOuW+TTvvdKkd53UR2DFSYR6EDINyUSNpUfU
         KxIUA1BHfB+dZ9sitqLfQ4mKQ00Wd9mNo34LFWThnFYVhdwa5tXDAmB5HRg9PLsZdFBx
         cT/busEceDMQUWB4giO7bjalRmcyYGlZ8hUTpXkzeyhEfkoG0F31pOIjbH7D+5PFfnO6
         LqYSBpPH9m8tkIcxyUBz8tQWYPol3NTo+D0Et/uCV0eVHzOIeKYftajgU/R1fMynecsp
         yyED4X6PNN25+4hPBASJ4qfEBhCAOPDtUECEK6L7WVwgh35v2+VP99LYsOEDWLvX8do5
         fJfA==
X-Gm-Message-State: AMCzsaWmt7AjqfWlAeAxnslaeY9CP2RrpJzdvX6L/OwScAtn4e4UgDQo
        +y3iAOcZo/O6tNxfUWWeiK20Bw==
X-Google-Smtp-Source: ABhQp+SB0JalE6G5cG59DqrhSzUP0wqEJpqhUZZoZYaKogcppzFqbwpBGUH8jdMwIFgXjyqSeoinQQ==
X-Received: by 10.223.183.1 with SMTP id l1mr1383972wre.139.1508416240625;
        Thu, 19 Oct 2017 05:30:40 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id 25sm12820879wrv.8.2017.10.19.05.30.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Oct 2017 05:30:40 -0700 (PDT)
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
Subject: [PATCH 4/6] t0021/rot13-filter: add packet_initialize()
Date:   Thu, 19 Oct 2017 14:30:28 +0200
Message-Id: <20171019123030.17338-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.0.rc1.106.g7e97f58a41
In-Reply-To: <20171019123030.17338-1-chriscool@tuxfamily.org>
References: <20171019123030.17338-1-chriscool@tuxfamily.org>
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
2.15.0.rc1.106.g7e97f58a41

