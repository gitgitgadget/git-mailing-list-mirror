Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793446789;
	b=pBDtTOdojDHLnVNiw7hVtVtLwWLq4sJ54fzrixFokomigxe7BbtuT61Sa1YcH2HXJisk
	 lGHaWd8OgQbImeiu96KWkwtgsIRpXBMCbdA4nM11P6WJWm5xskvv2MC99BxG5/zgC2a0x
	 A/m8AKBymqqR6J5vFFvkzAGE3AkVapsGHFHcn93g7ZpK7ag0uclHZDzaBw7PC7gha2jnd
	 LyeYqb9/hkryDywwMVf/B4TBwWAR4vz0WEm4mniLxUW93vNTcxJC7LZS3axxHA4ZrSpin
	 00GC31ySCJAaImsPpFTdZN8sHzT39JGTeIIkrWd/6ygYYJioDUsbyV8nCrknvItv/PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793446789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Bc8n/qIMIDl4LzX4d+xBd1iNZ8XAjyP91d6jiUG1yLA=;
	b=uYzVTRumrtm2AnB3anGO6PE4hb0JYlaXnOA5MfsWLOBzF5sHyYtvAjPR2ITWDLeNt8HJ
	 8vsujADJUT/kFjAN4Sk+CaN6IyvGnDBe6r8WNM+I2qZPL4T5jwbhDPUN9sFFETh/Tgtx8
	 8Y0oe3ziQotGL99NSgV6agD69SR6SMIl1KTQWozJyhIEKjv3AypH5hLOqyUFWAZI+bunH
	 sZH9YOz15PNkb6pnX24XHqhQKlWrRXAYyFOFjHP/ZPrQ77xx/8vYjuleByLXDqDw+VQ9n
	 AVQK6G/GD8xzwYocxQrRDi35+v5iuSscPaaBfjdm7AJJxUy9nzRRH74zRQrDBEZkXsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YiUCRJJo;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD16606A320
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 11:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CD16606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YiUCRJJo
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso13698045e9.1
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 04:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793446787; x=1794051587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bc8n/qIMIDl4LzX4d+xBd1iNZ8XAjyP91d6jiUG1yLA=;
        b=YiUCRJJoILBAYyPwowlCPrYp52yPvPD3zrkl5ItKnwvHILrulb9PPt/sxrpiMvlZGy
         aOSYY54JsiKMg9RfcFzbP9aJtvX8SaoHcHZa/his0vMd1+9vxt2fQKSqKqC3VsUl9qap
         JmF2kmSVeDhlgY3EkhlEzqIVPR9YLhxTVWs8cP+F0S9EWN+vmfFOcG/tQDSqhRtjKTHu
         no+rtAIyxIdKx+m8utlcrp6FbfrDQXIVexCjt8L9f4bMtnWcSElKDFuUdyxAWkRx69CZ
         3pekigDlEn10jddiBvie2n6Mezm4ny22N2Y6FF4bFgcO7W0nScTL6jq7icjNUHlIycK4
         ymAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793446787; x=1794051587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bc8n/qIMIDl4LzX4d+xBd1iNZ8XAjyP91d6jiUG1yLA=;
        b=dzub40yFEaSjlMrIwm/pG+uY30GBDP3W/+UnPGrEx+VMtvvhTxz2KcFP4Kls6VnLTN
         px5Qhs53YB9kVHjy1dOf0VwCu7wRIJRMQQW4qOTAbJUhVZYe6o6l7vjh5RAk/SWL8gmb
         V6Gn0YsLTkAT8bY+fZeEDZW9NWT7QCQ4pUxUwZ0D+J1FqojedATUFNntZj6plh91+ze2
         gelabONmp6uDRozyhzSN/bncNkHBo17typf+0v53juZBEMvPzvOGj0X8WpBpArg5w3dV
         KM72HCP+XXFFl+Z5NvrL55XIGgrSF8lsLZHpdZjHb0Ts74BwypP3vjlvLmrZxnO1JGs2
         xzHw==
X-Gm-Message-State: AFq9FYLE5P71wAVnuNyd0hNvdNDJFWK13UF5QCz5irySgNG7zdfW1xi2
	3nAU7QX2SDIHZ6QCKbszC+34fC43LMC2aLUQY+4sKaMB2UfMDi6k2lPKG6+x8V/K
