Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793471873;
	b=NzxnORUwaDGIkqGvEX6LpX+QUG/q8P9re3EJzZtFACmcIttNnzjf1B3pznfZThhLRGOq
	 OAIoRXYqoa5TF4PNimsTx1CNfia4OhZoXmxOH3jLLw22IKULG7TW5l8wLKDBJDhZR2nid
	 IXotLAMFou+6uZxc0IJo/CmRQLmAhlgMp8IdSBequX4pfBDk8xEbhOYRZ66To+O6XWGb3
	 eG1oM8noPU9+vdZAFkPjF9osRCNDcuYTMKzDGBkqu1m3quel7F1fzt11nI514EITSnKpC
	 l1ITpVaB/Tiqr6o124Qi3X6st/rMvw5loL6G/rZjno9jg26onFwgBnCH4nVmz50swEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793471873;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vJu1E8C7XZJC+/5LkmvOuiY2tzcsJPyKXldjsAp8pmY=;
	b=w5IfGP81rDLx4zHZ3OOVKlzTtJvY4i3YPoZaWg31qb/n5VH/nVpoK3xStsBODd5lJS+4
	 vclHk4jjpmp9p3RJBIos8cwvQCTyNxKs3Ev5vInNrOndKLQ8PkLn8EV3g5izuKX9Mr9ZJ
	 4TQmHc6vi02/wM4INrwhMtjsyea18JA/h/o3shbTXlI3IiljTXVWdAivpn1nKyz+dD6jS
	 ELrqHoObnCq/UDunHBlqbaaW1UKqmMGJD7axhA0FBkaJc7VJBaKMoNNjz6jrRaCUAlHlu
	 A9pl4YhXFIr517HaldejTivaaWSYjBxzkHnh7nKaR7jn2lknwF5Vx3IshZ1W91Es/oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f9mMA7cf;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D901606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 18:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D901606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f9mMA7cf
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so14165765e9.2
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 11:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793471871; x=1794076671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vJu1E8C7XZJC+/5LkmvOuiY2tzcsJPyKXldjsAp8pmY=;
        b=f9mMA7cf9E/3x39KueJ55UYEp+606tt50f5HYG6zXnNNX+aV2gc8hczT83izRPoAKx
         +VAzB0g2VBIoenJ2zAiz3GxxAvnoYGUDm/Kj6ac9N8OX1GS4+zddseGnfjDGvzN4Tz4N
         ZgIulm5gm25rxs9zGTgljKnVf84TOX9uWBPVPZud9BctV/OHK6yQamfO6VTAiX6I77ML
         6gdzebtnr0FkSm/+mVsCmbs+3zuhpA9Oo3HNWVjZvijnm8mw7wSdiK4JJb5O4pKSni7a
         Jzr5S8s3DbJcBG3jmEFHlSOseOVUIgB2pCg9wXyJDcyMWFF3EoT3CM55MV9KBKKNgtHh
         heEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793471871; x=1794076671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vJu1E8C7XZJC+/5LkmvOuiY2tzcsJPyKXldjsAp8pmY=;
        b=ZhEMp6OYZ+/0uiWjlwlykTuTX0sm395Kn/Ltzb2jbcSY8b6QNTLFfmV0RmDn8pDvT4
         xofkvdvAIh2RI0BdqFzN9PvF8OnAaQLkeT2IOIKDWb6j8c7o4rYR9cjEhuqGuC/ePZ+G
         XPBACueca7jRVagHKCacsFyYqA4TT0XckkdfSVX5vQqqeCmW6xIXEodR0Ea8Nn4fA5U5
         62dR0D/AZCxmv2yalW0cvZc9EJ6WGY6kONUSil9z9MrwxwjKUOuGsaQdkEcV/lUUUUP7
         WbtkX5NiqgeKgPHjL2fN4Q49c/H3PQQ2bj78Yg8QgzqpF53hNNieCjIzL4mv9cMZLRAr
         1NZw==
