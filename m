Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C432BE02C
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 23:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768261510; cv=none; b=JQB6RnggX3k/JLci9t+W1nGoy6ufKgksiz3sgWJI5XA8I4zpzWjQzFUdeafFUbxxd9os5BThLcOnAiOcu9kEVXiHFnaaeu+GOc9GRmcu/LiAsWqDp+c3hF9GVPwbYhzMZ3jTEcjyUaDb9Rs4J8OfBLXJs+wMRIt1+fAGhdGvJwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768261510; c=relaxed/simple;
	bh=3Yptu3aNUoxa5j72uQQuWfsADczFtgA080hAZKpLRNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6DXqlm73OIy0GskZR53uh8Mcjdhc/bvlySLnEzv4WhcY34JRR2OWyBUTd7MFvGaRQxRjH8558A+QoHCosDR4A51vDWPS9Bd/o04QdMOW+iTZ+YfwVngBXNZ1H99Wg8z0qNeQy6S2fFjSIYWbenPl9u+XeQjIEsBuHLeOTTZISo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=QdvEpsRW; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="QdvEpsRW"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-792815157f3so17834747b3.1
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 15:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768261507; x=1768866307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SORBDdykNMsZXTPcEwIW7MNEN2e8/klVuLKb5Pjtxr4=;
        b=QdvEpsRWuPOQkaU2ydAYAjceonyVyn3ilyIfCBmuIDLBL1ht5H18ZJEwkySxJEWCTb
         9Wr8YaaNR3PTCgr4kvjcKdLfdtBEe2JvpyvLH/wmJAGvzpBH9MbG3xw/YMr6/2AL4OO8
         o6euuoppXveJgDwKhau3TvruOnfN3LpzUajWQUCQ2BnHVzmjUSulkMIRMi9Mkwq3jdYE
         gE+t6F1z23kkvK433lY2G38jiuJQJj9Q7SdOYcUlTs/zj6dlVq2ZrAWP5oUrLQ/ravn/
         /iBJkanGyhBPVgZp1l7HQiTs/5qUv0ahBexxHB1Vfg9WFcOi1dEJ07We1YPi3Tu5L2Oo
         ptDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768261507; x=1768866307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SORBDdykNMsZXTPcEwIW7MNEN2e8/klVuLKb5Pjtxr4=;
        b=XxIVkiK8hziJg5SpBiQaQcyhW6/v9wNmx8cVsdlx+CqAhAYm8OIRhLM+t1QAsepyVb
         nDQ5qGVdoBahgt1UZpPAZd8KForlMDFHnzpEGgNmKd5swsF9EHdet9FjJQ7RZkcT0ks9
         6k6fI6DVTFDC7Wl7B0h4j0caeSH/km5n1FhSlgAz1Wz4e7RbubFLGr/B80aArZlXnhsi
         CjYL+grdfsNTkcM0YuIVySoEWYplmYdE1IImADBXuXehAiyc9CGI9oKI7ilUwcWDDxkc
         aK/vPLT68RuionfBu2l1ETtuFuo5PqLP1wEXFaNGeDeYyvbpAESFN425kjvUJN9jzlX1
         RBAQ==
X-Gm-Message-State: AOJu0YyHpAJ1BkwAa3CX1S3OPBUPIv7nZtUAF67XSAoj4PqnYpjR2/9/
	ognsa5Cj9z//8oNw3U3V2Lp8Q+BSBNWYyOqVJm7MCR4H6wo7YWoyN34aApdDLWt93g8u1DJ0+m0
	NS4MAtjV3buh+
X-Gm-Gg: AY/fxX7f0JybBre+xGGrvVrYZGlSpwqzGD7tG7FGCkUgmPWi5plzlT2KW0iyUZlsVVb
	8PACV5a/w37ZHr+11unl3wssolfhTBwyvAAJAOksu6Cl+Gd70oKlv7rjsw+MMgn+WdPM5g9t0FN
	nElePwDauqkM0ysFbIkmZX5sgcvTbytBaQuQ5QC+Fi/Z3pcMbbffDQxW7GEPONItZNyDacM1q2Z
	okqb1sIRLvArT1hUezIegwkYs/JPnyGL7b+qaFGL6hu4a9plrd19opwiixD/IbaGyU4x1hcU82r
	WXCKSitM05G5urS0h5quxWMC6eUzw4gyrN+LGpmZNs0mbG0R51QzU07eDvgWjDXPS65WAtMYqom
	S889aXH9boKCRh2PlOnu8KOU1YDO85MsRhYiEKDde2XnrPshiweprOPozusDxHlbRJEWwjW+0Iy
	dcEPRzXmJ9vJaAhwaZMYkZNh4q3bjkZyXylHHvHlraNOUR6vuZRASJxam8MMUXf9SQoMmEySwci
	Ta3f5olq/SIkduAXA==
