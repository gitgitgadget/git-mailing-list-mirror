Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00B6C20A26
	for <e@80x24.org>; Sat, 16 Sep 2017 08:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751260AbdIPIHv (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:07:51 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37585 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbdIPIHt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:07:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id f4so4505050wmh.4
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R9Z69DoyUDK9o6oXA9OvHk93UoEvPVFR4ZMhkiQ9X00=;
        b=S/KprAhKlAWTdBJERKGsLZymAxJRMoXK2PODqAlCGl570SFXONE9jgXaSTi/jJ/BLi
         ZDWu8ZGLqKaBc91U/RpSiaID0Jg6/GoJTr7UbH8ClwjgPeNaBEpuvKSTlhjYJ2EmORr7
         1a50n9+tir9fJyvDjxHJ2sGFPWq1XoJmx2mt6V796I96p2OadRKyX4wEP4cU3vDiifwL
         s8lEb+7frTTzvQqxVXe9g2F8sm4mBZN6dkihnmJQRrUFVYr/71FdD0lHQPVUzxAzYeha
         dlcIZi5hAtI275cFJJSrlAnZIIYiOrrUaoarfLrvwgrpxSKe90GUDC+9yAQVRZ0ATd4x
         TexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R9Z69DoyUDK9o6oXA9OvHk93UoEvPVFR4ZMhkiQ9X00=;
        b=SRItzQBjW1p0mqsmPl7wosv+VaI44WQpAtI4vOWDj+GBMRhLEoXpZVPl4enX9XTue0
         n1apsW+rNZsxSGwaYYvQBBNlVA7j40Sq6LiWBVht8+1Y4ehpDz6wf+NTDbko9MB9sqpt
         BSAxbDicGcxNaOtUKLosCfu6TtPtXUICeGVhSLrpwBkgJ6Qr5yGePFrHIdYidsAHW/bB
         LhnlxjIvKjlf1Mg0yK5BWMwqGsTwAHzgBBMESf86712ntdftEI93r8HnIjHa3F9Mx/RW
         jVd9l5fr5/Bdo/jrGrcLo7YN1B5CvamboLAk9/7iOzzd10AnRGKmZUo3orqwVD4kUWBB
         HIbg==
X-Gm-Message-State: AHPjjUhkzOpOre1D2bVMRoLAF+Rh4+qAY05hkRARZkMzaUDAPD65d4xY
        JA2/kSYrejikkQrN7I80LLNTkg==
X-Google-Smtp-Source: AOwi7QAmHmR6dyb07QH4MDPxUboVvd1jQK8lJQlOY7lbbhS0aW/vIrt7xQi4iNO5od5/729srgYeWA==
X-Received: by 10.28.236.25 with SMTP id k25mr4127644wmh.146.1505549267923;
        Sat, 16 Sep 2017 01:07:47 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.07.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:07:47 -0700 (PDT)
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
Subject: [PATCH v6 04/40] t0021/rot13-filter: improve error message
Date:   Sat, 16 Sep 2017 10:06:55 +0200
Message-Id: <20170916080731.13925-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If there is no new line at the end of something it receives,
the packet_txt_read() function die()s, but it's difficult to
debug without much context.

Let's give a bit more information when that happens.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0021/rot13-filter.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index 82882392ae..3b3da8a03d 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -82,7 +82,8 @@ sub packet_bin_read {
 sub packet_txt_read {
 	my ( $res, $buf ) = packet_bin_read();
 	unless ( $res == -1 or $buf eq '' or $buf =~ s/\n$// ) {
-		die "A non-binary line MUST be terminated by an LF.";
+		die "A non-binary line MUST be terminated by an LF.\n"
+		    . "Received: '$buf'";
 	}
 	return ( $res, $buf );
 }
-- 
2.14.1.576.g3f707d88cd

