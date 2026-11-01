Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793518149;
	b=Fgwr3t0Ga7PGw+nEqqnmuN7T+iIEzs4Q2Pv9FedTVl9rMRRWC99gisJtCW94r2g8jKD/
	 VlN624WWGKOfVuw8swYfLIM8bvNLS5/ps80oKkVTjTsH7x0Y3pQYujvF9yN7zcDWMKzbb
	 b2w0PnTjSOWD9yrqRgXg39YOoxNehWTgUPeA0wjIMQ8DKrWRXWHLbWYPc+50VfK0B4yn4
	 b+4UPFuuJme3oipXTdrSmxYgh5b7ClA2dKt8LzBYyM5DFoevuAWevutNdHeLlqrC/GaWV
	 DuLF/cxo1Zui3MlFGBQNpp53gHBuCwL1O3nb+fM4jnKI800Vqnw94YB7kiP55Z+UR7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793518149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Qc4v2J/Wh5ir9BDpvZNh4x5rh0znAEQaxzbk6ey7IoE=;
	b=vYdS6d9AbiXXclTKN19Eq5LHfv3BMQLK14E74GVOVjs9JRtCnY9GMkLTnYpAR7SAlYLJ
	 KKlvj9XkgM8cZvEUX1no5HFFbgmszvr7qrB30wZE467qi+j5rwG8pr182DVODTwpQwE+U
	 oqh76qUhsBUmYi0wcZF5DQVDoANfoMqipAmQDjXoK8/glNL1/d3FdibTCfwBPJkbXKpUB
	 yxvXwPJz1Y7wK3MQ7/OfsKPGJVUAWKjxI2XWjfqZJqqM+O2xtAi3X9F34MGTU0qh+hVoX
	 E5gutbsepQg2pkGHkCO6Yw1noi+tOtznBkzEVgffH2ybSRvDn96blJcaxq3w7fYe+rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SVWmpLoY;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3870606A324
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 07:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3870606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SVWmpLoY
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48df4f540ebso865840f8f.3
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 00:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793518147; x=1794122947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qc4v2J/Wh5ir9BDpvZNh4x5rh0znAEQaxzbk6ey7IoE=;
        b=SVWmpLoYqIxjrA2d7XO0iyn6cDo8dFYbCcYcymbGfvNpDx+/Scu2j7LUyzGW8vcjzO
         7dG4m/2x5CuZb6xmcg8j+IMoh/US+K6XYq6CXDA0kbqp6tALEQnr/m1Z8H2XmceH9cJJ
         ZiMOPonuDbdS1SvzQuQRmp5Rg3mTKzs5/RTX8ABKhXMpmn+Ro8/qmdl85zUaZJPg+2ku
         pL5H6YfbiD/ysYaHYWp3ziin2RPZWeW+/OXhidHHae5HT/diSzsqQLjRJjQYbdL2NCej
         nYoEgSQgUFDN+XZCi2JQrIY4HMXolkx3uprhIvM2al6YygyNtb3Po6piL4ncqRb8bxLx
         aX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793518147; x=1794122947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qc4v2J/Wh5ir9BDpvZNh4x5rh0znAEQaxzbk6ey7IoE=;
        b=MgjgCsOh7WMP+7kq2oyfpQz3PrNH9pSrljlFJvTYBS3ua9ej9BO8oUyQnGVA8705fl
         mhcHPUD0lDNhpFsNTI+Fd8m/Dv7hx2v5VO9g7KZfyx7ALZ+/uOu/RvezFa6eL58OnbSv
         OjZpHr+TBOoXrIJ5aW2wdfsvZ3hwbQMKwMD8wmrF3ge6j7G02akRczfGtP4Y6RMnyeSS
         kBqsappRz9qcx8FP8aJFXHFVDh43Glv91XQg/rXPJVgTAfFpvOqT4S9AO3KFR46DEyNu
         XiOG6sliIISIN9sLuzJgpYxV+pxRbsYXjUZrY3UHLIJa+hFCZzDUCdChIpp32YMS65cC
         9kQA==
X-Gm-Message-State: APuU4Z/uA956EWujTPcQR7CUtNuMc81Pv2oYPFmjO+EE+xIn7cru9gjf
	u54ozeoqoPmQaCN/AAGIpDcq8Sycx8lUWjPTrxM0NTKWiRQ8IvA+2hikzrvr5jr4
