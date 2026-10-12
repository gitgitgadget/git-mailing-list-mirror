Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C274B1468
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791840434; cv=none; b=VHiowBPc4V0Do82J3CTSUg21iaLjo/MSftt14pGAYe8R8OWViGCXqgz5IvMPPY+p+rHa4SVLAq/E3svhkFRTjdFlqE4t6FQ8rlZifXekx275qbxmcrmCMqOEC/My9bnFfGHGKZ4qCXI6YFFi1MUYKPzX2eLcfsW3qQSMC3LFWbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791840434; c=relaxed/simple;
	bh=5fCC8ZgTZmOfyJ4MfSy09fkULKT/njs+iIKORcqS6ZI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=A9vVoPaSeTdojdDPYH2AXTDmM0DlpHLtmDh2BwfuXh3ouZJIfR9VPDnH04FAlLon7Ox/b8uADdjxGWT45eNfd5k3aMWLOhUidJlSCPcmYc7MqO5ifIlJ6hV2wm6cjcJqArp3HTezEKbaQptHlqQcw924gUbrlQHSog9lbteZhkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3Y0wTgc; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3Y0wTgc"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4a6bb779d13so289367fac.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 14:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791840431; x=1792445231; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n8IlTS5PZYbZahAEU2YR+g5M+J9FMp8Z8Xo/RRIHiWw=;
        b=j3Y0wTgct+ME7byXWvgn1zzwBBt/H5cyE920QeclE4SZXMiBhtOkuX1Zce9itF4WZ9
         3KZhXo7XrNqkyjp48j7uI9ARf9nxUQxz8Y6Azt1+6/Pd7PC9YGvYLaRV/X8gW8pZejj3
         40y73b7VaSRpdC0QE2opLYvkVTqQU6dNestVaXuPeRmGhEVKYnO2qykyrtR7kgC3W4xe
         dtuusTvzk0gm9g2FrkO8l8WRc8BW2aoS600Qe6+VLW7dKx64oLJI0LM98k/e6XnHfmP1
         datX8PmkEMJaXVw9C8vT8mUXX1I59p+q5E0bEoi3rFFnu0wN/D4ebJZMak/Na+Xf9xT3
         xoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791840431; x=1792445231;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n8IlTS5PZYbZahAEU2YR+g5M+J9FMp8Z8Xo/RRIHiWw=;
        b=di2/dyJ1yC8prBHonHtcdTsxCn2XwNUhoiBCyXKPq+yBA+HbPJXYzV7itzJ4e3MW58
         2HChJSQneM5goncO8SI+TheeRYD9qKtCunWNYgiXXGJgYVGVzVlBLzsnex7sdGj9bnB0
         KAqH6guL2hh85U8ifAe1J8/LEohSkKQCVvc8We04PtvMcCKiBThN2egLUZ6d67+sPMCc
         0rleZjXa/LoDYsg5AkemZXm97a8gUqryZTtexe0y+Bt+qR6Fwhrp4TbHhvpXGKQcD/k1
         fgIFInVLLA8UftmX/3Ce6Ev1lWfz5QqcUqlvSyDMdxcJ+re5DiyQ9mK2z7xzxyW9yJWi
         C9pA==
X-Gm-Message-State: AFq9FYKg/IjNwB04fCEIyAB9zbSW6vU7KWiTxs88jHd6wb02t4lzt0LV
	VY1/Zjm9qGL/d6CUZSvklqwlGauWUvWry8KehnTv9PUHNwOvfp01nHu+eXw/MA==
X-Gm-Gg: AYBFou0RNw5r/QD7LtJqh7yYhUBgcQyNmp/jXbeiu1uaYf72LKkDx3gMusH1My1OX2r
	EnPJnp8gcB8mHQx0G9QdZp5kQrlujLuGydC3E8GDE+an1vAiurTc3S7EcOEX/STgdYQ/8NbhQay
	Z8FDFUZv0fx4GuQIxRHiqyu2WGEsYXLYZvkFwBWfuEyi5Q41eVxvHdA8W1J5NTeYFpddiSBxp6q
	QPrMh+1d82L29ImQG8eI42jtcTNprJBqziQkuwnOxujK0w/fmrglZGjZfNYsk3MFJ8FCHts1nEj
	ACaiv0Z7BH6hIA2pYb7nxyX6Lpn1tdGDRARQzf7Uupj2ALhFkkDBCecT+qVVoqBLzwvtbkbBZtE
	c5i69Rn6DjkpTrV1wupLQ2z0nGhknnRQkREmZLVj0/xqAdr7I3UR/EI+E4TWtM79/5+mClCU7fK
	TWLzdbRUxeGxTn4aU+Lcs+UFjJuOjx02zMi+hpkhLf4Cu14seJIfKLGXxrYTJmUXo5aoGpig/1w
	w==
