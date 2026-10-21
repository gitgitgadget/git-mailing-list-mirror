Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792577809;
	b=1NTRWEMuYDM1Kf4qd5mZmJlf9n4vMAXEpxjwwJligg118yMyxU7U7XkGtKAhg/0YGy7W
	 m4IYm2ul77v7SJRh3t7YCeyV1Pid3V0aRDYUMHwc/yFVrCHi/7a/2cTuS3QLRphxGHrEl
	 67U2BKhYDzALRuQ0e5T4mwn5XotkjJ0L+5M/jZ8cDIxH0Sj+Z6/c0nnQuWbwt9Z8yK5Ci
	 feCYa2g0TmxOq4NC07n6KFCOG/olvdGSj8pjW8i27yYbPyLLREeNECr0lqyZWEaSyeM3f
	 jy8GG7LSC6Z4+wSRtgfIdxgWyxbXXHdPybZekvbhSvckK8Tnz8+JHLsoIHOkZ8fth8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792577809;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dPkKzaHYkJhh6wa7QFoKyPu7Q3qgqtI2wNOLP5sPG0o=;
	b=s2dDtPuXrve+3WA9tjRERlt6+Ct0BM0hpSHf6YFmiB7ayajWd3Liu9gfiT3+fspwoy6l
	 Hs5LHZbnLdn4dE69qMGWq6AvcGaJcHE0fkcbiipPHk7EKBP1KctBdr3waNXiibcLVxRtW
	 0azNf1L33iB9CYX7daWwDWwvLUpY4sNLReeKx6pMDt4cXVuHcN88iBUuKRNeiv3NZM5kq
	 LSS50gEDw/vchhREoQQE4wGJ6DBqfiYodMBJCTDCfH3nhBTQ7089u+OsP+iSxqgfoNdf/
	 dE3mPIEfQG+Ayk5tORMeD+0RaCJ3hpZ2UT8l0THkudo2Onixk0yNSs7+KkjvSTrOx2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="TPL685a/";
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4D3606A32A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 10:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C4D3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TPL685a/
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c40e30c26a4so241286666b.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 03:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792577807; x=1793182607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dPkKzaHYkJhh6wa7QFoKyPu7Q3qgqtI2wNOLP5sPG0o=;
        b=TPL685a/aekNmDyz48qHk1E6/YIbX4gf+HI5qG2OkZa8842K5q1xT+Hr+gEXOG2CAS
         idFpAWQHJmPB6inxlLWNmeveMSOUA62FsFdlmZxqRmTjcogrnCfRzGKZ2TGbtDZluJP9
         Yg+BFXO1HkDUa4Jf3f9spRCzxwpjzGRAllfbJRgXqpQzfY3SHPzABC4qk7AAJahitj6d
         1fMN2ygEaTjT/b2Q8Gi09Mvp7a3j3TPq26r//SOMq4fHlg+lK4KZRB5+nLBWjotEkDN4
         jTHEdl1lG651NmD0KQ3oVC+t/3DdbZFMCS6lvbMJjy4mpZ+eAVDzO9iH41QIh38QVEjT
         fklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792577807; x=1793182607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dPkKzaHYkJhh6wa7QFoKyPu7Q3qgqtI2wNOLP5sPG0o=;
        b=EmJx4MUa7oVvr/cj40w3349IpLY7TsZGSE8sdv7mq6R+9kayqOvogu9wYsgx5lNr1A
         SFbl43gjqTU539Q1Ocs3VZs49PjUkPSFZjAscLZosikskknc4+gPwdBBkjTVwrL4YSlE
         g0yqN7ot/6zAtWMKis/rPSWAcJlGFJ+iaFhQrr3rhrq8YZVILjarBdTqE3kxHTZxP9H8
         Bgv5YkbicGCOyjktb31uaoSjocUS2NEUS2L7/fKuFRUnVb/7tnV+63RANauJFYlthU9/
         3dnqPM4gBYoMnittfN22obp91HD0pT+rfCypIBNuo1Cpk9UMnx17gsycEn+7Qd89fXWx
         OLFA==
