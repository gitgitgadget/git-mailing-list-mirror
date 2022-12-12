Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DE6C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 21:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiLLVgg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 16:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbiLLVga (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 16:36:30 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36D765E5
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:36:29 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h12so13622697wrv.10
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcsLOR+gIEF9OyHWTKumTW6RBJ2+B1MMahHJ0eVDYgY=;
        b=N1c/hvAMn1fedz/oGz92qIndQvhgXfDZjsl4nxD3szMioNUyIeP04sJtQ1jKICozHl
         TIRHp6nmpa7BgBusupJqmmbR9hVKaZo0o7ZbNogc2H/7SrBZoUDg2bWeBLioHR60kfO5
         hTtpv3g2RKdnndPiFxQ9BY0VOlSIYvN2hCjpNDUcquBiFZEJEcLWF7ZbJ49HyHnTZxSL
         lbBIr/u0/lws/ehbfo0sWRbIUfVEHDYt/hG2L1AwTZvlLrwLV83xQkPugOi/teyATJ2+
         A2UnzbgzOHTTpb+F6VdP7Au4VZEHLqkvCHpGpvyixth/8hbveDBX6Vzs55V73rFoDJ6h
         /RZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcsLOR+gIEF9OyHWTKumTW6RBJ2+B1MMahHJ0eVDYgY=;
        b=Ep3+R2WWEBEmzz9wUTOPJ89K/E+WpFbu09bGZ5SowAsaWLLbs5xG363IwA0Ly3KhYb
         sW+NeOu14b64oXZYqgjekdu66wJLcTQYRbm/konRX/O9Br494f2dykUlDFEPd19ViOzH
         QZlEKcOTGKEnM8gQLllsU41XNpS/8BePHKXGIp4WHNpR1sAF2+rxA+r9RCd9zOw+yXeq
         hIbU/e5WtAfFTIZ1WL8dq7D07B9gfHYuNcvyBnNZnAdYrcagh8PhVP47g6kI852MNWnw
         hYUYhqgWmL2Ac0cDZXscoKr7fdOuyV+Blp5XKE9uUjvxEtJHfYfLb9fyz7TEsWWNKsfm
         Bznw==
X-Gm-Message-State: ANoB5pnsF7AB2HkCJv0uO88o902763Ck2zfNh2iespJRKYnVDZyxIaHe
        NOW2SchousyObp3s9OZCABNtMAX40+Q=
X-Google-Smtp-Source: AA0mqf7NCJBhj67ofMIa1d3rat0giJZyJZH++BV6Ekd06OceMZryP86NUeXATwY1i4PLsdbGNsqvtw==
X-Received: by 2002:adf:fd52:0:b0:242:7d25:5892 with SMTP id h18-20020adffd52000000b002427d255892mr10570392wrs.16.1670880988133;
        Mon, 12 Dec 2022 13:36:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l2-20020a056000022200b002420dba6447sm9757834wrz.59.2022.12.12.13.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 13:36:27 -0800 (PST)
Message-Id: <d02875dda7c0939a0de59a47fa9eb3a73ebd29a4.1670880984.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
References: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
        <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Dec 2022 21:36:17 +0000
Subject: [PATCH v4 2/8] credential: add WWW-Authenticate header to cred
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
        Matthew John Cheetham <mjcheetham@github.com>,
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

[1] https://datatracker.ietf.org/doc/html/rfc2616#section-14.47

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 Documentation/git-credential.txt | 18 +++++++++++++++++-
 credential.c                     | 12 ++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index ac2818b9f66..bf0de0e9408 100644
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
 
@@ -160,6 +166,16 @@ empty string.
 Components which are missing from the URL (e.g., there is no
 username in the example above) will be left unset.
 
+`wwwauth[]`::
+
+	When an HTTP response is received by Git that includes one or more
+	'WWW-Authenticate' authentication headers, these will be passed by Git
+	to credential helpers.
+	Each 'WWW-Authenticate' header value is passed as a multi-valued
+	attribute 'wwwauth[]', where the order of the attributes is the same as
+	they appear in the HTTP response. This attribute is 'one-way' from Git
+	to pass additional information to credential helpers.
+
 Unrecognised attributes are silently discarded.
 
 GIT
diff --git a/credential.c b/credential.c
index 897b4679333..8a3ad6c0ae2 100644
--- a/credential.c
+++ b/credential.c
@@ -263,6 +263,17 @@ static void credential_write_item(FILE *fp, const char *key, const char *value,
 	fprintf(fp, "%s=%s\n", key, value);
 }
 
+static void credential_write_strvec(FILE *fp, const char *key,
+				    const struct strvec *vec)
+{
+	int i = 0;
+	const char *full_key = xstrfmt("%s[]", key);
+	for (; i < vec->nr; i++) {
+		credential_write_item(fp, full_key, vec->v[i], 0);
+	}
+	free((void*)full_key);
+}
+
 void credential_write(const struct credential *c, FILE *fp)
 {
 	credential_write_item(fp, "protocol", c->protocol, 1);
@@ -270,6 +281,7 @@ void credential_write(const struct credential *c, FILE *fp)
 	credential_write_item(fp, "path", c->path, 0);
 	credential_write_item(fp, "username", c->username, 0);
 	credential_write_item(fp, "password", c->password, 0);
+	credential_write_strvec(fp, "wwwauth", &c->wwwauth_headers);
 }
 
 static int run_credential_helper(struct credential *c,
-- 
gitgitgadget

