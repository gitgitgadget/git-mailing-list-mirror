Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA93C6FD1F
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 07:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjCYHgK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 03:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCYHgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 03:36:09 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E9D93C5
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 00:36:08 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v4-20020a05600c470400b003ee4f06428fso2168571wmo.4
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 00:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679729766;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFWypjZzD4ArrcS2ZtdLRLQ+YRWJy11qIse3apayfec=;
        b=DUnIqr7t97AnEBjKsYeEXZTeuJ+L4DQmBfB2r1GCgdASovR/b4/RrzFoGJLgkwiQZ5
         3yEuhabOOoIlcvBCMS/7Qzxmo/jYQti/ywrOmguy0s/W+mD97/F369FICZp2CNQpzS3r
         27/P+IupwPgzc0Sl9ZDZSGVWwRQuQ+xkJXs0agDRS2B8Fof54H3IMWzyLLCj+HHwzCr6
         gbVq4NoDWb39XBCay9ej+mr1+arZrTcjPkhz8lpMI0vF4lyhAh5ushKg43/jYNF1G1J8
         hBjuDevB7UgvtFzYsx3BrOjPj9+TIfJGsyA9juFQY08DX2dV/t6xQ6ui5s2KWPam2OST
         FCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679729766;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFWypjZzD4ArrcS2ZtdLRLQ+YRWJy11qIse3apayfec=;
        b=X9OCDsD26M4LiBkalVdiRPqJ0cJgPTbn7CtzxgX96xGiviDhrFbhClSc4HaJDdD+TP
         GeedneJGC7qaJ+Juiu6aSd0ipkGh299eiebb+bVFGDKzpkt4VZROwIfC++V7IeahUxNg
         1cfjmhi8gpvClyJwRSdiJpKJZA76nB89VpDbSBQB5G43+8EwkRcg4uq6SjymY+c1OUnp
         wqHiatY0B6lL9GhiCmRR2i7+eI06ac8fVi9cnmafQ27mRhUk56/594aeS8zmKxkIrCmw
         eY5gED6+Fri0QfGzJFYNGudX9ie7wEnsxQ9ERnIVBBN/lZ/SkHo12dd+10HSSz4ENi3X
         mSlA==
X-Gm-Message-State: AO0yUKVYeiiovIsEDNy/dg9GEiibjZt3vPXnSjBiXk4ebA3S9+GlgnpS
        ffx8dREyDpjaEX8VsUTCz1eN+cIi2H4=
X-Google-Smtp-Source: AK7set+UZWU6siiRVLEmpdX+UXz+CU630SYNnaN6Nl/63gh03D4lAMFEiNfkVramvprFlFsPvGWGLg==
X-Received: by 2002:a05:600c:474c:b0:3ed:bfb4:ad9f with SMTP id w12-20020a05600c474c00b003edbfb4ad9fmr7142248wmo.2.1679729766169;
        Sat, 25 Mar 2023 00:36:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d7-20020adffbc7000000b002d5a8d8442asm15751052wrs.37.2023.03.25.00.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 00:36:05 -0700 (PDT)
Message-Id: <pull.1469.v2.git.git.1679729764851.gitgitgadget@gmail.com>
In-Reply-To: <pull.1469.git.git.1678829531648.gitgitgadget@gmail.com>
References: <pull.1469.git.git.1678829531648.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 25 Mar 2023 07:36:04 +0000
Subject: [PATCH v2] credential/libsecret: support password_expiry_utc
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Mantas =?UTF-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
        Javier Roucher Iglesias 
        <Javier.Roucher-Iglesias@ensimag.imag.fr>,
        Matthieu Moy <git@matthieu-moy.fr>,
        M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: M Hickford <mirth.hickford@gmail.com>

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    credential/libsecret: store password_expiry_utc
    
    Patch v2 adds tests.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1469%2Fhickford%2Flibsecret-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1469/hickford/libsecret-v2
Pull-Request: https://github.com/git/git/pull/1469

