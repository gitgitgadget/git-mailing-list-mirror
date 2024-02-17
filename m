Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FA37FBCE
	for <git@vger.kernel.org>; Sat, 17 Feb 2024 23:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708212902; cv=none; b=QE5oE7pzYDYRF9jTOQBz1M2G31vqOsebH8sxQFynjjEkuC5tiwk8HatW6BvBglQCayF4nnV/F/vtHZmH5G7ANvUVWXn5/f1UQLrp7k8mMSJkI7vYbWsfEG6XuJOusJosdZr8sgjG8rjSPWJhvE/154nwPsTvqlOQH+Q/ts8cDzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708212902; c=relaxed/simple;
	bh=rJO5AFzlNWB2aLm6k6vOuTG9txMapd8R9nPOOCxb45g=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mQjhlXeAZQxAlp4t4fvnwNTp0NBVNpilbVMauBrqX9/tcjzZkkOceW8eth2DfqOkiBojLOXInQeg8FeSZ02LIHehLrBznyV55D+9XMOcEQCl1zDbS9avBMKsIDN8UZynHEwt2PzW292zJLf9iDCDKiwS5TxpYNhJ3w/CB0zH8qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0PTnQpL; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0PTnQpL"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41259f06e94so6160505e9.2
        for <git@vger.kernel.org>; Sat, 17 Feb 2024 15:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708212898; x=1708817698; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZCvLYdvpjXcv4tsrMvKoLKxHPlI73UmauNOCTcslBQ=;
        b=I0PTnQpLu6ZoQ6cVlaDo2JE9t1X4bBvvSR2Fy/rpWRcU6kyQyIP1ttKU0eOFMkXc1M
         Nh2cy9eTpmdhBe4L6kz0hG/f4HJD7aaxdP1UjHllI6W59+i8pW9Rc/btLe4CDVr8YHkV
         K9IoEacjRxJGini0L55LoCIKs1uOirRqQiLCKyOVAqIh8PZSP4+FyUQmwE4cU49o5KPd
         51BkSq0t/qeQfF34haLKupV1ezJhB+YdbdfI6fUeFEbJGSxwY81Duby7xXLDGANfDfqb
         srl9Fv0XrNVTxbVikC6v00vUbD0I6xkERbAXfahQFiwGmmhJp0qMF8I9mAjh7goNiUwq
         nA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708212898; x=1708817698;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZCvLYdvpjXcv4tsrMvKoLKxHPlI73UmauNOCTcslBQ=;
        b=oIVpPDU4bbVXtd2/egRvUGDdaYQgs7CmM+y39o2GrY3TJrxmrjJwQEF8QEBqJC7BCV
         362vTwlQvQZQ8cwLLzRi3E5d+Df0hxEDC/m6TO8Zvv1b1yA/pWwdhkh0+vKMZ4zmL0LW
         1W4FFpdiDz5RsEjkm2catfT5nQvX3SyslRStluKf98giouBMmI8jWjgZjOqcGXbv1mrU
         acBanG47QJCSf34iS0eQodWVeso2q4k1WA4Hn9WMAAgR01ar4e23QUjLpcSMnT0WS0Dv
         0rgt0jhUtXyeENVET9TLd+bmoKVBfq5zYFXncLzKMyKCqYo1cINNbrTlHE+jHw4G7f0E
         f5aA==
X-Gm-Message-State: AOJu0YwR2GaihsfAX5UEd1M9NHwIvU3UYxDoUHxsleAOvYO0G13oxUKC
	Fadh6z208l7zrejTx4UROCPkRgtiCvQNPtv9KOjfI7I2T6ecHn79oAtl30pX
X-Google-Smtp-Source: AGHT+IGLGU8BzZvnbO6pLGH7jrP4GlonPNtHaMFycRkukXAOD7VBfbe6wgXexbitz3dYKayJN5qsmA==
X-Received: by 2002:a05:600c:450f:b0:412:6015:3dbd with SMTP id t15-20020a05600c450f00b0041260153dbdmr571885wmo.4.1708212898069;
        Sat, 17 Feb 2024 15:34:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d5687000000b0033ce727e728sm5911666wrv.94.2024.02.17.15.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 15:34:57 -0800 (PST)
Message-ID: <f7031316a043b36fac10ecf784d2294894967e7b.1708212896.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1667.git.1708212896.gitgitgadget@gmail.com>
References: <pull.1667.git.1708212896.gitgitgadget@gmail.com>
From: "Bo Anderson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 17 Feb 2024 23:34:53 +0000
Subject: [PATCH 1/4] osxkeychain: replace deprecated SecKeychain API
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
Cc: Bo Anderson <mail@boanderson.me>,
    Bo Anderson <mail@boanderson.me>

