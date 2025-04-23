Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1E6265CD3
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 08:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745395317; cv=none; b=rXYn5Qq7ihkAIcJcIism1H5/RRax9T7U6xHcr+75aLCO5ImeypDpChcAV6gzXrYeAEu3P2aLrS1L8TEJbkky0WWxn4xbxZZpbyNq3Ns9KU1OwpsqdgsYx9zoFD6FPMYqEnxZ8Epp1ojSImMESJtjDvd+mROrhc8OycUhKx18VYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745395317; c=relaxed/simple;
	bh=RDuSSK10eS4ROmTfNOi/6eiwQtCL8ghmztsLIRbv0RE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=inpQSb1okoD1DDa9wnw0kG/4Tdx/zhLlcQMeNj79T8KGikvDD4/J305wt0Op4XdYiIeBha/Zdzg9Ti9uXwdCHbShIj0emDkAxKwlYyfnnqtFPJZUf5F6SttLV/cwZRy10j/VZ0o1eYAB3QlnJop/MGfU++PpVrBupGYnitvEelU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Veg43s5b; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Veg43s5b"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso42326105e9.1
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 01:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745395314; x=1746000114; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w13xKUUHfNMjLR4FXwCgez00vnXzKwK1LeizvTw1aVg=;
        b=Veg43s5bd+jqXjJ3YivH4jUXrPa7HbxIkIIK6WoY/2FnOBMG0gV8tZ0yOd4B3SycID
         Ll7cZf0huOzDxuzgpglI2KW/q+ICfgHVW7dNDcM4KMo6Tcd0GtmhbzLTO3cWG/PZx73y
         VYhGmterhugFlMTDu3ctlcpg/k/QtjA6D/3fdXQ7HrIK6OgPO/noK0GdOMflULt5UPQU
         ZkksrjV2L5vXw9DrAAiIt3qEvngTSNBqXxqOs+ny/goT4RhCX7NZOF9rz4DWkw0sxVO4
         prCWbiiJMKr+bTD/B5k4cJvb3fhexMUr2nuS55Fahvfj1oCsUuTUAvhduNOTo0FwiA4o
         9rDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745395314; x=1746000114;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w13xKUUHfNMjLR4FXwCgez00vnXzKwK1LeizvTw1aVg=;
        b=gvNi1L/jXwckSIO3BHYzhaazVp1+XnkSHgh1SqBMhbHqFfW+xyYRqkPZuch/Adlm/I
         hVp472DWBDFjowGoHozSvEoVi4DRGPr/0NFtaLGRb7qVjf5a0WFl3Au0sNth/soWgj7m
         Q1pMCIOyIlg2aSvgYSj/9IXN3vkOZXgGyC8EphAx+stVI4/f3VKbGoor5OPQPtghh9/e
         2a/G6eKhWDrOvsXTyBWfmOu0nTM2qtjM044r0mlthLQUS/uBf2ygALmwTC5oaR83Z4o6
         Sf776SFJOqtMo6pXxuT3n+Sz4mRDYo5JlxZ9A7CGGk1ugKfhFcxmtis6+Zv16hKZbv5M
         OQeQ==
X-Gm-Message-State: AOJu0YytW50rM2RbQo5j79cBU88casMti2ANI5aUGhzGml/LW6EYd5v4
	zBfeNVdYkHLaBeHHvx2ABkwuaP9ZmD8ajIuiOCqPYjorm8dEBzY+uM69sg==
X-Gm-Gg: ASbGncvP0EIPzjTSccUUJHYsMtIhuEGd1PhxZ4LZjutpTMpUxTxyG71st3gPTMdVKp3
	wTViW0oG7AYCb1zxEINI6X75/ymy3YV4zFeozMkfokz6KaDcQnRgHQv4jX5Gq8qWTUB2dmDS6r6
	Qup+9O77eMKMaKBF2SjHLUAh0oZE5KIgqqqrdzlwJ7/GiOvrH200z2swDofLsS7gQuqJy6ecKIY
	iVPmAJfHPKRR3910BABWx37ouoTle2aUljZz/pr75OHSbd0zFAhdIBsAlpto9VVgDCIcrqf5IfW
	3TU7H71046deMYDABBxvZ8ejdG7eUa6xRhoXv8rsoQ==
X-Google-Smtp-Source: AGHT+IEH55OhQDME29HGtEPNmmZ5VdyqoO9Sih8M37VRR8vfyTatlmq49QpzTRBKDckyNAu0C7FpTg==
X-Received: by 2002:a05:600c:1c07:b0:43c:e7a7:1e76 with SMTP id 5b1f17b1804b1-4406ab81962mr158729895e9.1.1745395313381;
        Wed, 23 Apr 2025 01:01:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa43bf20sm17602179f8f.48.2025.04.23.01.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 01:01:52 -0700 (PDT)
Message-Id: <6c2e17eca68b143eff7b33d195bc66a486471547.1745395308.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1904.v2.git.1745395308.gitgitgadget@gmail.com>
References: <pull.1904.git.1745239150.gitgitgadget@gmail.com>
	<pull.1904.v2.git.1745395308.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 23 Apr 2025 08:01:45 +0000
Subject: [PATCH v2 3/6] mingw: do not use nedmalloc on Windows/ARM64
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
    Johannes Schindelin <johannes.schindelin@gmx.de>,
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

