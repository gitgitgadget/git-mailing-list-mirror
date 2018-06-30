Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3056C1F516
	for <e@80x24.org>; Sat, 30 Jun 2018 09:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935021AbeF3JJu (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 05:09:50 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33518 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934961AbeF3JIv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 05:08:51 -0400
Received: by mail-lf0-f68.google.com with SMTP id u14-v6so3419890lfu.0
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 02:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x4vpeurzresshyx+x5NGij2RJxvhWCOLl3rht7U20rw=;
        b=IGlmPR/Gi5UaytuuQJU7SPBivGdR2Zo+r7y4YrEymnD5MPKD1urAkqY+1OK1LEEwXT
         NR9rVJzQ44tyacc+aA+VXWMsjNUemg7bBcKCAYZ5t5Uv0szXrYmYtJ0ehr3+j7R3BkTS
         DsmwqprNuI9+qfMWqdWxhXBVxcQR1vS39QAb8KuiDOGqD+/kBNQDdoEAY7qZy9+Rh/sf
         7phNV1FmOm8oM0PcK9zdG09Qw3eD3PbPnSdtSQ+5YX37DUc0aOjTzuo9q3nUqeFV88BS
         +Lo1UPiFv98wRnv/G+HVgMj1a+avrQyUXuY8C2N+M/AnQ/BmjY3ImIYlh4MoPykF38uZ
         Ww5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x4vpeurzresshyx+x5NGij2RJxvhWCOLl3rht7U20rw=;
        b=Uimj0gZaN3WHzTEJGFtnYpWTUUL2K8rxKVIbEblGbuq0cS3Aejk08tEcJs/QAVtWOk
         ZGXlmLj0LVqvf3qXpUZ4Tfnt6eXv01Q1PjcgraOoOxOpcZq7SFt/nTsGOqN8KsPJWRS9
         3mkeRyLjzBuoPOMYQwPmKQ0GSo+QVMEEWGF4O6tnTirLs9x8vDs/nF8vqMFJHPcT+7gX
         HTY6mmMi6woazSoeFh4prc3v6JOI3qx0u9H3kTSPnvtaUrECsvOV178NIvece5jFzV0i
         PYizYoxMgBJFARiA6M983ilifvwGpPunRK/iUXj3kuUVumfq/HKmM2YasvcgBwkd+xum
         jz+A==
X-Gm-Message-State: APt69E1GXuqCS0/IB6Im7k6uRRUpR19fn0x++m7ylGBLVeZEJNSlBhqg
        ZGs/jq7NyYiznJScEA2NJXSzgQ==
X-Google-Smtp-Source: AAOMgpcuUrn7xTcXKw52sPiKBN3Lt7nDV0ZgDlia85hQrsz3+9fBmA/5OurxbIOTYB7CPN+Fk62qOQ==
X-Received: by 2002:a19:7d84:: with SMTP id y126-v6mr11290309lfc.94.1530349730152;
        Sat, 30 Jun 2018 02:08:50 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id q5-v6sm1831508ljq.33.2018.06.30.02.08.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 02:08:48 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 22/23] transport.c: mark more strings for translation
Date:   Sat, 30 Jun 2018 11:08:17 +0200
Message-Id: <20180630090818.28937-23-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180630090818.28937-1-pclouds@gmail.com>
References: <20180630090818.28937-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 transport.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/transport.c b/transport.c
index 2f6a7cb4cd..516a83b7f6 100644
--- a/transport.c
+++ b/transport.c
@@ -139,7 +139,7 @@ static struct ref *get_refs_from_bundle(struct transport *transport,
 		close(data->fd);
 	data->fd = read_bundle_header(transport->url, &data->header);
 	if (data->fd < 0)
-		die("could not read bundle '%s'.", transport->url);
+		die(_("could not read bundle '%s'"), transport->url);
 	for (i = 0; i < data->header.references.nr; i++) {
 		struct ref_list_entry *e = data->header.references.list + i;
 		struct ref *ref = alloc_ref(e->name);
@@ -654,7 +654,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 
 	switch (data->version) {
 	case protocol_v2:
-		die("support for protocol v2 not implemented yet");
+		die(_("support for protocol v2 not implemented yet"));
 		break;
 	case protocol_v1:
 	case protocol_v0:
@@ -780,7 +780,7 @@ static enum protocol_allow_config parse_protocol_config(const char *key,
 	else if (!strcasecmp(value, "user"))
 		return PROTOCOL_ALLOW_USER_ONLY;
 
-	die("unknown value for config '%s': %s", key, value);
+	die(_("unknown value for config '%s': %s"), key, value);
 }
 
 static enum protocol_allow_config get_protocol_config(const char *type)
@@ -846,7 +846,7 @@ int is_transport_allowed(const char *type, int from_user)
 void transport_check_allowed(const char *type)
 {
 	if (!is_transport_allowed(type, -1))
-		die("transport '%s' not allowed", type);
+		die(_("transport '%s' not allowed"), type);
 }
 
 static struct transport_vtable bundle_vtable = {
@@ -898,7 +898,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	if (helper) {
 		transport_helper_init(ret, helper);
 	} else if (starts_with(url, "rsync:")) {
-		die("git-over-rsync is no longer supported");
+		die(_("git-over-rsync is no longer supported"));
 	} else if (url_is_local_not_ssh(url) && is_file(url) && is_bundle(url, 1)) {
 		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
 		transport_check_allowed("file");
@@ -1143,7 +1143,7 @@ int transport_push(struct transport *transport,
 						      transport->push_options,
 						      pretend)) {
 				oid_array_clear(&commits);
-				die("failed to push all needed submodules!");
+				die(_("failed to push all needed submodules"));
 			}
 			oid_array_clear(&commits);
 		}
@@ -1265,7 +1265,7 @@ int transport_connect(struct transport *transport, const char *name,
 	if (transport->vtable->connect)
 		return transport->vtable->connect(transport, name, exec, fd);
 	else
-		die("operation not supported by protocol");
+		die(_("operation not supported by protocol"));
 }
 
 int transport_disconnect(struct transport *transport)
@@ -1347,7 +1347,7 @@ static void read_alternate_refs(const char *path,
 
 		if (get_oid_hex(line.buf, &oid) ||
 		    line.buf[GIT_SHA1_HEXSZ] != ' ') {
-			warning("invalid line while parsing alternate refs: %s",
+			warning(_("invalid line while parsing alternate refs: %s"),
 				line.buf);
 			break;
 		}
-- 
2.18.0.rc2.476.g39500d3211

