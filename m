Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF1461F404
	for <e@80x24.org>; Mon, 19 Mar 2018 13:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933400AbeCSNeW (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:34:22 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34422 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755538AbeCSNcX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:23 -0400
Received: by mail-wr0-f196.google.com with SMTP id o8so18664736wra.1
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+KTVFjO2uroblZOlka9oEVuGBNAwHHXlLps2M+Ajnn4=;
        b=E5HA3RlmKxQ6LNecq49lVkOuV0NkiY1wgLaEPVmmjxFZMvBWP1pIXbO6BafN4wjhm/
         9TXPK3B/Am2ODbCeKAOK/o6Pp5ctyEEZiXtMt22x5A0t5ADMVEjQ5y5wGOSkW/pFGsMD
         NaaMGN3k9oa/Upn4WOnyHDvQaplpEoEtdpjo8UCMv7wSkFrAk6jXs+LVFEVhWcctXH8n
         FyXZz9wPjEYpaOhIEwzOztZXbpIT11pvO2oJDBmqYrMY0eONHrHeXat0h2Xt4aoMRQo4
         bcsiCXOxtoQlKdWsfJQqjRVvLGeZLhrJoqNH6DE/+NDV+Rkz1gUHja15wlt0960wupjr
         SNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+KTVFjO2uroblZOlka9oEVuGBNAwHHXlLps2M+Ajnn4=;
        b=mV2y8M4mvHFXBae7QvV4OnI/bQik4YWhzAbrymmL+o7+FXiegOTJUvFwrP3GKHOd1z
         TH4Ln/1RW353Bcnj9zAQ8U282XoDYqo0XbY00oykG2ybRmfCmQ87/ufwXxrbYWz9cGsP
         tLtBCmhyDyRf5P32WBh6//7UUbbvJGV7Ns2ycPliR6JNtf8pgHZfknn/rw2jksnaJpC9
         4JFIs795MK0F5/FnDd/DK6M0GkooRi0KOwilBmwMrf7m77kCFKMOXZqL2blL49RIUf6w
         PW5NNqr9cIZQzHhrU1bFB2R+vIW5zhFJFOAfvPQBSlbNHSKi+iEqfeiRdCkVzIR+KJ3L
         zZ1A==
X-Gm-Message-State: AElRT7GflYJPWzTU06iBjN8bbvSMiASupKy4TKFac5QuF1JE3bSauirK
        noR52nVktijm0Je5/ayMVeoVihkL
X-Google-Smtp-Source: AG47ELv66FFhAw5v9h3z/R8mKl74FIDW98e/wuEVbg4JHHXiUj34LWsQBw1qUxclGwfKCFh4gwRapg==
X-Received: by 10.223.152.141 with SMTP id w13mr9820423wrb.12.1521466342288;
        Mon, 19 Mar 2018 06:32:22 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:21 -0700 (PDT)
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
Subject: [PATCH v2 10/36] odb-helper: add 'script_mode' to 'struct odb_helper'
Date:   Mon, 19 Mar 2018 14:31:21 +0100
Message-Id: <20180319133147.15413-11-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
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
 odb-helper.c   | 16 +++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/external-odb.c b/external-odb.c
index ec1ec82dd9..9f797d66f4 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -41,6 +41,10 @@ static int external_odb_config(const char *var, const char *value, void *data)
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
index 677ea850a5..bf3c1ad8ac 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -116,16 +116,12 @@ static int odb_helper_object_cmp(const void *va, const void *vb)
 	return oidcmp(&a->oid, &b->oid);
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
 	if (odb_helper_start(o, &cmd, "have") < 0)
 		return;
 
@@ -137,6 +133,16 @@ static void odb_helper_load_have(struct odb_helper *o)
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
-- 
2.17.0.rc0.37.g8f476fabe9

