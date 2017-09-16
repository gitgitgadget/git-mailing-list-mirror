Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D561B20A21
	for <e@80x24.org>; Sat, 16 Sep 2017 08:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbdIPIJ5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:09:57 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34778 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbdIPIID (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:08:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id i131so4521346wma.1
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tEyTDsp2GjV04iTi2hYbzZBQJKpTWZ43CeEggVeuDRg=;
        b=tu/4m3avpCLo/FammtLiATdZZkLW6sgC9+L9vu/LMQclditTUg75IV8XpUexOGCSSZ
         RNmdeyEa3TpE3UEeUFtEKTj3ynlMDYWWFQeBQvD8PQr8SmondsmIwvHXltqwc3VIVyu8
         R/DE9/En2pub5IeU3Y2GqF6NKuptwE5s7XHnju7SZc3ekpxT/wmjC1Coa7H6rc4Yy+Jd
         RVIuAkeONgSTCQiT2NH6la2TM81wEPbxDxccdSIeSF9OBXhTyoncql/A7Ta3PMt4zbxk
         H7ORYX8B0jSRZ4e+9HYPk6J70Vv4Il52YiP3zDUbEdNa/+rFsLAy/BSFD2t1bYMbnTlp
         Yq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tEyTDsp2GjV04iTi2hYbzZBQJKpTWZ43CeEggVeuDRg=;
        b=B7WB15VgNggAJvGkQeYo0RXjsul5AAPpSjTue42nJ78xDKFG24i5Mj3+kUkeq3D8C9
         6IW7pQ19jSmtM/u7tYyD9MO8XuvJD3g3KuB00lYYGbXGZbj+TtBqaKyCH3/4qNEXC3/m
         axMginFkccu5lrd0kGHgUaEwlBZo4z8eymclv0LvlOQznGiy9m/9AIf8IX981HwfJc2b
         oYx9U1gNtcqtg7fxtXqACQr2OR9q/44gM19j1S55nAWiP4zt+Vd+yVcV3X+4i1oHoC0V
         WTD7niFdVwP8S+jkfmMBNWHC01eXbbMWHIDEyxr5/tWuD4FVZXNLOAFas6GV0vf5tP0t
         tFIA==
X-Gm-Message-State: AHPjjUgS8FUrsvhtPcSjHQ1kJ+Uld4cuyKj9AM9ImaMSkrfUDYNZPDyV
        6IFrSYoJBk/Uip0pv0ewEp4k4A==
X-Google-Smtp-Source: AOwi7QAX9bvA+yP7gla7C4sCTh9YaCKmqTPFoKLbxhP1tvvTNDxL0WqtwXU5VsmIEkGg8ftLSWl3Bw==
X-Received: by 10.28.92.73 with SMTP id q70mr4758973wmb.150.1505549281515;
        Sat, 16 Sep 2017 01:08:01 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:08:00 -0700 (PDT)
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
Subject: [PATCH v6 13/40] external-odb: accept only blobs for now
Date:   Sat, 16 Sep 2017 10:07:04 +0200
Message-Id: <20170916080731.13925-14-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The mechanism to decide which blobs should be sent to which
external object database will be very simple for now.
If the external odb helper support any "put_*" instruction
all the new blobs will be sent to it.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/external-odb.c b/external-odb.c
index 82fac702e8..a4f8c72e1c 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -124,6 +124,10 @@ int external_odb_put_object(const void *buf, size_t len,
 {
 	struct odb_helper *o;
 
+	/* For now accept only blobs */
+	if (strcmp(type, "blob"))
+		return 1;
+
 	external_odb_init();
 
 	for (o = helpers; o; o = o->next) {
-- 
2.14.1.576.g3f707d88cd

