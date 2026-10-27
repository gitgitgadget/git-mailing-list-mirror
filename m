Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793076686;
	b=OzgdqKbikxctdncHb537EinCtUvuL29TYBK3Q1wLW1bYolcGdX5+2s3ImXGIH+EeYwKo
	 asTKmnSiVjUZ0WuxQpWfVNOmq9OGCR+Bt7RFfwhzedjIE2GhhssyI/TDggEkyozvZA5ZL
	 9PCTYzIblbzkpiFYpJx10TU2iVdVjDpTtYCO9x254/OeBIucDT8m8cRrcJJHHEuP1RfPZ
	 PyWH6lBL3o7+W1aZ5YLeds7x0onhnXLiQDO8GxRquafD3/08H9TPGNYqcQFox1ImHHtEJ
	 RAPy4VkT64CSSev1zoimV7hBjHASuZ9PfS3bHdnFlbOerkaWuZzwznB7kE/wMjNOf5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793076686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=tKw9U+TJSwq0IiqYD/HJ55xyxaRrsN4emYoCAcVCGJg=;
	b=gDZa0XSuPfu3fie+cHHIl4s9HEXx0mHIT9rY2HQ7XMB/xtyrXfl+asYIASQyKv3YUf/X
	 jtIVqjbx0cAxfLqRPbAuKLV2EquLzDMsv7RH5YN5iTvQaGhZAH2t1l6JE4jj7j3LhSAU5
	 Qgk9dIpOf3HnX9pXUGy6FKM6Uo1qB5YSmJz8y7j8sU/XoY+vZPvIvMngPi4EvUbXBmd8R
	 wt6MUIghIi/7eKDAzgd5yDQko/oHA3xGmbFf7jSUJ48giTLok75mFJYVvxGd3pLAGdKit
	 +GPexARcCKztEKLT/kn/yuGaxvYVZA0bVKwQu59b8cfOh32fjlW2Ifl2DBxhKBBDOSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SrO11gNG;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D18606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 04:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45D18606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SrO11gNG
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35829219da8so776736eec.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 21:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793076685; x=1793681485; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tKw9U+TJSwq0IiqYD/HJ55xyxaRrsN4emYoCAcVCGJg=;
        b=SrO11gNGIAwt2ym5Fzt8TbYtZDWczg3Kv/M+fYjYKBJr+fO4e1pMpJ6koyYp35B9MD
         U+6Ihsc4vOHbLglPKXeGUu4+3S+EtSMeVXr4sbaqeoCzNsLo67aRpeL4/OYlOlCA4yES
         mS4PGwLIRQvGFlh+TtEB3n2t1AW3Ds21QUvL1OQLXdrSfZLFZqvnj0Gwi5+oPlnh42Pc
         C9HYSTJCRylY0pwa/mgd7MWQb93yKFuQBFLvYJSE3K+HjckHweji7kkAzRLjuGeigW/i
         CYEIpw1lOD+HdpOauzPQ71+5GccLEUy/O6yeETTk7jVIgQKod4SrnO3clLtWBYIbzoaK
         SxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793076685; x=1793681485;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tKw9U+TJSwq0IiqYD/HJ55xyxaRrsN4emYoCAcVCGJg=;
        b=jwod/6wqP+DpIZC/5+apTa+xqXOXqOss1kqW6/Ea5ymTlS7uSOQMpvZkjZBonAF5Ue
         U56R5eYmlCqh+JwY2cnBJN98wdcRY3x4yfF5oiZWkY3VBs5OaKtSBA6UM6+GmEPJogXn
         ASVTaI6INoEh/4RXOoUoK60akUpZTC0mJhT31JbeOY+8zxrDA70AGNwMuVy9dHyGspea
         f2FVqi+J5nZtZKKODyIJXgQBYDnghXHuP9VQok4cIIo23cVY83BXBO9JYgUm8Mv0CaNy
         PDk6N5M5kuhp37ILQW+2/GcxKUiX3xs3TJfxDjo+xg876NocEDRkVTdO4/yK8EFKvUgs
         V78g==
X-Gm-Message-State: AFq9FYImLa8zANLUQxoFvQzrZznRsp8Ld1VOOpmQGLvrqUnCb9H2gtCV
	aggNmdryWkYoRb02Rs1ljR9xULCcCYstCnRCwquQRlSGxROWaxR6ICiNBumtROkKcmM=
