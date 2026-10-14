Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4BF2D3A93
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 20:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792008066; cv=none; b=ZoksSG9rSowLqFbPu1wcIr0KysPDsoxoZsUDQ/UXmAhXxmmYVZ/Pu3WOyqLIOTiegWYUsuvOV7NVnvWRdfK5lM2OKRKFdNq39SBTzQ4RrlFmioP//vUS8OXqXvwdie2VPYHJlthla/lghA/njC5Bs9ovSuusNc3vFASV8J1DFBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792008066; c=relaxed/simple;
	bh=up80lNlffuaDAp52WmEWOVDf1n8oJfwVBcoghKiDhiI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=m92N5N7TVSsBtE3fjrbR8VtEaYHp+X1npfcQgyKrEQuZT+jRGO3WGM7WJC7asspS/WmMUAJWOeAGNwt6IyQej5U6olcjToEFY7+oxq7x4d57NcjYHOqTnLGyNa/UxfuDQxuXV9blcCJyKKSBxpxV/SRWATnRuZyXfunk9a9Vc4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoxIxM4z; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoxIxM4z"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93e027da22eso305807385a.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 13:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792008063; x=1792612863; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vSPDDNDWaqMh8sASENIHn1C/grF8f5bQppXYAt/5Zvk=;
        b=UoxIxM4zTydJgip/4HhjR/9sJqjpKZLegkmU7kFnz6XLEiADMMFEZtpEDZwkaaoQIN
         XFeI0Z0IxpnZz+EnIie/ZpgKjq1cxZ2J1CqyCxSIgtwDdc87QNBMvr3njwbH0gBkKHxJ
         LjfjEWgWf25ECfnmM7xY6AXw+9GOH4UNeHMcGU2mKsfp9ET5upQuxqRceXT1WGnR5yCD
         8IecVwf8dwZlk9Un1Z//v6lWsZnlefu9VeWUvqo6zAHNLhxwKRzThDIHe2tDU2cak4vu
         PxP98r8eYuGh/c/vwEdLZdrSBdzL63J5bVE2CBG891a64WzyNNFv2jpgaXo8eEGTUFBf
         I+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792008063; x=1792612863;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vSPDDNDWaqMh8sASENIHn1C/grF8f5bQppXYAt/5Zvk=;
        b=kfxvufXMokpKgLemMDvHqS5azMFci4mtQmgKk1oyPO+2nnTL0FlgQQtHX13ErSVLky
         32NP2xgrJebtR3OQKOxCzCMqHfEJyy9iBs+kLDEcJEPV1S37GFcgT+HD5SNas6aD90ku
         gqTm1Y81NH8x6H8cBreNMtD/m8Xn13/GhNajGi9K+D0BDjFl0Vst9EnM3yxQVC242vCY
         9wnr6mLjJVvnaNZk4ylIzAn9GBiSb0I0KyTUEix1KYAoybFWf87xhr/Z0P2GvcVaBP4r
         NWYcslfPhg68MUOLOGBY+/IexJNYp2lXEUV5ovJDFSrStoA0jX8UyQ4DiYaSIEEEypFn
         AlGA==
X-Gm-Message-State: AFq9FYKtBpJBy3CehFFOFOoxEMzNJzeXFa237vbamajyyvaWzse7Gpzf
	YLEy5apvPoSoHSuyf2tWA1h2nw7XyDIZSdCvFOXUCNEUq5YzS0wGFQC/yVQ6IA==
X-Gm-Gg: AYBFou3mEodgBTLa3p71cuHnTf44Qcy/3Ym98vudUMbS6dFEL3kpikhi5kzSLww7AeG
	lEHS2iCZP8bJXXk/UWq6WX1goulvpbv1PlsobY54JYaE2km6VWFoaG+k8E/yHeQN11BrKcsgVbE
	RNvnSyPnjmRWsmUaBqV24AwIgPMHHLtqY7w1U4b0jjDmb2i7gSAMfUihgzYUgqAlDOg10vWeSxX
	Zvd2LuY8NhPbL55qj31qwitbKT/7yRBSfBGap+wSzdsFbmiIIFBTmEs7cmyWmF9brWp9nIz0CIL
	tIkGPXON9/tgSa1yXBaVz3Uh+XiyjWJshp7D2BM2vBpoVjeK9F5od9cU7skbq0XxTtXVAM+ZbsH
	6mcvbMRezzzA55zGHEhHoWMZoO8Px+gn5nkcbGTNM1/gfqXRtFJ9HvxexD5vFbVUh6/94J9rpSe
	1bKXIrFOvtd3PoOp2kh+9axiMe6vzKENh+M3Sr6dUwyfRpCwHn0zUN+erh5iY9LZgWwvaZMFng
