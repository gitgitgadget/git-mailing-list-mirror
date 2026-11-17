Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911886;
	b=19EnX57TEnuY72VCQRkW2ZZa8Egd0Dn55KGGaPSB+IpKj+rfCVavXxKmC8/Vyi/+ZH83
	 bRsUoJ7W39FrKRB8WWgLd9eS+mp4k+U78GVoCrg+WXiQWbj6Usp1rRB4mDg/yhFyf3RyN
	 qcq8jm0l9SRvP13ddRqRQPmFTO8xcX+8SNl3/gQgHNvujyOvICE2lGvKZHZsOVLsIX20W
	 vZ8/AYA0ceMbtKBz9cdriOuqtBBBnkrY1XkNaexjvsdf3rnnjXfYvp+6Jlyh8YbPKefo3
	 Av91KeR3pD0knuMVUkxv5OYCvRS7Mm2okdfRte0HZGjlpDBHEr6XzI8dAXtBfsWk9bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dJCn/EW1JvkN0klvZ2sUkhRIKlLoJkzvoChdRK6V2Vs=;
	b=f4NWJ5mB5jqho54cxTZ8I3iZYPyKkHyaFzZFRpk3HCow/vuGvkt6HvXsyuvM0vutMASQ
	 7IxSIzzp/YxNxhmtx5UuGUMulvSXKkGDqHU14gwCfIp1lgmscrzPHawx3DWocxja7eoMI
	 /F7PSoGSfarqiaihOaSinxlg87GGZxycIp9A8VjNnYHRfIa64csxIfrKxMLukbOPgxxf2
	 HL7Xaz4uym3bgBc/SsUCIV0SBEN1L8MsArWQJ0hxm3NwOQq6sOX94D6cBmZ8zwhQMLNvC
	 d2OTx/LJRy7X9ges0B2+hhXn9np9wPe/OOwibzds4H4JxOpFAo1XLHaCsQj1vyxn2Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vDHCvO2M;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F7F606A339
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 10:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1F7F606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vDHCvO2M
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-491971ac844so3842101f8f.2
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 02:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794911883; x=1795516683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dJCn/EW1JvkN0klvZ2sUkhRIKlLoJkzvoChdRK6V2Vs=;
        b=vDHCvO2MDhsxDDdMfSDgODpkD9swQiP858Yv85u1lUVwW+6RgOV3lmDhi0ohhGhHZN
         tvh2RAIV1uVveUtrnybAG+ijn28jSQYMpsmQQJk6QZVK16F+VvtdEujK2B2y7j5b4eIQ
         G7bHzmsY0UgFM3FxJBxGyb0/t31uCouS9HTXbfgsDy3W4r/q30RxvDhg+9c9B/4lSRa/
         6m7VglQPy4umQ67IkOYHX53oRHoE25cW9wj3/pgTM8fIl1njhfFgA7Ak0t7L+HDzo1k3
         Ko2boKwLLMOg2+aBK+TyG2RDx04rh6VVVJcFZMa60nn7Y9iT9fiRJHZevW+/dOuP5qgh
         xgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794911883; x=1795516683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dJCn/EW1JvkN0klvZ2sUkhRIKlLoJkzvoChdRK6V2Vs=;
        b=swWyx9NiKm8Wt/b8LzsDY97U9MmG8ZvaqB5gIm8KjjHOvvU8vl00mpy+p9AO3Io2mz
         tT6rDsIbDCmjVqE7ZHSB1CtcWdy//uEoMM8BnFyWG94gX5eoPuZezLEz2tU8MAeTnqbM
         VYyWYk1UOkKak+37OE5YQrYjWtDrcYR5W5JtCzm2fthGs7hlZAHatAfkcK6jS7hrhy3+
         76D6YENx2XilGJt1efhjWdUuaepWsS/lYTUscIsI1RPQJcwch6cOIiK+s23Mhp1yn9af
         FCqL3xCuyZu3mXFmDuUrloSKQZNpMZuKUpbMeEmswR38uZgc6aaJ56O/TdljVJhM2uvv
         pXFw==
X-Gm-Message-State: APuU4Z8f2dA5qPa/YuIDWkOGnkTGeS4NdWKQFCo9onQh4RZOrcvtfIzH
	g0mPL6dxe7K2d6IyxocSV+E51virEuJkTIjPmJPKcYgU0sHPmvjaZtbdTXNL0w==
