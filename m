Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356130;
	b=sru0K/JxcVyjlXrk2yJ3u/2bZ4Ljcc7OAa9bW1JUrmyguC2IT5SLsxr9Occm63RNoyEc
	 l6xjgCrnaaTloDcLLP3cyNbBLTxk9lUoXpcTuFm0+/hiXm9SZi4oo/OvRtpC3jG04X5Bm
	 XJ10zFsXNZdvrvpZU9KTtRH+V3xM+w6u4SmWTpTWMZHjrQJCzQxnnsml1JgPvyJ8fGrdE
	 +p/Bcn3VeSXms0VAhp+gH8OieTN815CUmvZ3kda7EJx0k/+dbcYY7spvULkW//WYKUeOo
	 ZOTInhIHySS9gi/C/8Zhbt+1CfhWC3cLaWxeeIYVb0JvpY3Ms9kNlBkM8hxH2z1wx8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=M8782OwghTl32Pu8VEkTPaukp9ySxAtSql35WmIH7kA=;
	b=NNrn87T7QFQBDEGGFQ8w3QMn6yJaafASb4nqmRmsM5hQUPi31ZZ4qPzwiswP/+Z5Iw5D
	 gXJvSsDW2PdbKWyWnqY9msxqkdNwoJUeBUiBl7ViUtrZPMVwvu37yIzCyTLMLz6+te3T9
	 nMnD503jBjGMQoibOtjj/edda/jdB+idiBNAVGpN5pULFKD3jjO5peh3DD4lBkWFyAswF
	 /fpJ7sUlx9MOkx4iQSpsdQwHcrw7B3i14DoqCsuMFEzekm+E+aNNVKGNiF1h3F43ptHtc
	 tobmWlA3uik1CEVWimQh5xsO7pe335OdPWSHknVF7L7y/flb3JQwEGqD+RfT+wm4gZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zg2dG7Eh;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5469A606A330
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5469A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zg2dG7Eh
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48c5358fc28so433230f8f.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 03:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793356129; x=1793960929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M8782OwghTl32Pu8VEkTPaukp9ySxAtSql35WmIH7kA=;
        b=zg2dG7EhX9eH30L665emUgXc6H8+GGVfBP+vEzI5w7NkBiJcSTc4AjvMIBa1CJJJfe
         aA+cvuRwUG/SpWYBQ5XULtB+rXF4vsB+NaTjMoi+1zvjrC8V4enrSLGz5R2IMyGLkJbE
         Wbox29irYvjICIWgn0kDitBhj4VD9AhARFfEhQ4WGQooUgasp3TXmcrZJL8wKb0pxdF2
         gy1XPjv6gJtlOJASZtEYfmO3PH4YuF9bR2MfNehzFontGkZSSGItbwFHD6axrtk3Wm1S
         CDX9iVZUWoDLtvyUPT3QwOjLZEyu1aFdWnl+IY2tCLmn7M7JsHCaFm6YYcCDMS+pDdh0
         gbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793356129; x=1793960929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M8782OwghTl32Pu8VEkTPaukp9ySxAtSql35WmIH7kA=;
        b=UJJWjIJUfNAq+gnxDLNDq48R3aV3pISxC0m6510ARTIPOa35sAq7/F4rcmfHmGswok
         Tr085eC5IVVnbw4EeG9MtifUBWR9RJK8uTsafvsBdcUiZiEYyoeXDsrFRhHqHpEzGQkM
         6Vob9cG3cjEfYTBz6atUncDJe99JeaHMTsr6qWOZh1Q7X4LIlxCfDlvJAOQT7jGhObV1
         FI5UkarhTb3AsKEcS5smHU+LuaOdqlb5t6pbt9wGpWRsKrlHNvCujnkVqIy3lxK1FarF
         scl7x2cr747cmI4japEhl57WQ/r2Qaws0csv793XIME/VNLOew2NP1M/RiIRyjxUxnqZ
         lHDg==
X-Gm-Message-State: AFq9FYJuiG2ChJLRwEXclZOMpoKL7pEDKMp7pjIV6v9Ouh/2+cU91cHA
	4qLXKCB5fCZXYB1uQ2RwoJtV1aKeOh716nK2i5w3bqzrUrnPqVtWBhzOOhP1Ag==
