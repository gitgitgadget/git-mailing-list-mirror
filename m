Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356126;
	b=q/3XOcAaW1EcIhH0dgr+XlZX3m3kQgN/vrEc1/WeQHtZzrmng24vyvRNfGSN6/mz3ZUN
	 FbFgFOO1gd+WoFFYTBPUyNw6C4YbTMuU3+qy9gTr54cOuxfIJyfcptoW+G9xUgp2H5DkN
	 wI0+6JHHX9qps12Zxd2nSxF2XeUEEZC53Vm6ZKbpadn7J93iBK2FvOtrzNJqCz5MN2LOm
	 9sh3A1AlMIq47O1fBgEt4ZyLS3CkPv++WKoflzga5gHQyCESG3w1jGH9bZiECuk98ki1q
	 1sMVJ1k5Q0eZ5DSxSDOKxm9KPmoC0r28Y/YmR9lpLPUkL78cFza5JDE0LzHZdr6CoJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6CeQAkcFtoqNkZTQthsBLVGPDAQJ7T3G1jOmWZStZjs=;
	b=h46o5ZMxwKFsq437K9X7z0fS6kZcp5x0nau/xrCOjuO0B45crh2iUkwXRO+Vxv56jKZf
	 4hstrx+Mw8bHlVT9E8u4M/F3XygcpH0mPM0O2oRnPuUkN6Wl7hmJjubX363a3SakSjM9R
	 SJ83md0fwLwJsWdgbH73ULQoZqdwf1ZjBgDDcYbbVyWi0oWHtYz+seEarLC6zRCbOAoP0
	 N1LLgGfVw4Au+g6/UubNkmH2xi58pjZW3SR4URrQkzadBWHv2eb/DfvC/d4jk8E60Wl4c
	 J9fq/H5M8269hUpi0n4NXbeK06MUhxUOIuNeI6R2q9jn4bIuLdQ1TdeicbF4mU4WFLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CbsmeIdY;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA1460A2602
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FA1460A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CbsmeIdY
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso4353475e9.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 03:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793356125; x=1793960925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6CeQAkcFtoqNkZTQthsBLVGPDAQJ7T3G1jOmWZStZjs=;
        b=CbsmeIdYMr5LxRT43szcCc6V0KOnnt3J7Muw1DNiLU+Hby5/dmH0VcS90NpvoNLO2V
         GXU5J2M9HNsypm+Ct4Sl6hrigcfptBOQeuOYmLmWQ8rB4fvg5S+WDgk1G+utap2fNdjy
         4LkGSz8LjpS9Nmku/Gpe3VltL2wulRiUs6YM1OE84r2TbTkKmX37JLGW8eP8s2l4hEZ8
         vpYDlllaAXu/Du5q35S/XwlCPv3a26JUcGx2LDsaMx08/3dOIHH+d76JMZsveq/3tWC2
         MGuVQlxPZ0G7zgRWtYH/QnKhd3a3jV8exo1unsZkGPWhVqGVzAfyb0iSh9EFoee10Szq
         CrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793356125; x=1793960925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6CeQAkcFtoqNkZTQthsBLVGPDAQJ7T3G1jOmWZStZjs=;
        b=jv8BMjXwQToK98qnHPKdXbRvLcCZEHpRbF5KGPCdz2UYbppsECdnf+w8c0IEiQJJtk
         A+9zdJPnEILopGOhTkusa/V0+Ra4B/eLQ4T5ConE6hb7y+qDeg4BWEjjhgaYZS54TDRA
         Pp7X+idEaN5wScyvz4n7IruAWjN0vCFAKGKTELHkR3itRiMl9hQTqWOGb9eTD/TrbMHh
         +wgVjA1KtrYz2yUWV3toUooKoKX/g5gKj706qfiyZCLL8epBwd9r+K41wp6TMLiMqzOV
         ffTHHH+zZFU2CjtkpfFg1WAtEwX8Zz3xxAf6TwJhX6RzMeBw4xOX1QdYLB01C+3i+yKu
         m8rw==
X-Gm-Message-State: AFq9FYJQcOEcBQZJaLkvdj3DM00C35pQauPxVFuAlUFdrfkueEuomhh0
	OCYLXF8vjqCuqcLsQ/gi6cH44g51gz8SmkbkcH3YIxUebN04nODARBgdOiP5hg==
