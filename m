Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6A6B661
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 06:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbhYCCGh"
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A5493
	for <git@vger.kernel.org>; Sun,  5 Nov 2023 22:16:39 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4084b0223ccso30296125e9.2
        for <git@vger.kernel.org>; Sun, 05 Nov 2023 22:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699251397; x=1699856197; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7++tis+dxmW7xWKkzhNhcYfWsIXuwZk3+vpBLa+YnWI=;
        b=mbhYCCGhfl/Yz0WFDcIyK1VwN+04lVM4MDSsH/0zjh6ZEtzrpGo0+uJ/3AlSf7uo7Q
         GD21eT6Rdo6IZKLaP6NwrHgbMQxxsL2OeY2Ue31dAh+D+d6SLz6c7my+qcakyvKnaUUD
         qhY/+aqcFqobxOXPJ1e/dARp6p5iAKoRtayQvThPhHu49u56h1Vxy8Ztb0T6u90JKnPJ
         jsxkciLAfEGGmMHKtkGdrYtYYDG03EdonwwwAB9qg1Of/AEG41Rp5BjVqHJrsWzEnj6G
         bWFsp2LTa9D3e1QNp2D1CE3URKCea6zsXWEhAabkkYFc1kP4Vh5gbmsVc+e9ywjv29if
         eeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699251397; x=1699856197;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7++tis+dxmW7xWKkzhNhcYfWsIXuwZk3+vpBLa+YnWI=;
        b=RPDbHLi+n1il+4SvWPDs3aUB9ZIE0VjYGMt4RAuDJ2VwZXc4nbFzljOk+l3xsprulV
         lnRm9lKxnXv+0AYxOkwCYNERoadeODczQxw4IqG4yPAOiqtT4xHLo2F2yRxYmX/8qeZw
         HQZKc0svTuBqJL52AzuWJLMrAjBy/n2gm2fVhFxEdONpVly6S+712XxcwtmIRdd/wFZO
         kQQUuzSI+otDzHiWN6qIFm8IWok6iCLYe0lBLgahNY5DFHxdZeupKlO/JVw2b8lDbOJZ
         mBPW2kVtbtCx92aemwF6PfdJ9IRoVF/dod61YEKhtbdXDmJ+D37USXrYTv+Qv8NT3p5H
         QKmg==
X-Gm-Message-State: AOJu0Yx7jbguhMd40aHYo6DaUVkcXReSueqret/o95lEYa5Ywg80dAPo
	1IKZeSf7+F/48qWjJclA3eZyO46CLVI=
X-Google-Smtp-Source: AGHT+IEmZBeuXs+0kK0aSLlrTg9SbBGzzOsGRF9TP8PWAcqLbMip8t/2/juzIA2p8SmJE3hIeFCCow==
X-Received: by 2002:a05:600c:1c15:b0:406:f832:6513 with SMTP id j21-20020a05600c1c1500b00406f8326513mr21728463wms.3.1699251396936;
        Sun, 05 Nov 2023 22:16:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q8-20020a05600c46c800b0040776008abdsm10961199wmo.40.2023.11.05.22.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 22:16:36 -0800 (PST)
Message-ID: <pull.1534.v2.git.1699251395093.gitgitgadget@gmail.com>
In-Reply-To: <pull.1534.git.1684567247339.gitgitgadget@gmail.com>
References: <pull.1534.git.1684567247339.gitgitgadget@gmail.com>
From: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Nov 2023 06:16:34 +0000
Subject: [PATCH v2] credential/wincred: store oauth_refresh_token
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
Cc: Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    M Hickford <mirth.hickford@gmail.com>,
    M Hickford <mirth.hickford@gmail.com>

From: M Hickford <mirth.hickford@gmail.com>

a5c7656 (credential: new attribute oauth_refresh_token) introduced
a new confidential credential attribute for helpers to store.

We encode the new attribute in the CredentialBlob, separated by
newline:

    hunter2
    oauth_refresh_token=xyzzy

This is extensible and backwards compatible. The credential protocol
already assumes that attribute values do not contain newlines.

This fixes test "helper (wincred) gets oauth_refresh_token" when
t0303-credential-external.sh is run with
GIT_TEST_CREDENTIAL_HELPER=wincred. This test was added in a5c76569e7
(credential: new attribute oauth_refresh_token, 2023-04-21).

Alternatives considered: store oauth_refresh_token in a wincred
attribute. This would be insecure because wincred assumes attribute
values to be non-confidential.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    credential/wincred: store oauth_refresh_token
    
    Patch v2 fixes a bug when password is empty.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1534%2Fhickford%2Fwincred-refresh-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1534/hickford/wincred-refresh-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1534

