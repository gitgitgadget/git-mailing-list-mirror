Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995B8366DB0
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989123; cv=none; b=qpF14SnMniui71KZ51QYS+6MJdw1eJu2rhnL5FP4LV2eR0tNNWYD/ldzVQNZq7OQsvjtLsqyNXqeQsT7z6Dq2IEBNZA0H/C2Ps2lQMEd4AhZxTYa+j/0KcuQUc7TH5wAyDZDFmevRPTQ97Gh2g4baa+AxTIpfwS1ZsNUcCeaegI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989123; c=relaxed/simple;
	bh=+R90F2bRkbRMFd7C8VALt10nBcpXlpBf+L5axHoHwHw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=A2F0UPMaw+P38MhTOfapzHXgwF/hMzlT1Cc9GIxs7BJu0ZO+yMzxX6qgpC9xQ1hSaPB6AiEplSQY02U1lPxpFRCrStpQwNEvmlnkVgcypqWGWvW8gfoBFo3MHohu5vW1VhtRuvKZzJXsTgSaw3t4dWhXMxSKAgMpRFpOCIfiR8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEkek5fz; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEkek5fz"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b2f2c5ec36so514633385a.1
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 12:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767989120; x=1768593920; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9Sr0iBaMtENvjA7hDr85y5l+5Mpz9UCcJi1MXyO/Oo=;
        b=YEkek5fzBKWwDYv/ia3HsJ+FsqvR9Adv0ALKkmmYW4CFgo8bqFr7Zt3+xkFu3hTjbX
         cT9alyeBRvQlRLqwrGYh/JvsyejhdI9vw84AuRUhvTrMFCetKiTbup7tAdmWXmFdHLOx
         FpIge80xwibZPoNsWWsDnZlhIjqhh1kaaTV488Bn4QTtfrT6Y+9tHi2uNjIFfZhqq786
         i6S/x4cN3LwoYhkb0RoynvYds7KUtXqn0UTE2++5LooRgRtp8ZHHzpW1ulXi53OD+ag9
         eITObXJNG6X0eRTF0DoqBEdZheDCn92tJMLqqqqQPIzNfvBsN4kaYmTUSJn75ySuY69R
         V6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767989120; x=1768593920;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S9Sr0iBaMtENvjA7hDr85y5l+5Mpz9UCcJi1MXyO/Oo=;
        b=kV9foIwH3lMd0GfJR2GtN816xiiifbffQ+SVfk3fFC/87+D//5lwCEIIESeHyw/eDP
         t9+V7bZkyAUCTP54Vj3ycpjQPclfO71ZIn6k/tj9c3os0oRK/egzc/t/a4l+5M0Ctczo
         bVMkofzGvEx2PEoatpB7R+De6+7w/tUC3k/w5Go0EbCQntCOYKdznCDpGPB5pCZLh197
         mgEh1WY9iIA2bKO9/g93djqJ22K832UJOL2ceSQGrrjcTbNDs8RZRLF1fuLinRf2QUZN
         05kQ29buqCzquje9brXc5KhmA7D1lY3CZf5rawA1CjaXifm9QXzN6Z4KSN1F5bgqseM0
         Lcgw==
X-Gm-Message-State: AOJu0YyZ07c/JVSs+lG05Pc93auRxYyOnytx7GHkyDXs0NHTirHXVNM9
	rkwq6x/3tZA/kS0a1py+QqclpztFW3DXGggVMX86OgEb7bsw0i6Djo/j18FtFngV
X-Gm-Gg: AY/fxX4grjwgt/2IjUFi9Dg9981ohLrsBwC1PRVUduMSU5tS3A5H65IJSYKPLPKIudC
	X22Iw1C9OQWnxsXXdK/5AvQk0bLG2NsYU2l77PbiRwXEj+4+BJKoCoEwXg+egRFCx75Jvs6w6U2
	UBbE5sFbzrQN8LKMCRMf/rjsGNTHyefQE3aNMP4SCdWK9K9/dTonsuKHwJUBXwF1kFVgfh25FNV
	cfMpU7s9tZp0kttBvRGPWQJeL4+fFifgNV9tlowAxvqcF/WWppXgDK/Xz4VM9hYH5m9KwBu81iz
	4qYAUEamQZ91aHqVDvXikClb6CA+KObAAwi/t9GMNSJkr/szZSMLpuIMKzCnF9/jhzgkegNKkQp
	PRVe359kn6bsMj2XO5RiR04l4B2pD/2CBWop0eQMSmm5GRKuD8Bj+CHHaO7uALafyAtkyZiacLc
	1VLSujg81hSh4C
