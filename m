Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3527039A116
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980555; cv=none; b=VK0Bv2lCdinHlMtymyGGUoHbdPdHthwmOdq2RthvxdUgBnNBNrQayvvT1DkCCLA04iFr0WUo/DuzqL72bErRToU7YHsOZIbzLFlK5RAFUmtv6HvV1dHVPXx7E+TzwaPxaYD1udqZKyh90La7Cl0bgm5RrCys/fjQxebFtj/djOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980555; c=relaxed/simple;
	bh=eva4AZY4iNxlWW8SJAvEuUVq8JZ0no2gf/OB8YEVIQI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VO64zdsjDo91jq0s1sugrdrEd0dSbRiviDIWQHs2IfKcquvNnAyvlcmtDh45wtLyojWtI4u6K51CdFMb/BbpRgBD1kyGSFdgWF4yI2Ssmp2EgNGpcCkQxnoYLlUOtsh9uJooA11O8/EIlbbSk1hB8o3Q60FAYclapYihPjz9yR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VC5GmrgM; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VC5GmrgM"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88860551e39so50665866d6.3
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765980553; x=1766585353; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9CWEOi4hD4ipi8mZnom2/dXIxwydGgeZyBlUQ5lN1Q=;
        b=VC5GmrgMvSm5SM/biopw8XnXvkq/Bw+W4sqSrxEA4Gyojp0cETGoUAvqVSC1LSD+El
         pKCJC4HBZg3/iDOryOtaEyxk/0YRBICwfqxl/mYOf5HpZViwPQRQ+ZX4BABEYheESjdV
         54Z/oNgQD7uLjRi+s6tBmQ1uU1qsWC4tPoRMb2qTVub51zpwdC0jioi7uWTaBFHq1Ul1
         iHSOlOtiNzb6R/fxTWkQHcUMlctpwEFxejmUEYG9LuAqMib3wBwsFRVzzycDSGNZC+CX
         pZDq05Hq+P1AB07Jb0ch1oSl3vI/IQ41S6mU2mvRqGcUErnxTOqBRoIJAg2gu4BwxV1f
         GwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765980553; x=1766585353;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N9CWEOi4hD4ipi8mZnom2/dXIxwydGgeZyBlUQ5lN1Q=;
        b=kw43Jv7Y6D0986Vllhg0HHQ93vSXIyAlRmmVu53xZWSjwSxKzZWefaXIvzMCu3IcCj
         ZTyf7YPVAKsW6NzXU2zVEtHVMDaUtt5oOVvi6LehSKePnPYlCv6KS9+s45K1UGZ91xiY
         mHrOZHelEw+00/9tdf2vWaflvGiiPDCQ5urK7ou2wv0RQ0OS+FyT9NXqYJAS7Pv+pmYW
         6iDK+PXk5p6oSqd3MyM6pmPolPhotke3Ef/M+TLzueXs/PfAoRsOh9lRqgBl9AzUHdId
         pdZNBr2xiOEQYnfhA43MkxYKnJSf29IMWQ7AnibJq/InM+qgH43L1ojiFzyVl/dIzkjw
         nDLA==
X-Gm-Message-State: AOJu0Yzgo/qY2QjBZKjDrwb5xo+fX2GzvgZy5OAOoB1dWGpFfGKFHrM/
	7PjFORyYAiGV2EXM7kEuUpM5KnbLlqtIouxHuGB6G6BIWh8QgxsIGgn3hrizJLpp
X-Gm-Gg: AY/fxX5D27FGQp9nw5drhj4046K+7ypNJiR5GOjyIPVAQKx7XyAv4UZ6tdtjAE9zKdk
	gRDYO1diRNVUr6pBXVc3oaYuwJra7Ec9DOwpm/7/Eiv2GzgH9eYsCAVcW6xHkOrk7R4/20fqprr
	3LfPe4EYa6MP9rBtEOqRI1mSWMkejED4KFrfkxVKhDHeR38g+zRS+NPPTjdFmBR6UkKRQx3JEzk
	EOhNDbtBmWAx35gQMpJpmd7jaVDYBWGqlh0BCPFx4ORYSamnDJN++4CpX6dRZIyYrk5+oUlm+r+
	EKba8YMVuLA3dPPoyWRREynbATKNSSJL3EIsoWYZMGhcqjkqDnPA6zeMg+P/B4Ha92mxPv7QmZd
	1K6GwiVIzVy9hzs67jhWWGBfDR7DNH41Vh/2qFIiBdRD+WVm1lVzZhgP3PRA84rPWyK0EqbSQJB
	VQMmtGH9k8bdujpcwpDnQoLw==
X-Google-Smtp-Source: AGHT+IHtzpmu1YKcHc0s/IzL+j4U1xi4tKZ7SA4dufEtCzHjenVoKI6dzxMJDK5GB/+uuWpJJbn2Rw==
X-Received: by 2002:a05:6214:3203:b0:880:4b27:1888 with SMTP id 6a1803df08f44-8887e16bb44mr256603896d6.3.1765980550262;
        Wed, 17 Dec 2025 06:09:10 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.69])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88993b4204asm96322526d6.7.2025.12.17.06.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:09:09 -0800 (PST)
Message-Id: <5cb3b10500339fec403b84e30721e4f6a68e42f6.1765980535.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:08:48 +0000
Subject: [PATCH 11/18] mingw: support renaming symlinks
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
    Karsten Blees <blees@dcon.de>

From: Karsten Blees <blees@dcon.de>

Older MSVCRT's `_wrename()` function cannot rename symlinks over
existing files: it returns success without doing anything. Newer
MSVCR*.dll versions probably do not share this problem: according to CRT
sources, they just call `MoveFileEx()` with the `MOVEFILE_COPY_ALLOWED`
flag.

Avoid the `_wrename()` call, and go with directly calling
`MoveFileEx()`, with proper error handling of course.

Signed-off-by: Karsten Blees <blees@dcon.de>
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

