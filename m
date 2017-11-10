Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6FD820239
	for <e@80x24.org>; Fri, 10 Nov 2017 13:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753008AbdKJNXR (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 08:23:17 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:47887 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752831AbdKJNXR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 08:23:17 -0500
Received: by mail-wr0-f195.google.com with SMTP id k61so8597519wrc.4
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 05:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HDiuU07BnGUsQzKHmrgQytJt0e5SNEhqugkLK7jXJMU=;
        b=AHujPGk/oyMnzVF/S0LEG2kZNB6k6kCllQe7Rrs0i0vftT2x+6w5D3qSi9tv/suqN/
         CvG/bMZTirfqRGxELKNuxdvkRVcJltZqv3AOo+JJo+5v4OrWeS451EQuKIu7qruwGrhR
         fkJGsLv/62ESf6+4iewH38uhAgSqBTe4zQKYugsm3RCbLl25YoG6couPcjV9PfVOUleU
         xulwhIEyBhp2fHAXKOZHFRYHxrMhrVUYWXVJEjzn+xVQofeuVM4GFfyyXyrEpNypWV8B
         FBpIolsXZjoBNMQ1YxxlDMQ5YZYXkUFsIxEA3ovvVFaL5CzD+33Vj1WoFXtzyM2MKGOf
         RyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HDiuU07BnGUsQzKHmrgQytJt0e5SNEhqugkLK7jXJMU=;
        b=TLl6BrhRcviG+WpEW1qukMH5XYhFiSGIQAIhuULxJ+8Hulp0DMB7bUTiPat62l7FWp
         gOZyPEFo9LiSs0pRGmstHeeViEkhFI0E4zC5yC9skLb0Jla4WL/2JTJ5Vsq+tCBe7Yth
         ais2nGCVIfPZH0OYTDvEkcvM7Rfdj9DYcpQDIB8S/MPu2lb3KysZ444F3cF0Oz57m00u
         1wI72Ul+KXNZH7XRq53VU2LxlAW9obTNBAL+f5SIUsO3oJyQjjcanTmQGmBnaahDq7Uu
         zarqtnqYpPYlGtduuoXerrClqdNdifVfgL78C/bATqa1d0bNnbmCM/TCl+g7tr21Nib4
         0NKA==
X-Gm-Message-State: AJaThX73uQIMCqWi2xlq8HlJUL4CFSSekaLsQE6FT4SGJ92kBgXuGLXi
        uFFpsTE88L6+Lycry0Fn0xWVZLyN
X-Google-Smtp-Source: AGs4zMYteo5jMTjGC+L/PeU6CinUbiIODZf7eT0Sbs7ssFQFSNciUUuxtgrgPXVhPEdaeJFpjNTv8w==
X-Received: by 10.223.168.23 with SMTP id l23mr310078wrc.15.1510320195711;
        Fri, 10 Nov 2017 05:23:15 -0800 (PST)
Received: from christian-Latitude-E6330.register.onboard.eurostar.com ([82.113.183.179])
        by smtp.gmail.com with ESMTPSA id 19sm2232731wmn.15.2017.11.10.05.23.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Nov 2017 05:23:15 -0800 (PST)
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
Subject: [PATCH v3 6/8] t0021/rot13-filter: refactor checking final lf
Date:   Fri, 10 Nov 2017 14:21:58 +0100
Message-Id: <20171110132200.7871-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.0.132.g7ad97d78be
In-Reply-To: <20171110132200.7871-1-chriscool@tuxfamily.org>
References: <20171110132200.7871-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As checking for a lf character at the end of a buffer
will be useful in another function, let's refactor this
functionality into a small remove_final_lf_or_die()
helper function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0021/rot13-filter.pl | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index 9e18be66b6..8f255b6131 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -93,15 +93,23 @@ sub packet_bin_read {
 	}
 }
 
-sub packet_txt_read {
-	my ( $res, $buf ) = packet_bin_read();
-	if ( $res == -1 or $buf eq '' or $buf =~ s/\n$// ) {
-		return ( $res, $buf );
+sub remove_final_lf_or_die {
+	my $buf = shift;
+	if ( $buf =~ s/\n$// ) {
+		return $buf;
 	}
 	die "A non-binary line MUST be terminated by an LF.\n"
 	    . "Received: '$buf'";
 }
 
+sub packet_txt_read {
+	my ( $res, $buf ) = packet_bin_read();
+	if ( $res != -1 and $buf ne '' ) {
+		$buf = remove_final_lf_or_die($buf);
+	}
+	return ( $res, $buf );
+}
+
 # Read a text line and check that it is in the form "key=value"
 sub packet_key_val_read {
 	my ( $key ) = @_;
-- 
2.15.0.132.g7ad97d78be