X-Google-Smtp-Source: AGHT+IG2DiRf1k8xu2f42cd6Hu8Xk1FCW50YX9iuxfVnyUNBkFAvvaiXXyqi9+U/vvI/rSwB4mIrKw==
X-Received: by 2002:a05:690e:4091:b0:646:7c5f:c74b with SMTP id 956f58d0204a3-64716b8dac4mr15602092d50.24.1768261507389;
        Mon, 12 Jan 2026 15:45:07 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa67999fsm75616537b3.37.2026.01.12.15.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 15:45:07 -0800 (PST)
Date: Mon, 12 Jan 2026 18:45:06 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] midx-write.c: assume checksum-invalid MIDXs require an
 update
Message-ID: <952a40c1bef40f5ad2c7f6853f6da64f99350976.1768261435.git.me@ttaylorr.com>
References: <cover.1768261435.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1768261435.git.me@ttaylorr.com>

In 6ce9d558ced (midx-write: skip rewriting MIDX with `--stdin-packs`
unless needed, 2025-12-10), the MIDX machinery learned how to optimize
out unnecessary writes with "--stdin-packs".

In order to do this, it compares the contents of the in-progress write
against a MIDX loaded directly from the object store. We load a separate
MIDX (as opposed to checking our update relative to "ctx.m") because the
MIDX code does not reuse an existing MIDX with --stdin-packs, and always
leaves "ctx.m" as NULL. See commit 0c5a62f14bc (midx-write.c: do not
read existing MIDX with `packs_to_include`, 2024-06-11) for details on
why.

If "ctx.m" is non-NULL, however, it is guaranteed to be checksum-valid,
since we only assign "ctx.m" when "midx_checksum_valid()" returns true.
Since the same guard does not exist for the MIDX we pass to
"midx_needs_update()", we may ignore on-disk corruption when determining
whether or not we can optimize out the write.

Add a similar guard within "midx_needs_update()" to prevent such an
issue.

A more robust fix would involve revising 0c5a62f14bc and teaching the
MIDX generation code how to reuse an existing MIDX even when invoked
with "--stdin-packs", such that we could avoid side-loading the MIDX
directly from the object store in order to call "midx_needs_update()".
For now, pursue the minimal fix.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c                | 14 ++++++++++++++
 t/t5319-multi-pack-index.sh |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/midx-write.c b/midx-write.c
index 87b97c70872..6485cb67068 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1011,6 +1011,20 @@ static bool midx_needs_update(struct multi_pack_index *midx, struct write_midx_c
 	struct strbuf buf = STRBUF_INIT;
 	bool needed = true;
 
+	/*
+	 * Ensure that we have a valid checksum before consulting the
+	 * exisiting MIDX in order to determine if we can avoid an
+	 * update.
+	 *
+	 * This is necessary because the given MIDX is loaded directly
+	 * from the object store (because we still compare our proposed
+	 * update to any on-disk MIDX regardless of whether or not we
+	 * have assigned "ctx.m") and is thus not guaranteed to have a
+	 * valid checksum.
+	 */
+	if (!midx_checksum_valid(midx))
+		goto out;
+
 	/*
 	 * Ignore incremental updates for now. The assumption is that any
 	 * incremental update would be either empty (in which case we will bail
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index b6622849db7..faae98c7e76 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -563,7 +563,7 @@ test_expect_success 'git fsck suppresses MIDX output with --no-progress' '
 	! grep "Verifying object offsets" err
 '
 
-test_expect_failure 'corrupt MIDX is not reused' '
+test_expect_success 'corrupt MIDX is not reused' '
 	corrupt_midx_and_verify $MIDX_BYTE_OFFSET "\377" $objdir \
 		"incorrect object offset" &&
 	git multi-pack-index write 2>err &&
-- 
2.52.0.437.gcc6f76a88cd
