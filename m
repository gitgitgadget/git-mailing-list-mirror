Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAF63F4138
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590172; cv=none; b=bYC2kYcH1YDdQIfzpFCj4m4WS8rFjQDqetLoQoQKu+1vfbV/fz7BC8cPW+7BWOP7MjKJ1KxGgOT/j+gz/EEbF6K+63mgg7R3wHQnMKlT/ZNmLEibArbW9/1donh1KA7918ywsMiKGN9jKktpbjpU+AzJGCU2ebplMzRB4croZ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590172; c=relaxed/simple;
	bh=3+C6elnFoHqivaBIEZzTyKh6+/Yq3Cbvs5ZPpMGiiEA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DgSSWaXX6M41ZXAMmBp80xOkt55j5MRjnDuY7cMiDdrhsbA5cCkZuSFP4g/UQe1jU+pBafb33VAxFZ+JQ7IqY8NN6BusWzqghV4hiB7xB9hD3OjxjRLTKWO2oe3dYyDJfLNfCTgs5tBvrCqr71rKjYSQz2gVJjsltqj/jGlperI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sB/ljVn1; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sB/ljVn1"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c1d487f2cso15168121cf.1
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 02:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783590170; x=1784194970; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qjjnCdHCh/jH0lRuLQclLMSI12/uJV2sFtK46bRAD2U=;
        b=sB/ljVn1p3NjyJIkqU2J5EbJ/4doOwm+qHy5Fjt6Ikep8uVvBleIslMeK6FVuT6cL9
         z97P94NNBuc7FuGRTxc7+ewVyeyBowzzOAs749ydAyMnNCVvjRPVmPSqX82y2K8Bl9b1
         VArT+uW5Bof9SS/wymG+MireckYeFWkX//rFO72YDTZaA6cQAjaUvJaFlmJwuOJAXXGO
         JJQ72gTMA49GyW3bx8SOaPVUqNRrgEBll7ZcMuzz+5jF4C125jECBi3m1G1yH5PY6Teg
         8dS2pN54SGg6TMk/yYddyq7GBuzdl931elM44/WdswXs0+J/xENjW714Dp1Al67BEoVJ
         Uo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590170; x=1784194970;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qjjnCdHCh/jH0lRuLQclLMSI12/uJV2sFtK46bRAD2U=;
        b=s0xkvS0iGOgC8/fgArdlPGfIuE9/zo0xsSp7zR7GpJ8Mn7SKy7nf0Utz1RxhmnmLSU
         tjyF1LkvG45uWqjkxzP/XRBvNOk+2t9DGYXsJpaatGeahRfArxtEYGNZlLLZG3DJDBRz
         H0eCljD9Tm391IfFiTh02ZxDiOS6Fw5hBHJV1b9MmOOK01UmcsAzyhyEaWEvOsbCL3bB
         yHXQeF9DNIc9Swai/DIV5NhJh1+0kMhZMQVU4PaTmrrJt6xjoJl3DF4+ox9K1jJFTT5g
         fUee1NVGU2d1HWEDSJS+KcGsOyo//Cl3lyV5fn2wSXhmvxemB7hfqJ8Qmmx1DO8a6ePv
         HnrA==
X-Gm-Message-State: AOJu0YzoQL5MDP9MXkj1QRZO03pYdX+7XzQmIhXFWgWawAyI50WNw0ko
	VXEZMn2ZSbqUyUTxxztp5SR4Uh2gsuR/SVdC9CyDqchI7+6qARe7M72gtZf9Ryzw