X-Gm-Message-State: AFq9FYLFyBQELT2mj/jqMwrQR6H6m9xp32aVGYqg2Z/yIY+LKgkLMAd2
	02QnlqyQP90zUrp0JzyferKSWqGoZRr0z0ra6q+Gf0Tx30+JI9yRYIpi5Nq2kmWI
X-Gm-Gg: AYBFou1C8fz38mX+T+r/ix/foRWhgbYEZUKdt5FrqLKgcSkHPC5Nr9XrjjqafMgmxf4
	7m4j+aYzbxX92OSzGcpTgC3T3jt9OifOKCbnCVjj2zXxwuwKzq0pa4/7TADtiIkLluB9zb07qjx
	mhftU/P6ZGOmxSlVQQ7kuagxT8F+DawLv67uRmqEJO5ZyMHZkQpW5wQ3vch7AUjZwNBw3M/Ygfq
	Jrv1+jx2SRKcl19iIUIiJujkP6JYLI3aMqhAQA5BF1rdyDBxXC2sncVwclfbwo1eFfKj3GorDIg
	ZA85yeWOO59cTdPPmSQilT3GTAp31iLDbbbpciLUNJNlOpiC3sEySqZyEfOY1RFkXbYofR9MrPu
	IXwcx/F1Ql7BRoyMBwGXMqCbqlIh4xMGIXl2GEqUapAkOf4iZHXslm1ddIkRjFKFHM9MJ3u+TnM
	7MMR8euFk/qHxK/4EBEkurLc2RfVOyMc69KCe4xD01cIgl4T/Op5Z958wlCMdExQaH/8qQXSb1W
	zvaDshqvAKF1qGcNxB3wqgpAAp73suPDCSIRHiNmLuU5C6FzTbjQItFA9fTvNGezVQUzv0mciPB
	cpuygzVCH+g=
X-Received: by 2002:a17:907:9687:b0:c29:519b:3aee with SMTP id a640c23a62f3a-c4607289492mr397061766b.33.1792577807350;
        Wed, 21 Oct 2026 03:16:47 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.28.1.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e258427cesm4472602f8f.52.2026.10.21.03.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:16:47 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] diff: use size_t for the allocation size of word-diff buffers
Date: Wed, 21 Oct 2026 12:16:38 +0200
Message-ID: <20261021101640.329990-3-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021101640.329990-1-gitter.spiros@gmail.com>
References: <20261021101640.329990-1-gitter.spiros@gmail.com>
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

Since 3c7a31204f (xdiff: use size_t for buffer sizes, 2026-09-30) the
size of an mmfile_t is a size_t, but the word-diff code still grows
these buffers with ALLOC_GROW() using an "unsigned long" (in struct
diff_words_buffer) or a "long" (in diff_words_fill()) for the allocated
size.

On platforms where "long" is 32 bits wide this is not just cosmetic.
diff_words_fill() writes every word followed by a newline, so its
output can be up to twice as large as its input, which is limited by
MAX_XDIFF_SIZE to just under 1GiB. alloc_nr() computes (alloc + 16) * 3
in the type of "alloc", which overflows a signed 32-bit "long" as soon
as the buffer grows past about 700MiB. The result is undefined behavior,
in practice a negative size that REALLOC_ARRAY() turns into a huge
allocation request and a die().

The buffer in diff_words_append() is bounded by MAX_XDIFF_SIZE, so
there it is only a matter of consistency, but if that limit ever went
away, ALLOC_GROW() would truncate the requested size, and the memcpy()
right after it would overflow the buffer.

Use size_t for both.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index b4ac17f8ef..9483931c05 100644
--- a/diff.c
+++ b/diff.c
@@ -1959,7 +1959,7 @@ static void emit_rewrite_diff(const char *name_a,
 
 struct diff_words_buffer {
 	mmfile_t text;
-	unsigned long alloc;
+	size_t alloc;
 	struct diff_words_orig {
 		const char *begin, *end;
 	} *orig;
@@ -2192,7 +2192,7 @@ static void diff_words_fill(struct diff_words_buffer *buffer, mmfile_t *out,
 		regex_t *word_regex)
 {
 	int i, j;
-	long alloc = 0;
+	size_t alloc = 0;
 
 	out->size = 0;
 	out->ptr = NULL;
-- 
2.53.0

