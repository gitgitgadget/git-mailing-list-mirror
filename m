Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A687347C6
	for <git@vger.kernel.org>; Sat, 26 Sep 2026 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790414975; cv=pass; b=k2xrvULk/ckOQW5wCER49kKZlVJ9FJiAw8ejI+bE/Tc+nhnAkdOHZgPnIJ8iU1zATEqLDz/pqkn+oaZVQL8xpiSKSzGEH6gocb7m9m/VeqMzUUXwG4pSjiVpaCNR3KvcZQ/Q1YI56IJ6sRcf3mp+/MUsUiB/5H20q8U4paSa9DE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790414975; c=relaxed/simple;
	bh=tXsIjj4ffiH+O42VWxA5/02yUoIH41VQjL6hKdpQOPQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=cr7tQxNBPPLla2aLzKPzKDYZxRmiPZSoADrG5Y2ziZRZS+viTymB4KN6IrsWGdmYj++zqUzo3QSRsUtUARDElCe6v0rKmov3IERT9vHG/j423Nup0yqQulYaDfp6GJFtpbV+c1kiWob0Xqc+8/pjip75HOevoGKc2tF+5NO9N/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epY4LRGu; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epY4LRGu"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66d1447e2b1so911971d50.0
        for <git@vger.kernel.org>; Sat, 26 Sep 2026 02:29:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790414972; cv=none;
        d=google.com; s=arc-20260327;
        b=QL8wSUgN2XlA+RC9r5IX9Bt4MJD/gKUVMG4XxDDQI3jKjHN0vps7RlIiIayeca/3wG
         h3aVAgbefMLdmsaNvxu7Qx/1+5kaHSGLqXpMZN7LNUnjQT8vA0UK+JnMycKhk+Qzd/a1
         CHdPqG+sUfIC7UvU6P5y69qJuH7GKy4orCWZlzdRA5BNn4o/2KVczr4BIeWJegRduTls
         wsZV8TVwkHz43viiKjUCyf5FXR0Vwu97z9cwheJrUOrCEQsPxgsdS2XT3/lRi9pPxQ20
         oc4nMll/6TXNteZsG9zv9LBACUyI8GZMmTSAVXgTSBhtHS4A+SJkEBW762A7USh4IKh2
         eTTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=tXsIjj4ffiH+O42VWxA5/02yUoIH41VQjL6hKdpQOPQ=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=QbXHjVAYMqv+3/9zeAaiE1+tbkToNS3bOKrGm584qPq0BasXHuk+60j1LTyygSH3g+
         NJE1ynYEahiMAaJwCUwVgTR5bgjE9jBxW/3KoU9t4hEzNLt3uW5X3N15PPp36oK8hoqc
         srTd+t0OUTvmVHtDmELJMZV3y9Yn0kbrocf69dKjJ1eCJgLHAk30gbqK4gsue7xcmi5L
         HJwknM72ayLnBaFVsdWzyRGCvMIunZ0FmA6738R7+QEdvcKcrBC8USezHBYNU7NWCRfA
         8PdSKL6OA4gMFiiW7Yb8sYR9/biYtvQgKrlz1O+nFBHYVsjHSG7dJfHNAQgihrVDPqYS
         AHPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790414972; x=1791019772; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tXsIjj4ffiH+O42VWxA5/02yUoIH41VQjL6hKdpQOPQ=;
        b=epY4LRGuRbhqSOBZkOtGKUr5Ax1NHgBZRibHbUKyToehPU71RfpGv9qrwe+sShxU3D
         BCVs2lNKcd73c0RrVSDYTTGA24Vy5NPUSWqbz+uDwfv09ICxLVN/zFyeReqkmgeXPxap
         1MD3GhO7IQugNtSKLxSDerusZ1yM01P3Dl6sRLAQXATaMFRC9E7AcnL7QovmDL0+WwXd
         /aNu0mC1Y78o1skXsVs7tCxM93S7n7kFV4KrDDvq/1f8t84WP7vd5GXvu6qrcPO2JCRf
         5IpjYZmKfnVedON5Bnwqpju3cBzGfyKd3j3EFNO6TFlm5zyi7weS5dEacwzbj2fw6+nG
         FlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790414972; x=1791019772;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tXsIjj4ffiH+O42VWxA5/02yUoIH41VQjL6hKdpQOPQ=;
        b=2sr7/j9H3dteFfyMRc8yjf6JuZtI+U5HU0tYU5at2nAFybeHeQPwGBvoL8sYopMydz
         uejnfK/+4obfgTrJ1w7xX7kBfhWj2cq/3pvl/hnSQZrlGgMeyp160SyK/ZNZ4HPZbk7C
         ADgVn7NHVXJISgFkjqSlh+sOfzkTyr1x7cdFowRnbTgKs+WSMgNHVcRMPcwornS16OM1
         HSF5re2qVJmtrgFYPOlG9hvIMPB0W09mxPdthnoc9yj5JslhvBnTph+u7Lz4rVSRiIrL
         +tIfuqbCo89H2C3FZsE+99f/FtnsHiTt75X+dG9XRnUWH0RPleLLyVC5qSAWdP/scDzt
         4GMg==
