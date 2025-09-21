Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2CE2D2395
	for <git@vger.kernel.org>; Sun, 21 Sep 2025 12:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758457367; cv=none; b=aBmjEJxn4ZjSDrKoVsKdxGfRM7RjCzlA7fpFGtCcnGNYcgOmBnvtScAz+6TJv0SaHWyTaRGxWnTmotaiBtRdIswj+IMrhzUZEyIFyX47fJ35J+W/wDqre8g13GHC4hmmqFVhqTrYPrJQgNVFjk4kbEMEwtaKdkwKfCeEygAGBDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758457367; c=relaxed/simple;
	bh=/hjLUXftX4i7JKE+lBJRzysrHrEVUI3vQtJ3IWtKLkc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ciNWE0gwYTxv04p5+yhW6ljlKFc4oQCFyBjz8vVn0dxc4VaK24k2jNAUYT4bZ/YmeHiOzRqvy9WET6b3DfIvysI5ZeWb+/ePHFAdsceeMV7XH1zxcHXJtsxAGwzm5r3GQ39QBQaaa80noBhqGTAPMnyWo63opOJb9eyGc2lQX3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkFTCj2G; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkFTCj2G"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-4248b34fc8eso13520765ab.3
        for <git@vger.kernel.org>; Sun, 21 Sep 2025 05:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758457365; x=1759062165; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JI40US1j2L0AL50sABRUzcYhvzC2y4gUNm6et1VQB5E=;
        b=FkFTCj2GHUa6qugDNXdAYwQngtE7c9Tjn2/W7KvwzcEAjV6KrXDhm7WicfG4lWeV0J
         TrggQ8/1zylPL99ReRkjof/q7NhJDEogmWKKLOzlQrg5BmswMOoWjhUJ7VmkTwJ7WHkP
         kQKNQaCLiNc5b4zNgbkY/GZ+l4do5puxUibJv9soODNerP09deLcX7A8kqayntFr8oJc
         4LgXzPGMxwY682WrQ0VMjFA0YA0SXGcRPrMTzcWv8sEsmWEjRRChxrdYMSAAQcUyRNqL
         zai5P2jK1dcE/RVwXyPOngJij6clH5g9iHVHKBYVCUUA50wkK9S4Bh05u8fyLyCfXl0F
         MDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758457365; x=1759062165;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JI40US1j2L0AL50sABRUzcYhvzC2y4gUNm6et1VQB5E=;
        b=mhirXbNKpl+Tb9vlBn61DToODqhFiCKRi5eOpo+dJRZKCN7xuSED/RhZq/g9JDP17B
         LC6O1tlrD7RUSkZ4m+hEjBvA4Q7YDXYNCOqOnfCB8ee477o5lMW5ZYb1nODdEwBzo9H6
         d8KTKv+zj4waBQj/ylmCSrZYBDL8czYVegqfO0yXqQ0NbG799EmUaNShQ+hrvE05vPeU
         z3BkyrpvFskvOnj2+w1U1t2yAI6YYrti1vl3vUCb6KOpe1YhODO1+Ntvud9rXOPoNOGC
         UNm7DcHixpsNXw4C78V0KzKSMRnN8lvA/C1bCSQsxpVrxiLq7w7dWmHT1sm38VYRM6QE
         rsAw==
X-Gm-Message-State: AOJu0Ywdppp+lCSCtv8MaOD9o4eck01V9pp5Rem98HoEbnTVWEZCNajB
	Dv7wZAlhudrkZwbvy0pVyXa5EuSSIJ23A5Ur6IT85AXDcFYdfPHQ3t8Y04MS1CCl
