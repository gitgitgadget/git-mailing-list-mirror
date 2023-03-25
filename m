Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98790C76195
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 01:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjCYBXV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 21:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjCYBXU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 21:23:20 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3047249C2
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 18:23:19 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q19so339127wrc.5
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 18:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679707397;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D3XctWO5q1wwB9St8J+gJLUcD+Ks5M4ii5wgbXLAybE=;
        b=SOKWmkg7jO6w3ufjQerPwZRPpoWEO4kO+g/kRVEqku9jUtMX5EFbZMnRbJaeh7em0n
         St75rDTHsEq3HaDYPsW5IlR9KvgiQkeQR6kWNW9RM8eFX42EXuqnzek3eVDE2Qt4X2Cd
         XNv+mpQianzKo9h0AYBhh83bGnqE3FW7s02+MFUREpt05JTbobivxWpcNYXd2rq0MM0t
         DHyGMTko1EvHyWH8mYF+qlGj7v6h2SRHTzsBTEfwhJWLLxbx5HxOyTVhw/2J6dLwHtQO
         pR+CXmbIFB76cy6dtIhZ1jUduHV9CDew9P1Uud1qBGxSd5OqWhLcuO1QyRJi834acix1
         bgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679707397;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D3XctWO5q1wwB9St8J+gJLUcD+Ks5M4ii5wgbXLAybE=;
        b=2zGd1BWy1IbJdSfaESjk3uK2RANorb1QIiYrrQ0Igc0wT1I94goAlDhQU4dBYZ2UNf
         m9x9IQHa5GrK/CiLPzsKxETpi1Csl0fyfd2N0ETAbVjncoiQBwbXqDSIncVHG7XGmqfg
         UB0P9kPvX4u7K/VTeUqFTrMLLy5JPPAklcqbVnhZFaWYOVEx2iXZ4Vwa9jtqAsPvKCy8
         cWuP4pzAnyDxW3QSVCz51wWvwV7to6qp9O3drFmKxFINPzio+EUriF9QVq5j5Mhs7tEU
         uE9uROE4h2KEDNrHhrIyf1iUqvScSRhlST8btJoe48VwjJ8syORvKSwS4ikV1aItYI6M
         nqPA==
X-Gm-Message-State: AAQBX9dSDWeR3rxfbg3vx0XBn518tJIX+rXmpg8SS2yKGbSu/SbfOKNr
        ee3hbO3N6norITwhjqMVjp5HCPEqTRc=
X-Google-Smtp-Source: AKy350ZmfyUWG4Iroa1tvQrrxyW/bHAKMk+O++GbXqNKgY9EiheRbwnPSRRbOgiOr4VjhWBhL01rnQ==
X-Received: by 2002:adf:ee41:0:b0:2cf:e3d8:5dff with SMTP id w1-20020adfee41000000b002cfe3d85dffmr3263861wro.9.1679707397332;
        Fri, 24 Mar 2023 18:23:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c0a0a00b003edd2ec9f85sm1360433wmp.6.2023.03.24.18.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 18:23:17 -0700 (PDT)
Message-Id: <pull.1496.git.1679707396407.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 25 Mar 2023 01:23:16 +0000
Subject: [PATCH] credential/wincred: include wincred.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Harshil Jani <harshiljani2002@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: M Hickford <mirth.hickford@gmail.com>

Delete redundant definitions. Mingw-w64 has wincred.h since 2007 [1].

[1] https://github.com/mingw-w64/mingw-w64/blob/9d937a7f4f766f903c9433044f77bfa97a0bc1d8/mingw-w64-headers/include/wincred.h

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    credential/wincred: include wincred.h

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1496%2Fhickford%2Fwincred-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1496/hickford/wincred-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1496

 .../wincred/git-credential-wincred.c          | 61 +------------------
 1 file changed, 1 insertion(+), 60 deletions(-)

diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index ead6e267c78..6e5a91a7168 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <io.h>
 #include <fcntl.h>
+#include <wincred.h>
 
 /* common helpers */
 
@@ -33,64 +34,6 @@ static void *xmalloc(size_t size)
 	return ret;
 }
 
-/* MinGW doesn't have wincred.h, so we need to define stuff */
-
-typedef struct _CREDENTIAL_ATTRIBUTEW {
-	LPWSTR Keyword;
-	DWORD  Flags;
-	DWORD  ValueSize;
-	LPBYTE Value;
-} CREDENTIAL_ATTRIBUTEW, *PCREDENTIAL_ATTRIBUTEW;
-
-typedef struct _CREDENTIALW {
-	DWORD                  Flags;
-	DWORD                  Type;
-	LPWSTR                 TargetName;
-	LPWSTR                 Comment;
-	FILETIME               LastWritten;
-	DWORD                  CredentialBlobSize;
-	LPBYTE                 CredentialBlob;
-	DWORD                  Persist;
-	DWORD                  AttributeCount;
-	PCREDENTIAL_ATTRIBUTEW Attributes;
-	LPWSTR                 TargetAlias;
-	LPWSTR                 UserName;
-} CREDENTIALW, *PCREDENTIALW;
-
-#define CRED_TYPE_GENERIC 1
-#define CRED_PERSIST_LOCAL_MACHINE 2
-#define CRED_MAX_ATTRIBUTES 64
-
-typedef BOOL (WINAPI *CredWriteWT)(PCREDENTIALW, DWORD);
-typedef BOOL (WINAPI *CredEnumerateWT)(LPCWSTR, DWORD, DWORD *,
-    PCREDENTIALW **);
-typedef VOID (WINAPI *CredFreeT)(PVOID);
-typedef BOOL (WINAPI *CredDeleteWT)(LPCWSTR, DWORD, DWORD);
-
-static HMODULE advapi;
-static CredWriteWT CredWriteW;
-static CredEnumerateWT CredEnumerateW;
-static CredFreeT CredFree;
-static CredDeleteWT CredDeleteW;
-
-static void load_cred_funcs(void)
-{
-	/* load DLLs */
-	advapi = LoadLibraryExA("advapi32.dll", NULL,
-				LOAD_LIBRARY_SEARCH_SYSTEM32);
-	if (!advapi)
-		die("failed to load advapi32.dll");
-
-	/* get function pointers */
-	CredWriteW = (CredWriteWT)GetProcAddress(advapi, "CredWriteW");
-	CredEnumerateW = (CredEnumerateWT)GetProcAddress(advapi,
-	    "CredEnumerateW");
-	CredFree = (CredFreeT)GetProcAddress(advapi, "CredFree");
-	CredDeleteW = (CredDeleteWT)GetProcAddress(advapi, "CredDeleteW");
-	if (!CredWriteW || !CredEnumerateW || !CredFree || !CredDeleteW)
-		die("failed to load functions");
-}
-
 static WCHAR *wusername, *password, *protocol, *host, *path, target[1024];
 
 static void write_item(const char *what, LPCWSTR wbuf, int wlen)
@@ -300,8 +243,6 @@ int main(int argc, char *argv[])
 
 	read_credential();
 
-	load_cred_funcs();
-
 	if (!protocol || !(host || path))
 		return 0;
 

base-commit: 27d43aaaf50ef0ae014b88bba294f93658016a2e
-- 
gitgitgadget
