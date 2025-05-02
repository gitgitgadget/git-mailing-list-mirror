Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC7E227563
	for <git@vger.kernel.org>; Fri,  2 May 2025 23:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746228861; cv=none; b=X1UTCLCUYAqbSrtxuxOl1vd0bhhF8vtu23eoJd955ShqUijKbW/xEcYo9nC4GZw7y+tCPLQTn59K5RQLV9MkB8ijSCtmG4jAKp/I+JEVhF7REX3JoGJ/ED3csFg1cXYV5jNU+rA6Tg1QAUdfBvdQyp3BaMV5QxAT6zy2HX4Pu+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746228861; c=relaxed/simple;
	bh=u1cuoUzn5HY+o2Zlx6iLeZE6xym0FhJJQWsWOHg4SEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c4Phu0bC6vVZ9sx+g5LAZ/b6iTJBTgJQPdRattK1+w1+C4lwocF8kl0ldgMg+7/p2p8L3aARI/WnO4H0UbfECMfyAi5lNC28abAyRIoBdBXNt06UDb36pkHHyJX1SYOtSFIzsgvue32T90mwPuuuHfn/BGE8gV8NAh8PID6SwKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsLK3Eb/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsLK3Eb/"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-73c17c770a7so3879365b3a.2
        for <git@vger.kernel.org>; Fri, 02 May 2025 16:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746228858; x=1746833658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=31shhJNhex/BW+tdLweDTQUW2WgGIZ+rt2Vtbz4pIUM=;
        b=LsLK3Eb/kWDmFH74ZcaMliLhFYGPjuua4NScUUIteOuyJ7sFhmHItLeUSYN/pp//7S
         67y1Vt9sYZAp+Wx0bUx/IRyOZVQFYGcRM/U12UmaURKTbTD1DZHd0Rb3wKCSwg7nLE1x
         OMm/Nu8vpQ8jMbwL6uKohOXL70nalITUOYrMj/I/7mqZAhWyh2el67Qcp2s/Tiq7wbiK
         WbCRyELFgFGbOE0U5z8UfpbxsQLJ0jVY8DXnDNEqS69Fkdk05h4uZeT90DdHZLp/DqrZ
         GL8APgz6ZKI+QLJ1E/puLOslZyeiBd56B9urI5HqIGd4a0QR8EdlG1omPTTUPhWj6yPl
         BM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746228858; x=1746833658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31shhJNhex/BW+tdLweDTQUW2WgGIZ+rt2Vtbz4pIUM=;
        b=IYM68VLGxf4fH7Y6AuoDh0Swnlc4NNQh0thZL/p3sN6ypwdYFMYKOaTjr0uFkIXOun
         t9o7AFk0Ur5IyUinp13LPejG2ktVenU+hwsEV2ffFka71qouo+L1Uzcub6Hav+Vz3bo/
         cdTol7kdcd+EX8IP+9iVQ53U9w2x2n892993YyeaW7SkqszV4k8lzwGmQ4VmDh0e8eBR
         MqQaBEnYMsBHZBkHnprFeRgmX9TxInku22gfzmXEVdI+MKzebGiNm3MQgCz5BaPNIX0C
         FSDnelgfVCsCBavYSwQvdC98mUp0jJfxCInnQwBErcBLCkxjMAM3I5OAXLwg7lOfN34i
         I3Ww==
X-Gm-Message-State: AOJu0Yxu/lXYEDWfUvw0hjW0HAsnlawuBR4MvKZ4s2yUIvBvBpgePiXQ
	9dkyrbBd9RkphvUgkzM2v+ajC8qSs6MrcudnK/DWtb3En9mD3FhlZG5t4wtE
X-Gm-Gg: ASbGnct7hPoaTSPHEsDMY+MuzsGdGuqe5lKifGwQ+OzBndo5B91m/z0X8XshZoaJ57g
	8QVHfbCZb8M21auVlq0v0FFjBGpQa7gTCD+hDp/xJizxN5V57xCdOjaobR8h/V6cKP5ResPHbwh
	5kVjopOabnPlqacBK2PbDz2gWiz9T6N8OMwE+keRkRCMV4KvtkapxYnGhT3ld3/eC9azf65Lgy7
	wgEhWMM9LCMK3fM9ld5spSRA/e0dTHSVCStTfxWVyGsRusX+JpCMTjUfilkiK2DsNP3t1uU8d87
	j7BSvA5Jj6kpajHiJ8XazgNg
X-Google-Smtp-Source: AGHT+IGLIQ24kxhd1TWFwdpEHI8HqqkaiVu0HNpbmMz5vgQ5t1fjr9e7dHhESXMFoDnVwduuiBMIyA==
X-Received: by 2002:a05:6a00:448c:b0:736:592e:795f with SMTP id d2e1a72fcca58-74058a20d67mr6187808b3a.9.1746228858476;
        Fri, 02 May 2025 16:34:18 -0700 (PDT)
Received: from fedora.. ([2601:646:8081:3770::4bd0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058dbbe30sm2273738b3a.62.2025.05.02.16.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 16:34:18 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: git@vger.kernel.org
Cc: shejialuo@gmail.com,
	Collin Funk <collin.funk1@gmail.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] wrapper: Fix a errno discrepancy on NetBSD.
Date: Fri,  2 May 2025 16:33:32 -0700
Message-ID: <20250502233403.289761-1-collin.funk1@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As documented on NetBSD's man page, open with the O_NOFOLLOW flag and a
symlink returns -1 and sets errno to EFTYPE which differs from POSIX.
This patch fixes the following test failure:

$ sh t0602-reffiles-fsck.sh --verbose
--- expect	2025-05-02 23:05:23.920890147 +0000
+++ err	2025-05-02 23:05:23.916794959 +0000
@@ -1 +1 @@
-error: packed-refs: badRefFiletype: not a regular file but a symlink
+error: unable to open '.git/packed-refs': Inappropriate file type or format
not ok 12 - the filetype of packed-refs should be checked

This portability issue was introduced in Commit
cfea2f2da8 (packed-backend: check whether the "packed-refs" is regular file, 2025-02-28)

Signed-off-by: Collin Funk <collin.funk1@gmail.com>
---
 wrapper.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/wrapper.c b/wrapper.c
index 3c79778055..4d448d7c57 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -737,7 +737,19 @@ int is_empty_or_missing_file(const char *filename)
 int open_nofollow(const char *path, int flags)
 {
 #ifdef O_NOFOLLOW
-	return open(path, flags | O_NOFOLLOW);
+	int ret = open(path, flags | O_NOFOLLOW);
+#ifdef __NetBSD__
+	/*
+	 * NetBSD sets errno to EFTYPE when path is a symlink. The only other
+	 * time this errno occurs when O_REGULAR is used. Since we don't use
+	 * it anywhere we can avoid an lstat here.
+	 */
+	if (ret < 0 && errno == EFTYPE) {
+		errno = ELOOP;
+		return -1;
+	}
+#endif
+	return ret;
 #else
 	struct stat st;
 	if (lstat(path, &st) < 0)
-- 
2.49.0

