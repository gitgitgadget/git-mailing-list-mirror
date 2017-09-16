Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC13820A21
	for <e@80x24.org>; Sat, 16 Sep 2017 08:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbdIPIIJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:08:09 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34103 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751331AbdIPIIF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:08:05 -0400
Received: by mail-wr0-f196.google.com with SMTP id k20so2370256wre.1
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=we4EP7UbNOMbWkQ4TUsrWa3BTuSxC04DFWZYaKUcK7Q=;
        b=QTwVSnN3esxpdQ9p2QWSapSdi4/Oocl5GbYuKxS6K8zt0sNZsc5JqTQLtX9HTDmH1T
         Q3ARVEvek0ShA+R1sWxsRAtctM6QJ2ZaUcozQWSsygGvJv506ThgVs7FiyjiQNd17utW
         OZB8IwLgZ4qI9PwUJ8zF0+NzbZTvIoSwSiw+FrpPRCoDWqwPuUL1/KjHCEqzQDWckHoW
         tG0ZL2Etpt0QWBto1wwOo236Rlh0HYl9yVICSx+K8avrKw0niI0oJxikLI+Hj1rU3wt7
         aJt6jrDrYZ8Unr6m6ozNITa9YvKLvwi48rLjWUwaqFOx1RyvMdj4T9/axbWzcsn6VuSI
         5BAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=we4EP7UbNOMbWkQ4TUsrWa3BTuSxC04DFWZYaKUcK7Q=;
        b=nVUPEqCSAXFZr8Hp79Kfmd+TKDRVHZkl022Hjtv9CMsuL+a92BTig+BWpokcjFABQR
         zYYvgwgqF63T+VYnf5iW9az2aWftKQ5dE95K7GnE8vL8Z4Q6bhlXGXCiTphDW504aNI3
         Otc0kowaLcJuGwxR/fhRQwrAEfXIoG3G9d1lo0bkcTzHnjIvb6BS+2SmjhlXTDxqIQAg
         41ry7BX0iCXsQ2rxAAV64d/vhYUF/IRHNIHPOCcOJUXP9YavmtuvRy98heqW6k/b6Cx4
         dPrX8hrZZa61/UmxR+O/4a7QpxNRd0LcI50+/bIMGCqwO2CFHiX3RnZ6q4EwmxPuS/61
         JZxA==
X-Gm-Message-State: AHPjjUgdKMHIndpL4HRKZHI7Ba9uouYRw3ssu6qK7z+X5rOTxfE9iiQs
        sdRC6otc4VAw9n0E
X-Google-Smtp-Source: ADKCNb7hEheQBjQrO+nqohgw7CtlmYkFt1mGzBH1JJe5LScRyZXA1aWDJRqTr049i657+2v67eG+xQ==
X-Received: by 10.223.173.204 with SMTP id w70mr25233703wrc.281.1505549284180;
        Sat, 16 Sep 2017 01:08:04 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:08:03 -0700 (PDT)
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
Subject: [PATCH v6 15/40] Add GIT_NO_EXTERNAL_ODB env variable
Date:   Sat, 16 Sep 2017 10:07:06 +0200
Message-Id: <20170916080731.13925-16-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
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
 external-odb.c | 6 ++++++
 sha1_file.c    | 3 +++
 4 files changed, 22 insertions(+)

diff --git a/cache.h b/cache.h
index 6c22bd0525..a2bd2090b3 100644
--- a/cache.h
+++ b/cache.h
@@ -429,6 +429,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define CEILING_DIRECTORIES_ENVIRONMENT "GIT_CEILING_DIRECTORIES"
 #define NO_REPLACE_OBJECTS_ENVIRONMENT "GIT_NO_REPLACE_OBJECTS"
 #define GIT_REPLACE_REF_BASE_ENVIRONMENT "GIT_REPLACE_REF_BASE"
+#define NO_EXTERNAL_ODB_ENVIRONMENT "GIT_NO_EXTERNAL_ODB"
 #define GITATTRIBUTES_FILE ".gitattributes"
 #define INFOATTRIBUTES_FILE "info/attributes"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
@@ -767,6 +768,14 @@ void reset_shared_repository(void);
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
index 3fd4b10845..bbccabef6b 100644
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
@@ -116,6 +117,7 @@ const char * const local_repo_env[] = {
 	INDEX_ENVIRONMENT,
 	NO_REPLACE_OBJECTS_ENVIRONMENT,
 	GIT_REPLACE_REF_BASE_ENVIRONMENT,
+	NO_EXTERNAL_ODB_ENVIRONMENT,
 	GIT_PREFIX_ENVIRONMENT,
 	GIT_SUPER_PREFIX_ENVIRONMENT,
 	GIT_SHALLOW_FILE_ENVIRONMENT,
@@ -154,6 +156,8 @@ void setup_git_env(void)
 	replace_ref_base = getenv(GIT_REPLACE_REF_BASE_ENVIRONMENT);
 	git_replace_ref_base = xstrdup(replace_ref_base ? replace_ref_base
 							  : "refs/replace/");
+	if (getenv(NO_EXTERNAL_ODB_ENVIRONMENT))
+		use_external_odb = 0;
 	namespace = expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
 	shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
 	if (shallow_file)
diff --git a/external-odb.c b/external-odb.c
index a4f8c72e1c..52cb448d01 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -65,6 +65,9 @@ int external_odb_has_object(const unsigned char *sha1)
 {
 	struct odb_helper *o;
 
+	if (!use_external_odb)
+		return 0;
+
 	external_odb_init();
 
 	for (o = helpers; o; o = o->next) {
@@ -124,6 +127,9 @@ int external_odb_put_object(const void *buf, size_t len,
 {
 	struct odb_helper *o;
 
+	if (!use_external_odb)
+		return 1;
+
 	/* For now accept only blobs */
 	if (strcmp(type, "blob"))
 		return 1;
diff --git a/sha1_file.c b/sha1_file.c
index d0155e392f..7b2a0f64fa 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -619,6 +619,9 @@ void prepare_external_alt_odb(void)
 	static int linked_external;
 	const char *path;
 
+	if (!use_external_odb)
+		return;
+
 	if (linked_external)
 		return;
 
-- 
2.14.1.576.g3f707d88cd