X-Gm-Gg: AYBFou3Zzf+3GTz3GBIvlwcXo8q5VMtj+OYQa1MLKqcGPcrOaPnMnPHrG5EGgz907f7
	5ImcabxtKifULNLJf81AFDA8ZXyQ3H80FPllxGeis9Zk5tdStSJ6tsZ5dPDOXxWS8ZlD0b3rq94
	FjSOZE4JccQR7vs68k8fgzOp7r3QiTv2LX65RNuUKA6rArLX62jGvw+0IB1YCf9ETa4QnIDR4+t
	g/91zPbPxclZABdeB8Rd6AL7+pqmerdDygS7k4VAWZWWqdNvweXEwEpkP8GfLB+llIOsxyULwYi
	FU6+0B5WElQCYkp24hfTCdC7DzEX6DGwqLDptUexNmH3Wze2TFfZ3TSiEHMxvuKvwt7QMeIGiAn
	Rx1r8AJ0AdqdWVQz4eNHTFX3DpAit1GNZ3za1boXkOrUiMVCADFvebT0qOyPdElvAcPvOligHRC
	oRkJ99HqzN6X8nr04PuzQpuFyT+bq7tMO+DBRnXdhvcy0teZnt8XtXXw36h+SsvkxQRL3wnbxyi
	IluOoNzv2TYJXlkOvz6GsHj02bciYNevC/Ejez9vSZvHfxOA5SwCSE0OEg8rsAerSoKhSCFOPdW
	JmH5NHa8BcWT2u1Seg4VSNnTjJA6jstdblgXIbmmoVDRsiq0dA==
X-Received: by 2002:a05:600c:c48e:b0:4a1:f7f4:7cf1 with SMTP id 5b1f17b1804b1-4ac16bc47f8mr39244555e9.11.1793356124765;
        Fri, 30 Oct 2026 03:28:44 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([205.147.30.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b964desm2449445f8f.46.2026.10.30.03.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:28:44 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Toon Claes <toon@iotcl.com>,
	Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Jonathan Tan <jonathantanmy@fastmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH 0/6] loose object size checks and a few size truncations
Date: Fri, 30 Oct 2026 11:28:33 +0100
Message-ID: <cover.1793355390.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
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

These patches come from the same search for truncated sizes on LLP64
(64-bit Windows, where "long" is 32 bits but size_t is 64 bits) as the
"use size_t for a few more object and buffer sizes" series:

  https://lore.kernel.org/git/cover.1793352943.git.gitter.spiros@gmail.com/

Its cover letter explains the method (a MinGW cross build and
clang-tidy with -Wshorten-64-to-32). For these I followed each value
back to where it comes from and forward to where it is used, because
they can lead to out-of-bounds memory accesses. For that reason I sent
all of them but 3/6 to the git-security list first; they do not
consider them security issues, so here they are. While checking the
loose object reader I also found two missing size checks that have
nothing to do with LLP64 (1/6 and 3/6).

 1/6 A loose object whose zlib stream is shorter than the size in its
     header is accepted, and the uninitialized tail of the buffer is
     handed out as object content (all platforms; e.g. "git cat-file
     commit" prints heap memory). A longer stream is silently cut.

 2/6 On Windows the size from the loose object header is truncated, so
     the caller gets a buffer much smaller than the size it is told,
     and reads beyond its end.

 3/6 The same check as 1/6 for the streaming reader of loose objects,
     which today streams out a short or long object without an error.

 4/6 "git cat-file --batch" writes memory past the end of objects
     between 2GiB and 4GiB (all platforms; non-blob objects, or blobs
     with --filters/--textconv).

 5/6 On Windows, concatenating notes that add up to 4GiB or more
     overflows a heap buffer.

 6/6 On Windows, diffing a 2-4GiB file as text reads one byte before
     its buffer.

1/6 and 3/6 come with tests, which are cheap, and fail without the
fix. The others would need objects of several GiB (and 2/6, 5/6 and
6/6 a 32-bit "long"), so their commit messages describe how to
reproduce them instead. I have not run anything on Windows: the
Windows-only issues are based on reading the code and on the
cross-compiled build.

5/6 passes the combined size to odb_write_object() through
cast_size_t_to_ulong(), as the length parameter is still an "unsigned
long" on master. With 1/4 of the series above, which makes it a
size_t, the cast becomes unnecessary but harmless; the two series do
not conflict.

The series is based on master (b9e5cff180).

Elia Pinto (6):
  object-file: check size of inflated loose object against its header
  object-file: use size_t for loose object sizes
  odb/source-loose: check object size when streaming loose objects
  cat-file: use size_t for the length passed to batch_write()
  notes: avoid truncating the size of concatenated notes
  diff: use size_t in count_trailing_blank()

 builtin/cat-file.c           |  2 +-
 diff.c                       |  2 +-
 notes.c                      |  7 +++----
 object-file.c                | 29 ++++++++++++++++++-----------
 object-file.h                |  6 +++---
 odb/source-loose.c           | 22 ++++++++++++++++++----
 t/lib-loose.sh               |  5 ++++-
 t/t1006-cat-file.sh          | 18 ++++++++++++++++++
 t/t1060-object-corruption.sh | 28 ++++++++++++++++++++++++++++
 9 files changed, 94 insertions(+), 25 deletions(-)


base-commit: b9e5cff1803ab24582201ef059516eb16014b9d9
-- 
2.53.0

