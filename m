Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D9E0201C8
	for <e@80x24.org>; Fri, 10 Nov 2017 13:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752972AbdKJNWt (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 08:22:49 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55273 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751661AbdKJNWs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 08:22:48 -0500
Received: by mail-wm0-f67.google.com with SMTP id r68so2726991wmr.3
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 05:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tfP0WZ7mORrmrjdXeMrGPMZNSlxBNg6e5P1KFkH0jdc=;
        b=lXfmbSQ1Ltp01tFyIQihdlJXkiZTKmcm5wWgLFeANET/xjGJqu5jtB7Fp2wlq4uE9I
         y/20F8fYFCMbAMrPB2i2DJoHk6MIt+3JhFfkyeDKLCIFgqSTmW82qcEEQ+wLr2Ykg3kV
         dc7SIEEru1qXnjESNAjCxlgGHrhh+Z5g12THQTAjvwAa0JYk3HRZMud2WrdPDOZ+rynX
         1c2PDYsZULbLn+OcohHi0B+9SfrBQeqikq2MXan0C56WafvqZRE+lFjiO2V8QwT7nCVs
         KswgbzaQaH1MM1CjvCz7iw7LQV2qv135f0cysRX0A0knxO8Qu3TAo3b1drXMXRHme5Pj
         90+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tfP0WZ7mORrmrjdXeMrGPMZNSlxBNg6e5P1KFkH0jdc=;
        b=S05aWdxEbkhNFVStbnwjBOz61gUo9NG5IPxuhfEMk8Qm1y1VUwJaIpWg4tBfl/BzTV
         OemfsWzMtoBmP0YZeH3SVLjX9XCNWAy+bNcUFdC+qD407hNqlLL3+WXZ0MoB39ZyQ/dS
         HVSaVQiFnMKCn3sHjTyt9b18otugG9nMahRkxJ0Ptk4mgVT5PA+ZYsApnNTAGwLpQPg/
         nH2qQ9OVrIyRorShEMXG1Qv6pB0P5dFubuoD+ebsKtH+8IDDk4vfretC/CSIhyjPh4WP
         bbnfFke9z8JsIecVEsJ7DXnc9oYXElx1hHDjf1jaH8JEKIwIC+AcLvtRxQCodLvebErK
         x1xA==
X-Gm-Message-State: AJaThX619hU+wOBPWM/KztL/3wcT4fUnUbKGKZX940H7FGE+UK+WET8Z
        7k81mmYlxpxg5f76CEHfSi5ozXTQ
X-Google-Smtp-Source: AGs4zMZoUpKaxJN/gsxIpyLlnQc4NN+gljNljl1rZz0+R7PaJ1KrCHa8rCfNL6dMHshim+nI669kDQ==
X-Received: by 10.28.131.200 with SMTP id f191mr236323wmd.39.1510320167235;
        Fri, 10 Nov 2017 05:22:47 -0800 (PST)
Received: from christian-Latitude-E6330.register.onboard.eurostar.com ([82.113.183.179])
        by smtp.gmail.com with ESMTPSA id 19sm2232731wmn.15.2017.11.10.05.22.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Nov 2017 05:22:46 -0800 (PST)
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
Subject: [PATCH v3 4/8] t0021/rot13-filter: improve error message
Date:   Fri, 10 Nov 2017 14:21:56 +0100
Message-Id: <20171110132200.7871-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.0.132.g7ad97d78be
In-Reply-To: <20171110132200.7871-1-chriscool@tuxfamily.org>
References: <20171110132200.7871-1-chriscool@tuxfamily.org>
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
index 8bba97af1a..55b6e17034 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -98,7 +98,8 @@ sub packet_txt_read {
 	if ( $res == -1 or $buf eq '' or $buf =~ s/\n$// ) {
 		return ( $res, $buf );
 	}
-	die "A non-binary line MUST be terminated by an LF.";
+	die "A non-binary line MUST be terminated by an LF.\n"
+	    . "Received: '$buf'";
 }
 
 # Read a text line and check that it is in the form "key=value"
-- 
2.15.0.132.g7ad97d78be

