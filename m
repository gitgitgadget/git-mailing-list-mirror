Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D38C61F461
	for <e@80x24.org>; Tue, 25 Jun 2019 13:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbfFYNlW (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 09:41:22 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32994 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbfFYNlV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 09:41:21 -0400
Received: by mail-ed1-f67.google.com with SMTP id i11so27271953edq.0
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 06:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZfzpubbHAcLJUt4CwStdJgNBdC3xUrbjHUmQ2Q/WJU4=;
        b=R1dc1z0uAKpyTvKAXSDf+y0ztA0gpACfxnUbJqbeC1CHEJdDFxgFzlrc/x6WReOs2W
         ku+rjiGiy2VQj0/9kBXWwSkjSdSkCSxjfAlXN5gFmqwCIVOU/slFFBrsybucaGT7l7Q+
         QqRgWs0EUTHnvx/1U8WkMubFxz4uzfATbmhNuF4GO+Ux4ph3jltpjMRoS/YPNeECdtIv
         B0sDEcNxZhLOy/JlcmHaeR9s2a8SFuGj1+T82XXhr907Y200i4W8hSK6VqO+fJepH4ci
         SLKDPj0w/c3I6p5fzzmeVNoFDb6xsp7KVM2549CQf7zpujmoDB7H2+IKL9k0iDEEyihy
         YH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZfzpubbHAcLJUt4CwStdJgNBdC3xUrbjHUmQ2Q/WJU4=;
        b=NdOd2RmfZ/6kMMzPlyULZnPS4NT8/MHev6kU773ufdcXHgx15QkXo7CnMHFX8a1oef
         OcSS/cIEQLMW/yOdaksl53dvcfWy+yIFiB92w9WZW3VpIq1P7I4FtP/mcfIqlypIcy2D
         tbKF/SNvkxRCLKBnzh9jxZoSERiJDJR1Lsnm2+6XlfnBeXcpEJhb3yoOLraJrxuxWeY8
         YItrKgsdcYV6YAHcCYbkGdgA7DJwXd4deGU7mZjIDmJGW2p/v/vg4Z7MnN6zOVfZX1W2
         EOY7dh092EI1ZJ4Mp2lZk2SlfCboGqtfBDFzl/8v3jyCaKlmsmFDO0I+MUEaqlGvrDTj
         NQbw==
X-Gm-Message-State: APjAAAXUZIfsNt2LfZKk3K8JvAKC9JdRfbulyg568Q+pGzJhQ3LbbBZO
        9MahefpsUUqTUD4vkDaUiaUKukfoAnI=
X-Google-Smtp-Source: APXvYqxK+WVO5NJySSc1C6d0Ap3Zv1Q55PE10CcooT3BLJ2j+YM8+IB8dFJKbZ/qr9dn0j2aW1441A==
X-Received: by 2002:a17:906:9711:: with SMTP id k17mr25203499ejx.298.1561470079426;
        Tue, 25 Jun 2019 06:41:19 -0700 (PDT)
Received: from ubuntu-N150ZU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id v11sm2448445ejx.24.2019.06.25.06.41.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 06:41:18 -0700 (PDT)
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
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v6 12/15] remote: add promisor and partial clone config to the doc
Date:   Tue, 25 Jun 2019 15:40:36 +0200
Message-Id: <20190625134039.21707-13-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.229.ga13d9ffdf7.dirty
In-Reply-To: <20190625134039.21707-1-chriscool@tuxfamily.org>
References: <20190625134039.21707-1-chriscool@tuxfamily.org>
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
2.22.0.229.ga13d9ffdf7.dirty

