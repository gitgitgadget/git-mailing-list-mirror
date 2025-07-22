Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7352638BF
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753197797; cv=none; b=P8Qc8qNOudX9d6nX2WWhV5sotA5O96fp6Ln6rwZLYr+duHos/AN8cNy/o4c7FKJ+hJGpORqtHjovXpoLzYa/he/GlCFkEbPWasw47Lq4FuyE39B2laoWdasb22jo+qdi6YqkCWkipyttejvSpg30MfY8Liotj4/BiP4PP9VaGaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753197797; c=relaxed/simple;
	bh=rW6XAXHR/baKs2zZ4OwvdZLmXD2Bq4LF8tM/Fw4bCbI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mMZ/I3xiJUktaM/jhm46IDYoPbALG5flc8yvsE0J2viEl2LrZQ/MckiXmpL7km9shL5fTohFpu9cWy4OMJlrUQoUvecZWh/44oxMJ0Jwy1ruFYZ3zve369SKuGN2b0U1RDC1MX+52qtUPj3OSCzJ1FFtVO2saNM6BrywAo7AgKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwFfIGZD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwFfIGZD"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4563cfac2d2so42987875e9.3
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 08:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753197794; x=1753802594; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1X06A0NdexEto8yPmI1p6MIlBfs5M6iYOqr3bHf/G8=;
        b=OwFfIGZD/xjE/EhAH5zrcHqoJTGRdk1GTt5G1V63hrho+gjByqyOmGzo3B4fXteOeX
         61sYKaNd6ff7M/y+tvqWJ6vxBG2gkz1JOGK80lsODqB/BeShWSxN0e8kGgOei7yylU3Q
         dk1GBsW/YIbvQgI2e9V/pWWlZd8rc8fxvKIGPtwnoLjI50b+XdmGjgYI4RYeLtDe3LK/
         hPhTpDgJgQoJ4m8jcJLRwJ8f2dBEBYX5vuHnKdtXDrO3iosokGMIDK5i+ZKpFl+EwEe/
         AfCoji8d1+aAaTnhKq7cg1ydnSTxmLd7xzH0ndSTrWCpI3YLqZRXHU5XpHGsBf5H6/Je
         xZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753197794; x=1753802594;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1X06A0NdexEto8yPmI1p6MIlBfs5M6iYOqr3bHf/G8=;
        b=Dj7HdKRkpK6Gs312++0YafH5lGfKcjuw6zfvKWgVvjIp716dh6kIjPc6aejAzd6d59
         ihYOFsQKlmJTOQSErcDX4KMiG4QuyJj45EFYWjNXQHzU9AB7qhU/WflC6HAf5En4zpZI
         XyjzTc6ZOUAVG1o1+Sn5JeISnXEKieyWZ/Q1SMoBhRr3UCKsolw5HSud2KZ6TFEfhvhx
         Ay0uhbWiAKhxCp7SYr9lyHhuTM8qwyKDx44H753kLn/xuDlhlwCNUuE+Dx3GrZO7PxjU
         cO0JsRiIOSK1RkneRmjvrdPwkfYQmjU1rQEu+xUedlHQTC2mZxwkcEAgrVRnEltrAg/j
         V2iA==
X-Gm-Message-State: AOJu0YxDtiS/rKpA6uO3Q0wFPEcnLir/Me+gZrBYc5toFX1Yx4ElzTUY
	bjXmSvMtlzvNFGDleaaclHydDPboX4x0qOywuLn9POb/FMLAHiEEfq9UxXuxyg==
X-Gm-Gg: ASbGncu5fQG8ceZOIhwKfmr7HYJsdqHu/V+0YnMAhu4LmBtXU+iGBLfTi/5ZGlAoC8K
	ntwxfufzDazXaFRvCIH8RnfOIP4K8PhK1MXCF0VfQW919YLzJQJD/Vzgll/nPX1/9R9cegZ7Q+y
	DPTN7CQB5ymUavXpHTO9BTCsLxrwEjKwlVXOekU+yN3TeokCMJm/w99LJNSH/U4O5bkTPg9UvRX
	tIt7QQTfYDiNkPXAltRlCec8JX8xEmGZM55mvG6o3qheZiswds2RS2fIOO0BrKt9o3+CRHh7srD
	lgBbADTpCf19j/+73JMUHlr6aP/Ah3yzWbbSLzMRk065E2F+UnvDSsRe4UxgLW28c00rQT0jz0a
	SJfRxLnWosOKBDRJjNFn9Iw8=
X-Google-Smtp-Source: AGHT+IHNq+xKfgQDV+dixoHYKT+P8rvdznh6ygkg0JDHRedQmkf7GdZ1L4I9Z0zgTzNRZtx+lrniuA==
X-Received: by 2002:a05:600c:468b:b0:456:2419:dc05 with SMTP id 5b1f17b1804b1-4562e33db7fmr263434025e9.12.1753197793457;
        Tue, 22 Jul 2025 08:23:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b74ed25sm135579455e9.24.2025.07.22.08.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 08:23:13 -0700 (PDT)
Message-Id: <dccc204430535f8c9eb74d7861365dbb2c42bb02.1753197791.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
References: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 22 Jul 2025 15:23:06 +0000
Subject: [PATCH 1/6] merge-ort: update comments to modern testfile location
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

In commit 919df3195553 (Collect merge-related tests to t64xx,
2020-08-10), merge related tests were moved from t60xx to t64xx.  Some
comments in merge-ort relating to some tricky code referenced specific
testcases within certain testfiles for additional information, but
referred to their historical testfile names; update the testfile names
to mention their modern location.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 47b3d1730ece..d87ba6dd42bf 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2163,7 +2163,7 @@ static int handle_content_merge(struct merge_options *opt,
 		/*
 		 * FIXME: If opt->priv->call_depth && !clean, then we really
 		 * should not make result->mode match either a->mode or
-		 * b->mode; that causes t6036 "check conflicting mode for
+		 * b->mode; that causes t6416 "check conflicting mode for
 		 * regular file" to fail.  It would be best to use some other
 		 * mode, but we'll confuse all kinds of stuff if we use one
 		 * where S_ISREG(result->mode) isn't true, and if we use
@@ -2520,7 +2520,7 @@ static void compute_collisions(struct strmap *collisions,
 	 * happening, and fall back to no-directory-rename detection
 	 * behavior for those paths.
 	 *
-	 * See testcases 9e and all of section 5 from t6043 for examples.
+	 * See testcases 9e and all of section 5 from t6423 for examples.
 	 */
 	for (i = 0; i < pairs->nr; ++i) {
 		struct strmap_entry *rename_info;
@@ -2618,7 +2618,7 @@ static char *check_for_directory_rename(struct merge_options *opt,
 	 * That's why otherinfo and dir_rename_exclusions is here.
 	 *
 	 * As it turns out, this also prevents N-way transient rename
-	 * confusion; See testcases 9c and 9d of t6043.
+	 * confusion; See testcases 9c and 9d of t6423.
 	 */
 	new_dir = rename_info->value; /* old_dir = rename_info->key; */
 	otherinfo = strmap_get_entry(dir_rename_exclusions, new_dir);
-- 
gitgitgadget