X-Received: by 2002:a05:6808:4f6c:b0:4f4:550a:3a86 with SMTP id 5614622812f47-50c599658bfmr11920149b6e.53.1791840430879;
        Mon, 12 Oct 2026 14:27:10 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.139.80])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2a860102dsm10537452fac.16.2026.10.12.14.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 14:27:09 -0700 (PDT)
Message-Id: <pull.2251.v3.git.1791840427937.gitgitgadget@gmail.com>
In-Reply-To: <pull.2251.git.1791553518774.gitgitgadget@gmail.com>
References: <pull.2251.git.1791553518774.gitgitgadget@gmail.com>
From: "Marc Becker via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 Oct 2026 21:27:07 +0000
Subject: [PATCH v3] wincred: refactor credential blob processing
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

Invalid target size check (bytes instead of characters) for `wcsncpy_s`
already led to memory corruption; d22a4884 just hid the error by making
sure the target is always big enough.
Single invocation of `wcstok_s` only cuts out first hit delimiter.
Consecutive items would always start with a line feed character if
separation consists of CRLF.
Only exception is 1st item (due to following bug).
Advancement to end of password line is missing. Password value is reused
as extended credential item but likely filtered out due to value
mismatch with accepted key.

Line split needs to be deterministic and code should be split up into
smaller blocks.

Create separate methods for writing credential items and the complete
credential blob content to tighten code in main credential loop.
Reduce variable scope and nesting level. Use early continue/return to
improve code readability.
Use `wmemchr` to reliably detect wide-character-newline in immutable
blob data without need to create a further copy.

Signed-off-by: Marc Becker <becm@gmx.de>
---
    wincred: fix line split of secret blob content
    
    Changes since v1:
    
     * move credential blob dissection and output to separate methods
       (maintainer request)
     * mark character constants as wide char
     * consistently treat sizes/lengths as (wide) character count
    
    Changes since v2:
    
     * adjust loop condition for credential items; loop body processes
       non-final lines
     * fix remaining C++ style comment

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2251%2Fbecm%2Ffix-wincred-secret-linesplit-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2251/becm/fix-wincred-secret-linesplit-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2251

Range-diff vs v2:

 1:  01a1039f70 ! 1:  c7b03346cc wincred: refactor credential blob processing
     @@ contrib/credential/wincred/git-credential-wincred.c: static void write_item(cons
      +	LPCWSTR blob = (LPCWSTR)cred->CredentialBlob;
      +	DWORD wlen = cred->CredentialBlobSize / sizeof(WCHAR);
      +
     -+	/* check if content is single line */
     ++	/* check if content is single line (retain trailing carriage return) */
      +	if ((end = wmemchr(blob, L'\n', wlen)) == NULL) {
      +		write_item("password", blob, wlen);
      +		return;
     @@ contrib/credential/wincred/git-credential-wincred.c: static void write_item(cons
      +	length = end++ - blob;
      +	wlen -= length + 1;
      +
     -+	/* skip carriage return at line end */
     ++	/* trim carriage return at line end */
      +	if (length && blob[length - 1] == L'\r')
      +		--length;
      +	write_item("password", blob, length);
     ++	blob = end;
      +
     -+	while (1) {
     -+		/* key/value content starts on next line */
     -+		blob = end;
     -+
     -+		/* find line end */
     -+		if ((end = wmemchr(blob, L'\n', wlen)) == NULL) {
     -+			write_credential_item(blob, wlen);
     -+			return;
     -+		}
     -+		/* determine current line length and remaining data size */
     ++	/* find line separator */
     ++	while ((end = wmemchr(blob, L'\n', wlen)) != NULL) {
      +		length = end++ - blob;
      +		wlen -= length + 1;
      +
     -+		// skip carriage return at line end
     ++		/* trim carriage return at line end */
      +		if (length && blob[length - 1] == L'\r')
      +			--length;
     ++
     ++		/* write item and advance blob position */
      +		write_credential_item(blob, length);
     ++		blob = end;
      +	}
     ++	/* process final line (retain trailing carriage return) */
     ++	write_credential_item(blob, wlen);
      +}
      +
       /*


 .../wincred/git-credential-wincred.c          | 124 ++++++++++++------
 1 file changed, 85 insertions(+), 39 deletions(-)

diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index 22eb27ca31..c25f34a0b6 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <io.h>
 #include <fcntl.h>
+#include <wchar.h>
 #include <wincred.h>
 
 /* common helpers */
@@ -69,6 +70,70 @@ static void write_item(const char *what, LPCWSTR wbuf, int wlen)
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
+static void write_credential(const CREDENTIALW *cred)
+{
+	LPCWSTR end;
+	DWORD length;
+	LPCWSTR blob = (LPCWSTR)cred->CredentialBlob;
+	DWORD wlen = cred->CredentialBlobSize / sizeof(WCHAR);
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
@@ -148,51 +213,32 @@ static void get_credential(void)
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
+
+		if (!match_cred(creds[i], 0))
+			continue;
+
+		username = creds[i]->UserName;
+		write_item("username", username, username ? wcslen(username) : 0);
+
+		write_credential(creds[i]);
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