X-Gm-Gg: AYBFou1VxDaNKGuMz14Dx4k7mqZeVq6kkhQdeZwnN4oDMS/dqsS6wxOFDqkVVHQtW1m
	WjuB673w0rCneD/EzQ9FMIDqozJZyXlrrKSn1z2Yrx4jqQYKxHFhYSajPDEmivInuwSmqNOharQ
	P0pSJniqFkFgNdikUSzSyMMYjy6hjfveQhdaMhy84bq5phQIS+WKpEdf5zs6815Im5jvEsokLSo
	1MyqF6o9BX9C0WzmUu4AnfLES+7jnz6PGaaxBk+JizlHXqMWf3usCm0H64uyU0D6GyXls9CmkyV
	dBVvvIb1aZELAjDDZ0YybZYbNdpJsMrNjmZ4QCs+wE4dpmMbN96ME8getIlkY0wPdWCsTRiJzdm
	P9lWOhWl/tweVlXiTLI2eFDD6T/fg4HFsr9pfaYGeuztzTWGZH27WmDKeyzwzxQ+NNgSoWXFZyV
	ze28H0eI1YAlYrSeNpn42OE6Vw1XN1mgg/KiBh9Te3D/kWZEdJr/GTohs5d/C1fm31Ezrqm6vFt
	ks+7FoBze52ohKG4nlCpIlRaAGudbdBsfUtwZGd+VAATW2ASnqcSfqZxpMlngf0Jwpo7CgEpaHY
	7yoOpRw/DgTfjqVDT3E/DQpCL82CP5iGYcUjRZfUEIduyBkWKArmSIPWC3lW6dc=
X-Received: by 2002:a05:6000:22c4:b0:48d:ff0b:9b52 with SMTP id ffacd0b85a97d-48e6e306ebamr15655808f8f.19.1793518146970;
        Sun, 01 Nov 2026 00:29:06 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71ba2415sm13100417f8f.50.2026.11.01.00.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 00:29:06 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Simon Richter <Simon.Richter@hogyros.de>,
	Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	Olamide Caleb Bello <belkid98@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3] pack-objects: use size_t for streamed large blobs
Date: Sun,  1 Nov 2026 08:29:03 +0100
Message-ID: <20261101072904.274912-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261031183748.273957-1-gitter.spiros@gmail.com>
References: <20261031183748.273957-1-gitter.spiros@gmail.com>
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

On platforms where "long" is 32 bits but size_t is 64 bits, like 64-bit
Windows, handling a blob of 4GiB or more truncates the size in the pack
header while the data decompresses to the full size, corrupting the
object. If the compressed data also exceeds 4GiB, the length
accumulation overflows "unsigned long", misaligning the offsets of all
subsequent objects in the index.

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
platform where "long" is 32 bits but size_t is 64 bits, so no test is
added.

Helped-by: Simon Richter <Simon.Richter@hogyros.de>
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
Changes since v2: say that this is about platforms where "long" is
32 bits but size_t is 64 bits, as Junio asked.

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

Range-diff against v2:
1:  185b9da891 ! 1:  02e682725b pack-objects: use size_t for streamed large blobs
    @@ Commit message
         write_large_blob_data() adds up the compressed length in an "unsigned
         long" as well.
     
    -    On platforms where "long" is 32 bits, handling a blob of 4GiB or more
    -    truncates the size in the pack header while the data decompresses to the
    -    full size, corrupting the object. If the compressed data also exceeds
    -    4GiB, the length accumulation overflows "unsigned long", misaligning the
    -    offsets of all subsequent objects in the index.
    +    On platforms where "long" is 32 bits but size_t is 64 bits, like 64-bit
    +    Windows, handling a blob of 4GiB or more truncates the size in the pack
    +    header while the data decompresses to the full size, corrupting the
    +    object. If the compressed data also exceeds 4GiB, the length
    +    accumulation overflows "unsigned long", misaligning the offsets of all
    +    subsequent objects in the index.
     
         When running repack or gc on a loose large blob, the original loose copy
         is pruned, leaving only the corrupted packed copy and resulting in data
    @@ Commit message
         because core.bigFileThreshold is itself an "unsigned long".
     
         Triggering this requires processing an object of 4GiB or more on a
    -    platform where "long" is 32 bits, so no test is added.
    +    platform where "long" is 32 bits but size_t is 64 bits, so no test is
    +    added.
     
         Helped-by: Simon Richter <Simon.Richter@hogyros.de>
         Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>

base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
-- 
2.53.0

