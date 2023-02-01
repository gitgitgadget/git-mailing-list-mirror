Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAD9C38142
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 09:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjBAJj6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 04:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjBAJj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 04:39:57 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655C85B584
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 01:39:55 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id y1so16708012wru.2
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 01:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eROjWqw/uRA8aOlp7qqmdEbeG2BW+cR6drWIIZ0B8EI=;
        b=jBM3rrUQSd6lVxWjgbi5qkg6B/z+Rc9ERh5HMB/Alq8/Y3WU6vcyi8/jxVa2OM/s7/
         F8FIJssXpnf8nVzlnj9pcxIiX0UI8Pucslx1YsR2AEablW5a8TIrg5zY5H68BadSDN6d
         TQ0bTuOzVG+CepMhPLJOKmbV2vkyOeZTXYen6vu9mup7uyw51cqUi9hvkCe84mMV4evp
         grlwMUzTtxzAJheExqD4zcWiNjGKo7ISdC9UxCOjFk5BNDu9gJqXa8+It264hc1zOoft
         NFaNP7USKJ3Ia9JDr57QuiCE2RWapRQDgELirYBVEVO68JZsby7H8P7wfMRa3Urh8eXR
         5XbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eROjWqw/uRA8aOlp7qqmdEbeG2BW+cR6drWIIZ0B8EI=;
        b=gQaUJJAh2WtFlFROOs21H7tAqVq6XVOFVSq2cwOf4VaFc5Tn7lQ2c5rWPDwGZKzyQI
         TcojZHRKIjDJ/9cp2WOn5/vlxuSCxg3JDtM/79UTcT7OUN2Xzmy1kCIf/f8rIEKrd0rt
         iTvU7T205werXRlCldFdnOEKO0BJQqSRGe0I16K/OaTaTZZPp3yQ2n9euIKaB94MYGHf
         grkm2hvN23VRsj4G3poNc5JfepYp/V5qWwKVOUOmru3HDufCLAhb6tgsbLHGx1ESj3pn
         t+hr/GSajlZ7CQWhFJo7QU+Lp2WaCEu3LQACiNVG+rjJcSUjpVn1HLuAJ6egboG0YfrC
         GmhQ==
X-Gm-Message-State: AO0yUKXDMgFXV6PPYoYsQfh6ahRL71iGsm9DMBQYcP5Hf96ZaxhlEpLr
        KSdcmuD0qgQxKSmbh6+8TBamLjrZVmc=
X-Google-Smtp-Source: AK7set8LCTHlL0fFDR4jBtOfj0GiXcDq6azF8FzdGop0UCMFCUgGKyPidV3AgGQTwnZpUqE/5y90/g==
X-Received: by 2002:a5d:47a2:0:b0:2bf:b5bd:8f60 with SMTP id 2-20020a5d47a2000000b002bfb5bd8f60mr1475915wrb.61.1675244393275;
        Wed, 01 Feb 2023 01:39:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e2-20020adfe382000000b002bfae43109fsm16771065wrm.93.2023.02.01.01.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 01:39:52 -0800 (PST)
Message-Id: <pull.1443.v2.git.git.1675244392025.gitgitgadget@gmail.com>
In-Reply-To: <pull.1443.git.git.1674914650588.gitgitgadget@gmail.com>
References: <pull.1443.git.git.1674914650588.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Feb 2023 09:39:51 +0000
Subject: [PATCH v2] credential: new attribute password_expiry_utc
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        Cheetham <mjcheetham@outlook.com>,
        Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: M Hickford <mirth.hickford@gmail.com>

Some passwords have an expiry date known at generation. This may be
years away for a personal access token or hours for an OAuth access
token.

Currently the credential protocol has no expiry attribute. When multiple
helpers are configured, `credential fill` tries each helper in turn
until it has a username and password, returning early.

When a storage helper and a credential-generating helper are configured
together, the credential is necessarily stored without expiry, so
`credential fill` may later return an expired credential from storage.

```
[credential]
	helper = storage  # eg. cache or osxkeychain
	helper = generate  # eg. oauth
```

