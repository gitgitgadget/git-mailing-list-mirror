Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A927F3C8736
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833362; cv=none; b=RhFTRUJU5b+9qz1iRhVzbD9EXNpPnLvnF4LdYfPBT8YLAXazUB49exVm6+AArY1BG6rLO56pcvTVO43/lHxWOUlwNSMwC3K/AG1qI14ps84Ejjr6p9+fcWKgRb402JZ1DMRIcR00OfO2cerqRB/DsoIk8yyO3q0oBdjjQRrmBL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833362; c=relaxed/simple;
	bh=wHG1rEo5EGGfQAj9w7ID5CnG13NxbBr8aFfDBi0xj58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6wFVT6KNulpS8MoIHuTZOQZz3s7AOfWGeD9Z9uAC6DMvFej8Al09EF1kKFEVP2owLQHVlNzp4svQI+Oy0GQ269ZQ2QSjOSvLHiLsl13XyYiB7/axuBuhlcLX3aQZTbioxJUvy4lbvheFMOC5SUhG7XcIE1YwpTH81EqzO/Hhoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEUKlkwO; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEUKlkwO"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d572f7437so1490206f8f.1
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 08:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775833359; x=1776438159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lCT8rBX+ICK7q8SDjaMogUbYcOcdYJWGbM+9eBWCmX0=;
        b=HEUKlkwOoPesGCLeSroOJd8J8gp6IqLok1QzW/1DkurKSnnkeMP91VKFspWFFFqolu
         +gN6unt+GCD/ehBkVioMTn1MWaFBU/8JLYfDVri7pa6IAnjplnMLboOT4JECFiKfIhPu
         GtA/xp/U+YjKZA82WrO2ZsRP18zZzr+XZwiNbFZ5BB2oexIrotrWJDW4vIMXCSsOsLS0
         KS3EzAYli29LOEybYVNH+osEtDKpPKirDSR8JX6KD+s6Y80WkmCIuDABs+andDFcVoJs
         PGkzQ9s6Fya6KxMZq7LKyGMBKSdzKtjVPczYCrgEU/6NK5fYkblSO7yfp7GsNzlL+4gF
         O/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775833359; x=1776438159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCT8rBX+ICK7q8SDjaMogUbYcOcdYJWGbM+9eBWCmX0=;
        b=AsVga+YBoa4yUzyMy3JTXAStQoW+KL1bmX5U10lqwg/WddOpu6DIAYkqPAgCSaYhe9
         IJa3bFsksPQGrgcDHXmvXt48LB+DX5/LqW8j3rEc99NHoGLtALJ+Mc1uYc83Uxlpj6tg
         bQr4G05eZ0hsCS1b6nEIxkUU5E8r1E8ihCOxyODiFgkkSFaRO9730hgIJVLVedz/yUz2
         thyupak+HSUaqL+X9rOKlw9OIb1wWyOlEOu4N/j8+eLcN68pY0o6DaK7lMlxvwyTvR4Q
         cBhaqSPNTLkAnKhjgS6qoQm0M1Imq13YL0y3Dcxz2gFc4dHVY6OdMNZkpSg8+dLPoBSi
         PYOQ==
X-Gm-Message-State: AOJu0YwsUuO5Qmqe6BU1LyL17X/Be26YNO2/+L1mUukSf2ox8xNFgCZK
	FpFPIUgH8Oi/uxLOtcf/ALtnbBLop/oo0V2FN5lUdNiM/WT0KJGMbbJogGDZ6OYNy8U=
X-Gm-Gg: AeBDietOvC94EUBkNT/klQRaTTuPngsZM39gXjumh3WjXYZ6c/qZDfAY4c3tJUyC294
	5Y67HvPeWizoY+pgQ8I6J9CZ/NJk0fx/fnzigUBBbgQCEnU2+f18DCPnmQPOwWI4Qks1f2t4Eel
	X2A4w2K8H4RAnfLI5tbbi7IHXegY7rM6XryDx1OB4A+clu0FBwIVUye84W3MKFHXG7A6rm1dtxV
	WZKieD3Td8z9HRLt2OIVz6dCtkkhpJhgrS/cVw79IHpZ7k465gKAMXV5fdiy3YbkPjFwqLdyy8K
	JONhwJkySwNoDWx3wjkUoBoSf/NqJCRByDN2xgZ+s+GYGGAWdVESXWgGK7Hq7jtpN39jxbnwXEb
	5ytYgFu6sygeMqi56DXLrtIUccV8mT8iMWSzjQ6gO1hlAuUrikeBZZmsn+1K603YhLpxLg0EBmL
	VzwKLeFeVIvjA/HauV9+Y7uJIIOy/bn9WEj6aqVIW8s7Ujg3xUXg8wrV/MK+eeIT9MRlawmaUDY
	3FwZrOlofnHL1kIUGE=
X-Received: by 2002:a05:6000:401e:b0:43b:9227:bc6e with SMTP id ffacd0b85a97d-43d642c778fmr5475024f8f.24.1775833358626;
        Fri, 10 Apr 2026 08:02:38 -0700 (PDT)
Received: from lorenzo-VM (host-79-19-37-238.retail.telecomitalia.it. [79.19.37.238])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50015sm8740013f8f.27.2026.04.10.08.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:02:37 -0700 (PDT)
Date: Fri, 10 Apr 2026 17:02:35 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Tian Yuchen <cat@malon.dev>
Subject: [GSoC PATCH v4 1/5] pack-write: add explanation to promisor file
 content
Message-ID: <b4990fcdf0759dc8f0e95b497daee54e08b09e0d.1775832056.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>

In the entire codebase there is no explanation as to why the ".promisor"
files may contain the ref names (and their associated hashes) that were
fetched at the time the corresponding packfile was downloaded.

As explained in the log message of commit 5374a290 (fetch-pack: write
fetched refs to .promisor, 2019-10-14), where this loop originally came
from, these ref names (and associated hashes) are not used for anything
in the production, but are solely there to help debugging.

Explain this in a new comment.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 pack-write.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/pack-write.c b/pack-write.c
index 83eaf88541..b8ab9510ff 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -603,6 +603,15 @@ void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_
 	int i, err;
 	FILE *output = xfopen(promisor_name, "w");
 
+	/*
+	 * Write in the .promisor file the ref names and associated hashes,
+	 * obtained by fetch-pack, at the point of generation of the
+	 * corresponding packfile. These pieces of info are only used to make
+	 * it easier to debug issues with partial clones, as we can identify
+	 * what refs (and their associated hashes) were fetched at the time
+	 * the packfile was downloaded, and if necessary, compare those hashes
+	 * against what the promisor remote reports now.
+	 */
 	for (i = 0; i < nr_sought; i++)
 		fprintf(output, "%s %s\n", oid_to_hex(&sought[i]->old_oid),
 			sought[i]->name);
-- 
2.53.0.585.ge25071d955

