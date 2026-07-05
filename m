Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993B536C0CD
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 08:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783239877; cv=none; b=OTUg4fyx5SCMz5cYh1NOpUi7pJr0Qop033ciYQEwhTkqIkC+UYuG4STa7/d6ObRPLh07ZkMmTzev/hDrsX1uVKuItriFRpv2owP5EdwhsMwH+GF8GRsmiXSndjr+/Mf+r6hU4i5OYE+iZPxxEyFpwQ0a3+xVU43/D7/70euov6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783239877; c=relaxed/simple;
	bh=a9pkDZlx+4dvdN0bwsTBba0CBVHtb/MsxfdVN/YRO/U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ssTk5et3Yu4k9qVxqr/9u5fq1eFeJVNV3Yx73SOS6ub3BMYkV5zDsrutCzdTvEt7r0obXaBMjPo3zxyEaWBw5ewMQBWjlHiPrE+akNxdbI4im1PMjDZ0E7yNyjq9r8t3ATnkw+knAvtAqf5c5NMGUDfoGi1b/4hgnDM0h7nqTnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0NMcBPi; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0NMcBPi"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c2b2c9eccso14104361cf.2
        for <git@vger.kernel.org>; Sun, 05 Jul 2026 01:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783239876; x=1783844676; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9X8KVP4mbwb4VKLPiCHHiqc+lRHfgOwY/vgXjtz9fiM=;
        b=Y0NMcBPieYnSNykuvrrU2KQ2fWEKFjr6RLkNCzS4DwLp9p7012lqR/Y+VMggGhDjIo
         Or/Cd+b2HrxLVJIHjIAax8Lt62xKIlTRoVrjLo3ztjYXDtK9gItBMFJHqMrPbVfP8G54
         KRlKOgF4h0lKpFzVr+XASednwqA4qidMC+kQRkSAFFv04cg+G50Vc0g3hA5x5JVBIKyJ
         4Y6D38DNVKDRHiAOU8Miei1W2QqGIuj/w1kR8Iee+fsTy1k6/vylScoiSvbWvOgAsEfG
         TnS+H7ZNklk7G4wUbfe3UZDIDfAZ57B5lV+WLcj849KjnU13e2mL3sQ/vaXiNYDIWVYE
         SPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783239876; x=1783844676;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9X8KVP4mbwb4VKLPiCHHiqc+lRHfgOwY/vgXjtz9fiM=;
        b=U3JpuCCWMSKbqa+nYY0zTK/IQj8ERP/9k5PGRegfHp+Ac9mJZ+EdbJn+ZAe53rgi/J
         s6uj98JF6xtiaAhNcI+dtmwgILW796E2WdudeeDA6vwdHHWzgRtNFmDZ1TAVi1YVOFTQ
         oyD8vvEORxe3ULK89Zc8w9pdTaaJoH2BRlRIby6tM2RY6Ra5z9tB6NrK6uX5rxfzT1Bj
         oCDSpRFkh4jeOw853peuNfNdSuHKhrarhaVhhChjFMj8EWCmcwIq8sipUXr3T9UI0g/Z
         kma446LY6V/NfSs42Xop+XEgqe937lQ61r8miLZ32bdHV/YOkI/1uXTIgQTWN6WavbwL
         eJTg==
X-Gm-Message-State: AOJu0YziwN/qSrJsJEdeMfUNdWfbg5jZedpF2zPdXak5wx6MF6P3jjzv
	Es5MFIOXBJcBLCskp0Pb7sWqfAL2MF5s1XIg3IKMcjXoTP2k6dZ67xBWX1pTGQ==
X-Gm-Gg: AfdE7clYttsT0hUwUeMdQNo8lQ5zPEiMJPA2A3WSWgSB5Lybzn/eqrXMgRkHDfik6m2
	+kjQAp7cIZjtNVJsxFpgY3eM2ucU9h4VqOZrVgNTkKZ8f11UA+4OXZm4Ns0a7wmMfwAMjmcqQX0
	gwO2YWwY152v5C/oLec8jy4ePucAmS51JXDAIvDhJ9l/n6jah5bZ2Qu6qpaSeyPHX1eh1jsn+pC
	VVE+D1Rkv3kPJoLPLJHFCiE9016ttsJrEnrMfpElFEs9MsXWq84ekioG5gvgTqq9XY3hw8ki5pF
	y1dLW3NvtuSUhv7kgOZIvApAP7geWBGicEanmNOUBcT8mu9u5JI0R2ELx9wgFzgrB4HAkpswTAE
	cn98l7gRPPxikxfdQoDTwQextQ/IIRgp5ffr/QVxtIGsuucUlHnOj9G52Rtu4gW7oWKckQooYyX
	L2qS57VsaRwojifSnT4Q==
X-Received: by 2002:ac8:590e:0:b0:51c:c6c:9d65 with SMTP id d75a77b69052e-51c4c1f6bb6mr100062761cf.1.1783239875558;
        Sun, 05 Jul 2026 01:24:35 -0700 (PDT)
Received: from [127.0.0.1] ([135.237.130.145])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46e371bdfsm102379716d6.1.2026.07.05.01.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:24:34 -0700 (PDT)
Message-Id: <546a7c5d9f76fc9cb71305bd0bcb4bc7693ecb39.1783239870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
	<pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 05 Jul 2026 08:24:19 +0000
Subject: [PATCH v2 02/12] loose: avoid closing invalid fd on error path
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

`write_one_object()` opens a file at line 186 and jumps to the errout
label on failure. The errout cleanup unconditionally calls `close(fd)`,
but when `open()` itself failed, fd is -1. Calling `close(-1)` is
harmless on most platforms (returns EBADF) but is undefined behavior per
POSIX and can confuse fd tracking in sanitizer builds.

Guard the close with fd >= 0.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 loose.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/loose.c b/loose.c
index 940a9e0dfe..bf01d3e42d 100644
--- a/loose.c
+++ b/loose.c
@@ -201,7 +201,8 @@ static int write_one_object(struct odb_source_loose *loose,
 	return 0;
 errout:
 	error_errno(_("failed to write loose object index %s"), path.buf);
-	close(fd);
+	if (fd >= 0)
+		close(fd);
 	rollback_lock_file(&lock);
 	strbuf_release(&buf);
 	strbuf_release(&path);
-- 
gitgitgadget

