Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96C41991CD
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 07:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742369098; cv=none; b=A4hCc0bREPcsJMzBiOlM44Yo67SN34EUBn/3mYwP23ZBzlbuPnKnG/EffPJMISKTY3ysPpPr2J1R/l7AY+CcuL2pfP7oxI1QBjp+Y9/1XPU4ezyocvUqFq0NwqLR8uDRFrhwQh0KIaZU1j0jucLwtZ8I0TodMaQNdYDzQIqrMRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742369098; c=relaxed/simple;
	bh=hR56AVElvj1UlNEJrUqmGsIqylCTdHjGv9Sym+DTpuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ecPJwCWfzODk/S0w/DEGf8GoX4XIPhqvTDNUjPAij7hDpHCmbW/tAO+z7Qdu7oUZQys6T5mxWcoXuRBb5Aa30rjEgwwwO8DZ6Uv2+2/wW80k8IpvFVqNhjs1OBLOvPnhpmcQ9eNcaiMt+SXfug7EjSa/iPr/QZELcG1fxNhVrYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESU6bT7w; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESU6bT7w"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30c0517142bso57447701fa.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 00:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742369094; x=1742973894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=svTpOJ4Q6htNj2kZKEdQxez5OELn2VVaAhRO/LsvGDE=;
        b=ESU6bT7w/PrHLfbSNQw7CGShLwEa4L3sKsKIIJuMgMdsblhBlgNt1obOkLvVelWjmw
         ETaAGA7+F6+M9YHP3OE915tHbDwNXD8xV+mMqfz/5q44RR2qYgAXVx6dXIFMzsqWljWG
         L1M/XTZuL6Fh7hiPT/6/f0UX+aFmZtPUG1roaxylRAqmWLHwiDz6TIKEkyqdAuYPuVA3
         ATLhHgmc6inKA+3UrE0ORPiF5mjm+0FtIDH4YQaQ17doaiX2ym+QLsdQT1PwTOBEIkYh
         yrwEojsj1UACamLBWbSKPJ/6byaqcnAOW9M5CQqmbTL9czwBnzW8XV2IiRvas3LVVENo
         4D4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742369094; x=1742973894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=svTpOJ4Q6htNj2kZKEdQxez5OELn2VVaAhRO/LsvGDE=;
        b=ZJLs3U0dE+oGhUHaG9yreCUt2tpCm3j4qVtTY4EPEDdH2yzXIOtwN4gi78LNeQBz06
         7TGbBBeKcARfbVLKt5U8shOJh+EEHvL24EnbvVKT6u4Kvq65CmOu9M7XhsscRITA1Z7M
         PcG8draT02SmBaSP+lTNGviUCKPSx7fwQlWaNTRD4fYaVvfHGSsnPUesCENFcOnBG9XE
         Lz8LCCloEaNpwYhAPeYnGWHlB8Y1SDiSwr3DHFFFJtDk970jstO4RMxvRFNJ4qXlKu57
         is4ousR67mKzuIFmoHSAVBmdi2t4Nxz/jojqzi0fnkbzUQk8MHvpuVfJ+yWDjovwTr/n
         wVMg==
X-Gm-Message-State: AOJu0YxjRJ6eGBlR2ZSOcOx+HB6bPmkPI11v73LMQWo4SoVbtGqNW9Dx
	oO5k4KwFKPDtqk/jeJBIRh+hxXIFNzAznoDLc5L39X8BMViU6GvylG1T2Q==
X-Gm-Gg: ASbGnctz1GUuk6jz+BhFUrByxswMeDbS5oqKVTIh55rHxQs0+61EMeFVUues/6Hvl2i
	hkKcQwH2R23JtXlVQiRWPKGEJ9x6opmxTjf1l4GipOMzMkmuC87pr6qHUB9yGYOHyTs3zxNytmk
	a9RSwe87yrIYXk630pyqBOwikCiFzLrm1PJf5w5lDs/NDhVTwWbhG1wKt7uIQdcYPNKeZYtR68k
	6wa98Q+dPLNwDOCPVZVNtyTwvtwh16VXS9c7Hbn73MsPGq23p/osZPGXJbeLEmn4yC0qz6+fzVg
	OErdW9WWqESQDQ9JzxDAXZnx26hT4wnfun39I2/jjuDv3SJIfmaz/HAPTyzHJw==
X-Google-Smtp-Source: AGHT+IF9hZrUxF2wetnERlNwWt9YJ4aD38cGdAsX0y8Ll02YyDhgiyHI5Ya296viU6KKytrjDZEqmw==
X-Received: by 2002:a05:651c:4ca:b0:30b:f775:baf5 with SMTP id 38308e7fff4ca-30d6a1c402amr6249441fa.0.1742369093671;
        Wed, 19 Mar 2025 00:24:53 -0700 (PDT)
Received: from localhost.localdomain ([217.116.228.14])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f209d6esm22089541fa.112.2025.03.19.00.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 00:24:52 -0700 (PDT)
From: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH 0/8] pretty: minor bugfixing, some refactorings
Date: Wed, 19 Mar 2025 08:23:33 +0100
Message-ID: <cover.1742367347.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I've been going through pretty.c with an eye to pulling apart parsing of
placeholders and formatting of strings. These are some initial cleanups
I've accumulated in the process. I think they should be valuable on
their own, even if I eventually abandon the bigger project.

Martin Ågren (8):
  pretty: tighten function signature to not take `void *`
  pretty: simplify if-else to reduce code duplication

Two more or less simple cleanups.

  pretty: collect padding-related fields in separate struct
  pretty: fix parsing of half-valid "%<" and "%>" placeholders
  pretty: after padding, reset padding info

Fix a bug or two in parsing and handling of padding placeholders.

  pretty: refactor parsing of line-wrapping "%w" placeholder
  pretty: refactor parsing of magic
  pretty: refactor parsing of decoration options

Further splitting without any intended changes in behavior. These
refactorings aren't followed by any patch that actually benefits from
them. Still, I do think these end up making the code a tiny bit easier
to understand by way of having smaller functions and collecting related
pieces of data into smaller structs.

Unless the original authors are (TTBOMK) no longer around, I'm cc-ing
them on the individual patches and on this cover letter.

Martin

 pretty.c                      | 300 +++++++++++++++++++++-------------
 t/t4205-log-pretty-formats.sh |  15 ++
 2 files changed, 197 insertions(+), 118 deletions(-)

-- 
2.49.0.472.ge94155a9ec

