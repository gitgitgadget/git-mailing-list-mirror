Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB48417D86
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 06:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791958181; cv=none; b=owDP16X5cDQX4iXHmnhyzJaNMC4WLrjy1LSOrOKhVocmjvX5NRS/WTaQRmgRwqIl/8dJf4espj42ZkIt8DbRIAiKNV4QdqyCg5+BMKB13A9jDNzenfDj4s2IYpkbxUybrALveSEthAAMaZ1eXBalosqxras4IQj3FXIbIaHwiF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791958181; c=relaxed/simple;
	bh=GMlD/eBWQxrQxY7TEc8HRIqLeLZ+w1njCUQYQXsEFOs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZgP1HSsbZO89X00OXpAXD1Ddzhqrd60rvSsmrq5d5W3JGAnHpI8tWkgy83teeap6m/QZNsHLj3zuETRXxNm1qwb1+0Xp0jh2eaw0HVNreKuC3WwE1mBPrZJmKqUM3PECe9cSoagrZ3iUis6prCK182EmBOLyV5G0/Kd79+D0txk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPimDCv7; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPimDCv7"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-9144e8021d3so223856d6.3
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 23:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791958178; x=1792562978; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xsfecZSkKeiQAqQP7AWZJhO9hHpfIXAXhhCEo3qqqqQ=;
        b=SPimDCv7z6x0uLt/0U0j4Aa2GnLxZxYAZQxjBcA+jlxTyRoFXR0nR7M565pPEQUhe7
         MIHw3pJMKdRhfqO9ouxRZPbaTnPJg8YkrCV9hCwcI5uPuxZX00i19gGwA71u+7NgaTak
         sEzeGkaEPg/xjPs4KMrqWrgVp56zDaqRUQaRSOdsjrj/Zx1tn2W3NEHjUtiJgTJzexc2
         SMgiD15eOR8QdCTWhM2TsFWG16CCOS8fTStY1isHT4nc/8anM0XSavnf9n01r1cN+p2e
         BRMZgTNTfvL1BUNyRF/MeCnrbHQWrEq+sxcN1NmlZKA9WPhQ73s2+PmLuWl5zR6pf/47
         2c3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791958178; x=1792562978;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xsfecZSkKeiQAqQP7AWZJhO9hHpfIXAXhhCEo3qqqqQ=;
        b=k4CbIynmvA+GZNkrKVpak/Jtnm7GMo+0ZhlwR2rAOFEzInbk2O1s3PNAE8B6hxPsKt
         B+/LsizsFc3wNPRPIOxZVmKsWs7vBwexOeTeBKaaZjS/7ShBf+atldSNAF4F+a/iM+vY
         GCvxA4QCKR1HOc1mNGiQnTMJtN9uQ8YvTUlC8FfbySemVzkjMkCL2RjPbT80EMzNV6fL
         SbQEq6luYmXHxI2u0nBzTtqT2rWGUPZvEMO0BooW+0n9vWAY7MbULrMOkNrpc/fp0v+S
         /1PbJnHBPAr1y0zoccIIqDPe5LckDyk7IVHHIOaIKCdAhIvL0pW2eI2ge5VZNmqhMIYM
         FNFg==
X-Gm-Message-State: AFq9FYJZYIhd4Y+rnJdd3XnUYzTgraTbrTellwYvZ5T94okqg28VciuF
	FbWfFMdMPtLF4y6L0AdSIz9y0A3QmKg/+n7cPHK9qtdOFculT6JB8y4L7fow3g==
