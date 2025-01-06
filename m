Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE561A3AA8
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 19:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736193137; cv=none; b=V9pFuKIowD8orif3QHZm9PAjN+GqTh22VSwV098/kyAl9IqsxSui6BYgu8XJmz5dCDAVkdLzKbEaHN60SV/AiVQtJTGJbLqxijIJo7Ga8d2wA4I9x9P9WsRvMBqE6sUKsxu8xgL5T6J/WoSFqAukFR9D8yGw5Tw8pyeNjAQBZuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736193137; c=relaxed/simple;
	bh=BKJcpNJQyBFXhO31TMITvbuXCBmSNkX24QFHnq59p3M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bE3g/Zo0U0gtJK4aqQVFealMzwgddDJauS4cx+GUxVytIkf07CaFKT7hqdmxU73k2Fpzy9xl5Zr/1nUgtEg9bnwHQ+YhFrlZdKDlqjR6eCOwtv2I1adx8L+zmq3qgtltydxHoclTs7/69NnR7edx4qFiJ9G/aQo6vnO4dPAxMLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+hZOIk8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+hZOIk8"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436637e8c8dso150010795e9.1
        for <git@vger.kernel.org>; Mon, 06 Jan 2025 11:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736193134; x=1736797934; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Rrs+w17WYWOq134ur+2yqiARR6qKferf2C88yG1/Ic=;
        b=T+hZOIk8G2Es0KYkd7r+G5DG0OYpXC1T4qQaDw/SKQkiJdFrnH+NOMNsL6+ODDwTdT
         fWkbKIIN6xGexxfOC7vwgUEE7dESSOxBocWH+g3OpuLB75t1QI3AEbDk+Ps2+0kCUhrx
         KworP+qvM1mhnD1IA6Jg/8HB3/8xLNlUarR9zjEW1kP3c/sApzfy0QMEDegb4pTC7oEq
         /UCDEY/X13mtKjxEpMSzfG7jcGAU/AZOr6h8iSrIivDGJv9dC4Lrjixrx8UoAPXe/jzP
         b8h9uend+6Rg4982K1nNrWzTEjrlICdAEH8Vt5hhMmQ6mSlc86zgJPaGTveoOvLUYuFE
         mylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736193134; x=1736797934;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Rrs+w17WYWOq134ur+2yqiARR6qKferf2C88yG1/Ic=;
        b=S/udeuMKKbH1TXQdh4gq0E32DbgAJdEWRTiacLL/J/0StczwXUQUR0gjGUqYUnsRDf
         Y0ojRaprzncY3tjGoM5NjQTy0y7fICbSFUrQAFprSQa7a+XZ+rUCAedo4/T6Eurx8l0D
         VB/V8wG77LSV11df/8j9Mo0hsMHbLuenIJyWB9avJRyPmqZ5s67HL6rdukWMeld74r+V
         bEKTcy2lo6MWV73A50OOTMoj+3MyJf7NuydlckuDReaAlsjH9XK/Ns+EUsEQb1wqgu8/
         NsYgBUEzIYnoKW4uWJOEmfrL/ZLcRs5rGcAaToAgfCc66JKvutHqdwXarfaHRZhwFKD0
         rx3g==
X-Gm-Message-State: AOJu0YwvRcP2GafLL2+jk5OQKx1wSvubp6Cv5qZmdmpEfHMGuxy2rhsV
	+KG5VOsAtDh9r26V/4dEFmqyF5ixQvW0jcxaR11BaymO4qUYqZ+8vL2/Ng==
X-Gm-Gg: ASbGncvVX0MI0UkOnxdRFMbDZyWyl2wSM+h35Lv9cwkU8ayTBXCl3E6X9eQvUyEN+OS
	IwsPdkstY6tNnws+NSWoSHoSAchdBrIhp5PA54Ow6ONbUmBnjrO8IAfrbAlhAc73CyjikpdsEjq
	hCekRKtN67euxI2hMXOXEQJWnTLfiQN7PMqKhgcCx/FSrmxF2p78jEzTVd3JNwHE1/oFQMgp4rS
	5rX8bHlJqrBXMH+vyIebNq0bOPhwzMwIculu18VkRzfi1Szr6mlKJkIcw==
X-Google-Smtp-Source: AGHT+IFHxK9TAJEo+9mi6unwQ0+34S4FgDQK51NkNOJrrzeYgGvxzrD8PSYSvu1gVKJ7sX6xZ/08EQ==
X-Received: by 2002:a05:6000:1f87:b0:385:fc70:7eb with SMTP id ffacd0b85a97d-38a221e2d62mr46228043f8f.12.1736193133382;
        Mon, 06 Jan 2025 11:52:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656af6c42sm611233515e9.9.2025.01.06.11.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 11:52:12 -0800 (PST)