X-Gm-Gg: AYBFou0RpOLjpTMAxyjltOmH2nAJ1KRTyhcjNNP+vrtoLK7JOVMJJE9/qQoijtbwE0B
	GmhX+ezOVtgCAXWScq65B6nCvkyc0YXH+gvSPwPRenFoNsAgnq9CfuUk+FxAvNbn9K1fWcItpBI
	XOxsm1aItef9YDi/E0Ov0dV8b8gM37MwwRC1a+PqwrdARkhdaJAuHSfzLovl1okvk4MF3hxvgaV
	C1pBFjIPLxnmNgk5noDXZDCBFYexJoXhEKVWKwY0sEky/3aL3J6bX69V94xTgMdfJMH7oAXGBqL
	z+CvWN+9TJo/l60NKcknHGWKgl18PL5UGro/QjPzdly0MkjgLnjI1C2AlL76Ud9tD3Ywvb3hhTt
	V/NwsNQzkb3VD9nri8Ytl3ErJ6fETUale3HhBFyfMPqkCEGj8lEDxgTPIvfaixrsoqq9MU+bxos
	vvgjp2/6oZkuiEbcWCsAvw8keEWQBTvauDqBO6JwhwX1dobWk7mPEg49vVrWKGt0OLxlvKXtii0
	m5jHfFXT+049kkOjp4pjB1I+YJz9ZrWBw1srzgONNbQUe4ZVweJLzaM
X-Received: by 2002:a05:693c:6384:20b0:339:851c:4c1 with SMTP id 5a478bee46e88-36a0f887a20mr2051928eec.18.1793076684679;
        Mon, 26 Oct 2026 21:51:24 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.39.88])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ee72c0sm45684188eec.29.2026.10.26.21.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 21:51:23 -0700 (PDT)
Message-Id: <pull.2276.v6.git.1793076683043.gitgitgadget@gmail.com>
In-Reply-To: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
References: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Oct 2026 04:51:23 +0000
Subject: [PATCH v6] diff-delta: use safe integer arithmetic
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Srujith A Poojary <poojarysrujith@gmail.com>,
    Srujith A Poojary <poojarysrujith@gmail.com>

From: Srujith A Poojary <poojarysrujith@gmail.com>

In create_delta_index(), buffer sizes for allocating the delta index
are calculated using arithmetic operations on entries and hsize:

  memsize = sizeof(*hash) * hsize + sizeof(*entry) * entries

To prevent potential size_t wrap-around when computing allocation sizes
on 32-bit systems, replace manual arithmetic with overflow-checked
helpers (st_mult, st_add, st_add3).

For the unpacked index allocation:
- sizeof(struct unpacked_index_entry) is 12 bytes on 32-bit systems,
  which may be padded to 16 bytes depending on compiler alignment rules.
- sizeof(struct index_entry *) is 4 bytes.
- entries is capped by (0xffffffu / RABIN_WINDOW) where RABIN_WINDOW is 16,
  limiting entries to 1,048,575.
- hsize is the smallest power of 2 greater than or equal to entries,
  capped at 1,048,576.

While entries is bounded in current code, using st_mult() and st_add()
guarantees that any unexpected growth in struct sizes or bounds changes
will safely die() on size_t overflow instead of wrapping around.

For the packed index allocation:
- (hsize + 1) is passed to st_mult(), which is evaluated as an argument
  inside st_add3(), and is safe from overflow because hsize is capped at
  1,048,576 early in the function.

Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
---
    [Outreachy PATCH] diff-delta: use safe integer arithmetic

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2276%2Fpoojarysrujith%2Fc-refactor-target-name-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2276/poojarysrujith/c-refactor-target-name-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/2276

Range-diff vs v5:

 1:  23fcfd3227 ! 1:  b91a1ed54b diff-delta: use safe integer arithmetic
     @@ Commit message
          will safely die() on size_t overflow instead of wrapping around.
      
          For the packed index allocation:
     -    - Passing (hsize + 1) as an argument to st_add3() is safe from overflow
     -      because hsize is capped at 1,048,576 early in the function.
     +    - (hsize + 1) is passed to st_mult(), which is evaluated as an argument
     +      inside st_add3(), and is safe from overflow because hsize is capped at
     +      1,048,576 early in the function.
      
          Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
      


 diff-delta.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/diff-delta.c b/diff-delta.c
index 7cbedeb507..efebce3aca 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -162,8 +162,8 @@ struct delta_index * create_delta_index(const void *buf, size_t bufsize)
 	hmask = hsize - 1;
 
 	/* allocate lookup index */
-	memsize = sizeof(*hash) * hsize +
-		  sizeof(*entry) * entries;
+	memsize = st_add(st_mult(sizeof(*hash), hsize),
+			 st_mult(sizeof(*entry), entries));
 	mem = malloc(memsize);
 	if (!mem)
 		return NULL;
@@ -258,9 +258,9 @@ struct delta_index * create_delta_index(const void *buf, size_t bufsize)
 	 * Now create the packed index in array form
 	 * rather than linked lists.
 	 */
-	memsize = sizeof(*index)
-		+ sizeof(*packed_hash) * (hsize+1)
-		+ sizeof(*packed_entry) * entries;
+	memsize = st_add3(sizeof(*index),
+			  st_mult(sizeof(*packed_hash), hsize + 1),
+			  st_mult(sizeof(*packed_entry), entries));
 	mem = malloc(memsize);
 	if (!mem) {
 		free(hash);

base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
-- 
gitgitgadget
