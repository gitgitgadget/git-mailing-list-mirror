Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843F0422529
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 11:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783683608; cv=none; b=jqSHn9l0L20GahEbQ7Vk3iA9OI8RC9uU5XcvTfN6uaAjMV702fPXVlDLTyhZQ/L5pQNW9Ork/tli8h3G/62GyvmZn7C4LI33QDBxsLs3aYDK9GrPBvShnFApG4+KPe8u2uY+M16XkSzpJ9XHEvpyLV/SORqRAN5Za26jCkMLltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783683608; c=relaxed/simple;
	bh=sr1f0qQ6O50x5r4+y/d2slBXcQhg7Rqk9BRY2ISSBt8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=l+YDfteQoOctyi1gNnz2K0EpbMzfIBPZ2IQiufOvsdLE/KjQQWUtyHFlkANSHuHdz43QgYm3LodYmMV8sZhkjvc0mcCLhRFvEhApdnq3NJbDMKVH2r03ibljt2cy901RXUrvuwP++ewcnXkf2mjAMjb0W78KQOMiqARK4+niuOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeM43pNQ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeM43pNQ"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so820428b3a.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 04:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783683595; x=1784288395; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nQm6RMxlxiFsMprKaAxumkCDE52wCruRR+lK7ElYBcE=;
        b=XeM43pNQt/pQIVg5OVmcw4NOM7kmuetXvp8GrCaKS2Q0nsK2tNgAjOsM1bD0uxDH8Z
         fak8f6PaEuHspm3Xaov7PhoiU7CasxAubd7pi80DAtcP6ytM1D7HLPC5wWD7Bvj0GAB6
         O/S255yLxagaMDzVMGOtLOJ36DsLahtYTat6swwBbtBlKibjl+FGeVJ13wPzyO7fZXYM
         k0dap60KfVKlZ/dLDbfHE8ncOEIV7CPQkGVhYe8g9T4ASOFCIJQNz3cXhmLZxgSGzQ+/
         B3QhociFwNnn48D0HLUIDiEorl4VqKaP8DG7O2PukoJRt+rVN/IrWvDxzkNdo+Ty5JP2
         xXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783683595; x=1784288395;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nQm6RMxlxiFsMprKaAxumkCDE52wCruRR+lK7ElYBcE=;
        b=a0CO6jBTPJ3AZ5Qbzzsg3QzwohzKQeQqZhh04dFOYjd2hoPSJ9X3LScICKG5Jidyd6
         HKzReA24meZrY2QHtUvKX3szYC5Z9oOveGminVnQg3MeEPzEJvlKBG5LYX4RxyAIqbKM
         K36UEN8HE6gDQhAV1DEUd6UDwO3IxpsTAi6P5sQZMB3IAZKFexjMdHJo56ghPffs+7YL
         vbw+SiXUj4x5Aw3UvqaL5paqyZwFtg5vuH/7lhGLD+awXdxM8/YG5yC5loU7NBewityg
         fqjNtmvSRBUQz9OBKZrssVDE4pSDC5yf/BQ8ZfiURofi7yLcSRybIm6VaA9HVQRDM2/D
         GHdg==
X-Gm-Message-State: AOJu0Yx+19VNyayrGF7kptPnLQ04S4NZQV3Kej4ysfBKYseWxzBo+JqE
	gt+uDSKRcXZHV1z2k4HqS6koAZ8R8ur5mrBK7fGYhGbuRxN7DDrrB445dQKjfi4R
X-Gm-Gg: AfdE7ckk7sQ2rmKWYqhooZ9ZlKbqS3NVIePIsb0be1N1mEBB5E4fvO8IGOfWR5K0A3u
	EBG/tYYIE1MZG7v0xStOPchPFkJMzO3Yz5Scw/oVj1KKm01+bkfzbvIRiQA21ON/O97Po+vHU0u
	5BNhpUKKxAXbDNkUYmIhKuINNpB5SuJsAk7+su6Uy0rx6RKO0wx7lZz6q4TzGHEyHMwmFNfVAws
	Bn1fP1XyxEMAimYyQa2WkcZV6EZx9TQGrODhGrl6pynSe4TmLM9f3gBCQPIV21J9jvKDf7+5v7c
	4cAOVwdKVmGLzpo/h2UUZEKbFx526f+QPKdSDLOgPaK3lajx/XmPjqtavmziZK0w+KZcp4Zuwhh
	5pbf2+5QVo1urAbCuoVWYX77jK5RnWXAny4qzDigNRusWoCoaHJKnxa99kKKoUsxOsIwybyVA+y
	JART1RZXW9B7Yro3JqzAitAGFIMiE=
X-Received: by 2002:a05:6a00:998:b0:842:50fd:4c13 with SMTP id d2e1a72fcca58-84870a53825mr2985961b3a.4.1783683595210;
        Fri, 10 Jul 2026 04:39:55 -0700 (PDT)
Received: from [127.0.0.1] ([172.185.47.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6db29d1sm10192253b3a.53.2026.07.10.04.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 04:39:54 -0700 (PDT)
Message-Id: <376a6581cbdc3c5df624658f19cf19aac7694bc7.1783683577.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2174.v2.git.1783683577.gitgitgadget@gmail.com>
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
	<pull.2174.v2.git.1783683577.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jul 2026 11:39:34 +0000
Subject: [PATCH v2 10/12] bisect: ensure non-NULL `head` before using it
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When `refs_resolve_ref_unsafe()` is called to resolve HEAD, and returns
NULL (e.g., HEAD does not exist as a proper ref), the code falls back to
`repo_get_oid("HEAD")` to try to resolve the OID directly. If that
succeeds, execution continues with `head` still set to NULL.

Later, that variable is passed to `repo_get_oid()` and `starts_with()`,
both of which would dereference the NULL pointer.

A concrete trigger for `refs_resolve_ref_unsafe()` returning NULL while
`repo_get_oid()` succeeds could not be constructed against the ref
backends currently in the tree; the naive case (a symbolic HEAD pointing
at a nonexistent branch, in either the files or the reftable backend)
fails in both calls consistently and returns via the existing
`error(_("bad HEAD - I need a HEAD"))` path.  Coverity, however, flags
the leftover use of `head` after the outer `if (!head)` on a formal
reading: `head` is still NULL at that point, and both `starts_with(head,
...)` and the second `repo_get_oid(..., head, ...)` in the else-branch
would dereference it if that state were ever reached.

Removing the outer check would risk regressing to a crash if a future
ref backend ever manages to hit the "returns NULL for HEAD but has a
valid OID for HEAD" state.  Assigning the literal string "HEAD" as a
safe fallback documents the intent and satisfies the analyzer without
changing behavior in any code path we can currently reach.

Assisted-by: Claude Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 408e0f414e..dccf0be6bb 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -811,9 +811,11 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 	 */
 	head = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
 				       "HEAD", 0, &head_oid, &flags);
-	if (!head)
+	if (!head) {
 		if (repo_get_oid(the_repository, "HEAD", &head_oid))
 			return error(_("bad HEAD - I need a HEAD"));
+		head = "HEAD";
+	}
 
 	/*
 	 * Check if we are bisecting
-- 
gitgitgadget

