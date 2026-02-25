Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678AA1F8723
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 00:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771978892; cv=none; b=UajOdg7aR175pwyIRIap22q7iSwJtWrOwMEEm/6Xtv7WxH5cE2+4TgJupoMSdoVFk4jDM0juwk13iKfbp9EzFddkbmGE8Zq/XXDgi6L5Q+IVM3dsyppVRAfSLDxQetffSrIivHo4UKvhje+0xvZJNfDOziwJgLA9ag27yboNNf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771978892; c=relaxed/simple;
	bh=OE42Nnnlen2M5xJ9r0DE3WNqZeCk+4/mqW+pQJkfAyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtqGVko2isdHQoJkMCotVinExSgh9oMH/DvooPff+Z1nkGsuNMM/t+iEG/683okPn+z/qFPFnH8otEvNZLJdoBOMyyxv79eJJLg0Eru1SLj0nmeVd+ddB69Wpe/HNBPsUBUuJRkF/Uo4Xwm3Fyu9qpdfYvnCtRdG1kbATeGJZ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=UM4IG6mU; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="UM4IG6mU"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-506a297c14bso52298051cf.2
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 16:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771978890; x=1772583690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qw8WjKg65GLJWUzO0q0LEXm+Y/MsPyW1fS/4/h5ujPs=;
        b=UM4IG6mUS9dinN3murCjKmDYsPUJBA5oRFUsKmBExDKzb658So8jCIeuCYuWaGojdn
         0EL+CJmmy5p2QFHpwefrXQro+d2x1T2fG3XgqL0aUHkYvXrWijthbUHmqdl4v5lhLk0E
         3gnGtWEc7y682Ev92ckl4j2IHnXf3m6kRlrAhA/MITtV3qnQBa9vAFVSa/3oESo7HbIM
         DLSh6Ezhu8B6L3rz/QOIGyp9slgqpwmgSbGJ+YisZgm7FdCMrd8oTHYsA/VdZgFfaJEh
         oT2f6RPQkyJUsWstwxl3dqN0FeLFkbOhCEpniGbNDSE4plC4v24LPM+vERipaRIRT4jJ
         aFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771978890; x=1772583690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qw8WjKg65GLJWUzO0q0LEXm+Y/MsPyW1fS/4/h5ujPs=;
        b=RTxSIyeyGwbOUahpn+ncXVEfOo8ZhpCHmf2NnsdS+EzXfuUpTcJ5cZvSYu7PfpHTva
         XkxshcclQBZGjyhGiXsbSl1uJOveUIru1CinTcUHsJK1E7dnNolfR/9huG+O1kPoDU1B
         C22kv8Q0BPc+fUEyrpdmuPokHF+KazIkgfRauTFQeX8fmE8sVyQGHckE18kJBOrdoomi
         vvcOkIfqE+M/lH3eZuuFG0HZCa60mFPmJ2bW7ILEF96dHdVTUA//2esmKr0LpcclWH6Z
         k/aQ5hm2Ay2oAQnT6U0PM2Cs1mAbnxymxpckyZpZF1/1lq5eEuIP5Zup3tt1g/hnFNNy
         Se3Q==
X-Gm-Message-State: AOJu0YyZrY/Io3IwlEJBuL3GgKnFfIkdQpgiBAwlTAm5JNpU0f7HmvIN
	U6bBGaNbSRcbrmoNRV3cYdJLotLOl9ueJ22eH4egFKOh89l1FfntOR+HA9m3BV5C3/1M6Fpb80C
	lP5a+TVeSDg==
X-Gm-Gg: ATEYQzznMS4WcDcGK5oZ1v6EGj5gQRiaXHFa5EU7a948k6nwSHX28ZeNzaCoJFR4/+h
	61coClJRKT+yISI1FvyLggZjdarDEwThRdAuOPwarHk+hFvqwHHuk7H6aPjk9LBa6EQdXevUMhE
	bd1Gtsp32Q5ZXl8rgZkpHYdpjA1gH5QADypkxORovuqQ/ae/MyWhmLfteZwVe8YIiTawuV672zL
	f+lecynuUjCSvMfTtxBatLq4MUvjiETH5IkpslpWITCsnhy7pk57IZsQ54luwCuA49nD4HAsJuA
	SOkzLOWz8J+XyUwssGIAnB+2phRRVpind33ifcZmCfFF1nRVXa1yM/AJrLTxs2OlwIznzF8hnan
	seoPFnryED5MtIGJw69d6vTBSfJ5GmN+526r1zDxCGOEoy1GRM28YHpJXbwpTTna/+OuOlaEzvH
	y0OxbNyZJPoGVpiX+0SDoPY97yyVgDat+HIVR8TGSUGosCpJeKc7OuytXDy2v1u+Pd9CmBBhhq/
	6GW442qGkvjcgsbgxlFcPi56kfjF2jTbL1wxVjl
X-Received: by 2002:a05:622a:3ce:b0:4f1:ba4d:deb1 with SMTP id d75a77b69052e-5070bc9b0f1mr217042071cf.46.1771978890144;
        Tue, 24 Feb 2026 16:21:30 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d6d505csm108397331cf.27.2026.02.24.16.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 16:21:29 -0800 (PST)
Date: Tue, 24 Feb 2026 19:21:27 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 07/14] midx: expose `midx_layer_contains_pack()`
Message-ID: <aba9ad5174aec361f019eb44da87b04ec9b92679.1771978829.git.me@ttaylorr.com>
References: <cover.1771978829.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1771978829.git.me@ttaylorr.com>

Rename the function `midx_contains_pack_1()` to instead be called
`midx_layer_contains_pack()` and make it accessible. Unlike
`midx_contains_pack()` (which recurses through the entire chain), this
function checks only a single MIDX layer.

This will be used by a subsequent commit to determine whether a given
pack belongs to the tip MIDX layer specifically, rather than to any
layer in the chain.

No functional changes are present in this commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 6 +++---
 midx.h | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/midx.c b/midx.c
index 20732c256a6..709fe7c3fd7 100644
--- a/midx.c
+++ b/midx.c
@@ -665,8 +665,8 @@ static int midx_pack_names_cmp(const void *a, const void *b, void *m_)
 		      m->pack_names[*(const size_t *)b]);
 }
 
-static int midx_contains_pack_1(struct multi_pack_index *m,
-				const char *idx_or_pack_name)
+int midx_layer_contains_pack(struct multi_pack_index *m,
+			     const char *idx_or_pack_name)
 {
 	uint32_t first = 0, last = m->num_packs;
 
@@ -707,7 +707,7 @@ static int midx_contains_pack_1(struct multi_pack_index *m,
 int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
 {
 	for (; m; m = m->base_midx)
-		if (midx_contains_pack_1(m, idx_or_pack_name))
+		if (midx_layer_contains_pack(m, idx_or_pack_name))
 			return 1;
 	return 0;
 }
diff --git a/midx.h b/midx.h
index e4a75ff2bef..f211a38b9e7 100644
--- a/midx.h
+++ b/midx.h
@@ -119,6 +119,8 @@ struct object_id *nth_midxed_object_oid(struct object_id *oid,
 int fill_midx_entry(struct multi_pack_index *m, const struct object_id *oid, struct pack_entry *e);
 int midx_contains_pack(struct multi_pack_index *m,
 		       const char *idx_or_pack_name);
+int midx_layer_contains_pack(struct multi_pack_index *m,
+			     const char *idx_or_pack_name);
 int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id);
 int prepare_multi_pack_index_one(struct odb_source *source);
 
-- 
2.53.0.185.g29bc4dff628