X-Google-Smtp-Source: AGHT+IGYl9L/Rit/qjTsOrG0Tt4kNQuyuOQqQss2sIn5oOCMlJtBfrFw2TTO3gXU6y61KcWbdJBglg==
X-Received: by 2002:a05:620a:290d:b0:89a:2f9b:10d3 with SMTP id af79cd13be357-8c38938eb7cmr1409372085a.30.1767989119913;
        Fri, 09 Jan 2026 12:05:19 -0800 (PST)
Received: from [127.0.0.1] ([20.161.67.219])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4b917dsm928767985a.17.2026.01.09.12.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 12:05:19 -0800 (PST)
Message-Id: <d3953f182658bf0935ff7962bb5f04f51bef7d51.1767989115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
	<pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 20:05:00 +0000
Subject: [PATCH v2 03/18] mingw: drop the separate `do_lstat()` function
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
Cc: Ben Knoble <ben.knoble@gmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Karsten Blees <karsten.blees@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Karsten Blees <karsten.blees@gmail.com>

From: Karsten Blees <karsten.blees@gmail.com>

With the new `mingw_stat()` implementation, `do_lstat()` is only called
from `mingw_lstat()` (with the function parameter `follow == 0`). Remove
the extra function and the old `mingw_stat()`-specific (`follow == 1`)
logic.

Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 13970ae729..ec6c2801d3 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -917,15 +917,7 @@ static int has_valid_directory_prefix(wchar_t *wfilename)
 	return 1;
 }
 
-/* We keep the do_lstat code in a separate function to avoid recursion.
- * When a path ends with a slash, the call to `GetFileAttributedExW()`
- * would fail. To prevent this, we strip any trailing slashes before that
- * call.
- *
- * If follow is true then act like stat() and report on the link
- * target. Otherwise report on the link itself.
- */
-static int do_lstat(int follow, const char *file_name, struct stat *buf)
+int mingw_lstat(const char *file_name, struct stat *buf)
 {
 	WIN32_FILE_ATTRIBUTE_DATA fdata;
 	wchar_t wfilename[MAX_PATH];
@@ -959,13 +951,7 @@ static int do_lstat(int follow, const char *file_name, struct stat *buf)
 			if (handle != INVALID_HANDLE_VALUE) {
 				if ((findbuf.dwFileAttributes & FILE_ATTRIBUTE_REPARSE_POINT) &&
 						(findbuf.dwReserved0 == IO_REPARSE_TAG_SYMLINK)) {
-					if (follow) {
-						char buffer[MAXIMUM_REPARSE_DATA_BUFFER_SIZE];
-						buf->st_size = readlink(file_name, buffer, MAXIMUM_REPARSE_DATA_BUFFER_SIZE);
-					} else {
-						buf->st_mode = S_IFLNK;
-					}
-					buf->st_mode |= S_IREAD;
+					buf->st_mode = S_IFLNK | S_IREAD;
 					if (!(findbuf.dwFileAttributes & FILE_ATTRIBUTE_READONLY))
 						buf->st_mode |= S_IWRITE;
 				}
@@ -1023,11 +1009,6 @@ static int get_file_info_by_handle(HANDLE hnd, struct stat *buf)
 	return 0;
 }
 
-int mingw_lstat(const char *file_name, struct stat *buf)
-{
-	return do_lstat(0, file_name, buf);
-}
-
 int mingw_stat(const char *file_name, struct stat *buf)
 {
 	wchar_t wfile_name[MAX_PATH];
-- 
gitgitgadget

