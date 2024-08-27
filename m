Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DA8481CD
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 21:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724793209; cv=none; b=MnJWTnpBsJbjvnbzJRR8yHgLGbSyiIGLN3KaQw1AasL4Uu8zYC5sGLQMc3xUHUPX7x+Iwue1+CZ4qGFgu5jNpjYVNHhMsoT/z/1N9co4Z/Qz0Mg97j0znnWJmy7g11cmHsKmhtsF4sIAOEwaKM84y5Eh8gohjHrxNs3aIM3j3mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724793209; c=relaxed/simple;
	bh=bOlvL/fQ3nDcDmn1RdGQE6dJ9gKg3Mmd3uEBPORUDQY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SF9+6xbopErZyzOuHpgj5dqbADOtJnMG2QlubtFt6pY9aVwHvH2ttduYDiT4o+VY068t3GcU3HGUbxH9+yn+z8eQRwLkNaBoYPNlAcTN8kPZno1rfRQi99ABF0WBGwHN5PuGu8n+4SNecCp5eTxyI8RlRsnS4xn+UiWAmIanEIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=NMSQOrlV; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="NMSQOrlV"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-709340f1cb1so3074682a34.3
        for <git@vger.kernel.org>; Tue, 27 Aug 2024 14:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1724793206; x=1725398006; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OzhNv6o9uX3xVfJINUs3i708IniL+uoQ/q5QFmdugYI=;
        b=NMSQOrlVkLbPWMvQZBCsqEjE/7BQ1cus0UV1jI+g/eVD3xJpjbb5/lbIzp/7qRcn5x
         Kg2qIs9OwKLoPd0SIDsdjiH3sMzZ5DyDyj91Uv9K3IwWUMvhEL9kap+ecVtJYD80FbNi
         Q/GDQGDAiNGF71etr7KoxBuvpifWK49x1Z9C8EIZJiFNC+fhpgYWjJPVf1IR56Q/0wJ6
         2abYuELNZaB2/gK5Z2uyWIN1OC/oL+LMkbYROeqtemPb2FiWMTbR6YbsF7g4RUKJhFtF
         bHtC77gwZpMuUwXoS/eznpx2Zuivx2CeSVptlsIqOhRj7bRBD/TP5LR9pZgjaTkDDBG7
         3QAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724793206; x=1725398006;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OzhNv6o9uX3xVfJINUs3i708IniL+uoQ/q5QFmdugYI=;
        b=JVxOzUYPjejhVm6KzmO1E63/umxk4wrzVjFn5eR/2jLdZ2st3GysSSM+nFleDBJW+D
         BpnbzIusElraju0QDZVS9o9y0HKCgXvIGtZLJDlg5lsCgHpc5KQ6uqY0zB43M8Q1Iqiv
         /Tl92TWMBItJbOtZwrx26FTeJxAlch1L3Eud68Glr9dLaS10pBAwVRA2aBYwimmf7Llc
         iO6xEl2VVQK+Cp7bnM8evzjfguW75s8OPgV3tZb4zTsRYv2x8Q2J9T4mpjNmIXiLoHw3
         JM1Uhla0lYCT/pXayek0ewB8kHWAAqnd+j8g2XOMIhNrtnMrabgWyrFe7bCgOxsHNWp7
         JiVQ==
X-Gm-Message-State: AOJu0YxUryNpjr025QM/uwKWKdB8vqmzskvCAoJcPhol3kT6VvPRDEVu
	xnzENFsAfkveS47kiQpiR7AX68+F6lEd3zuq4r7nNS83R37aYtpTSXCjf/EahPzkvgOM3AluFEL
	p
X-Google-Smtp-Source: AGHT+IFIo4Vdm1MXuZGKV2HTFC0lmBvHPqjpxeNVicILBCEiSb7wc26C+bg+mKlLd3BBnSgC9DjW+w==
X-Received: by 2002:a05:6830:dc9:b0:709:33ee:f578 with SMTP id 46e09a7af769-70e0eb2df69mr16426466a34.14.1724793205857;
        Tue, 27 Aug 2024 14:13:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39d3a9f90sm20866077b3.96.2024.08.27.14.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 14:13:25 -0700 (PDT)
Date: Tue, 27 Aug 2024 17:13:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] pack-objects: brown-paper-bag fixes for multi-pack reuse
Message-ID: <cover.1724793201.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This series fixes a couple of issues (some cosmetic, others less so) in
multi-pack reuse noticed when rolling this out over a few real-world,
internal repositories on GitHub's servers.

The patches are laid out as follows:

  - The first three patches demonstrate, prepare for, and fix a
    significant bug with multi-pack reuse which results in all sorts of
    strange behavior (explained in detail in the third commit of this
    series).

  - The fourth patch is a minor (mostly cosmetic) performance
    optimization that avoids duplicate calls to pack_pos_to_offset()
    when performing pack-reuse with a MIDX bitmap.

  - The final patch is a cosmetic fix to avoid using the value of a
    constant instead of the name constant itself.

Thanks in advance for your review!

Taylor Blau (5):
  t/t5332-multi-pack-reuse.sh: verify pack generation with --strict
  pack-bitmap: tag bitmapped packs with their corresponding MIDX
  builtin/pack-objects.c: translate bit positions during pack-reuse
  pack-bitmap.c: avoid repeated `pack_pos_to_offset()` during reuse
  builtin/pack-objects.c: do not open-code `MAX_PACK_OBJECT_HEADER`

 builtin/pack-objects.c      | 46 +++++++++++++++++++++++++++++--------
 midx.c                      |  1 +
 pack-bitmap.c               | 12 ++++++----
 pack-bitmap.h               |  1 +
 t/t5332-multi-pack-reuse.sh | 35 ++++++++++++++++++++++++----
 5 files changed, 78 insertions(+), 17 deletions(-)


base-commit: 159f2d50e75c17382c9f4eb7cbda671a6fa612d1
-- 
2.46.0.426.g82754d92509
