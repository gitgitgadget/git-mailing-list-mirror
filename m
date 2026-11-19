Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795070645;
	b=YkMChu7UeX5cLGdU3m7XyqMiNWvzT1iBTRq4KPzVlktF8675GP2V6548Eqej5ItDQx9H
	 IgpEjS/sZNJp0XkrIcAC/3O6Qb3v3PpY1Veo8LMiDRe3dns9cebL9K8xcgGPYT7ET/ZRO
	 riW2Gw32PuQufQDT/BxrnEhR5R+7jstVvlBNoRPdRIaYFZ1uf720SVvSEHp+Y0K9hIWUk
	 Tm5pisagMwWTUlOAqVy6trh29ra//jnywuRJLEd1o/0qSeR/KpbGmdQ172JiRFY6Sj7zu
	 AILnGLrxrYvDxpMciVFG3cnM7DDhDpLnTjXeGU8BQV5ml6EV6eu1+YL7VDvkWsqjS2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795070645;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eGQAZt9rnGzAABV1/DqTFR7NIWSq4H5R2lhvXxhTz+I=;
	b=V54SsXjJfkITDaWC0WAxjzillzM1KxFdUeWZGqmhozmx88w17D8v0tL5agl+aO7lhLJW
	 58hR3+JQ46oHGqLUGDRVCV+Z7g6Pj8xRRNqJLEx3ueAde32lU/O6nJfUpc1HVCDkGkfRo
	 fxBJwxMRR8XB5cEFc8EOSJTe9VWblIDnw0Db4MBf9rDIrohHWqKpSIxZ/AePkuucm4QkW
	 877HReYISEisZUEdd6aYzuoNn8+ya0/CkpIU0ifz9nXTa1e4R8nQqgqkbv0/+OxZpFQb4
	 iaCSNe1b7F5ibka4FM8gU0HL81Kqlylt8FEG1OY2FUNNzHotj8usCVLvJB2gtv0ONPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="YGq77/SG";
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF74606A330
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CF74606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YGq77/SG
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so20549135e9.2
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 22:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795070644; x=1795675444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eGQAZt9rnGzAABV1/DqTFR7NIWSq4H5R2lhvXxhTz+I=;
        b=YGq77/SGWaXa8gNR/WcfyLeZWR7v6GB4sMwfXXwtV08nXvfi40w3xsYB5lhWakLLk3
         KOoZKpfOfli1+v9UCR5QyY7d0hkw69GAVrO5hNfNrHaAF6BaEfLTymv/8md17iQZYLtt
         2ifa50R4/HaqzKsZFbi5BEPWBbVNplhyF4YzcL7y6+i7hVQF0J4OtkUjC8ZiR7iScCND
         VwDd7/ilY2N28yAZz+5JN9cGPH3wbnlqGD/TH/CH3osZJgYEYzCoAcOVlLf0IyZWGwpU
         gGSWb/EiBBGbuCmWXwcfMnm+ox5v8suFHY8oUbAz4ITPjMWllhEbyTE+jD1GY6OuzhqS
         dPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795070644; x=1795675444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eGQAZt9rnGzAABV1/DqTFR7NIWSq4H5R2lhvXxhTz+I=;
        b=OyyPd83peTxYvsCfciJ7lxNpK4b5Ga1uadSdJCUktbFXhUxGHsv+4cBjWTuxHojHIB
         9RyY84sD32ffKCimLsqTEbYkr52Jut8Emrdt686En2CYgyuedL83Ajnt3XpvQVWInuwY
         lJFFzZtJfqymhcp/0v+lIN1WRckTlf9HJdQvXrkKEkmNChz5dywWehGKa6WbhsAY9hav
         kgu9aJ9yPu3gj5SObxXSa/pe9CovqcvTNKb03DbV67/LO2sAX6EYgJLNTWxRAco9R43W
         450AA8tt22sbuB0mnylXwVbbIFt8n+wgaGP8Rpz487SBzf/9mIMUDqFqxbUQhlVrssBZ
         LxZQ==
X-Gm-Message-State: APuU4Z9dOO0n2PjKG6kbKStRJ8LpxQthup4bx7CbtupxNAqttD3De2L6
	narPRfc/2BKs0U80njcpISBYKewsdb2javWyDNEqk4MonL5469PhpFAK3tZYww==
