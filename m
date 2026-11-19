Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795069333;
	b=oivEN6ZQJj+Vtjpc+hh54XkGMFxWgn+ZtXfFJ1QBOxhzU0G8QxGnWUl1jQN8C7D8hqjh
	 xTjlJHDro+UpOP7VBrpbB02eECJ8T1FKYUd6tTidevzH6N6jakU4EICVoN61uFFrxPnwv
	 L/1REVmKfDmoSJCYcRpNwYdgOSqm/MyyGf2fzvsEtpSNhalj92n2XzWuMrcxhpuNjpzo3
	 fskrehNUxCyOiPpfthed2THrqOfdi82jr8XbK5+OyMwhbsCl+rQvfeZ9TEDm6h+SXHys1
	 hN1iK80rKlDL0+PkKt1h+hgre8S4lyBcZ9ap3/WMbhyNOB+Jj2izhJBaaUlAxQEmCgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SzfWBWzcm785zFUWezBCar5oYoXQUPvBWIPl0sKz3kU=;
	b=NFPE88sQ197kQV6agqcDSUQb9LtmXVrbe0V3eM0CQ6pexecaRkOuBCgi0707NWKy1+jP
	 pDA1M+SfMIMxzZLW23ughXxkrlLARvlS6I+6DrTXHg6lq6qKKPiJxJjUzmeO9mq02mQLu
	 u4gqmjGpGdMvJ6PYN/X6mXau2OsXEquSuL5NjutMN89zGC0KjGg651l5Arn5B8AL1iJJc
	 0jgcDHyMia2SlHSv75fHaXXyhfcYEMZOYQfbCCcRso4y3ypsn/a3K7titCQUOQPQ0vVYp
	 npjQXO7YQizDDK+3SmAU/122Q5U5mJDujUTaWH6E2xOSJ+nK/d8+Qlzi7VFtg4DMhtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qdx9fyi3;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF2860A2617
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FF2860A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qdx9fyi3
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso20665965e9.3
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 22:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795069331; x=1795674131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SzfWBWzcm785zFUWezBCar5oYoXQUPvBWIPl0sKz3kU=;
        b=Qdx9fyi38JNgCDQFsA63ESiBJ17jTO+nlbtiyIrYUawtZ2cSd36ktSmNzYZX0uJlfS
         2LaOC3LoIlKedGi5677hezt6xTaUAwLi6igMuJp5+j93/oEuXNsSqBA2Gy6ifgSZNbKI
         IYcYibGAFljIblZRZTfXNzFGDoEuRwsgqRujrA4Mvks52R6m1bZkSzclrdc4Nu8rXgn/
         O8dxdNf/0aQdPFeGYrevrqKB5PdR+OBPhy88iMSf7dYeNw3icdIWS3CZ7hJ9KgTy/FVd
         v81Bd0mFmhoBrdzf2fcx0OtlWxfkwNwGN2Zna4dXPXI3noQVoMvvFoZhYPSyXf+Mlf+C
         QrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795069331; x=1795674131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SzfWBWzcm785zFUWezBCar5oYoXQUPvBWIPl0sKz3kU=;
        b=2xmz4Fo0t6l1Wvu3KSJ1sDdTP3u7svWFeKJGzb53FwMeO4H46NpsXdN+OWu+T8P7up
         HWlv9NrQisTKrOdzmDvCdJTl0Mj8GGdYl1gjEEO9uFc/Zs2coio6seQ0NZJ/ZvO2p8X0
         /bdKB7Ht8kDOj6Znj8tPGWJQ1xv0RlBNPil/oSzsB/4wXPfQqVOYLMSwRJ473CP/bpb3
         I71yUrKtHZgvvlFpJ8VXnIlfmd21C3Q91cOe4fIFIPG3BcVogQIZROnNX5x8EJnU6+w6
         Mlw04Nj97e8aVFpneDZMrd0YDSPGnM4qqunlzWdnpWD7I4Mx9XSWtVrzD0TzEwyie2Oj
         2xww==
X-Gm-Message-State: APuU4Z93ip2XePclhldKtttH6U2mxeu3pP5URn3f6XEcxqYcGCRGjcdc
	4uNeQoivLPN4irqRxnun5F5GNdLO6k2eSnz5bTbh0cjOuWSw7P+UKKIdOik6uA==
X-Gm-Gg: AYBFou3Vadg78k9a2Yt/YGYhG8fZz+zGkfJqV7o4tA74Puz3sS8zXLvIV5xWRQAHiM9
	h3t9Av2wWzeH3mExb+q3JatCsvyhnbLuOjUFsvIL1/hvVyQDltMojvVnOWWYS0eP5uwvMM81rSE
	fIxWRTkISPyiVJU0gCw6svnhYcg3/pjMqkcyNvHdt7EFgJtG6I8+jlYifg5X4UKZt6qhpN/r036
	Rp6e7YWeUCbgm0fBeeURMZPZOZHILAISlv+VXvJvemoGMABJxZRCElBLb3rkzM7cjUvGW3JRfgq
	1iedh5e1kdTdGMsFZfKAzUkug6mDybvRWYULkUedqrNIuIMnRzrPuGgK07jYxBaw8TrLk0z140w
	vy9kt94Sp5ZUoSpukCpWsrOZ1Dc9exFOnDgTlePWb2oqi5ggnfXnzxvvFA7EqeDojzXFPuwo0cs
	CpA8sgoZH/Jn1HaPcOGVavFtwWd2xnuK84q8efxsvb3AN6PyIyzKJG8NN+1l2PVowYK+A+bXvqS
	HKLgV/k3P3DR97brC/q8z3K5p1UtxilrURriTVRzFLPIJle6M8ymGw3aypBRP9Wx9pb01wGuE8k
	PvPVsmpV+lkJh/qLmlctfC62jP6K2DKnPzaOnMwwqf3dh9A2jS3ZIY/HQ5hFL4XXk0TLOyntQQv
	xhoG+ejWn
X-Received: by 2002:a05:600c:8709:b0:4a3:5a7b:6002 with SMTP id 5b1f17b1804b1-4bb7da57419mr96360105e9.28.1795069331421;
        Wed, 18 Nov 2026 22:22:11 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c406sm8508413f8f.14.2026.11.18.22.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 22:22:10 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 5/5] notes: avoid truncating the size of concatenated notes
Date: Thu, 19 Nov 2026 07:21:50 +0100
Message-ID: <d0cc63a8ed4f0c11544e6bc01cbd8e6176a8c360.1795069177.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1795069177.git.gitter.spiros@gmail.com>
References: <cover.1794914210.git.gitter.spiros@gmail.com> <cover.1795069177.git.gitter.spiros@gmail.com>
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