From: Bo Anderson <mail@boanderson.me>

The SecKeychain API was deprecated in macOS 10.10, nearly 10 years ago.
The replacement SecItem API however is available as far back as macOS
10.6.

While supporting older macOS was perhaps prevously a concern,
git-credential-osxkeychain already requires a minimum of macOS 10.7
since 5747c8072b (contrib/credential: avoid fixed-size buffer in
osxkeychain, 2023-05-01) so using the newer API should not regress the
range of macOS versions supported.

Adapting to use the newer SecItem API also happens to fix two test
failures in osxkeychain:

    8 - helper (osxkeychain) overwrites on store
    9 - helper (osxkeychain) can forget host

The new API is compatible with credentials saved with the older API.

Signed-off-by: Bo Anderson <mail@boanderson.me>
---
 contrib/credential/osxkeychain/Makefile       |   3 +-
 .../osxkeychain/git-credential-osxkeychain.c  | 265 +++++++++++++-----
 2 files changed, 199 insertions(+), 69 deletions(-)

diff --git a/contrib/credential/osxkeychain/Makefile b/contrib/credential/osxkeychain/Makefile
index 4b3a08a2bac..238f5f8c36f 100644
--- a/contrib/credential/osxkeychain/Makefile
+++ b/contrib/credential/osxkeychain/Makefile
@@ -8,7 +8,8 @@ CFLAGS = -g -O2 -Wall
 -include ../../../config.mak
 
 git-credential-osxkeychain: git-credential-osxkeychain.o
-	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS) -Wl,-framework -Wl,Security
+	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS) \
+		-framework Security -framework CoreFoundation
 
 git-credential-osxkeychain.o: git-credential-osxkeychain.c
 	$(CC) -c $(CFLAGS) $<
diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index 5f2e5f16c88..dc294ae944a 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -3,14 +3,39 @@
 #include <stdlib.h>
 #include <Security/Security.h>
 
-static SecProtocolType protocol;
-static char *host;
-static char *path;
-static char *username;
-static char *password;
-static UInt16 port;
-
-__attribute__((format (printf, 1, 2)))
+#define ENCODING kCFStringEncodingUTF8
+static CFStringRef protocol; /* Stores constant strings - not memory managed */
+static CFStringRef host;
+static CFStringRef path;
+static CFStringRef username;
+static CFDataRef password;
+static CFNumberRef port;
+
+static void clear_credential(void)
+{
+	if (host) {
+		CFRelease(host);
+		host = NULL;
+	}
+	if (path) {
+		CFRelease(path);
+		path = NULL;
+	}
+	if (username) {
+		CFRelease(username);
+		username = NULL;
+	}
+	if (password) {
+		CFRelease(password);
+		password = NULL;
+	}
+	if (port) {
+		CFRelease(port);
+		port = NULL;
+	}
+}
+
+__attribute__((format (printf, 1, 2), __noreturn__))
 static void die(const char *err, ...)
 {
 	char msg[4096];
@@ -19,70 +44,135 @@ static void die(const char *err, ...)
 	vsnprintf(msg, sizeof(msg), err, params);
 	fprintf(stderr, "%s\n", msg);
 	va_end(params);
+	clear_credential();
 	exit(1);
 }
 
-static void *xstrdup(const char *s1)
+static void *xmalloc(size_t len)
 {
-	void *ret = strdup(s1);
+	void *ret = malloc(len);
 	if (!ret)
 		die("Out of memory");
 	return ret;
 }
 
-#define KEYCHAIN_ITEM(x) (x ? strlen(x) : 0), x
-#define KEYCHAIN_ARGS \
-	NULL, /* default keychain */ \
-	KEYCHAIN_ITEM(host), \
-	0, NULL, /* account domain */ \
-	KEYCHAIN_ITEM(username), \
-	KEYCHAIN_ITEM(path), \
-	port, \
-	protocol, \
-	kSecAuthenticationTypeDefault
-
-static void write_item(const char *what, const char *buf, int len)
+static CFDictionaryRef create_dictionary(CFAllocatorRef allocator, ...)
+{
+	va_list args;
+	const void *key;
+	CFMutableDictionaryRef result;
+
+	result = CFDictionaryCreateMutable(allocator,
+					   0,
+					   &kCFTypeDictionaryKeyCallBacks,
+					   &kCFTypeDictionaryValueCallBacks);
+
+
+	va_start(args, allocator);
+	while ((key = va_arg(args, const void *)) != NULL) {
+		const void *value;
+		value = va_arg(args, const void *);
+		if (value)
+			CFDictionarySetValue(result, key, value);
+	}
+	va_end(args);
+
+	return result;
+}
+
+#define CREATE_SEC_ATTRIBUTES(...) \
+	create_dictionary(kCFAllocatorDefault, \
+			  kSecClass, kSecClassInternetPassword, \
+			  kSecAttrServer, host, \
+			  kSecAttrAccount, username, \
+			  kSecAttrPath, path, \
+			  kSecAttrPort, port, \
+			  kSecAttrProtocol, protocol, \
+			  kSecAttrAuthenticationType, \
+			  kSecAttrAuthenticationTypeDefault, \
+			  __VA_ARGS__);
+
+static void write_item(const char *what, const char *buf, size_t len)
 {
 	printf("%s=", what);
 	fwrite(buf, 1, len, stdout);
 	putchar('\n');
 }
 
