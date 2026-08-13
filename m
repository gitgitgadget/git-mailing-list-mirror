Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B227484253
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632966; cv=none; b=Knn3bqf4AhO/Z/wE/YL7Pyzj432/x6bsyljIYwKlCgpH2RX56vWL/CQdD2Csl/jymTdSfcYTalmp/26BBUZOpAoeQQjiT1o4CM2SxK+hi5kT/+n6u1bXEOzQ7HQgVI48YYFYn0tTpv6MPLQ2H0T7A9T6YV1dKfKxY9aV3urQ7OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632966; c=relaxed/simple;
	bh=dTLJi/WZ6ji+LSDFlavMahcGkGDYQkrfUgZhRmFlvbE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=O/VntsbQasPP0t4RbrA8UuxmsXmCqTPY0WWARK0rEIkLa8HLjkZkgAEpQA1S+s43Wjigocjjz96qeXeHAqr8zP7LFaKd8Nm7RqNFex2StwrYJ7RR9/IFb3M7iHWS5YwVJdSKQFGL6KSLleIDF73mc3g24yERQJdWEGOaxor+yyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWE92VGT; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWE92VGT"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-45691990234so558543fac.3
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 07:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786632962; x=1787237762; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vwTFh6pXbUgSSuUulWyuHQdPiw34PP+qJ5+u7Tz9USE=;
        b=PWE92VGToSBt+3YiLTl6JB5Gxwef4aCDjqrS6HjZh0+UiX7YifhlWXgZQYzDgCFnnQ
         6SyRVkd26qnnvnHN0+aq3S8Z5cSICHdCwDc7apXE4WNl5rUnwp+JslKN/kR+UBW3kaP0
         YY3gmmS7JZFgnLxFBJaK1wo+NHihOr2QCmIiN1aokGU0CYqBIi61igxBGL6dqC+j4sUD
         lkvjhqaWHiV/8fyxlsGKw9XQO7gE4alHdnANNabEG8LMIjfKFerLHMR8U69MXi5D8B3i
         BS9bFatkgVtTE3dsjdxjWwWPD+V5kqEM9X78E1hBVT4YoMB7ogJ511d7W9pXHT60K33z
         GM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786632962; x=1787237762;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vwTFh6pXbUgSSuUulWyuHQdPiw34PP+qJ5+u7Tz9USE=;
        b=SdYqewxUZFJfRCa591NYRB2qayiocnuBe9HQlB0mwflaIvYIbrKp2O5k1JLn5tFf15
         AEF3qjn+TsRRS7QoCSOOdefhqxejcQd+cJ9GUPsDLg9H+GOVjGKksC6fsxWPSPjxuP3r
         6lTANyAXf1sxb4aEgP3aBqSMNzeWij6QwwpKrlDb9UfnuG4rBj/VWmoVNQPrOXRx/VdM
         QQMn+gzYB5Q4RVapiE4HOEbQDp55ddMWTt7ImfDjT4jhAkciFb4OElMjaveYm2TS+5ag
         P/bprxXj3iXT52eZMK0smgrtzQGE8jDefQbI+4e4YmbMm+ZWTHZIceErWyRjCOkK3VvH
         F7Rw==
X-Gm-Message-State: AOJu0YxG2R/10LpQI+2AjAoHMaaEHvHpnWRPKzHFba1zfnfVD3hTZkla
	PrMfQqxCnECidDuxNu4Jl3iM4DngQDdcAwOSLIVaF1q3AKuVkl4LZaCJkg/n6Q==
X-Gm-Gg: AR+sD10Mu0XjUI22Hf85471rqUVe975mwhiYGnVUCbhlY70nyuRoo/XKwywpp81b+GZ
	6IzaHE1OtCNkY6ZG1QhS99Pg8F64rPlzk5rRWwo0M2d/lkFzQ9MeNpdKaNGuFxj3b8YnhwA/6VQ
	7+9i+Zj7r+Ap3xz/DyKskwJ+ttIsT00k0IqK+9cnojZUtvGS95viSnfXc94VTzJuU3pPpoJqdck
	+GjKl+brhnSaaaBB5zDGnjypq2y+dsw6OgjUCrQFEA0aCyneqxWbqsouR9HeakswJhuZu1T/O7r
	THGlcgxS0OHpNzMBTR6naWsNmf9Ws41YclbWDngk2sniebqg55JyMvt652xJIKji5Wc8Hey/Dls
	PjgxBj9XyHoTWoSS+0EoWE8RKf/1bxPQK4PauvIt4iRAa4xU8IOfVbODcthlfF9tt80DE193zoq
	deCQqYlcDoJpgdf3DWNvMISUZZTBev+6y5lr0cdlJ1h9K7Puyc3rSuLVO8CEZRER4X
X-Received: by 2002:a05:6820:2d06:b0:69d:e676:6f66 with SMTP id 006d021491bc7-6b0c435571cmr5477866eaf.21.1786632961489;
        Thu, 13 Aug 2026 07:56:01 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.160.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b22cd169d0sm1718171b6e.5.2026.08.13.07.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 07:56:01 -0700 (PDT)
Message-Id: <c3019582844896d026a092c356b3b1b0e99e3fa8.1786632952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.v3.git.1786632952.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
	<pull.2175.v3.git.1786632952.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Aug 2026 14:55:43 +0000
Subject: [PATCH v3 05/13] pack-objects: widen `mem_usage` and `try_delta()`'s
 out-param to `size_t`
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The pair must move together because `find_deltas()` passes `&mem_usage`
to `try_delta()`: widening either alone breaks the type match.

`mem_usage` accumulates per-object byte counts already computed in
`size_t` (`SIZE()` and `sizeof_delta_index()` reach here through
`free_unpacked()`, now `size_t`), and was the last 32-bit-on-Windows
narrowing point in the delta-window memory accounting chain. With this
commit, that chain uses `size_t` consistently except for
`sizeof_delta_index()`'s still-narrow return, whose value is bounded by
`create_delta_index()`'s entries cap.

`window_memory_limit` (config-driven via `git_config_ulong()`) stays
`unsigned long`: it is only compared against `mem_usage` and promotes.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pack-objects.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 503ebbf091..96ecee393e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2804,7 +2804,7 @@ size_t oe_get_size_slow(struct packing_data *pack,
 }
 
 static int try_delta(struct unpacked *trg, struct unpacked *src,
-		     unsigned max_depth, unsigned long *mem_usage)
+		     unsigned max_depth, size_t *mem_usage)
 {
 	struct object_entry *trg_entry = trg->entry;
 	struct object_entry *src_entry = src->entry;
@@ -2991,7 +2991,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 {
 	uint32_t i, idx = 0, count = 0;
 	struct unpacked *array;
-	unsigned long mem_usage = 0;
+	size_t mem_usage = 0;
 
 	CALLOC_ARRAY(array, window);
 
-- 
gitgitgadget

