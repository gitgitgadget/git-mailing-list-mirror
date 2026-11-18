Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794985015;
	b=oEaY3nwV6DrP2ctmbbIjMzW5KqC2e7dEYqksbQt3efyl3SsewKC23skxavQO8UZFpHi/
	 ezpwyNEsbzL30q+omIN+zumxzL/lHRRL3jfdr15loL5PuXHbiIkM4v5HfSc3EV6fpMAHE
	 wMU0C5MkCUxslfS3t0KHHBcYdUF7RJ4KNx/l0CUztNJPcpELhUedVHwRHZ2NcRDj3N+D5
	 Cxx+PHU0a9Orq+ikFdB+y1wsqiNACFN82Ko5bmI723SMAoqLcp+wU0axPStm7ApuaAIyO
	 RfCJ7rbOTSJKYPdZs6vZUqCx+QFTqbEgKLNsPjpfqOU7AQyydO8ZPITLog2PJtcht7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794985015;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UpGof0JZlMrkI9fUI9n9OE6SWKutyfASsApiucENvV4=;
	b=fFDbzGZuzLo/OZ7ZQq/LvilMgq1fAK67Hug2waUP3PrvK5ncI4NwvZkJElPA3gCtJ1MB
	 lEEoLMTthYllQBYxTMqaYithIbaQIv20YQ39M3D13mmd6iY7NxtVN9Qli8vWDGGTakW/Z
	 rmdEHHFOJqhi/gRWrVj10IFov/JnsbLtjD/YUIvXnEohYk7OMvLrFnCAVkSIlTNYrEzo6
	 HclAy30MGsg41QieoFMXEkica5279f+PUrKt5WipZzDCeoUfN1tkcDmwp/yAG807uIVVq
	 gfC2sIVwjn+Ea6jevoL92uT3KapRBJCTa917HO+Le5xFimC/THXI2tFWL1dRyNp4kCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BekmXOXs;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ADA606A331
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 06:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0ADA606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BekmXOXs
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb55cda775so2670295e9.0
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 22:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794985013; x=1795589813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UpGof0JZlMrkI9fUI9n9OE6SWKutyfASsApiucENvV4=;
        b=BekmXOXsV6TO0x/CVstL6xzVSO1grEONPkNjb9gXrXzUeYDdBFVnvCJQ1z/Ndj9RXJ
         ddyL+DL8qPuhO1l6jC4v4G6eTXRJba8x6RFZip7i9lAJc1kq9krMZpKi4EmZrOVmrdRs
         asCJ51KH9mvtxU9r8HTu3YsQKzrEx9ZxO3aHAsFzhpytLC3Veq2SmBjp4NMikuNJjVpJ
         Xio6c2pwZZMHYgVBZND+lAYvItkxZarf6p8Q+lDxKIR7RcRws11Fx5kBC9k0EmhEjxh3
         t5jUVAquJMaN6p08ypMJHU0avYERVCdoyoqnNQl/lYAxFmx8/uWoOfMbuOhzLiN89Rlr
         AKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794985013; x=1795589813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UpGof0JZlMrkI9fUI9n9OE6SWKutyfASsApiucENvV4=;
        b=QkDutfKM7Bbr0G8hrFuzT8qK5LYVxKcvpMukwwsNud/Oo/s4ZYkTfXbIlBTSUFYssf
         IMrEUi6fPJTAxhN8akZirL24iF6oUMEIw+HE9TrJ9SuZm4zI0LAphyBHPPJbNjz5VKRY
         5sVcly7qKsmWf9NVJlJY1VB76+pZVxEudZbyOefOhgwR5mVuNjnkH9A8NvVrD47wZtez
         KlNKbukP2UuwIH+AlFFazrikZI47XKCJWkBnzoz2lgCV00in7viMrwmdFoBeYJsMuTax
         /dCQIB4+k2SysarbRXF8F1XrEOk59THB2Ms1emecHnU0qgSwGi5ldFgAWEg2jL6nNU2Y
         1iAA==
X-Gm-Message-State: APuU4Z8ggl9gp+R5JkH0sJm+9RssfSFk9x6qRYz3l5rNtEQDTmsd99sN
	FMSW1Utr7ocKuMQdu5CXvpnuQz/2tKLPxfolpTqiDZ8rybP54AADzJXWeIY9Ow==
