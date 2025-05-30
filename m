Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4F523C4FA
	for <git@vger.kernel.org>; Fri, 30 May 2025 18:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748628854; cv=none; b=nf0z/6TLf7A+zw0O4e8O+HXvuNaKUejvmhQm3I4z5Kj/tKkNCT8YmCVK9FnLcvJ1VfjLWqLRfrXLG1qoFAfBvGHggENAw/GEuAlCRcPTKgjf2mkFU0aR4Eh2GIkNDo7UgKAahg8dzazHTTeNkWXhpJ0qEgKkpQKO+Z2wxz0VxoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748628854; c=relaxed/simple;
	bh=1LWXJPpwVfQqO1Cza5WBCw7qJNIxHuCTBe+6CkH9duo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=n+S7MYfK9tNJ+jo2nDBMASnNLkEAzC6RcZaFD1JClTiD+dMSTlqVw+e61zkKxoX6LXtDtCgMY8gl/+LvReRBiYxUhxbdRbj6x6wgCt8TTg06MIt/YoMWknx3hq2qNUZKoFIFUkFJ/reBU8yp4nuNhC+U1QhVl/Qb57nnlpJcOZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCf/dyGM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCf/dyGM"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-441ab63a415so24957365e9.3
        for <git@vger.kernel.org>; Fri, 30 May 2025 11:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748628849; x=1749233649; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FACvJeYzQcZfdCYKUE7wTebEhBakCQ63a9n2CGS/Uk=;
        b=eCf/dyGM//iXseCMaqTzC5yJC4Hr7V+a8nH/JwDeACH4CLcs/tdhQC1HkpOst5YF/I
         IupHEy+VpYn+nfkYMn20xfw+L+uZXdYjog54TvjfT8K/nFVuiq1cBy6i5TQ4zPYKmuq5
         HJGL2CN4ANzoQIL0RlOUNTHCZPz/m7JkbHKsOJBDKncX13edNXNkv+IlUggsggh3344F
         oplNqaw+yxqVQ4yF/MEKX/5eROZwUFppHw2c+ZWieh13zgg9x/N6ld2J4uJaEqqSj6x/
         hIoRRwHUfwywvQXP6+TwZKQLmit+FLTN2FeuIzI9C16xXIgOMinE8BWRmZzdb5bnt9J6
         /JNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748628849; x=1749233649;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FACvJeYzQcZfdCYKUE7wTebEhBakCQ63a9n2CGS/Uk=;
        b=NTNBKVUbOeXzVAOVQLWwk01Zc4Wm+VZFN6F8KJhMH1f7rEJXgULYRIPyYXBBkXl1iO
         CmYLDHfBd0Ngc+45rz+KoYIWYI1TpykFyi9sGd56PR7jrFzcGULWZJ8nkzcJWHF5p3oV
         eOIn9Hb7NWSbVMl1JOLNtCXaX13AjgKjjF0eNbNlc0MC+4rIRdEIBv3VmcPWiO2xuNWU
         BQ55s/bgdlkmfqDvXZYLFV8Vxyoi5Hdbg35/b1NKYiZfkDDeCbRLCfSa5QUyBBOaDAta
         MaV2D8tTQN/BDV/QSuqU6/8In36k9Hx0uNQ612ZJDj4015HCcMbHEj8IiYMalERz7nVa
         Yd5Q==
X-Gm-Message-State: AOJu0YxPmDhLGKLdbDYhqPn9BEh9vaOVNVLJ83N89X7p6kBaH1XJ0Ccv
	gxdOL3+n2avl2rwSMU+zCmZjHihcCVHrrxY/RFZ3URN1OTIs5zVmgUh3Aqgo4w==
X-Gm-Gg: ASbGncvSaceAjSRHbrpHwbk9yaWDAYEtrhXupypkPW/JYMa+a29weQJ9DsIQUw59K1U
	XeEGacXtJp+VbU75zr4zdZx3gsReAZWmX8Yk8pd+5m0mTyyrIAvW0pP88nw1v2fREBnlCeKc4MK
	5kOuoYEDnMm44OclS2O3AXGI12Gvc/5NpNXrTRUmJSfTYschOgTNO06ajCG60pdKWpSWipAg4Jy
	1KxaT8wWfvtv0vplplC79yNTQQ+3JvKG5JHbuAVcz00xfU2mM5eiGkYcx10V+SXroqxBCbjK4Ee
	BocUozOKvG6YBErGaGGMB6oUPadQI93YDWzjAsQ9ZlwYYb2/neYYN15RRzePWm85a+Na+PLIcA=
	=
X-Google-Smtp-Source: AGHT+IGBlGKcHP31q+brcyZpAWsQKs9cTOLzzHJJTuTF2jR3jYQZacxvyk9C4QelufjK5HoiB5bnnA==
X-Received: by 2002:a05:600c:6286:b0:442:f98e:f37 with SMTP id 5b1f17b1804b1-450d657fbf9mr38738295e9.21.1748628849112;
        Fri, 30 May 2025 11:14:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fa249esm24619045e9.13.2025.05.30.11.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 11:14:08 -0700 (PDT)
Message-Id: <d7b7a0e29ec0dc92e491401bc0dacfa15d4af2ad.1748628847.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1977.v2.git.git.1748628846.gitgitgadget@gmail.com>
References: <pull.1977.git.git.1748149783383.gitgitgadget@gmail.com>
	<pull.1977.v2.git.git.1748628846.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 30 May 2025 18:14:05 +0000
Subject: [PATCH v2 1/2] pack-bitmap: remove checks before bitmap_free
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In pack-bitmap.c:find_boundary_objects, we build a roots_bitmap and
cascade it to cb.base. Only when cascade failed, roots_bitmap is
freed otherwise it leaks. Since cascade_pseudo_merges_1() only use
roots_bitmap as a mutable reference not takes roots_bitmap's ownership
we'd better remove `if(cascade_pseudo_merges_1)` and frees roots_bitmap
anyway.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 pack-bitmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index ac6d62b980c5..8727f316de92 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1363,8 +1363,8 @@ static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
 			bitmap_set(roots_bitmap, pos);
 		}
 
-		if (!cascade_pseudo_merges_1(bitmap_git, cb.base, roots_bitmap))
-			bitmap_free(roots_bitmap);
+		cascade_pseudo_merges_1(bitmap_git, cb.base, roots_bitmap);
+		bitmap_free(roots_bitmap);
 	}
 
 	/*
-- 
gitgitgadget

