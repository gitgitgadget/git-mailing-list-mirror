Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA9092141D
	for <e@80x24.org>; Tue, 22 Jan 2019 14:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfAVOmk (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 09:42:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40689 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbfAVOmh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 09:42:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id f188so14406013wmf.5
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 06:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1cnF8jR2820ojq6y7rJUTSkpzvd2fiFQ53mxqcy6Tzg=;
        b=mTTGopzNQgDXUPvuPAgW1RVAaRIyHraIZBKXjB8FkbgBByekWhHPSCpGQuNRnEJpDt
         DBinkF8hdrac0um4h+kpkCydZCeezHTp/ynoY6DayR2/5Y5QERfPccyEhwnUvtYHlOjk
         SM5QIgnlxz2obWYU6HnuuljGfwsRq/TmwZKoJXs9Ccg+quASriBWfEKTKkyjss8Lz4wD
         OfpoPZpoieaf5mUzeM7FJgSoR89VD2uF1YFwhVvLVL7xkKuWzp7DIp7eUoaXirFQ3nYe
         MBIXJnvv1cTCzo7FANTXxDgpWdP85ot8a2QBP006vq3SuB0M4pdpCQFbtnpTTe6+VqfO
         JLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1cnF8jR2820ojq6y7rJUTSkpzvd2fiFQ53mxqcy6Tzg=;
        b=CortpOFfJj/nlsORYN3UTGeeuAgfP8sXRCpbTWmLu1p7+AMFR8e0C5QPPUILs38mFc
         WyXgf1bSR2ugtuq7nWN1q+94lEgSMIuLp49TBVeUOlnjmWPNc3+4UXG/Peo8EVehr2Oa
         3ectdprHCB52cob42DBo9uTvmB2n5LEkKfMCGXFbz40rjIUtL99ah5ldjVUqscb2Lvqk
         fPluYITyZ3LT3STY8eL+KONpaUEUxwFmhPnMOiWvHAimxADwn0zgDHRrWS84JZ/4Gyjt
         d/0tXqXZ59iFbkCv+bmaibf/iKyDrmpO6tO0IwpjNV/3fCMqsir6ig6F9Qaaa5JyIRn4
         iCWA==
X-Gm-Message-State: AJcUukevGvEWnC76iK0iVaEam2pi2M7a77DJ1Qd0YmvB1875i4vJPatT
        adM5DCipzkPVAHTO94LyayBM5bqL
X-Google-Smtp-Source: ALg8bN5lHZ59t9sK0oDPXLY7CAMjFeZ1TaMA8GnWuSl64ra0AP6oL8IiM7bjNcEdJYi7Zyjee0Pctw==
X-Received: by 2002:a1c:1902:: with SMTP id 2mr4115209wmz.150.1548168155177;
        Tue, 22 Jan 2019 06:42:35 -0800 (PST)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id k26sm31266168wmi.28.2019.01.22.06.42.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 06:42:34 -0800 (PST)
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
Subject: [PATCH v2 07/13] promisor-remote: use repository_format_partial_clone
Date:   Tue, 22 Jan 2019 15:42:06 +0100
Message-Id: <20190122144212.15119-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.20.1.322.gd6b9ae60d4
In-Reply-To: <20190122144212.15119-1-chriscool@tuxfamily.org>
References: <20190122144212.15119-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A remote specified using the extensions.partialClone config
option should be considered a promisor remote too.

This remote should be at the end of the promisor remote list,
so that it is used only if objects have not been found in other
remotes.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/promisor-remote.c b/promisor-remote.c
index ea74f6d8a8..dcf6ef6521 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -83,6 +83,17 @@ static void promisor_remote_do_init(int force)
 	initialized = 1;
 
 	git_config(promisor_remote_config, NULL);
+
+	if (repository_format_partial_clone) {
+		struct promisor_remote *o, *previous;
+
+		o = promisor_remote_look_up(repository_format_partial_clone,
+					    &previous);
+		if (o)
+			promisor_remote_move_to_tail(o, previous);
+		else
+			promisor_remote_new(repository_format_partial_clone);
+	}
 }
 
 static inline void promisor_remote_init(void)
-- 
2.20.1.322.gd6b9ae60d4