X-Gm-Gg: AYBFou01o4jDV31wkITCFLZ9IVq/EjwLDmBbiGMMbaDtbDir4ocZylImtQ2UijVdhWr
	zZG4niL+YhnRYrgSyca5JIfQsPVZWOoTKY2vngFXS/JOyl44Q1OjxMX+4BMWQfXMtmzoyHvtDR6
	BaLIwwFDcwuOxLqtgfw7VwqSh06xAk71t1WfkORUCpUjk8ggUbTUzKNs5JACzadLWn9R+Y+V7uV
	77J6NLptkEfbqv3E7RMYpe0h2snaALKjB9MCTNab09mJsH1ZmIp7urgG72bqa/nyHSU913oV4XF
	tXvx8XvhAvMpnYIVfyJO0sRRVwi/EsJlTe9HTLQvTNWyszp+19QF5y9bP4F3yD3cXs0erzIfZXZ
	79k0PZelyQKTx1vMvhsz9GknTOLMm4esJAvwm23rujA75oUWsXJsup1wm1KcB9Erw+MwR5aU4yv
	TkVQroQUcIkMzo4ZAhyYVfs/iSf57MrH/cv4A21wP5WICYdJfLbOapEmlI9aORXbyjOhyUp/Usx
	z+OyjiENgnKbD9FJ09NyKrTShWULh1dwb0OcubKLoLNr5gzn+xBqZisvh9b84Wvdpygs+LhDXEU
	PlgUtuavsnehCMzdVJptSzgsLfbn6l5Q/Gxs1LpU5n4z/Acz0g==
X-Received: by 2002:a05:6000:188f:b0:487:1575:ebe2 with SMTP id ffacd0b85a97d-48e6e3024e7mr4238563f8f.44.1793356128612;
        Fri, 30 Oct 2026 03:28:48 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([205.147.30.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b964desm2449445f8f.46.2026.10.30.03.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:28:48 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 3/6] odb/source-loose: check object size when streaming loose objects
Date: Fri, 30 Oct 2026 11:28:36 +0100
Message-ID: <dee492c3d8dd58196f0524f7b682ab08ad2b066f.1793355390.git.gitter.spiros@gmail.com>
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

read_istream_loose() inflates a loose object until zlib reports the end
of the stream, but never compares the number of bytes it produced with
the size given in the object header. A corrupt object whose stream is
shorter than its header claims is thus streamed out without any error,
e.g. "git cat-file blob" exits with 0 after writing fewer bytes than
"git cat-file -s" reports. The same happens if the stream is longer than
the header claims.

Keep track of how many bytes we handed out and report the object as
corrupt if that does not match the size from the header once the stream
ends.

The tests create such objects with the loose_obj() helper, which can
already write a bogus size into the header.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 odb/source-loose.c  | 14 ++++++++++++++
 t/t1006-cat-file.sh | 18 ++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/odb/source-loose.c b/odb/source-loose.c
index d77e93e7c4..2233714ac4 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -289,6 +289,8 @@ struct odb_loose_read_stream {
 	char hdr[32];
 	int hdr_avail;
 	int hdr_used;
+	size_t total_read;
+	struct object_id oid;
 };
 
 static ssize_t read_istream_loose(struct odb_stream *_st, char *buf, size_t sz)
@@ -326,6 +328,16 @@ static ssize_t read_istream_loose(struct odb_stream *_st, char *buf, size_t sz)
 
 		if (status == Z_STREAM_END) {
 			git_inflate_end(&st->z);
+			/*
+			 * The object must be exactly as large as its
+			 * header claims.
+			 */
+			if (st->total_read + total_read != st->base.size) {
+				error(_("corrupt loose object '%s'"),
+				      oid_to_hex(&st->oid));
+				st->z_state = ODB_LOOSE_READ_STREAM_ERROR;
+				return -1;
+			}
 			st->z_state = ODB_LOOSE_READ_STREAM_DONE;
 			break;
 		}
@@ -335,6 +347,7 @@ static ssize_t read_istream_loose(struct odb_stream *_st, char *buf, size_t sz)
 			return -1;
 		}
 	}
+	st->total_read += total_read;
 	return total_read;
 }
 
@@ -388,6 +401,7 @@ static int odb_source_loose_read_object_stream(struct odb_stream **out,
 
 	st->mapped = mapped;
 	st->mapsize = mapsize;
+	oidcpy(&st->oid, oid);
 	st->hdr_used = strlen(st->hdr) + 1;
 	st->hdr_avail = st->z.total_out;
 	st->z_state = ODB_LOOSE_READ_STREAM_INUSE;
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 72fc8acc61..31a76c1b5d 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -1481,4 +1481,22 @@ test_objects_filter "object:type=commit"
 test_objects_filter "object:type=tag"
 test_objects_filter "object:type=tree"
 
+test_expect_success 'setup blobs with bogus size in header' '
+	git init bogus-size &&
+	echo_without_newline short |
+	loose_obj bogus-size/.git/objects blob 100 >oid-too-big &&
+	echo_without_newline "much longer" |
+	loose_obj bogus-size/.git/objects blob 3 >oid-too-small
+'
+
+test_expect_success 'streaming blob shorter than its header fails' '
+	test_must_fail git -C bogus-size cat-file blob $(cat oid-too-big) >out 2>err &&
+	test_grep "corrupt loose object" err
+'
+
+test_expect_success 'streaming blob longer than its header fails' '
+	test_must_fail git -C bogus-size cat-file blob $(cat oid-too-small) >out 2>err &&
+	test_grep "corrupt loose object" err
+'
+
 test_done
-- 
2.53.0