X-Gm-Gg: AYBFou3RoAPYlsNSDHBCaiLkDQlfBiTTvAonUBrrmoK4GB7bOKvtSJu1xB8wGtPrr76
	AidAhRUntSnEad6lBXwfTIIH+1tea1v3Bo8waxjNo21Uln1IeNJ01IEaCucPL2PwQDZblP5H7rz
	r/oHYAkqmsOadGQ1hKpk1wo4tCa6gxzlSq6uC1fN9iqcb9RYd5OkFuObDzf9ieHSdhzHI2aviMo
	13k1Mmd8N2SA0BwGpjC/p5j+jCzcg0ZHBMODy3HW2UQWs7rwSJAsjMl7Wnc+/feG9qUV3n+CBTH
	FXqTBTvHc5DPP/ACC8D4ADyD48NhQIVRVymLzO5Vohea9NPj/sig18R+KfhnpOtfjfT6f8jozTa
	sb0tjF6/+Bq2rJqhb8CXryiUZI8H9wOsOntyK7L3MX/0ifCyXUv50JNq/MRic0jZt5H1N50ABXH
	9s2JBHznqW9xyGsDEh5uMaAsgr8ykVQVcCeiASJxKmG0oGJRvLZR0HrjYTAGgT8yNJZ3arR+uHb
	yHf/0EhqVvYM+V3+gm2g4Lmcn0dxuvgFdpz9gQOXbKAcaxwCsVGXiVSXj46nV/gqo1JIzTpeWJZ
	mfxZUCVngLQV91/j9vxI/4cUbLFiTeX8R6gj28GKQ6T+sqjAQHVXl8hvJ8qrtcg=
X-Received: by 2002:a05:600c:a013:b0:4a2:526b:d40f with SMTP id 5b1f17b1804b1-4bb7d57749dmr29439635e9.0.1794985013245;
        Tue, 17 Nov 2026 22:56:53 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783f7eecsm222311235e9.3.2026.11.17.22.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:56:52 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/4] pack-check: use size_t for the size passed to verify callbacks
Date: Wed, 18 Nov 2026 07:56:38 +0100
Message-ID: <00939c7f1b144fb9dbbc1745e60f7baa18217742.1794984184.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794984184.git.gitter.spiros@gmail.com>
References: <cover.1793446357.git.gitter.spiros@gmail.com> <cover.1794984184.git.gitter.spiros@gmail.com>
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

verify_pack() in pack-check.c passes each object to a verify_fn callback
(defined in pack.h) taking the object size as an "unsigned long", even
though pack-check already handles it as a size_t. This signature is also
replicated in struct odb_fsck_options (odb.h) and implemented by
fsck_obj_buffer() in builtin/fsck.c.

On platforms where "long" is 32 bits while size_t is 64, such as
64-bit Windows, running "git fsck" on packs with objects of 4GiB or
more passes a truncated size to fsck_obj_buffer(), causing
parse_object_buffer() and fsck_object() to inspect only a prefix.

Use size_t for the size parameter in verify_fn,
struct odb_fsck_options.object_cb, and fsck_obj_buffer().
parse_object_buffer() and fsck_object() themselves still take an
"unsigned long"; until they are updated separately, they keep
inspecting only a prefix.

Triggering this requires processing objects of 4GiB or more on a
platform where "long" is 32 bits while size_t is 64, so no test is
added.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/fsck.c | 2 +-
 odb.h          | 2 +-
 pack.h         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index c4558efcf1..5849194686 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -392,7 +392,7 @@ static void check_connectivity(struct repository *repo)
 }
 
 static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
-			   unsigned long size, void *buffer, int *eaten, void *cb_data)
+			   size_t size, void *buffer, int *eaten, void *cb_data)
 {
 	struct repository *repo = cb_data;
 	struct object *obj;
diff --git a/odb.h b/odb.h
index 857637f980..9d4ef41d9b 100644
--- a/odb.h
+++ b/odb.h
@@ -210,7 +210,7 @@ struct odb_fsck_options {
 	enum odb_fsck_flags flags;
 
 	int (*object_cb)(const struct object_id *oid, enum object_type type,
-			 unsigned long size, void *buffer, int *eaten, void *cb_data);
+			 size_t size, void *buffer, int *eaten, void *cb_data);
 	void *object_payload;
 };
 
diff --git a/pack.h b/pack.h
index 2f2ce97c11..acc72a9527 100644
--- a/pack.h
+++ b/pack.h
@@ -88,7 +88,7 @@ struct progress;
 /* Note, the data argument could be NULL if object type is blob */
 typedef int (*verify_fn)(const struct object_id *oid,
 			 enum object_type type,
-			 unsigned long size,
+			 size_t size,
 			 void *buffer, int *eaten,
 			 void *fn_data);
 
-- 
2.53.0

