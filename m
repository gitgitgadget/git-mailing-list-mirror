Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7BC265607
	for <git@vger.kernel.org>; Mon, 21 Apr 2025 12:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745239159; cv=none; b=tXWPTlpohoeUlb395FyWCY+Vpxf2iXfHy5mOqOx8OvUhvM2kw97trquKzPgqhU+NNavnqB562REHs++q92PygdUrV0/3P1AsHx8keUoG3H6L8pBJzAbQSG4JrNyIholOppZdCrENFazOgv3gyOOV/BeA9Z7z+L9LqzY87C+Bydw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745239159; c=relaxed/simple;
	bh=RDuSSK10eS4ROmTfNOi/6eiwQtCL8ghmztsLIRbv0RE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=l4YlBlmeqaYGLqx6qJb4j82Mhbv7oR7pRskgBt7QuY+myzedjCvXabqaQNO77CM+c3ZjE8x5cAszZB3o3NzZEGdBmkRFfO/gTbQqZqo4h+VyAejowFOMY5+ZtCvl3MVANXXKHHZ3DWjd48yj/EQ5pHkYETBiXyy11s8qeREA/l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpW7OrpO; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpW7OrpO"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so27140995e9.1
        for <git@vger.kernel.org>; Mon, 21 Apr 2025 05:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745239154; x=1745843954; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w13xKUUHfNMjLR4FXwCgez00vnXzKwK1LeizvTw1aVg=;
        b=VpW7OrpOkHjyBbLmX8JajGaiqjyZsWyD7C3U45yJfegWf0/96I1o6BWGZFXq/Bf4fq
         buFY/cUvvQC0BokjWl0oCa5Nv7D86qZIO2RSQIZV1f6xQLWf85h/pWliZFFh4+x5oxPE
         G1XkhXKZ4fBXbM6n6SEpAEHD2H91Gpn5m5YZCoI6+WfoPEBGqoHMsbdWwLpGLaFIDdcT
         Zxrcwt/JzgdQhWQq5jEvwUYmB1/xjj2M9zFaeSDB6YHxtrf4yNLgurNFd9J0BmWKv05A
         q++NSQImiSPciWbOQxBH50uc8FKyupzaZ30B7O+McUODgiKhZAaD7+vjnVrJBGbSlRKd
         Dchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745239154; x=1745843954;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w13xKUUHfNMjLR4FXwCgez00vnXzKwK1LeizvTw1aVg=;
        b=ulvbkA+qm8D0jgnj2pPlkVZ5DI4riG04Oaz2dzpgW3XA66hyOYeYp7i5CueUpqZkPR
         oRvt9psRgns3XSHFXcPncL6M7H5bQJ+5hYnHArwbJlhdVlVTe5kD44pBWCd2nujLrdxK
         KyAsKYtX+28S4PtbRqnhxfV4WuQ3nmwUZCFg2XCBOpntbGFN4RFj2b6PBG3U17aHs5Pl
         Sm5sOs1la+GhqfqYHj6rTbFQpw+/lilYM/ZWFF57NoRB6ziSwSUdK8xzvONjBdqRR1lG
         eOgzyAHMLikyZXYQHMAteWkLCSzGTf1Z0SjGFdvCbOvyB7lz6DwD3fsSPHu0mRVy5qgp
         n4hw==
X-Gm-Message-State: AOJu0YwLVjyixiY/p4rlw7RwLOe93gyfMmE9qRo9eNV0DI/6bXpYo7vT
	9bMy6Fbj+kqENYi+S5IRddgChsyQJUDXkzONNyydYXtwwi+auRD9yf02Bg==
X-Gm-Gg: ASbGncu/gGflKFssByGLqziQSS6BA/7viHwb/TPYMsiebXpUSk+T2KoM8IYvG8qwXxI
	YP3blA3t9nQfPi/vG73pjzGNrObITjEeNce55SI5U38QNDCr3hMT+0ARHk1zP/iRuwBRsIADz2p
	PJac+s3QbRwzogwK9L/XIJMmtBth7cd9JkVHtX/9/83El3ZiQwGZ/3KvWX37GsX6tyx56FNTyKK
	guNgKV2Vstz8lyBCxkMy3JsDmSN2yS7npLYUOlhMu7aZA3JtqzD6GDQeTuDKWF2D+0JO8PSUkCe
	NP6jj3NqaU+Nr9vwgYyW+bd1hgzHkKCMjA1ketjO8Q==
X-Google-Smtp-Source: AGHT+IH+y88FhPFSU12MGdNazKt36I7RPYwB3ygtTe2Odo6Apo20fWykRA0py8dieMNjxcOI8dXsXw==
X-Received: by 2002:a05:600c:4e52:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-4406b1f1cbamr103015535e9.3.1745239154416;
        Mon, 21 Apr 2025 05:39:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5d6cd2sm131538165e9.33.2025.04.21.05.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 05:39:13 -0700 (PDT)
Message-Id: <6c2e17eca68b143eff7b33d195bc66a486471547.1745239150.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1904.git.1745239150.gitgitgadget@gmail.com>
References: <pull.1904.git.1745239150.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 21 Apr 2025 12:39:07 +0000
Subject: [PATCH 3/6] mingw: do not use nedmalloc on Windows/ARM64
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

It does not compile there, and seeing as nedmalloc has been pretty much
unmaintained since at least November 2017, as per
https://github.com/ned14/nedmalloc/issues/20#issuecomment-343432314,
there is also no hope that any fixes will materialize there.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index 1e5d89f1aa4..6222d2c5a48 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -742,7 +742,9 @@ ifeq ($(uname_S),MINGW)
 	HAVE_LIBCHARSET_H = YesPlease
 	USE_GETTEXT_SCHEME = fallthrough
 	USE_LIBPCRE = YesPlease
-	USE_NED_ALLOCATOR = YesPlease
+	ifneq (CLANGARM64,$(MSYSTEM))
+		USE_NED_ALLOCATOR = YesPlease
+	endif
         ifeq (/mingw64,$(subst 32,64,$(prefix)))
 		# Move system config into top-level /etc/
 		ETC_GITCONFIG = ../etc/gitconfig
-- 
gitgitgadget

