Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BAE423E8C
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784111725; cv=none; b=muh5QsGFSAjlgUimuNMrfuxmCtZa8IcBoEzPgjwGmTjmqg1Uk1gxPiAVk9Ba/pfJy04JFgi2+m7B50hbad4PHOx2QUw1gHybUW9ShnsZ4UifUDl0zkjgP8bNhGOZyKQU5nGvvkRXcbYcM0mSqKmOHj35ObojP6FQBgbWrJwL3G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784111725; c=relaxed/simple;
	bh=fPGBWeAGlv+szsh176Yfb79LmJcVeGL+cIXxfrJu9V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mSjNjDr6AVzc1LECiXKdDQo7JRW0M/Awy4sn/wDdf889dvpoYtdjiTxXLaDTHHsFvh5d1VsNFyKT8h6Q7Uq4g+8vajHAruIuXkHBUT4fxkQMiD6WNqZOltx4fK66JwIH2oRUpVbQ/Y+b4iQoajT4/+wpTVJMgAqxq8m4Z0coz6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U260ZMEx; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U260ZMEx"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c1677c91969so86185166b.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 03:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784111722; x=1784716522; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y+vSayVLjS84vEi+EegAeGTWI2uZAq5g2jzJha58MSs=;
        b=U260ZMExpzuQ54AfKbEaJyeIKk8+TFJ7D2zI5Cu0VOLdVmJWXqOh2kwr6Rm8j6Q0VL
         Z7zFAsiMRCf3b25ASJmoxY1O20uvFYSzO/DncFtsPVF/xw6AErLb8e8sVGFkp7adTwhQ
         DEfWJ9N5p39Tvx1C06kYOIjROg8vGtYZfUFDLd2rIKGggRRtQ0KVATqfIjBkIStcf4pw
         aKg7XrljqEme7YzqmIF9hTOeMhxeXKnDFXqVOQaFE+BCKiYrDtSRRh3evzLFU50r/5dv
         xzX2LfoowF/mLai1H9AI/4mlqDbkLvuqA2oVupKEZB76woLLUo/joEKx07gyEn+PdI3h
         egMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784111722; x=1784716522;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y+vSayVLjS84vEi+EegAeGTWI2uZAq5g2jzJha58MSs=;
        b=U+mTBZEgd5IR4y9JDd04tdv3hN/HoXpU4eIyEdSTSfgnT5ria+dt2Oon9NulIx4ZoH
         LqFc4tZrFgliOV9xl2+pQOeLgnHVdFETYem9/ydx6Wh8rS1E2MX8ZrPpci8SfKWzKXzc
         zwzcUpLArALs+QtWzdqnqgFteUf/spIzPovh+DCggKUNCcV+SPpNGTJiK1MKCJ6upIJE
         M4U43zu5mTYwpTj//sRAlP0g1obIGKI8vQo9MINTm6VKxe/5wv8plUWADyRbh853vmx/
         S5cMF6nCW8SRvPhJ6u8JsB6bPQ9KEwtDmkE/NcBWGlWLa41eNxbSlNlisR4dUmuqVOIA
         gy+Q==
X-Gm-Message-State: AOJu0YyR28l9xulFljnBA9IqSGyPwZq2KWY+xIeQ9cX8Rbb5vqorKF2S
	ilGqfiUwYllTTbrrbpSQv6lq0BC5UZNcdun4htyZXmTXUvhacI2+h+SIFDoXURWe
X-Gm-Gg: AfdE7cmU9Bd3yMdUHnxsjGpK4TeCpU9rpUWuPS/J+4xOcZWjYlbJMBQNEyWnYN42dof
	t3uLNzDBRcNbxAk4C+xffFu5DOj9nmIoL9eEXKKli8TBuf3COTiFeXyGIHrVwRn+7xF0MdpBj4A
	RHQfpB+0C5MvZ2sg6TMqgCj+q0XGEiXrmvW6qiXVefWchx6l73e+2xwF6DBFMy9WF7HKYeiNIT4
	WHlcNNaj+z0ImqWiJn5+2GlgTIQ2NWucc5B2/w0Arej/WOhnlaIcp084+jVI+YANIhswSkM339Y
	Sa9u0olNVKJrBSrjK9m+OfTWK48E/cQrsuqYoPX0fPBDevVMVc3U6LhIvMsbIoipIU9Cw66FAft
	P5nh2tqFY3SZserXMfSDGXmFutvSp6mPZbAvt/lnrSexFXpBzJoCjNSdDlk7pZ/FLMm78LJyJj/
	AZxYaZilY0lHK9W6j+GrixcMn1lv/dnWQqsgEzbmjX1bMHgKFXD1QeiO2YSP1CWtdOh3qU3SeZj
	6AZcMolIRv7aKlAE+GDB0FRjgucj+/PiuYwkXbd85t0f8OEKuLan4UM
X-Received: by 2002:a17:907:7b83:b0:c15:a30f:82df with SMTP id a640c23a62f3a-c16794618bfmr145097866b.49.1784111720916;
        Wed, 15 Jul 2026 03:35:20 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168716aa07sm1765566b.14.2026.07.15.03.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 03:35:19 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH v5 0/2] fetch: make submodule fetch errors configurable
Date: Wed, 15 Jul 2026 13:35:14 +0300
Message-ID: <20260715103518.526326-1-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714132959.3368867-1-paulius.zaleckas@gmail.com>
References: <20260714132959.3368867-1-paulius.zaleckas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Changes in v5:
- Use test_grep instead of raw grep in the new tests (Ramsay, Junio)
- Parse and format the fail/warn values through a single name array
  shared by config, option parsing and option forwarding; values are
  now matched case-sensitively (Junio)
- Credit Jean-Noël for the v2 documentation fixes, which I forgot to
  do back then

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
  (Jean-Noël)
- Add --submodule-errors documentation to Documentation/fetch-options.adoc
  (Jean-Noël)

Paulius Zaleckas (2):
  submodule: fix premature failure in recursive submodule fetch
  fetch: add fetch.submoduleErrors to make submodule fetch errors
    non-fatal

 Documentation/config/fetch.adoc  |  14 +++
 Documentation/fetch-options.adoc |   8 ++
 builtin/fetch.c                  |  72 +++++++++++++-
 submodule.c                      |  58 ++++++++---
 submodule.h                      |   7 +-
 t/t5526-fetch-submodules.sh      | 161 +++++++++++++++++++++++++++++++
 6 files changed, 303 insertions(+), 17 deletions(-)

-- 
2.54.0

