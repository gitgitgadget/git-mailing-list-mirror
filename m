Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2674818AE3
	for <git@vger.kernel.org>; Sat,  4 Jul 2026 23:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783208263; cv=none; b=WNirByTy5GfoHIbbwuZ3ULWUnDzueOgPzxzdTxysocLio6yrY3UvuB7So7enViek+udBwz7zcoWaML7zeToBUXTxan9TlEFsPSmZz4yXQ894OgeP9K9qg9DDn5us0gp/Eds1OV83cMARZaXWMBdLCb6p9UTGttE8yaAmp9dLKho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783208263; c=relaxed/simple;
	bh=Bb5hYrO95VlR80X+bTpwjfdY4JBNM17i1+KmpH2PApo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRrhxiOGQLoRxU+hlfa58ESxLv37fjLFzTqvzPQ4BsKma3uZ1swo1RXwXyZpH9j9o0hw+V0rmF4LXdCtGDj+qEGFj+apMvN0SC3rPm1oEhmkzhiTZSakXzUho8Ljfr4+FiuSEnEPJSkRPFdmOxcIYO1IhOXKF4yMh2e7Jo8vB/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oEFILz9R; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oEFILz9R"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-80e2cfe6918so23448137b3.0
        for <git@vger.kernel.org>; Sat, 04 Jul 2026 16:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783208261; x=1783813061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0O2p09lQTGEFnsUIn1owXeIeGeFe6bkCsTaTS8GOUSE=;
        b=oEFILz9REvyCSIivFfRFZECdvzYc2JiXBFtWi03HrdyAAWVhgriM3XHFYt7IH1NLC5
         jDN46DfSbfNnYVoSEdc2CUbRxiMvZfbCOMqzrQBsVmIdsGqT/Gp31gl4Oq6NRnW1z2/q
         lmW2RHvFQis6ARv0bOi0pPc1+8nI8Rr77YAUh84qRO+J9HPzuS2DmDkGcpb+VtI9EnYY
         S/7AG40cERlE0wEeuAYHGsdMWwpRuxGnn5zZaLuFq9EdZ22qNAB04OvfLCevYUS0xaRG
         buCMrhmJWQ70dmwabegDrC1dkMrdvWrJrnbRb9WkHI0D9gGRN17vCfPUEvdJP/AEyHME
         HCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783208261; x=1783813061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0O2p09lQTGEFnsUIn1owXeIeGeFe6bkCsTaTS8GOUSE=;
        b=QIv6nng8bNtOdeV/SPEXtSZC4kppBmbFbZhBLkZX1pK7UzSQV9GDrUMIkaPABFMvIm
         D+kxocpguCtOf6XNpU+TjzzIvVlCaFthzVOKIVeUuAtNeVjUR4v4PRexCZX4skL4SVfv
         vzvuy7+YSygFaydtC/jrfxDA44D7TYEj1WMoBEKvwop071w7aOCDdojiL06lWKhxVcAJ
         jXZtmpZZr+p9BhbpWqG0Zcv5rZ2swODYdK6jwfY0EC9DiQ5/XZZ5Avbw5ahu3b4hxglU
         jynVZshgwIk4V/AtYF/77QrtikYCFEjQI+70POyEdieI4NGdQUTCTdkBzDNUqqhtDT0v
         Od2A==
X-Gm-Message-State: AOJu0Yw89brpVVHUqFfrYU6zjcnXa6GL1sbLr3Cw9elZNnPwYGjtwVzN
	brs0T7SsUvYBPgZlHskAuA3xa9I0EFJq0EjKXnTig81V0Eft9qIhr0V00RGRnw==
X-Gm-Gg: AfdE7cmeCC8XU/gr6r6LKEm++ltuJHX81iIArSxzWZIvZrJIaT1TUEjfPK+7yL/zsLO
	Y7+Miirtv+bigkHa+Xql8SPKJJldNOmmFKu1F8FGpDCWXmkS4dNhnYAtLiaHgKj0I7J2s1Dci51
	y4kKTDuJJPD9q3FiDrUVmKNzf17H4FVjW4AP91VGpB26bQOH2Zb/0kLAvQe+3+KWm6GfUTcSjfb
	Co4yx3akDlrlFmHgxxU671Lo655B3YwLzZBNlVjvX/+DsY6CZmnc/yPvAmAHVYol/FU0W/8I6hO
	fTOgH75yjz/FhzjpgGb5kyJ7YRTih/LcAZW91kTUKd+4/Jzl3Yn4MfXgsHvV0AIckIemFaMcwxR
	Hi27jX5KETEjID4B51vbijXZAtpywPO8vr3QKBnKgyfEjPgQaW9//hE1PLidGaBwUTQyw29QAdh
	O/SoMLeILH5SgRZUTYcTtnBcxZIYkwsCiH0sBq5A==
X-Received: by 2002:a05:690c:23ca:b0:80e:38c5:bc39 with SMTP id 00721157ae682-81737448db9mr53162877b3.7.1783208261073;
        Sat, 04 Jul 2026 16:37:41 -0700 (PDT)
Received: from mair.home.arpa ([65.187.96.176])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8144ba240d1sm39473827b3.42.2026.07.04.16.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 16:37:40 -0700 (PDT)
From: Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] precompose_utf8: use a flex array for d_name
Date: Sat,  4 Jul 2026 19:37:24 -0400
Message-ID: <20260704233724.16928-1-ihar.hrachyshka@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703023554.36577-1-ihar.hrachyshka@gmail.com>
References: <20260703023554.36577-1-ihar.hrachyshka@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On macOS, git status may abort while reading a directory entry
whose UTF-8 name grows past NAME_MAX bytes:

  __chk_fail_overflow
  __strlcpy_chk
  precompose_utf8_readdir
  read_directory_recursive
  wt_status_collect
  cmd_status

