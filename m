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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6106F1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 13:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbfFYNlP (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 09:41:15 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38422 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfFYNlM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 09:41:12 -0400
Received: by mail-ed1-f66.google.com with SMTP id r12so27259620edo.5
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 06:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v7xYUgFCv1yB8odZItBcl+uRJGhBZUO/PWSuRmjzAqI=;
        b=uMlu8z7AR8bhTad0frCdbijRenOyV+Eyq9lEjt5lt6ov64VBCTVfzcHdFgh0TSCYVt
         l4MBcJfQycICgFv8kIJe/sdQU4QT5aOnw1Y3XbecCuBzPOivf+OKHR1Q5YeTFyVrIy7y
         C1pCgP4OHe5pfogrFzqOxLbCFUpG0RauETzmoPFXoL4YkNM1OMiYY4pHSEEl/ovTiHhn
         IOhccxsIeIpI6S8IosEcJUIsYMBFwbM/DJ+5dErV5AGiSuknrXSSE7+47ZCfQjFddyh+
         6v0EsxAfoFsf0+eeXJrA+mJMPj43M86bqY26PPnkuQ4QQ2BW+87j1Lm2BXAiqG07boAz
         H0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v7xYUgFCv1yB8odZItBcl+uRJGhBZUO/PWSuRmjzAqI=;
        b=TBoe3374W5R8m7GDpNJC22azBmQhPnnAadFc1nsS5lhKr2rgy3PcQhjGrHVeMSPKoc
         aSN2hvnXao52dDjV9MgLbq+jjXlR3AoQnEa2lP0i7ZhuwHfYpEfH1FIUi+DnxNf8SUhs
         lMyYX8hdID3D5A3ccbB92n07nnVfVkujb2P2rvCQufO8cmPhz94Jz3n5cY+UW+D/VK+R
         sthNK/f9733M+3YcMOTJwTvUP3WebmGFJSM6oV0sOv6yXjXCtCtIWbSWWzReQ7wauTMd
         6X9BqBv9c84Z+PWLLzSUjjYFRPl1ZT8CN78eBMjSDAcoSypSXHLXKFUWqYnuSvP8RiQ2
         gfnQ==
X-Gm-Message-State: APjAAAV4DhJEZiLt1raAWoRVMiuYN1Ez5iOK/fRlI6wtxD0nsXf53xyK
        J9Os2Dc4vemM3D5T7nz3Y/Z31Ac9k7k=
X-Google-Smtp-Source: APXvYqzWKrg4/dhe8G0L3R7sWX4+ttwyAed8KASazyLg7IaCJv7RA38PADNaHve9Ac5VYaxzCnnENQ==
X-Received: by 2002:a50:fd0c:: with SMTP id i12mr82974221eds.55.1561470070138;
        Tue, 25 Jun 2019 06:41:10 -0700 (PDT)
Received: from ubuntu-N150ZU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id v11sm2448445ejx.24.2019.06.25.06.41.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 06:41:09 -0700 (PDT)
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
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 04/15] promisor-remote: implement promisor_remote_get_direct()
Date:   Tue, 25 Jun 2019 15:40:28 +0200
Message-Id: <20190625134039.21707-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.229.ga13d9ffdf7.dirty
In-Reply-To: <20190625134039.21707-1-chriscool@tuxfamily.org>
References: <20190625134039.21707-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

This is implemented for now by calling fetch_objects(). It fetches
from all the promisor remotes.

Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Helped-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 promisor-remote.h |  5 ++++
 2 files changed, 72 insertions(+)

diff --git a/promisor-remote.c b/promisor-remote.c
index c249b80e02..b79a84ce3a 100644
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
@@ -90,3 +92,68 @@ int has_promisor_remote(void)
 {
 	return !!promisor_remote_find(NULL);
 }
+
+static int remove_fetched_oids(struct repository *repo,
+			       struct object_id **oids,
+			       int oid_nr, int to_free)
+{
+	int i, remaining_nr = 0;
+	int *remaining = xcalloc(oid_nr, sizeof(*remaining));
+	struct object_id *old_oids = *oids;
+	struct object_id *new_oids;
+
+	for (i = 0; i < oid_nr; i++)
+		if (oid_object_info_extended(repo, &old_oids[i], NULL,
+					     OBJECT_INFO_SKIP_FETCH_OBJECT)) {
+			remaining[i] = 1;
+			remaining_nr++;
+		}
+
+	if (remaining_nr) {
+		int j = 0;
+		new_oids = xcalloc(remaining_nr, sizeof(*new_oids));
+		for (i = 0; i < oid_nr; i++)
+			if (remaining[i])
+				oidcpy(&new_oids[j++], &old_oids[i]);
+		*oids = new_oids;
+		if (to_free)
+			free(old_oids);
+	}
+
+	free(remaining);
+
+	return remaining_nr;
+}
+
+int promisor_remote_get_direct(struct repository *repo,
+			       const struct object_id *oids,
+			       int oid_nr)
+{
+	struct promisor_remote *r;
+	struct object_id *remaining_oids = (struct object_id *)oids;
+	int remaining_nr = oid_nr;
+	int to_free = 0;
+	int res = -1;
+
+	promisor_remote_init();
+
+	for (r = promisors; r; r = r->next) {
+		if (fetch_objects(r->name, remaining_oids, remaining_nr) < 0) {
+			if (remaining_nr == 1)
+				continue;
+			remaining_nr = remove_fetched_oids(repo, &remaining_oids,
+							 remaining_nr, to_free);
+			if (remaining_nr) {
+				to_free = 1;
+				continue;
+			}
+		}
+		res = 0;
+		break;
+	}
+
+	if (to_free)
+		free(remaining_oids);
+
+	return res;
+}
diff --git a/promisor-remote.h b/promisor-remote.h
index 01dcdf4dc7..ed4ecead36 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -1,6 +1,8 @@
 #ifndef PROMISOR_REMOTE_H
 #define PROMISOR_REMOTE_H
 
+struct object_id;
+
 /*
  * Promisor remote linked list
  * Its information come from remote.XXX config entries.
@@ -12,5 +14,8 @@ struct promisor_remote {
 
 extern struct promisor_remote *promisor_remote_find(const char *remote_name);
 extern int has_promisor_remote(void);
+extern int promisor_remote_get_direct(struct repository *repo,
+				      const struct object_id *oids,
+				      int oid_nr);
 
 #endif /* PROMISOR_REMOTE_H */
-- 
2.22.0.229.ga13d9ffdf7.dirty

