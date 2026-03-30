Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FF935E958
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774892450; cv=none; b=K1IBArGnjYD8leprCPzfVT7Hg0OCbG8c8wJ346WAziWDCL7eyiVV5TOgy3yMUne0Ixh4O950hmAzv+gfK3AKhQ6upKYjF+cr/4XsGjx3yvJYgAMxvTJTL3rVQyKxblwex6Uimh8j8erHrXySs0nym89Iw6+wVCF4UlgGzk7jpQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774892450; c=relaxed/simple;
	bh=uHksznb00j992PNpRFZbfqGjjsGbcZIX+2hDUYEu8z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qVC9c4hgUbWbphxBD/YmreJYjYQj0YiYXf0/TyEQSfqthnyy+IKapxvcL4pUQGZJL09BllkHXyL7w7Ny62EE51sOaeWxrCSUvYjWoRiTxrztNKWoQ5RY7NwWwl8WdNN0IMkPxTB97H0GpFApGdD43gFCGJxMat64KZxKeOI13qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pGH1Uicc; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGH1Uicc"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-66bb7e098b1so1550408a12.3
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 10:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774892447; x=1775497247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=doFZ0EKWaZ4wjw2Uot68hEKs4Q83oDeG1tVTxe18GTk=;
        b=pGH1UiccePnZhUimNtOl0UM4KUe8tWYUpf77zHIFkxe4NPVZ1DV0ZoqGxRtB3VfiGQ
         QnPQsV3+SsGtLg8oABS7IUkynJZ92bVuicpw/243nQ5GtNNa6DnjH5b6qv5A84kFCrl3
         vo+FjZ0HlCYmNbttgVq1hGpeyGaAMnyqeDwUPr+Fi6Cfr0ytyw/+lQ7zZ9fvPD5sOqkJ
         pvpQOi1DCDY74R13jVRp2dXkLd1hU3EpBjbvMlchnrwxZoqz6O06SBMmrOBQuWfZrrcb
         q44W9p+Ho00+m4r0+bYP/nHAEaDZ+MObbQ8y88F1U0wOY9LIbpZBl/8NmPmgRwOcBw0j
         x3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774892447; x=1775497247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doFZ0EKWaZ4wjw2Uot68hEKs4Q83oDeG1tVTxe18GTk=;
        b=gnX0Bt4OZPYE0Y7BHKQutAb31Uombw4SZ2kLhqCeTkJLTD0YDkhjF3AEjw9PgjW5rl
         +HMjaD7phPFIZgBPJ4vabrbgkbWFSUwMTv3UF5dljcV8dJXCMFO48JodcxBrSph8lsTz
         86vskwGFAULMPTblHaWeJ+Mlv28F7b6vyhw/dks1PV5aQkGhrE8HIsxYRLWc5gXTfgqv
         TqF8Q4lZ5YSwVM6od6P5JylQ4ZqeqELHLgvffPX5w7T4jxMzJ+Xyi7NUOYBRK1z/fY1p
         +n4/w32WAOuBdVneP93SaIufV5Xaibcto6eHVwtiGnjD53b9d2jChsHvYtSGgeJ0VWN2
         ojhw==
X-Gm-Message-State: AOJu0YyZ6+HSxDx5uTJxECIuMwELMILVrVbmEg+i2lwpWgZLP9XHmW/P
	ABM6sr8G3x0k3J8PI1xQlDXrwxvayDrCt/dTtsW1edHNoBIxnWDHD7GKK4BhUg==
X-Gm-Gg: ATEYQzzR6m/XdokMisiivZVspHmkwkUZdHV/vLWUFI/0uYyyl3LudihJwk598GnkffU
	d6KheGGcvYCBBacCSJDjKsNhUtXUbWqiJ9xL4R2MyuKW9jr1bvxCtB9U+j9IrDcSAry1uTRyM2d
	E9OG64g3ZV1qiIspjiWOIv9saYIIOQq9wIltN5mOuxYhhWzEyp1D7kaYBJSivWTZrcNLKsccNTr
	VxWBJj2+mhfJdi+/+qKIOr0L7uXw4OHj4rJe0JrKJinxQY000z/aYYp1IliFL2/F7eVsWavGX0U
	fp0cvEg4VPQeM2C7EviI4qE+Oy4BJxLJfxvMCPT5dDwZSvFEohlEVQSGrTpx7MFdJeOGd3cCsnE
	JmCh0Qd0svaI0Ogm2i+1wqOJ34KyOVdKT9v2gHuY8Ruu74p/7QnmZeGoKCOpyAw1rNJ7pEBZcBI
	7CSdpMeaEZKIcPndNuWW6ktY4ZM2xTGZaXZ6uetC4d4+chfv/FPd4YYuIj/B4U5oybfiYThVNpv
	kqSOoEWJZ9aftO8vuD6IlDWaHODaMTL143MN7GCmE0MtLl8L+41fMPy
X-Received: by 2002:a17:907:948c:b0:b98:40a3:aa0c with SMTP id a640c23a62f3a-b9b50351487mr831276766b.24.1774892446366;
        Mon, 30 Mar 2026 10:40:46 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7ae520c2sm320769066b.21.2026.03.30.10.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 10:40:45 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
To: git@vger.kernel.org
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH 0/2] fetch: make submodule fetch errors configurable
Date: Mon, 30 Mar 2026 20:39:36 +0300
Message-ID: <20260330173938.3792358-1-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When fetching with --recurse-submodules, git currently exits with a
non-zero status if any submodule references an OID that is not reachable
from the submodule's remote.  This situation arises naturally when an
upstream branch is still in preparation (e.g. a topic branch in a merge
window): the local branch does not depend on the missing commit, so a
hard failure is unnecessarily disruptive.

Patch 1 fixes a pre-existing NEEDSWORK in submodule.c where a phase-1
fetch failure was recorded immediately, even when a phase-2 OID-based
retry was about to be scheduled.  After this fix the existing fatal
behaviour is preserved but the logic is now structured so that errors
are only recorded when the phase-2 retry actually fails.

Patch 2 introduces fetch.submoduleErrors (fail|warn) and
--submodule-errors=<fail|warn> to let users opt into non-fatal
behaviour.  The default remains fail for full backwards compatibility.

Paulius Zaleckas (2):
  submodule: fix premature failure in recursive submodule fetch
  fetch: add fetch.submoduleErrors to make submodule fetch errors
    non-fatal

 Documentation/config/fetch.adoc | 14 +++++
 builtin/fetch.c                 | 39 +++++++++++++-
 submodule.c                     | 52 +++++++++++++-----
 submodule.h                     |  7 ++-
 t/t5526-fetch-submodules.sh     | 96 +++++++++++++++++++++++++++++++++
 5 files changed, 192 insertions(+), 16 deletions(-)

-- 
2.53.0

