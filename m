Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A95726A1BB
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206081; cv=none; b=KtieLmUJ4l8rT8GVaGp5hVHOzo9qz0Vfz3yExR2JiECcgMSEQ27MiBjVR+5/+uYGy5acW/+0Wh5cc8Su3moXSeVkxPiYEdH+FnLVsf9NB1isQNjASF8sjD3cGzRQqAqEYojQPI+1OSqSTsNuaWyWxeZenGhxug3VuDi/Ofcs7sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206081; c=relaxed/simple;
	bh=IKggX0rcVYGNT64FnxpY4rn/lW2NyYQ7E9cT2eLph3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cj6+V0Ye/rrnlP0GrUaw8t9TUhNumVj/CSK4T8QiUlo8Tjm0PBiXEix0Zw7PgbQOETXgmrP0/OZLlXn1Zn0fLp3eCM0byKArvEPcpStMf0DISWbShPos7wFwmWSVXXT62vYIWD3v70LTPXPIPBKeMR8SjQCjmqXcusiOMDbZy1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkrg1ZhA; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkrg1ZhA"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso6126241a12.2
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 10:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753206079; x=1753810879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+Xq+V/jT7NwkcVbB2m8Pukn8M0SIRlFJL/dW6sqFD4=;
        b=hkrg1ZhAs/aq+i3X6iRvcEbxUsZCA0B3z6qMTOBY/vFRGPHBrLusohyHCOrx4CeUOU
         uI/0lpey3EU18XmEXTJHiUFQUU6hBqw/Gt9KwVEvjQUkCY86qemtXWtdJH/eAY6iJ8vY
         d2JlTpqByud3BcCQxKB2seT90Yg+vuGC/PCARzPANcJqtxsBUXPtsjhKsl2j2AFpWOVG
         1Ho9Ufd0hrjIKlp9Z3/7Fa4XXuC8BM/U3pNank9kPXaf/VjqSplWR+d3+823m8WQ+BB0
         fmZ0zaiqOKgWX8UZckIVapq3UXqKMt/bk0pffEX54lNNxpbV7hkny26tHb/EZjyxm87x
         W4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753206079; x=1753810879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+Xq+V/jT7NwkcVbB2m8Pukn8M0SIRlFJL/dW6sqFD4=;
        b=XRmJPb19GG+rLnwbSkhv/2Qe8EsOAX1KN6KWLbNgSxpOM0YldeRCCt2O7J3171HJyt
         Pq3zlI0yoC6TPaqjwpIf04FBAs0//aH+gacqIv7JeoIgmJYge2LIJwWSIvvNPYzjSnCu
         O8/iYF9J9u4pZcWM+fHNkjVS3fYJRSnFCjp2Nog0ApxEIRVXam7chPvz/EXwXKbd8DwA
         wRx3pakwOCI6qJqRI3FbSS6Ud/CSK4VNxwbsN1DFzs3R4X+Dt6Fqbii4Oo+1rH4hMFaw
         mq96NmnGC+J8HTfutMUf6a0ItrzGMDi37HW4XhRV7wl/77SaS4EvVoUE88bzXf3GQzUf
         x1Og==
X-Gm-Message-State: AOJu0Ywz0+XDowf/eGN35heCJ77a+JYZqPKyzlgs8VlJiQ9NY9hdf4cp
	Dyr7NUyy6MAhBnIPGGJipoNB/HE5V5LQ74ZcbRDEKnpuSlKB+2XOT2ghiZu3+Q==
X-Gm-Gg: ASbGncvZav8aAo8nK2CSQRXwi7Gff8N4HGpvQCgJi4fGR1TYWcViHzkmKsqHCy5/TAn
	om//esfqgE0IaNLzXZyh8ccQRVlMc6AXLvCRyWuIQpJet7lMOa34uwCHLhops1xQBt7v2sff4RC
	UQN11cjW+FjrJQ2BKy8P/kv4mQ96I4rhcXBe/dtJcIMt9XJxN3rNleotTgH3uCnniZLG/KIJhmC
	m1SvHoZDodAu7yK3/84h0kjIaL6b1aYX30yDunltl3sMyF5K5AzYs/BFXP/lqWuutqt5t/bvOkd
	oL3CgGnTfHYs/0ikqmFRjv74cfUu2iD6ZSScK3g4F0auLzouv+M5CHn8rlQZKkBWum07xlvAuLw
	EOBuuHrEAW+gKzwPJiFXREQPgkNEF/vhHgA==
X-Google-Smtp-Source: AGHT+IFZZ2kJ94HnOm35nGSVoNo+tlcM6WLPCJAj/u8YcuH/J1WaM/16QDVb5WX0gZ2oARWjX9whqA==
X-Received: by 2002:a17:90b:3cc3:b0:311:9e59:7aba with SMTP id 98e67ed59e1d1-31e506e576bmr241863a91.2.1753206079263;
        Tue, 22 Jul 2025 10:41:19 -0700 (PDT)
Received: from localhost.localdomain ([211.37.148.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e40f31bedsm932293a91.2.2025.07.22.10.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 10:41:18 -0700 (PDT)
From: Hoyoung Lee <lhywkd22@gmail.com>
To: git@vger.kernel.org
Cc: Hoyoung Lee <lhywkd22@gmail.com>
Subject: [PATCH v3 2/2] t/helper/test-delta: fix possible resource leak and ensure safe cleanup
Date: Tue, 22 Jul 2025 17:41:02 +0000
Message-Id: <20250722174102.1876197-3-lhywkd22@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722174102.1876197-1-lhywkd22@gmail.com>
References: <20250722174102.1876197-1-lhywkd22@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initialize `fd` to -1 and unify all `open()`-related `close()` calls
under a single cleanup label. This prevents undefined behavior when
`fd` is used without initialization in error paths.

The cleanup logic now safely avoids calling `close()` on invalid
descriptors and ensures consistent resource management.

Signed-off-by: Hoyoung Lee <lhywkd22@gmail.com>
---
 t/helper/test-delta.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index 6bc787a474..f5811e96ad 100644
--- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -17,7 +17,7 @@ static const char usage_str[] =
 
 int cmd__delta(int argc, const char **argv)
 {
-	int fd;
+	int fd = -1;
 	struct stat st;
 	void *from_buf = NULL, *data_buf = NULL, *out_buf = NULL;
 	unsigned long from_size, data_size, out_size;
@@ -31,13 +31,12 @@ int cmd__delta(int argc, const char **argv)
 	fd = open(argv[2], O_RDONLY);
 	if (fd < 0 || fstat(fd, &st)) {
 		perror(argv[2]);
-		return 1;
+		goto cleanup;
 	}
 	from_size = st.st_size;
 	from_buf = xmalloc(from_size);
 	if (read_in_full(fd, from_buf, from_size) < 0) {
 		perror(argv[2]);
-		close(fd);
 		goto cleanup;
 	}
 	close(fd);
@@ -51,7 +50,6 @@ int cmd__delta(int argc, const char **argv)
 	data_buf = xmalloc(data_size);
 	if (read_in_full(fd, data_buf, data_size) < 0) {
 		perror(argv[3]);
-		close(fd);
 		goto cleanup;
 	}
 	close(fd);
@@ -81,5 +79,8 @@ int cmd__delta(int argc, const char **argv)
 	free(data_buf);
 	free(out_buf);
 
+	if (fd >= 0)
+		close(fd);
+
 	return ret;
 }
-- 
2.34.1

