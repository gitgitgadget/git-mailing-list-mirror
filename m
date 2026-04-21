Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7708F175A95
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 00:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776731177; cv=none; b=f/tgd/GKjivX2zeej5YMGkuONRc+kB1AZmQpBhyTWi1l9FATPS/TR8ADpgWe0DmnNCOFNBZM1eAZjXY/3XTkKR3WXMWamS6niMWeOeiQHRRJCXq5lIxy1VaDfMijDAu4V4MxRm+eYekovDP5hv1CKXXpL3xPutPZDv1inI+YNYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776731177; c=relaxed/simple;
	bh=FotFHbrPPvl+hqmWM3axYffDJr2Q3vyGO+dx28IX9c0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=EzN1janKAGuev66bCPjYNV08+ISfaHxGdVYeFYziPNcLFm68SyRB2w7eakj02EB4TUK9EPQZkc6BMRjqUm9T4fFQRSyIJu3reBxOU9Dg1yWgcvw64DoB2WPcC97aYGWlA/KLFEUhpupNnXOCZpuypzRauzAyA3SyfjkyRA/ghUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iga1TyTu; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iga1TyTu"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8a48deebe95so29318376d6.0
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 17:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776731174; x=1777335974; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0bOIf+sew5hF33LjdsACP1+IiFF8AVnM4A3JIthae00=;
        b=iga1TyTumnYtxhuzyjzBWHE7m+MBP7CgvyhfezDiYP29BfhgIglPrAEzdQEaxNma9n
         6i5TBKH04vlgwvRCzGq10JYi4O2xSYBOWDNdeeUmh3ukDRxDsYOeUcWolZPh2Sw/Bvx8
         U8GzzlqxWvnNaa6BZexkArT76xepK8g7XWVKIMk9qCdaTM2XST2KrZhfJUFYT5Wh6pAx
         8GaPhlJb24H07W3d1J7tejR0Amhpf1LCj0MwhICICBm5mORL1OTccdQh7UnMii+qS6yO
         5BkUaBDN2dbAiG1mo/vGdfn7kgL4aK0szt4T4sF8sgMPKLKDJG3OuhoDsJndHOaDQICj
         fylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776731174; x=1777335974;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bOIf+sew5hF33LjdsACP1+IiFF8AVnM4A3JIthae00=;
        b=BnSA1UcwxRbp84qU1eNtxccWvIHLPOSaokv4zMV8v0xkOx/30cZgXYh9czIwkY0Gtw
         6y1BULYXVeLIDhJF8cvHlKFYxSa6IgAjsqFurb0JAhy6maHghKONTPw2CYtozOnfDTg4
         c1v3G+si5MRcQaThw5w/VnYLnoFCMtK7cUGJulIjaEpCSeIfj8t46jAD9fVWN01O6KUp
         KxinhLHhzxoCSajXvwvv1V9JvyLkhnLIANzNyv4Nva8FLX3rKh2gfSg6WP8OQnOi6zvM
         tWsPigAIswkiQj851jdRDq6HqMjei/nfwEcapqvFiHfFf3W6Y1ias3z28yikSrQx+rfs
         7ymg==
X-Gm-Message-State: AOJu0YyNtplRNvP91hUEniaeXDs4VXdSb41Y+QN/23SP3Zm7E3A5k66P
	Sz4zoYcPBOtavyXxmooNnLBkn1qPG3M4w7LimG+NPFc4kbphhJS4BRQeqlDzdQ==
X-Gm-Gg: AeBDieuAs9UvsTq9NpH+nb9NkzOBwPPfelQYQ7a3nYtKECaNPyIMSqNd9HbAW9fygU0
	+HER1c5KxNYdEGadlTWqmutTS7Mz8UMtyUJojfiuSGPG5KjV572yLkmBgP2RrRVo2elRA13oV21
	d3FSPjvl0/WJIu43d+LUhGruWhy9pWuPQnaw4vVpzUGK8R/D7KnsXu563WPjus4hYP3wKNt1hjs
	SnFfJDjz3pEEbOa5OsTjFi/b3GPBVxoTImEN6OaNQEwGJsWSjq208jQqUNiFms15vXMCiexeww2
	EYu8pSRLxc7sUayvYfHONJkVBTI/Zvc/n/YdiK9FssJ6O6MnhhkW+kaxNxbOMqovmCvJeBhy1uY
	aXtENhPYRTYyikhxRA3pnkq/ZCfRi9SdwTMxdfYmmrs39/43yU7Rc03yZqSGG/wzvujPxtpgPES
	KDyO0h2mA75VA65vjJz/NOmETY2a39LCm10OSY
X-Received: by 2002:a05:6214:e63:b0:8a1:6529:5ac2 with SMTP id 6a1803df08f44-8b02803ee1cmr268423896d6.13.1776731174154;
        Mon, 20 Apr 2026 17:26:14 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.117.99])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aec3a3bsm89403206d6.49.2026.04.20.17.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 17:26:12 -0700 (PDT)
Message-Id: <pull.2096.git.1776731171.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 21 Apr 2026 00:26:06 +0000
Subject: [PATCH 0/5] Duplicate entry hardening
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
Cc: Elijah Newren <newren@gmail.com>

We had some corrupt trees with duplicate entries in real world repositories,
which triggered an assertion failure in merge-ort. Further, the corrupt tree
creation in the third party tool would have been avoided had verify_cache()
correctly checked for D/F conflicts. Provide fixes for both issues,
including 3 preparatory changes for the merge-ort fix.

Elijah Newren (5):
  merge-ort: propagate callback errors from traverse_trees_wrapper()
  merge-ort: drop unnecessary show_all_errors from collect_merge_info()
  merge-ort: free diff pairs queue in clear_or_reinit_internal_opts()
  merge-ort: abort merge when trees have duplicate entries
  cache-tree: fix verify_cache() to catch non-adjacent D/F conflicts

 cache-tree.c                         | 46 ++++++++++++++--
 merge-ort.c                          | 78 ++++++++++++++++------------
 t/meson.build                        |  1 +
 t/t0093-direct-index-write.pl        | 38 ++++++++++++++
 t/t0093-verify-cache-df-gap.sh       | 59 +++++++++++++++++++++
 t/t6422-merge-rename-corner-cases.sh | 54 +++++++++++++++++++
 6 files changed, 239 insertions(+), 37 deletions(-)
 create mode 100644 t/t0093-direct-index-write.pl
 create mode 100755 t/t0093-verify-cache-df-gap.sh


base-commit: e8955061076952cc5eab0300424fc48b601fe12d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2096%2Fnewren%2Fduplicate-entry-hardening-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2096/newren/duplicate-entry-hardening-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2096
-- 
gitgitgadget
