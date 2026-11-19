Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795069331;
	b=Jnea4sMfbqE6pupX8cTPAtzdgjLDNwHGXq+fNbBbndLKVp7psdmpkqjUJlgOPOpavmhx
	 B9o233vkPVu93qYrYhC6uttQtD1owUM03lbz9nTwFWLcnlgA/oR/8gmXSkNBnb/PjPg2b
	 IqVKhNSm58G7raO/dwLDfzs3vZIGp3QL3DvpjPwC/KaCAqpcZH659DKDLvup+l/UhdROW
	 wZafZ5YcdMkvzV2J8+8gHV2QpiUNrcrJIJjAWTEfvdaPbKb8d4yjWX9d8D9x8CZ8QIghP
	 fZvvwWDHAuHXU1BQ3d+lFN7lh/VaKhBdn15gAs309fgL/5NzoCBvIiWA4ZNXz39QbGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069331;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6p/KCR4rb1GFsxJI0EHfV9Qg6VI0JNHZ0kka/fEW9w0=;
	b=LNTn6jV6DId8vzZWKYCDXSUAkd9X3odHZuMkd9aJqFJq20lPkb3RNmsJNJGxP19v7wZ7
	 C+iqRUydJnQVp25w+sh3M4wT9l0GFrwTDKvbguojLVL45c3YEt+87inTAoLDu/knCJlyq
	 hCrFHPbIsC+6gvVebr+ZR3Y11XXKVYkV7eb8vLUCyv44e9n1JPSQaRGxdeLz5mdlVctag
	 uGRI/e8+2F0HP15SWQpIY3ion0hj0QE6OcRaQMpR2cieSvh5qn00Kt9zybMuKlVRQQDYg
	 nTpBXO8Di3kdbuQxDirZq5H5YdIEkQTLJpXLi9C86fXbRoYDJ2OgIG0tKVhgnqQjf3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gjkMyGSW;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0CF60A2617
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC0CF60A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gjkMyGSW
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so1150406f8f.3
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 22:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795069329; x=1795674129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6p/KCR4rb1GFsxJI0EHfV9Qg6VI0JNHZ0kka/fEW9w0=;
        b=gjkMyGSWFnhU1OkuUGfWhW8oT1NFJuHgs3WKe8r48pvRiLZT6+ZR4tgu+Kp2ZhDj0I
         lLYS231nQrxp1UgMsX+sZ5+8Fog+enOUXIIG7BUQdZ4menwSWQ8xhWFhYf41QcAUyT1F
         RocUe0ZsI06Op4S1lr3IhNF/a3LJdhZGUGdK/w5nD2emHgn+LN3C/zr7a6CNUiYX3mwO
         feiBwERHaFpI3I18TUuQ8NJLyQ07rdbjyI4kUHAoHu4a0kd37dw3W+H8yWmhHV9wDoMT
         +BhpqkPm0RwBoPx0Ar5NF6F8gLIaHmU0wkYtsJ7xOUbrjZglaj+Exmn8w1HLQC9KfQVD
         /hJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795069329; x=1795674129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6p/KCR4rb1GFsxJI0EHfV9Qg6VI0JNHZ0kka/fEW9w0=;
        b=yoOdl4i6phcRyV6vD0PfSUfBdhs9boOaGYNWX1kcJqTQNuQ6jHMtL2uOnMa5AX6A7Q
         8y/LBunErg8m/b3iBgAsHc2rV4096BYOymqUMhul3iiWBKJeEbJVctupJoJhH+zS9lO0
         iQ0Jweam7XvA8REqtJ5pkXZFV4UIWjkhdkdUpW++sl/zl06EXSieWp3C8t17fhNubWvi
         rdFwgvHbvwBJADKAhcfFopY7j7tEfvCxPwDZ1DVW0cWHAHboIe8BOOOePKUWiXe8+29S
         xcFnIGldDfLHU/XDu68SlBbDIJ+2ac3ZfZcNIf5n5vKyO0X4Ssd0R/mzYclfpcjyOn0R
         dDYg==
X-Gm-Message-State: APuU4Z/UW9zy/kd6lfNk1YCP0OjSHM4P+t5zyGnRDqtnb2X1z59B0CXX
	4/tVqAnoEmmhdc/In8wo0ec52dRarPXtyzu2hqgdzNTafSgwh94fD/m9F/UtiQ==
