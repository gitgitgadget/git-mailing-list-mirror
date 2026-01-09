Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD20369966
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989135; cv=none; b=ex+3Fe1Jd5KTOOEwhMX8DzPHAfRALTGMbDrMxjFmMpxIj84KN3BVxrZDZxxP/Mbz45i3aENd+tTL4EbxNRoHVcE0GUUPDbRpDvGYGf7bJBRad5zPHJ+5WBOqSAjVFK3XfBxtFNTii3P1PvVAizRj0LgB7GCPsRmFKngs2wHixZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989135; c=relaxed/simple;
	bh=Pl1eKjjL8WAc++uqQD3rhxV9vumEHNZnhGdgXa9vLUA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=okaLJImjv1GpvLlhGfhwJXvG0yzZtbhbIQn+2HF8y3ow5CoAQWhAem99/Tdh8xKA/OwKoKujLh9gAuUvcp5Mzgk1M9sBLDGEhnweoPHec80za5QXgcOuMeMEgtKcNVvUNr5Rq5rpphuWNl0LMD3Mbi6jfWDIqTx/NcDou8FDOVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBVbjTZJ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBVbjTZJ"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4f4cd02f915so34462411cf.1
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 12:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767989130; x=1768593930; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TR/8OJdHcNUmjByOTHR01sKPQthQQcJrNtHhMH3hN9Q=;
        b=LBVbjTZJNhDtHkwCKvxcVU7qiMLZNIIJd7UnfGTmBiGro/mRD3CKEXNnrU3oNModag
         1abyru05AWQ5ehOFGrdknJQjDsYIBGG/xlesQMLdI/fZpQRsHsn2t5Z5WNIADNrmPhp8
         +H+8trLY4q93LV2ic2K/Oen++1fCQyZvDfaWtXFO5jUEAt02vPOgrfUgIMg38nlHjdme
         dPhxJ56W6DxWH6o7fvPYo12/SlqCuFAwqGSTE/Lyg3diUtPP+2qC/uMBqM/3xwV9t4zs
         f680W61Zj4MGUsJGtIRQFezBMZ/xpYCahnw1kf41yctIJ4xptiANHRj44eykC+wfoXh2
         UO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767989130; x=1768593930;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TR/8OJdHcNUmjByOTHR01sKPQthQQcJrNtHhMH3hN9Q=;
        b=bM96YTXvKP5xpZpxTNXb/041XkqYf/uIWwq6sn0T2zH5xJipwqgYvvBj+iDxhe23KC
         iJhMVDto5jRqMuTwCirC3SwDBwotymENh/+mdiREgS9hycg/4+fsKljEoDzl6ihY+xsz
         Hnd+m7R/Qurk6uKYvfam2NMANtaxMtRmBb/V0/34/VZmN8myUjxFLgk9gG4y1mE+gYOe
         3lHl+WqRASY2/99e8ksevc8KL1xLeUTLQHoEaUo/krCFlHctkQEQN5QZ024y4MHkjjOF
         sO8SJuUi4AQXT9aH3AZrXUeXcbJa+l02p2BvP2apnhmdKkQDUijLBdT4umld6/3e6njr
         Faxg==
X-Gm-Message-State: AOJu0Yzpz8QkkmuZioi1s3UUSVh4lNOMC0sNP25e8qolVHjQ+Q63IgkU
	sWOJIipryGqJtTTMez0EhxyO5brz+Asje0CykWIyV+7rGSVE0Mjg7bSqck8fUvdh
X-Gm-Gg: AY/fxX59z90ZuLVJiC6KASPyNstiNqXgs0yLFNg/oJjlPN1lpVIlEykSvBjoxi3Dq9Z
	0QoPDXhgp/5nKNo3Y9+39bAWMrDnPJQ1UH+UWvnrL4ZRRtmhVoIfmOtEjxFLdyL2sRop7sJEdr8
	f0/roxEA6fvAUpwux4MngXvwAxeDOuE1Jf0mXVJGYuwMAuw6v7ciFWuKgJ9bwqlQwYjo65vy48t
	RawptMcIVP1URcI7pTsiLRrx8O835kXIbwtAtgfr0GESVp+vDWoV5sF/c2UfGqMMSjrnfU4SBuO
	kBc8BL2DP1Zq+lO0aSlz7D7/97LKnrxxIeY84UG8EibbkdqwPTbcD0eFZAN4VjJFeo6kvTVB4TS
	k4CWRhEsUNkGW9ywp4PdWSSCHc0kJR44Owfk3oUTqjiKAmAxVJTRJVWVUibT87KqBpj7x73JfHT
	R0FaYPFVrTAwhC
