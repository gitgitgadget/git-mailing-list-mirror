Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A0E71FAE5
	for <e@80x24.org>; Mon, 19 Mar 2018 13:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933350AbeCSNco (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:32:44 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36536 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933323AbeCSNcf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:35 -0400
Received: by mail-wr0-f193.google.com with SMTP id d10so18635843wrf.3
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1w7IXjdyjkmfKPYhHytpxN3RGwTKsVZJIxIuUzndLDM=;
        b=l41CJs0GkLJouGkHFqFeN9NpuWEe3uxpk4b2goRqYYxeqTQ7k/Ww3CZ9JQdapA23T4
         k4D8vATkHIm5mXfFI69HL9mNUgWx27YjSfMF3vm0ddPpiQ6S9l6jSoDsgyR4Pms777Qt
         wAFgl4N3vkah+KqkoDlqFFT2KRzl7ui6/nPf7yYx/dnHHAguPCwFgIKvvNqIcul/fVxw
         1lWCSmYFWIU1OUq0i9J3EtLyfiB+nGS5E7MQtV8ngzi6WKyFJj63pAKFe7zmZDJDzmCt
         jv/ioMJgw/F2DsVHC4RvMeZ/A2B72/T2uxjY2nE0Fmb9y1d0zfHrKheO3pIFSYXqfbEW
         vXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1w7IXjdyjkmfKPYhHytpxN3RGwTKsVZJIxIuUzndLDM=;
        b=DKRt3pwfVZzifJQ882+7a2zlRVlrOm/jR5GiXIzMG698G6jrmWCYCzH2qMOWj9Qiot
         P1O56QpvI8txvowqaKdjPp4FmVlJ94zbHQIjEU9SfI7yrM47bUeymGfPrtYN6DvswldB
         +rN2srBfmseLwzIlxmdBGHDEJijIFVhx++pDdsJ015DwITyhOlarUsZMMnESA8hrxCWE
         7We4zWFB9nSud4RgDlDfy6Q2FGWOC/Oc9TZKEpzZ/uo99Jp8OKK1z9vAiTmihVJYuBu2
         i/ru3XG2NeAEDkD5HyXTnrc3ocP2S+AKl12bJZqNMHUQOkHuv9ElmKGYykkvBqzTPPvV
         8cwA==
X-Gm-Message-State: AElRT7EUhmPA2ezQrj6Ohq3TccHjfLgfZ2pvIPbAeKfeSo/gVbCiDsKi
        ZiXYgJMwtzjl+nHs9NECb9/dm9/4
X-Google-Smtp-Source: AG47ELsYmChFhiH8/y6W0+9m6KeT1UNqFVBGhAkVhyIPRdi17YoM1WMPsC5s21oxMQFyd9NVYU11Ww==
X-Received: by 10.223.193.73 with SMTP id w9mr10228096wre.101.1521466353662;
        Mon, 19 Mar 2018 06:32:33 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:33 -0700 (PDT)
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
Subject: [PATCH v2 18/36] external-odb: accept only blobs for now
Date:   Mon, 19 Mar 2018 14:31:29 +0100
Message-Id: <20180319133147.15413-19-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
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
index 806dc8e699..de2ae70db1 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -210,6 +210,10 @@ int external_odb_put_object(const void *buf, size_t len,
 
 	external_odb_init();
 
+	/* For now accept only blobs */
+	if (strcmp(type, "blob"))
+		return 1;
+
 	for (o = helpers; o; o = o->next) {
 		int r = odb_helper_put_object(o, buf, len, type, sha1);
 		if (r <= 0)
-- 
2.17.0.rc0.37.g8f476fabe9

