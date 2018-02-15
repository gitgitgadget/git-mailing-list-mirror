Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF8D31F404
	for <e@80x24.org>; Thu, 15 Feb 2018 00:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032233AbeBOASY (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 19:18:24 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:38660 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032127AbeBOASX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 19:18:23 -0500
Received: by mail-pg0-f48.google.com with SMTP id l24so2902159pgc.5
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 16:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=o3giA8wSbkz1nScdcCLlCmPLqiSZ0JMnY1WMQBiTkwU=;
        b=rkLnEtyINfVT/yqaaecE5NV2ENLiKHNiycIYmAoNhn9+tygNxPxW0hXtNeoFWV5yA4
         7Dd7TiLFEbmdVY3GHSugB9aI4FroWYf+BX7hoGhqud4RshMTCAM6qA3KuXX+IbrxD+UD
         UIFKHRseA9zMee1hH51ZcHQHdF9roveXSl2aFCSlBJ8UaP5aLV8oiAz5haHDvp7JmbLo
         53jFo+8YUJMtZNtoYeA/WU8BgG8HbDQIzS+8S6X05K3h06Haj4w4VjO2Zw84gsJJbtEm
         RkF9fhC8Q/VnB2PCcLyV80c7cxY0uwlX80FLvGMwmXYvMZf8NaYrnhfJrxiTVcBjtroi
         8/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o3giA8wSbkz1nScdcCLlCmPLqiSZ0JMnY1WMQBiTkwU=;
        b=VkxTXab+YGi5PIITWzz8flmIVo9p5jbQqVypxpjmjhuByDu8ZXa4YtIZPJsCa9t8p7
         9ddoVQtzUHT3wr843f00ygUb/2bgPiKrK5GU6BADffFiAnr9qrpmgHjrHdmjmYTK+vRy
         A5lSE/n/3REDlPqdGlOLcW1gOOLSNkhdNBliCGd49eMMzBw9arr54MY616+28H60cgBX
         Bb6LW5+VoLPXdA3fTRYA8QsVD+xWPfUjpjX5NQRhTD4Bbz/xzpBDK62NwoPLoLII1Y9H
         rwAzICO3cP/i4iLwA13h65/RtzSPM5T5eMq8icN3C07bnn4ediZB517bLu+tQjsRV4L6
         H/jA==
X-Gm-Message-State: APf1xPDJPKSynudiJ7s4XHhKdOaEoj3icROAmtsBcTJzEH8akrqg73vG
        3TpeIEkW2/y5UVeLKP4RLAag4CcJnk4=
X-Google-Smtp-Source: AH8x2245Fh3inZNGoinSTtW/nKoarGUWKFSMud9Pyc3o8AYLL//zuSkZ9X/qkTftny0qyUXS8nvRrQ==
X-Received: by 10.101.67.71 with SMTP id k7mr643616pgq.136.1518653902812;
        Wed, 14 Feb 2018 16:18:22 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id l80sm4739302pfk.44.2018.02.14.16.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Feb 2018 16:18:22 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/1] git status docs.
Date:   Wed, 14 Feb 2018 16:18:11 -0800
Message-Id: <20180215001812.135304-1-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A user complained about the inaccurate documentation of `git-status --porcelain`.
Fix the table showing the states.

I found e92e9cd3c3 (Documentation improvements for the description
of short format., 2010-04-23) which also linked to 
https://public-inbox.org/git/20100410040959.GA11977@coredump.intra.peff.net/

Stefan Beller (1):
  Documentation/git-status: clarify status table for porcelain mode

 Documentation/git-status.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.16.1.291.g4437f3f132-goog

