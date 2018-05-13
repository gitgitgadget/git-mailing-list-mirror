Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DE1F1F42D
	for <e@80x24.org>; Sun, 13 May 2018 10:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751264AbeEMKdB (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 06:33:01 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35721 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeEMKc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 06:32:58 -0400
Received: by mail-wr0-f196.google.com with SMTP id i14-v6so9332006wre.2
        for <git@vger.kernel.org>; Sun, 13 May 2018 03:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H4a7CajNoBAV6IEdv6rpwvtR0xvavvb9T30wDJ0HDII=;
        b=UZQeZA2QDn2snQ5wSYVxtO9AX8TbdtFdtp+2wz7NcmOUBt0SI71v5C4THVUPEKKvFC
         WTQ7VOsn9EpnlHERdOOvpT3aW6cjUI9R3GmHpgE0H9iag75MbemLSCKJ9FTjmrL0EnpS
         euKpw7o6eQF3rT2zcDFXi2lc11941gnwcSnwBuTnMugh6qX579pYCCP5M/M9xNypQ7sD
         hwRqIvPnjNtl5CC0snsONG0DjyphWEgDOkOuqu07O+JRqtn9Z03rjg97+DhfXQXSIo2p
         5hg8QHthN5LdvLLYiPysYbC1q58HPPYSpzcoiTiKI4RaYvSGCaVpWkiD3gaf4He5gjdH
         lvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H4a7CajNoBAV6IEdv6rpwvtR0xvavvb9T30wDJ0HDII=;
        b=SMwsoUqPe4/MFcvTapSP8uv0Dwb/duA6DHGzKxOt5WpqlBxgmjfkTB2xwdDlvM61RJ
         oSZPw9dhZb6fQPAofE93VnRiVkCfFR/aJBrLL4/y7UVIqqDFrGzVMGVDkU84GB3zKVNa
         3b6yVpfeD7xgsMGXuqMfPkmfk74yABBLHTLYbR6YRvO9pg6+HScYIP0a3onNOlKTuR8B
         Xl1u0FTSOmUPz7XGjJgftXHbYfJO8gbRZRBuaNCPbTQ96jVX15jAlvM/+Zef+QYQJfOB
         zEoVgxLjMntfwYIJzRDJWWK2I/fHrQmzFD96LVVnhqhRX/hxBxVr6q7BK96RTv+DoAS6
         yV4w==
X-Gm-Message-State: ALKqPwdgJCJ8/MZPn1Tm5lo7cOyGjaQa3m9t429Rmjdxlse7hLekaKyq
        NDKHalUh4TF7z2S1LZg2PpIrlgsq
X-Google-Smtp-Source: AB8JxZqKOh3dPINt72pMUC1D9+A9xdjwsu5obszXufHeChT44FRs4wFnmjePhFs8D0XKlih3R1KlJQ==
X-Received: by 2002:adf:e642:: with SMTP id b2-v6mr3755138wrn.172.1526207576477;
        Sun, 13 May 2018 03:32:56 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id t203-v6sm6886375wmt.33.2018.05.13.03.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 May 2018 03:32:55 -0700 (PDT)
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
Subject: [PATCH v1 2/8] Add initial odb remote support
Date:   Sun, 13 May 2018 12:32:26 +0200
Message-Id: <20180513103232.17514-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.590.gbd05bfcafd
In-Reply-To: <20180513103232.17514-1-chriscool@tuxfamily.org>
References: <20180513103232.17514-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The odb-remote.{c,h} files will contain the functions
that are called by the rest of Git mostly from
"sha1_file.c" to access the objects managed by the
odb remotes.

The odb-helper.{c,h} files will contain the functions to
actually implement communication with either the internal
functions or the external scripts or processes that will
manage and provide remote git objects.

For now only infrastructure to create helpers from the
config and to check if there are odb remotes and helpers
is implemented.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile     |  2 ++
 odb-helper.c | 16 ++++++++++++
 odb-helper.h | 13 ++++++++++
 odb-remote.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 odb-remote.h |  7 +++++
 5 files changed, 110 insertions(+)
 create mode 100644 odb-helper.c
 create mode 100644 odb-helper.h
 create mode 100644 odb-remote.c
 create mode 100644 odb-remote.h

diff --git a/Makefile b/Makefile
index ad880d1fc5..f64dea287b 100644
--- a/Makefile
+++ b/Makefile
@@ -896,6 +896,8 @@ LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
 LIB_OBJS += object.o
+LIB_OBJS += odb-helper.o
+LIB_OBJS += odb-remote.o
 LIB_OBJS += oidmap.o
 LIB_OBJS += oidset.o
 LIB_OBJS += packfile.o
diff --git a/odb-helper.c b/odb-helper.c
new file mode 100644
index 0000000000..b4d403ffa9
--- /dev/null
+++ b/odb-helper.c
@@ -0,0 +1,16 @@
+#include "cache.h"
+#include "object.h"
+#include "argv-array.h"
+#include "odb-helper.h"
+#include "run-command.h"
+#include "sha1-lookup.h"
+
+struct odb_helper *odb_helper_new(const char *name, int namelen)
+{
+	struct odb_helper *o;
+
+	o = xcalloc(1, sizeof(*o));
+	o->name = xmemdupz(name, namelen);
+
+	return o;
+}
diff --git a/odb-helper.h b/odb-helper.h
new file mode 100644
index 0000000000..61d2ad082b
--- /dev/null
+++ b/odb-helper.h
@@ -0,0 +1,13 @@
+#ifndef ODB_HELPER_H
+#define ODB_HELPER_H
+
+struct odb_helper {
+	const char *name;
+	const char *dealer;
+
+	struct odb_helper *next;
+};
+
+extern struct odb_helper *odb_helper_new(const char *name, int namelen);
+
+#endif /* ODB_HELPER_H */
diff --git a/odb-remote.c b/odb-remote.c
new file mode 100644
index 0000000000..e03b953ec6
--- /dev/null
+++ b/odb-remote.c
@@ -0,0 +1,72 @@
+#include "cache.h"
+#include "odb-remote.h"
+#include "odb-helper.h"
+#include "config.h"
+
+static struct odb_helper *helpers;
+static struct odb_helper **helpers_tail = &helpers;
+
+static struct odb_helper *find_or_create_helper(const char *name, int len)
+{
+	struct odb_helper *o;
+
+	for (o = helpers; o; o = o->next)
+		if (!strncmp(o->name, name, len) && !o->name[len])
+			return o;
+
+	o = odb_helper_new(name, len);
+	*helpers_tail = o;
+	helpers_tail = &o->next;
+
+	return o;
+}
+
+static int odb_remote_config(const char *var, const char *value, void *data)
+{
+	struct odb_helper *o;
+	const char *name;
+	int namelen;
+	const char *subkey;
+
+	if (parse_config_key(var, "odb", &name, &namelen, &subkey) < 0)
+		return 0;
+
+	o = find_or_create_helper(name, namelen);
+
+	if (!strcmp(subkey, "promisorremote"))
+		return git_config_string(&o->dealer, var, value);
+
+	return 0;
+}
+
+static void odb_remote_init(void)
+{
+	static int initialized;
+
+	if (initialized)
+		return;
+	initialized = 1;
+
+	git_config(odb_remote_config, NULL);
+}
+
+struct odb_helper *find_odb_helper(const char *dealer)
+{
+	struct odb_helper *o;
+
+	odb_remote_init();
+
+	if (!dealer)
+		return helpers;
+
+	for (o = helpers; o; o = o->next)
+		if (!strcmp(o->dealer, dealer))
+			return o;
+
+	return NULL;
+}
+
+int has_odb_remote(void)
+{
+	return !!find_odb_helper(NULL);
+}
diff --git a/odb-remote.h b/odb-remote.h
new file mode 100644
index 0000000000..68aa330244
--- /dev/null
+++ b/odb-remote.h
@@ -0,0 +1,7 @@
+#ifndef ODB_REMOTE_H
+#define ODB_REMOTE_H
+
+extern struct odb_helper *find_odb_helper(const char *dealer);
+extern int has_odb_remote(void);
+
+#endif /* ODB_REMOTE_H */
-- 
2.17.0.590.gbd05bfcafd

