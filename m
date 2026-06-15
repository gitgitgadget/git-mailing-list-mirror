Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4202F7F0F
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 11:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781524357; cv=none; b=PBw6go71T/SGi576RIAWakjr2CvImAVMgB5nvLYcwUPctxSsA9lNLfeBZ2eOoLhhWj4lYkujRL/j9DaeInPAepwMrtTXXVgrmJ+D2ckYvKYqOj/FTsPgy4qdFLtTgRzw7yrbmRmdPzpLD9840glddZQxXtZpwKyZzcP4sYZ6THI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781524357; c=relaxed/simple;
	bh=FellPyu2qHWjOzwVCILppFtJCOZDSUQMHt2bh7/OEog=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=vCKhjPzyvxLY8I4xZ+ntOsvme/b0hYagLbWOMt9ia60uUc4+0A1tVPM9xF6zCgUWb42R6JD9kYpq2TwH5+FVqkRpXvhb7rvpYcw4r+fdTmkpg0Qt3BeqfjmLhwkH7RuDXzslWAZrPHjpWg4dJzddWbEph+7DEspWOcyK4/153nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMKbO2Fj; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMKbO2Fj"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8ce9df49c5fso52808566d6.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 04:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781524356; x=1782129156; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cr6Jivse7VHkoXrhZ8y5dvbNMUphuMsD6uY2aUsTmWo=;
        b=KMKbO2FjTzlCZ+4Vuq579u2yZRGulCqC3yERX0cCefTa+jCNrzHBIsZSZC6Xji977M
         6qTpq+wbdl8fwb6KpAYAPfQqNVZeUrqVHYyaxm/yyWkFWNd7fG4CtQnVaFDIxW2WK5Xy
         3UyEyq8ZoMS099+s8TVltaF/YoRhB6aGKIpOSkblGWCxpr/PoVTwucoEO1WKKBv/Qg56
         kpt+Kr6fOif4ZXjwlGtnlCbGao72BOxEmrz5a+k2hWy9eT9UsccJCug4HBmBrusY5Caf
         QQGi489somt2zh5dut34sxS7xC6KJRkLxZ0ZszYQaZAErhnUZu+YUEeHyCrXnKnmijZt
         oi3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781524356; x=1782129156;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cr6Jivse7VHkoXrhZ8y5dvbNMUphuMsD6uY2aUsTmWo=;
        b=GqQuCV2VU2zBBlJrbcQf+VBorg1lKcpql2J4K6Wn/Hnbwfk4o9c2WES9LLUmGvbOIw
         colxj4LyNiiw44HHz29CVgMP3+Sk5012rhPNFYlstMJ6UeekR7h6flG2mxEc+T4/4OT5
         FDbmxhFwa6mcVZBEgMHQZqR9R1nj4Elw4Aa8rVOyVQm1zAgdklqIMk3LfBhBRy2HQwxN
         WF63hq0GNsRzvUtOE4jW7g8DsZ1VLyLrf37fbRE07Ta6b8lRYxvH640LVyr4rpVGpF2p
         ASi3CDM9j8YL6q3OLhrc4LMriYFnznELYpeDtI0ySE1fR2GHD3COh9ALbvBC7SfN8Cxh
         xCuw==
X-Gm-Message-State: AOJu0YycWh9gZtJFtbd94WxhWFSq7usmxm4Nm8bomikSCAfAfNhcd0AB
	SSSxUGqR119x5Sq6DTczIodRQs5jN8RSrM2GdOmTcGlcsXJVdxHeXQXijvRYOw==
X-Gm-Gg: Acq92OHbVyByA1dw0BtY8bK6LWOAP/H2XSlqnvWnv7wpJuM82crWNBaGYYHdSUX8j4t
	jc86cXPC3EiGZ53zSYZ/4gMUP1hb84L/dCN43n17u5MN9KMtQ/6UXvJp4u8I6ku3ilglQ5XxjV+
	fi6nJEpyHrD0Bn4n84lsVG+sZqX+wOCLvQJ+y918LACWrAjGpANfH3b7ygu6Qpa0a8jH7SeTrz7
	Tx/0a8/EXHqwoZ00NQmUiIKFm3qjiGxc7mKxCbjc4wPVRrX/oiaPHdjqFsg8/xV3PRkBh32lI19
	7dTBocrCeRV/9cmtnD4iKcHPZaYBLWJuO8dzsfGgXdGw6BG+t9UyQ+EE7MaM69gWKXzVCyKetmT
	PtXftNm+tcEa9nGrPDtSU9zrlC+NYblbJacU4JKAznwj4jRdb0TaHerVHjM7jvUE7p8MNsP+h1a
	zaBtuAhrlCsOHsfLjD00jp+QE5vZg=
X-Received: by 2002:a05:6214:f0a:b0:8a5:104b:e37b with SMTP id 6a1803df08f44-8d4502aed80mr178250316d6.42.1781524355475;
        Mon, 15 Jun 2026 04:52:35 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.143.211])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d304577d69sm110166546d6.29.2026.06.15.04.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 04:52:34 -0700 (PDT)
Message-Id: <271a5299e30cc85ea59c2d0b806a5677576de764.1781524349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2137.v2.git.1781524349.gitgitgadget@gmail.com>
References: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
	<pull.2137.v2.git.1781524349.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Jun 2026 11:52:25 +0000
Subject: [PATCH v2 3/7] pack-objects(check_pack_inflate()): use size_t instead
 of unsigned long
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

`write_reuse_object()` learned to track its packed-object size as
`size_t` in 606c192380 (odb, packfile: use size_t for streaming
object sizes, 2026-05-08), but the comparison sink it feeds,
`check_pack_inflate()`, still takes the expected decompressed size
as `unsigned long`. The call site bridges the mismatch with
`cast_size_t_to_ulong()`, which on Windows turns a >4 GiB object
into an immediate die().

That function only uses `expect` once: as the right-hand side of a
`stream.total_out == expect` equality test against zlib's counter.
zlib's own `total_out` counter is `uLong` and is therefore still
32-bit-bound on Windows. Widening `expect` to `size_t` cannot fix that,
but it is a strict improvement nonetheless: instead of dying outright,
an oversized object now simply makes the equality fail and lets
`write_reuse_object()` fall back to `write_no_reuse_object()`, which
decompresses and re-deflates the content (and which the larger
pack-objects widening series targets separately).

Drop the `cast_size_t_to_ulong()` shim at the call site now that
the receiving parameter speaks the same type as `entry_size`.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pack-objects.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 50675481e1..56d1bb498d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -453,7 +453,7 @@ static int check_pack_inflate(struct packed_git *p,
 		struct pack_window **w_curs,
 		off_t offset,
 		off_t len,
-		unsigned long expect)
+		size_t expect)
 {
 	git_zstream stream;
 	unsigned char fakebuf[4096], *in;
@@ -671,8 +671,7 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 	datalen -= entry->in_pack_header_size;
 
 	if (!pack_to_stdout && p->index_version == 1 &&
-	    check_pack_inflate(p, &w_curs, offset, datalen,
-			       cast_size_t_to_ulong(entry_size))) {
+	    check_pack_inflate(p, &w_curs, offset, datalen, entry_size)) {
 		error(_("corrupt packed object for %s"),
 		      oid_to_hex(&entry->idx.oid));
 		unuse_pack(&w_curs);
-- 
gitgitgadget