Range-diff vs v1:

 1:  46ba4863f33 ! 1:  1e27677b6f5 credential/libsecret: support password_expiry_utc
     @@ contrib/credential/libsecret/git-credential-libsecret.c: static void credential_
       }
       
       static void usage(const char *name)
     +
     + ## t/lib-credential.sh ##
     +@@ t/lib-credential.sh: helper_test_clean() {
     + 	reject $1 https example.com store-user
     + 	reject $1 https example.com user1
     + 	reject $1 https example.com user2
     ++	reject $1 https example.com user3
     + 	reject $1 http path.tld user
     + 	reject $1 https timeout.tld user
     + 	reject $1 https sso.tld
     +@@ t/lib-credential.sh: helper_test_timeout() {
     + 	'
     + }
     + 
     ++helper_test_password_expiry_utc() {
     ++	HELPER=$1
     ++
     ++	test_expect_success "helper ($HELPER) stores password_expiry_utc" '
     ++		check approve $HELPER <<-\EOF
     ++		protocol=https
     ++		host=example.com
     ++		username=user3
     ++		password=pass
     ++		password_expiry_utc=9999999999
     ++		EOF
     ++	'
     ++
     ++	test_expect_success "helper ($HELPER) gets password_expiry_utc" '
     ++		check fill $HELPER <<-\EOF
     ++		protocol=https
     ++		host=example.com
     ++		username=user3
     ++		--
     ++		protocol=https
     ++		host=example.com
     ++		username=user3
     ++		password=pass
     ++		password_expiry_utc=9999999999
     ++		--
     ++		EOF
     ++	'
     ++}
     ++
     + write_script askpass <<\EOF
     + echo >&2 askpass: $*
     + what=$(echo $1 | cut -d" " -f1 | tr A-Z a-z | tr -cd a-z)
     +
     + ## t/t0301-credential-cache.sh ##
     +@@ t/t0301-credential-cache.sh: test_atexit 'git credential-cache exit'
     + # test that the daemon works with no special setup
     + helper_test cache
     + 
     ++helper_test_password_expiry_utc cache
     ++
     + test_expect_success 'socket defaults to ~/.cache/git/credential/socket' '
     + 	test_when_finished "
     + 		git credential-cache exit &&
     +
     + ## t/t0303-credential-external.sh ##
     +@@ t/t0303-credential-external.sh: else
     + 	helper_test_timeout "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"
     + fi
     + 
     ++helper_test_password_expiry_utc "$GIT_TEST_CREDENTIAL_HELPER"
     ++
     + # clean afterwards so that we are good citizens
     + # and don't leave cruft in the helper's storage, which
     + # might be long-term system storage


 .../libsecret/git-credential-libsecret.c      | 42 ++++++++++++++++---
 t/lib-credential.sh                           | 30 +++++++++++++
 t/t0301-credential-cache.sh                   |  2 +
 t/t0303-credential-external.sh                |  2 +
 4 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/contrib/credential/libsecret/git-credential-libsecret.c b/contrib/credential/libsecret/git-credential-libsecret.c
index 2c5d76d789f..3f2b530db79 100644
--- a/contrib/credential/libsecret/git-credential-libsecret.c
+++ b/contrib/credential/libsecret/git-credential-libsecret.c
@@ -39,6 +39,7 @@ struct credential {
 	char *path;
 	char *username;
 	char *password;
+	char *password_expiry_utc;
 };
 
 #define CREDENTIAL_INIT { 0 }
@@ -54,6 +55,20 @@ struct credential_operation {
 
 /* ----------------- Secret Service functions ----------------- */
 
+static const SecretSchema schema = {
+	"org.git.Password",
+	SECRET_SCHEMA_NONE,
+	{
+		{  "user", SECRET_SCHEMA_ATTRIBUTE_STRING },
+		{  "object", SECRET_SCHEMA_ATTRIBUTE_STRING },
+		{  "protocol", SECRET_SCHEMA_ATTRIBUTE_STRING },
+		{  "port", SECRET_SCHEMA_ATTRIBUTE_INTEGER },
+		{  "server", SECRET_SCHEMA_ATTRIBUTE_STRING },
+		{  "password_expiry_utc", SECRET_SCHEMA_ATTRIBUTE_INTEGER },
+		{  NULL, 0 },
+	}
+};
+
 static char *make_label(struct credential *c)
 {
 	if (c->port)
@@ -78,6 +93,9 @@ static GHashTable *make_attr_list(struct credential *c)
 		g_hash_table_insert(al, "port", g_strdup_printf("%hu", c->port));
 	if (c->path)
 		g_hash_table_insert(al, "object", g_strdup(c->path));
+	if (c->password_expiry_utc)
+		g_hash_table_insert(al, "password_expiry_utc",
+			g_strdup(c->password_expiry_utc));
 
 	return al;
 }
@@ -101,9 +119,11 @@ static int keyring_get(struct credential *c)
 
 	attributes = make_attr_list(c);
 	items = secret_service_search_sync(service,
-					   SECRET_SCHEMA_COMPAT_NETWORK,
+					   &schema,
 					   attributes,
-					   SECRET_SEARCH_LOAD_SECRETS | SECRET_SEARCH_UNLOCK,
+					   SECRET_SEARCH_LOAD_SECRETS | SECRET_SEARCH_UNLOCK |
+					   // for backwards compatibility
+					   SECRET_SCHEMA_DONT_MATCH_NAME,
 					   NULL,
 					   &error);
 	g_hash_table_unref(attributes);
@@ -128,6 +148,12 @@ static int keyring_get(struct credential *c)
 			c->username = g_strdup(s);
 		}
 
+		s = g_hash_table_lookup(attributes, "password_expiry_utc");
+		if (s) {
+			g_free(c->password_expiry_utc);
+			c->password_expiry_utc = g_strdup(s);
+		}
+
 		s = secret_value_get_text(secret);
 		if (s) {
 			g_free(c->password);
@@ -162,7 +188,7 @@ static int keyring_store(struct credential *c)
 
 	label = make_label(c);
 	attributes = make_attr_list(c);
-	secret_password_storev_sync(SECRET_SCHEMA_COMPAT_NETWORK,
+	secret_password_storev_sync(&schema,
 				    attributes,
 				    NULL,
 				    label,
@@ -198,7 +224,7 @@ static int keyring_erase(struct credential *c)
 		return EXIT_FAILURE;
 
 	attributes = make_attr_list(c);
-	secret_password_clearv_sync(SECRET_SCHEMA_COMPAT_NETWORK,
+	secret_password_clearv_sync(&schema,
 				    attributes,
 				    NULL,
 				    &error);
@@ -238,6 +264,7 @@ static void credential_clear(struct credential *c)
 	g_free(c->path);
 	g_free(c->username);
 	g_free(c->password);
+	g_free(c->password_expiry_utc);
 
 	credential_init(c);
 }
@@ -285,6 +312,9 @@ static int credential_read(struct credential *c)
 		} else if (!strcmp(key, "username")) {
 			g_free(c->username);
 			c->username = g_strdup(value);
+		} else if (!strcmp(key, "password_expiry_utc")) {
+			g_free(c->password_expiry_utc);
+			c->password_expiry_utc = g_strdup(value);
 		} else if (!strcmp(key, "password")) {
 			g_free(c->password);
 			c->password = g_strdup(value);
@@ -312,9 +342,11 @@ static void credential_write_item(FILE *fp, const char *key, const char *value)
 
 static void credential_write(const struct credential *c)
 {
-	/* only write username/password, if set */
+	/* only write username/password/expiry, if set */
 	credential_write_item(stdout, "username", c->username);
 	credential_write_item(stdout, "password", c->password);
+	credential_write_item(stdout, "password_expiry_utc",
+		c->password_expiry_utc);
 }
 
 static void usage(const char *name)
diff --git a/t/lib-credential.sh b/t/lib-credential.sh
index 5ea8bc9f1dc..9ebf7eeae48 100644
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -43,6 +43,7 @@ helper_test_clean() {
 	reject $1 https example.com store-user
 	reject $1 https example.com user1
 	reject $1 https example.com user2
+	reject $1 https example.com user3
 	reject $1 http path.tld user
 	reject $1 https timeout.tld user
 	reject $1 https sso.tld
@@ -298,6 +299,35 @@ helper_test_timeout() {
 	'
 }
 
+helper_test_password_expiry_utc() {
+	HELPER=$1
+
+	test_expect_success "helper ($HELPER) stores password_expiry_utc" '
+		check approve $HELPER <<-\EOF
+		protocol=https
+		host=example.com
+		username=user3
+		password=pass
+		password_expiry_utc=9999999999
+		EOF
+	'
+
+	test_expect_success "helper ($HELPER) gets password_expiry_utc" '
+		check fill $HELPER <<-\EOF
+		protocol=https
+		host=example.com
+		username=user3
+		--
+		protocol=https
+		host=example.com
+		username=user3
+		password=pass
+		password_expiry_utc=9999999999
+		--
+		EOF
+	'
+}
+
 write_script askpass <<\EOF
 echo >&2 askpass: $*
 what=$(echo $1 | cut -d" " -f1 | tr A-Z a-z | tr -cd a-z)
diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
index 698b7159f03..f5ba727e53b 100755
--- a/t/t0301-credential-cache.sh
+++ b/t/t0301-credential-cache.sh
@@ -30,6 +30,8 @@ test_atexit 'git credential-cache exit'
 # test that the daemon works with no special setup
 helper_test cache
 
+helper_test_password_expiry_utc cache
+
 test_expect_success 'socket defaults to ~/.cache/git/credential/socket' '
 	test_when_finished "
 		git credential-cache exit &&
diff --git a/t/t0303-credential-external.sh b/t/t0303-credential-external.sh
index f028fd14182..f1478680bff 100755
--- a/t/t0303-credential-external.sh
+++ b/t/t0303-credential-external.sh
@@ -52,6 +52,8 @@ else
 	helper_test_timeout "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"
 fi
 
+helper_test_password_expiry_utc "$GIT_TEST_CREDENTIAL_HELPER"
+
 # clean afterwards so that we are good citizens
 # and don't leave cruft in the helper's storage, which
 # might be long-term system storage

base-commit: 27d43aaaf50ef0ae014b88bba294f93658016a2e
-- 
gitgitgadget
