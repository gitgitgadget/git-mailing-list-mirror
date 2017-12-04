Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DFD720954
	for <e@80x24.org>; Mon,  4 Dec 2017 23:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752155AbdLDX7j (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 18:59:39 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42555 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbdLDX7X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 18:59:23 -0500
Received: by mail-pg0-f66.google.com with SMTP id e14so9384781pgr.9
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 15:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R+8+7RuZTObIJ4hK8MTm9iSFTWtWcTQI48AEPE8N+Ok=;
        b=Tu0xVIaMN3GH+5NM7WzU1wSjO8uTpVzPilnJtug00zCoH4YZA7I26he3QjnErFpxpC
         axGMmz20TvREk0S9qb+vgnVKcb4dNpjpIbXJkUh95fwTtJgdL4jqhmxo4N/elZJXNbpz
         C9uu33EEInLLOxYXG5wfX7DlioHCpOVRuBwQfMWLk0FxNufo3G4UdCsMnVS/UEDEafWR
         5ntlZuSqFGVR2GNFeppHMxkgAny2rcr+X9Fdta+oIPav7W8/BL5Z/oX6nCWMRw0i/oZM
         GEZS5meByTqBp2dbKHLBEeXQSqYq6X+EE/OyTeP094glWomfvtzaErT2ygiMzA2qAZWq
         U+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R+8+7RuZTObIJ4hK8MTm9iSFTWtWcTQI48AEPE8N+Ok=;
        b=JmoIpfgKSj5qDQcAZJ6e2DdMN6vPnMz+EkVS+j/J2YxPOyhL0Cu8hKnutflU0xmpQl
         VzAfNY8QVRZij6AwHDinLV46gF7+IH8XfUIdwlZFynvHm99OQ2a0hwOlskVMj3z8JzIc
         aKs3vdCj5jiCHLcW/IprA5S+3dZ7JemZsvwKU52P8x58dgWQJu4vIh4mdQ15t4VTnTwW
         sQBl+qXlyX8q0n4bLRThwAof8ePEqyRQJREgyCbrITXfeQbCSLiXXc6WRSwsyH046gdW
         pb5gLctLStYXpeQqD9WbN8gvaHbzdDeZLKl9lk0XEBe5dfocXtE7UupNGPT9tyTUOSgw
         iNVQ==
X-Gm-Message-State: AJaThX4qakZ9gvHQUEkvkfFOs9pZeVE/TC17iP0LycsdF0otIwH073Fh
        Q7FmCIQmERCRHiEIwZBC1HZ7DiQEQHI=
X-Google-Smtp-Source: AGs4zMZSt0aclYJmXqugKa5vzHF8XI6i9t8AfufY+BgTVTutqW9May81MX5yu9vfyDKg8NbycAMDJw==
X-Received: by 10.98.35.144 with SMTP id q16mr19369777pfj.13.1512431962652;
        Mon, 04 Dec 2017 15:59:22 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id b187sm24939223pfg.109.2017.12.04.15.59.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 15:59:21 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [WIP 12/15] ls-refs: introduce ls-refs server command
Date:   Mon,  4 Dec 2017 15:58:20 -0800
Message-Id: <20171204235823.63299-13-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081-goog
In-Reply-To: <20171204235823.63299-1-bmwill@google.com>
References: <20171020171839.4188-1-bmwill@google.com>
 <20171204235823.63299-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce the ls-refs server command.  In protocol v2, the ls-refs
command is used to request the ref advertisement from the server.  Since
it is a command which can be requested (as opposed to manditory in v1),
a clinet can sent a number of parameters in its request to limit the ref
advertisement based on provided ref-patterns.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Makefile  |  1 +
 ls-refs.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ls-refs.h |  9 ++++++
 serve.c   |  8 ++++++
 4 files changed, 114 insertions(+)
 create mode 100644 ls-refs.c
 create mode 100644 ls-refs.h

diff --git a/Makefile b/Makefile
index 710672cf4..be3c2f98b 100644
--- a/Makefile
+++ b/Makefile
@@ -807,6 +807,7 @@ LIB_OBJS += list-objects.o
 LIB_OBJS += ll-merge.o
 LIB_OBJS += lockfile.o
 LIB_OBJS += log-tree.o
+LIB_OBJS += ls-refs.o
 LIB_OBJS += mailinfo.o
 LIB_OBJS += mailmap.o
 LIB_OBJS += match-trees.o
diff --git a/ls-refs.c b/ls-refs.c
new file mode 100644
index 000000000..591dd105d
--- /dev/null
+++ b/ls-refs.c
@@ -0,0 +1,96 @@
+#include "cache.h"
+#include "repository.h"
+#include "refs.h"
+#include "remote.h"
+#include "argv-array.h"
+#include "ls-refs.h"
+#include "pkt-line.h"
+
+struct ls_refs_data {
+	unsigned peel;
+	unsigned symrefs;
+	struct argv_array patterns;
+};
+
+/*
+ * Is there one among the list of patterns that match the tail part
+ * of the path?
+ */
+static int tail_match(const char **pattern, const char *path)
+{
+	const char *p;
+	char *pathbuf;
+
+	if (!pattern)
+		return 1; /* no restriction */
+
+	pathbuf = xstrfmt("/%s", path);
+	while ((p = *(pattern++)) != NULL) {
+		if (!wildmatch(p, pathbuf, 0)) {
+			free(pathbuf);
+			return 1;
+		}
+	}
+	free(pathbuf);
+	return 0;
+}
+
+static int send_ref(const char *refname, const struct object_id *oid,
+		    int flag, void *cb_data)
+{
+	struct ls_refs_data *data = cb_data;
+	const char *refname_nons = strip_namespace(refname);
+	struct strbuf refline = STRBUF_INIT;
+
+	if (data->patterns.argc && !tail_match(data->patterns.argv, refname))
+		return 0;
+
+	strbuf_addf(&refline, "%s %s", oid_to_hex(oid), refname_nons);
+	if (data->symrefs && flag & REF_ISSYMREF) {
+		struct object_id unused;
+		const char *symref_target = resolve_ref_unsafe(refname, 0,
+							       unused.hash,
+							       &flag);
+
+		if (!symref_target)
+			die("'%s' is a symref but it is not?", refname);
+
+		strbuf_addf(&refline, " %s", symref_target);
+	}
+
+	strbuf_addch(&refline, '\n');
+
+	packet_write(1, refline.buf, refline.len);
+	if (data->peel) {
+		struct object_id peeled;
+		if (!peel_ref(refname, peeled.hash))
+			packet_write_fmt(1, "%s %s^{}\n", oid_to_hex(&peeled),
+					 refname_nons);
+	}
+
+	strbuf_release(&refline);
+	return 0;
+}
+
+int ls_refs(struct repository *r, struct argv_array *keys, struct argv_array *args)
+{
+	int i;
+	struct ls_refs_data data = { 0, 0, ARGV_ARRAY_INIT };
+
+	for (i = 0; i < args->argc; i++) {
+		if (!strcmp("--peeled", args->argv[i]))
+			data.peel = 1;
+		else if (!strcmp("--symrefs", args->argv[i]))
+			data.symrefs = 1;
+		else
+			/* Pattern */
+			argv_array_pushf(&data.patterns, "*/%s", args->argv[i]);
+
+	}
+
+	head_ref_namespaced(send_ref, &data);
+	for_each_namespaced_ref(send_ref, &data);
+	packet_flush(1);
+	argv_array_clear(&data.patterns);
+	return 0;
+}
diff --git a/ls-refs.h b/ls-refs.h
new file mode 100644
index 000000000..9e4c57bfe
--- /dev/null
+++ b/ls-refs.h
@@ -0,0 +1,9 @@
+#ifndef LS_REFS_H
+#define LS_REFS_H
+
+struct repository;
+struct argv_array;
+extern int ls_refs(struct repository *r, struct argv_array *keys,
+		   struct argv_array *args);
+
+#endif /* LS_REFS_H */
diff --git a/serve.c b/serve.c
index 476e73b54..36f77c365 100644
--- a/serve.c
+++ b/serve.c
@@ -4,8 +4,15 @@
 #include "pkt-line.h"
 #include "version.h"
 #include "argv-array.h"
+#include "ls-refs.h"
 #include "serve.h"
 
+static int always_advertise(struct repository *r,
+			    struct strbuf *value)
+{
+	return 1;
+}
+
 static int agent_advertise(struct repository *r,
 			   struct strbuf *value)
 {
@@ -26,6 +33,7 @@ struct protocol_capability {
 
 static struct protocol_capability capabilities[] = {
 	{ "agent", 0, agent_advertise, NULL },
+	{ "ls-refs", 0, always_advertise, ls_refs },
 };
 
 static void advertise_capabilities(void)
-- 
2.15.1.424.g9478a66081-goog

