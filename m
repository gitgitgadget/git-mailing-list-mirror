Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93DD91F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbeACQfP (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:35:15 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38495 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbeACQfK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:35:10 -0500
Received: by mail-wm0-f66.google.com with SMTP id 64so3639048wme.3
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GRvUElo1ucLbpJiwS91seGIL8gc0qQKP9TR7Nkv8KRQ=;
        b=iq2JG0m6ljMjACfPffnJ4/lLDxvCxu1HNbmgep0j9T95d1EAkzxM1rfzbOa2mXMXJ2
         yznGXfRuLblWWbYkhvbKn5tjQrMLtp1oVvbFVegjvT83bgbzaCHFyKsjT6UBKLaCdSHX
         oUQj0yFfh0PQSTI1QYUfSmyMLmwmVmmD8BvTT+5TaP4Ho04EamC5an1nPQ2tGw0tz5YY
         msLnaMxvMoplxlar2U1ZNyTWnWdpBU4eryes3l2jkoBP8Z9QgjU6ZcQT/0j11vq319VY
         CmuGHOQFZjvznxyK/w5rTQgvmnxdzPI/0VuBz8NWYGzu275kxhOoTLfrL94qeBRwItsv
         Iw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GRvUElo1ucLbpJiwS91seGIL8gc0qQKP9TR7Nkv8KRQ=;
        b=Ca3RUdQhwlfpNi9FEjYyvVVip1S8qsK5v48Xqghb5jzrAEUwU3sw7F9vZb6P2fetiz
         qjAgfh0XsboWI6c9oGScK8oqPZKIGf1AYJQy7UBVTMEh+oNcCdO5tTcRn88DCcQ4+u9J
         WCf5EuG5ZawLPOUUsuSmzeFtC0tf8XxMy+bBXvThvcwCMN2Ql1zG5Vm0o7z2Pw4ctNZX
         hU79iynmkNUeXHFp14WSPqR3zvGsOoQXHvwVkEgjjSp+TWxyh0XLYk7R1WcdANQSB0wY
         9ruCpAO+FvrIpsxybrBtlb0s5KsEjuOihYMgv0ZPvsK5k6xjTk/Y7NygWxDq0gRXgbRG
         VU5w==
X-Gm-Message-State: AKGB3mKBx/P696gh+PJsI9NE11du1vEuG1YCMjLfqkRQUazpnbjyThlq
        xtXAhGIwSvgq3lbQsSJP4kX5l/tb
X-Google-Smtp-Source: ACJfBovkZE0/Fa3XD0RP/zKVZzwQU3NukdN3JpGuXCiZdB48bCl5pLnupBh2vmm0MPDNBFnCGpVgUg==
X-Received: by 10.28.62.20 with SMTP id l20mr1971863wma.6.1514997308586;
        Wed, 03 Jan 2018 08:35:08 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:35:07 -0800 (PST)
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
Subject: [PATCH 31/40] odb-helper: add 'script_mode' to 'struct odb_helper'
Date:   Wed,  3 Jan 2018 17:33:54 +0100
Message-Id: <20180103163403.11303-32-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

to prepare for having a long running odb helper sub-process
handling the communication between Git and an external odb.

We introduce "odb.<name>.subprocesscommand" to make it
possible to define such a sub-process, and we mark such odb
helpers with the new 'script_mode' field set to 0.

Helpers defined using the existing "odb.<name>.scriptcommand"
are marked with the 'script_mode' field set to 1.

Implementation of the different capabilities/instructions in
the new (sub-)process mode is left for following commits.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c |  4 ++++
 odb-helper.c   | 19 ++++++++++++++-----
 odb-helper.h   |  2 +-
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/external-odb.c b/external-odb.c
index 3ce3d111f3..f38c2c2fe3 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -43,6 +43,10 @@ static int external_odb_config(const char *var, const char *value, void *data)
 		o->type = ODB_HELPER_SCRIPT_CMD;
 		return git_config_string(&o->dealer, var, value);
 	}
+	if (!strcmp(subkey, "subprocesscommand")) {
+		o->type = ODB_HELPER_SUBPROCESS_CMD;
+		return git_config_string(&o->dealer, var, value);
+	}
 
 	return 0;
 }
diff --git a/odb-helper.c b/odb-helper.c
index 0fa7af0348..91b4de1a05 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -124,6 +124,9 @@ int odb_helper_init(struct odb_helper *o)
 	FILE *fh;
 	struct strbuf line = STRBUF_INIT;
 
+	if (o->type != ODB_HELPER_SCRIPT_CMD)
+		return 0;
+
 	if (odb_helper_start(o, &cmd, 0, "init") < 0)
 		return -1;
 
@@ -174,16 +177,12 @@ static int odb_helper_object_cmp(const void *va, const void *vb)
 	return hashcmp(a->sha1, b->sha1);
 }
 
-static void odb_helper_load_have(struct odb_helper *o)
+static void have_object_script(struct odb_helper *o)
 {
 	struct odb_helper_cmd cmd;
 	FILE *fh;
 	struct strbuf line = STRBUF_INIT;
 
-	if (o->have_valid)
-		return;
-	o->have_valid = 1;
-
 	if (odb_helper_start(o, &cmd, 0, "have") < 0)
 		return;
 
@@ -195,6 +194,16 @@ static void odb_helper_load_have(struct odb_helper *o)
 	strbuf_release(&line);
 	fclose(fh);
 	odb_helper_finish(o, &cmd);
+}
+
+static void odb_helper_load_have(struct odb_helper *o)
+{
+	if (o->have_valid)
+		return;
+	o->have_valid = 1;
+
+	if (o->type == ODB_HELPER_SCRIPT_CMD)
+		have_object_script(o);
 
 	qsort(o->have, o->have_nr, sizeof(*o->have), odb_helper_object_cmp);
 }
diff --git a/odb-helper.h b/odb-helper.h
index 4a9cc7f07b..9a33adbf0b 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -7,7 +7,7 @@ enum odb_helper_type {
 	ODB_HELPER_NONE = 0,
 	ODB_HELPER_GIT_REMOTE,
 	ODB_HELPER_SCRIPT_CMD,
-	ODB_HELPER_PROCESS_CMD,
+	ODB_HELPER_SUBPROCESS_CMD,
 	OBJ_HELPER_MAX
 };
 
-- 
2.16.0.rc0.16.g82191dbc6c.dirty

