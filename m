Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E75342CAD
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047604; cv=none; b=YdFxosBF7VFDEQ0vgZOLRl4oi0Qc4VpCUYlO2HC73lFyz5bGHHZAl9OPUBM7PMGm1nWyUChIIyT6Ce1I/6xMtyecVO1IGycV/IvAof9WCiNI7eiZjBXfc2hLyD9cyBShXeHl5htGF1qnZr1Aof9EZ0ZRE+a0FW0A0I24UbBQTf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047604; c=relaxed/simple;
	bh=VLZjJt/ylcDqkdllMl3PSA2d3cVBnWJ7nhgHhtDLvh8=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=E4G3cbCyU1pl/H2pG6r1SQS1mbTDN1tC88hEjMM+kV5m2Tq22STI50QLsLZcU/hN1HAb/rRZI1jW/oUVhD01yIQwLfSXk0qfH6TT6JcJci3ORW5cimVjigKMIO12qFPxLlUySsLM067JvHuVx/+RuzmZF7SHLaCLyxNcJmNj5RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bE7JM8B6; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bE7JM8B6"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-297f35be2ffso13727535ad.2
        for <git@vger.kernel.org>; Thu, 13 Nov 2025 07:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763047601; x=1763652401; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v9aZRKrhKMkZbhq3KRVa81PWOcGa0shSWcWaUJ1GV4I=;
        b=bE7JM8B6uSCy3QlBCPTJs9nBD3x9ih7BoWHoncoilzmJ+4mSs6orP9Y+jeCRVL37W9
         XGfevywMB/zI3o1M1zt6hXxaS1A6HB0fu4eaFYH9vPmub0Fzu0Q3nzoSPJXAudH1FZsE
         jas54y7Y/IgKZrtLedCHv6CpOiMeRaXEDYtcIso9dd/VxOtm7P4fhpPgw9qFjFj0h9Ud
         YMGLDoyHnJ0baYw9gsEsvIsU8zVdqEJHG7MNlvoemvitBVJpuTgepVlqOfby9NN/I5Es
         qkhD5Ew54cHcgjO3txoFU8wMV8+kpCzRabXAad4yl0GGrPnNJfGPgO16PQIhgwjmV56X
         Xljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763047601; x=1763652401;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9aZRKrhKMkZbhq3KRVa81PWOcGa0shSWcWaUJ1GV4I=;
        b=n6Z2OEObZuBNbpC5oSTjH6am+oHUtOknoR5fuD2JgCzQ71xWMWvRbFkYgpDghBVrfK
         AMa4oq6uhdkhNLsu0/nJktZYf/uUToEhyI5XwyXFhpiS2qU+afZwCyX5rmb4CTO9w7QZ
         4gpvZ75Ij6HDsJdRCV8WfWqufqldv6CY/54D2dUM+bcvy4w50Ylg2CAZR33qcUxjX5n/
         jTriktsFpRWyUgaGG9PSRAWg7jGcg4tnBnjjXfjfxGe80xdX5qsV0iQ+qxrfC2UEaYfN
         9CQWf4ZZmTLv/WF7NU6DJ9saSBlGOEQnX9KbjQZoXAxv9CMNL2Kj2G4/CuO5E4ROioM/
         SpRQ==
X-Gm-Message-State: AOJu0YwLrXHXUi3miI//6LeofLcZbKMDqcazKT2oqtPRPAVAaTXQ/2sd
	2Zfyd9MMJ8G028/0Gc4HSbkS+P2yzf9NvUL2uQ193o3iJmxQ4B1URSPH767Ddw==
X-Gm-Gg: ASbGncvzA5juEFdNpVG4jm0uIe/m/k8U1ugKtuo5yp6/UiYAyrBbgNgVmfMljvlM48U
	VZlrnz27etC17V2RLSLGw2+YmLEs+7+uQusku8dFTncrutYlrpLqGjet0/I9Cg9k7gVwopbv1+A
	/d/4IqR49JIuH96wAa0TFdjSUpHDBJHzfSQIhP3p2G+P3HzRb/BCQS6A4SGyCfiNisUNYDWswOs
	ePRRjFFPWvxvsboMUkkFjjbLhyvjkEnMSc31UZIEab40zJckAcgXDGjmrSH8psaDiHSPqGd5rC5
	0pwaDjGVahv012lT/Gm8H3JB4EjVC8+fcCBySZSkt5p3Wew8o7R4Gu7Rcg87e3oHaOjEslbxAU+
	KTzw+OVN1AsDOtNWpVREywafnXDQtPuc+aeX+BeHekAkhadvjSNX8dE/H+n51QiN8v8uJp3oQmA
	m+8sIHZR7fI/p7/Q==
