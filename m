Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211E210957
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 20:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765053067; cv=none; b=Jtyma1MahqWKP5c9mbSSboiNg0cv5PI1tfDDtnDQ/Jfm6dCVV30XJlupTuUx/TJsOnUAfz7aPFTh+UcE1YGp3aiOHEEMfm+NH9hYBwYSDLwm/+Id9PqDEI4r5z8MsURbc7jR/LyQYXNVRha73np6AQXwcaV1Ux0UBvbzIyZ0n3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765053067; c=relaxed/simple;
	bh=4/8JQ3xrRTlCa0Tg6CFVMSnCAvyx1FJUan8Ei3T22u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxfliOUtSnPfNRbmIS9d3+B3fTc7AkO0gElLUECcEb26bAkQc+K0mzDSVjvaOwsgYM/mRhayWSwshT0N5v46fiAXD8uzidp9ycQ4d3aifDd+sA5O7krrfw1ngwQNJKufUSAfK6Bz0MTI7qKX7zJjzUAguh46VQF16XekqqP0ZWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Jn3iX9gv; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Jn3iX9gv"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-787e7aa1631so49912797b3.1
        for <git@vger.kernel.org>; Sat, 06 Dec 2025 12:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765053063; x=1765657863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0u+Y1GFBFtefedyxSeyR4xYuq3EaAwbQryrLjSTNj0A=;
        b=Jn3iX9gvWG7tQPmChOvVe2Ybf9OTKIKkk8ndPzKq1oEIE/yjiNeQFuzihXxpuegYg3
         0NyQNfDILBUEalY9Not2imDrMnmEXP2Tlx8CRA/WRrWrvvWaoNVKN4Q8ULFGJZ+Wo7wF
         UwiBkWmBpgNP+pVDBudAbSHxF7AAdXfcE3HZMXV7AnU+QLauX6iC64oTZKft4YAhFLBT
         btWdVHZj18S2+/snqVVatiPdCj55jNDM2dt5OkJDA8/yPz/cHZOaHL5CG7XxUO6cIsql
         sg4cQ09c5WvADDP/wo2MmOaSs12wD1Oe9n42SRBXyfNzv8aoNQR/X1rgmJLPHPYkqHmg
         ieWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765053063; x=1765657863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0u+Y1GFBFtefedyxSeyR4xYuq3EaAwbQryrLjSTNj0A=;
        b=rxe4lBlbXoj1mzMOCmwDE46hCAQ3N5K3h+qGFLE9kZQxcyPGugz3efrDchVD2S10mk
         Ea5LTk+BCW4TuIyz7eQHWzfjgxaWsRmVK3ps5nfDeL2qjF1bv/c2emXPejyBRFgTQ+v8
         k0p8W46uBOmVDx3NCNMQwSN84daDSQcM0ke7kUEX51BvIf/oHuS9e+wGjefiM/VEoXr8
         e/CzFisU+cxDn66XstJcGdZHk/3BtojiktfW1ScMpU6r6TiO6y02/jx6++ySb/YOKjxO
         /OXeqRnhKgJJRziY9eI6oSUv/p/JXwIpGRcH8v0d+Av2KOTGA1wOnlaaTre603UKyv8Z
         PJpQ==
X-Gm-Message-State: AOJu0YyHqcaIBCjZHSI8zEcKixHdGTyeIyo4ZgypxgzrYXubtM37YuBR
	bc05ZUwvAn+FNEeyD5QFUg/EnEFhaeM0uCwIBdXozw640GTPN3A+PItOJrqm6CBuyhFNkkXLaHB
	6sf09nlk=
X-Gm-Gg: ASbGnctZG6U5wBRetjiIa/88taSqA/+B34jKTSjXn7jDEFvd3LliLpIwzfTQsw8v4S5
	BNGkb0cct4g48bZH1ychrGJXBVGkCte1DTbPDla8NQymm0qFEtCPCSV5ZFfbqF2t3T3RgigkuTS
	5V0fn4lyH1jEvKjXTe6Uq2iUaFQnG/34DR6HJUr/lBI0mt8MY16xKqTLqxrL/BQJjIS+LADSYTx
	H6fhKM1kN54990vQl3mF6Gzw8BmXRl37CsyIIpNMFBALZvsbAwqhGEX9q6HqUYfRbOnXJd0z0ef
	GFtwA7LhonXelLAC9X06HAOibKWXC3OiTErR9iVH4Wkcmce3bwDvilFNA6XWH0DiM8GOBmkRUd4
	PhsBa9vEEj87WvT/SECBwpcWEzWUBeom2MzdcbYDX/iYEcLQSDGRLifH2GNQHSoSw6GpWfHFN5N
	q3a6L1nF5ks8d/bLzWBH717F/UKLv2RXf352XEBFhBkYMqwsQYte+pb2E1i9tFyD1htqZbS9Kmn
	V5Q+AU/z7stEjf0Gw==
X-Google-Smtp-Source: AGHT+IGb2tak2MXX3PmDLjZ5exk9BPdkyl4Tf7gnI6ZnxoqLGOSQlCngpdCWJPevd7oe4XVUWOSpzQ==
X-Received: by 2002:a05:690c:7085:b0:787:c948:2040 with SMTP id 00721157ae682-78c33610b3amr33277057b3.16.1765053063027;
        Sat, 06 Dec 2025 12:31:03 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78c3a6d889esm5826547b3.25.2025.12.06.12.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 12:31:02 -0800 (PST)
Date: Sat, 6 Dec 2025 15:31:01 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 01/17] midx: mark `get_midx_checksum()` arguments as const
Message-ID: <8cd8f6e8420a52030f92166d5a20387183cdbb6b.1765053054.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1765053054.git.me@ttaylorr.com>

To make clear that the fucntion `get_midx_checksum()` does not do
anything to modify its argument, mark the MIDX pointer as const.

The following commit will rename this function altogether to make clear
that it returns the raw bytes of the checksum, not a hex-encoded copy of
it.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 2 +-
 midx.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index 24e1e721754..6c01f0fa522 100644
--- a/midx.c
+++ b/midx.c
@@ -24,7 +24,7 @@ void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext
 int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 			 const char *idx_name);
 
-const unsigned char *get_midx_checksum(struct multi_pack_index *m)
+const unsigned char *get_midx_checksum(const struct multi_pack_index *m)
 {
 	return m->data + m->data_len - m->source->odb->repo->hash_algo->rawsz;
 }
diff --git a/midx.h b/midx.h
index 6e54d73503d..7c7e0b59121 100644
--- a/midx.h
+++ b/midx.h
@@ -85,7 +85,7 @@ struct multi_pack_index {
 #define MIDX_EXT_BITMAP "bitmap"
 #define MIDX_EXT_MIDX "midx"
 
-const unsigned char *get_midx_checksum(struct multi_pack_index *m);
+const unsigned char *get_midx_checksum(const struct multi_pack_index *m);
 void get_midx_filename(struct odb_source *source, struct strbuf *out);
 void get_midx_filename_ext(struct odb_source *source, struct strbuf *out,
 			   const unsigned char *hash, const char *ext);
-- 
2.52.0.171.gd6a4e6b6955

