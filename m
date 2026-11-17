Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794915556;
	b=4iO8kqtc4W7lbxOxSre8LCA8QKpVrxCzSIXsFD+2zAGS0hbigRIu93Zi3aq8D6mFMPsk
	 es0PX7429reErVCf7TC0Cwag8D582gSX9zguaGJ7UYuJzEK0Yy8/V8OzK/iGDjjU/0t4Z
	 LkAZ5a1VhU1aS9w4mSY2iwtjofeToBpD18AHCP8pQBLp4WeaCcCQo5uBwpsNpBUu5DmIy
	 6qb5jF8fonutBq+5HBNm1a6cX13Fy/vMPI+4QZi57d1ICS74qofIiwRhcOZn2ZGUlm4K5
	 1pbffGQSNhtlNq0dEjLKpY4RqabuSS48q0dQl+/l6IENuXceCz7B5Wom36cWL50cQHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794915556;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SzfWBWzcm785zFUWezBCar5oYoXQUPvBWIPl0sKz3kU=;
	b=TdONtc1tku8IIqkiPbYI1aD1J27yU60B+qBCRMf7EQiPsLOZKxTtIetmmf2QAuhA+YrB
	 lUo6Q1Z5KliM/LAIU5OF+s3B0qPwgTG1PZT3CiRzNP2wJPvxB3LECDGLYgU3aQwfgFDje
	 srrgbD9vOfG3xnnA+6Q44SZHofVCn1j7xaUEx6+NTMgd+/4UqHUP7/4QafPeAzZnW5rnA
	 dGZpzM/4ZF2GbPDCtFEYPp+6NFA6BCM9ycbhgik3fKtQqygFUBloMBPsQDkguh13735zE
	 E9BxZclVVV2tE1gyfu2pecrs33IbwL71qDsPN5ZuZ7a+rWPBwjl4KRkadSWrvn8WmeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=grCjhthZ;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A01E606A32C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 11:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A01E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=grCjhthZ
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so35137295e9.0
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 03:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794915554; x=1795520354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SzfWBWzcm785zFUWezBCar5oYoXQUPvBWIPl0sKz3kU=;
        b=grCjhthZ5Az2fG4j128xSt8vCRlvbND7++UCpcqN5rdz/gEhVHmzKV/YilGi1JPX9z
         Ke+byyvwYsM6sjmd1WAEOWJBAJVx9aJ3xEGZfc+MIrFqf+lfCbJII5SIaODtbemKCMFk
         4ynWiFKdqel9NUwyR82GnUl5cERmFuFxNftfMzmB96ISYk9W+12y3xXgBSm1TVT3Xii+
         LtZY1BBMv9Lu2TN1XxQjOOMk2CQyI4S+5DgFS5OxfG+7GBwkI8cgQU5ppDvQUlDGxdeb
         nuBGAeWYrVAQ5RHDngM6ucsQ8hY64KUNl1iS+GIJGK0hLoWVFwMfYbh2L1KPXaAltbCl
         nZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794915554; x=1795520354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SzfWBWzcm785zFUWezBCar5oYoXQUPvBWIPl0sKz3kU=;
        b=cDGU2yrQGAjkTg2JXmpDt4LSLQhoIZ6KjTpWyKaVjSHXRMzqYiUbzvONujAu9CwNwW
         udt2BZ51/7puBpPrlUPUDC4E949zSIVS2N+ngtFIo2GOSkkbRvm4fgtSLYZ6jZMU4sRw
         Bm8fkRQmzHp0mVSe/WTSBqho8T1csgEXpqQgii3uT2JZpnxFIgMDQOsqXvNTmF38Nrcc
         j9/8NDD7kb42SXcRRg3NGjMQps77mESBqfsZuu3wvneGQqwwpjYfoJ2CUMglisq2sUZi
         DyCnqGgXe9BSoPqMsyGSzGi2/Rbnbj528IxkqSJntmO2qVz2Ow8ZDBPT0evvpjWFcZV8
         hvSQ==
X-Gm-Message-State: APuU4Z/Sxvoc5nxJ7AP66yjpnQqeKFByUPNt+gm7+/zPc5j6S5HsU7v+
	CR6V/qJ6zmqMsxK8+BYDXE2RpLKRaRRGN33G4Is97vFtP5ew9nmC6fc+9n24SA==