An improvement is to introduce a password expiry attribute to the
credential protocol. If the expiry date has passed, `credential fill`
ignores the password attribute, so subsequent helpers can generate a
fresh credential. This is backwards compatible -- no change in
behaviour with helpers that discard the expiry attribute.

Note that the expiry logic is entirely within the credential layer.
Compatible helpers store and retrieve the new attribute like any other.
This keeps the helper contract simple.

This patch adds support for the new attribute to cache.

Example usage in a credential-generating helper
https://github.com/hickford/git-credential-oauth/pull/16

Future ideas: make it possible for a storage helper to provide OAuth
refresh token to subsequent helpers.
https://github.com/gitgitgadget/git/pull/1394

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    credential: new attribute password_expiry_utc
    
    Some passwords have an expiry date known at generation. This may be
    years away for a personal access token or hours for an OAuth access
    token.
    
    Currently the credential protocol has no expiry attribute. When multiple
    helpers are configured, credential fill tries each helper in turn until
    it has a username and password, returning early.
    
    When a storage helper and a credential-generating helper are configured
    together, the credential is necessarily stored without expiry, so
    credential fill may later return an expired credential from storage.
    
    [credential]
    helper = storage  # eg. cache or osxkeychain
    helper = generate  # eg. oauth
    
    
    An improvement is to introduce a password expiry attribute to the
    credential protocol. If the password has expired, credential fill no
    longer returns early, so subsequent helpers can generate a fresh
    credential. This is backwards compatible -- no change in behaviour with
    helpers that discard the expiry attribute.
    
    Note that the expiry logic is entirely within the credential layer.
    Compatible helpers store and retrieve the new attribute like any other.
    This keeps the helper contract simple.
    
    This patch adds support for the new attribute to cache.
    
    Example usage in a credential-generating helper
    https://github.com/hickford/git-credential-oauth/pull/16
    
    Future ideas: make it possible for a storage helper to provide OAuth
    refresh token to subsequent helpers.
    https://github.com/gitgitgadget/git/pull/1394
    
    Questions for reviewers:
    
     * Does the behaviour implemented match the documentation? (I'm not
       famiiliar with C)
     * Any edge cases?
     * How to test in t0300-credentials.sh ?

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1443%2Fhickford%2Fpassword-expiry-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1443/hickford/password-expiry-v2
Pull-Request: https://github.com/git/git/pull/1443

