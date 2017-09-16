Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AB0C20A21
	for <e@80x24.org>; Sat, 16 Sep 2017 08:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbdIPIIY (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:08:24 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35989 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbdIPIIU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:08:20 -0400
Received: by mail-wm0-f67.google.com with SMTP id r136so4498980wmf.3
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kwh80uEmdQsvkUOQndEyw6Nq/iswdZKZo2oUgPaP5uQ=;
        b=lhsa8RoZH4BmrRongHxtNWvlwvj+iFLebii8XQgWyIz3BzC4jAaC7MjSfewKaCxeqB
         4kIlYQFjBtn+b6T/gD8gX6qUYP/5ZEGIyUO1vZAnYu5BH4R2Xv2dgmFQQ7b4g9rWgVsS
         K4NgAlaeLQMMc2jFjJdhhu8Lbin0XgQ5xRfgzlzHygt1im/NxId706kKN9xuM2o0Lf/u
         /xB/Z1Rj1wavWQ/cfxvStRM87HuUAE87lfUTC/ENJ0cprGMleXhkM2Di5B9p64JIIJ4E
         MP710sLF9UkcN+blnx9235pbDcFlogdIsHwVyeZIftlNZt5ZFH6Q0fYXNeZaZv0iwO6V
         A74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kwh80uEmdQsvkUOQndEyw6Nq/iswdZKZo2oUgPaP5uQ=;
        b=dh3ukiudTNoCfrI3F9EBbOwcxNavsmHMNOXHzPZanaSXoKpQe3v3SmPSYmrcnJndKY
         4KKQ09Uwb4HCYZgsmwZ0CLAIZZfotcEDN6Uw93xsnxLrPf7v6klDSTiviuDHDA10oSEF
         M0gZUJwf2ROMAnqaHK4I08NkqfeaJqPJyqaEUXJ9Tyjrr2ksYewbeDMrDJU1IxGP7ova
         J9K59i8bPBYhdw63AzFCt78LAzEKU/gopG7E9zfbc/SZo/otrMRbpKaCQrzUyzKNsirj
         h7bFiAZf/kd3rhxhN5ocXPEwKP64SfIK/i14NjzpjNtl9smGP4TVklo6hn+FzEUIwr7p
         7Vug==
X-Gm-Message-State: AHPjjUjz/y7rg3QZoZ7MiiMm+zGRwb+iYnW1Zx36kwFmsyl1h8TDZbcZ
        LrE2bEhuvudEQM5bpZauASE5QQ==
X-Google-Smtp-Source: AOwi7QDnUH7RAtIWPYwL3CiMOHRBjcRwaqmapRgpdDHCYQP4gGj2AMVOoDmVM9kGal08dhVPI0wddg==
X-Received: by 10.28.64.6 with SMTP id n6mr4866732wma.61.1505549298541;
        Sat, 16 Sep 2017 01:08:18 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.08.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:08:17 -0700 (PDT)
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
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 25/40] odb-helper: add 'script_mode' to 'struct odb_helper'
Date:   Sat, 16 Sep 2017 10:07:16 +0200
Message-Id: <20170916080731.13925-26-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
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
 external-odb.c |  8 +++++++-
 odb-helper.c   | 19 ++++++++++++++-----
 odb-helper.h   |  1 +
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/external-odb.c b/external-odb.c
index 31d21bfe04..ccca67eff5 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -32,8 +32,14 @@ static int external_odb_config(const char *var, const char *value, void *data)
 
 	o = find_or_create_helper(name, namelen);
 
-	if (!strcmp(subkey, "scriptcommand"))
+	if (!strcmp(subkey, "scriptcommand")) {
+		o->script_mode = 1;
 		return git_config_string(&o->cmd, var, value);
+	}
+	if (!strcmp(subkey, "subprocesscommand")) {
+		o->script_mode = 0;
+		return git_config_string(&o->cmd, var, value);
+	}
 
 	return 0;
 }
diff --git a/odb-helper.c b/odb-helper.c
index 3d940a3171..22728200e3 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -123,6 +123,9 @@ int odb_helper_init(struct odb_helper *o)
 	FILE *fh;
 	struct strbuf line = STRBUF_INIT;
 
+	if (!o->script_mode)
+		return 0;
+
 	if (odb_helper_start(o, &cmd, 0, "init") < 0)
 		return -1;
 
@@ -173,16 +176,12 @@ static int odb_helper_object_cmp(const void *va, const void *vb)
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
 
@@ -194,6 +193,16 @@ static void odb_helper_load_have(struct odb_helper *o)
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
+	if (o->script_mode)
+		have_object_script(o);
 
 	qsort(o->have, o->have_nr, sizeof(*o->have), odb_helper_object_cmp);
 }
diff --git a/odb-helper.h b/odb-helper.h
index fbb6d333ee..ee2b09b182 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -15,6 +15,7 @@ struct odb_helper {
 	const char *name;
 	const char *cmd;
 	unsigned int supported_capabilities;
+	int script_mode;
 
 	struct odb_helper_object {
 		unsigned char sha1[20];
-- 
2.14.1.576.g3f707d88cd