X-Gm-Gg: AZFdTZdsU2FT8qBlOQuwczRtJc7k6ZKLdgoTcr8DC3GWaIY25FgB3ga+ICOFAqVodJI
	iDJBHqdyxtrlHI7YV/dlnjBxGQXt/bLUW1dlYxpC69ACM+09UWHZkA3M4ewNyKtEJp8ej06ms1/
	9S3IA/7urZUt2Y6DkxISwdaAE22s2SOuroDtNHk8akokw7TZJ3SCvIrM3QQEpEuC7S11uqyeDEl
	XskB2flj48pbDDfCyxby1h6Fxzo/I4tmF8s1Qd/n6ntwA8isVSrA5YusOlEUEXr9t8+S2/imsIs
	EcnRMuSayVQcgIFZC7bILm+gDDtJb4pAT2gVlblEg7TpDBo/zMn9uDY7eJesQkbVXBMPtSfxCeT
	nUGT80Si7OWQdm6zv3CFKI2ZC4FaRLuaYfRkGW96USwg2D3odQbKGmiSemibmN8wPXZfijCPRaR
	S2nDkR3nF7FxXFqZD75LhVDAXIqO/SEwroRXivYHonOkqr+zrlY/v4EujXQWssv+PeyrpSxr92/
	Spk2y3d0iHZ7Ul0rOWflwO+rEeCUZwo9iaBhNUPx5Q0ZQj7pNYVKTn97OAFk5VgvYv1DvRhlG2z
	tyw8e0ZbsMc//q+qsqX//HDUEq3r8Chp84YeYPXGZzW0lkIGSoiD7RTTj9X847M=
X-Received: by 2002:a5d:5d88:0:b0:48b:1296:52ec with SMTP id ffacd0b85a97d-49c70ed8eaamr31322890f8f.18.1794911882802;
        Tue, 17 Nov 2026 02:38:02 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c608d10b2sm44715932f8f.44.2026.11.17.02.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 02:38:01 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Neeraj Singh <neerajsi@microsoft.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael Montalbo <mmontalbo@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Alexander Meshcheryakov <alexander.s.m@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 0/4] widen a few sizes and counts that are 32 bits everywhere
Date: Tue, 17 Nov 2026 11:37:52 +0100
Message-ID: <cover.1794909894.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793546752.git.gitter.spiros@gmail.com>
References: <cover.1793546752.git.gitter.spiros@gmail.com>
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

This is v2 of the series that widens a few sizes and line counts held
in 32-bit types even on 64-bit platforms.

Changes since v1:

 - 2/4 is rewritten after Phillip's review [1]. v1 only made the size
   parameter of count_lines() a size_t; as Phillip pointed out, that
   removes the bound that kept the "int" line counter from overflowing.
   The patch now uses size_t for the sizes and line counts along the
   whole complete-rewrite path of "git diff -B". This includes
   emit_rewrite_lines(), which with v1 still truncated the size, so
   that "git diff -B -p" printed a correct hunk header above an empty
   body. It also adds two EXPENSIVE tests to t4022.

 - 4/4 is new. It was found by looking at the totals of "--stat" after
   2/4: they are added up in "int" and overflow past INT_MAX lines,
   which 2/4 makes possible with a single file. The same code also
   showed that scale_linear() overflows for a small file when the graph
   is wide enough; a cheap test in t4052 covers that case.

 - 1/4 and 3/4 are unchanged. As in v1, they need objects of 4GiB or
   more and were verified by simulating the truncation at 16 bits.
   2/4 and 4/4 come with tests instead.

2/4 now also changes count_trailing_blank(), whose size is also
changed by patch 6/6 of my series "loose object size checks and a few
size truncations" [2]. That patch will be dropped from v2 of that
series, so the two series will not conflict.

The series is based on master at 50fe5cc63f (The 12th batch).

[1] https://lore.kernel.org/git/0cb42395-3e62-42e0-bfd3-a4265ed7cc33@gmail.com/
[2] https://lore.kernel.org/git/cover.1793355390.git.gitter.spiros@gmail.com/

Elia Pinto (4):
  csum-file: use size_t for the count passed to hashwrite()
  diff: use size_t for sizes and line counts of complete rewrites
  diffcore-delta: use size_t for the size of the buffer to hash
  diff: use uintmax_t for diffstat totals and graph scaling

 csum-file.c             |  2 +-
 csum-file.h             |  2 +-
 diff.c                  | 90 +++++++++++++++++++++++------------------
 diff.h                  |  2 +-
 diffcore-delta.c        |  2 +-
 t/t4022-diff-rewrite.sh | 51 ++++++++++++++++++++++-
 t/t4052-stat-output.sh  | 10 +++++
 7 files changed, 114 insertions(+), 45 deletions(-)

Range-diff against v1:
1:  07baad46b1 = 1:  07baad46b1 csum-file: use size_t for the count passed to hashwrite()
2:  2011b90d80 < -:  ---------- diff: use size_t for the size passed to count_lines()
-:  ---------- > 2:  e63ed0c49c diff: use size_t for sizes and line counts of complete rewrites
3:  0c5442280c = 3:  3427c3d2c8 diffcore-delta: use size_t for the size of the buffer to hash
-:  ---------- > 4:  692c503e97 diff: use uintmax_t for diffstat totals and graph scaling
-- 
2.53.0