Message-Id: <pull.1842.v2.git.1736193131798.gitgitgadget@gmail.com>
In-Reply-To: <pull.1842.git.1734729534213.gitgitgadget@gmail.com>
References: <pull.1842.git.1734729534213.gitgitgadget@gmail.com>
From: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Jan 2025 19:52:11 +0000
Subject: [PATCH v2] credential-cache: respect request capabilities
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
    M Hickford <mirth.hickford@gmail.com>,
    M Hickford <mirth.hickford@gmail.com>

From: M Hickford <mirth.hickford@gmail.com>

Previously, credential-cache responded with capability[]=authtype
regardless of request.

The capabilities in a credential helper response should be a subset of
the capabilities in the request.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    credential-cache: respect request capabilities

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1842%2Fhickford%2Fcache-capability-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1842/hickford/cache-capability-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1842

Range-diff vs v1:

 1:  9197941029f ! 1:  696780d4782 credential-cache: respect request capabilities
     @@ t/lib-credential.sh: helper_test_authtype() {
       		EOF
       	'
       
     -+	test_expect_success "helper ($HELPER) does not get authtype and credential without authtype capability" '
     ++	test_expect_success "helper ($HELPER) get authtype only if request has authtype capability" '
      +		check fill $HELPER <<-\EOF
      +		protocol=https
      +		host=git.example.com
     @@ t/lib-credential.sh: helper_test_authtype() {
       	test_expect_success "helper ($HELPER) stores authtype and credential with username" '
       		check approve $HELPER <<-\EOF
       		capability[]=authtype
     -
     - ## t/t0303-credential-external.sh ##
     -@@ t/t0303-credential-external.sh: helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER"
     - helper_test "$GIT_TEST_CREDENTIAL_HELPER"
     - helper_test_password_expiry_utc "$GIT_TEST_CREDENTIAL_HELPER"
     - helper_test_oauth_refresh_token "$GIT_TEST_CREDENTIAL_HELPER"
     -+helper_test_authtype "$GIT_TEST_CREDENTIAL_HELPER"
     - 
     - if test -z "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"; then
     - 	say "# skipping timeout tests (GIT_TEST_CREDENTIAL_HELPER_TIMEOUT not set)"


 builtin/credential-cache--daemon.c | 11 +++++------
 t/lib-credential.sh                | 15 +++++++++++++++
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index bc22f5c6d24..692216cf83c 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -134,17 +134,16 @@ static void serve_one_client(FILE *in, FILE *out)
 	else if (!strcmp(action.buf, "get")) {
 		struct credential_cache_entry *e = lookup_credential(&c);
 		if (e) {
-			e->item.capa_authtype.request_initial = 1;
-			e->item.capa_authtype.request_helper = 1;
-
-			fprintf(out, "capability[]=authtype\n");
+			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_RESPONSE)) {
+				fprintf(out, "capability[]=authtype\n");
+			}
 			if (e->item.username)
 				fprintf(out, "username=%s\n", e->item.username);
 			if (e->item.password)
 				fprintf(out, "password=%s\n", e->item.password);
-			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_HELPER) && e->item.authtype)
+			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_RESPONSE) && e->item.authtype)
 				fprintf(out, "authtype=%s\n", e->item.authtype);
-			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_HELPER) && e->item.credential)
+			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_RESPONSE) && e->item.credential)
 				fprintf(out, "credential=%s\n", e->item.credential);
 			if (e->item.password_expiry_utc != TIME_MAX)
 				fprintf(out, "password_expiry_utc=%"PRItime"\n",
diff --git a/t/lib-credential.sh b/t/lib-credential.sh
index 58b9c740605..324ecc792d5 100644
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -566,6 +566,21 @@ helper_test_authtype() {
 		EOF
 	'
 
+	test_expect_success "helper ($HELPER) get authtype only if request has authtype capability" '
+		check fill $HELPER <<-\EOF
+		protocol=https
+		host=git.example.com
+		--
+		protocol=https
+		host=git.example.com
+		username=askpass-username
+		password=askpass-password
+		--
+		askpass: Username for '\''https://git.example.com'\'':
+		askpass: Password for '\''https://askpass-username@git.example.com'\'':
+		EOF
+	'
+
 	test_expect_success "helper ($HELPER) stores authtype and credential with username" '
 		check approve $HELPER <<-\EOF
 		capability[]=authtype

base-commit: 92999a42db1c5f43f330e4f2bca4026b5b81576f
-- 
gitgitgadget
