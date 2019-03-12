Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63D5D20379
	for <e@80x24.org>; Tue, 12 Mar 2019 13:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfCLNac (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 09:30:32 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46380 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfCLNa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 09:30:29 -0400
Received: by mail-ed1-f68.google.com with SMTP id n17so2255824edt.13
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 06:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZlFfQvdTesOwcJ+FpZBsUDW33v8Ne5TN7SitZEfxQgw=;
        b=sQNLhifI8nnsxZC7S2yXlzM9B3CIuT9zyoZKW3v8VcGoAv6k5o+L0V3OCu6QF0Oq5a
         YIixbvxKP9fSVVH+r/SfrbGf+iVE8PyF/zZEz4iPkOzgZF1hgZEU5bOvXs5YlbDY+3l5
         IvTpijslk2X+SX5Pqzhf9VLurzNfWTH3qvt39f3UBcrINxN+77bSiHlWWwP+1UFTCKgs
         590Bs7bIbS1qEDA0CbMKJmTIJNx1F8ejM5P+nlUKHDOhLG2NUFHuvDy8rH5ZUSpN9ISD
         da0gl5XDqC/9X7n1FtM+aBvaumOCB8wFa0ple6kRXKWMvdHv3hk5GSQlT2WyUPDnQulu
         TIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZlFfQvdTesOwcJ+FpZBsUDW33v8Ne5TN7SitZEfxQgw=;
        b=X8DjlCw93esUPRv0kMFpWBps1y3fNDs70S0qF/uD/fADf11MWyreH3zXOcJfSbo2Ah
         9Ez3uZbX4ZUPaMJzKTKnkuZ+JUNuM+QFtoeQ6cm9GQDkRdjw8s3lmsfyF+isH1b+KRUd
         SpRD2uSS6JWe56zsR5NUNGACAEZRLcd7QuMsb0mSYBVtTImVgfsdQHIljBW6ncqTbHnM
         oZ2iLk9RAm97oLlnvqFab4qZafUkVL6kaFMVbT2AOjycoDRpHe/plJPcFopXT2CxHFtY
         9+U5WmdJHUzoHJU+4Tol6HpKMaOcotvHdyalO7fMGQ+1eRZV4MkZWV/Az/f+IGyjT1NG
         tdpg==
X-Gm-Message-State: APjAAAWpOr4tPAqPHvIRNI0uzbFLcUg1lsyw5WSJdISCW1ADNUBMsTBj
        m7pcqZkBwq+OBQPZFu+lt+alWfV8
X-Google-Smtp-Source: APXvYqy45ZL/hwDmIbtzUdF2rCzL+jXuMapKws/oQlYbKYyA9u/XNJcDA68CBGaOgEsdf/ghoKQOEg==
X-Received: by 2002:a17:906:49c7:: with SMTP id w7mr26071396ejv.226.1552397427900;
        Tue, 12 Mar 2019 06:30:27 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id h8sm5875213edk.21.2019.03.12.06.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 06:30:26 -0700 (PDT)
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
Subject: [PATCH v3 11/11] remote: add promisor and partial clone config to the doc
Date:   Tue, 12 Mar 2019 14:29:59 +0100
Message-Id: <20190312132959.11764-12-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.166.gb5e4dbcfd3
In-Reply-To: <20190312132959.11764-1-chriscool@tuxfamily.org>
References: <20190312132959.11764-1-chriscool@tuxfamily.org>
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
2.21.0.166.gb5e4dbcfd3

