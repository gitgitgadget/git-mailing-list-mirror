Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F85C636CC
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 21:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjBDVQT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 16:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjBDVQS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 16:16:18 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B081421A37
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 13:16:15 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r27so3560118wrr.1
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 13:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ted+GJkzw/KFmaYejTVSTNbtLmwBVREAjO02H71O9+k=;
        b=TQ5GeYJc66g64Kd3npgEtCfMI73IP3Q5+hMrtygguHEYnZ+DGst+VHqERCmHSYxymW
         xEZqqZ1z3SuBGgfjc4+p7hEilVFAyYNwbNLYIivSewP0Ors+iv1K0Poh+GBMdxMo2PHI
         e4VP6wNY/UyLlvNe/GbV+Q5X+UjgJpw4YmJ6+StGo/OKfP2mD8wdBnI5/syM+ppg8pdf
         H/dbtQLt04IFlMIlks4h9f3uAQSBYQ6q/Rcl7SURvXflnjb340u9tdBF2oi2yWs8VqVu
         ZNiQY7zi82cQ8aG8Qrvrjtn+Y19QDfdQJOsrt5KWm4W0G97Ke17kAE6Oo7IBoyQ0Mp3o
         1oUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ted+GJkzw/KFmaYejTVSTNbtLmwBVREAjO02H71O9+k=;
        b=3s7pS2liNth3YyDOJ7CMG2/Ka9BDBfO5gvV2PC7wlkT1p0lsKTiRl+OK0gjmegt9Q9
         xhLOpXTBC9lbRpji58TkdsOjVgb3m1ccK34phszjue5+ZgAzS3KKV27rnnzMnw6NlyUv
         t+CQnHF+zqZ6lUlbngprESHfLgicGsVhVYXuB2pXrRt6lyjIXV3RRE8dYym13NfzO9X/
         7IixbCVcW5aTghUEv4PYTZKJCeMIZoxOtGkFylHQSxYhlGKwhQ4wpuODisstlEizeddY
         ItyZdhQdMw84MpniSMsVMU9IPsYUHjlw1HEBiGpadAuZq7U1HxXUBsorlApUpxzmNg0j
         55ww==
X-Gm-Message-State: AO0yUKWHoLP27zoGd34nUoB8KeMuDUVacEjrdt4wc3B7VzN3hFSoz+r0
        5STSfK1PnvqMYT5v9R948AAdc7lkuBw=
X-Google-Smtp-Source: AK7set8IO3cM4snt7q8yjZxMyYy7dxz9AqMUqF2i4zEEcF4Rd+TAjm6Hl4NLWXIUM/F1B14YAdo8lQ==
X-Received: by 2002:a05:6000:49:b0:2c3:e4f5:188e with SMTP id k9-20020a056000004900b002c3e4f5188emr79137wrx.3.1675545373573;
        Sat, 04 Feb 2023 13:16:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p4-20020a5d68c4000000b002c3e4f2ffdbsm129103wrw.58.2023.02.04.13.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 13:16:13 -0800 (PST)
Message-Id: <pull.1443.v3.git.git.1675545372271.gitgitgadget@gmail.com>
In-Reply-To: <pull.1443.v2.git.git.1675244392025.gitgitgadget@gmail.com>
References: <pull.1443.v2.git.git.1675244392025.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Feb 2023 21:16:12 +0000
Subject: [PATCH v3] credential: new attribute password_expiry_utc
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

When multiple credential helpers are configured, `credential fill` tries
each helper in turn until it has a username and password, returning
early. If Git authentication succeeds, `credential approve`
stores the successful credential in all helpers. If authentication
fails, `credential reject` erases matching credentials in all helpers.
Helpers implement corresponding operations: get, store, erase.

The credential protocol has no expiry attribute, so helpers cannot
store expiry information. (Even if a helper returned an improvised
expiry attribute, git credential discards unrecognised attributes
between operations and between helpers.)

As a workaround, whenever monolithic helper Git Credential Manager (GCM)
retrieves an OAuth credential from its storage, it makes a HTTP request
to check whether the OAuth token has expired [1]. This complicates and
slows the authentication happy path.

Worse is the case that a storage helper and a credential-generating
helper are configured together:

	[credential]
		helper = storage  # eg. cache or osxkeychain
		helper = generate  # eg. oauth or manager

`credential approve` stores the generated credential in both helpers
without expiry information. Later `credential fill` may return an
expired credential from storage. There is no workaround, no matter how
clever the second helper.