X-Received: by 2002:a05:620a:3721:b0:93c:c2d5:1ae5 with SMTP id af79cd13be357-93ebd0c0039mr2780875585a.7.1792008061688;
        Wed, 14 Oct 2026 13:01:01 -0700 (PDT)
Received: from [127.0.0.1] ([40.79.245.21])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef508811esm573685985a.36.2026.10.14.13.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 13:01:00 -0700 (PDT)
Message-Id: <pull.2251.v5.git.1792008058394.gitgitgadget@gmail.com>
In-Reply-To: <pull.2251.git.1791553518774.gitgitgadget@gmail.com>
References: <pull.2251.git.1791553518774.gitgitgadget@gmail.com>
From: "Marc Becker via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 20:00:58 +0000
Subject: [PATCH v5] wincred: refactor credential blob processing
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
Cc: Marc Becker <becm@gmx.de>,
    Marc Becker <becm@gmx.de>

From: Marc Becker <becm@gmx.de>

Implementation for splitting secret blob into separate lines and
parsing those into key/value pairs has a couple of issues:
- invalid size limit to `wcsncpy_s` (missed during d22a4884)
- inconsistent detection of line separator (matches _CR_ and _LF_)
- failing to advance position after initial password line
- deep code nesting in loop body.

Line end detection needs to be deterministic and
code can be split up into smaller functional blocks.

Create new methods for processing the matching credential and each
supported key/value pair of a multi-line secret.
Reduce variable scope and nesting level. Use early continue/return to
improve code readability.
Use `wmemchr` to reliably detect wide-character linefeed in immutable
blob data without need to create a further copy.

Signed-off-by: Marc Becker <becm@gmx.de>
---
    wincred: fix line split of secret blob content
    
    Changes since v4:
    
     * rename method to parse/format/write secret data to
       write_credential_secret
     * pass only secret blob data to write_credential_secret

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2251%2Fbecm%2Ffix-wincred-secret-linesplit-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2251/becm/fix-wincred-secret-linesplit-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/2251