X-Gm-Gg: AYBFou2KiHUfJUqgYPZA0Fi6SKO0xntf9kn6QRpXyGMuyUdalsNRzhh/A3kUrM5kneU
	VufP9Wsu1GAJHt2/AhzWF1TdjL9XPjPN68drKaNyzukVFbgUH2iKP7GBUvEXP6CM0YTfbgVNibZ
	z+LMGjwRp228oGaqr4eeR7Cu4/hFGvi367XUb40qpLqWMZ4E3TYIYlMWOHNS1KkYrwN/U9y4qkt
	SbIn+qslR/qOmj8RShg8jPajv6NpypGGc/8oTguASXZ5tfKdnjgRfGvm0Jta9o7Tr/Uh/NRsPQB
	N3BE3W0mK5f94RChsOOfSN9znQLMydU5SGzj+u9RTP4KMhceB30E929jwEbh42u+bjYAdU9eTLE
	oGhFQj/4g5B71vyhGWX3tWpXmiE7/JGV8GHVNr3YFdv8TJTldiyVhc7pI3OL8Cd6OusJWrbQYIo
	pyV4pNdfFcSfXIt0MRIpuOHzNOy2fMO8wUtm8rZ28uZoeoFzactNnknHnKsLQY8w5QCqNBXEcx/
	ZtXi8N+o6etfBb5nTaS4uzvWeE7Qqe7406dUzB75U3mTXvdAfTfVMllyyAjumc3vstWfdUCO746
	ALsLkuNaiyyDtrlUkpbsb4MhbfnCFttOPGxUCt73dp00+gwiofG4G3YF/GhmVHA=
X-Received: by 2002:a05:600c:3b87:b0:4a2:150f:1607 with SMTP id 5b1f17b1804b1-4ac1709ad56mr110317225e9.13.1793446786888;
        Sat, 31 Oct 2026 04:39:46 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78a4csm8345366f8f.23.2026.10.31.04.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 04:39:46 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Jonathan Tan <jonathantanmy@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 3/4] index-pack: use size_t for object sizes
Date: Sat, 31 Oct 2026 12:39:37 +0100
Message-ID: <02582827457e53b61548f544f57fd7f4044e725e.1793446357.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793446357.git.gitter.spiros@gmail.com>
References: <cover.1793446357.git.gitter.spiros@gmail.com>
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

Functions like sha1_object() and append_obj_to_pack() in
builtin/index-pack.c take object sizes as an "unsigned long", even
though struct object_entry already tracks them as size_t. On platforms
where "long" is 32 bits, this truncates the size for objects of 4GiB or
more.

When receiving, on those platforms, a large object that already exists
locally, sha1_object() compares the real size (size_t) against the
truncated size, resulting in a false "SHA1 COLLISION FOUND" error and
aborting index-pack.

Use size_t for the size parameter across these functions.

Triggering this requires processing 4GiB or more of input on a platform
where "long" is 32 bits, so no test is added.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/index-pack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f65228468b..d4c073654d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -588,7 +588,7 @@ static void *unpack_raw_entry(struct object_entry *obj,
 }
 
 static void *unpack_data(struct object_entry *obj,
-			 int (*consume)(const unsigned char *, unsigned long, void *),
+			 int (*consume)(const unsigned char *, size_t, void *),
 			 void *cb_data)
 {
 	off_t from = obj[0].idx.offset + obj[0].hdr_size;
@@ -765,10 +765,10 @@ struct compare_data {
 	struct object_entry *entry;
 	struct odb_stream *st;
 	unsigned char *buf;
-	unsigned long buf_size;
+	size_t buf_size;
 };
 
-static int compare_objects(const unsigned char *buf, unsigned long size,
+static int compare_objects(const unsigned char *buf, size_t size,
 			   void *cb_data)
 {
 	struct compare_data *data = cb_data;
@@ -881,7 +881,7 @@ static void do_record_outgoing_links(struct object *obj)
 }
 
 static void sha1_object(const void *data, struct object_entry *obj_entry,
-			unsigned long size, enum object_type type,
+			size_t size, enum object_type type,
 			const struct object_id *oid)
 {
 	void *new_data = NULL;
@@ -1438,11 +1438,11 @@ static size_t write_compressed(struct hashfile *f, void *in, size_t size)
 
 static struct object_entry *append_obj_to_pack(struct hashfile *f,
 			       const unsigned char *sha1, void *buf,
-			       unsigned long size, enum object_type type)
+			       size_t size, enum object_type type)
 {
 	struct object_entry *obj = &objects[nr_objects++];
 	unsigned char header[10];
-	unsigned long s = size;
+	size_t s = size;
 	int n = 0;
 	unsigned char c = (type << 4) | (s & 15);
 	s >>= 4;
-- 
2.53.0