X-Gm-Gg: AYBFou1Z+T67dtkeaUJz8xaxEl3PoG37TIr3Y52BMzmXuPNWKnrup7i1f4WCMGMhlQh
	zt0cGm8OVCTtB3Voe8VUW0ZmJlg+ZWiLVQDjIMo9RVDKEXUQCAg/DquXHktYcuyTrCWFU3aXf7t
	ymsqMOy4ACZNcfG9pF29zQp6/3x1HaRWszDmYGRJIyy91em856EldF9wcthDRRbfwNUDt2XzWQp
	zG0WtFiDEMDlfsJmtQMD3dtPc2a2xXL/zn/+a9nm5dR6S8iIT2t+oj7mUDXTiaDcG7vAU5sHdae
	VSHCzSFn4uixqBpAAQzAXmQ3/fZlf/68mwOOMy7Nz6+u+23iD/1gbPYpbXgXfYsQ+OKe08pOyLS
	JwK9f7/8D0bdLDr0SmGaDhnM/R7TPyDOLkkFhrXvjj4CHC2p2e31/JchLV8qlYW6UkC6zGYkpzQ
	/51OV0VOSUDLB4NwEnDBrqSiydxMe+cgz+T8Ym9FYVwcAL9N682MbVJjSbtD+4alHx+4TAS+vTc
	5uZNg/Orls=
X-Received: by 2002:a05:6214:5f0a:b0:919:867b:5215 with SMTP id 6a1803df08f44-91b55334746mr242100196d6.3.1791958178520;
        Tue, 13 Oct 2026 23:09:38 -0700 (PDT)
Received: from [127.0.0.1] ([9.234.149.85])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b622bfsm44784116d6.24.2026.10.13.23.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 23:09:38 -0700 (PDT)
Message-Id: <a4e602b9e726081aaaf73c627548b823a4d35477.1791958171.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 06:09:31 +0000
Subject: [PATCH 5/5] date: avoid overflow in approxidate relative-time
 multiplication
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

The `approxidate_alpha()` function multiplies a time unit length (e.g.,
604800 for weeks) by a user-supplied number to compute a time offset in
seconds. Both operands are `int`, and the product is passed to
`update_tm()` as `time_t`. For inputs like "99999 weeks ago", the int
multiplication overflows (604800 * 99999 is roughly 60 billion, far
beyond `INT_MAX`), producing a wrapped value that results in a wrong
date.

Use the checked `time_t` multiplication so oversized products do not
overflow or wrap around.

On platforms where `time_t` is unsigned (and where the pre-processor
allows us to determine this fact), reject counts that are too large and
report a parse error. Narrowing them first could otherwise produce
negative or truncated values that become bogus offsets. Leave signed
`time_t` count parsing unchanged.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6 and GPT-6.1 Sol
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 date.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/date.c b/date.c
index 014065b419..0d65804d2f 100644
--- a/date.c
+++ b/date.c
@@ -1298,7 +1298,18 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
 	while (tl->type) {
 		size_t len = strlen(tl->type);
 		if (match_string(date, tl->type) >= len-1) {
-			update_tm(tm, now, tl->length * *num);
+			time_t length = tl->length, num_t = *num;
+			time_t seconds;
+#ifndef is_unsigned_type
+			seconds = length * num_t;
+#else
+			time_t max_val = is_unsigned_type(length)
+				? maximum_unsigned_value_of_type(length)
+				: maximum_signed_value_of_type(length);
+			seconds = mult_overflows(length, num_t)
+				? max_val : length * num_t;
+#endif
+			update_tm(tm, now, seconds);
 			*num = 0;
 			*touched = 1;
 			return end;
@@ -1368,8 +1379,15 @@ static const char *approxidate_digit(const char *date, struct tm *tm, int *num,
 	}
 
 	/* Accept zero-padding only for small numbers ("Dec 02", never "Dec 0002") */
-	if (date[0] != '0' || end - date <= 2)
+	if (date[0] != '0' || end - date <= 2) {
+#ifdef is_unsigned_type
+		if (is_unsigned_type((time_t)0) &&
+		    (number > INT_MAX ||
+		     number > maximum_unsigned_value_of_type((time_t)0)))
+			return NULL;
+#endif
 		*num = number;
+	}
 	return end;
 }
 
@@ -1398,6 +1416,10 @@ static timestamp_t approxidate_str(const char *date,
 		if (isdigit(c)) {
 			pending_number(&tm, &number);
 			date = approxidate_digit(date-1, &tm, &number, time_sec);
+			if (!date) {
+				*error_ret = 1;
+				return 0;
+			}
 			touched = 1;
 			continue;
 		}
-- 
gitgitgadget