Range-diff vs v1:

 1:  46ce22aa3a3 ! 1:  12f092f45b1 credential/wincred: store oauth_refresh_token
     @@ Commit message
          This is extensible and backwards compatible. The credential protocol
          already assumes that attribute values do not contain newlines.
      
     +    This fixes test "helper (wincred) gets oauth_refresh_token" when
     +    t0303-credential-external.sh is run with
     +    GIT_TEST_CREDENTIAL_HELPER=wincred. This test was added in a5c76569e7
     +    (credential: new attribute oauth_refresh_token, 2023-04-21).
     +
          Alternatives considered: store oauth_refresh_token in a wincred
          attribute. This would be insecure because wincred assumes attribute
          values to be non-confidential.
     @@ contrib/credential/wincred/git-credential-wincred.c: static void get_credential(
       	if (!CredEnumerateW(L"git:*", 0, &num_creds, &creds))
       		return;
      @@ contrib/credential/wincred/git-credential-wincred.c: static void get_credential(void)
     - 		if (match_cred(creds[i])) {
     + 		if (match_cred(creds[i], 0)) {
       			write_item("username", creds[i]->UserName,
       				creds[i]->UserName ? wcslen(creds[i]->UserName) : 0);
      -			write_item("password",
      -				(LPCWSTR)creds[i]->CredentialBlob,
      -				creds[i]->CredentialBlobSize / sizeof(WCHAR));
     -+			secret = xmalloc(creds[i]->CredentialBlobSize);
     -+			wcsncpy_s(secret, creds[i]->CredentialBlobSize, (LPCWSTR)creds[i]->CredentialBlob, creds[i]->CredentialBlobSize / sizeof(WCHAR));
     -+			line = wcstok_s(secret, L"\r\n", &remaining_lines);
     -+			write_item("password", line, wcslen(line));
     -+			while(line != NULL) {
     -+				part = wcstok_s(line, L"=", &remaining_parts);
     -+				if (!wcscmp(part, L"oauth_refresh_token")) {
     -+					write_item("oauth_refresh_token", remaining_parts, wcslen(remaining_parts));
     ++			if (creds[i]->CredentialBlobSize > 0) {
     ++				secret = xmalloc(creds[i]->CredentialBlobSize);
     ++				wcsncpy_s(secret, creds[i]->CredentialBlobSize, (LPCWSTR)creds[i]->CredentialBlob, creds[i]->CredentialBlobSize / sizeof(WCHAR));
     ++				line = wcstok_s(secret, L"\r\n", &remaining_lines);
     ++				write_item("password", line, line ? wcslen(line) : 0);
     ++				while(line != NULL) {
     ++					part = wcstok_s(line, L"=", &remaining_parts);
     ++					if (!wcscmp(part, L"oauth_refresh_token")) {
     ++						write_item("oauth_refresh_token", remaining_parts, remaining_parts ? wcslen(remaining_parts) : 0);
     ++					}
     ++					line = wcstok_s(NULL, L"\r\n", &remaining_lines);
      +				}
     -+				line = wcstok_s(NULL, L"\r\n", &remaining_lines);
     ++			} else {
     ++				write_item("password",
     ++						(LPCWSTR)creds[i]->CredentialBlob,
     ++						creds[i]->CredentialBlobSize / sizeof(WCHAR));
      +			}
       			for (int j = 0; j < creds[i]->AttributeCount; j++) {
       				attr = creds[i]->Attributes + j;
     @@ contrib/credential/wincred/git-credential-wincred.c: static void read_credential
       		/*
       		 * Ignore other lines; we don't know what they mean, but
       		 * this future-proofs us when later versions of git do
     -
     - ## t/t0303-credential-external.sh ##
     -@@ t/t0303-credential-external.sh: test -z "$GIT_TEST_CREDENTIAL_HELPER_SETUP" ||
     - helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER"
     - 
     - helper_test "$GIT_TEST_CREDENTIAL_HELPER"
     -+helper_test_oauth_refresh_token "$GIT_TEST_CREDENTIAL_HELPER"
     - 
     - if test -z "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"; then
     - 	say "# skipping timeout tests (GIT_TEST_CREDENTIAL_HELPER_TIMEOUT not set)"


 .../wincred/git-credential-wincred.c          | 46 ++++++++++++++++---
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index 4cd56c42e24..5c6a7d65d4a 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -35,7 +35,7 @@ static void *xmalloc(size_t size)
 }
 
 static WCHAR *wusername, *password, *protocol, *host, *path, target[1024],
-	*password_expiry_utc;
+	*password_expiry_utc, *oauth_refresh_token;
 
 static void write_item(const char *what, LPCWSTR wbuf, int wlen)
 {
@@ -140,6 +140,11 @@ static void get_credential(void)
 	DWORD num_creds;
 	int i;
 	CREDENTIAL_ATTRIBUTEW *attr;
+	WCHAR *secret;
+	WCHAR *line;
+	WCHAR *remaining_lines;
+	WCHAR *part;
+	WCHAR *remaining_parts;
 
 	if (!CredEnumerateW(L"git:*", 0, &num_creds, &creds))
 		return;
@@ -149,9 +154,23 @@ static void get_credential(void)
 		if (match_cred(creds[i], 0)) {
 			write_item("username", creds[i]->UserName,
 				creds[i]->UserName ? wcslen(creds[i]->UserName) : 0);
-			write_item("password",
-				(LPCWSTR)creds[i]->CredentialBlob,
-				creds[i]->CredentialBlobSize / sizeof(WCHAR));
+			if (creds[i]->CredentialBlobSize > 0) {
+				secret = xmalloc(creds[i]->CredentialBlobSize);
+				wcsncpy_s(secret, creds[i]->CredentialBlobSize, (LPCWSTR)creds[i]->CredentialBlob, creds[i]->CredentialBlobSize / sizeof(WCHAR));
+				line = wcstok_s(secret, L"\r\n", &remaining_lines);
+				write_item("password", line, line ? wcslen(line) : 0);
+				while(line != NULL) {
+					part = wcstok_s(line, L"=", &remaining_parts);
+					if (!wcscmp(part, L"oauth_refresh_token")) {
+						write_item("oauth_refresh_token", remaining_parts, remaining_parts ? wcslen(remaining_parts) : 0);
+					}
+					line = wcstok_s(NULL, L"\r\n", &remaining_lines);
+				}
+			} else {
+				write_item("password",
+						(LPCWSTR)creds[i]->CredentialBlob,
+						creds[i]->CredentialBlobSize / sizeof(WCHAR));
+			}
 			for (int j = 0; j < creds[i]->AttributeCount; j++) {
 				attr = creds[i]->Attributes + j;
 				if (!wcscmp(attr->Keyword, L"git_password_expiry_utc")) {
@@ -160,6 +179,7 @@ static void get_credential(void)
 					break;
 				}
 			}
+			free(secret);
 			break;
 		}
 
@@ -170,16 +190,26 @@ static void store_credential(void)
 {
 	CREDENTIALW cred;
 	CREDENTIAL_ATTRIBUTEW expiry_attr;
+	WCHAR *secret;
+	int wlen;
 
 	if (!wusername || !password)
 		return;
 
+	if (oauth_refresh_token) {
+		wlen = _scwprintf(L"%s\r\noauth_refresh_token=%s", password, oauth_refresh_token);
+		secret = xmalloc(sizeof(WCHAR) * wlen);
+		_snwprintf_s(secret, sizeof(WCHAR) * wlen, wlen, L"%s\r\noauth_refresh_token=%s", password, oauth_refresh_token);
+	} else {
+		secret = _wcsdup(password);
+	}
+
 	cred.Flags = 0;
 	cred.Type = CRED_TYPE_GENERIC;
 	cred.TargetName = target;
 	cred.Comment = L"saved by git-credential-wincred";
-	cred.CredentialBlobSize = (wcslen(password)) * sizeof(WCHAR);
-	cred.CredentialBlob = (LPVOID)password;
+	cred.CredentialBlobSize = wcslen(secret) * sizeof(WCHAR);
+	cred.CredentialBlob = (LPVOID)_wcsdup(secret);
 	cred.Persist = CRED_PERSIST_LOCAL_MACHINE;
 	cred.AttributeCount = 0;
 	cred.Attributes = NULL;
@@ -194,6 +224,8 @@ static void store_credential(void)
 	cred.TargetAlias = NULL;
 	cred.UserName = wusername;
 
+	free(secret);
+
 	if (!CredWriteW(&cred, 0))
 		die("CredWrite failed");
 }
@@ -265,6 +297,8 @@ static void read_credential(void)
 			password = utf8_to_utf16_dup(v);
 		else if (!strcmp(buf, "password_expiry_utc"))
 			password_expiry_utc = utf8_to_utf16_dup(v);
+		else if (!strcmp(buf, "oauth_refresh_token"))
+			oauth_refresh_token = utf8_to_utf16_dup(v);
 		/*
 		 * Ignore other lines; we don't know what they mean, but
 		 * this future-proofs us when later versions of git do

base-commit: bc5204569f7db44d22477485afd52ea410d83743
-- 
gitgitgadget
