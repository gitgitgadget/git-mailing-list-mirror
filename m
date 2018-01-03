Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBB451F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbeACQh0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:37:26 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44986 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbeACQeV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:34:21 -0500
Received: by mail-wr0-f194.google.com with SMTP id l41so2141183wre.11
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DhcpIuEWcwxYHIb7TrlE1HI2cYfrqZnQCPXYlbIX5SY=;
        b=Ve5wbMTaw92i+ijg4o2dgwSr4ibtVFp92Hj8DXd5+vPBbx3FwwFzvYlEtlIPywvoQG
         UNeklpsNEf1t8IntKGSoDyQT+dT89cV5XWOkjG6xv8AiGk7JxexY7uEwVqjqjno8vI1E
         cCDgkrcu6l8ze803BogjsicwauWUymAheTIegJPrd+xpGTzkoYGFBo+bJ+B+tb6P6HoY
         wtP6Ce4ABgUjJeGJjANHecYu/KAR0u6z2L32L5WEni7VmFilzpOAmwMGz+XUa0Wxc/VJ
         Xhp+VibEnNOrY0Uv8rpajA3EuMrRhqVMLNjYsRVpfv80kMbB6Hqruha3Ja0lxQrmaO1w
         Cvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DhcpIuEWcwxYHIb7TrlE1HI2cYfrqZnQCPXYlbIX5SY=;
        b=ss4OeGekompoMljjhESlNTZef2v1qGdY+87satCq9mQF3TBrKkmNinheKDKOtxyeGF
         BbyY1pyxzwV01lIGkqaQUJCdbgn0xVIgonmAnT5mL0sfNMIRMGb0cmnrLAYnhAcAB5vy
         ah1e+/hE8pl2pLkPYYpYtg81kogyns9rayGfiwLWR1ThtNLt1cwElHLtG+JG14zmOi7C
         T4ob16jpjQZhjMH376d1wnwyyVpfltcfODALfxvecnlAf5f7KX577NqfVogzccOA/AQl
         i99/oxB1qWag3NxrIubhtkiiHfvmbRlUmoZvNxEh0f9NZChK9hxkb6klusJoHzdpixxB
         gDyA==
X-Gm-Message-State: AKGB3mJnOTmFf0gQ0v+umxHnt8EkrFrfqgo9J4OM4rn/DBDYGiYK64FI
        ygzoYYqBeZ/XOLZ295u/ETgEa31H
X-Google-Smtp-Source: ACJfBovAIBb9XW0wIO4Viril1ymOsaHQJ8J65YZWGzvR0PwIRwqBTRvObuC1h0lVGJLEXT5Q6unv1Q==
X-Received: by 10.223.160.233 with SMTP id n38mr2149391wrn.45.1514997258515;
        Wed, 03 Jan 2018 08:34:18 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.34.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:34:17 -0800 (PST)
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
Subject: [PATCH 02/40] Add GIT_NO_EXTERNAL_ODB env variable
Date:   Wed,  3 Jan 2018 17:33:25 +0100
Message-Id: <20180103163403.11303-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new environment variable will be used to perform git
commands without involving any external odb mechanism.

This makes it possible for example to create new blobs that
will not be sent to an external odb even if the external odb
supports "put_*" instructions.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h        | 9 +++++++++
 environment.c  | 4 ++++
 external-odb.c | 3 +--
 sha1_file.c    | 3 +++
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 21af6442af..7b27abac35 100644
--- a/cache.h
+++ b/cache.h
@@ -437,6 +437,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define CEILING_DIRECTORIES_ENVIRONMENT "GIT_CEILING_DIRECTORIES"
 #define NO_REPLACE_OBJECTS_ENVIRONMENT "GIT_NO_REPLACE_OBJECTS"
 #define GIT_REPLACE_REF_BASE_ENVIRONMENT "GIT_REPLACE_REF_BASE"
+#define NO_EXTERNAL_ODB_ENVIRONMENT "GIT_NO_EXTERNAL_ODB"
 #define GITATTRIBUTES_FILE ".gitattributes"
 #define INFOATTRIBUTES_FILE "info/attributes"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
@@ -813,6 +814,14 @@ void reset_shared_repository(void);
 extern int check_replace_refs;
 extern char *git_replace_ref_base;
 
+/*
+ * Do external odbs need to be used this run?  This variable is
+ * initialized to true unless $GIT_NO_EXTERNAL_ODB is set, but it
+ * maybe set to false by some commands that do not want external
+ * odbs to be active.
+ */
+extern int use_external_odb;
+
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
diff --git a/environment.c b/environment.c
index 63ac38a46f..b3bd0daae2 100644
--- a/environment.c
+++ b/environment.c
@@ -48,6 +48,7 @@ const char *excludes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 int check_replace_refs = 1;
 char *git_replace_ref_base;
+int use_external_odb = 1;
 enum eol core_eol = EOL_UNSET;
 enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
@@ -117,6 +118,7 @@ const char * const local_repo_env[] = {
 	INDEX_ENVIRONMENT,
 	NO_REPLACE_OBJECTS_ENVIRONMENT,
 	GIT_REPLACE_REF_BASE_ENVIRONMENT,
+	NO_EXTERNAL_ODB_ENVIRONMENT,
 	GIT_PREFIX_ENVIRONMENT,
 	GIT_SUPER_PREFIX_ENVIRONMENT,
 	GIT_SHALLOW_FILE_ENVIRONMENT,
@@ -156,6 +158,8 @@ void setup_git_env(void)
 	free(git_replace_ref_base);
 	git_replace_ref_base = xstrdup(replace_ref_base ? replace_ref_base
 							  : "refs/replace/");
+	if (getenv(NO_EXTERNAL_ODB_ENVIRONMENT))
+		use_external_odb = 0;
 	free(namespace);
 	namespace = expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
 	shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
diff --git a/external-odb.c b/external-odb.c
index f3ea491333..390958dbfe 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -43,7 +43,7 @@ static void external_odb_init(void)
 {
 	static int initialized;
 
-	if (initialized)
+	if (initialized || !use_external_odb)
 		return;
 	initialized = 1;
 
@@ -69,4 +69,3 @@ int external_odb_has_object(const unsigned char *sha1)
 			return 1;
 	return 0;
 }
-
diff --git a/sha1_file.c b/sha1_file.c
index 3f5ff274e2..cba6b2a537 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -675,6 +675,9 @@ void prepare_external_alt_odb(void)
 	static int linked_external;
 	const char *path;
 
+	if (!use_external_odb)
+		return;
+
 	if (linked_external)
 		return;
 
-- 
2.16.0.rc0.16.g82191dbc6c.dirty