-static void find_username_in_item(SecKeychainItemRef item)
+static void find_username_in_item(CFDictionaryRef item)
 {
-	SecKeychainAttributeList list;
-	SecKeychainAttribute attr;
+	CFStringRef account_ref;
+	char *username_buf;
+	CFIndex buffer_len;
 
-	list.count = 1;
-	list.attr = &attr;
-	attr.tag = kSecAccountItemAttr;
+	account_ref = CFDictionaryGetValue(item, kSecAttrAccount);
+	if (!account_ref)
+	{
+		write_item("username", "", 0);
+		return;
+	}
 
-	if (SecKeychainItemCopyContent(item, NULL, &list, NULL, NULL))
+	username_buf = (char *)CFStringGetCStringPtr(account_ref, ENCODING);
+	if (username_buf)
+	{
+		write_item("username", username_buf, strlen(username_buf));
 		return;
+	}
 
-	write_item("username", attr.data, attr.length);
-	SecKeychainItemFreeContent(&list, NULL);
+	/* If we can't get a CString pointer then
+	 * we need to allocate our own buffer */
+	buffer_len = CFStringGetMaximumSizeForEncoding(
+			CFStringGetLength(account_ref), ENCODING) + 1;
+	username_buf = xmalloc(buffer_len);
+	if (CFStringGetCString(account_ref,
+				username_buf,
+				buffer_len,
+				ENCODING)) {
+		write_item("username", username_buf, buffer_len - 1);
+	}
+	free(username_buf);
 }
 
-static void find_internet_password(void)
+static OSStatus find_internet_password(void)
 {
-	void *buf;
-	UInt32 len;
-	SecKeychainItemRef item;
+	CFDictionaryRef attrs;
+	CFDictionaryRef item;
+	CFDataRef data;
+	OSStatus result;
 
-	if (SecKeychainFindInternetPassword(KEYCHAIN_ARGS, &len, &buf, &item))
-		return;
+	attrs = CREATE_SEC_ATTRIBUTES(kSecMatchLimit, kSecMatchLimitOne,
+				      kSecReturnAttributes, kCFBooleanTrue,
+				      kSecReturnData, kCFBooleanTrue,
+				      NULL);
+	result = SecItemCopyMatching(attrs, (CFTypeRef *)&item);
+	if (result) {
+		goto out;
+	}
 
-	write_item("password", buf, len);
+	data = CFDictionaryGetValue(item, kSecValueData);
+
+	write_item("password",
+		   (const char *)CFDataGetBytePtr(data),
+		   CFDataGetLength(data));
 	if (!username)
 		find_username_in_item(item);
 
-	SecKeychainItemFreeContent(NULL, buf);
+	CFRelease(item);
+
+out:
+	CFRelease(attrs);
+
+	/* We consider not found to not be an error */
+	if (result == errSecItemNotFound)
+		result = errSecSuccess;
+
+	return result;
 }
 
-static void delete_internet_password(void)
+static OSStatus delete_internet_password(void)
 {
-	SecKeychainItemRef item;
+	CFDictionaryRef attrs;
+	OSStatus result;
 
 	/*
 	 * Require at least a protocol and host for removal, which is what git
@@ -90,25 +180,42 @@ static void delete_internet_password(void)
 	 * Keychain manager.
 	 */
 	if (!protocol || !host)
-		return;
+		return -1;
 
-	if (SecKeychainFindInternetPassword(KEYCHAIN_ARGS, 0, NULL, &item))
-		return;
+	attrs = CREATE_SEC_ATTRIBUTES(NULL);
+	result = SecItemDelete(attrs);
+	CFRelease(attrs);
+
+	/* We consider not found to not be an error */
+	if (result == errSecItemNotFound)
+		result = errSecSuccess;
 
-	SecKeychainItemDelete(item);
+	return result;
 }
 