X-Gm-Gg: AfdE7cmeJHtUuqtmR/uJ8Aa5NMdV/eQzrkEcmmRHkBH2eYkJ3+I1PqnW3hQh2Ilm6ad
	5QiO5ue7jioT8wobMiSdyDGAZKXwbzmnDiW1H5pCnpFAWQAFN5qPbmRuG/TsCO6JSM4qtAvPsxV
	TwxESrehBrdhZtw4DLUVo0h1kyvYRBeXX5jHTddzhIjl42aM/7opLTuvOnbm9/FilHPhX7rya6r
	Cdyx8Jpn3G/rAHKa9XPtHUI0hUUpDNOfkaOGh46Wij1ZhyeIPbA2YZKdpIX8G28UeJQ8rWeq/XF
	OcsJ0ivDFrvpWRK0NWjm3bYnWSvjalCPDkW403rl9o/m0kiyIcC1vAAEyQ02Wp0Yq4Lw78Mv7o1
	rn/e1y8zTSWXwL/vHBaVgDFqzoSpgUUKw8EFX0VT33whwZkVmJ1ZWlUoO2oGPs12XJr9dbww2AL
	Fhkb3I28gMOC+/
X-Received: by 2002:ac8:5fcc:0:b0:517:98e3:d939 with SMTP id d75a77b69052e-51c8b48ec53mr71890001cf.49.1783590170380;
        Thu, 09 Jul 2026 02:42:50 -0700 (PDT)
Received: from [127.0.0.1] ([20.84.47.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd56bf115sm13807836d6.12.2026.07.09.02.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:42:49 -0700 (PDT)
Message-Id: <0675767797f103b79ab936e01bfd06747725bcad.1783590159.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 09:42:35 +0000
Subject: [PATCH 08/11] revision: avoid dereferencing NULL in
 `add_parents_only()`
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

This function resolves revision suffixes like commit^@ (all parents),
commit^! (commit minus parents), and commit^-N (exclude Nth parent). It
calls `get_reference()` in a loop to peel through tag objects until it
reaches a commit.

The existing NULL check after `get_reference()` only handles the
ignore_missing case, but get_reference() can return NULL through three
distinct paths:

  1. revs->ignore_missing: the caller asked to silently skip missing
     objects.

  2. revs->exclude_promisor_objects: the object is a lazy promisor
     object that should be excluded from the walk.

  3. revs->do_not_die_on_missing_objects: the caller wants to record
     missing OIDs for later reporting (used by `git rev-list
     --missing=print`) rather than dying.

In the latter two instances, the code falls through to dereference the
NULL pointer.

Handle all three cases explicitly:

  - ignore_missing: return 0, matching the existing behavior and
    the pattern in `handle_revision_arg()`.

  - do_not_die_on_missing_objects: return 0. The missing OID has already
    been recorded in `revs->missing_commits` by `get_reference()`.
    Returning 0 is consistent with `handle_revision_arg()` and
    `process_parents()`, both of which continue without error when this flag
    is set. The broader codebase pattern for this flag is "record and
    continue": list-objects.c, builtin/rev-list.c, and process_parents
    all skip the die/error and keep walking.

  - everything else (only the `exclude_promisor_objects` case in
    practice): return -1, consistent with `handle_revision_arg()` where
    the condition only matches `ignore_missing` or
    `do_not_die_on_missing_objects`, falling through to ret = -1 for the
    promisor case.

Note: the callers of `add_parents_only()` in
`handle_revision_pseudo_opt()` treat any nonzero return as "handled"
(`if (add_parents_only(...)) { ret = 0; }`), so the -1 for the promisor
case is indistinguishable from success there. This means a
promisor-excluded tag target referenced via commit^@ would be silently
skipped rather than producing an error.  This is a pre-existing
limitation of the caller's return value handling and not made worse by
this change; the alternative (a NULL dereference crash) _would be_
strictly worse.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 revision.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index e91d7e1f11..7f3999b551 100644
--- a/revision.c
+++ b/revision.c
@@ -1903,8 +1903,13 @@ static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
 		return 0;
 	while (1) {
 		it = get_reference(revs, arg, &oid, 0);
-		if (!it && revs->ignore_missing)
-			return 0;
+		if (!it) {
+			if (revs->ignore_missing)
+				return 0;
+			if (revs->do_not_die_on_missing_objects)
+				return 0;
+			return -1;
+		}
 		if (it->type != OBJ_TAG)
 			break;
 		if (!((struct tag*)it)->tagged)
-- 
gitgitgadget