X-Gm-Gg: AYBFou302gsBl+/2yL/uEqJLKBrmM2ZVbn2gAXPzZ6VXRWPIlXgCGv1892tGszAAkb4
	IBRGxZ9L59n7IfUGz8eQ5XadzxyJuJjxbRaraiRjQNf+gJzKJJHiO2CyELsrbKrM0y1WXp+2TWF
	mDiAcrioyhgNqNsiLWhWe3pMQW7gByKKlxa9eW0oAYRS4h0OjZ84fnh3qf2nGkePL4W1ymBcZIl
	71UrqzM4XOQYMNHFI2AfHX488MG9p6/BTiDorlJW1XkwxG1Doxc02t9r8N146bEb7DxBoHq8aFG
	0JtXWilHcBkk39vk0vsYI0i5/Rmlds0Y6SDah8K25ZQ8+F5ck/cuYtmI+FyUmjxbQ6GFyFgr35M
	M7KQDEBuJSSaUqyhqTJO7dRakIdnsGEu9Nn7//diYoI4OG9R0gzKauBiHazEeOo6kRtCFF6GoFB
	0/eR8pkXn+0EGlv4F88pTviSxwprFKvXZbwFxt8EfZ36hzM3FAm9i/0UxMDK7Om/ApXgxefs/ZA
	JzCiLQD/9TEh8wQFhuSJbzpHSvchuRX4stRt7Nh9efYyFxK0cc29fEC0VkiVQUnc1JauJFQTrdc
	HPOxZCzfABzsgtFT1IteuaRjTBRgTbqTM4A9c8bsiqAM9z22SEdsL6yigwqUDe7JZokQvs7vDLU
	TCZ3ewjSf6A==
X-Received: by 2002:a05:600c:5250:b0:4bb:60da:56af with SMTP id 5b1f17b1804b1-4bb60da5884mr209846525e9.25.1794915553634;
        Tue, 17 Nov 2026 03:39:13 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78420edasm93555925e9.9.2026.11.17.03.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 03:39:13 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 5/5] notes: avoid truncating the size of concatenated notes
Date: Tue, 17 Nov 2026 12:38:58 +0100
Message-ID: <04f320d1de82902c174ff300426815125e1054c9.1794914210.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794914210.git.gitter.spiros@gmail.com>
References: <cover.1793355390.git.gitter.spiros@gmail.com> <cover.1794914210.git.gitter.spiros@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

combine_notes_concatenate() reads both notes with odb_read_object(),
which returns their sizes as size_t, but computes the size of the
combined buffer in an "unsigned long". On 64-bit Windows, where "long"
has 32 bits while size_t has 64, two notes adding up to 4GiB or more
give a small buf_len: we allocate that many bytes and then memcpy()
the full contents of both notes into the buffer, writing far past its
end.

The notes can come from a fetched notes ref. Besides notes merges with
the "union" strategy and notes.rewriteMode=concatenate (the default),
the function is also used when loading a notes tree that contains more
than one note for the same object, e.g. at different fanout levels, so
merely displaying such notes is enough to trigger it.

Compute the size as a size_t with st_add3(), and go through
cast_size_t_to_ulong() when passing it to odb_write_object(), whose
length parameter is still an "unsigned long". That makes us die on such
platforms instead of writing a truncated blob, until the write API
learns about size_t, too.

No test, as triggering this needs a platform with a 32-bit "long" and
notes larger than 4GiB.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 notes.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/notes.c b/notes.c
index ec9c2cb150..05da28b8d4 100644
--- a/notes.c
+++ b/notes.c
@@ -811,8 +811,7 @@ int combine_notes_concatenate(struct object_id *cur_oid,
 			      const struct object_id *new_oid)
 {
 	char *cur_msg = NULL, *new_msg = NULL, *buf;
-	unsigned long buf_len;
-	size_t cur_len, new_len;
+	size_t cur_len, new_len, buf_len;
 	enum object_type cur_type, new_type;
 	int ret;
 
@@ -839,7 +838,7 @@ int combine_notes_concatenate(struct object_id *cur_oid,
 		cur_len--;
 
 	/* concatenate cur_msg and new_msg into buf */
-	buf_len = cur_len + 2 + new_len;
+	buf_len = st_add3(cur_len, 2, new_len);
 	buf = (char *) xmalloc(buf_len);
 	memcpy(buf, cur_msg, cur_len);
 	buf[cur_len] = '\n';
@@ -850,7 +849,7 @@ int combine_notes_concatenate(struct object_id *cur_oid,
 
 	/* create a new blob object from buf */
 	ret = odb_write_object(the_repository->objects, buf,
-			       buf_len, OBJ_BLOB, cur_oid);
+			       cast_size_t_to_ulong(buf_len), OBJ_BLOB, cur_oid);
 	free(buf);
 	return ret;
 }
-- 
2.53.0

