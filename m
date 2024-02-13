Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A9661665
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860623; cv=none; b=tlxrlBnfI3KZBmJuDV9t0X3rCjyu7LKKWkZXQ8BcEAI6Irk2QY10EJ6fkvsHPHzfDE1rBA3k61Qq+fmRvI+8UxAd1RgvoDr+4NPW/CUMqgv6w3olPAI4xeUBhXvwvDHODRUht0N7zzExM4dYeMIoW802YX9ssXPwCVWMPbMpMr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860623; c=relaxed/simple;
	bh=2yl2cc0T334lQFLMHazO5RpcQzeW1H9U47XMttFiFm8=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Ftli8V+wbbdrnUeW6QRzSX4Z8MCS6aKMDboFBkebOiczF4H6eQyR6kQhqVkLZe6RgY0yNb1eRdVK+5Q586uHWCp0U6umRglg1mbMTAeQNySw4xAjMmzPyo0q+nmrN5poUAQOg40q4lKj4VZNQ1TFblyNEwT3ppmrYbB0cSujaDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZ9q8GaP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ9q8GaP"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33cd57b86bfso823976f8f.1
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 13:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707860619; x=1708465419; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FeuF/astsqWWv3ANT9cgEVMWG8+Us6flZZTMWjvd2aE=;
        b=fZ9q8GaPvM7QdBMHEBfgT9FtJEtF4jQivAJOodd6JWuAilXIBG1UBCtJKvA67hhmA9
         kt3J5s+bxCcnj6FVNMbtc9nDcztrvw3+tDLlC2yBFx/NHQkf+xnh0EPyjePzGALFg9st
         hvNATj5DAduLC8haaVgy5GWalejkbpkEwK8f8RGAnfL/Qj5ZOGL8yQwJlYyUOrWwtMO9
         /M6SHEj//FbOuGJti/n7ZOxzu7r7RhZOsrtF1SHLXJ1UOIipnFS+Hrz1sIvz3VOCExVO
         6Qn5SwJBakpE9YwlvIbXbmjT92iXO5h/ez09dz0DXzfAXgqHgoKKykyzY1VmocGeCqvJ
         z4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707860619; x=1708465419;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FeuF/astsqWWv3ANT9cgEVMWG8+Us6flZZTMWjvd2aE=;
        b=RNe0u4YIv+AdFm6yLGC8MKjALjO90967KI7LOsA4LYOITpS42OWuEVfFENe14+D1PJ
         zLGlIXtuTgGVk6HI8ajXOwOPTqgJxdJLc1qYEo69U2gBB9H35wjYtAih9FLd4wdRWW2V
         v8wzRnCdf/EOGSlB6x9N/nOaNCqeq4eglJ2UlhVaj2SytLJEOEkr5+hes5pjtGeCopkL
         m20A7hCIy5dqkOrYXyRsyy7S3Y2E8HEi8q+cqi5jaSxJgpvyiacVczAnkGdMNjDNf0DS
         AjJeoYi877NcPwU407pxCdrEpTpZdVIgnb+F8ehGFO8i18Axb2Xh1RkTcXts0PHIco32
         2yPg==
X-Gm-Message-State: AOJu0Yy1DVtecwKbP/gPHBoeVrPRiHFClBxFTcVKiz9xRJ0e/HfhvKpt
	xV+jVWFARy4esqxDWzZoknPegoTuWa/tbehQNHpWJlsaL3pgVCWJO/g4dCe0
X-Google-Smtp-Source: AGHT+IEBTinmwVG9maWN22bobtQF0uRFhSZNrUM60g2/BH0d+10AocT/vtd4ygxqMuTrP62XXQe+zg==
X-Received: by 2002:a5d:6711:0:b0:33c:2e8a:ddee with SMTP id o17-20020a5d6711000000b0033c2e8addeemr334263wru.4.1707860619182;
        Tue, 13 Feb 2024 13:43:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q17-20020a5d61d1000000b0033940016d6esm10435362wrv.93.2024.02.13.13.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 13:43:39 -0800 (PST)
Message-ID: <pull.1663.git.1707860618119.gitgitgadget@gmail.com>
From: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 21:43:38 +0000
Subject: [PATCH] credential/osxkeychain: store new attributes
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
Cc: M Hickford <mirth.hickford@gmail.com>,
    M Hickford <mirth.hickford@gmail.com>

From: M Hickford <mirth.hickford@gmail.com>

d208bfd (credential: new attribute password_expiry_utc, 2023-02-18)
and a5c76569e7 (credential: new attribute oauth_refresh_token)
introduced new credential attributes.

Similar to 7144dee3 (credential/libsecret: erase matching creds only,
2023-07-26), we encode the new attributes in the secret, separated by
newline:

    hunter2
    password_expiry_utc=1684189401
    oauth_refresh_token=xyzzy