X-Gm-Message-State: AFq9FYJFfjRasEZsuEDrMGBYTz54O3ECueIhVYher/TCXosCW+PIpwwT
	UtwoJ2qJU4eqZNbppuK0e6WNtGnIb4ru6Ntxmx3ceYNEBIi8SJtwaTKBOM0XS4YN
X-Gm-Gg: AYBFou1eO+b5HtPWok1vHn5y1pPHdr+bQ0l371o8N/A3skX1sJJvktgGgxj8UbkwCKy
	gd/LUPUrjKHP7FeaFwQeLuoRX0Lx2nHueV4hIMzPTITUxV4ZUAxRp6n3m0TfwClJSwpVJDza1pP
	fovYSOeRKZVsTWYxTJ1gVnXJKP7Z8Xlh4i4K2Zoi8X39AcM8FL/dOuFCUkhDY0De/LLoa5UD5xX
	fLhchNo1OBphYuJkVkPzM0Iu/RyjjTwbmciPvL8L+pFU3z3d1t7DEQ3o8OVzNQXFd+CV9VCMtNB
	mVm8J+ZbvyNvTUiUV2kgs7HqTCuNdhU7iG/VFInL7SkgEL6huLa+Htic5+oYpFBjj9GXhtO8OR7
	qSr1+YVkk0dP6ERoVYPQZhYFGXTIlnqLooP996SkwA9vWn0TKezybU8AKXH5bWaRm0BzefFNgK5
	wx+5PWjtflmLlNKNskTpj6aix1IRuR7fDwBr10DT3v7lmhFCRapm5WmLdNJ4fWp78XuDyhLeGyp
	fDmU9Bes6WA8HJSNFy7iSA6ECTCe4VE7KSRADNB22bFH5OQolrzkiSfv/RxQd7gmos+P7+B8VjY
	FHgBNbj4W629BC05drS7GgUK4g7nolyg4A9vv4HE10535On350AFXGuAl7hXQ6U=
X-Received: by 2002:a05:600c:3f0f:b0:4a2:1612:636e with SMTP id 5b1f17b1804b1-4ac16bc4645mr130928785e9.5.1793471871381;
        Sat, 31 Oct 2026 11:37:51 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81b7fe80sm251681865e9.11.2026.10.31.11.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 11:37:51 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Simon Richter <Simon.Richter@hogyros.de>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Olamide Caleb Bello <belkid98@gmail.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2] pack-objects: use size_t for streamed large blobs
Date: Sat, 31 Oct 2026 19:37:48 +0100
Message-ID: <20261031183748.273957-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261031180411.257932-1-gitter.spiros@gmail.com>
References: <20261031180411.257932-1-gitter.spiros@gmail.com>
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

In builtin/pack-objects.c, write_no_reuse_object() handles blobs
exceeding core.bigFileThreshold by writing them in a streaming path. It
takes the size from st->size (size_t) and assigns it to an "unsigned
long" variable, which is then written to the pack object header, and
write_large_blob_data() adds up the compressed length in an "unsigned
long" as well.

On platforms where "long" is 32 bits, handling a blob of 4GiB or more
truncates the size in the pack header while the data decompresses to the
full size, corrupting the object. If the compressed data also exceeds
4GiB, the length accumulation overflows "unsigned long", misaligning the
offsets of all subsequent objects in the index.

When running repack or gc on a loose large blob, the original loose copy
is pruned, leaving only the corrupted packed copy and resulting in data
loss. Truncating st->size to 16 bits, with a 100KiB loose blob reachable
from a commit and "git -c core.bigFileThreshold=1k repack -a -d", leaves
a corrupt packed object and no loose copy.

Switch the streamed path to use size_t for the object size, and off_t
for the length of the compressed data, which write_large_blob_data()
adds up while it writes the stream piece by piece, and for
write_no_reuse_object()'s return value, like write_reuse_object()
already does. Other truncations in pack-objects are not reachable
because core.bigFileThreshold is itself an "unsigned long".

Triggering this requires processing an object of 4GiB or more on a
platform where "long" is 32 bits, so no test is added.

