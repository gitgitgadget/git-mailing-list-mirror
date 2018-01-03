Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF2151F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751250AbeACQgP (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:36:15 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:43421 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbeACQes (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:34:48 -0500
Received: by mail-wm0-f66.google.com with SMTP id n138so3641139wmg.2
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C0EMhJTsXqetbF6WyLEoVjQ9euXDuAaY9ASBYC1WZt8=;
        b=j7v+vgcMn4GsQXnCWr+i5v3oYwQ3D9aaEC1ZQmVNRRGHCy8Fduj4Y3Do2ESZ5CMtrj
         HbG+GVQAUUAtGCN+uWEFElm2k2U6v48xofTY8vhGJNDGaxHlgbs8OkWdyPnsi0oOl5mb
         u0BM7DicPr3FlDnZrn3GNzQLBrS+7sCthDhnyKuYFFqnmrFzAs4DDMfWMCUvIl6cUzW2
         2H+nhrGV9cHSD8vnGGgPjnSAxNhw/D6IEwmNmkTI/3QTRKfRKdp7fHf6SE3BpZsma/15
         cUp00ui3qDqddiG0KIcSgZv2NzMYXH67PH7yQrQ9iZ1n5TXIfC5kG68JnPc3T/Rhu95l
         oAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C0EMhJTsXqetbF6WyLEoVjQ9euXDuAaY9ASBYC1WZt8=;
        b=jrgOHC8Zmfl1mUz/H0k9g5EOFm8oskfvxndoGs04q7II2j2BX2kM45IeAPu9LDEenS
         W2Cktqm7iFRU+P9+BBoQh51uy2nJjQUs0vNHTmvh7DvLNG+hueJwVlvBk6mzUXj2QkmN
         M8pZs93gnb/lgpOuJKKom/03kgEuc73RJ9kW5CuyfOJ+HusUBQHGh3Ix1JscAMwL8IBu
         OstJ0k/CA41H/Dj8Y0fCdWpEnb3MiQ4pv1heGLnk8jke/zZx2E7uxLHY2rfCcHE5zr3D
         XuqhbCo2JyK6Rik/RGGczH2w6KO9dKOqfGpeI5df5eAn3chC22+zfkGQhTTUTdb3Cvw5
         3XpA==
X-Gm-Message-State: AKGB3mJ/WOz4mkZx4gNU+oafYpOSC5zBQayBU25b2fUA5ebYl3Z/2B5v
        VCIwo0VqVaYyDI11/fCmbOZ470RM
X-Google-Smtp-Source: ACJfBovEjoVmoMhF3bbRcRBnhIoiedqCz/xGnhXrmOg3DLUnzPT46vmmtVN+VCziAtWAlwZguRo59g==
X-Received: by 10.28.183.132 with SMTP id h126mr1978753wmf.17.1514997286984;
        Wed, 03 Jan 2018 08:34:46 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:34:46 -0800 (PST)
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
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 20/40] external-odb: accept only blobs for now
Date:   Wed,  3 Jan 2018 17:33:43 +0100
Message-Id: <20180103163403.11303-21-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
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
index 337bdd2540..93971e9ce4 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -159,6 +159,10 @@ int external_odb_put_object(const void *buf, size_t len,
 
 	external_odb_init();
 
+	/* For now accept only blobs */
+	if (strcmp(type, "blob"))
+		return 1;
+
 	for (o = helpers; o; o = o->next) {
 		int r = odb_helper_put_object(o, buf, len, type, sha1);
 		if (r <= 0)
-- 
2.16.0.rc0.16.g82191dbc6c.dirty

