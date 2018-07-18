Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C05E51F597
	for <e@80x24.org>; Wed, 18 Jul 2018 16:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731739AbeGRQvw (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 12:51:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43407 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730897AbeGRQvv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 12:51:51 -0400
Received: by mail-lj1-f196.google.com with SMTP id r13-v6so4595566ljg.10
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 09:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Hphiudg0/hIiCxvgg5BNB/n7TOBILXYAYs1Ebnbq5k=;
        b=u9NBT3kuyxEy+W/Pw54EIxBqSX0YRgB8NSpFNgs+vnIIckkMyIKEzXolbkcCq4+LJw
         4Kmagjl9RDmC963gvxOzifEuMlJvPIlPADwc4k2zJZFRRyy9mWmRgrJYKlTdmdz4siHG
         tFCskV8FwPlFddnTig3lU3RW0xuDRIk9aSGf5sa7vBm2tj6AhJHynvCNOg8guSlNsVVj
         XQhMQmLtrtzqJt3XlKIpTrfkjtR7Ry2mQkE6YmkSDaC9XFX0ofWJbjGLUkSismlakbAf
         zkYc/2NoC+pLGU4lYzloMjIB86PhvItMRf6w0j78OU1xOyx9w2T1m9oCeYIsn6ik5sMj
         dmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Hphiudg0/hIiCxvgg5BNB/n7TOBILXYAYs1Ebnbq5k=;
        b=F21/O1tP0vBaru4viYZLu6PvmWsYyFTr6VckAn9OJGijULXoyOkt8IjivekprqXo3k
         zjbblV9QNEm+c+HLG4qE7SQOC0MDXqydANcZP5JAkSiXbcTcUTVry3hIyj39HD/XrjrM
         xAGCvZ6TpByZFOs4rUp8bLEMEDcSABi9o6ndtVaTrl8bamHpL+HGkgJM5qb9WNSGvJXU
         CqtPUPkgpyak/hhXbGRF7spXe0SaofBVJ8rTPZMLX50ivIjv6W6x9qaAmByKAgg1+zPc
         Kf5WMdjqqKZb4HT09ZvaP1eB1CAJBAA9H+RBGz04xF9DVx2sZ2ZqfBtllWM/D2W7mpX2
         e7tg==
X-Gm-Message-State: AOUpUlHJVVquVDnllVUOO29XTdVH39L9zNkikVroI/svv27nwnkL/Ayk
        hPVOBkgLySj9EATKCM72jnsdRw==
X-Google-Smtp-Source: AAOMgpdtCsnlVSxgSudayWKum7ljXJvLKX0YaqHsXcrLfAouetzZ8r7lgKgMl6a55PLIaqzb0lekwA==
X-Received: by 2002:a2e:3313:: with SMTP id d19-v6mr4913586ljc.25.1531930392665;
        Wed, 18 Jul 2018 09:13:12 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j26-v6sm689203ljc.54.2018.07.18.09.13.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 09:13:11 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 22/23] transport.c: mark more strings for translation
Date:   Wed, 18 Jul 2018 18:11:00 +0200
Message-Id: <20180718161101.19765-23-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180718161101.19765-1-pclouds@gmail.com>
References: <20180718161101.19765-1-pclouds@gmail.com>
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
index 9fcc33915a..516a83b7f6 100644
--- a/transport.c
+++ b/transport.c
@@ -139,7 +139,7 @@ static struct ref *get_refs_from_bundle(struct transport *transport,
 		close(data->fd);
 	data->fd = read_bundle_header(transport->url, &data->header);
 	if (data->fd < 0)
-		die("could not read bundle '%s'", transport->url);
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