X-Gm-Gg: ASbGncvEk6NuYUJSVOP0UF1TywwCVBs/7J4whpFP21Bt5Xwpvwf5prTL/FfBR6oNn0K
	MTuyBxoGGn/dH8VUG7XtoxNs0bnh7AQrDUeGbGSFbQHPAsEmu6nkO+GwnZxZIHGTTYaIEutgMIc
	R7x89QRSuG/m/UWjUTB/zZB20h6M9L2FKtmuidwlpzy9R+VKg8okuJBkg45lrOW5Gr3+8BloAwi
	Zsr3/KoE/mB9DpLSyFCm3f92HsrsupjONajlxwnbcxK+iYpyaMnQ6O9HZSXvOoQnEYxf29KNUBt
	O8YarWFfBHrgZtYah9JedR2Ht7C3f+WGQzmKoC8nzeFLulxpOaAYIMD5xXuY08mDO5RzrIlS8SI
	euk/lYROolOmvUkYPlBlRMj7E
X-Google-Smtp-Source: AGHT+IFD7LQ0D4DgwdaJMggn/qoiddVVzARSp9rri5hQmnVn059n5lzxBcbC55JhQOMOuOmRmHBPfg==
X-Received: by 2002:a05:6e02:1b09:b0:424:57d:1a50 with SMTP id e9e14a558f8ab-42481947533mr148594475ab.11.1758457364950;
        Sun, 21 Sep 2025 05:22:44 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.35.114])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d50aa5dc6sm4574390173.47.2025.09.21.05.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 05:22:44 -0700 (PDT)
Message-Id: <bcb231125c95ff809c618eedab71375b94e6c69e.1758457356.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1974.git.1758457356.gitgitgadget@gmail.com>
References: <pull.1974.git.1758457356.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 21 Sep 2025 12:22:36 +0000
Subject: [PATCH 3/3] http-push: avoid new compile error
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

With the recent update in Git for Windows/ARM64 as of
https://github.com/git-for-windows/git-sdk-arm64/commit/21b288e16358
cURL was updated from v8.15.0 to v8.16.0, and the LLVM-based builds (but
strangely not the GCC-based builds) continuously greet me thusly:

  http-push.c:211:2: error: call to '_curl_easy_setopt_err_long' declared
  with 'warning' attribute: curl_easy_setopt expects a long argument
  [-Werror,-Wattribute-warning]
      CC builtin/apply.o
    211 |         curl_easy_setopt(curl, CURLOPT_INFILESIZE, buffer->buf.len);
        |         ^
  C:/a/git-sdk-arm64/git-sdk-arm64/minimal-sdk/clangarm64/include/curl/typecheck-gcc.h:50:15:
  note: expanded from macro 'curl_easy_setopt'
     50 |               _curl_easy_setopt_err_long();                             \
        |               ^
  1 error generated.
  make: *** [Makefile:2877: http-push.o] Error 1

The easiest way to shut up that compile error (which is legitimate,
seeing as the `CURLOPT_INFILESIZE` options expects a `long` parameter,
but `buffer->buf.len` refers to the `size_t` attribute of a `strbuf`)
would be to simply cast the parameter to a `long`.

However, there is a much better solution: To use the
`CURLOPT_INFILESIZE_LARGE` option instead, which was added in cURL
v7.11.0 (see https://curl.se/ch/7.11.0.html) and which Git _already_
uses in `curl_append_msgs_to_imap()`.

This fix was the motivation for renaming `xcurl_off_t()` to
`cast_size_t_to_curl_off_t()` and making it available more broadly,
which is the reason why it is used here, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 http-push.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/http-push.c b/http-push.c
index 91a5465afb..7a9b96a6d0 100644
--- a/http-push.c
+++ b/http-push.c
@@ -208,7 +208,8 @@ static void curl_setup_http(CURL *curl, const char *url,
 	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
 	curl_easy_setopt(curl, CURLOPT_URL, url);
 	curl_easy_setopt(curl, CURLOPT_INFILE, buffer);
-	curl_easy_setopt(curl, CURLOPT_INFILESIZE, buffer->buf.len);
+	curl_easy_setopt(curl, CURLOPT_INFILESIZE_LARGE,
+			 cast_size_t_to_curl_off_t(buffer->buf.len));
 	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
 	curl_easy_setopt(curl, CURLOPT_SEEKFUNCTION, seek_buffer);
 	curl_easy_setopt(curl, CURLOPT_SEEKDATA, buffer);
-- 
gitgitgadget