X-Gm-Gg: AYBFou1ldQdkH5n9PUYjrin93U34hbMUuo00h2qpW2qiHAWHrcA8OhTcw5WCXLxLNK0
	sAVK2q74JIbMO6yycCS2xm2ph2A25h8ZJTIC9TmmCuwzAELfcHaloVmeocplu18uViOjx6wROsJ
	G9H9NRu7GkQVwF1cqmVul5tfwX1kR/uLxA+CwwdjcTYRzEgsKjxaeq8Yx5kUVUaBtQ1zOVPAQ1v
	AnsQ0mZ0gRE/+0m4iedfpYX3G7SfPhcKmqoGHxDuM1u4Jq0fYUKwQP7OYwnTGkfXu9IW4eFStPd
	QZWqawn+hjZ3yN96St9lTlaQ4iNJTb3TQ94RidZFS9INrgLIGyQl6Q9kdnRdVw5YUsbsYeGoQb6
	DuBpkUvLFfSq692B/WEkNLsXbRFkL3kTIciiE7/xth/giNuHq0O+jXzv8p/dMinJm7IAvMxnQZ1
	377qkmAnQ24rL1qxqQmyjKj7dIbiR9PTL50kwMPwd5KaJlfu6ROYIowFl2gUEPgA9zUXu0xuNTV
	rH3L+tCBfRCutkW5YOLK3RwJUpcCmn5tceWGYgK8Y4Y4X5Kkdbi8fkzZEa4+vpAQAd/joEM2xr3
	C5VzmQ5diqyrhoo2JYROiRBWfUj+iu+z2zGjtAsrAjK5dd0UDmGfMxhVlHKMmgQ95nux6OImwAh
	DDZcsWeVp
X-Received: by 2002:a05:600c:46c7:b0:4bb:76f6:d23a with SMTP id 5b1f17b1804b1-4bb7da45409mr102726685e9.21.1795070643846;
        Wed, 18 Nov 2026 22:44:03 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85372d15sm15172955e9.14.2026.11.18.22.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 22:44:03 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Taylor Blau <me@ttaylorr.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 1/4] pack-objects, fast-import: pass at most 4GiB at a time to hashwrite()
Date: Thu, 19 Nov 2026 07:43:53 +0100
Message-ID: <6399c46c3c18a3389e5af77966189dac0a9b9157.1795070117.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1795070117.git.gitter.spiros@gmail.com>
References: <cover.1794909894.git.gitter.spiros@gmail.com> <cover.1795070117.git.gitter.spiros@gmail.com>
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

hashwrite() takes the byte count as a uint32_t. Three callers can hand
it more than 4GiB at once, and then only "count mod 2^32" bytes end up
in the pack, while the object header records the full size:

 - write_no_reuse_object() in pack-objects writes a compressed object
   from memory in one call, which can exceed 4GiB when
   core.bigFileThreshold is raised above that;

 - copy_pack_data() writes as much of a reused object as the pack
   window holds, which can exceed 4GiB when core.packedGitWindowSize
   is set that high;

 - store_object() in fast-import writes a compressed object from
   memory, like pack-objects, when its big file threshold allows it.

Have these callers write in pieces of at most 4GiB, instead of widening
hashwrite(), which src/csum_file.rs also declares with a u32.

With hashwrite() taking a 16-bit count and a 100KB random blob,
"git repack -a -d", a second "git repack -a -d" reusing that pack, and
"git fast-import" each leave a pack that fsck rejects with "offset
beyond end of packfile"; with this patch fsck is happy. No test, as it
would need an object of 4GiB or more.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/fast-import.c  |  9 ++++++++-
 builtin/pack-objects.c | 15 ++++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 9db3f83eea..45590106fa 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1098,7 +1098,14 @@ static int store_object(
 		pack_size += hdrlen;
 	}
 
-	hashwrite(pack_file, out, s.total_out);
+	/* hashwrite() takes at most 4GiB at a time */
+	for (size_t done = 0; done < s.total_out; ) {
+		uint32_t n = s.total_out - done > UINT32_MAX ?
+			     UINT32_MAX : s.total_out - done;
+
+		hashwrite(pack_file, (unsigned char *)out + done, n);
+		done += n;
+	}
 	pack_size += s.total_out;
 
 	e->idx.crc32 = crc32_end(pack_file);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ca3a891dfb..d72eefa2cd 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -495,6 +495,9 @@ static void copy_pack_data(struct hashfile *f,
 		in = use_pack(p, w_curs, offset, &avail);
 		if (avail > len)
 			avail = (unsigned long)len;
+		/* hashwrite() takes at most 4GiB at a time */
+		if (avail > UINT32_MAX)
+			avail = UINT32_MAX;
 		hashwrite(f, in, avail);
 		offset += avail;
 		len -= avail;
@@ -624,7 +627,17 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 		datalen = write_large_blob_data(st, f, &entry->idx.oid);
 		odb_stream_close(st);
 	} else {
-		hashwrite(f, buf, datalen);
+		const unsigned char *p = buf;
+		off_t left = datalen;
+
+		/* hashwrite() takes at most 4GiB at a time */
+		while (left) {
+			uint32_t n = left > UINT32_MAX ? UINT32_MAX : left;
+
+			hashwrite(f, p, n);
+			p += n;
+			left -= n;
+		}
 		free(buf);
 	}
 
-- 
2.53.0

