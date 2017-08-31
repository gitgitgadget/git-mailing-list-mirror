Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C9D0208CD
	for <e@80x24.org>; Thu, 31 Aug 2017 13:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751086AbdHaNTl (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Aug 2017 09:19:41 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35420 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbdHaNTk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2017 09:19:40 -0400
Received: by mail-qt0-f194.google.com with SMTP id u11so477579qtu.2
        for <git@vger.kernel.org>; Thu, 31 Aug 2017 06:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=I2YkMiqihTxNlYr5OlKQFsIXKq/V0UJX43S6DfJZdKw=;
        b=YATTEfBk5+zIENsoCp5loU9zIi4aP4wbPlWrgiD8rSA540AT9cgV5AaIPdjhBuPP43
         CMDHCbXzCN/eZaKk6e1wIkmLnf3Z+p8AroHCq2tACrUGfujSXI9SieWz01nbCzsRpjmn
         6ZO+K6jwchSVIBksZFtXjqV6Tgf/AKDkkqp4bICJcdY6G44DyTqN2cjPo/SStW+Z7EhS
         j6vbk7sF8BL+9Y9Szm09iUaAXRzvBNS+5xJ4VgvRqDSLHPHUESoj708oEh56A8CLkfYv
         ocJEEZLcC42iKiuzwB8BnH7FgBqUOJ4SQI97cYDtWZjq0/aqdDE5VIvjIx48uIf6FTP5
         379A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=I2YkMiqihTxNlYr5OlKQFsIXKq/V0UJX43S6DfJZdKw=;
        b=fZz8oSr1Rw1SrFJpll8gbT1xKBzGn6rEg3dl+xS8vmkLg9aAAWJQGsXIflXobeh2QN
         X+wDYLOQdmM+isl0CJguuhYyMxg2dTulcXj9exIrQgBkzD4OMYv3CD16TsNsD+WD6cRJ
         zzXE+BFuxD6C+py5tDAIPwWA8E/FU3S8rfaWu2ocUSzUQmC3JA0zE/x5u8/b5nfqyFvd
         DjBVjjUbhqozByixWKV8os4QS3wICju47xjn3DFMrTyfr27PVW6MTdmts7a0qFdMzw3G
         90XMLlTWvivAEBic0wPo5hEX7N92Jk8z4T6UdW9YGISbdUclqbl/RO+BBeo3nJbVYh0l
         5ejg==
X-Gm-Message-State: AHYfb5iyHaPmvz8IdlQt1lqV5PhruaeOW+EU1URLAhy+PXon7ZWNN3Dk
        xEoTVqNfqoo9/vk5R/0=
X-Google-Smtp-Source: ADKCNb7cgaIWJXYztvhMxYlzF58Y7ohXR0SIz5So+ckhUWWkqJRsniUtYAqSwGYdEauD9BLSEfaZfQ==
X-Received: by 10.237.60.168 with SMTP id d37mr7399585qtf.9.1504185579595;
        Thu, 31 Aug 2017 06:19:39 -0700 (PDT)
Received: from localhost (tripoint.kitware.com. [66.194.253.20])
        by smtp.gmail.com with ESMTPSA id o17sm5373854qkl.52.2017.08.31.06.19.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Aug 2017 06:19:39 -0700 (PDT)
From:   Ben Boeckel <mathstuf@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Ben Boeckel <mathstuf@gmail.com>
Subject: [PATCH v3] Documentation: mention that `eol` can change the dirty status of paths
Date:   Thu, 31 Aug 2017 09:19:36 -0400
Message-Id: <20170831131936.26226-1-mathstuf@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20170822174918.GA1005@megas.kitware.com>
References: <20170822174918.GA1005@megas.kitware.com>
In-Reply-To: <20170822174918.GA1005@megas.kitware.com>
References: <20170822174918.GA1005@megas.kitware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When setting the `eol` attribute, paths can change their dirty status
without any change in the working directory. This can cause confusion
and should at least be mentioned with a remedy.

Reviewed-by: Torsten Bögershausen <tboegi@web.de>
Reviewed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 Documentation/gitattributes.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index c4f2be2..4c68bc1 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -151,7 +151,10 @@ unspecified.
 
 This attribute sets a specific line-ending style to be used in the
 working directory.  It enables end-of-line conversion without any
-content checks, effectively setting the `text` attribute.
+content checks, effectively setting the `text` attribute.  Note that
+setting this attribute on paths which are in the index with CRLF line
+endings may make the paths to be considered dirty.  Adding the path to
+the index again will normalize the line endings in the index.
 
 Set to string value "crlf"::
 
-- 
2.9.5

