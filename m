Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E26EC636D3
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 19:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjBFTaG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 14:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjBFT35 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 14:29:57 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5EEAD1C
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 11:29:55 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso9711747wms.3
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 11:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/UuZ5dZ8KwaWSEkvdwkxrC8WwljJs97TcRAaiIaiBA=;
        b=a37O+ow3/3W3odGuFQ1o7o3n+5MBTMn1BcwhXOIDeg1Di7/9a1g+yAe75NdEkYzmDd
         Ol5CO+Cj9k1RX994rjVmrbygglqwECCmrNE3M6rP8rBPM8caIaQ92o3+ODW3+VcCHgbh
         DC7/XmhH5uLw/Fw1BDFunRaSRw/MW1Sf8D4sBTTiIowwr6Ka3MkdErcA/mgd7fNKdmd4
         AWwQgN+1bW0p5GdkSTeuJ5MtLt7qI42w3DNkd/Wu49upjLnMZxMXfcvyzp+nC2bf8qKG
         zqBnKcGBTfP5UBbXloZV53m/ok7kEB9DRGH2cPg1DSGbzujJcud4A6c6z4ibW13Twuwx
         irOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/UuZ5dZ8KwaWSEkvdwkxrC8WwljJs97TcRAaiIaiBA=;
        b=zzLYuQ3an3eDzl3unBU8zbr+yaUDnimkvZlQX4kqOF8en/jPtSrbmvCayAX/dunxTn
         PW34b+JGRVMTRTUSRPgKPyNaR4EdA+cxSNqqwmW0LEzyj+a/jO+D2J6GF8OoSfa7ttUL
         XQCx6SE21aF9jQW0T/BQFjOfkSGcB3u/j+LOHIBPjd+yE0z8g51+EM+SQE7DyW3PVeZY
         rWTJEU2oZYQ5Ce0poETGCO8pXb6A0Jcp+7tQzdG/iU7/f36dq/msqEhY6cPjqESFrWo8
         vhoS/6HN3Q9kr5jMq/M4EHvV2yODIp6k6iydO3/fP80xkB3nvHopgw38Kba0FB3hThnX
         Aufw==
X-Gm-Message-State: AO0yUKWpKWYouI0MU9U8xUH49mV+QaLGylOliovAy5L8ASUvWPMMpcXC
        L2f0Ud5urvA/TrpkZN66NIkwnc/5lII=
X-Google-Smtp-Source: AK7set+oY3GDkOfuFuFttD+2u9zWnmw2dgIugK60V+q7ctoqnMAatRM5g6W+O202SHM0Dp3qg/wGIQ==
X-Received: by 2002:a05:600c:3287:b0:3dd:1c46:b92 with SMTP id t7-20020a05600c328700b003dd1c460b92mr793203wmp.16.1675711793891;
        Mon, 06 Feb 2023 11:29:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l16-20020a1c7910000000b003dc1d668866sm16406293wme.10.2023.02.06.11.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 11:29:53 -0800 (PST)
Message-Id: <149aedf55010718e22669575a148988eed0d8dcb.1675711789.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v8.git.1675711789.gitgitgadget@gmail.com>
References: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
        <pull.1352.v8.git.1675711789.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Feb 2023 19:29:49 +0000
Subject: [PATCH v8 3/3] credential: add WWW-Authenticate header to cred
 requests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Add the value of the WWW-Authenticate response header to credential
requests. Credential helpers that understand and support HTTP
authentication and authorization can use this standard header (RFC 2616
Section 14.47 [1]) to generate valid credentials.

WWW-Authenticate headers can contain information pertaining to the
authority, authentication mechanism, or extra parameters/scopes that are
required.

The current I/O format for credential helpers only allows for unique
names for properties/attributes, so in order to transmit multiple header
values (with a specific order) we introduce a new convention whereby a
C-style array syntax is used in the property name to denote multiple
ordered values for the same property.

In this case we send multiple `wwwauth[]` properties where the order
that the repeated attributes appear in the conversation reflects the
order that the WWW-Authenticate headers appeared in the HTTP response.

Add a set of tests to exercise the HTTP authentication header parsing
and the interop with credential helpers. Credential helpers will receive
WWW-Authenticate information in credential requests.

[1] https://datatracker.ietf.org/doc/html/rfc2616#section-14.47

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 Documentation/git-credential.txt |  19 ++-
 credential.c                     |  11 ++
 t/t5563-simple-http-auth.sh      | 236 +++++++++++++++++++++++++++++++
 3 files changed, 265 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index ac2818b9f66..50759153ef1 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -113,7 +113,13 @@ separated by an `=` (equals) sign, followed by a newline.
 The key may contain any bytes except `=`, newline, or NUL. The value may
 contain any bytes except newline or NUL.
 
