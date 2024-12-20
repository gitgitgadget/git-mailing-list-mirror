Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCF9227B86
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734715209; cv=none; b=AadPW+4VyitsDR2xEb50niIeReF2lEm4ahJhodmNybBX3sc0RwD8iMyYzx+qIZ/KgzrIXe5eNkleiyGp+CwT78GpVq2FvH/3ovlDM8R9zHY5jku1Fk0L/CYMaP8wrsUV5LswuGgp/v4d8rkSQHDJr0GI3FP+JsvIkm+1DRxAKtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734715209; c=relaxed/simple;
	bh=7H+pjDdjW7OcRFwIEzIOPBAvtC+HQNEA7ytPoIQ8ADA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lllKk2mQk5bxR8pvpdsntHm6ueafE2uK7QHUE+kyJAW1ic9A3uGcL0pVZSll4ARV7JzT100tGxEycjsfXh3WfE4+vIJZnmACJJJDibb9SUP9lvG63L2gqyaE+WYj7T5rqKeM3yTFo4HSg4VQB+2EmVvlpVlTBshQHGTMNNeJaXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zy/CCJwA; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zy/CCJwA"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38637614567so1110785f8f.3
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 09:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734715206; x=1735320006; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whDBi9e8q90S9pAIhdJKTn+zXwAuFGtOvjxGmFMB1l4=;
        b=Zy/CCJwALNaao6IpW43d0gjqqYJSC9oa2BA6dQEqDoc9vRqCHm0x4aIVa3qoZIEQ4g
         ilfT8ptdxp/eG79hu6xYqjuLm5gl5wADFU5TfsS2381YMnArerJDKIr8zZQkB7HODV/A
         svV/ytZ0ymsO51nJN7m4m3+5G+5GpSuebEx/2zAboLpRWUME4vhIOQ1ek6vML98PgvN2
         TJWVHscFIcefktUCNs+th92aHytkfw1DBq4hQc1S60VYVjF1Dwh7GVAFTXeznbnOYzcE
         b0VN1j2F2hc4KwKRaiJMM6wtwmUZAHRxXm6uzid1PkS7YZpZosgf2RiCTqeTuAgxSKCd
         n2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734715206; x=1735320006;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whDBi9e8q90S9pAIhdJKTn+zXwAuFGtOvjxGmFMB1l4=;
        b=DmPUv0uODvYm+lorbQRihEUI7oAiCprdzYXQjzro35bHwI1TVDgWVOBVAReSY5yR+V
         UMfutoZb6Y9MgkhzT4cSoPsyHS1amB35zXyT+ZyhLUt3hEQsqhLYAGTCsCGEdf2PE4om
         qEC8q8pTt76TG7HAsV9rYvWvRGfKwSMOnJj8rZU0uF169t1Dy19N0TT80WCCgWh0J11h
         jb5+TagVyPn4gCGMpifCiWWp2cVFio7ugeKxClDgponXRdZ1sjiv/ztVGp2V0YYxPb8C
         b43TK5RLN6biLSEgVDinsJYGEBtGYVewB9frdMVQV58dppOjypMDrkj7/UOeqA+AT+Bb
         A4sw==
X-Gm-Message-State: AOJu0YytphmHccNMlSbGdI9iUoblmU1gdkYwOykOZAGqqff/eFdL8Tya
	ml/angrm87ExM39EmXpMClQGMssVaj4MgPhWtLZhjp8zPkwrtzst3+MYAQ==
X-Gm-Gg: ASbGnctduc4cZkf5aMzBeTaUDEv53QvOUJoKy5xMsgAbTt3cYEROjD25ZeKoZGhbHva
	t4aJU+KAar1EG7QfQHBwZ6OTX3WrGeakCrOuvsltNiLETTPaqrCZs3GHLW0X+I0zG+YkdyI/dv1
	nZEvkowRr3ryNhiG87oi/q3TteNpd4yqrlyW6KPTqmToG2WHcgTWMMNsGxfgf+Eane92ERFD09s
	92YKyMChOml1L/C2+ILDd74pWqGZuWdQy5/ipTgdYrZ0uYR+bdYd8Ifdg==
X-Google-Smtp-Source: AGHT+IG2Jwwb4JEFPsFvdps0VEcDmiYzMncVHr3Kne2k8qge2k/ApB0EcnJ7Cq/jHcDty0rNAlWGUw==
X-Received: by 2002:a5d:5f51:0:b0:385:fa2e:a33e with SMTP id ffacd0b85a97d-38a223fd369mr3690213f8f.43.1734715205726;
        Fri, 20 Dec 2024 09:20:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b441bbsm84161115e9.40.2024.12.20.09.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 09:20:04 -0800 (PST)
Message-Id: <18a41f2fe6f2219f16f998699394005bd57ac463.1734715194.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
References: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
	<pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Dec 2024 17:19:53 +0000
Subject: [PATCH v3 7/8] pack-objects: prevent name hash version change
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    jonathantanmy@google.com,
    karthik nayak <karthik.188@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When the --name-hash-version option is used in 'git pack-objects', it
can change from the initial assignment to when it is used based on
interactions with other arguments. Specifically, when writing or reading
bitmaps, we must force version 1 for now. This could change in the
future when the bitmap format can store a name hash version value,
indicating which was used during the writing of the packfile.

Protect the 'git pack-objects' process from getting confused by failing
with a BUG() statement if the value of the name hash version changes
between calls to pack_name_hash_fn().

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b19c3665003..4d10baf7ac9 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -276,6 +276,14 @@ static void validate_name_hash_version(void)
 
 static inline uint32_t pack_name_hash_fn(const char *name)
 {
+	static int seen_version = -1;
+
+	if (seen_version < 0)
+		seen_version = name_hash_version;
+	else if (seen_version != name_hash_version)
+		BUG("name hash version changed from %d to %d mid-process",
+		    seen_version, name_hash_version);
+
 	switch (name_hash_version)
 	{
 	case 1:
-- 
gitgitgadget

