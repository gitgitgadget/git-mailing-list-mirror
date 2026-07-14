Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ED93264CB
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035804; cv=none; b=NnRGwy4UrgjDA6lc/ylPgokOoPBbV0YnhoYy8J171tM3fA6mZgotfV6u4UA+2yrramILV2/yEN/ik7rsYdEh0Zo6tSw659cENopGxN3qtanAz9CD6CtQetZzo8jVDyJdkqoCIUq9PdKRvvXBAWeocoJk0ayB3aeHqsNX3Mob84o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035804; c=relaxed/simple;
	bh=HU40+FF4y5JOKI6/gtWKnuOoFtDMqo3JuCK0qx1Py48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8XRnpF4oAnTqb8RGayMCnMLOQrdtAIprXWOffo/dE8SrYOOYJWyzdgYXwixzvlkbWhF9WMTnQ8mD98A4vgdGciWTsJlpDIf7AxBnR2Pt4uMfd5yFZZ0JJWIqhzFhRdJwTLmiBnPxLhfsuT+2mDTpaqvKmPxapgeqV/OMhhOsTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsRHKUgr; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsRHKUgr"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-69a50b818c8so7195063a12.2
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 06:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784035801; x=1784640601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Kdrltia/ePl/5ok3GxKoXOVWCxGzM7n0QpzFIs/e3c=;
        b=dsRHKUgrVTlSLXRzupwl6xJYlDGsLPLfN8xWvJrltxEsInz1Xzi+5w58cIyhCHA2mR
         VlnPGfs+BcCdnPP8YTQayt3oUq9lj99YUq6LutOaWD06bW61mdBPKXUuYQLhTB8z856O
         oKpvcpx8iIm5aKJDqjJjh7l7ZTo9eUeepKhrcKB71rswoQWGofJLXdoZSs+rA2On1ofR
         +wwDgboczFvbRrLyx+e0+vdf14fTM5MST8Eo1urunTpCUt+48uiIBUJxOSMWmJycpsZK
         yhNr7KjbYwNzejiV6Hxud1tYtdju5Jo+iRuSSy3pH0PwusP6iCZ54kTzChPBv6Kq+puC
         kUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035801; x=1784640601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Kdrltia/ePl/5ok3GxKoXOVWCxGzM7n0QpzFIs/e3c=;
        b=Jj/vZRrxq1b1NQzwHjBC5s9jT+32CaQVVp2Wn+usAgeotkQeSF/DL7VVMy8nu5nkux
         +Mewwc3M4xd58ahj/jmGns+KnTox3yRFxoPIS2VWlfUa2bCjIke6qAHnOB5bs52skJaF
         3dtbumKdMA/fH8fLYqLEMU0d3lYCvlAOUw9NYI0DILvCTAisljsD8ghyUN6fABrLQuLZ
         UYFm3b3GEW5nTHAvz6S33a0M7jYz3CIP+/G8pIPN9gCciOlvmkh8tymau0jCHD/0DTlq
         YNx5pdfn+sbLyCO969Z2ktcGhZQr9Vd3XKPEZ4non3d0MpddSbRr7D4WpJpfdSXlkSOc
         ykqA==
X-Gm-Message-State: AOJu0Ywotvn3InJXSMsS5GIj36KRjGhSf2vyE7y8/ZH5tlYVh8UbFLBo
	oQ3Ca2qspamMu/crH1Uli2KL9Rkpp+7aRxXniR9N2vJmZHCVWqRUjUlCStuW5iSd
X-Gm-Gg: AfdE7ckrfTbPhOvVg6tFj9DvwAf+QFrQ7GyRtwj0QLqYuN65tVIagQ3bMEWUOWjAFnc
	BdNVAN7Y+qfl6a+XMnJnUmrQmJsS5b7DO//xE7C62+V9A5NrXfVz36Vb3EWSGRsF5qywqnOGcVT
	GdNpTILM9Sy8arIo4W+FZrsZm6VOXvj4jpfEN7jEH1/xGY/KZrUEqDwzvfvHSHuyVq/CwY6NkJO
	pedBtcEVK4t2JqWYoVVLllU1+qgYQeS5voXtppIk/kmfSB3VD7iQX1XRPk/sixcxyxJ+rxANkAN
	nPiapVhrUcU1aUaAr1B8/feDNwxgrZofBG0tMlnRWequM2vZ9h2v4GGoK6WAO+t76q1OVVkt8HG
	dokU1wdk0vS+2qgTBYf5lqxVImB78hQBcv1261WX6xIx0RO50fzRX/uwlJ066KOL4nerdeRyOTu
	108cFhQiFQxaBtJJ3nYu56bypxYymbzzBshtGTFoLiTuMmlqKyiv9sSVHtU4A79vPLWsq5rKgZd
	2AD8EhLVakvuD7UWAu2UVQJHtBjgw==
X-Received: by 2002:a05:6402:3806:b0:698:3b7c:7e30 with SMTP id 4fb4d7f45d1cf-69c5f244010mr6017799a12.40.1784035800888;
        Tue, 14 Jul 2026 06:30:00 -0700 (PDT)
Received: from M-K2012N0113010 ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd288757esm1616877a12.9.2026.07.14.06.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 06:30:00 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH v4 0/2] fetch: make submodule fetch errors configurable
Date: Tue, 14 Jul 2026 16:29:55 +0300
Message-ID: <20260714132959.3368867-1-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710122655.3066377-1-paulius.zaleckas@gmail.com>
References: <20260710122655.3066377-1-paulius.zaleckas@gmail.com>
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
are only recorded when the phase-2 retry actually fails, or when there
is no phase-2 retry to fall back on.

Patch 2 introduces fetch.submoduleErrors (fail|warn) and
--submodule-errors=(fail|warn) to let users opt into non-fatal
behaviour.  The default remains fail for full backwards compatibility.

Changes in v4:
- Forward an explicit --submodule-errors=fail to child fetches as well,
  so the command line overrides fetch.submoduleErrors=warn config in
  the per-remote children of fetch --all/--multiple (noticed by Junio)

Changes in v3:
- Report a phase-1 failure also when the gitlink commits are already
  present locally, instead of silently succeeding
- Route "Could not access submodule" through record_fetch_error() so it
  shows up in the error summary and honors the warn mode
- Forward --submodule-errors to child fetches so it takes effect for
  fetch --all/--multiple and nested submodule recursion
- Add tests for all of the above
- Documentation: don't imply git pull takes --submodule-errors, minor
  wording and placement fixes

Changes in v2:
- Fix option synopsis to use (fail|warn) instead of <fail|warn>
- Add --submodule-errors documentation to Documentation/fetch-options.adoc

Paulius Zaleckas (2):
  submodule: fix premature failure in recursive submodule fetch
  fetch: add fetch.submoduleErrors to make submodule fetch errors
    non-fatal

 Documentation/config/fetch.adoc  |  14 +++
 Documentation/fetch-options.adoc |   8 ++
 builtin/fetch.c                  |  46 ++++++++-
 submodule.c                      |  58 ++++++++---
 submodule.h                      |   7 +-
 t/t5526-fetch-submodules.sh      | 161 +++++++++++++++++++++++++++++++
 6 files changed, 277 insertions(+), 17 deletions(-)

-- 
2.54.0