Range-diff vs v4:

 1:  5fbd3987cf ! 1:  7a0b1d4d2d wincred: refactor credential blob processing
     @@ contrib/credential/wincred/git-credential-wincred.c: static void write_item(cons
      + * Write single credential block
      + * consisting of password and further (accepted) credential items.
      + */
     -+static void write_credential(const CREDENTIALW *cred)
     ++static void write_credential_secret(LPCWSTR blob, DWORD wlen)
      +{
      +	LPCWSTR end;
      +	DWORD length;
     -+	LPCWSTR blob = (LPCWSTR)cred->CredentialBlob;
     -+	DWORD wlen = cred->CredentialBlobSize / sizeof(WCHAR);
      +
      +	/* check if content is single line (retain trailing carriage return) */
      +	if ((end = wmemchr(blob, L'\n', wlen)) == NULL) {
     @@ contrib/credential/wincred/git-credential-wincred.c: static void get_credential(
      +	/* search for the first credential that matches target and username */
      +	for (int i = 0; i < num_creds; ++i) {
      +		LPCWSTR username;
     ++		LPCWSTR blob;
      +
      +		if (!match_cred(creds[i], 0))
      +			continue;
     @@ contrib/credential/wincred/git-credential-wincred.c: static void get_credential(
      +		username = creds[i]->UserName;
      +		write_item("username", username, username ? wcslen(username) : 0);
      +
     -+		write_credential(creds[i]);
     ++		blob = (LPCWSTR)creds[i]->CredentialBlob;
     ++		write_credential_secret(blob, creds[i]->CredentialBlobSize / sizeof(*blob));
      +
      +		for (int j = 0; j < creds[i]->AttributeCount; j++) {
      +			CREDENTIAL_ATTRIBUTEW *attr = creds[i]->Attributes + j;


 .../wincred/git-credential-wincred.c          | 124 ++++++++++++------
 1 file changed, 85 insertions(+), 39 deletions(-)

diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index 22eb27ca31..e2b40ef8c8 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <io.h>
 #include <fcntl.h>
+#include <wchar.h>
 #include <wincred.h>
 
 /* common helpers */
@@ -69,6 +70,68 @@ static void write_item(const char *what, LPCWSTR wbuf, int wlen)
 	free(buf);
 }
 
+/*
+ * Write known credential item.
+ */
+static void write_credential_item(LPCWSTR data, int wlen)
+{
+	static const LPCWSTR refresh_token = L"oauth_refresh_token";
+	LPCWSTR value;
+	DWORD klen;
+	DWORD vlen;
+
+	/* find key/value separator for credential item */
+	if ((value = wmemchr(data, L'=', wlen)) == NULL)
+		return;
+	klen = value++ - data;
+	vlen = wlen - klen - 1;
+
+	/* write items known to git credential protocol */
+	if (klen == wcslen(refresh_token) && wmemcmp(data, refresh_token, klen) == 0)
+		write_item("oauth_refresh_token", value, vlen);
+}
+
+/*
+ * Write single credential block
+ * consisting of password and further (accepted) credential items.
+ */
+static void write_credential_secret(LPCWSTR blob, DWORD wlen)
+{
+	LPCWSTR end;
+	DWORD length;
+
+	/* check if content is single line (retain trailing carriage return) */
+	if ((end = wmemchr(blob, L'\n', wlen)) == NULL) {
+		write_item("password", blob, wlen);
+		return;
+	}
+	/* determine current line length and remaining data size */
+	length = end++ - blob;
+	wlen -= length + 1;
+
+	/* trim carriage return at line end */
+	if (length && blob[length - 1] == L'\r')
+		--length;
+	write_item("password", blob, length);
+	blob = end;
+
+	/* find line separator */
+	while ((end = wmemchr(blob, L'\n', wlen)) != NULL) {
+		length = end++ - blob;
+		wlen -= length + 1;
+
+		/* trim carriage return at line end */
+		if (length && blob[length - 1] == L'\r')
+			--length;
+
+		/* write item and advance blob position */
+		write_credential_item(blob, length);
+		blob = end;
+	}
+	/* process final line (retain trailing carriage return) */
+	write_credential_item(blob, wlen);
+}
+
 /*
  * Match an (optional) expected string and a delimiter in the target string,
  * consuming the matched text by updating the target pointer.
@@ -148,51 +211,34 @@ static void get_credential(void)
 {
 	CREDENTIALW **creds;
 	DWORD num_creds;
-	int i;
-	CREDENTIAL_ATTRIBUTEW *attr;
-	WCHAR *secret;
-	WCHAR *line;
-	WCHAR *remaining_lines;
-	WCHAR *part;
-	WCHAR *remaining_parts;
 
 	if (!CredEnumerateW(L"git:*", 0, &num_creds, &creds))
 		return;
 
-	/* search for the first credential that matches username */
-	for (i = 0; i < num_creds; ++i)
-		if (match_cred(creds[i], 0)) {
-			write_item("username", creds[i]->UserName,
-				creds[i]->UserName ? wcslen(creds[i]->UserName) : 0);
-			if (creds[i]->CredentialBlobSize > 0) {
-				secret = xmalloc(creds[i]->CredentialBlobSize + sizeof(WCHAR));
-				wcsncpy_s(secret, creds[i]->CredentialBlobSize, (LPCWSTR)creds[i]->CredentialBlob, creds[i]->CredentialBlobSize / sizeof(WCHAR));
-				line = wcstok_s(secret, L"\r\n", &remaining_lines);
-				write_item("password", line, line ? wcslen(line) : 0);
-				while(line != NULL) {
-					part = wcstok_s(line, L"=", &remaining_parts);
-					if (!wcscmp(part, L"oauth_refresh_token")) {
-						write_item("oauth_refresh_token", remaining_parts, remaining_parts ? wcslen(remaining_parts) : 0);
-					}
-					line = wcstok_s(NULL, L"\r\n", &remaining_lines);
-				}
-				free(secret);
-			} else {
-				write_item("password",
-						(LPCWSTR)creds[i]->CredentialBlob,
-						creds[i]->CredentialBlobSize / sizeof(WCHAR));
-			}
-			for (int j = 0; j < creds[i]->AttributeCount; j++) {
-				attr = creds[i]->Attributes + j;
-				if (!wcscmp(attr->Keyword, L"git_password_expiry_utc")) {
-					write_item("password_expiry_utc", (LPCWSTR)attr->Value,
-					attr->ValueSize / sizeof(WCHAR));
-					break;
-				}
+	/* search for the first credential that matches target and username */
+	for (int i = 0; i < num_creds; ++i) {
+		LPCWSTR username;
+		LPCWSTR blob;
+
+		if (!match_cred(creds[i], 0))
+			continue;
+
+		username = creds[i]->UserName;
+		write_item("username", username, username ? wcslen(username) : 0);
+
+		blob = (LPCWSTR)creds[i]->CredentialBlob;
+		write_credential_secret(blob, creds[i]->CredentialBlobSize / sizeof(*blob));
+
+		for (int j = 0; j < creds[i]->AttributeCount; j++) {
+			CREDENTIAL_ATTRIBUTEW *attr = creds[i]->Attributes + j;
+
+			if (!wcscmp(attr->Keyword, L"git_password_expiry_utc")) {
+				write_item("password_expiry_utc", (LPCWSTR)attr->Value, attr->ValueSize / sizeof(WCHAR));
+				break;
 			}
-			break;
 		}
-
+		break;
+	}
 	CredFree(creds);
 }
 

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
gitgitgadget
