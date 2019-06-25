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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DF021F461
	for <e@80x24.org>; Tue, 25 Jun 2019 13:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbfFYNlc (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 09:41:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39830 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730847AbfFYNlW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 09:41:22 -0400
Received: by mail-ed1-f67.google.com with SMTP id m10so27236045edv.6
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 06:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=flz8AQf2YyWfeUF6PkCk1aqxzsb+TL0CnOz7yPbe5Ws=;
        b=Lw7lXDSme24srlg/9hwV+bp2HI0dlQF19XE1h6WMLN81e2nx8XoHPniIURXv8QP1ih
         o0oEx7UArWVPR6coyqBUs/LTv/uV5yKxFGLqyEV73dp/JFpHjBzCOZUkeEmnDNozxu0C
         kR4fTPvQY8/xNnPwpuI1390dgGOqgHWiTTrKnQmUVkdajXrwSHCqKJlcddd0oKaR583I
         SyeKdxRSW58lZh6q+s16/DoLDDm2pw+ZUdGzbJZfctu5UF3cfUCKzvibCi2TcFgXs7q0
         sQJM6nIOdVC4VmSngVgCUXxArvcxcnjTF7K1RvFcopcJq7P88UKwXdI2jVpofvXGvRgf
         EsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=flz8AQf2YyWfeUF6PkCk1aqxzsb+TL0CnOz7yPbe5Ws=;
        b=hZPyOqev9xF2Kzff5icftETlP+66G8S+0B5EYP0OJ3mvNyyBIIV7AwbMeFw1EUvmeW
         cn4OhsrOlhU2Bapwrm9o4zPZLjzwaE/hL9DLm9Ovwb923wWv6hJVhVmlRC5+7acgKGRo
         qdOJXlXJL/jj4nGYbVl6e2MA3nrM3lR5HY8LlzDuVAX65QK9LEMezeWvnfR7C4W3dr3O
         aujTO1vkEnrb02cP2EWKhoXD68qhnWVxG7vlM8VwmZKAfTIiubQ7afhXrd9/bF27XiuT
         urtqY+tbPX8dwEP97ztHsCdXI8sQs+0YPGPCAB5QKwU3UwDJh7hmJgCSi7l2YFVvRbQO
         Uysw==
X-Gm-Message-State: APjAAAUMED90VEE+uRHE5v88lgfJpI97KSUMWRX48ddEZaUrbkxN4+jb
        mi0aY35hYQzGawsM7W01jdfY8dT5glM=
X-Google-Smtp-Source: APXvYqynPCGhU+Ab31KsSG9WgwfHit2nb2FtzThfzIMnrM9rQjmCf+YRBVOZaMW0nulw8+Mm15dvVg==
X-Received: by 2002:a17:906:944f:: with SMTP id z15mr25055248ejx.137.1561470080531;
        Tue, 25 Jun 2019 06:41:20 -0700 (PDT)
Received: from ubuntu-N150ZU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id v11sm2448445ejx.24.2019.06.25.06.41.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 06:41:19 -0700 (PDT)
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
Subject: [PATCH v6 13/15] Remove fetch-object.{c,h} in favor of promisor-remote.{c,h}
Date:   Tue, 25 Jun 2019 15:40:37 +0200
Message-Id: <20190625134039.21707-14-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.229.ga13d9ffdf7.dirty
In-Reply-To: <20190625134039.21707-1-chriscool@tuxfamily.org>
References: <20190625134039.21707-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As fetch_objects() is now used only in promisor-remote.c
and should't be used outside it, let's move it into
promisor-remote.c, make it static there, and remove
fetch-object.{c,h}.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile          |  1 -
 fetch-object.c    | 43 -------------------------------------------
 fetch-object.h    |  9 ---------
 promisor-remote.c | 40 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 39 insertions(+), 54 deletions(-)
 delete mode 100644 fetch-object.c
 delete mode 100644 fetch-object.h

diff --git a/Makefile b/Makefile
index 049bc8cfd4..9b0baa7239 100644
--- a/Makefile
+++ b/Makefile
@@ -880,7 +880,6 @@ LIB_OBJS += ewah/ewah_io.o
 LIB_OBJS += ewah/ewah_rlw.o
 LIB_OBJS += exec-cmd.o
 LIB_OBJS += fetch-negotiator.o
-LIB_OBJS += fetch-object.o
 LIB_OBJS += fetch-pack.o
 LIB_OBJS += fsck.o
 LIB_OBJS += fsmonitor.o
diff --git a/fetch-object.c b/fetch-object.c
deleted file mode 100644
index eac4d448ef..0000000000
--- a/fetch-object.c
+++ /dev/null
@@ -1,43 +0,0 @@
-#include "cache.h"
-#include "packfile.h"
-#include "pkt-line.h"
-#include "strbuf.h"
-#include "transport.h"
-#include "fetch-object.h"
-
-static int fetch_refs(const char *remote_name, struct ref *ref)
-{
-	struct remote *remote;
-	struct transport *transport;
-	int original_fetch_if_missing = fetch_if_missing;
-	int res;
-
-	fetch_if_missing = 0;
-	remote = remote_get(remote_name);
-	if (!remote->url[0])
-		die(_("Remote with no URL"));
-	transport = transport_get(remote, remote->url[0]);
-
-	transport_set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
-	transport_set_option(transport, TRANS_OPT_NO_DEPENDENTS, "1");
-	res = transport_fetch_refs(transport, ref);
-	fetch_if_missing = original_fetch_if_missing;
-
-	return res;
-}
-
-int fetch_objects(const char *remote_name, const struct object_id *oids,
-		  int oid_nr)
-{
-	struct ref *ref = NULL;
-	int i;
-
-	for (i = 0; i < oid_nr; i++) {
-		struct ref *new_ref = alloc_ref(oid_to_hex(&oids[i]));
-		oidcpy(&new_ref->old_oid, &oids[i]);
-		new_ref->exact_oid = 1;
-		new_ref->next = ref;
-		ref = new_ref;
-	}
-	return fetch_refs(remote_name, ref);
-}
diff --git a/fetch-object.h b/fetch-object.h
deleted file mode 100644
index 7bcc7cadb0..0000000000
--- a/fetch-object.h
+++ /dev/null
@@ -1,9 +0,0 @@
-#ifndef FETCH_OBJECT_H
-#define FETCH_OBJECT_H
-
-struct object_id;
-
-int fetch_objects(const char *remote_name, const struct object_id *oids,
-		  int oid_nr);
-
-#endif
diff --git a/promisor-remote.c b/promisor-remote.c
index 826890f7b8..92c4c12c1c 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -2,7 +2,45 @@
 #include "object-store.h"
 #include "promisor-remote.h"
 #include "config.h"
-#include "fetch-object.h"
+#include "transport.h"
+
+static int fetch_refs(const char *remote_name, struct ref *ref)
+{
+	struct remote *remote;
+	struct transport *transport;
+	int original_fetch_if_missing = fetch_if_missing;
+	int res;
+
+	fetch_if_missing = 0;
+	remote = remote_get(remote_name);
+	if (!remote->url[0])
+		die(_("Remote with no URL"));
+	transport = transport_get(remote, remote->url[0]);
+
+	transport_set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
+	transport_set_option(transport, TRANS_OPT_NO_DEPENDENTS, "1");
+	res = transport_fetch_refs(transport, ref);
+	fetch_if_missing = original_fetch_if_missing;
+
+	return res;
+}
+
+static int fetch_objects(const char *remote_name,
+			 const struct object_id *oids,
+			 int oid_nr)
+{
+	struct ref *ref = NULL;
+	int i;
+
+	for (i = 0; i < oid_nr; i++) {
+		struct ref *new_ref = alloc_ref(oid_to_hex(&oids[i]));
+		oidcpy(&new_ref->old_oid, &oids[i]);
+		new_ref->exact_oid = 1;
+		new_ref->next = ref;
+		ref = new_ref;
+	}
+	return fetch_refs(remote_name, ref);
+}
 
 static struct promisor_remote *promisors;
 static struct promisor_remote **promisors_tail = &promisors;
-- 
2.22.0.229.ga13d9ffdf7.dirty

