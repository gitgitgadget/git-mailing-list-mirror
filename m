Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356132;
	b=o96cmMzf36GpchumOyxddlQgQRSVgh8Dro01ZWbWLPMwwh944yqnur8C3obWTA0pJGCr
	 NlbCWLaIIWSG5sFgMDegOWF2u4irSAYqv+NzHNYgtRu93K5iN8FCY7zNO8pf41/W4jdTY
	 FiDvg0pGOqAoBDQ/qkayUnfMvehRH6uOJ5STYbYiipXo7BCSueWX7TkZJZmWu2DjKIuHi
	 m7H4yRjCHELp7RGLJ8he/KSDivSKjolkEqcUiNwNpTXK2csMIzzfmgxENrMlyHWANpCXq
	 n9bSHsIYDyRQRzmgq4umxIqZnVgkAIimSicnexYJiggkjTq+mRX40z+3LqG3KKTFbEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2c9dLLipDv7lpOocoSZT6FsRbBQxVRo27HeLtX2INTg=;
	b=Nx6s1w01QEuNhML+uUu7lSXEb8mynALb8XO4Xk/vFZaRMASdp0eabcnprVrTOpWtX5NJ
	 SwoRjx4oojN9Z/bkZS6dlOhn3uRVs26ZVWW48w513HiaOQi9FVfD0CRXkjK3cJ7964Ojz
	 2JxAPEb5CAApS6/sbnnu16/GuilJ8pHHtcdf53nqV9BQhcITUdJShpi2ujt/cUBTYfvEu
	 XTXir8ZMIewH9RqFF2hdKnsBt6J4CodoVnwdxr683F5SdNHNy3mPU7qnTCMwkwVY69vup
	 i7nilE/V3LkXoE1JCJkVwnhvlPFA8uQlQRJbCB7I9dzXcr2eYd6Xs/DgasSNW6KRw8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a1aP1kZh;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1523060A6F5B
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1523060A6F5B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a1aP1kZh
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso380565f8f.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 03:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793356130; x=1793960930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2c9dLLipDv7lpOocoSZT6FsRbBQxVRo27HeLtX2INTg=;
        b=a1aP1kZhStC7EjF0zvWgf+GpVlahJ9r2ou1WuNKy13ZlBtsJigxX03WGZ1Vnhyseeg
         UNHHDFjFUho90AFAEuep2YmXOTciJ1sL2cd5SiyG8Vkx6DX2SN12oD7QT2BrxKdoF8m3
         c9zskjupC4ANhid3Vi6mWquP8tWcehkT2AiuVXptbEQND/0SWBhPm0kpI6VUTPnFeuwe
         8OSxMAGl8/sMbBXI6IFhGTvdRY8QsCUAkDLWAnvtn0lrJtWsMmU5Nw5n/48N00Z7t2eW
         0h+r2WQTTYjZ9+TgBSgjdENwVaTS+zUKEKReS9FhqGwL6f41TM8ngAXgpaHCamRzxGdl
         mnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793356130; x=1793960930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2c9dLLipDv7lpOocoSZT6FsRbBQxVRo27HeLtX2INTg=;
        b=NFGolNv9fz6zFcYwyEIEsoJPY8UbF5iRrlenN53G9P3SCWfCZ4hKulomk15LGVVI6y
         fhD3h0FceFhKdGJ2wvmOHdpKtgtdqSY9MHaKCqApjMq8oQ0cJy/LSl0DrjTtu1S9VBsn
         o8sU+JpS/lOXTIyC3UsHBJBWH9WeNNm0F4Ihv4iPUHbXWjG2U7g6tQWAnK5pdGi/i7c8
         Gs+ZN+JgZ17F2v4d6dXbF3bbe+gubveM6B5GgOxILl4NAkFZWsXmISHJ9oAAnLkFYTW0
         z3I9Cwh6tVpDBoEHnhMXcsncuhMYvejr+IG8ANeEBWwyPkJq2JG67o+Fp7Lj+f/FZyjq
         O59Q==
X-Gm-Message-State: AFq9FYLcGA0TQ4b82L9IfdQJZTADL0uDEqsm8CyvTW6OkjBgU/TnkBWY
	T85a0BtU1qXhaRUsbAoCd4QLoWYyBiHc96skjpqhSy4Z6RnyBBcaUvrA17f/pA==
X-Gm-Gg: AYBFou3bXcRBM1xYvuI3SoemwkrhybOeQZL2ML3orIYvV38Y+s89Uj8nNDz1FYcC1sa
	diD5nU4RbG6+TJYlkFEst/qvj3Q6kaeogV5m3KXQNyJSI3P5Wtz5VSSpTY+T3xEUeP4bwoZj6pO
	3yvwBQyjaQNxnRKlakk+kVDNSLmuH0S8CzmbBQWR5qanoCP4xdnl0OEwcHqYffNok4zYwnVuapa
	9keLz4fR6fyOl+6a367EJoc+xJ0MnpPw8uMnEzPbr0YTeXb/iqYVOrLbrsj7EYD2tBFARAUniCX
	E/QqbQIfY4LvJPndZOdyvPtzQ8zK8dprPBsV5ZBG8/wBBy4fQp1kjShVYW56CGXJOMmHV2RGTOw
	LL3KG03whkZShzbIfPOZfGXWLckyQSdMxsymSE90s2/bAVHbsLMtVMzJXg40JiJNxRiTPF5uw8i
	7IeBYlN5zNtYVTd/M5RG22VGd3jMF/St6NRJyZPi3dxlbFrJbXiOIntrkmt5ozDiVuWb0ZahCjD
	cm3PwXrf50OQBs1TzK+Nntm3ZqvVrqST5JWBp3DancTJROVp9TchWgPZLM0Rfb9F9bEwZCEUoA8
	6AjTs7uAkrkYXAhzRlWESCxc4bqnHmA6tVja4UDPCPCq/deDug==
X-Received: by 2002:a5d:5d05:0:b0:48e:38e:3102 with SMTP id ffacd0b85a97d-48e6e4f692cmr4566425f8f.29.1793356130237;
        Fri, 30 Oct 2026 03:28:50 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([205.147.30.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b964desm2449445f8f.46.2026.10.30.03.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:28:49 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/6] notes: avoid truncating the size of concatenated notes
Date: Fri, 30 Oct 2026 11:28:38 +0100
Message-ID: <21f5a4e009155e36865f6b01d59a00b644669e41.1793355390.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793355390.git.gitter.spiros@gmail.com>
References: <cover.1793355390.git.gitter.spiros@gmail.com>
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
combined buffer in an "unsigned long". On platforms where that type is
32 bits wide, like Windows, two notes adding up to 4GiB or more give a
small buf_len: we allocate that many bytes and then memcpy() the full
contents of both notes into the buffer, writing far past its end.

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