This is extensible and backwards compatible. The credential protocol
already assumes that attribute values do not contain newlines.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    [RFC] contrib/credential/osxkeychain: store new attributes
    
    Is any keen MacOS user interested in building and testing this RFC
    patch? I personally don't have a MacOS machine, so haven't tried
    building it. Fixes are surely necessary. Once it builds, you can test
    the feature with:
    
    GIT_TEST_CREDENTIAL_HELPER=osxkeychain ./t0303-credential-external.sh
    
    
    The feature would help git-credential-oauth users on MacOS
    https://github.com/hickford/git-credential-oauth/issues/42

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1663%2Fhickford%2Fosxkeychain-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1663/hickford/osxkeychain-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1663

 .../osxkeychain/git-credential-osxkeychain.c  | 56 ++++++++++++++++++-
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index 5f2e5f16c88..25ffa84f4ba 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -8,6 +8,8 @@ static char *host;
 static char *path;
 static char *username;
 static char *password;
+static char *password_expiry_utc;
+static char *oauth_refresh_token;
 static UInt16 port;
 
 __attribute__((format (printf, 1, 2)))
@@ -22,6 +24,17 @@ static void die(const char *err, ...)
 	exit(1);
 }
 
+
+static void *xmalloc(size_t size)
+{
+	void *ret = malloc(size);
+	if (!ret && !size)
+		ret = malloc(1);
+	if (!ret)
+		 die("Out of memory");
+	return ret;
+}
+
 static void *xstrdup(const char *s1)
 {
 	void *ret = strdup(s1);
@@ -69,11 +82,27 @@ static void find_internet_password(void)
 	void *buf;
 	UInt32 len;
 	SecKeychainItemRef item;
+	char *line;
+	char *remaining_lines;
+	char *part;
+	char *remaining_parts;
 
 	if (SecKeychainFindInternetPassword(KEYCHAIN_ARGS, &len, &buf, &item))
 		return;
 
-	write_item("password", buf, len);
+	line = strtok_r(buf, "\n", &remaining_lines);
+	write_item("password", line, strlen(line));
+	while(line != NULL) {
+		part = strtok_r(line, "=", &remaining_parts);
+		if (!strcmp(part, "oauth_refresh_token")) {
+			write_item("oauth_refresh_token", remaining_parts, strlen(remaining_parts));
+		}
+		if (!strcmp(part, "password_expiry_utc")) {
+			write_item("password_expiry_utc", remaining_parts, strlen(remaining_parts));
+		}
+		line = strtok_r(NULL, "\n", &remaining_lines);
+	}
+
 	if (!username)
 		find_username_in_item(item);
 
@@ -100,13 +129,32 @@ static void delete_internet_password(void)
 
 static void add_internet_password(void)
 {
+	int len;
+
 	/* Only store complete credentials */
 	if (!protocol || !host || !username || !password)
 		return;
 
+	char *secret;
+	if (password_expiry_utc && oauth_refresh_token) {
+		len = strlen(password) + strlen(password_expiry_utc) + strlen(oauth_refresh_token) + strlen("\npassword_expiry_utc=\noauth_refresh_token=");
+		secret = xmalloc(len);
+		snprintf(secret, len, len, "%s\npassword_expiry_utc=%s\noauth_refresh_token=%s", password, oauth_refresh_token);
+	} else if (oauth_refresh_token) {
+		len = strlen(password) + strlen(oauth_refresh_token) + strlen("\noauth_refresh_token=");
+		secret = xmalloc(len);
+		snprintf(secret, len, len, "%s\noauth_refresh_token=%s", password, oauth_refresh_token);
+	} else if (password_expiry_utc) {
+		len = strlen(password) + strlen(password_expiry_utc) + strlen("\npassword_expiry_utc=");
+		secret = xmalloc(len);
+		snprintf(secret, len, len, "%s\npassword_expiry_utc=%s", password, password_expiry_utc);
+	} else {
+		secret = xstrdup(password);
+	}
+
 	if (SecKeychainAddInternetPassword(
 	      KEYCHAIN_ARGS,
-	      KEYCHAIN_ITEM(password),
+	      KEYCHAIN_ITEM(secret),
 	      NULL))
 		return;
 }
@@ -161,6 +209,10 @@ static void read_credential(void)
 			username = xstrdup(v);
 		else if (!strcmp(buf, "password"))
 			password = xstrdup(v);
+		else if (!strcmp(buf, "password_expiry_utc"))
+			password_expiry_utc = xstrdup(v);
+		else if (!strcmp(buf, "oauth_refresh_token"))
+			oauth_refresh_token = xstrdup(v);
 		/*
 		 * Ignore other lines; we don't know what they mean, but
 		 * this future-proofs us when later versions of git do

base-commit: c875e0b8e036c12cfbf6531962108a063c7a821c
-- 
gitgitgadget
