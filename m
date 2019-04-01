Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74645202BB
	for <e@80x24.org>; Mon,  1 Apr 2019 16:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfDAQlQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 12:41:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51640 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbfDAQlP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 12:41:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id 4so104932wmf.1
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 09:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XntUJc4k1Zp4N1xIrmXLeuG+ksVkNtIoVn5atpCh3yI=;
        b=YszJLOfJo2OeLtTtRQdr30EyU1z5l2k8dbTDsUvklnboVXCrQvg2gtSyxQno738YDz
         Bo1JnxVHA2SvyavYIXIzv5DoqvJdX249FKzY+6GHDvZyiG10pEhWb/mtNWqa5ilOwiy5
         cQltrRPj1UWA+0pxuiGlhFxInB/nzxcK1XHxe1iHEM4GTS/P6LVMVMMago0sZhqcwt2C
         OTXBzsI5NZprG4E9STTd3KuSm21jznOh94BpBBDoE2kCyEAcnkAPgJUibg+7dDYy/pCu
         E40ZvNEAeoaXD5V3F1y8ppyVJ7Yw4APlhBNEcl1NSzDmxT839Y9f7o3k3AwuzPeVsGDc
         gYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XntUJc4k1Zp4N1xIrmXLeuG+ksVkNtIoVn5atpCh3yI=;
        b=g57tjDaas7Rz4Fq/AnuxJ1vPKvXL0sBd/Ffywxp7bEed/YR4+ojo598OwzVkKM4YXz
         QNo+Bs12xn2ttKKsVRVBGkchtjbhC9hHiiZbIr0tZC2gFc0+a8m7mZiLt88GQkuIX988
         PZdgiaVSsb9I2j2OZnvy3VFZLmjb2URZ8ghEw+kJCwmThTVF9Dlv59UVh2D/nTtGLD7B
         cmIy9nIgNsVBmrDI++N58XK3BUA5EVPv0CpKQ7BmnsDlSlId1mchfm1E2Um6QrwTfepx
         jWbZcCMJomGhFuhjXaDJAV6bh5k0bFIUEbc9YnIPKV2Nikm13Djx6mCXxc5RqH9Qoij1
         vvzA==
X-Gm-Message-State: APjAAAXe5u07yUGdC6iLgckh9fwDVcsF0VEKYne8wz+AqFaGsbliBOc8
        9pHQZ/XDdmFfV96O+8F5sFOIIGWw
X-Google-Smtp-Source: APXvYqzABbPqN3eRUoiYOBXSsNrWUfC3TiizAUmsL843zwreb7DiXDFebih4WZjsHBdDIRnV8M+rXw==
X-Received: by 2002:a1c:ac07:: with SMTP id v7mr351077wme.49.1554136873474;
        Mon, 01 Apr 2019 09:41:13 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:101d:3e80:8542:d1d4:667f:a0da])
        by smtp.gmail.com with ESMTPSA id s10sm11749070wmh.0.2019.04.01.09.41.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 09:41:12 -0700 (PDT)
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
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 03/11] promisor-remote: implement promisor_remote_get_direct()
Date:   Mon,  1 Apr 2019 18:40:37 +0200
Message-Id: <20190401164045.17328-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.203.gd44fa53258
In-Reply-To: <20190401164045.17328-1-chriscool@tuxfamily.org>
References: <20190401164045.17328-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

This is implemented for now by calling fetch_objects(). It fetches
from all the promisor remotes.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++
 promisor-remote.h |  1 +
 2 files changed, 65 insertions(+)

diff --git a/promisor-remote.c b/promisor-remote.c
index 0c768210ee..a3d601e45a 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -1,6 +1,8 @@
 #include "cache.h"
+#include "object-store.h"
 #include "promisor-remote.h"
 #include "config.h"
+#include "fetch-object.h"
 
 static struct promisor_remote *promisors;
 static struct promisor_remote **promisors_tail = &promisors;
@@ -90,3 +92,65 @@ int has_promisor_remote(void)
 {
 	return !!promisor_remote_find(NULL);
 }
+
+static int remove_fetched_oids(struct object_id **oids, int oid_nr, int to_free)
+{
+	int i, missing_nr = 0;
+	int *missing = xcalloc(oid_nr, sizeof(*missing));
+	struct object_id *old_oids = *oids;
+	struct object_id *new_oids;
+	int old_fetch_if_missing = fetch_if_missing;
+
+	fetch_if_missing = 0;
+
+	for (i = 0; i < oid_nr; i++)
+		if (oid_object_info_extended(the_repository, &old_oids[i], NULL, 0)) {
+			missing[i] = 1;
+			missing_nr++;
+		}
+
+	fetch_if_missing = old_fetch_if_missing;
+
+	if (missing_nr) {
+		int j = 0;
+		new_oids = xcalloc(missing_nr, sizeof(*new_oids));
+		for (i = 0; i < oid_nr; i++)
+			if (missing[i])
+				oidcpy(&new_oids[j++], &old_oids[i]);
+		*oids = new_oids;
+		if (to_free)
+			free(old_oids);
+	}
+
+	return missing_nr;
+}
+
+int promisor_remote_get_direct(const struct object_id *oids, int oid_nr)
+{
+	struct promisor_remote *r;
+	struct object_id *missing_oids = (struct object_id *)oids;
+	int missing_nr = oid_nr;
+	int to_free = 0;
+	int res = -1;
+
+	promisor_remote_init();
+
+	for (r = promisors; r; r = r->next) {
+		if (fetch_objects(r->name, missing_oids, missing_nr) < 0) {
+			if (missing_nr == 1)
+				continue;
+			missing_nr = remove_fetched_oids(&missing_oids, missing_nr, to_free);
+			if (missing_nr) {
+				to_free = 1;
+				continue;
+			}
+		}
+		res = 0;
+		break;
+	}
+
+	if (to_free)
+		free(missing_oids);
+
+	return res;
+}
diff --git a/promisor-remote.h b/promisor-remote.h
index 01dcdf4dc7..30c0b3dcb6 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -12,5 +12,6 @@ struct promisor_remote {
 
 extern struct promisor_remote *promisor_remote_find(const char *remote_name);
 extern int has_promisor_remote(void);
+extern int promisor_remote_get_direct(const struct object_id *oids, int oid_nr);
 
 #endif /* PROMISOR_REMOTE_H */
-- 
2.21.0.203.gd44fa53258