X-Google-Smtp-Source: AGHT+IF4cylaJiqa6vpOO5/LBULzBHwCc5K7p2oG2kwtsClf7RbuzP0BWEogI87/EaJcOHUPYMUlCw==
X-Received: by 2002:a05:622a:4a0f:b0:4ff:9737:ba91 with SMTP id d75a77b69052e-4ffb492e796mr129252191cf.25.1767989130443;
        Fri, 09 Jan 2026 12:05:30 -0800 (PST)
Received: from [127.0.0.1] ([20.161.67.219])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffb9e97ef2sm50212681cf.10.2026.01.09.12.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 12:05:29 -0800 (PST)
Message-Id: <3670a0a181f8c1198ffea6560ae81a4b4f949be2.1767989115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
	<pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 20:05:08 +0000
Subject: [PATCH v2 11/18] mingw: support renaming symlinks
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

Older MSVCRT's `_wrename()` function cannot rename symlinks over
existing files: it returns success without doing anything. Newer
MSVCR*.dll versions probably do not share this problem: according to CRT
sources, they just call `MoveFileEx()` with the `MOVEFILE_COPY_ALLOWED`
flag.

Avoid the `_wrename()` call, and go with directly calling
`MoveFileEx()`, with proper error handling of course.

Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index b1cc30d0f1..55f0bb478e 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2275,7 +2275,7 @@ int mingw_accept(int sockfd1, struct sockaddr *sa, socklen_t *sz)
 int mingw_rename(const char *pold, const char *pnew)
 {
 	static int supports_file_rename_info_ex = 1;
-	DWORD attrs, gle;
+	DWORD attrs = INVALID_FILE_ATTRIBUTES, gle;
 	int tries = 0;
 	wchar_t wpold[MAX_PATH], wpnew[MAX_PATH];
 	int wpnew_len;
@@ -2286,15 +2286,6 @@ int mingw_rename(const char *pold, const char *pnew)
 	if (wpnew_len < 0)
 		return -1;
 
-	/*
-	 * Try native rename() first to get errno right.
-	 * It is based on MoveFile(), which cannot overwrite existing files.
-	 */
-	if (!_wrename(wpold, wpnew))
-		return 0;
-	if (errno != EEXIST)
-		return -1;
-
 repeat:
 	if (supports_file_rename_info_ex) {
 		/*
@@ -2370,13 +2361,22 @@ repeat:
 		 * to retry.
 		 */
 	} else {
-		if (MoveFileExW(wpold, wpnew, MOVEFILE_REPLACE_EXISTING))
+		if (MoveFileExW(wpold, wpnew,
+				MOVEFILE_REPLACE_EXISTING | MOVEFILE_COPY_ALLOWED))
 			return 0;
 		gle = GetLastError();
 	}
 
-	/* TODO: translate more errors */
-	if (gle == ERROR_ACCESS_DENIED &&
+	/* revert file attributes on failure */
+	if (attrs != INVALID_FILE_ATTRIBUTES)
+		SetFileAttributesW(wpnew, attrs);
+
+	if (!is_file_in_use_error(gle)) {
+		errno = err_win_to_posix(gle);
+		return -1;
+	}
+
+	if (attrs == INVALID_FILE_ATTRIBUTES &&
 	    (attrs = GetFileAttributesW(wpnew)) != INVALID_FILE_ATTRIBUTES) {
 		if (attrs & FILE_ATTRIBUTE_DIRECTORY) {
 			DWORD attrsold = GetFileAttributesW(wpold);
@@ -2388,16 +2388,10 @@ repeat:
 			return -1;
 		}
 		if ((attrs & FILE_ATTRIBUTE_READONLY) &&
-		    SetFileAttributesW(wpnew, attrs & ~FILE_ATTRIBUTE_READONLY)) {
-			if (MoveFileExW(wpold, wpnew, MOVEFILE_REPLACE_EXISTING))
-				return 0;
-			gle = GetLastError();
-			/* revert file attributes on failure */
-			SetFileAttributesW(wpnew, attrs);
-		}
+		    SetFileAttributesW(wpnew, attrs & ~FILE_ATTRIBUTE_READONLY))
+			goto repeat;
 	}
-	if (gle == ERROR_ACCESS_DENIED &&
-	       retry_ask_yes_no(&tries, "Rename from '%s' to '%s' failed. "
+	if (retry_ask_yes_no(&tries, "Rename from '%s' to '%s' failed. "
 		       "Should I try again?", pold, pnew))
 		goto repeat;
 
-- 
gitgitgadget