X-Google-Smtp-Source: AGHT+IGXs36Ev+1QYODpNmeC0vBR49rNxolQEZ/gj2fiMZ1slylmcOZnchA2633KjvrZJY0VNFncAQ==
X-Received: by 2002:a17:903:1a43:b0:295:9db1:ff2b with SMTP id d9443c01a7336-2984ee03543mr84726585ad.57.1763047601089;
        Thu, 13 Nov 2025 07:26:41 -0800 (PST)
Received: from [127.0.0.1] ([172.182.209.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bed4fsm29463365ad.75.2025.11.13.07.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 07:26:40 -0800 (PST)
Message-Id: <pull.1999.git.1763047599254.gitgitgadget@gmail.com>
From: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Nov 2025 15:26:39 +0000
Subject: [PATCH] osxkeychain: avoid incorrectly skipping store operation
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Koji Nakamaru <koji.nakamaru@gree.net>,
    Koji Nakamaru <koji.nakamaru@gree.net>

From: Koji Nakamaru <koji.nakamaru@gree.net>

git-credential-osxkeychain skips storing a credential if its "get"
action sets "state[]=osxkeychain:seen=1". This behavior was introduced
in e1ab45b2 (osxkeychain: state to skip unnecessary store operations,
2024-05-15), which appeared in v2.46.

However, this state[] persists even if a credential returned by
"git-credential-osxkeychain get" is invalid and a subsequent helper's
"get" operation returns a valid credential. Another subsequent helper
(such as [1]) may expect git-credential-osxkeychain to store the valid
credential, but the "store" operation is incorrectly skipped because it
only checks "state[]=osxkeychain:seen=1".

To solve this issue, "state[]=osxkeychain:seen" needs to contain enough
information to identify whether the current "store" input matches the
output from the previous "get" operation (and not a credential from
another helper).

Set "state[]=osxkeychain:seen" to a value encoding the credential output
by "get", and compare it with a value encoding the credential input by
"store".

[1]: https://github.com/hickford/git-credential-oauth

Reported-by: Petter Sælen <petter@saelen.eu>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
---
    osxkeychain: avoid incorrectly skipping store operation

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1999%2FKojiNakamaru%2Ffix%2Fosxkeychain-state-seen-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1999/KojiNakamaru/fix/osxkeychain-state-seen-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1999

 .../osxkeychain/git-credential-osxkeychain.c  | 158 +++++++++++++++++-
 1 file changed, 151 insertions(+), 7 deletions(-)

diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index 611c9798b3..c973e844a5 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -12,7 +12,7 @@ static CFStringRef username;
 static CFDataRef password;
 static CFDataRef password_expiry_utc;
 static CFDataRef oauth_refresh_token;
-static int state_seen;
+static char *state_seen;
 
 static void clear_credential(void)
 {
@@ -61,6 +61,12 @@ static void die(const char *err, ...)
 	exit(1);
 }
 
+/*
+ * NOTE: We could use functions in strbuf.h and/or wrapper.h, but those
+ * introduce significant dependencies. Therefore, we define simplified
+ * versions here to keep this code self-contained.
+ */
+
 static void *xmalloc(size_t len)
 {
 	void *ret = malloc(len);
@@ -69,6 +75,30 @@ static void *xmalloc(size_t len)
 	return ret;
 }
 
+static void *xcalloc(size_t count, size_t size)
+{
+	void *ret = calloc(count, size);
+	if (!ret)
+		die("Out of memory");
+	return ret;
+}
+
+static void *xrealloc(void *ptr, size_t size)
+{
+	void *ret = realloc(ptr, size);
+	if (!ret)
+		die("Out of memory");
+	return ret;
+}
+
+static char *xstrdup(const char *str)
+{
+	char *ret = strdup(str);
+	if (!ret)
+		die("Out of memory");
+	return ret;
+}
+
 static CFDictionaryRef create_dictionary(CFAllocatorRef allocator, ...)
 {
 	va_list args;
@@ -112,6 +142,98 @@ static void write_item(const char *what, const char *buf, size_t len)
 	putchar('\n');
 }
 
+struct sb {
+	char *buf;
+	int size;
+};
+
+static void sb_init(struct sb *sb)
+{
+	sb->size = 1024;
+	sb->buf = xcalloc(sb->size, 1);
+}
+
+static void sb_release(struct sb *sb)
+{
+	if (sb->buf) {
+		free(sb->buf);
+		sb->buf = NULL;
+		sb->size = 0;
+	}
+}
+
+static void sb_add(struct sb *sb, const char *s, int n)
+{
+	int len = strlen(sb->buf);
+	int size = sb->size;
+	if (size < len + n + 1) {
+		sb->size = len + n + 1;
+		sb->buf = xrealloc(sb->buf, sb->size);
+	}
+	strncat(sb->buf, s, n);
+	sb->buf[len + n] = '\0';
+}
+
+static void write_item_sb(struct sb *sb, const char *what, const char *buf, int n)
+{
+	char s[32];
+
+	sprintf(s, "__%s=", what);
+	sb_add(sb, s, strlen(s));
+	sb_add(sb, buf, n);
+}
+
+static void write_item_sb_cfstring(struct sb *sb, const char *what, CFStringRef ref)
+{
+	char *buf;
+	int len;
+
+	if (!ref)
+		return;
+	len = CFStringGetMaximumSizeForEncoding(CFStringGetLength(ref), ENCODING) + 1;
+	buf = xmalloc(len);
+	if (CFStringGetCString(ref, buf, len, ENCODING))
+		write_item_sb(sb, what, buf, strlen(buf));
+	free(buf);
+}
+
+static void write_item_sb_cfnumber(struct sb *sb, const char *what, CFNumberRef ref)
+{
+	short n;
+	char buf[32];
+
+	if (!ref)
+		return;
+	if (!CFNumberGetValue(ref, kCFNumberShortType, &n))
+		return;
+	sprintf(buf, "%d", n);
+	write_item_sb(sb, what, buf, strlen(buf));
+}
+
+static void write_item_sb_cfdata(struct sb *sb, const char *what, CFDataRef ref)
+{
+	char *buf;
+	int len;
+
+	if (!ref)
+		return;
+	buf = (char *)CFDataGetBytePtr(ref);
+	if (!buf || strlen(buf) == 0)
+		return;
+	len = CFDataGetLength(ref);
+	write_item_sb(sb, what, buf, len);
+}
+
+static void encode_state_seen(struct sb *sb)
+{
+	sb_add(sb, "osxkeychain:seen=", strlen("osxkeychain:seen="));
+	write_item_sb_cfstring(sb, "host", host);
+	write_item_sb_cfnumber(sb, "port", port);
+	write_item_sb_cfstring(sb, "path", path);
+	write_item_sb_cfstring(sb, "username", username);
+	write_item_sb_cfdata(sb, "password", password);
+}
+
 static void find_username_in_item(CFDictionaryRef item)
 {
 	CFStringRef account_ref;
@@ -124,6 +246,7 @@ static void find_username_in_item(CFDictionaryRef item)
 		write_item("username", "", 0);
 		return;
 	}
+	username = CFStringCreateCopy(kCFAllocatorDefault, account_ref);
 
 	username_buf = (char *)CFStringGetCStringPtr(account_ref, ENCODING);
 	if (username_buf)
@@ -163,6 +286,7 @@ static OSStatus find_internet_password(void)
 	}
 
 	data = CFDictionaryGetValue(item, kSecValueData);
+	password = CFDataCreateCopy(kCFAllocatorDefault, data);
 
 	write_item("password",
 		   (const char *)CFDataGetBytePtr(data),
@@ -173,7 +297,14 @@ static OSStatus find_internet_password(void)
 	CFRelease(item);
 
 	write_item("capability[]", "state", strlen("state"));
-	write_item("state[]", "osxkeychain:seen=1", strlen("osxkeychain:seen=1"));
+	{
+		struct sb sb;
+
+		sb_init(&sb);
+		encode_state_seen(&sb);
+		write_item("state[]", sb.buf, strlen(sb.buf));
+		sb_release(&sb);
+	}
 
 out:
 	CFRelease(attrs);
@@ -288,13 +419,22 @@ static OSStatus add_internet_password(void)
 	CFDictionaryRef attrs;
 	OSStatus result;
 
-	if (state_seen)
-		return errSecSuccess;
-
 	/* Only store complete credentials */
 	if (!protocol || !host || !username || !password)
 		return -1;
 
+	if (state_seen) {
+		struct sb sb;
+
+		sb_init(&sb);
+		encode_state_seen(&sb);
+		if (!strcmp(state_seen, sb.buf)) {
+			sb_release(&sb);
+			return errSecSuccess;
+		}
+		sb_release(&sb);
+	}
+
 	data = CFDataCreateMutableCopy(kCFAllocatorDefault, 0, password);
 	if (password_expiry_utc) {
 		CFDataAppendBytes(data,
@@ -403,8 +543,9 @@ static void read_credential(void)
 							   (UInt8 *)v,
 							   strlen(v));
 		else if (!strcmp(buf, "state[]")) {
-			if (!strcmp(v, "osxkeychain:seen=1"))
-				state_seen = 1;
+			int len = strlen("osxkeychain:seen=");
+			if (!strncmp(v, "osxkeychain:seen=", len))
+				state_seen = xstrdup(v);
 		}
 		/*
 		 * Ignore other lines; we don't know what they mean, but
@@ -443,5 +584,8 @@ int main(int argc, const char **argv)
 
 	clear_credential();
 
+	if (state_seen)
+		free(state_seen);
+
 	return 0;
 }

base-commit: 4badef0c3503dc29059d678abba7fac0f042bc84
-- 
gitgitgadget
