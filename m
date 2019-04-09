Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D1E420374
	for <e@80x24.org>; Tue,  9 Apr 2019 16:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfDIQMF (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 12:12:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55479 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfDIQMD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 12:12:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id o25so4224527wmf.5
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 09:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y0Do80d2PQBTqqe6EfxWfVFZp8FN+9ycPLcbMO84/AU=;
        b=mdXIHGJ/EYHEwq94dG/hjRwI1m27afXb144R/p9ttIOSvKFj0QxfOKCfOP8QlPGosm
         R2FHnzRAk6i505RZR/W5qYEDpn7brN5Z2Tilde5p6+hHu47zPAVMTkrE01UW+X3SfPMA
         BSx01ZjjrjThr5sBs+LuSZMWulWlTkqpF0zlnz6pWZeVP/Z4ys5jvhh6uai5rS1JlVxU
         xnsZzT1sHH3C7bnCQqbDQ+Mm3WJBxOgjC5OWR554gFFOLh9jykVDPqDItQDTcoHIj0li
         BYtsfve4WkkmmTlY06c6G7HQXFa6AQJB/nN2T0TAzmZDKuZr6JQe5Uungr9kvd0YrBno
         CIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y0Do80d2PQBTqqe6EfxWfVFZp8FN+9ycPLcbMO84/AU=;
        b=FCl32IJLpGjUPZOT+aQDmu+ZIW4cHwDn/216Q47fyLbCSZgIJ+m/r9owazHQNn5VwL
         473zCMZC8atUwsnrdiSXLcL6mFueFQ2f16ZNI5YB6LWQfXXljf2Fh3EPeqKXe9CexnYu
         1tWZDOKWHuNmYqwo4mPmvYTUClChSytM+q1x0mOUVrJvO4k9AWY4u7Zy8IwkAKkX2tRI
         fgT/wCKhORnW55tobW2fEJCg3khHsLn5uKvPuQ8Zx/znneUiXUxf7h+CkofIhR0oYqoS
         30LF+9BmYtWl9iGOxgfzsUL9QZS11lLlssPmimFwPYCx6imCvxfOYnTdAy/bEXFKpfcv
         Hj2Q==
X-Gm-Message-State: APjAAAXV1zbu3IwlbaUnHcNfpkcToVHRki59ytiLiz5c0Hkvb0zkUppy
        61FzrdBwq8b0rNPHGcAQ44In9BiR
X-Google-Smtp-Source: APXvYqxSy9QVbb35K4ycjKALO7qMkcqTQDJG47OKToWi9hUSOoGnmI0qBWjlMPhJOaeqG/tAJtJwvw==
X-Received: by 2002:a05:600c:2309:: with SMTP id 9mr23080700wmo.52.1554826321497;
        Tue, 09 Apr 2019 09:12:01 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id i2sm4356012wmg.47.2019.04.09.09.11.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 09:12:00 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 13/16] remote: add promisor and partial clone config to the doc
Date:   Tue,  9 Apr 2019 18:11:13 +0200
Message-Id: <20190409161116.30256-14-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.750.g68c8ebb2ac
In-Reply-To: <20190409161116.30256-1-chriscool@tuxfamily.org>
References: <20190409161116.30256-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/remote.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
index 6c4cad83a2..a8e6437a90 100644
--- a/Documentation/config/remote.txt
+++ b/Documentation/config/remote.txt
@@ -76,3 +76,11 @@ remote.<name>.pruneTags::
 +
 See also `remote.<name>.prune` and the PRUNING section of
 linkgit:git-fetch[1].
+
+remote.<name>.promisor::
+	When set to true, this remote will be used to fetch promisor
+	objects.
+
+remote.<name>.partialclonefilter::
+	The filter that will be applied when fetching from this
+	promisor remote.
-- 
2.21.0.750.g68c8ebb2ac