-static void add_internet_password(void)
+static OSStatus add_internet_password(void)
 {
+	CFDictionaryRef attrs;
+	OSStatus result;
+
 	/* Only store complete credentials */
 	if (!protocol || !host || !username || !password)
-		return;
+		return -1;
 
-	if (SecKeychainAddInternetPassword(
-	      KEYCHAIN_ARGS,
-	      KEYCHAIN_ITEM(password),
-	      NULL))
-		return;
+	attrs = CREATE_SEC_ATTRIBUTES(kSecValueData, password,
+				      NULL);
+
+	result = SecItemAdd(attrs, NULL);
+	if (result == errSecDuplicateItem) {
+		CFDictionaryRef query;
+		query = CREATE_SEC_ATTRIBUTES(NULL);
+		result = SecItemUpdate(query, attrs);
+		CFRelease(query);
+	}
+
+	CFRelease(attrs);
+
+	return result;
 }
 
 static void read_credential(void)
@@ -131,36 +238,52 @@ static void read_credential(void)
 
 		if (!strcmp(buf, "protocol")) {
 			if (!strcmp(v, "imap"))
-				protocol = kSecProtocolTypeIMAP;
+				protocol = kSecAttrProtocolIMAP;
 			else if (!strcmp(v, "imaps"))
-				protocol = kSecProtocolTypeIMAPS;
+				protocol = kSecAttrProtocolIMAPS;
 			else if (!strcmp(v, "ftp"))
-				protocol = kSecProtocolTypeFTP;
+				protocol = kSecAttrProtocolFTP;
 			else if (!strcmp(v, "ftps"))
-				protocol = kSecProtocolTypeFTPS;
+				protocol = kSecAttrProtocolFTPS;
 			else if (!strcmp(v, "https"))
-				protocol = kSecProtocolTypeHTTPS;
+				protocol = kSecAttrProtocolHTTPS;
 			else if (!strcmp(v, "http"))
-				protocol = kSecProtocolTypeHTTP;
+				protocol = kSecAttrProtocolHTTP;
 			else if (!strcmp(v, "smtp"))
-				protocol = kSecProtocolTypeSMTP;
-			else /* we don't yet handle other protocols */
+				protocol = kSecAttrProtocolSMTP;
+			else {
+				/* we don't yet handle other protocols */
+				clear_credential();
 				exit(0);
+			}
 		}
 		else if (!strcmp(buf, "host")) {
 			char *colon = strchr(v, ':');
 			if (colon) {
+				UInt16 port_i;
 				*colon++ = '\0';
-				port = atoi(colon);
+				port_i = atoi(colon);
+				port = CFNumberCreate(kCFAllocatorDefault,
+						      kCFNumberShortType,
+						      &port_i);
 			}
-			host = xstrdup(v);
+			host = CFStringCreateWithCString(kCFAllocatorDefault,
+							 v,
+							 ENCODING);
 		}
 		else if (!strcmp(buf, "path"))
-			path = xstrdup(v);
+			path = CFStringCreateWithCString(kCFAllocatorDefault,
+							 v,
+							 ENCODING);
 		else if (!strcmp(buf, "username"))
-			username = xstrdup(v);
+			username = CFStringCreateWithCString(
+					kCFAllocatorDefault,
+					v,
+					ENCODING);
 		else if (!strcmp(buf, "password"))
-			password = xstrdup(v);
+			password = CFDataCreate(kCFAllocatorDefault,
+						(UInt8 *)v,
+						strlen(v));
 		/*
 		 * Ignore other lines; we don't know what they mean, but
 		 * this future-proofs us when later versions of git do
@@ -173,6 +296,7 @@ static void read_credential(void)
 
 int main(int argc, const char **argv)
 {
+	OSStatus result = 0;
 	const char *usage =
 		"usage: git credential-osxkeychain <get|store|erase>";
 
@@ -182,12 +306,17 @@ int main(int argc, const char **argv)
 	read_credential();
 
 	if (!strcmp(argv[1], "get"))
-		find_internet_password();
+		result = find_internet_password();
 	else if (!strcmp(argv[1], "store"))
-		add_internet_password();
+		result = add_internet_password();
 	else if (!strcmp(argv[1], "erase"))
-		delete_internet_password();
+		result = delete_internet_password();
 	/* otherwise, ignore unknown action */
 
+	if (result)
+		die("failed to %s: %d", argv[1], (int)result);
+
+	clear_credential();
+
 	return 0;
 }
-- 
gitgitgadget