Helped-by: Simon Richter <Simon.Richter@hogyros.de>
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
Changes since v1: use off_t for the length of the streamed data,
following Simon's comment.

 builtin/pack-objects.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ca3a891dfb..24203b5359 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -412,13 +412,13 @@ static unsigned long do_compress(void **pptr, unsigned long size)
 	return stream.total_out;
 }
 
-static unsigned long write_large_blob_data(struct odb_stream *st, struct hashfile *f,
-					   const struct object_id *oid)
+static off_t write_large_blob_data(struct odb_stream *st, struct hashfile *f,
+				   const struct object_id *oid)
 {
 	git_zstream stream;
 	unsigned char ibuf[1024 * 16];
 	unsigned char obuf[1024 * 16];
-	unsigned long olen = 0;
+	off_t olen = 0;
 	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	git_deflate_init(&stream, cfg->pack_compression_level);
@@ -513,10 +513,11 @@ static inline int oe_size_greater_than(struct packing_data *pack,
 }
 
 /* Return 0 if we will bust the pack-size limit */
-static unsigned long write_no_reuse_object(struct hashfile *f, struct object_entry *entry,
-					   unsigned long limit, int usable_delta)
+static off_t write_no_reuse_object(struct hashfile *f, struct object_entry *entry,
+				   unsigned long limit, int usable_delta)
 {
-	unsigned long size, datalen;
+	size_t size;
+	off_t datalen;
 	unsigned char header[MAX_PACK_OBJECT_HEADER],
 		      dheader[MAX_PACK_OBJECT_HEADER];
 	unsigned hdrlen;

Range-diff against v1:
1:  45e45c5b75 ! 1:  185b9da891 pack-objects: use size_t for streamed large blobs
    @@ Commit message
         from a commit and "git -c core.bigFileThreshold=1k repack -a -d", leaves
         a corrupt packed object and no loose copy.
     
    -    Switch the streamed path to use size_t for size and datalen, make
    -    write_large_blob_data() add up and return the length as a size_t, and
    -    use off_t for write_no_reuse_object()'s return value. Other truncations
    -    in pack-objects are not reachable because core.bigFileThreshold is
    -    itself an "unsigned long".
    +    Switch the streamed path to use size_t for the object size, and off_t
    +    for the length of the compressed data, which write_large_blob_data()
    +    adds up while it writes the stream piece by piece, and for
    +    write_no_reuse_object()'s return value, like write_reuse_object()
    +    already does. Other truncations in pack-objects are not reachable
    +    because core.bigFileThreshold is itself an "unsigned long".
     
         Triggering this requires processing an object of 4GiB or more on a
         platform where "long" is 32 bits, so no test is added.
     
    +    Helped-by: Simon Richter <Simon.Richter@hogyros.de>
         Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
     
      ## builtin/pack-objects.c ##
    @@ builtin/pack-objects.c: static unsigned long do_compress(void **pptr, unsigned l
      
     -static unsigned long write_large_blob_data(struct odb_stream *st, struct hashfile *f,
     -					   const struct object_id *oid)
    -+static size_t write_large_blob_data(struct odb_stream *st, struct hashfile *f,
    -+				    const struct object_id *oid)
    ++static off_t write_large_blob_data(struct odb_stream *st, struct hashfile *f,
    ++				   const struct object_id *oid)
      {
      	git_zstream stream;
      	unsigned char ibuf[1024 * 16];
      	unsigned char obuf[1024 * 16];
     -	unsigned long olen = 0;
    -+	size_t olen = 0;
    ++	off_t olen = 0;
      	struct repo_config_values *cfg = repo_config_values(the_repository);
      
      	git_deflate_init(&stream, cfg->pack_compression_level);
    @@ builtin/pack-objects.c: static inline int oe_size_greater_than(struct packing_da
     +				   unsigned long limit, int usable_delta)
      {
     -	unsigned long size, datalen;
    -+	size_t size, datalen;
    ++	size_t size;
    ++	off_t datalen;
      	unsigned char header[MAX_PACK_OBJECT_HEADER],
      		      dheader[MAX_PACK_OBJECT_HEADER];
      	unsigned hdrlen;

base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
-- 
2.53.0

