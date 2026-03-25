Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D24138BF60
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 23:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774482711; cv=none; b=u+BqwX3a0fWpBFmf2Mjs8qlLLianQnWaqOfRFMq1ltG9cM8AqtlzKArj/cLOVGKwd7OvlXkI6bxrzYWSxvVSLYq/JsyzQmPHvoFvlqgEUSn+ZO7+bAUVGRNvLb+lvaVGVcdtclv/PJvUwmBWQ4hjm93qFGTHJxuBvgURTq9KKLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774482711; c=relaxed/simple;
	bh=PHqN8/MIHho5FXixGxPh6nqSh7uPvRwYRAwpszXPvMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHP5FTIs9tHRbOWfJSqnLRXww2AemLUMauL173tlxj2ZpZadHGPiWXd0muqyRoY1C+ZkiLxWOKo84mVstsDmKJ2igJ2UL/QVrn8f1doQpj0dHjUX24McFZiiovSeO9idZL1vZ1DzsV5ZQ4DP9UP5h5mVugnN7F+6GYxk+iVx3Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=UR7Bjw3Q; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="UR7Bjw3Q"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79a3ba1653fso4136677b3.3
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 16:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774482709; x=1775087509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4LOPJBC1loXl6lpooiFMMY+xwUPwa0VHRxGE1cqP0qI=;
        b=UR7Bjw3Q+Rdg5wta7YE/eL9edOacsHZHChCTQQdWtufE2YMYZzilD2V8rGAKYrt4tn
         /AUTSYkUZ7292lfP0cg3VzOVZSWPwDn/8DtcUqJqQ6ZzrRJEvZyQfdhKaT1zgbFHRsnI
         889TjIigyoQktFqlN9m/fmYFPLWUetLtgxx5BqR+1bmrLxGdjaGIwMdba+zTKC+GprjC
         Kri6eFUX/U41OmLqZjgZIVMFe2ml1paBuTBwgSX1q4x3cjVbLOJ9DDlOHj1PewhUmgHs
         PLwFxM7KL80lLTrCY2jc5VwVI0cjY2tLB3+U6CG4ihPt6DITzXXfVaq7EyLR8rZUN685
         vRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774482709; x=1775087509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LOPJBC1loXl6lpooiFMMY+xwUPwa0VHRxGE1cqP0qI=;
        b=eNSv7z6Uj9ObZZn+xs3S/sgkhGai4TeaynfP5TV1WRn92EC2LsZ5vZpINte5MhJw2w
         iEXpBVQ/mfKqe8RLlscgmdLsdOX3cRtoqdibjR1iSPaVWb0caTs6daLuvXuZd6GqS5BF
         TuA0YtEtOdTSxnTUCQ1U7Nt0OFviOkrUNcvD6ksxOTKtAXICYElZRgbeu1D3XGoHL22P
         LTPtql8j6VkyzNS2DB1/Gd2UWg/ybPd58IwEQQm3/3MS1RxY2Nn7h8p+eLLEfrghJyY1
         sXwyZ9JCj4g9RTPS+0lwxVu02rEokGM14j9OhfoVQ2aGN0XhObyJdzWlyxSnOl71N5MD
         sfPw==
X-Gm-Message-State: AOJu0YwAq9F4eu8KFJfqvYebR7B46TfGwQu3usTe+iRxi6I7iggSWzCq
	vaqfDvSM/I7sHAsQI7Ji+YECnSdjTJROaPNBDO4S276ynajp5XlLzHGEZ7/EvdBp0SO1n0+s5JZ
	949/mUQnkYg==
X-Gm-Gg: ATEYQzxprnVqtmg8bb2O9uBGYWpaYc7ioc9Cy/+CIPV8bR3viVn5zLfF4myb26rpawv
	Twx2uz+on2OZ9ISB3Kvc5xYAzRH5PopOF38iy/tqIePyBgXeIOl1o9nky/GhqrLRaEFG4SpmP+d
	uljC7xFoWZtQcYbp2alwH/ze7L4fVzWrYq1fYwNqfBvZ+9aU8TUF9wijEZt8Y4P56d9+xvWFYjh
	ZH0UyWthAUuJWsYLIZbXNF/ryJhtnCX0ArmuaaL648dKhML7OGT8Rv8djru9Km8LHpB9/kp/gfJ
	zsmGZ6n1ZIUTlU6RupgrSSlVf7O9k3rv8ZGJNVZTKjX8SyhZJWIRZ/Z2k30PMiQkzgKOk0syfPh
	cNjweVh5pDNpfrCKmdjjfkbi2cjXntPr0W0f84YvRWg3VvLLyF1EWZP/HLTzuZmRVDU5lt58vj9
	9EjEdIXyP/lCmQ0KINNsxSH0AIB1yKJqIEuWOG3ygaYTac9lO6irD7aAcb1LIUDVednEUnQr64M
	CZiWioXclH8z/ZyZPNQFwh4nPxyHw==
X-Received: by 2002:a05:690c:c155:b0:79a:565a:b5d with SMTP id 00721157ae682-79acf387658mr55157307b3.15.1774482709006;
        Wed, 25 Mar 2026 16:51:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79b1e41e735sm5219587b3.45.2026.03.25.16.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 16:51:48 -0700 (PDT)
Date: Wed, 25 Mar 2026 19:51:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 1/5] pack-objects: plug leak in `read_stdin_packs()`
Message-ID: <1fabd88f5e3950e505bf24735bf3eae2437db7b6.1774482701.git.me@ttaylorr.com>
References: <cover.1773959041.git.me@ttaylorr.com>
 <cover.1774482700.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1774482700.git.me@ttaylorr.com>

The `read_stdin_packs()` function added originally via 339bce27f4f
(builtin/pack-objects.c: add '--stdin-packs' option, 2021-02-22)
declares a `rev_info` struct but neglects to call `release_revisions()`
on it before returning, creating the potential for a leak.

The related change in 97ec43247c0 (pack-objects: declare 'rev_info' for
'--stdin-packs' earlier, 2025-06-23) carried forward this oversight and
did not address it.

Ensure that we call `release_revisions()` appropriately to prevent a
potential leak from this function. Note that in practice our `rev_info`
here does not have a present leak, hence t5331 passes cleanly before
this commit, even when built with SANITIZE=leak.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index cd013c0b68a..9a89bc5c4c9 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3968,6 +3968,8 @@ static void read_stdin_packs(enum stdin_packs_mode mode, int rev_list_unpacked)
 			     show_object_pack_hint,
 			     &mode);
 
+	release_revisions(&revs);
+
 	trace2_data_intmax("pack-objects", the_repository, "stdin_packs_found",
 			   stdin_packs_found_nr);
 	trace2_data_intmax("pack-objects", the_repository, "stdin_packs_hints",
-- 
2.53.0.614.g164f3b634ec

