Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01F2E2141D
	for <e@80x24.org>; Tue, 22 Jan 2019 14:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbfAVOmg (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 09:42:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52006 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbfAVOme (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 09:42:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so14407773wmj.1
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 06:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wutLavTrUFm+pGaCnESAeomqLN1u0UjGjc/8mngdTBI=;
        b=u2vD2kbHDQN0qrsaiF4Kx5onZfRF5h4GvVWsKfCy/m6jLC+EwqZb95dW5QmL55h/Xj
         h7uKjdrbN5qXkBR/nQw1zLpLNs7AzcV7nYT43WO9Hjmflx618OIDUToSFg1810YwWN7w
         e0GanE42GwkzpdLDRnoTYVBUaO5YAvIDK7vKq151Ir+cRWl7p0UJZ3pcKwDEAWsyayYK
         IbXDkHZJdntKYkAGadxu1WtmfY/zsS8zZXe9FVJ7ZESMOBYJNA+NgYNL1dQZ33NdKd/m
         dc+EmwwSTUSysFPJI6GtpKi319bI2o0J+dRiSlqaEygKuH9s/NfuUtMSY4lzv3XkOa7f
         IDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wutLavTrUFm+pGaCnESAeomqLN1u0UjGjc/8mngdTBI=;
        b=BpYCLG3Z7juuxihAbYuKKYPtEgMQxEgYZXxG+9DiZLu6+GszNIeam8NaNxywZX9r2V
         dt0bRbAzk937jqcZIiaoPBMKDmS9hZrw/WUu+zLiotxd9vzOQKEvFwQhXsjCgHME4hc3
         wvoka6iQ0Cr3smVumZ52eQzsbHhyLAF8A+MAG4eOyM07PIbsqTSJX8i0njYbWcmeCj+/
         RBAavKbzTpMdVdDxvbcWPZHwpuaCIQKGo2krxpKMdOi1LINIgetzrrp6eZbE/6jq+H8f
         9xj0DSgnjhvu38a4q5dEh2Biz+6AQ99PNAEsiub2CdxcwFSZKiFVHPv3kIlRV772mEk8
         OocA==
X-Gm-Message-State: AJcUukfBggWf9BaqzabYrXvVmPDVB9Pm6DiOdBjEZrOoZoD6exXyxzea
        /nTxQe8PXI1yigPKoJFKQ2UPXX2K
X-Google-Smtp-Source: ALg8bN6VzM4f8bGb8zIE6C2fmGP+PE2AgZec8INiU1Zpq0L+Nbo4o6B1X2hPbWYQvO8XuqQHB3Hj2A==
X-Received: by 2002:a1c:2088:: with SMTP id g130mr3985917wmg.122.1548168151286;
        Tue, 22 Jan 2019 06:42:31 -0800 (PST)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id k26sm31266168wmi.28.2019.01.22.06.42.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 06:42:30 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 02/13] partial-clone: add missing 'is' in doc
Date:   Tue, 22 Jan 2019 15:42:01 +0100
Message-Id: <20190122144212.15119-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.20.1.322.gd6b9ae60d4
In-Reply-To: <20190122144212.15119-1-chriscool@tuxfamily.org>
References: <20190122144212.15119-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/technical/partial-clone.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/partial-clone.txt b/Documentation/technical/partial-clone.txt
index 1ef66bd788..896c7b3878 100644
--- a/Documentation/technical/partial-clone.txt
+++ b/Documentation/technical/partial-clone.txt
@@ -114,7 +114,7 @@ their "<name>.pack" and "<name>.idx" files.
   that it has, either because the local repository has that object in one of
   its promisor packfiles, or because another promisor object refers to it.
 +
-When Git encounters a missing object, Git can see if it a promisor object
+When Git encounters a missing object, Git can see if it is a promisor object
 and handle it appropriately.  If not, Git can report a corruption.
 +
 This means that there is no need for the client to explicitly maintain an
-- 
2.20.1.322.gd6b9ae60d4

