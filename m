Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FA7B202A2
	for <e@80x24.org>; Thu, 19 Oct 2017 12:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752091AbdJSMao (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 08:30:44 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:53893 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbdJSMak (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 08:30:40 -0400
Received: by mail-wr0-f195.google.com with SMTP id u40so2276745wrf.10
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 05:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H2KKJf34GSshcp++pL3LNxm4z9Pc5Wwl4rjMxzeiS1I=;
        b=Hh7MdZw0Gs3DaRzDGSUoKJLqYppjFjw8khgXYld8U37/Mt1X10dJ68Q8LNpsMYqgPS
         zeHUP5hK/PV7Z+hg+yd+aq5JS3ul8tT1dP2cO9y8jKDOukkgHkl0sxoe3Oo3SzGdj4Yw
         6lOh5ysoavm1zc5f+mbm285N080oi2ynsjcWbAXcQ3JjYCZXIGGD8z8XsmonwCAVOIas
         muSrVx5GtIqrk0bYYmvXNGCPQpGRPv804j8qyKofgSUA3vZD7zvOYhGPL2P/UKALMDD/
         4DRDsXb6GAgOJP8F2zMQik3J7pmFP4H72aHHyxcB04k4t5V48uSrGuzww1spEMQY89Gi
         O0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H2KKJf34GSshcp++pL3LNxm4z9Pc5Wwl4rjMxzeiS1I=;
        b=qidcBymiKsvwGiHyHjbWPmTdnrEBy73MYM1I4geKG0MJODTHL5ajX3JIm/NQoXF6O1
         au4IiDUiebd4CdnhctG3THI+Yad7So/cpgVRTt1rI5TiqBhRmPO5f0ThNlelSPNQzDVX
         Sv7iLyVCAvLZNFdkGL8b8VCY0pBH54iujlvFYhmGDjrhyZpwpJl763qoPqRkwrvZmjXW
         t7DJ3Fy5TMUDCdaGXtdV8bZFfKC5/rV1w9wnaAoCl2gaNSwlBQoii0WZ4krr2ejdm88G
         GZpnAMjeBOoTtFnf1UbSEX6iw7BjBbtyW6bkqCl9ybl9CbIP4bTvxGuleEb6W9qz95xL
         JumA==
X-Gm-Message-State: AMCzsaVDSRqKRFHQE/Bq1FanjgWUugz/2NaEekbyU9f+z0Hpdsfe6RRK
        F5DdZ/PVw4JbS2Z8s+r7RA2VDg==
X-Google-Smtp-Source: ABhQp+QER6gdUlfg4wUWBEAqq7xxtwXpSyR943oSDVl40LmpfaB2JBeRRC+hSDJ4UcB+8DkFkawRVw==
X-Received: by 10.223.131.65 with SMTP id 59mr1398863wrd.66.1508416239412;
        Thu, 19 Oct 2017 05:30:39 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id 25sm12820879wrv.8.2017.10.19.05.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Oct 2017 05:30:38 -0700 (PDT)
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
Subject: [PATCH 3/6] t0021/rot13-filter: improve error message
Date:   Thu, 19 Oct 2017 14:30:27 +0200
Message-Id: <20171019123030.17338-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.0.rc1.106.g7e97f58a41
In-Reply-To: <20171019123030.17338-1-chriscool@tuxfamily.org>
References: <20171019123030.17338-1-chriscool@tuxfamily.org>
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
2.15.0.rc1.106.g7e97f58a41