X-Gm-Gg: AZFdTZcYjYtp/1UD4T7p/C3Zv6X6jb+qOl0fcHSHtE/gtdVt59P6A4R0JbOdLUuc+C7
	vFeoWiunpvRxPC8CRxGby2QR/5TRdw/JDpKbvlDy6rJ8JzVWmsWXBOQtj8cr0GWoJu0Xnpt+1Ls
	v1vcGwnpNzwnC5XUTRJUedpsZJIQVLEbs46e8vzn+OCMUxUfiJ1OxR/69DvvUKWylfpVcDa9KmO
	r9H3dXpaSacOAhB2mmQ8HuXoSy/YbC4ARigvEJgaXusYaxPnUNyCFif/V+dv4lJgyNpMd0sRaX3
	TNfk/FpCR46QcSsO1SI+eNw3PBKF21oc5ENc/2xKvkS3b414KTouv6QznbQqYnixCeB+wHZbLjE
	Qvs7vgZp1RSZKU5Xxe2oKyojQs/hDrU82A/YCsdqBY63DrsaOHN6u8w5xyG86sI5fNhDYNN726H
	/36sw+pbWfBATqOSVWoVD6KT4WDCCZgHZlNQp6gaG7yCMNqVLYvUJPEzOrCGQb/wdimmpK0GEyR
	Q3GeBxGKTSRMmKLhx5NtadFVZgo7lNqP08Qjnf0jpugM49KOuC+JVJwFNlEsoaISvuCBU7luSoK
	TBvQxHEW4uqVlYmeCJvYn2BCiRsQavs21t4PEjWZFLKgA/uZpje1bPkcrc9trOI=
X-Received: by 2002:a05:6000:1a8d:b0:48e:d36:77 with SMTP id ffacd0b85a97d-4a633a63e82mr10820024f8f.4.1795069329102;
        Wed, 18 Nov 2026 22:22:09 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c406sm8508413f8f.14.2026.11.18.22.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 22:22:08 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/5] odb/source-loose: check object size when streaming loose objects
Date: Thu, 19 Nov 2026 07:21:48 +0100
Message-ID: <c694d3e128bab9e7f2875d2d6fe5563de12c5615.1795069177.git.gitter.spiros@gmail.com>
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

read_istream_loose() streams a loose object until zlib reports the end
of the stream, but never compares the number of bytes with the size in
the object header. "git cat-file blob" on an object whose stream is
shorter or longer than its header claims thus exits with 0, writing a
different number of bytes than "git cat-file -s" reports.

Count the bytes handed out and fail the read if they do not match once
the stream ends. Like the other errors in this function, this returns
-1 silently and leaves the message to the caller, e.g. "unable to
stream <oid> to stdout" from cat-file.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 odb/source-loose.c  | 11 +++++++++++
 t/t1006-cat-file.sh | 18 ++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/odb/source-loose.c b/odb/source-loose.c
index d77e93e7c4..a294fb16ab 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -289,6 +289,7 @@ struct odb_loose_read_stream {
 	char hdr[32];
 	int hdr_avail;
 	int hdr_used;
+	size_t total_read;
 };
 
 static ssize_t read_istream_loose(struct odb_stream *_st, char *buf, size_t sz)
@@ -326,6 +327,15 @@ static ssize_t read_istream_loose(struct odb_stream *_st, char *buf, size_t sz)
 
 		if (status == Z_STREAM_END) {
 			git_inflate_end(&st->z);
+			/*
+			 * The object must be exactly as large as its
+			 * header claims; like the other errors below,
+			 * this is reported by our caller.
+			 */
+			if (st->total_read + total_read != st->base.size) {
+				st->z_state = ODB_LOOSE_READ_STREAM_ERROR;
+				return -1;
+			}
 			st->z_state = ODB_LOOSE_READ_STREAM_DONE;
 			break;
 		}
@@ -335,6 +345,7 @@ static ssize_t read_istream_loose(struct odb_stream *_st, char *buf, size_t sz)
 			return -1;
 		}
 	}
+	st->total_read += total_read;
 	return total_read;
 }
 
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index f2b24dd278..cfc0905292 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -1513,4 +1513,22 @@ test_expect_success PIPE 'concurrently written alternates are loaded' '
 	)
 '
 
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
+	test_grep "unable to stream" err
+'
+
+test_expect_success 'streaming blob longer than its header fails' '
+	test_must_fail git -C bogus-size cat-file blob $(cat oid-too-small) >out 2>err &&
+	test_grep "unable to stream" err
+'
+
 test_done
-- 
2.53.0