X-Gm-Message-State: AFq9FYIggVXWt5OeBnHFbYjGhxqLM3q5SBmf//rQHvWR/SronZedtDE/
	edn4DklhjW4t76E2RKXGTn2vtG7R9JU+/pkoC1XUYSJIR0xDKyelIO8dwsyIzyD1L2y5m32G6sQ
	X054sm+amN3vcvK27hb1ePpQg413eZ4uy1g==
X-Gm-Gg: AYBFou0O/lRToPq6GOav0cec2FCE3NgYlJ4l0Sx62yyO+zHqksVPX6/ewPGcnlAPUJn
	Cz8l7F/+GEdS632E7+28c6uul5ltsiFtCcp9Bd3aCz10ZbyZKfvFPPXfqDtFOp0CysKvxPmNtD7
	0nQfOsy5IH48hWgzQhzI5uzzUSNMNqc5FW9ZrC96Q5aVMAYLRcEvguiq0VSewpousfsc6BphD2K
	UzTQAApN66hoyJInEHmxHZK2WPMSvlfSIjxrmUrEH02o6+wNXM2g1gmszQbDUftOuJbm+0D5A7X
	cCl38U+vOUzYOmTr1+45awyBwtfCsZtfPJ7KgNdsAFngHG0OMWJM9y/gsssXR4yi+ZxOuFp+Uoh
	94NMjXNnDKhs=
X-Received: by 2002:a05:690e:1504:b0:674:a09:3990 with SMTP id
 956f58d0204a3-6740a094193mr2232256d50.30.1790414972505; Sat, 26 Sep 2026
 02:29:32 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 26 Sep 2026 02:29:31 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 26 Sep 2026 02:29:31 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?TCBOYXVkw6k=?= <lourens.naude@gmail.com>
Date: Sat, 26 Sep 2026 02:29:31 -0700
X-Gm-Features: AclHuK965KBHnHIJXUZuM7yUBYpnaG_UVEFExKjNX3XaZCRlmjWBj0Qot8DMISg
Message-ID: <CAFhNnpth2=NFFbPpyt2GTCvAs0DrKkgLrmE5OdNb2MOUZc2G_g@mail.gmail.com>
Subject: BUG: pack-objects aborts on missing promised tree during fetch (Git 2.55.0)
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Following up on the earlier report
(https://www.spinics.net/lists/git/msg500476.html), I hit the same
failure with Git 2.55.0 on Arch Linux x86_64 while running `git fetch
origin main` in a `tree:0` partial clone of the public
`NousResearch/hermes-agent` repository.

The child command `git pack-objects
--exclude-promisor-objects-best-effort .git/objects/pack/pack` aborted
with `BUG: builtin/pack-objects.c:5004: should_include_obj should only
be called on existing objects`.

Matching debug symbols place the failure in
`is_not_in_promisor_pack_obj()` at `pack-objects.c:5004`, called from
`process_tree()` at `list-objects.c:167`. The tree was
`d0daf5223f2367bd20fc2deb9d66aed05fcd30e8`. With lazy fetching
disabled, `cat-file` cannot find it and `rev-list --objects --all
--missing=3Dprint` marks it missing. The clone has
`remote.origin.promisor=3Dtrue` and
`remote.origin.partialclonefilter=3Dtree:0`. All pack indexes verify,
and `git fsck --full --no-dangling --no-reflogs` exits successfully.

The child command matches `index-pack`'s `repack_local_links()` path.
I have no deterministic minimal reproduction, but another reporter
supplied partial-clone reproduction steps
(https://www.spinics.net/lists/git/msg511313.html). I have not
attached the core because it contains process memory.

Reported by GPT-6 via Codex on behalf of L Naud=C3=A9.