-In both cases, all bytes are treated as-is (i.e., there is no quoting,
+Attributes with keys that end with C-style array brackets `[]` can have
+multiple values. Each instance of a multi-valued attribute forms an
+ordered list of values - the order of the repeated attributes defines
+the order of the values. An empty multi-valued attribute (`key[]=\n`)
+acts to clear any previous entries and reset the list.
+
+In all cases, all bytes are treated as-is (i.e., there is no quoting,
 and one cannot transmit a value with newline or NUL in it). The list of
 attributes is terminated by a blank line or end-of-file.
 
@@ -160,6 +166,17 @@ empty string.
 Components which are missing from the URL (e.g., there is no
 username in the example above) will be left unset.
 
+`wwwauth[]`::
+
+	When an HTTP response is received by Git that includes one or more
+	'WWW-Authenticate' authentication headers, these will be passed by Git
+	to credential helpers.
++
+Each 'WWW-Authenticate' header value is passed as a multi-valued
+attribute 'wwwauth[]', where the order of the attributes is the same as
+they appear in the HTTP response. This attribute is 'one-way' from Git
+to pass additional information to credential helpers.
+
 Unrecognised attributes are silently discarded.
 
 GIT
diff --git a/credential.c b/credential.c
index 897b4679333..9f39ebc3c7e 100644
--- a/credential.c
+++ b/credential.c
@@ -263,6 +263,16 @@ static void credential_write_item(FILE *fp, const char *key, const char *value,
 	fprintf(fp, "%s=%s\n", key, value);
 }
 
+static void credential_write_strvec(FILE *fp, const char *key,
+				    const struct strvec *vec)
+{
+	char *full_key = xstrfmt("%s[]", key);
+	for (size_t i = 0; i < vec->nr; i++) {
+		credential_write_item(fp, full_key, vec->v[i], 0);
+	}
+	free(full_key);
+}
+
 void credential_write(const struct credential *c, FILE *fp)
 {
 	credential_write_item(fp, "protocol", c->protocol, 1);
@@ -270,6 +280,7 @@ void credential_write(const struct credential *c, FILE *fp)
 	credential_write_item(fp, "path", c->path, 0);
 	credential_write_item(fp, "username", c->username, 0);
 	credential_write_item(fp, "password", c->password, 0);
+	credential_write_strvec(fp, "wwwauth", &c->wwwauth_headers);
 }
 
 static int run_credential_helper(struct credential *c,
diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
index 004eac5d1ed..a7b1e5bd1af 100755
--- a/t/t5563-simple-http-auth.sh
+++ b/t/t5563-simple-http-auth.sh
@@ -73,6 +73,242 @@ test_expect_success 'access using basic auth' '
 	expect_credential_query get <<-EOF &&
 	protocol=http
 	host=$HTTPD_DEST
+	wwwauth[]=Basic realm="example.com"
+	EOF
+
+	expect_credential_query store <<-EOF
+	protocol=http
+	host=$HTTPD_DEST
+	username=alice
+	password=secret-passwd
+	EOF
+'
+
+test_expect_success 'access using basic auth invalid credentials' '
+	test_when_finished "per_test_cleanup" &&
+
+	set_credential_reply get <<-EOF &&
+	username=baduser
+	password=wrong-passwd
+	EOF
+
+	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
+	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+	EOF
+
+	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
+	WWW-Authenticate: Basic realm="example.com"
+	EOF
+
+	test_config_global credential.helper test-helper &&
+	test_must_fail git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
+
+	expect_credential_query get <<-EOF &&
+	protocol=http
+	host=$HTTPD_DEST
+	wwwauth[]=Basic realm="example.com"
+	EOF
+
+	expect_credential_query erase <<-EOF
+	protocol=http
+	host=$HTTPD_DEST
+	username=baduser
+	password=wrong-passwd
+	wwwauth[]=Basic realm="example.com"
+	EOF
+'
+
+test_expect_success 'access using basic auth with extra challenges' '
+	test_when_finished "per_test_cleanup" &&
+
+	set_credential_reply get <<-EOF &&
+	username=alice
+	password=secret-passwd
+	EOF
+
+	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
+	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+	EOF
+
+	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
+	WWW-Authenticate: FooBar param1="value1" param2="value2"
+	WWW-Authenticate: Bearer authorize_uri="id.example.com" p=1 q=0
+	WWW-Authenticate: Basic realm="example.com"
+	EOF
+
+	test_config_global credential.helper test-helper &&
+	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
+
+	expect_credential_query get <<-EOF &&
+	protocol=http
+	host=$HTTPD_DEST
+	wwwauth[]=FooBar param1="value1" param2="value2"
+	wwwauth[]=Bearer authorize_uri="id.example.com" p=1 q=0
+	wwwauth[]=Basic realm="example.com"
+	EOF
+
+	expect_credential_query store <<-EOF
+	protocol=http
+	host=$HTTPD_DEST
+	username=alice
+	password=secret-passwd
+	EOF
+'
+
+test_expect_success 'access using basic auth mixed-case wwwauth header name' '
+	test_when_finished "per_test_cleanup" &&
+
+	set_credential_reply get <<-EOF &&
+	username=alice
+	password=secret-passwd
+	EOF
+
+	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
+	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+	EOF
+
+	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
+	www-authenticate: foobar param1="value1" param2="value2"
+	WWW-AUTHENTICATE: BEARER authorize_uri="id.example.com" p=1 q=0
+	WwW-aUtHeNtIcAtE: baSiC realm="example.com"
+	EOF
+
+	test_config_global credential.helper test-helper &&
+	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
+
+	expect_credential_query get <<-EOF &&
+	protocol=http
+	host=$HTTPD_DEST
+	wwwauth[]=foobar param1="value1" param2="value2"
+	wwwauth[]=BEARER authorize_uri="id.example.com" p=1 q=0
+	wwwauth[]=baSiC realm="example.com"
+	EOF
+
+	expect_credential_query store <<-EOF
+	protocol=http
+	host=$HTTPD_DEST
+	username=alice
+	password=secret-passwd
+	EOF
+'
+
+test_expect_success 'access using basic auth with wwwauth header continuations' '
+	test_when_finished "per_test_cleanup" &&
+
+	set_credential_reply get <<-EOF &&
+	username=alice
+	password=secret-passwd
+	EOF
+
+	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
+	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+	EOF
+
+	# Note that leading and trailing whitespace is important to correctly
+	# simulate a continuation/folded header.
+	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
+	WWW-Authenticate: FooBar param1="value1"
+	 param2="value2"
+	WWW-Authenticate: Bearer authorize_uri="id.example.com"
+	 p=1
+	 q=0
+	WWW-Authenticate: Basic realm="example.com"
+	EOF
+
+	test_config_global credential.helper test-helper &&
+	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
+
+	expect_credential_query get <<-EOF &&
+	protocol=http
+	host=$HTTPD_DEST
+	wwwauth[]=FooBar param1="value1" param2="value2"
+	wwwauth[]=Bearer authorize_uri="id.example.com" p=1 q=0
+	wwwauth[]=Basic realm="example.com"
+	EOF
+
+	expect_credential_query store <<-EOF
+	protocol=http
+	host=$HTTPD_DEST
+	username=alice
+	password=secret-passwd
+	EOF
+'
+
+test_expect_success 'access using basic auth with wwwauth header empty continuations' '
+	test_when_finished "per_test_cleanup" &&
+
+	set_credential_reply get <<-EOF &&
+	username=alice
+	password=secret-passwd
+	EOF
+
+	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
+	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+	EOF
+
+	CHALLENGE="$HTTPD_ROOT_PATH/custom-auth.challenge" &&
+
+	# Note that leading and trailing whitespace is important to correctly
+	# simulate a continuation/folded header.
+	printf "">$CHALLENGE &&
+	printf "WWW-Authenticate: FooBar param1=\"value1\"\r\n" >$CHALLENGE &&
+	printf " \r\n" >>$CHALLENGE &&
+	printf " param2=\"value2\"\r\n" >>$CHALLENGE &&
+	printf "WWW-Authenticate: Bearer authorize_uri=\"id.example.com\"\r\n" >>$CHALLENGE &&
+	printf " p=1\r\n" >>$CHALLENGE &&
+	printf " \r\n" >>$CHALLENGE &&
+	printf " q=0\r\n" >>$CHALLENGE &&
+	printf "WWW-Authenticate: Basic realm=\"example.com\"\r\n" >>$CHALLENGE &&
+
+	test_config_global credential.helper test-helper &&
+	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
+
+	expect_credential_query get <<-EOF &&
+	protocol=http
+	host=$HTTPD_DEST
+	wwwauth[]=FooBar param1="value1" param2="value2"
+	wwwauth[]=Bearer authorize_uri="id.example.com" p=1 q=0
+	wwwauth[]=Basic realm="example.com"
+	EOF
+
+	expect_credential_query store <<-EOF
+	protocol=http
+	host=$HTTPD_DEST
+	username=alice
+	password=secret-passwd
+	EOF
+'
+
+test_expect_success 'access using basic auth with wwwauth header mixed line-endings' '
+	test_when_finished "per_test_cleanup" &&
+
+	set_credential_reply get <<-EOF &&
+	username=alice
+	password=secret-passwd
+	EOF
+
+	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
+	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+	EOF
+
+	CHALLENGE="$HTTPD_ROOT_PATH/custom-auth.challenge" &&
+
+	# Note that leading and trailing whitespace is important to correctly
+	# simulate a continuation/folded header.
+	printf "">$CHALLENGE &&
+	printf "WWW-Authenticate: FooBar param1=\"value1\"\r\n" >$CHALLENGE &&
+	printf " \r\n" >>$CHALLENGE &&
+	printf "\tparam2=\"value2\"\r\n" >>$CHALLENGE &&
+	printf "WWW-Authenticate: Basic realm=\"example.com\"" >>$CHALLENGE &&
+
+	test_config_global credential.helper test-helper &&
+	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
+
+	expect_credential_query get <<-EOF &&
+	protocol=http
+	host=$HTTPD_DEST
+	wwwauth[]=FooBar param1="value1" param2="value2"
+	wwwauth[]=Basic realm="example.com"
 	EOF
 
 	expect_credential_query store <<-EOF
-- 
gitgitgadget