Introduce a password expiry attribute. In `credential fill`, ignore
expired passwords and continue to query subsequent helpers.

In the example above, `credential fill` ignores the expired credential
and a fresh credential is generated. If authentication succeeds,
`credential approve` replaces the expired credential in storage.
If authentication fails, the expired credential is erased by
`credential reject`. It is unnecessary but harmless for storage
helpers to self prune expired credentials.

Add support for the new attribute to credential-cache.
Eventually, I hope to see support in other storage helpers.

Example usage in a credential-generating helper
https://github.com/hickford/git-credential-oauth/pull/16

[1] https://github.com/GitCredentialManager/git-credential-manager/blob/66b94e489ad8cc1982836355493e369770b30211/src/shared/GitLab/GitLabHostProvider.cs#L217

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    credential: new attribute password_expiry_utc
    
    details in commit message
    
    Changes in patch v3:
    
     * Tests
     * Simplified credential_read, moved expiry logic to credential_fill

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1443%2Fhickford%2Fpassword-expiry-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1443/hickford/password-expiry-v3
Pull-Request: https://github.com/git/git/pull/1443

Range-diff vs v2:

 1:  b9ee729ee4d ! 1:  1846815a5c1 credential: new attribute password_expiry_utc
     @@ Commit message
          years away for a personal access token or hours for an OAuth access
          token.
      
     -    Currently the credential protocol has no expiry attribute. When multiple
     -    helpers are configured, `credential fill` tries each helper in turn
     -    until it has a username and password, returning early.
     +    When multiple credential helpers are configured, `credential fill` tries
     +    each helper in turn until it has a username and password, returning
     +    early. If Git authentication succeeds, `credential approve`
     +    stores the successful credential in all helpers. If authentication
     +    fails, `credential reject` erases matching credentials in all helpers.
     +    Helpers implement corresponding operations: get, store, erase.
      
     -    When a storage helper and a credential-generating helper are configured
     -    together, the credential is necessarily stored without expiry, so
     -    `credential fill` may later return an expired credential from storage.
     +    The credential protocol has no expiry attribute, so helpers cannot
     +    store expiry information. (Even if a helper returned an improvised
     +    expiry attribute, git credential discards unrecognised attributes
     +    between operations and between helpers.)
      
     -    ```
     -    [credential]
     -            helper = storage  # eg. cache or osxkeychain
     -            helper = generate  # eg. oauth
     -    ```
     +    As a workaround, whenever monolithic helper Git Credential Manager (GCM)
     +    retrieves an OAuth credential from its storage, it makes a HTTP request
     +    to check whether the OAuth token has expired [1]. This complicates and
     +    slows the authentication happy path.
      
     -    An improvement is to introduce a password expiry attribute to the
     -    credential protocol. If the expiry date has passed, `credential fill`
     -    ignores the password attribute, so subsequent helpers can generate a
     -    fresh credential. This is backwards compatible -- no change in
     -    behaviour with helpers that discard the expiry attribute.
     +    Worse is the case that a storage helper and a credential-generating
     +    helper are configured together:
      
     -    Note that the expiry logic is entirely within the credential layer.
     -    Compatible helpers store and retrieve the new attribute like any other.
     -    This keeps the helper contract simple.
     +            [credential]
     +                    helper = storage  # eg. cache or osxkeychain
     +                    helper = generate  # eg. oauth or manager
      
     -    This patch adds support for the new attribute to cache.
     +    `credential approve` stores the generated credential in both helpers
     +    without expiry information. Later `credential fill` may return an
     +    expired credential from storage. There is no workaround, no matter how
     +    clever the second helper.
     +
     +    Introduce a password expiry attribute. In `credential fill`, ignore
     +    expired passwords and continue to query subsequent helpers.
     +
     +    In the example above, `credential fill` ignores the expired credential
     +    and a fresh credential is generated. If authentication succeeds,
     +    `credential approve` replaces the expired credential in storage.
     +    If authentication fails, the expired credential is erased by
     +    `credential reject`. It is unnecessary but harmless for storage
     +    helpers to self prune expired credentials.
     +
     +    Add support for the new attribute to credential-cache.
     +    Eventually, I hope to see support in other storage helpers.
      
          Example usage in a credential-generating helper
          https://github.com/hickford/git-credential-oauth/pull/16
      
     -    Future ideas: make it possible for a storage helper to provide OAuth
     -    refresh token to subsequent helpers.
     -    https://github.com/gitgitgadget/git/pull/1394
     +    [1] https://github.com/GitCredentialManager/git-credential-manager/blob/66b94e489ad8cc1982836355493e369770b30211/src/shared/GitLab/GitLabHostProvider.cs#L217
      
          Signed-off-by: M Hickford <mirth.hickford@gmail.com>
      
     @@ Documentation/git-credential.txt: Git understands the following attributes:
       
      +`password_expiry_utc`::
      +
     -+	If password is a personal access token or OAuth access token, it may have an
     -+	expiry date. When getting credentials from a helper, `git credential fill`
     -+	ignores the password attribute if the expiry date has passed. Storage
     -+	helpers should store this attribute if possible. Helpers should not
     -+	implement expiry logic themselves. Represented as Unix time UTC, seconds
     -+	since 1970.
     ++	Generated passwords such as an OAuth access token may have an expiry date.
     ++	When reading credentials from helpers, `git credential fill` ignores expired
     ++	passwords. Represented as Unix time UTC, seconds since 1970.
      +
       `url`::
       
       	When this special attribute is read by `git credential`, the
      
     + ## Documentation/gitcredentials.txt ##
     +@@ Documentation/gitcredentials.txt: helper::
     + If there are multiple instances of the `credential.helper` configuration
     + variable, each helper will be tried in turn, and may provide a username,
     + password, or nothing. Once Git has acquired both a username and a
     +-password, no more helpers will be tried.
     ++unexpired password, no more helpers will be tried.
     + +
     + If `credential.helper` is configured to the empty string, this resets
     + the helper list to empty (so you may override a helper set by a
     +
       ## builtin/credential-cache--daemon.c ##
      @@ builtin/credential-cache--daemon.c: static void serve_one_client(FILE *in, FILE *out)
       		if (e) {
     @@ credential.c
       
       void credential_init(struct credential *c)
       {
     -@@ credential.c: static void credential_getpass(struct credential *c)
     - 	if (!c->username)
     - 		c->username = credential_ask_one("Username", c,
     - 						 PROMPT_ASKPASS|PROMPT_ECHO);
     --	if (!c->password)
     -+	if (!c->password || c->password_expiry_utc < time(NULL)) {
     -+		c->password_expiry_utc = TIME_MAX;
     - 		c->password = credential_ask_one("Password", c,
     - 						 PROMPT_ASKPASS);
     -+	}
     - }
     - 
     - int credential_read(struct credential *c, FILE *fp)
     - {
     - 	struct strbuf line = STRBUF_INIT;
     - 
     -+	int password_updated = 0;
     -+	timestamp_t this_password_expiry = TIME_MAX;
     -+
     - 	while (strbuf_getline(&line, fp) != EOF) {
     - 		char *key = line.buf;
     - 		char *value = strchr(key, '=');
     -@@ credential.c: int credential_read(struct credential *c, FILE *fp)
     - 		} else if (!strcmp(key, "password")) {
     - 			free(c->password);
     - 			c->password = xstrdup(value);
     -+			password_updated = 1;
     - 		} else if (!strcmp(key, "protocol")) {
     - 			free(c->protocol);
     - 			c->protocol = xstrdup(value);
      @@ credential.c: int credential_read(struct credential *c, FILE *fp)
       		} else if (!strcmp(key, "path")) {
       			free(c->path);
       			c->path = xstrdup(value);
      +		} else if (!strcmp(key, "password_expiry_utc")) {
     -+			this_password_expiry = parse_timestamp(value, NULL, 10);
     -+			if (this_password_expiry == 0 || errno) {
     -+				this_password_expiry = TIME_MAX;
     -+			}
     ++			c->password_expiry_utc = parse_timestamp(value, NULL, 10);
     ++			if (c->password_expiry_utc == 0 || errno)
     ++				c->password_expiry_utc = TIME_MAX;
       		} else if (!strcmp(key, "url")) {
       			credential_from_url(c, value);
       		} else if (!strcmp(key, "quit")) {
     -@@ credential.c: int credential_read(struct credential *c, FILE *fp)
     - 		 */
     - 	}
     - 
     -+	if (password_updated)
     -+		c->password_expiry_utc = this_password_expiry;
     -+
     - 	strbuf_release(&line);
     - 	return 0;
     - }
      @@ credential.c: void credential_write(const struct credential *c, FILE *fp)
       	credential_write_item(fp, "path", c->path, 0);
       	credential_write_item(fp, "username", c->username, 0);
     @@ credential.c: void credential_fill(struct credential *c)
       
       	for (i = 0; i < c->helpers.nr; i++) {
       		credential_do(c, c->helpers.items[i].string, "get");
     --		if (c->username && c->password)
     -+		if (c->username && c->password && time(NULL) < c->password_expiry_utc)
     ++		if (c->password_expiry_utc < time(NULL)) {
     ++			FREE_AND_NULL(c->password);
     ++			c->password_expiry_utc = TIME_MAX;
     ++		}
     + 		if (c->username && c->password)
       			return;
       		if (c->quit)
     - 			die("credential helper '%s' told us to quit",
     +@@ credential.c: void credential_approve(struct credential *c)
     + 
     + 	if (c->approved)
     + 		return;
     +-	if (!c->username || !c->password)
     ++	if (!c->username || !c->password || c->password_expiry_utc < time(NULL))
     + 		return;
     + 
     + 	credential_apply_config(c);
     +@@ credential.c: void credential_reject(struct credential *c)
     + 
     + 	FREE_AND_NULL(c->username);
     + 	FREE_AND_NULL(c->password);
     ++	c->password_expiry_utc = TIME_MAX;
     + 	c->approved = 0;
     + }
     + 
      
       ## credential.h ##
      @@ credential.h: struct credential {
     @@ credential.h: struct credential {
       }
       
       /* Initialize a credential structure, setting all fields to empty. */
     +
     + ## t/t0300-credentials.sh ##
     +@@ t/t0300-credentials.sh: test_expect_success 'setup helper scripts' '
     + 	test -z "$pass" || echo password=$pass
     + 	EOF
     + 
     ++	write_script git-credential-verbatim-with-expiry <<-\EOF &&
     ++	user=$1; shift
     ++	pass=$1; shift
     ++	pexpiry=$1; shift
     ++	. ./dump
     ++	test -z "$user" || echo username=$user
     ++	test -z "$pass" || echo password=$pass
     ++	test -z "$pexpiry" || echo password_expiry_utc=$pexpiry
     ++	EOF
     ++
     + 	PATH="$PWD:$PATH"
     + '
     + 
     +@@ t/t0300-credentials.sh: test_expect_success 'credential_fill continues through partial response' '
     + 	EOF
     + '
     + 
     ++test_expect_success 'credential_fill populates password_expiry_utc' '
     ++	check fill "verbatim-with-expiry one two 9999999999" <<-\EOF
     ++	protocol=http
     ++	host=example.com
     ++	--
     ++	protocol=http
     ++	host=example.com
     ++	username=one
     ++	password=two
     ++	password_expiry_utc=9999999999
     ++	--
     ++	verbatim-with-expiry: get
     ++	verbatim-with-expiry: protocol=http
     ++	verbatim-with-expiry: host=example.com
     ++	EOF
     ++'
     ++
     ++test_expect_success 'credential_fill continues through expired password' '
     ++	check fill "verbatim-with-expiry one two 5" "verbatim three four" <<-\EOF
     ++	protocol=http
     ++	host=example.com
     ++	--
     ++	protocol=http
     ++	host=example.com
     ++	username=three
     ++	password=four
     ++	--
     ++	verbatim-with-expiry: get
     ++	verbatim-with-expiry: protocol=http
     ++	verbatim-with-expiry: host=example.com
     ++	verbatim: get
     ++	verbatim: protocol=http
     ++	verbatim: host=example.com
     ++	verbatim: username=one
     ++	EOF
     ++'
     ++
     + test_expect_success 'credential_fill passes along metadata' '
     + 	check fill "verbatim one two" <<-\EOF
     + 	protocol=ftp
     +@@ t/t0300-credentials.sh: test_expect_success 'credential_approve calls all helpers' '
     + 	EOF
     + '
     + 
     ++test_expect_success 'credential_approve stores password expiry' '
     ++	check approve useless <<-\EOF
     ++	protocol=http
     ++	host=example.com
     ++	username=foo
     ++	password=bar
     ++	password_expiry_utc=9999999999
     ++	--
     ++	--
     ++	useless: store
     ++	useless: protocol=http
     ++	useless: host=example.com
     ++	useless: username=foo
     ++	useless: password=bar
     ++	useless: password_expiry_utc=9999999999
     ++	EOF
     ++'
     ++
     + test_expect_success 'do not bother storing password-less credential' '
     + 	check approve useless <<-\EOF
     + 	protocol=http
     +@@ t/t0300-credentials.sh: test_expect_success 'do not bother storing password-less credential' '
     + 	EOF
     + '
     + 
     ++test_expect_success 'credential_approve does not store expired credential' '
     ++	check approve useless <<-\EOF
     ++	protocol=http
     ++	host=example.com
     ++	username=foo
     ++	password=bar
     ++	password_expiry_utc=5
     ++	--
     ++	--
     ++	EOF
     ++'
     + 
     + test_expect_success 'credential_reject calls all helpers' '
     + 	check reject useless "verbatim one two" <<-\EOF
     +@@ t/t0300-credentials.sh: test_expect_success 'credential_reject calls all helpers' '
     + 	EOF
     + '
     + 
     ++test_expect_success 'credential_reject erases expired credential' '
     ++	check reject useless <<-\EOF
     ++	protocol=http
     ++	host=example.com
     ++	username=foo
     ++	password=bar
     ++	password_expiry_utc=5
     ++	--
     ++	--
     ++	useless: erase
     ++	useless: protocol=http
     ++	useless: host=example.com
     ++	useless: username=foo
     ++	useless: password=bar
     ++	useless: password_expiry_utc=5
     ++	EOF
     ++'
     ++
     + test_expect_success 'usernames can be preserved' '
     + 	check fill "verbatim \"\" three" <<-\EOF
     + 	protocol=http


 Documentation/git-credential.txt   |  6 ++
 Documentation/gitcredentials.txt   |  2 +-
 builtin/credential-cache--daemon.c |  3 +
 credential.c                       | 17 +++++-
 credential.h                       |  2 +
 t/t0300-credentials.sh             | 94 ++++++++++++++++++++++++++++++
 6 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index ac2818b9f66..29d184ab824 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -144,6 +144,12 @@ Git understands the following attributes:
 
 	The credential's password, if we are asking it to be stored.
 
+`password_expiry_utc`::
+
+	Generated passwords such as an OAuth access token may have an expiry date.
+	When reading credentials from helpers, `git credential fill` ignores expired
+	passwords. Represented as Unix time UTC, seconds since 1970.
+
 `url`::
 
 	When this special attribute is read by `git credential`, the
diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 4522471c337..95636b18439 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -167,7 +167,7 @@ helper::
 If there are multiple instances of the `credential.helper` configuration
 variable, each helper will be tried in turn, and may provide a username,
 password, or nothing. Once Git has acquired both a username and a
-password, no more helpers will be tried.
+unexpired password, no more helpers will be tried.
 +
 If `credential.helper` is configured to the empty string, this resets
 the helper list to empty (so you may override a helper set by a
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
index f6389a50684..d3e1bf7a679 100644
--- a/credential.c
+++ b/credential.c
@@ -7,6 +7,7 @@
 #include "prompt.h"
 #include "sigchain.h"
 #include "urlmatch.h"
+#include "git-compat-util.h"
 
 void credential_init(struct credential *c)
 {
@@ -234,6 +235,10 @@ int credential_read(struct credential *c, FILE *fp)
 		} else if (!strcmp(key, "path")) {
 			free(c->path);
 			c->path = xstrdup(value);
+		} else if (!strcmp(key, "password_expiry_utc")) {
+			c->password_expiry_utc = parse_timestamp(value, NULL, 10);
+			if (c->password_expiry_utc == 0 || errno)
+				c->password_expiry_utc = TIME_MAX;
 		} else if (!strcmp(key, "url")) {
 			credential_from_url(c, value);
 		} else if (!strcmp(key, "quit")) {
@@ -269,6 +274,11 @@ void credential_write(const struct credential *c, FILE *fp)
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
@@ -342,6 +352,10 @@ void credential_fill(struct credential *c)
 
 	for (i = 0; i < c->helpers.nr; i++) {
 		credential_do(c, c->helpers.items[i].string, "get");
+		if (c->password_expiry_utc < time(NULL)) {
+			FREE_AND_NULL(c->password);
+			c->password_expiry_utc = TIME_MAX;
+		}
 		if (c->username && c->password)
 			return;
 		if (c->quit)
@@ -360,7 +374,7 @@ void credential_approve(struct credential *c)
 
 	if (c->approved)
 		return;
-	if (!c->username || !c->password)
+	if (!c->username || !c->password || c->password_expiry_utc < time(NULL))
 		return;
 
 	credential_apply_config(c);
@@ -381,6 +395,7 @@ void credential_reject(struct credential *c)
 
 	FREE_AND_NULL(c->username);
 	FREE_AND_NULL(c->password);
+	c->password_expiry_utc = TIME_MAX;
 	c->approved = 0;
 }
 
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
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 3485c0534e6..96391015af5 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -35,6 +35,16 @@ test_expect_success 'setup helper scripts' '
 	test -z "$pass" || echo password=$pass
 	EOF
 
+	write_script git-credential-verbatim-with-expiry <<-\EOF &&
+	user=$1; shift
+	pass=$1; shift
+	pexpiry=$1; shift
+	. ./dump
+	test -z "$user" || echo username=$user
+	test -z "$pass" || echo password=$pass
+	test -z "$pexpiry" || echo password_expiry_utc=$pexpiry
+	EOF
+
 	PATH="$PWD:$PATH"
 '
 
@@ -109,6 +119,43 @@ test_expect_success 'credential_fill continues through partial response' '
 	EOF
 '
 
+test_expect_success 'credential_fill populates password_expiry_utc' '
+	check fill "verbatim-with-expiry one two 9999999999" <<-\EOF
+	protocol=http
+	host=example.com
+	--
+	protocol=http
+	host=example.com
+	username=one
+	password=two
+	password_expiry_utc=9999999999
+	--
+	verbatim-with-expiry: get
+	verbatim-with-expiry: protocol=http
+	verbatim-with-expiry: host=example.com
+	EOF
+'
+
+test_expect_success 'credential_fill continues through expired password' '
+	check fill "verbatim-with-expiry one two 5" "verbatim three four" <<-\EOF
+	protocol=http
+	host=example.com
+	--
+	protocol=http
+	host=example.com
+	username=three
+	password=four
+	--
+	verbatim-with-expiry: get
+	verbatim-with-expiry: protocol=http
+	verbatim-with-expiry: host=example.com
+	verbatim: get
+	verbatim: protocol=http
+	verbatim: host=example.com
+	verbatim: username=one
+	EOF
+'
+
 test_expect_success 'credential_fill passes along metadata' '
 	check fill "verbatim one two" <<-\EOF
 	protocol=ftp
@@ -149,6 +196,24 @@ test_expect_success 'credential_approve calls all helpers' '
 	EOF
 '
 
+test_expect_success 'credential_approve stores password expiry' '
+	check approve useless <<-\EOF
+	protocol=http
+	host=example.com
+	username=foo
+	password=bar
+	password_expiry_utc=9999999999
+	--
+	--
+	useless: store
+	useless: protocol=http
+	useless: host=example.com
+	useless: username=foo
+	useless: password=bar
+	useless: password_expiry_utc=9999999999
+	EOF
+'
+
 test_expect_success 'do not bother storing password-less credential' '
 	check approve useless <<-\EOF
 	protocol=http
@@ -159,6 +224,17 @@ test_expect_success 'do not bother storing password-less credential' '
 	EOF
 '
 
+test_expect_success 'credential_approve does not store expired credential' '
+	check approve useless <<-\EOF
+	protocol=http
+	host=example.com
+	username=foo
+	password=bar
+	password_expiry_utc=5
+	--
+	--
+	EOF
+'
 
 test_expect_success 'credential_reject calls all helpers' '
 	check reject useless "verbatim one two" <<-\EOF
@@ -181,6 +257,24 @@ test_expect_success 'credential_reject calls all helpers' '
 	EOF
 '
 
+test_expect_success 'credential_reject erases expired credential' '
+	check reject useless <<-\EOF
+	protocol=http
+	host=example.com
+	username=foo
+	password=bar
+	password_expiry_utc=5
+	--
+	--
+	useless: erase
+	useless: protocol=http
+	useless: host=example.com
+	useless: username=foo
+	useless: password=bar
+	useless: password_expiry_utc=5
+	EOF
+'
+
 test_expect_success 'usernames can be preserved' '
 	check fill "verbatim \"\" three" <<-\EOF
 	protocol=http

base-commit: 2fc9e9ca3c7505bc60069f11e7ef09b1aeeee473
-- 
gitgitgadget
