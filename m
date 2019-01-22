Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23E881F453
	for <e@80x24.org>; Tue, 22 Jan 2019 14:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbfAVOmr (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 09:42:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38240 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728973AbfAVOmm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 09:42:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so27651829wrw.5
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 06:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rD/75bV/jeg2Muz2AT+6dgGxsd1j/DzJZPKtZtmT2nY=;
        b=TRwFD3Bbeqp0k2inJjZH55/fmEqHcSZJ3gT5Xq3b08yCf8VYgFAIqhoRcJk04yXFZx
         2qbXcmwY1kBGBj3w2YZTe/cX6gV6Y/U4uJaem3Me2wRaKvhOOjSpWUa1FGT7EJWFBu1D
         Dc6UYKjHNjTS6vVcfhiBrvnZYoWt8+4jlvFkGMWo+acEo8d3dIz5r2St75e4j0BH34+z
         CshnK3r/3yEtFECeur1MkxZWvsxMrd5ABrGLBKUnAHAE76Rr5K6wIOQhZMNURSzLWeLl
         utQ77wkJ05XNCbt+5B/P3uWBmL9u88AmjiHWRKtPBc++12mFygrnjCv03k4JxTAKxcjq
         IC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rD/75bV/jeg2Muz2AT+6dgGxsd1j/DzJZPKtZtmT2nY=;
        b=AH1F2y0ZNv40PX50eH7/sIyR75zRqWiaA0PBnJJv5fPbxqS6PgCeZ9/YBO2+FElIt8
         o7rq0OCRHvZtUmyIN42DTTgZualxZ4gXQ3LbFdQoaxP8Omn5k+cub5trRJX308J+5E0U
         z78YsYHlE2YaHniuAHQsaJY9VJw3tPC0aPt8534DAmUFBRtDTq0JOIGAlNJlEzvyl0fZ
         MC9134m/lV/sy/d5iwD5rgI+RcwjsNJAqEydVBvOijuC3dijLCduoygGiH2fHxP3yBS7
         mwRm9HM2+4aUQU6NZYz6X++9VxEqoGChsEt/UknczDDQPgx1igaLjRFLGRmlkUcAAnM1
         +DqA==
X-Gm-Message-State: AJcUuke7u+mJyR0Vy7KUcRvWKOyga9kVpQFgtzk+L7ys0IGaa9NlMZGZ
        3Ci+9SsCFK6N9VgQfiVInoAY73li
X-Google-Smtp-Source: ALg8bN4RWviVjuBrUBf9eiRfV2hkkPx20pAU4wjNOVE2UeyuQpqDcPVfjNbAP9o7cPgxj0y1Z2QAng==
X-Received: by 2002:a5d:4382:: with SMTP id i2mr33000770wrq.172.1548168160861;
        Tue, 22 Jan 2019 06:42:40 -0800 (PST)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id k26sm31266168wmi.28.2019.01.22.06.42.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 06:42:40 -0800 (PST)
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
Subject: [PATCH v2 13/13] remote: add promisor and partial clone config to the doc
Date:   Tue, 22 Jan 2019 15:42:12 +0100
Message-Id: <20190122144212.15119-14-chriscool@tuxfamily.org>
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
2.20.1.322.gd6b9ae60d4