The precompose wrapper already reallocates dirent_prec_psx for
long names, but d_name is declared as char[NAME_MAX + 1]. A
fortified libc can still see that declared object size and reject a
larger strlcpy bound, even though the allocation was grown.

Make d_name a FLEX_ARRAY and size allocations from offsetof(). That
matches the actual object layout with the dynamic allocation, so the
fortified copy sees a destination whose size can grow with max_name_len.

Add a regression test that creates an over-NAME_MAX non-ASCII basename
and runs status with core.precomposeunicode enabled.

Signed-off-by: Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
---

Changes in v2:
- Drop perl from the regression test and use printf/tr instead.
- Use the minimal 256-byte filename that reproduces the crash.

 compat/precompose_utf8.c     | 12 ++++++++----
 compat/precompose_utf8.h     |  9 +++++----
 t/t3910-mac-os-precompose.sh | 16 ++++++++++++++++
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 1711794..8077f62 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -19,6 +19,11 @@ typedef char *iconv_ibp;
 static const char *repo_encoding = "UTF-8";
 static const char *path_encoding = "UTF-8-MAC";
 
+static size_t dirent_prec_psx_size(size_t max_name_len)
+{
+	return st_add(offsetof(dirent_prec_psx, d_name), max_name_len);
+}
+
 static size_t has_non_ascii(const char *s, size_t maxlen, size_t *strlen_c)
 {
 	const uint8_t *ptr = (const uint8_t *)s;
@@ -114,8 +119,8 @@ const char *precompose_argv_prefix(int argc, const char **argv, const char *pref
 PREC_DIR *precompose_utf8_opendir(const char *dirname)
 {
 	PREC_DIR *prec_dir = xmalloc(sizeof(PREC_DIR));
-	prec_dir->dirent_nfc = xmalloc(sizeof(dirent_prec_psx));
-	prec_dir->dirent_nfc->max_name_len = sizeof(prec_dir->dirent_nfc->d_name);
+	prec_dir->dirent_nfc = xmalloc(dirent_prec_psx_size(NAME_MAX + 1));
+	prec_dir->dirent_nfc->max_name_len = NAME_MAX + 1;
 
 	prec_dir->dirp = opendir(dirname);
 	if (!prec_dir->dirp) {
@@ -145,8 +150,7 @@ struct dirent_prec_psx *precompose_utf8_readdir(PREC_DIR *prec_dir)
 		int ret_errno = errno;
 
 		if (new_maxlen > prec_dir->dirent_nfc->max_name_len) {
-			size_t new_len = sizeof(dirent_prec_psx) + new_maxlen -
-				sizeof(prec_dir->dirent_nfc->d_name);
+			size_t new_len = dirent_prec_psx_size(new_maxlen);
 
 			prec_dir->dirent_nfc = xrealloc(prec_dir->dirent_nfc, new_len);
 			prec_dir->dirent_nfc->max_name_len = new_maxlen;
diff --git a/compat/precompose_utf8.h b/compat/precompose_utf8.h
index fea06cf..c7c3cc2 100644
--- a/compat/precompose_utf8.h
+++ b/compat/precompose_utf8.h
@@ -14,11 +14,12 @@ typedef struct dirent_prec_psx {
 
 	/*
 	 * See http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/dirent.h.html
-	 * NAME_MAX + 1 should be enough, but some systems have
-	 * NAME_MAX=255 and strlen(d_name) may return 508 or 510
-	 * Solution: allocate more when needed, see precompose_utf8_readdir()
+	 * Start with room for NAME_MAX + 1 bytes, but keep d_name as a
+	 * flexible array. Some systems have NAME_MAX=255 while strlen(d_name)
+	 * from readdir() may return 508 or 510 bytes. Grow the allocation as
+	 * needed in precompose_utf8_readdir().
 	 */
-	char   d_name[NAME_MAX+1];
+	char   d_name[FLEX_ARRAY];
 } dirent_prec_psx;
 
 
diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose.sh
index 6d5918c..ea75fb4 100755
--- a/t/t3910-mac-os-precompose.sh
+++ b/t/t3910-mac-os-precompose.sh
@@ -207,6 +207,22 @@ test_expect_success "Add long precomposed filename" '
 	git commit -m "Long filename"
 '
 
+test_expect_success "status with long non-ASCII filename" '
+	test_when_finished "rm -rf long-utf8-status" &&
+	git init long-utf8-status &&
+	(
+		cd long-utf8-status &&
+		test "$(git config --bool core.precomposeunicode)" = true &&
+		long_utf8_name=$(
+			printf "%253s\342\200\224" "" |
+			tr " " a
+		) &&
+		test "$(printf "%s" "$long_utf8_name" | wc -c | tr -d " ")" = 256 &&
+		printf "content\n" >"$long_utf8_name" &&
+		git status --porcelain=v1 >actual
+	)
+'
+
 test_expect_failure 'handle existing decomposed filenames' '
 	echo content >"verbatim.$Adiarnfd" &&
 	git -c core.precomposeunicode=false add "verbatim.$Adiarnfd" &&
-- 
2.54.0