Range-diff vs v1:

 1:  184b0aa6514 ! 1:  b9ee729ee4d credential: new attribute password_expiry_utc
     @@ Metadata
       ## Commit message ##
          credential: new attribute password_expiry_utc
      
     -    If password has expired, credential fill no longer returns early,
     -    so later helpers can generate a fresh credential. This is backwards
     -    compatible -- no change in behaviour with helpers that discard the
     -    expiry attribute. The expiry logic is entirely in the git credential
     -    layer; compatible helpers simply store and return the expiry
     -    attribute verbatim.
     +    Some passwords have an expiry date known at generation. This may be
     +    years away for a personal access token or hours for an OAuth access
     +    token.
      
     -    Store new attribute in cache.
     +    Currently the credential protocol has no expiry attribute. When multiple
     +    helpers are configured, `credential fill` tries each helper in turn
     +    until it has a username and password, returning early.
     +
     +    When a storage helper and a credential-generating helper are configured
     +    together, the credential is necessarily stored without expiry, so
     +    `credential fill` may later return an expired credential from storage.
     +
     +    ```
     +    [credential]
     +            helper = storage  # eg. cache or osxkeychain
     +            helper = generate  # eg. oauth
     +    ```
     +
     +    An improvement is to introduce a password expiry attribute to the
     +    credential protocol. If the expiry date has passed, `credential fill`
     +    ignores the password attribute, so subsequent helpers can generate a
     +    fresh credential. This is backwards compatible -- no change in
     +    behaviour with helpers that discard the expiry attribute.
     +
     +    Note that the expiry logic is entirely within the credential layer.
     +    Compatible helpers store and retrieve the new attribute like any other.
     +    This keeps the helper contract simple.
     +
     +    This patch adds support for the new attribute to cache.
     +
     +    Example usage in a credential-generating helper
     +    https://github.com/hickford/git-credential-oauth/pull/16
     +
     +    Future ideas: make it possible for a storage helper to provide OAuth
     +    refresh token to subsequent helpers.
     +    https://github.com/gitgitgadget/git/pull/1394
      
          Signed-off-by: M Hickford <mirth.hickford@gmail.com>
      
     @@ Documentation/git-credential.txt: Git understands the following attributes:
       
      +`password_expiry_utc`::
      +
     -+	If password is a personal access token or OAuth access token, it may have an expiry date. When getting credentials from a helper, `git credential fill` ignores the password attribute if the expiry date has passed. Storage helpers should store this attribute if possible. Helpers should not implement expiry logic themselves. Represented as Unix time UTC, seconds since 1970.
     ++	If password is a personal access token or OAuth access token, it may have an
     ++	expiry date. When getting credentials from a helper, `git credential fill`
     ++	ignores the password attribute if the expiry date has passed. Storage
     ++	helpers should store this attribute if possible. Helpers should not
     ++	implement expiry logic themselves. Represented as Unix time UTC, seconds
     ++	since 1970.
      +
       `url`::
       
     @@ builtin/credential-cache--daemon.c: static void serve_one_client(FILE *in, FILE
       		if (e) {
       			fprintf(out, "username=%s\n", e->item.username);
       			fprintf(out, "password=%s\n", e->item.password);
     -+			if (e->item.password_expiry_utc != 0) {
     -+				fprintf(out, "password_expiry_utc=%ld\n", e->item.password_expiry_utc);
     -+			}
     ++			if (e->item.password_expiry_utc != TIME_MAX)
     ++				fprintf(out, "password_expiry_utc=%"PRItime"\n",
     ++					e->item.password_expiry_utc);
       		}
       	}
       	else if (!strcmp(action.buf, "exit")) {
     @@ credential.c
       #include "prompt.h"
       #include "sigchain.h"
       #include "urlmatch.h"
     -+#include <time.h>
     ++#include "git-compat-util.h"
       
       void credential_init(struct credential *c)
       {
     -@@ credential.c: void credential_clear(struct credential *c)
     - 	free(c->path);
     - 	free(c->username);
     - 	free(c->password);
     -+	c->password_expiry_utc = 0;
     - 	string_list_clear(&c->helpers, 0);
     +@@ credential.c: static void credential_getpass(struct credential *c)
     + 	if (!c->username)
     + 		c->username = credential_ask_one("Username", c,
     + 						 PROMPT_ASKPASS|PROMPT_ECHO);
     +-	if (!c->password)
     ++	if (!c->password || c->password_expiry_utc < time(NULL)) {
     ++		c->password_expiry_utc = TIME_MAX;
     + 		c->password = credential_ask_one("Password", c,
     + 						 PROMPT_ASKPASS);
     ++	}
     + }
     + 
     + int credential_read(struct credential *c, FILE *fp)
     + {
     + 	struct strbuf line = STRBUF_INIT;
       
     - 	credential_init(c);
     ++	int password_updated = 0;
     ++	timestamp_t this_password_expiry = TIME_MAX;
     ++
     + 	while (strbuf_getline(&line, fp) != EOF) {
     + 		char *key = line.buf;
     + 		char *value = strchr(key, '=');
     +@@ credential.c: int credential_read(struct credential *c, FILE *fp)
     + 		} else if (!strcmp(key, "password")) {
     + 			free(c->password);
     + 			c->password = xstrdup(value);
     ++			password_updated = 1;
     + 		} else if (!strcmp(key, "protocol")) {
     + 			free(c->protocol);
     + 			c->protocol = xstrdup(value);
      @@ credential.c: int credential_read(struct credential *c, FILE *fp)
       		} else if (!strcmp(key, "path")) {
       			free(c->path);
       			c->path = xstrdup(value);
      +		} else if (!strcmp(key, "password_expiry_utc")) {
     -+			// TODO: ignore if can't parse integer
     -+			c->password_expiry_utc = atoi(value);
     ++			this_password_expiry = parse_timestamp(value, NULL, 10);
     ++			if (this_password_expiry == 0 || errno) {
     ++				this_password_expiry = TIME_MAX;
     ++			}
       		} else if (!strcmp(key, "url")) {
       			credential_from_url(c, value);
       		} else if (!strcmp(key, "quit")) {
     - 			c->quit = !!git_config_bool("quit", value);
     - 		}
     -+
     -+		// if expiry date has passed, ignore password and expiry fields
     -+		if (c->password_expiry_utc != 0 && time(NULL) > c->password_expiry_utc) {
     -+			trace_printf(_("Password has expired.\n"));
     -+			FREE_AND_NULL(c->username);
     -+			FREE_AND_NULL(c->password);
     -+			c->password_expiry_utc = 0;
     -+		}
     +@@ credential.c: int credential_read(struct credential *c, FILE *fp)
     + 		 */
     + 	}
     + 
     ++	if (password_updated)
     ++		c->password_expiry_utc = this_password_expiry;
      +
     - 		/*
     - 		 * Ignore other lines; we don't know what they mean, but
     - 		 * this future-proofs us when later versions of git do
     + 	strbuf_release(&line);
     + 	return 0;
     + }
      @@ credential.c: void credential_write(const struct credential *c, FILE *fp)
       	credential_write_item(fp, "path", c->path, 0);
       	credential_write_item(fp, "username", c->username, 0);
       	credential_write_item(fp, "password", c->password, 0);
     -+	if (c->password_expiry_utc != 0) {
     -+		int length = snprintf( NULL, 0, "%ld", c->password_expiry_utc);
     -+		char* str = malloc( length + 1 );
     -+		snprintf( str, length + 1, "%ld", c->password_expiry_utc );
     -+		credential_write_item(fp, "password_expiry_utc", str, 0);
     -+		free(str);
     ++	if (c->password_expiry_utc != TIME_MAX) {
     ++		char *s = xstrfmt("%"PRItime, c->password_expiry_utc);
     ++		credential_write_item(fp, "password_expiry_utc", s, 0);
     ++		free(s);
      +	}
       }
       
       static int run_credential_helper(struct credential *c,
     +@@ credential.c: void credential_fill(struct credential *c)
     + 
     + 	for (i = 0; i < c->helpers.nr; i++) {
     + 		credential_do(c, c->helpers.items[i].string, "get");
     +-		if (c->username && c->password)
     ++		if (c->username && c->password && time(NULL) < c->password_expiry_utc)
     + 			return;
     + 		if (c->quit)
     + 			die("credential helper '%s' told us to quit",
      
       ## credential.h ##
      @@ credential.h: struct credential {
       	char *protocol;
       	char *host;
       	char *path;
     -+	time_t password_expiry_utc;
     ++	timestamp_t password_expiry_utc;
       };
       
       #define CREDENTIAL_INIT { \
     + 	.helpers = STRING_LIST_INIT_DUP, \
     ++	.password_expiry_utc = TIME_MAX, \
     + }
     + 
     + /* Initialize a credential structure, setting all fields to empty. */


 Documentation/git-credential.txt   |  9 +++++++++
 builtin/credential-cache--daemon.c |  3 +++
 credential.c                       | 24 ++++++++++++++++++++++--
 credential.h                       |  2 ++
 4 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index ac2818b9f66..667c4d80e26 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -144,6 +144,15 @@ Git understands the following attributes:
 
 	The credential's password, if we are asking it to be stored.
 
+`password_expiry_utc`::
+
+	If password is a personal access token or OAuth access token, it may have an
+	expiry date. When getting credentials from a helper, `git credential fill`
+	ignores the password attribute if the expiry date has passed. Storage
+	helpers should store this attribute if possible. Helpers should not
+	implement expiry logic themselves. Represented as Unix time UTC, seconds
+	since 1970.
+
 `url`::
 
 	When this special attribute is read by `git credential`, the
diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index f3c89831d4a..338058be7f9 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -127,6 +127,9 @@ static void serve_one_client(FILE *in, FILE *out)
 		if (e) {
 			fprintf(out, "username=%s\n", e->item.username);
 			fprintf(out, "password=%s\n", e->item.password);
+			if (e->item.password_expiry_utc != TIME_MAX)
+				fprintf(out, "password_expiry_utc=%"PRItime"\n",
+					e->item.password_expiry_utc);
 		}
 	}
 	else if (!strcmp(action.buf, "exit")) {
diff --git a/credential.c b/credential.c
index f6389a50684..354fa1652a9 100644
--- a/credential.c
+++ b/credential.c
@@ -7,6 +7,7 @@
 #include "prompt.h"
 #include "sigchain.h"
 #include "urlmatch.h"
+#include "git-compat-util.h"
 
 void credential_init(struct credential *c)
 {
@@ -195,15 +196,20 @@ static void credential_getpass(struct credential *c)
 	if (!c->username)
 		c->username = credential_ask_one("Username", c,
 						 PROMPT_ASKPASS|PROMPT_ECHO);
-	if (!c->password)
+	if (!c->password || c->password_expiry_utc < time(NULL)) {
+		c->password_expiry_utc = TIME_MAX;
 		c->password = credential_ask_one("Password", c,
 						 PROMPT_ASKPASS);
+	}
 }
 
 int credential_read(struct credential *c, FILE *fp)
 {
 	struct strbuf line = STRBUF_INIT;
 
+	int password_updated = 0;
+	timestamp_t this_password_expiry = TIME_MAX;
+
 	while (strbuf_getline(&line, fp) != EOF) {
 		char *key = line.buf;
 		char *value = strchr(key, '=');
@@ -225,6 +231,7 @@ int credential_read(struct credential *c, FILE *fp)
 		} else if (!strcmp(key, "password")) {
 			free(c->password);
 			c->password = xstrdup(value);
+			password_updated = 1;
 		} else if (!strcmp(key, "protocol")) {
 			free(c->protocol);
 			c->protocol = xstrdup(value);
@@ -234,6 +241,11 @@ int credential_read(struct credential *c, FILE *fp)
 		} else if (!strcmp(key, "path")) {
 			free(c->path);
 			c->path = xstrdup(value);
+		} else if (!strcmp(key, "password_expiry_utc")) {
+			this_password_expiry = parse_timestamp(value, NULL, 10);
+			if (this_password_expiry == 0 || errno) {
+				this_password_expiry = TIME_MAX;
+			}
 		} else if (!strcmp(key, "url")) {
 			credential_from_url(c, value);
 		} else if (!strcmp(key, "quit")) {
@@ -246,6 +258,9 @@ int credential_read(struct credential *c, FILE *fp)
 		 */
 	}
 
+	if (password_updated)
+		c->password_expiry_utc = this_password_expiry;
+
 	strbuf_release(&line);
 	return 0;
 }
@@ -269,6 +284,11 @@ void credential_write(const struct credential *c, FILE *fp)
 	credential_write_item(fp, "path", c->path, 0);
 	credential_write_item(fp, "username", c->username, 0);
 	credential_write_item(fp, "password", c->password, 0);
+	if (c->password_expiry_utc != TIME_MAX) {
+		char *s = xstrfmt("%"PRItime, c->password_expiry_utc);
+		credential_write_item(fp, "password_expiry_utc", s, 0);
+		free(s);
+	}
 }
 
 static int run_credential_helper(struct credential *c,
@@ -342,7 +362,7 @@ void credential_fill(struct credential *c)
 
 	for (i = 0; i < c->helpers.nr; i++) {
 		credential_do(c, c->helpers.items[i].string, "get");
-		if (c->username && c->password)
+		if (c->username && c->password && time(NULL) < c->password_expiry_utc)
 			return;
 		if (c->quit)
 			die("credential helper '%s' told us to quit",
diff --git a/credential.h b/credential.h
index f430e77fea4..935b28a70f1 100644
--- a/credential.h
+++ b/credential.h
@@ -126,10 +126,12 @@ struct credential {
 	char *protocol;
 	char *host;
 	char *path;
+	timestamp_t password_expiry_utc;
 };
 
 #define CREDENTIAL_INIT { \
 	.helpers = STRING_LIST_INIT_DUP, \
+	.password_expiry_utc = TIME_MAX, \
 }
 
 /* Initialize a credential structure, setting all fields to empty. */

base-commit: 5cc9858f1b470844dea5c5d3e936af183fdf2c68
-- 
gitgitgadget
